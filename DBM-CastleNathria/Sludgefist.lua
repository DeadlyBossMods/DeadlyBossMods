local mod	= DBM:NewMod(2394, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164407)
mod:SetEncounterID(2399)
mod:SetZone()
mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(20200112000000)--2020, 1, 12
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 332318 332687",
	"SPELL_CAST_SUCCESS 332362 335354 335293",
	"SPELL_AURA_APPLIED 331209 331314 335293",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 331209 331314"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, maybe warn for headless charge too
--TODO, Falling Debris warning, get target? spammy? event?
--TODO, chain slam target?
--TODO, tank debuff swapping seems removed, remove it from code if it doesn't return by testing
--TODO, correct Ids for Chain link, maybe raid icons and such
--TODO, do timers pause during stun? or just queue up?
local warnHatefulGaze							= mod:NewTargetNoFilterAnnounce(331209, 4)
local warnStunnedImpact							= mod:NewTargetNoFilterAnnounce(331314, 1)
local warnChainLink								= mod:NewTargetAnnounce(335293, 3)
local warnFallingDebris							= mod:NewSpellAnnounce(332362, 3)
--local warnCrushedArmor							= mod:NewStackAnnounce(332991, 2, nil, "Tank|Healer")

local specWarnHatefulGaze						= mod:NewSpecialWarningMoveTo(331209, nil, nil, nil, 3, 2)
local specWarnHeedlessCharge					= mod:NewSpecialWarningSoon(331211, nil, nil, nil, 2, 2)
local yellHatefulGaze							= mod:NewYell(331209)
local yellHatefulGazeFades						= mod:NewFadesYell(331209)
local specWarnChainLink							= mod:NewSpecialWarningYou(335293, nil, nil, nil, 1, 2)
local yellChainLink								= mod:NewYell(335293)
local specWarnDestructiveStomp					= mod:NewSpecialWarningRun(332318, "Melee", nil, nil, 4, 2)
local specWarnColossalRoar						= mod:NewSpecialWarningSpell(332687, nil, nil, nil, 2, 2)
--local specWarnCrushedArmor						= mod:NewSpecialWarningStack(332991, nil, 12, nil, nil, 1, 6)
--local specWarnCrushedArmorTaunt					= mod:NewSpecialWarningTaunt(332991, nil, nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

local timerHatefulGazeCD						= mod:NewAITimer(44.3, 331209, nil, nil, nil, 3, nil, DBM_CORE_L.IMPORTANT_ICON, nil, 1, 4)
local timerStunnedImpact						= mod:NewTargetTimer(8, 331314, nil, nil, nil, 5, nil, DBM_CORE_L.DAMAGE_ICON)
local timerChainLinkCD							= mod:NewAITimer(44.3, 335293, nil, nil, nil, 3)
local timerDestructiveStompCD					= mod:NewAITimer(44.3, 332318, nil, nil, nil, 3)
local timerFallingDebrisCD						= mod:NewAITimer(44.3, 332362, nil, nil, nil, 3)
local timerColossalRoarCD						= mod:NewAITimer(44.3, 332687, nil, nil, nil, 2)
local timerChainSlamCD							= mod:NewAITimer(44.3, 335354, nil, nil, nil, 3)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
--mod:AddInfoFrameOption(308377, true)
mod:AddSetIconOption("SetIconGaze", 331209, true, false, {1})
--mod:AddNamePlateOption("NPAuraOnVolatileCorruption", 312595)

function mod:OnCombatStart(delay)
	timerHatefulGazeCD:Start(1-delay)
	timerChainLinkCD:Start(1-delay)
	timerDestructiveStompCD:Start(1-delay)
	timerFallingDebrisCD:Start(1-delay)
	timerColossalRoarCD:Start(1-delay)
	timerChainSlamCD:Start(1-delay)
--	if self.Options.NPAuraOnVolatileCorruption then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Show(4)
--	end
--	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.NPAuraOnVolatileCorruption then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 332318 then
		specWarnDestructiveStomp:Show()
		specWarnDestructiveStomp:Play("justrun")
		timerDestructiveStompCD:Start()
	elseif spellId == 332687 then
		specWarnColossalRoar:Show()
		specWarnColossalRoar:Play("aesoon")
		timerColossalRoarCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 332362 then
		warnFallingDebris:Show()
		timerFallingDebrisCD:Start()
	elseif spellId == 335354 then
		timerChainSlamCD:Start()
	elseif spellId == 335293 then
		timerChainLinkCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 331209 then
		timerHatefulGazeCD:Start()
		if args:IsPlayer() then
			specWarnHatefulGaze:Show(DBM_CORE_L.PILLAR)
			specWarnHatefulGaze:Play("targetyou")
			yellHatefulGaze:Yell()
			yellHatefulGazeFades:Countdown(spellId)
		else
			specWarnHeedlessCharge:Show()
			specWarnHeedlessCharge:Play("farfromline")
			warnHatefulGaze:Show(args.destName)
		end
		if self.Options.SetIconGaze then
			self:SetIcon(args.destName, 1)
		end
	elseif spellId == 331314 then
		warnStunnedImpact:Show(args.destName)
		timerStunnedImpact:Start(args.destName)
	elseif spellId == 335293 then
		warnChainLink:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnChainLink:Show()
			specWarnChainLink:Play("targetyou")
			yellChainLink:Yell()
		end
	--[[elseif spellId == 332991 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			if amount >= 12 then
				if args:IsPlayer() then
					specWarnCrushedArmor:Show(amount)
					specWarnCrushedArmor:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
						specWarnCrushedArmorTaunt:Show(args.destName)
						specWarnCrushedArmorTaunt:Play("tauntboss")
					else
						warnCrushedArmor:Show(args.destName, amount)
					end
				end
			else
				warnCrushedArmor:Show(args.destName, amount)
			end
		end--]]
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 331209 then
		if args:IsPlayer() then
			yellHatefulGazeFades:Cancel()
		end
		if self.Options.SetIconGaze then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 331314 then
		timerStunnedImpact:Stop(args.destName)
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 157612 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 310351 then

	end
end
--]]
