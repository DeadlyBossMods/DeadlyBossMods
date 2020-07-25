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
	"SPELL_CAST_START 332318",
	"SPELL_CAST_SUCCESS 332362 332687",
	"SPELL_AURA_APPLIED 331209 331314 335270 335293 335491",
	"SPELL_AURA_REMOVED 331209 331314 335270",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, do timers pause during stun? or just queue up? Does failing to stun boss vs stunning affect the alternating timers?
--TODO, one chain link pair is established, maybe add a spam repeat icon yell to the afflicted pair
local warnHatefulGaze							= mod:NewTargetNoFilterAnnounce(331209, 4)
local warnStunnedImpact							= mod:NewTargetNoFilterAnnounce(331314, 1)
local warnChainThisOne							= mod:NewTargetAnnounce(335270, 3)--Targetting debuff
local warnChainLink								= mod:NewTargetAnnounce(335293, 3)--Affected players when targetting ends
local warnChainSlam								= mod:NewTargetNoFilterAnnounce(164407, 3)
local warnFallingDebris							= mod:NewSpellAnnounce(332362, 3)

local specWarnHatefulGaze						= mod:NewSpecialWarningMoveTo(331209, nil, nil, nil, 3, 2)
local specWarnHeedlessCharge					= mod:NewSpecialWarningSoon(331212, nil, nil, nil, 2, 2)
local yellHatefulGaze							= mod:NewYell(331209)
local yellHatefulGazeFades						= mod:NewFadesYell(331209)
local specWarnChainLink							= mod:NewSpecialWarningYou(335491, nil, nil, nil, 1, 2)
local yellChainLink								= mod:NewYell(335491)
local yellChainLinkFades						= mod:NewFadesYell(335491)
local specWarnChainSlam							= mod:NewSpecialWarningYou(335470, nil, nil, nil, 1, 2)
local yellChainSlam								= mod:NewYell(335470, nil, nil, nil, "YELL")
local yellChainSlamFades						= mod:NewFadesYell(335470, nil, nil, nil, "YELL")
local specWarnDestructiveStomp					= mod:NewSpecialWarningRun(332318, "Melee", nil, nil, 4, 2)
local specWarnColossalRoar						= mod:NewSpecialWarningSpell(332687, nil, nil, nil, 2, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

local timerHatefulGazeCD						= mod:NewNextTimer(67.3, 331209, nil, nil, nil, 3, nil, DBM_CORE_L.IMPORTANT_ICON, nil, 1, 4)
local timerStunnedImpact						= mod:NewTargetTimer(8, 331314, nil, nil, nil, 5, nil, DBM_CORE_L.DAMAGE_ICON)
local timerChainLinkCD							= mod:NewCDTimer(20.8, 335491, nil, nil, nil, 3)
local timerChainSlamCD							= mod:NewCDTimer(34, 335354, nil, nil, nil, 3)
local timerDestructiveStompCD					= mod:NewNextCountTimer(44.3, 332318, nil, nil, nil, 3)
local timerFallingDebrisCD						= mod:NewCDTimer(11, 332362, nil, nil, nil, 3)
local timerColossalRoarCD						= mod:NewNextCountTimer(44.3, 332687, nil, nil, nil, 2)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
--mod:AddInfoFrameOption(308377, true)
mod:AddSetIconOption("SetIconGaze", 331209, true, false, {1})

mod.vb.stompCount = 0
mod.vb.roarCount = 0

function mod:OnCombatStart(delay)
	self.vb.stompCount = 0
	self.vb.roarCount = 0
	timerHatefulGazeCD:Start(53-delay)
	timerChainLinkCD:Start(6.4-delay)
	timerDestructiveStompCD:Start(22.4-delay, 1)
	timerFallingDebrisCD:Start(10.1-delay)
--	timerColossalRoarCD:Start(1-delay)--Cast instantly on pull
	timerChainSlamCD:Start(34-delay)
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
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 332318 then
		self.vb.stompCount = self.vb.stompCount + 1
		specWarnDestructiveStomp:Show()
		specWarnDestructiveStomp:Play("justrun")
		--pull:22.4, 23.3, 44.2, 23.1, 45.5, 22.0, 45.3, 22.1"
		if self.vb.stompCount == 1 or (self.vb.stompCount % 2 == 0) then
			timerDestructiveStompCD:Start(44, self.vb.stompCount+1)
		else
			timerDestructiveStompCD:Start(22, self.vb.stompCount+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 332362 then
		warnFallingDebris:Show()
		timerFallingDebrisCD:Start()
	elseif spellId == 332687 then
		self.vb.roarCount = self.vb.roarCount + 1
		specWarnColossalRoar:Show()
		specWarnColossalRoar:Play("aesoon")
		if self.vb.roarCount % 2 == 0 then
			timerColossalRoarCD:Start(36.5, self.vb.roarCount+1)
		else
			timerColossalRoarCD:Start(30.8, self.vb.roarCount+1)
		end
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
	elseif spellId == 335270 then
		if args:IsPlayer() then
			specWarnChainLink:Show()
			specWarnChainLink:Play("targetyou")
			yellChainLink:Yell()
			yellChainLinkFades:Countdown(spellId)
		else
			warnChainThisOne:Show(args.destName)
		end
	elseif spellId == 335293 then
		warnChainLink:CombinedShow(0.5, args.destName)
	elseif spellId == 335470 then
		--timerChainSlamCD:Start()
		if args:IsPlayer() then
			specWarnChainSlam:Show()
			specWarnChainSlam:Play("targetyou")
			yellChainSlam:Yell()
			yellChainSlamFades:Countdown(4)--Can't auto pull from spellId
		else
			warnChainSlam:Show(args.destName)
		end
	end
end

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
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 335491 then--Chain link
		timerChainLinkCD:Start()
	elseif spellId == 332362 then
		warnFallingDebris:Show()
		timerFallingDebrisCD:Start()
	end
end
