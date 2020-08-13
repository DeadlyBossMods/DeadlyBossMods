local mod	= DBM:NewMod(2394, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164407)
mod:SetEncounterID(2399)
mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(20200112000000)--2020, 1, 12
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 332318",
	"SPELL_CAST_SUCCESS 332687 340803",
	"SPELL_AURA_APPLIED 331209 331314 342419 342420 335470 341294",
	"SPELL_AURA_REMOVED 331209 331314 342419 342420",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, this straght up needs an updateAllTimers function like archimonde to be perfect.
--TODO, add warning for Seismic shift if it's not spammy
--Timers delaying other timers, some abilities being skipped entirely if coming off cd during stun or another ability cast
--The timers COULD be perfected, I'm just not sure it's worth the effort to. Not an end boss, or even a hard one.
--I'll return to perfecting timers if things don't change on live and can analylize dozens more logs to verify patterns
local warnHatefulGaze							= mod:NewTargetNoFilterAnnounce(331209, 4)
local warnStunnedImpact							= mod:NewTargetNoFilterAnnounce(331314, 1)
local warnChainThisOne							= mod:NewTargetAnnounce(342419, 3)--Targetting debuff
--local warnChainLink							= mod:NewTargetAnnounce(335293, 3)--Affected players when targetting ends
local warnChainSlam								= mod:NewTargetNoFilterAnnounce(164407, 3)
local warnFallingRubble							= mod:NewSpellAnnounce(332572, 3)
local warnVengefulRage							= mod:NewTargetNoFilterAnnounce(341294, 4)

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
local specWarnStonequake						= mod:NewSpecialWarningDodge(335433, nil, nil, nil, 2, 2)
--local specWarnSiesmicShift						= mod:NewSpecialWarningDodge(340803, nil, nil, nil, 2, 2, 4)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

local timerHatefulGazeCD						= mod:NewNextTimer(67.3, 331209, nil, nil, nil, 3, nil, DBM_CORE_L.IMPORTANT_ICON, nil, 1, 4)
local timerStunnedImpact						= mod:NewTargetTimer(8, 331314, nil, nil, nil, 5, nil, DBM_CORE_L.DAMAGE_ICON)
local timerChainLinkCD							= mod:NewCDCountTimer(20.8, 335491, nil, nil, nil, 3)
local timerChainSlamCD							= mod:NewCDCountTimer(34, 335354, nil, nil, nil, 3)
local timerDestructiveStompCD					= mod:NewNextCountTimer(44.3, 332318, nil, nil, nil, 3)
local timerFallingRubbleCD						= mod:NewAITimer(11, 332572, nil, nil, nil, 3)
local timerColossalRoarCD						= mod:NewCDCountTimer(44.3, 332687, nil, nil, nil, 2)
local timerStoneQuakeCD							= mod:NewCDCountTimer(34, 335433, nil, nil, nil, 3)
local timerSiesmicShiftCD						= mod:NewAITimer(34, 340803, nil, nil, nil, 3, nil, DBM_CORE_L.MYTHIC_ICON)--Mythic

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
mod:AddInfoFrameOption(342410, true)
mod:AddSetIconOption("SetIconGaze", 331209, true, false, {1})

mod.vb.gazeCount = 0
mod.vb.stompCount = 0
mod.vb.roarCount = 0
mod.vb.linkCount = 0
mod.vb.chainSlaimCount = 0
mod.vb.quakeCount = 0

function mod:OnCombatStart(delay)
	self.vb.gazeCount = 0
	self.vb.stompCount = 0
	self.vb.roarCount = 0
	self.vb.linkCount = 0
	self.vb.chainSlaimCount = 0
	self.vb.quakeCount = 0
	timerChainLinkCD:Start(6.4-delay, 1)
	timerFallingRubbleCD:Start(10.1-delay)
	timerStoneQuakeCD:Start(14.8)
	timerDestructiveStompCD:Start(22.4-delay, 1)
--	timerColossalRoarCD:Start(1-delay)--Cast instantly on pull
	timerChainSlamCD:Start(34-delay, 1)
	timerHatefulGazeCD:Start(53-delay, 1)
	if self:IsMythic() then
		timerSiesmicShiftCD:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM_CORE_L.NO_DEBUFF:format(DBM:GetSpellInfo(342410)))
			DBM.InfoFrame:Show(5, "playergooddebuff", 342410)--TODO, change number when columns work again
		end
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Show(4)
--	end
--	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
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
		--pull:27.0, 22.1, 44.6, 22.1, 44.2, 22.1, 47.1, 22.6, 45.2, 23.1"
		if self.vb.stompCount == 1 or (self.vb.stompCount % 2 == 0) then
			timerDestructiveStompCD:Start(44, self.vb.stompCount+1)
		else
			timerDestructiveStompCD:Start(22, self.vb.stompCount+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 332572 then
--		warnFallingRubble:Show()
--		timerFallingRubbleCD:Start()
	elseif spellId == 332687 then
		self.vb.roarCount = self.vb.roarCount + 1
		specWarnColossalRoar:Show()
		specWarnColossalRoar:Play("aesoon")
		--"Colossal Roar-332687-npc:164407 = pull:0.0, 30.3, 37.0, 30.8, 36.1, 30.2, 36.8, 30.4, 38.9, 30.6, 30.9", -- [2]
		if self.vb.roarCount < 10 and (self.vb.roarCount % 2 == 0) then
			--Logic almost works, except when it doesn't
			timerColossalRoarCD:Start(36.1, self.vb.roarCount+1)
		else
			timerColossalRoarCD:Start(30.2, self.vb.roarCount+1)
		end
	elseif spellId == 340803 then
--		specWarnSiesmicShift:Show()
--		specWarnSiesmicShift:Play("watchstep")
		timerSiesmicShiftCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 331209 then
		self.vb.gazeCount = self.vb.gazeCount + 1
		timerHatefulGazeCD:Start(67.3, self.vb.gazeCount+1)
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
	elseif spellId == 342419 or spellId == 342420 then
		if args:IsPlayer() then
			specWarnChainLink:Show()
			specWarnChainLink:Play("targetyou")
			yellChainLink:Yell()
			yellChainLinkFades:Countdown(spellId)
		else
			warnChainThisOne:Show(args.destName)
		end
--	elseif spellId == 335293 then
--		warnChainLink:CombinedShow(0.5, args.destName)
--		if args:IsPlayer() and self:AntiSpam(6, 1) then
--			specWarnChainLink:Show()
--			specWarnChainLink:Play("targetyou")
--		end
	elseif spellId == 335470 then
		self.vb.chainSlaimCount = self.vb.chainSlaimCount + 1
		--timerChainSlamCD:Start(nil, self.vb.chainSlaimCount+1)
		if args:IsPlayer() then
			specWarnChainSlam:Show()
			specWarnChainSlam:Play("targetyou")
			yellChainSlam:Yell()
			yellChainSlamFades:Countdown(4)--Can't auto pull from spellId
		else
			warnChainSlam:Show(args.destName)
		end
	elseif spellId == 341294 then
		warnVengefulRage:Show(args.destName)
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
	elseif spellId == 342419 or spellId == 342420 then
		if args:IsPlayer() then
			yellChainLinkFades:Cancel()
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

local function skippedQuake(self)
	self.vb.quakeCount = self.vb.quakeCount + 1
	--Lowest time addition for sipped quake is 29.4, plus minus the extra 5.8 over scheduling
	timerStoneQuakeCD:Start(23.6, self.vb.quakeCount+1)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 335491 then--Chain link
		self.vb.linkCount = self.vb.linkCount + 1
		timerChainLinkCD:Start(nil, self.vb.linkCount+1)
	elseif spellId == 332552 then
		warnFallingRubble:Show()
		timerFallingRubbleCD:Start()
	elseif spellId == 335433 then--Stonequake
		self:Unschedule(skippedQuake)
		self.vb.quakeCount = self.vb.quakeCount + 1
		specWarnStonequake:Show()
		specWarnStonequake:Play("watchstep")
		--"Stonequake-335433-npc:164407 = pull:14.8, 35.5, 34.4, 63.8, 67.4, 37.8, 34.2, 34.2", -- [7]
		--"Stonequake-335433-npc:164407 = pull:14.6, 36.7, 34.7, 65.2, 35.6, 34.2, 65.0", -- [7]
		timerStoneQuakeCD:Start(34.2, self.vb.quakeCount+1)
		self:Schedule(40, skippedQuake, self)
	end
end
