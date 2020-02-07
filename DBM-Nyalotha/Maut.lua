local mod	= DBM:NewMod(2365, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(156523)
mod:SetEncounterID(2327)--Obsidian Destroyer ID, but only one left after eliminating all others, should be correct
mod:SetZone()
--mod:SetHotfixNoticeRev(20190716000000)--2019, 7, 16
--mod:SetMinSyncRevision(20190716000000)
mod.respawnTime = 20

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 308044 305663 308903 308872 314337 305722",
	"SPELL_CAST_SUCCESS 307805 308044 310129 306290 315025",
	"SPELL_SUMMON 305625",
	"SPELL_AURA_APPLIED 307806 307399 306005 306301 314993 315025",
	"SPELL_AURA_APPLIED_DOSE 307399",
	"SPELL_AURA_REMOVED 306005 314993 307806 315025",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, infoframe showing players missing Devoured Abyss during big aoe cast?
--TODO, auto icon marking of siphons?
--TODO, tank swap stacks 2 or 3?
--[[
(ability.id = 308044 or ability.id = 305663 or ability.id = 308903 or ability.id = 308872 or ability.id = 314337 or ability.id = 305722) and type = "begincast"
 or (ability.id = 307805 or ability.id = 310129 or ability.id = 306290) and type = "cast"
 or ability.id = 306005 and (type = "applybuff" or type = "removebuff")
--]]
--Stage One: Obsidian Destroyer
local warnDevourMagic						= mod:NewTargetAnnounce(307805, 3)
local warnShadowWounds						= mod:NewStackAnnounce(307399, 2, nil, "Tank")
local warnAncientCurse						= mod:NewSpellAnnounce(315025, 4)
----Add
local warnDarkOffering						= mod:NewCountAnnounce(308872, 2)
--Stage Two: Obsidian Statue
local warnForbiddenRitual					= mod:NewCountAnnounce(306290, 2, nil, "Healer")
local warnForbiddenMana						= mod:NewTargetNoFilterAnnounce(306301, 1, nil, false)
local warnDrainEssence						= mod:NewTargetNoFilterAnnounce(314993, 2, nil, "RemoveMagic")

--Stage One: Obsidian Destroyer
local specWarnShadowWounds					= mod:NewSpecialWarningStack(307399, nil, 2, nil, nil, 1, 6)
local specWarnShadowWoundsTaunt				= mod:NewSpecialWarningTaunt(307399, nil, nil, nil, 1, 2)
local specWarnDevourMagic					= mod:NewSpecialWarningMoveAway(307805, nil, nil, nil, 1, 2)
local yellDevourMagic						= mod:NewYell(307805)
local yellDevourMagicFades					= mod:NewShortFadesYell(307805)
local specWarnStygianAnnihilation			= mod:NewSpecialWarningMoveTo(308044, nil, 307421, nil, 3, 2)
local specWarnBlackWing						= mod:NewSpecialWarningDodge(305663, nil, nil, nil, 2, 2)
local specWarnDarkManifestation				= mod:NewSpecialWarningDodge(308903, nil, nil, nil, 2, 2)
local specWarnAncientCurse					= mod:NewSpecialWarningYou(315025, nil, nil, nil, 1, 2, 4)
local yellAncientCurse						= mod:NewYell(315025, nil, false, 2)
local yellAncientCurseFades					= mod:NewShortFadesYell(315025)
--Stage Two: Obsidian Statue
local specWarnDrainEssence					= mod:NewSpecialWarningMoveAway(314993, nil, nil, nil, 1, 2)
local yellDrainEssence						= mod:NewYell(314993, nil, false, 2)
local yellDrainEssenceFades					= mod:NewShortFadesYell(314993)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

--Stage One: Obsidian Destroyer
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20594))
local timerDevourMagicCD					= mod:NewCDTimer(22, 307805, nil, nil, nil, 3)
local timerStygianAnnihilationCD			= mod:NewCDTimer(55.3, 308044, 307421, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON, nil, 1, 4)
local timerBlackWingsCD						= mod:NewCDTimer(20.6, 305663, nil, nil, nil, 3)--20-30
local timerShadowClawsCD					= mod:NewCDTimer(12.3, 310129, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerDarkManifestationCD				= mod:NewCDCountTimer(35.2, 308903, nil, nil, nil, 1, nil, DBM_CORE_TANK_ICON)
local timerAncientCurseCD					= mod:NewNextTimer(50, 314337, nil, nil, nil, 3, nil, DBM_CORE_CURSE_ICON, nil, 3, 4)
----Add
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20655))
local timerDarkOfferingCD					= mod:NewNextCountTimer(12.1, 308872, nil, nil, nil, 5)
--Stage Two: Obsidian Statue
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20553))
local timerForbiddenRitualCD				= mod:NewCDCountTimer(7, 306290, nil, "Healer", nil, 5, nil, DBM_CORE_HEALER_ICON)--6.1-8.5 (7)
local timerDrainEssenceCD					= mod:NewCDTimer(13.8, 314993, nil, nil, nil, 5, nil, DBM_CORE_MAGIC_ICON)--13.8-15.8

local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(8, 314995)
mod:AddInfoFrameOption(306005, true)

mod.vb.bigAoeActive = false
mod.vb.darkManifestationCount = 0
mod.vb.ritualCount = 0
--mod.vb.ancientCurseIcon = 1
local DevouredAbyss = DBM:GetSpellInfo(307839)
local castsPerGUID = {}

function mod:OnCombatStart(delay)
	self.vb.bigAoeActive = false
	self.vb.darkManifestationCount = 0
	--self.vb.ancientCurseIcon = 1
	table.wipe(castsPerGUID)
	timerShadowClawsCD:Start(7.1-delay)--SUCCESS
	timerDevourMagicCD:Start(11.5-delay)--SUCCESS
	timerDarkManifestationCD:Start(12-delay)
	if self:IsHard() then
		timerBlackWingsCD:Start(18.1-delay)
		if self:IsMythic() then
			timerAncientCurseCD:Start(16.7-delay)
		end
	end
	timerStygianAnnihilationCD:Start(40.2-delay)--40-42
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
		DBM.InfoFrame:Show(3, "enemypower", 0, 0)
	end
	berserkTimer:Start(self:IsHard() and 600 or 660)--Heroic and Normal confirmed, LFR and mythic unknown
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

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
		timerDarkManifestationCD:Start(35.2, self.vb.darkManifestationCount+1)
	elseif spellId == 308872 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		warnDarkOffering:Show(count)
		timerDarkOfferingCD:Start(12.1, count+1, args.sourceGUID)
	elseif spellId == 314337 then
		warnAncientCurse:Show()
		--self.vb.ancientCurseIcon = 1
		timerAncientCurseCD:Start()
	elseif spellId == 305722 then--Obsidian Statue
		timerDevourMagicCD:Stop()
		timerStygianAnnihilationCD:Stop()
		timerBlackWingsCD:Stop()
		timerShadowClawsCD:Stop()
		timerDarkManifestationCD:Stop()
		timerAncientCurseCD:Stop()
		timerDrainEssenceCD:Start(9.7)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 307805 then
		timerDevourMagicCD:Start()
	elseif spellId == 308044 then
		self.vb.bigAoeActive = false
	elseif spellId == 310129 then
		timerShadowClawsCD:Start()
	elseif spellId == 306290 then
		self.vb.ritualCount = self.vb.ritualCount + 1
		warnForbiddenRitual:Show(self.vb.ritualCount)
		timerForbiddenRitualCD:Start(6.1, self.vb.ritualCount+1)
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 305625 then
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
		end
		timerDarkOfferingCD:Start(10, 1, args.destGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 307806 then
		warnDevourMagic:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDevourMagic:Show()
			specWarnDevourMagic:Play("runout")
			yellDevourMagic:Yell()
			yellDevourMagicFades:Countdown(spellId)
		end
	elseif spellId == 307399 then
		local amount = args.amount or 1
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnShadowWounds:Show(amount)
				specWarnShadowWounds:Play("stackhigh")
			else
				--Don't show taunt warning if you're 3 tanking and aren't near the boss (this means you are the add tank)
				--Show taunt warning if you ARE near boss, or if number of alive tanks is less than 3
				if (self:CheckNearby(8, args.destName) or self:GetNumAliveTanks() < 3) and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then--Can't taunt less you've dropped yours off, period.
					specWarnShadowWoundsTaunt:Show(args.destName)
					specWarnShadowWoundsTaunt:Play("tauntboss")
				else
					warnShadowWounds:Show(args.destName, amount)
				end
			end
		else
			warnShadowWounds:Show(args.destName, amount)
		end
	elseif spellId == 306005 then--Obsidian Skin
		self.vb.ritualCount = 0
		timerForbiddenRitualCD:Start(4.1, 1)
		timerDrainEssenceCD:Start(7.8)
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
	elseif spellId == 315025 then
		if args:IsPlayer() then
			specWarnAncientCurse:Show()
			specWarnAncientCurse:Play("targetyou")
			yellAncientCurse:Yell()
			yellAncientCurseFades:Countdown(spellId)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 306005 then--Obsidian Skin
		self.vb.darkManifestationCount = 0
		timerForbiddenRitualCD:Stop()
		timerDrainEssenceCD:Stop()
		timerShadowClawsCD:Start(7.6)--SUCCESS (7.6-10)
		timerDevourMagicCD:Start(12.1)--SUCCESS
		timerDarkManifestationCD:Start(12.6, 1)
		if self:IsHard() then
			timerBlackWingsCD:Start(19.9)
			if self:IsMythic() then
				timerAncientCurseCD:Start(16.9)
			end
		end
		timerStygianAnnihilationCD:Start(40.6)
	elseif spellId == 314993 then
		if args:IsPlayer() then
			yellDrainEssenceFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 307806 then
		if args:IsPlayer() then
			yellDevourMagicFades:Cancel()
		end
	elseif spellId == 315025 then
		if args:IsPlayer() then
			yellAncientCurseFades:Cancel()
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
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 156650 then--dark-manifestation
		timerDarkOfferingCD:Stop(castsPerGUID[args.destGUID]+1, args.destGUID)
		castsPerGUID[args.destGUID] = nil
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 314992 then--Drain Essence cast not in combat log, only debuffs
		timerDrainEssenceCD:Start()
	end
end
