local mod	= DBM:NewMod(2394, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164407)
mod:SetEncounterID(2399)
mod:SetUsedIcons(1)
mod:SetHotfixNoticeRev(20200813000000)--2020, 8, 13
mod:SetMinSyncRevision(20200813000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 332318",
	"SPELL_CAST_SUCCESS 332687",
	"SPELL_AURA_APPLIED 331209 331314 342419 342420 335470 341294 340817",
	"SPELL_AURA_REMOVED 331209 331314 342419 342420 340817",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, this straght up needs an updateAllTimers function like archimonde to be perfect.
--Timers delaying other timers, some abilities being skipped entirely if coming off cd during stun or another ability cast
--The timers COULD be perfected, I'm just not sure it's worth the effort to. Not an end boss, or even a hard one.
--I'll return to perfecting timers if things don't change on live and can analylize dozens more logs to verify patterns
local warnHatefulGaze							= mod:NewTargetNoFilterAnnounce(331209, 4)
local warnStunnedImpact							= mod:NewTargetNoFilterAnnounce(331314, 1)
local warnChainLink								= mod:NewTargetAnnounce(342419, 3)--Targetting debuff
local warnChainSlam								= mod:NewTargetNoFilterAnnounce(164407, 3)
local warnVengefulRage							= mod:NewTargetNoFilterAnnounce(341294, 4)

local specWarnHatefulGaze						= mod:NewSpecialWarningMoveTo(331209, nil, nil, nil, 3, 2)
local specWarnHeedlessCharge					= mod:NewSpecialWarningSoon(331212, nil, nil, nil, 2, 2)
local yellHatefulGaze							= mod:NewShortYell(331209)
local yellHatefulGazeFades						= mod:NewShortFadesYell(331209)
local specWarnChainLink							= mod:NewSpecialWarningYou(335491, nil, nil, nil, 1, 2)
local yellChainLink								= mod:NewIconRepeatYell(335300, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.shortyell, false)
local specWarnChainSlam							= mod:NewSpecialWarningYou(335470, nil, nil, nil, 1, 2)
local yellChainSlam								= mod:NewShortYell(335470, nil, nil, nil, "YELL")
local yellChainSlamFades						= mod:NewShortFadesYell(335470, nil, nil, nil, "YELL")
local specWarnDestructiveStomp					= mod:NewSpecialWarningRun(332318, "Melee", nil, nil, 4, 2)
local specWarnColossalRoar						= mod:NewSpecialWarningSpell(332687, nil, nil, nil, 2, 2)
local specWarnFallingRubble						= mod:NewSpecialWarningDodge(332572, nil, nil, nil, 2, 2)
local specWarnSiesmicShift						= mod:NewSpecialWarningMoveAway(340817, nil, nil, nil, 2, 2, 4)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

local timerHatefulGazeCD						= mod:NewCDCountTimer(69.0, 331209, nil, nil, nil, 3, nil, DBM_CORE_L.IMPORTANT_ICON, nil, 1, 4)
local timerStunnedImpact						= mod:NewTargetTimer(12, 331314, nil, nil, nil, 5, nil, DBM_CORE_L.DAMAGE_ICON)
local timerChainLinkCD							= mod:NewCDCountTimer(68.1, 335300, nil, nil, nil, 3)
local timerChainSlamCD							= mod:NewCDCountTimer(34, 335354, nil, nil, nil, 3)
local timerDestructiveStompCD					= mod:NewCDCountTimer(44.3, 332318, nil, nil, nil, 3)
local timerFallingRubbleCD						= mod:NewCDCountTimer(67.8, 332572, nil, nil, nil, 3)
local timerColossalRoarCD						= mod:NewCDCountTimer(44.3, 332687, nil, nil, nil, 2)
local timerSiesmicShiftCD						= mod:NewCDCountTimer(34, 340817, nil, nil, nil, 3, nil, DBM_CORE_L.MYTHIC_ICON)--Mythic

--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(5, 340817)
mod:AddInfoFrameOption(342410, true)
mod:AddSetIconOption("SetIconGaze", 331209, true, false, {1})

mod.vb.gazeCount = 0
mod.vb.stompCount = 0
mod.vb.roarCount = 0
mod.vb.linkCount = 0
mod.vb.chainSlaimCount = 0
mod.vb.rubbleCount = 0
mod.vb.shiftCount = 0
local ChainLinkTargetOne, ChainLinkTargetTwo = {}, {}
local playerName = UnitName("player")
local SiesmicTimers = {18.4, 25.9, 29.3, 12.9, 25.5, 30.5, 12.6, 25.9, 30.6}

local function ChainLinkYellRepeater(self, text)
	yellChainLink:Yell(text)
	self:Schedule(2, ChainLinkYellRepeater, self, text)
end

function mod:OnCombatStart(delay)
	self.vb.gazeCount = 0
	self.vb.stompCount = 0
	self.vb.roarCount = 0
	self.vb.linkCount = 0
	self.vb.chainSlaimCount = 0
	self.vb.rubbleCount = 0
	table.wipe(ChainLinkTargetOne)
	table.wipe(ChainLinkTargetTwo)
	timerChainLinkCD:Start(4.7-delay, 1)
	timerFallingRubbleCD:Start(13.2-delay, 1)
	timerDestructiveStompCD:Start(18.3-delay, 1)
--	timerColossalRoarCD:Start(1-delay)--Cast instantly on pull
	timerChainSlamCD:Start(34-delay, 1)
	timerHatefulGazeCD:Start(50.9-delay, 1)
	if self:IsMythic() then
		self.vb.shiftCount = 0
		timerSiesmicShiftCD:Start(18.4, 1)
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM_CORE_L.NO_DEBUFF:format(DBM:GetSpellInfo(342410)))
			DBM.InfoFrame:Show(5, "playergooddebuff", 342410)--TODO, change number when columns work again
		end
	end
	if self.Options.NPAuraOnHaunting then
		DBM:FireEvent("BossMod_EnableFriendlyNameplates")
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
		--pull:22.4, 23.3, 44.2, 23.1, 45.5, 22.0, 45.3, 22.1"
		--pull:27.0, 22.1, 44.6, 22.1, 44.2, 22.1, 47.1, 22.6, 45.2, 23.1"
		--Mythic
		--pull:18.3, 26.0, 43.0, 25.8, 43.2, 25.9", -- [2]
		if self.vb.stompCount == 1 or (self.vb.stompCount % 2 == 0) then
			timerDestructiveStompCD:Start(43, self.vb.stompCount+1)
		else
			timerDestructiveStompCD:Start(25, self.vb.stompCount+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 332687 then
		self.vb.roarCount = self.vb.roarCount + 1
		specWarnColossalRoar:Show()
		specWarnColossalRoar:Play("aesoon")
		--"Colossal Roar-332687-npc:164407 = pull:0.0, 30.3, 37.0, 30.8, 36.1, 30.2, 36.8, 30.4, 38.9, 30.6, 30.9", -- [2]
		--"Colossal Roar-332687-npc:164407 = pull:0.0, 30.9, 37.9, 30.3, 38.8", -- [2]
		if self.vb.roarCount < 10 and (self.vb.roarCount % 2 == 0) then
			--Logic almost works, except when it doesn't
			timerColossalRoarCD:Start(36.8, self.vb.roarCount+1)
		else
			timerColossalRoarCD:Start(30.2, self.vb.roarCount+1)
		end
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
		--Combat log order is all 342419 first, then all 342420
		if spellId == 342419 then
			ChainLinkTargetOne[#ChainLinkTargetOne + 1] = args.destName
		else
			ChainLinkTargetTwo[#ChainLinkTargetTwo + 1] = args.destName
		end
		warnChainLink:CombinedShow(0.3, args.destName)
		local icon
		if spellId == 342420 then
			icon = #ChainLinkTargetTwo--Generate icon on the evens, because then we can divide it by 2 to assign raid icon to that pair
			local playerIsInPair = false
			if ChainLinkTargetOne[icon] == playerName then
				specWarnChainLink:Show(ChainLinkTargetTwo[icon])
				specWarnChainLink:Play("gather")
				playerIsInPair = true
			elseif ChainLinkTargetTwo[icon] == playerName then
				specWarnChainLink:Show(ChainLinkTargetOne[icon])
				specWarnChainLink:Play("gather")
				playerIsInPair = true
			end
			if playerIsInPair then
				self:Unschedule(ChainLinkYellRepeater)
				if type(icon) == "number" then icon = DBM_CORE_L.AUTO_YELL_CUSTOM_POSITION:format(icon, "") end
				self:Schedule(2, ChainLinkYellRepeater, self, icon)
				yellChainLink:Yell(icon)
			end
		end
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
	elseif spellId == 340817 then
		if self:AntiSpam(8, 9) then
			self.vb.shiftCount = self.vb.shiftCount + 1
			local timer = SiesmicTimers[self.vb.shiftCount+1]
			if timer then
				timerSiesmicShiftCD:Start(timer, self.vb.shiftCount+1)
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
	elseif spellId == 342419 or spellId == 342420 then
		if args:IsPlayer() then
			self:Unschedule(ChainLinkYellRepeater)
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 335491 then--Chain link
		table.wipe(ChainLinkTargetOne)
		table.wipe(ChainLinkTargetTwo)
		self.vb.linkCount = self.vb.linkCount + 1
		timerChainLinkCD:Start(68.1, self.vb.linkCount+1)
	elseif spellId == 341193 then--or spellId == 341103
		self.vb.rubbleCount = self.vb.rubbleCount + 1
		specWarnFallingRubble:Show(self.vb.rubbleCount)
		specWarnFallingRubble:Play("watchstep")
		timerFallingRubbleCD:Start(67.8, self.vb.rubbleCount+1)
	end
end
