local mod	= DBM:NewMod(2365, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(156523)
mod:SetEncounterID(2327)--Obsidian Destroyer ID, but only one left after eliminating all others, should be correct
mod:SetZone()
--mod:SetHotfixNoticeRev(20190716000000)--2019, 7, 16
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 308044 305663 308903 308872 314337 305722",
	"SPELL_CAST_SUCCESS 307805 308044 310129 314995",
	"SPELL_AURA_APPLIED 307399 305675 310235 306005 306301 314993",
	"SPELL_AURA_APPLIED_DOSE 307399",
	"SPELL_AURA_REMOVED 305675 310235 306005 314993",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"SPELL_INTERRUPT",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, infoframe and auto marking on current 3 arcane feast targets at all times on mythic
--TODO, infoframe showing players missing Devoured Abyss during big aoe cast?
--TODO, auto icon marking of siphons if it's managable target count
--Stage One: Obsidian Destroyer
local warnDevourMagic						= mod:NewTargetAnnounce(307805, 3)
local warnManaRotWounds						= mod:NewStackAnnounce(307399, 2, nil, "Tank")
local warnDarkOffering						= mod:NewCastAnnounce(308872, 2)
local warnAncientCurse						= mod:NewSpellAnnounce(314337, 3)
--Stage Two: Obsidian Statue
local warnForbiddenMana						= mod:NewTargetNoFilterAnnounce(306301, 1, nil, false)
local warnDrainEssence						= mod:NewTargetAnnounce(314993, 3)

--Stage One: Obsidian Destroyer
local specWarnManaRotWounds					= mod:NewSpecialWarningStack(307399, nil, 9, nil, nil, 1, 6)
local specWarnManaRotWoundsTaunt			= mod:NewSpecialWarningTaunt(307399, nil, nil, nil, 1, 2)
local specWarnDevourMagic					= mod:NewSpecialWarningMoveAway(307805, nil, nil, nil, 1, 2)
local yellDevourMagic						= mod:NewYell(307805)
local specWarnStygianAnnihilation			= mod:NewSpecialWarningMoveTo(307805, nil, nil, nil, 3, 2)
local specWarnBlackWing						= mod:NewSpecialWarningDodge(305663, "Tank", nil, nil, 1, 2)
local specWarnDarkManifestation				= mod:NewSpecialWarningRun(308903, nil, nil, nil, 4, 2)
--Stage Two: Obsidian Statue
local specWarnDrainEssence					= mod:NewSpecialWarningMoveAway(314993, nil, nil, nil, 1, 2)
local yellDrainEssence						= mod:NewYell(314993)
local yellDrainEssenceFades					= mod:NewShortFadesYell(314993)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)
--local specWarnConductivePulse				= mod:NewSpecialWarningInterrupt(295822, "HasInterrupt", nil, nil, 3, 2)

--mod:AddTimerLine(BOSS)
--Stage One: Obsidian Destroyer
local timerDevourMagicCD					= mod:NewAITimer(30.1, 307805, nil, nil, nil, 3)
local timerStygianAnnihilationCD			= mod:NewAITimer(84, 308044, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON, nil, 1, 4)
local timerBlackWingsCD						= mod:NewAITimer(30.1, 305663, nil, nil, nil, 3)
local timerManaRotClawsCD					= mod:NewAITimer(5.3, 310129, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerDarkManifestationCD				= mod:NewAITimer(30.1, 308903, nil, nil, nil, 1, nil, DBM_CORE_TANK_ICON)
local timerAncientCurseCD					= mod:NewAITimer(30.1, 314337, nil, nil, nil, 3, nil, DBM_CORE_CURSE_ICON)
--Stage Two: Obsidian Statue
local timerDrainEssenceCD					= mod:NewAITimer(30.1, 314993, nil, nil, nil, 5, nil, DBM_CORE_MAGIC_ICON)

--local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(8, 314995)
mod:AddInfoFrameOption(306005, true)
--mod:AddSetIconOption("SetIconOnEyeBeam", 264382, true, false, {1, 2})
mod:AddNamePlateOption("NPAuraOnDarkAegis", 305675)
mod:AddNamePlateOption("NPAuraOnDevouredAegis", 310235)

mod.vb.bigAoeActive = false
mod.vb.darkManifestationCount = 0
local DevouredAbyss = DBM:GetSpellInfo(307839)

function mod:OnCombatStart(delay)
	self.vb.bigAoeActive = false
	self.vb.darkManifestationCount = 0
	timerDevourMagicCD:Start(1-delay)
	timerStygianAnnihilationCD:Start(1-delay)
	timerBlackWingsCD:Start(1-delay)
	timerManaRotClawsCD:Start(1-delay)
	timerDarkManifestationCD:Start(1-delay)
	timerAncientCurseCD:Start(1-delay)
	if self.Options.NPAuraOnDarkAegis or self.Options.NPAuraOnDevouredAegis then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.NPAuraOnDarkAegis or self.Options.NPAuraOnDevouredAegis then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

--function mod:OnTimerRecovery()

--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 308044 then
		self.vb.bigAoeActive = true
		specWarnStygianAnnihilation:Show(DevouredAbyss)
		specWarnStygianAnnihilation:Play("findshelter")
		timerStygianAnnihilationCD:Start()
	elseif spellId == 305663 then
		specWarnBlackWing:Show()
		specWarnBlackWing:Play("shockwave")
		timerBlackWingsCD:Start()
	elseif spellId == 308903 then
		self.vb.darkManifestationCount = self.vb.darkManifestationCount + 1
		specWarnDarkManifestation:Show()
		specWarnDarkManifestation:Play("justrun")
		timerDarkManifestationCD:Start()
	elseif spellId == 308872 then
		warnDarkOffering:Show()
	elseif spellId == 314337 then
		warnAncientCurse:Show()
		timerAncientCurseCD:Start()
	elseif spellId == 305722 then--Obsidian Statue
		timerDevourMagicCD:Stop()
		timerStygianAnnihilationCD:Stop()
		timerBlackWingsCD:Stop()
		timerManaRotClawsCD:Stop()
		timerDarkManifestationCD:Stop()
		timerAncientCurseCD:Stop()
		timerDrainEssenceCD:Start(1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 307805 then
		timerDevourMagicCD:Start()
	elseif spellId == 308044 then
		self.vb.bigAoeActive = false
	elseif spellId == 310129 then
		timerManaRotClawsCD:Start()
	elseif spellId == 314995 then
		timerDrainEssenceCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 307805 then
		warnDevourMagic:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDevourMagic:Show()
			specWarnDevourMagic:Play("runout")
			yellDevourMagic:Yell()
		end
	elseif spellId == 307399 then
		local amount = args.amount or 1
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnManaRotWounds:Show(amount)
				specWarnManaRotWounds:Play("stackhigh")
			else
				--Don't show taunt warning if you're 3 tanking and aren't near the boss (this means you are the add tank)
				--Show taunt warning if you ARE near boss, or if number of alive tanks is less than 3
				if (self:CheckNearby(8, args.destName) or self:GetNumAliveTanks() < 3) and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then--Can't taunt less you've dropped yours off, period.
					specWarnManaRotWoundsTaunt:Show(args.destName)
					specWarnManaRotWoundsTaunt:Play("tauntboss")
				else
					warnManaRotWounds:Show(args.destName, amount)
				end
			end
		else
			warnManaRotWounds:Show(args.destName, amount)
		end
	elseif spellId == 305675 then
		if self.Options.NPAuraOnDarkAegis then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 310235 then
		if self.Options.NPAuraOnDevouredAegis then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 306005 then
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, "boss1")
		end
	elseif spellId == 306301 then
		warnForbiddenMana:Show(args.destName)
	elseif spellId == 314993 then
		warnDrainEssence:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDrainEssence:Show()
			specWarnDrainEssence:Play("runout")
			yellDrainEssence:Yell()
			yellDrainEssenceFades:Countdown(spellId)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 305675 then
		if self.Options.NPAuraOnDarkAegis then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 310235 then
		if self.Options.NPAuraOnDevouredAegis then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 306005 then--Obsidian Skin
		timerDevourMagicCD:Start(2)
		timerStygianAnnihilationCD:Start(2)
		timerBlackWingsCD:Start(2)
		timerManaRotClawsCD:Start(2)
		timerDarkManifestationCD:Start(2)
		timerAncientCurseCD:Start(2)
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 314993 then
		if args:IsPlayer() then
			yellDrainEssenceFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 298548 then

	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 156650 then--dark-manifestation

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 306290 then--Forbidden Mana
		DBM:Debug("Forbidden of Mana cast")
	end
end
