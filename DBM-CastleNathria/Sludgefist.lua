local mod	= DBM:NewMod(2394, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164407)
mod:SetEncounterID(2399)
mod:SetUsedIcons(1)
mod:SetHotfixNoticeRev(20210119000000)--2021, 01, 19
mod:SetMinSyncRevision(20201228000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 332318",
	"SPELL_CAST_SUCCESS 332687",
	"SPELL_AURA_APPLIED 331209 331314 342420 335470 340817 341250",
	"SPELL_AURA_REMOVED 331209 331314 342419 342420 340817",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"SPELL_ENERGIZE 346269",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, this straght up needs an updateAllTimers function like archimonde to be perfect, especially around hateful gaze/impact stun
--The timers COULD be perfected, I'm just not sure it's worth the effort to since the variations are all predictable (based around spell queuing or delayed by impact stun)
--I'll return to perfecting timers if things don't change on live and can analylize dozens more logs to verify patterns
--[[
(ability.id = 332318) and type = "begincast"
 or ability.id = 332687 and type = "cast"
 or (ability.id = 335470 or ability.id = 335470 or ability.id = 331209) and type = "applydebuff"
 or ability.id = 346269 or ability.id = 331314
 or (ability.id = 342420 or ability.id = 340817) and type = "applydebuff"
--]]
local warnHatefulGaze							= mod:NewTargetCountAnnounce(331209, 4, nil, nil, nil, nil, nil, nil, true)
local warnStunnedImpact							= mod:NewTargetNoFilterAnnounce(331314, 1)
--local warnChainLink								= mod:NewTargetAnnounce(342419, 3)--Targetting debuff
local warnChainSlam								= mod:NewTargetCountAnnounce(335470, 3, nil, nil, nil, nil, nil, nil, true)
local warnGruesomeRage							= mod:NewTargetNoFilterAnnounce(341250, 4)

local specWarnHatefulGaze						= mod:NewSpecialWarningMoveTo(331209, nil, nil, nil, 3, 2)
local specWarnHeedlessCharge					= mod:NewSpecialWarningSoon(331212, nil, nil, nil, 2, 2)
local yellHatefulGaze							= mod:NewShortYell(331209)
local yellHatefulGazeFades						= mod:NewShortFadesYell(331209)
local specWarnChainLink							= mod:NewSpecialWarningMoveTo(335300, nil, nil, nil, 1, 2)
local yellChainLink								= mod:NewIconRepeatYell(335300, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.shortyell, false, 2)
local specWarnChainSlam							= mod:NewSpecialWarningYou(335470, nil, nil, nil, 1, 2)
local specWarnChainSlamPartner					= mod:NewSpecialWarningTarget(335470, nil, nil, nil, 1, 2)
local yellChainSlam								= mod:NewShortYell(335470, nil, nil, nil, "YELL")
local yellChainSlamFades						= mod:NewShortFadesYell(335470, nil, nil, nil, "YELL")
local specWarnDestructiveStomp					= mod:NewSpecialWarningRun(332318, "Melee", 247733, nil, 4, 2)
local specWarnColossalRoar						= mod:NewSpecialWarningSpell(332687, nil, 226056, nil, 2, 2)
local specWarnFallingRubble						= mod:NewSpecialWarningDodge(332572, nil, nil, nil, 2, 2)
local specWarnSiesmicShift						= mod:NewSpecialWarningMoveAway(340817, nil, nil, nil, 2, 2, 4)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

--All timers outside of stun and gaze will use keep arg so timers remain visible if they come off CD during gaze stun
local timerHatefulGazeCD						= mod:NewCDCountTimer(68.9, 331209, nil, nil, nil, 3, nil, DBM_COMMON_L.IMPORTANT_ICON, nil, 1, 4)
local timerStunnedImpact						= mod:NewBuffActiveTimer(12, 331314, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerChainLinkCD							= mod:NewCDCountTimer(68.9, 335300, nil, nil, nil, 3, nil, nil, true)
local timerChainSlamCD							= mod:NewCDCountTimer(68.9, 335470, nil, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON, true)
local timerDestructiveStompCD					= mod:NewCDCountTimer(44.3, 332318, 247733, nil, nil, 3, nil, nil, true)
local timerFallingRubbleCD						= mod:NewCDCountTimer(68.9, 332572, nil, nil, nil, 3, nil, nil, true)
local timerColossalRoarCD						= mod:NewCDCountTimer(27.9, 332687, 226056, nil, nil, 2, nil, nil, true)
local timerSiesmicShiftCD						= mod:NewCDCountTimer(34, 340817, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON, true)--Mythic

--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(5, 340817)
mod:AddSetIconOption("SetIconGaze", 331209, true, false, {1})

mod.vb.gazeCount = 0
mod.vb.stompCount = 0
mod.vb.roarCount = 0
mod.vb.linkCount = 0
mod.vb.chainSlamCount = 0
mod.vb.rubbleCount = 0
mod.vb.shiftCount = 0
local ChainLinkTargets = {}
local playerName = UnitName("player")
local playerPartner = nil
local SiesmicTimers = {18.1, 25.4, 29.3, 12.3, 25.5, 30.1, 12.6, 25.5, 30.1, 12.3, 25.4, 30.1, 13.5, 25.5, 28.8}
--								   30.1				       13.5        31.3
local function ChainLinkYellRepeater(self, text, runTimes)
	yellChainLink:Yell(text)
	runTimes = runTimes + 1
	if runTimes < 3 then
		self:Schedule(2, ChainLinkYellRepeater, self, text, runTimes)
	end
end

function mod:OnCombatStart(delay)
	self.vb.gazeCount = 0
	self.vb.stompCount = 0
	self.vb.roarCount = 0
	self.vb.linkCount = 0
	self.vb.chainSlamCount = 0
	self.vb.rubbleCount = 0
	playerPartner = nil
	table.wipe(ChainLinkTargets)
	--Roar cast instantly on pull, no timer needed
	--These 3 are same across board
	timerFallingRubbleCD:Start(12.1-delay, 1)--Unknown, not in combat log
	timerDestructiveStompCD:Start(18.1-delay, 1)
	timerHatefulGazeCD:Start(50.1-delay, 1)
	if not self:IsLFR() then
		timerChainLinkCD:Start(4.7-delay, 1)--Used on normal+
		if self:IsHard() then--Heroic+
			timerChainSlamCD:Start(28.3-delay, 1)
			if self:IsMythic() then--Mythic+
				self.vb.shiftCount = 0
				timerSiesmicShiftCD:Start(18.1, 1)
			end
		end
	end
--	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 332318 then
		self.vb.stompCount = self.vb.stompCount + 1
		specWarnDestructiveStomp:Show()
		specWarnDestructiveStomp:Play("justrun")
		--Heroic
		--pull:18.2, 25.9, 44.6, 25.5, 44.9, 25.5, 45.0, 25.3, 44.0", -- [2]
		--Mythic
		--pull:18.6, 25.5, 43.4, 25.5, 43.8, 25.5, 43.7", -- [2]
		if self.vb.stompCount % 2 == 0 then
			timerDestructiveStompCD:Start(43, self.vb.stompCount+1)
		else
			timerDestructiveStompCD:Start(25, self.vb.stompCount+1)--LFR is only about .5 seconds slower, so not worth nitpick
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 332687 then
		self.vb.roarCount = self.vb.roarCount + 1
		specWarnColossalRoar:Show()
		specWarnColossalRoar:Play("aesoon")
		timerColossalRoarCD:Start(self:IsLFR() and 33.2 or 27.9, self.vb.roarCount+1)--27-31 in fated?
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 331209 then
		self.vb.gazeCount = self.vb.gazeCount + 1
		timerHatefulGazeCD:Start(self:IsLFR() and 69.1 or 67.3, self.vb.gazeCount+1)
		if self.Options.SetIconGaze then
			self:SetIcon(args.destName, 1)
		end
		if args:IsPlayer() then
			specWarnHatefulGaze:Show(DBM_COMMON_L.PILLAR)
			specWarnHatefulGaze:Play("targetyou")
			yellHatefulGaze:Yell()
			yellHatefulGazeFades:Countdown(spellId)
		else
			specWarnHeedlessCharge:Show()
			specWarnHeedlessCharge:Play("farfromline")
			warnHatefulGaze:Show(self.vb.gazeCount, args.destName)
		end
	elseif spellId == 331314 then
		warnStunnedImpact:Show(args.destName)
		timerStunnedImpact:Start()
	elseif spellId == 342420 then--spellId == 342419 or
		--Combat log order is all 342419 first, then all 342420
		--Update, both spell Ids now have source and des names, so can just ignore one spell Id entirely and apply source/dest to check for pairs
		ChainLinkTargets[#ChainLinkTargets + 1] = args.sourceName
--		warnChainLink:CombinedShow(0.3, args.destName)
		local icon = #ChainLinkTargets--Generate icon on the evens, because then we can divide it by 2 to assign raid icon to that pair
		local playerIsInPair = false
		if args.sourceName == playerName then
			specWarnChainLink:Show(args.destName)
			specWarnChainLink:Play("gather")
			playerIsInPair = true
			playerPartner = args.destName
		elseif args.destName == playerName then
			specWarnChainLink:Show(args.sourceName)
			specWarnChainLink:Play("gather")
			playerIsInPair = true
			playerPartner = args.sourceName
		end
		if playerIsInPair then
			--need to account for up to 30 people (15 pairs)
			if icon == 9 then
				icon = "(°,,°)"
			elseif icon == 10 then
				icon = "(•_•)"
			elseif icon == 11 then
				icon = "(ಥ﹏ಥ)"
			elseif icon == 12 then
				icon = "(ツ)"
			elseif icon == 13 then
				icon = "ʕ•ᴥ•ʔ"
			elseif icon == 14 then
				icon = "ಠ_ಠ"
			elseif icon == 15 then
				icon = "(͡°͜°)"
			end
			self:Unschedule(ChainLinkYellRepeater)
			if type(icon) == "number" then icon = DBM_CORE_L.AUTO_YELL_CUSTOM_POSITION:format(icon, "") end
			self:Schedule(2, ChainLinkYellRepeater, self, icon, 0)
			yellChainLink:Yell(icon)
		end
	elseif spellId == 335470 then
		if args:IsPlayer() then
			specWarnChainSlam:Show()
			specWarnChainSlam:Play("targetyou")
			yellChainSlam:Yell()
			yellChainSlamFades:Countdown(4)--Can't auto pull from spellId
		elseif playerPartner and playerPartner == args.destName then
			specWarnChainSlamPartner:Show(args.destName)
			specWarnChainSlamPartner:Play("gathershare")
		else
			warnChainSlam:Show(self.vb.chainSlamCount, args.destName)
		end
		--Chain slam always extends Colossal Roar by a very precise amount
		if timerColossalRoarCD:GetRemaining(self.vb.roarCount+1) < 7.25 then
			local elapsed, total = timerColossalRoarCD:GetTime(self.vb.roarCount+1)
			local extend = 7.25 - (total-elapsed)
			DBM:Debug("timerColossalRoarCD extended by: "..extend, 2)
			timerColossalRoarCD:Stop()
			timerColossalRoarCD:Update(elapsed, total+extend, self.vb.roarCount+1)
		end
	elseif spellId == 341250 then
		warnGruesomeRage:Show(args.destName)
	elseif spellId == 340817 then
		if self:AntiSpam(8, 9) then
			self.vb.shiftCount = self.vb.shiftCount + 1
			local timer = SiesmicTimers[self.vb.shiftCount+1]
			if timer then
				timerSiesmicShiftCD:Start(timer, self.vb.shiftCount+1)
				local timerAfter = SiesmicTimers[self.vb.shiftCount+2]
				if not timerAfter then--Disable timer keeping if we're out of timer data beind THIS timer
					timerSiesmicShiftCD:SetSTKeep(false, self.vb.shiftCount+1)
				end
			end
		end
		if args:IsPlayer() then
			specWarnSiesmicShift:Show()
			specWarnSiesmicShift:Play("range5")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
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
	elseif spellId == 342419 or spellId == 342420 then--Both spellIds checked on purpose here for personal removal
		if args:IsPlayer() then
			self:Unschedule(ChainLinkYellRepeater)
			playerPartner = nil
		end
	elseif spellId == 340817 then
		if args:IsPlayer() then
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
--]]

function mod:SPELL_ENERGIZE(_, _, _, _, _, _, _, _, spellId, _, _, amount)
	if spellId == 346269 then
		timerHatefulGazeCD:Stop()--Boss immediately full energy so terminate timer/countdown immediately
		--TODO, also adjust other timers instead of just using KeepTime?
		--Might be annoying work to do for something that shouldn't happen in a properly executed fight
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 335300 then--Chain link
		table.wipe(ChainLinkTargets)
		self.vb.linkCount = self.vb.linkCount + 1
		timerChainLinkCD:Start(67.7, self.vb.linkCount+1)--67.7-69.1
	elseif spellId == 341193 then--or spellId == 341103
		self.vb.rubbleCount = self.vb.rubbleCount + 1
		specWarnFallingRubble:Show(self.vb.rubbleCount)
		specWarnFallingRubble:Play("watchstep")
		timerFallingRubbleCD:Start(67.8, self.vb.rubbleCount+1)
	elseif spellId == 335354 then--Chain Slam
		self.vb.chainSlamCount = self.vb.chainSlamCount + 1
		timerChainSlamCD:Start(68.9, self.vb.chainSlamCount+1)
	end
end
