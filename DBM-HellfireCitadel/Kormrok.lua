local mod	= DBM:NewMod(1392, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90435)
mod:SetEncounterID(1787)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
mod:SetHotfixNoticeRev(14154)
mod.respawnTime = 18--18 is an odd one, but definitely was 18

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 181292 181293 181296 181297 181299 181300 180244 181305",
	"SPELL_CAST_SUCCESS 181307 181299 181300",
	"SPELL_AURA_APPLIED 181306 186882 180115 180116 180117 189197 189198 189199 186879 186880 186881",
	"SPELL_AURA_REMOVED 181306 180244"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

mod:RegisterEvents(
	"CHAT_MSG_ADDON"--Has to be out of combat
)

--(ability.id = 181292 or ability.id = 181293 or ability.id = 181296 or ability.id = 181297 or ability.id = 181299 or ability.id = 181300 or ability.id = 180244 or ability.id = 181305) and type = "begincast" or ability.id = 181307 and type = "cast" or (ability.id = 181306 or ability.id = 180115 or ability.id = 180116 or ability.id = 180117 or ability.id = 189197 or ability.id = 189198 or ability.id = 189199 or ability.id = 186882 or ability.id = 186879 or ability.id = 186880 or ability.id = 186881) and (type = "applybuff" or type = "applydebuff")
--TODO, other countdowns, other voices, once ability importance is assessed.
local warnShadowEnergy				= mod:NewSpellAnnounce(180115, 2)
local warnExplosiveEnergy			= mod:NewSpellAnnounce(180116, 3)--This one looks more dangerous than other 2, because it enables the Explosive Runes ability
local warnFoulEnergy				= mod:NewSpellAnnounce(180117, 2)
--These are probably temp, changed to better tank special warnings when better understood
local warnExplosiveBurst			= mod:NewTargetCountAnnounce(181306, 4)--Concerns everyone
local warnEnrage					= mod:NewSpellAnnounce(186882, 3)

local specWarnPound					= mod:NewSpecialWarningCount(180244, nil, nil, nil, 2, 2)
local specWarnSwat					= mod:NewSpecialWarningCount(181305, "Tank", nil, nil, 1, 2)
local specWarnExplosiveBurst		= mod:NewSpecialWarningYouCount(181306)
local yellExplosiveBurst			= mod:NewYell(181306)
local specWarnExplosiveBurstNear	= mod:NewSpecialWarningClose(181306, nil, nil, nil, 3, 2)
local specWarnFoulCrush				= mod:NewSpecialWarningSwitch(181307, "Dps|Tank")--Tweak it as needed once can figure out how to detect what tank it's on
local specWarnFelOutpouring			= mod:NewSpecialWarningDodge(181292, nil, nil, nil, 2, 2)
local specWarnExplosiveRunes		= mod:NewSpecialWarningSpell(181296, "-Tank")--Leaving as a spell warning, MoveTo gives misleading info that everyone just runs toward them, only a few do who know what to do
local specWarnGraspingHands			= mod:NewSpecialWarningSwitch(181299)
--Empowered versions (made separate so users can set different sounds for the more dangerous versions if they choose)
local specWarnEmpFelOutpouring		= mod:NewSpecialWarningDodge(181293, nil, nil, nil, 2, 2)
local specWarnEmpExplosiveRunes		= mod:NewSpecialWarningSpell(181297, "-Tank")
local specWarnDraggingHands			= mod:NewSpecialWarningSwitch(181300)

local timerLeapCD					= mod:NewCDTimer(113.5, 180068, nil, nil, nil, 6)--Not techincally a leap timer, timer syncs up to when he gains next buff (leap ended)
--Times here are not relevant, they are all hard coded orders based on what buff boss has, real values are under 3 different phases
local timerPoundCD					= mod:NewNextCountTimer(42, 180244, nil, nil, nil, 2)
local timerFelOutpouringCD			= mod:NewNextTimer(107, 181292, nil, nil, nil, 2)
local timerExplosiveRunesCD			= mod:NewNextTimer(48, 181296, nil, nil, nil, 5)
local timerGraspingHandsCD			= mod:NewNextTimer(107, 181299, nil, nil, nil, 1)
--Tank Debuffs. These are also hard coded, but in different place.
mod:AddTimerLine(TANK)
local timerExplosiveBurstCD			= mod:NewNextCountTimer(40, 181306, nil, nil, nil, 3)--Everyone needs to know these 2
local timerFoulCrushCD				= mod:NewNextCountTimer(40, 181307, nil, nil, nil, 1)--Everyone needs to know these 2
local timerSwatCD					= mod:NewNextCountTimer(40, 181305, nil, "Tank", nil, 5)

--local berserkTimer				= mod:NewBerserkTimer(360)--Was 8 min on heroic PTR, but that also might have been a bug so will wait to confirm

local countdownGraspingHands		= mod:NewCountdown(40, 181299)
local countdownExplosiveBurst		= mod:NewCountdown("Alt10", 181306)

local voicePound					= mod:NewVoice(180244)--aesoon
local voiceFelOutpouring			= mod:NewVoice(181292)--watchwave
local voiceExplosiveBurst			= mod:NewVoice(181306)--runout
local voiceGraspingHands			= mod:NewVoice(181299)--gather
local voiceSwat						= mod:NewVoice(181305, "Tank")--carefly

mod:AddRangeFrameOption("4/40")
--mod:AddArrowOption("RuneArrow", 157060, false, 3)--Off by default, because hud does a much better job, and in case user is running both Exorsus Raid Tools and DBM (ExRT has it's own arrow)
mod:AddHudMapOption("HudMapForRune", 181202)

mod.vb.explodingTank = nil
mod.vb.poundActive = false
mod.vb.poundCount = 0
mod.vb.explosiveBurst = 0
mod.vb.foulCrush = 0
mod.vb.swatCount = 0
mod.vb.enraged = false
local debuffName = GetSpellInfo(181306)
local UnitDebuff = UnitDebuff
local playerName = UnitName("player")
local playerOrangeX, playerOrangeY = nil, nil
local playerGreenX, playerGreenY = nil, nil
local playerPurpleX, playerPurpleY = nil, nil

--Not local functions, so they can also be used as a test functions as well
--/run DBM:GetModByName("1392"):RuneStart(181293, true)
function mod:RuneStart(spellId, force)
	if not self:IsMythic() and not force then return end
	local playerX, playerY
	if spellId == 181293 then
		playerX, playerY = playerPurpleX, playerPurpleY
	elseif spellId == 181297 then
		playerX, playerY = playerOrangeX, playerOrangeY
	elseif spellId == 181300 then
		playerX, playerY = playerGreenX, playerGreenY
	end
	if spellId and playerX and playerY then
	--	if self.Options.RuneArrow then
	--		DBM.Arrow:ShowRunTo(playerX, playerY, 0)
	--	end
		if self.Options.HudMapForRune then
			local m1 = DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", playerName, 0.1, 8, 0, 1, 0, 0.5):Appear()--tiny dot for self, to create line PoO
			local m2 = DBMHudMap:RegisterPositionMarker(spellId, "HudMapForRune", "highlight", playerX, playerY, 3, 8, 0, 1, 0, 0.5, nil, 4):Pulse(0.5, 0.5)--Rune location
			m2:EdgeTo(m1, nil, 8, 0, 1, 0, 1)--Now draw line between player and rune
		end
	end
end

function mod:RuneOver()
--	if self.Options.RuneArrow then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.HudMapForRune then
		DBMHudMap:Disable()
	end
end

local debuffFilter
do
	debuffFilter = function(uId)
		if UnitDebuff(uId, debuffName) then
			return true
		end
	end
end

local function updateRangeCheck(self, force)
	if not self.Options.RangeFrame then return end
	if self.vb.explodingTank then
		if UnitDebuff("player", debuffName) then
			DBM.RangeCheck:Show(30)
		elseif not self:CheckNearby(31, self.vb.explodingTank) and self.vb.poundActive then--far enough from tank and pound is active, switch back to 4
			DBM.RangeCheck:Show(4)
		else--No pound, tank still active, keep filtered radar up to prevent walking back into tank
			DBM.RangeCheck:Show(30, debuffFilter)
		end
	elseif self.vb.poundActive or force then--Just pound, no tank debuff.
		DBM.RangeCheck:Show(4)
	else
		DBM.RangeCheck:Hide()
	end
end

local function trippleBurstCheck(self, target, first)
	if self:CheckNearby(31, target) then--Second and third check will use smaller range
		specWarnExplosiveBurstNear:Show(target)
		voiceExplosiveBurst:Play("justrun")
	end
	if first then
		self:Schedule(2.5, trippleBurstCheck, self, target)
	end
	updateRangeCheck(self)
end

function mod:OnCombatStart(delay)
	self.vb.explodingTank = nil
	self.vb.poundActive = false
	self.vb.poundCount = 0
	self.vb.enraged = false
	timerLeapCD:Start(12-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.RuneArrow then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.HudMapForRune then
		DBMHudMap:Disable()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 181292 or spellId == 181293 then
		if spellId == 181293 then
			specWarnEmpFelOutpouring:Show()
		else
			specWarnFelOutpouring:Show()
		end
		voiceFelOutpouring:Play("watchwave")
	elseif spellId == 181296 or spellId == 181297 then
		if spellId == 181297 then
			specWarnEmpExplosiveRunes:Show()
		else
			specWarnExplosiveRunes:Show()
		end
	elseif spellId == 181299 or spellId == 181300 then
		if spellId == 181300 then
			specWarnDraggingHands:Show()
		else
			specWarnGraspingHands:Show()
		end
		updateRangeCheck(self, true)
	elseif spellId == 180244 then
		self.vb.poundActive = true
		self.vb.poundCount = self.vb.poundCount + 1
		specWarnPound:Show(self.vb.poundCount)
		voicePound:Play("aesoon")
		updateRangeCheck(self)
	elseif spellId == 181305 then
		self.vb.swatCount = self.vb.swatCount + 1
		specWarnSwat:Show(self.vb.swatCount)
		voiceSwat:Play("carefly")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 181307 then
		self.vb.foulCrush = self.vb.foulCrush + 1
		specWarnFoulCrush:Show(self.vb.foulCrush)
	elseif spellId == 181299 or spellId == 181300 then
		updateRangeCheck(self)
	end
end

local function delayedPound(self, time)
	timerPoundCD:Start(time, 2)
end

local function delayedExplosiveRunes(self, time)
	timerExplosiveRunesCD:Start(time)
end

local function delayedHands(self, time)
	timerGraspingHandsCD:Start(time)
	countdownGraspingHands:Start(time)
	if not self:IsMythic() then
		voiceGraspingHands:Schedule(time-5, "gather")
	end
end

local function delayedFelOutpouring(self, time)
	timerFelOutpouringCD:Start(time)
end

local function delayedSwat(self, time, count)
	timerSwatCD:Start(time, count)
end

local function delayedFowlCrush(self, time, count)
	timerFoulCrushCD:Start(time, count)
end

local function delayedExplosiveBurst(self, time, count)
	timerExplosiveBurstCD:Start(time, count)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 181306 then
		self.vb.explosiveBurst = self.vb.explosiveBurst + 1
		self.vb.explodingTank = args.destName
		countdownExplosiveBurst:Start()
		if args:IsPlayer() then
			specWarnExplosiveBurst:Show(self.vb.explosiveBurst)
			yellExplosiveBurst:Yell()
		else
			if self:CheckNearby(31, args.destName) then
				specWarnExplosiveBurstNear:Show(args.destName)
				voiceExplosiveBurst:Play("runout")
			else
				warnExplosiveBurst:Show(self.vb.explosiveBurst, args.destName)
			end
			--Check player distance 3x, like mark of chaos, don't let players run INTO it after they are safe
			self:Schedule(3, trippleBurstCheck, self, args.destName, true)
		end
		updateRangeCheck(self)
	--Each energy has it's own hard coded sequence of events/timers.
	--So all timers need to be scheduled here, they aren't started by any ability casts
	elseif spellId == 180115 or spellId == 186879 then--Shadow Energy (186879 enraged version)
		self.vb.poundCount = 0
		self.vb.swatCount = 0
		warnShadowEnergy:Show()
		self:RuneStart(181293)
		if self:IsMythic() and spellId == 186879 then--Mythic AND enraged
			timerFelOutpouringCD:Start(8)
			self:Schedule(8, delayedFelOutpouring, self, 65)--73
			timerSwatCD:Start(23, 1)
			self:Schedule(23, delayedSwat, self, 23, 2)
			self:Schedule(46, delayedSwat, self, 23, 3)
			timerPoundCD:Start(26, 1)
			self:Schedule(26, delayedPound, self, 30)--57
			timerExplosiveRunesCD:Start(39)
			timerGraspingHandsCD:Start(50)
			countdownGraspingHands:Start(50)
			timerLeapCD:Start(96)
		elseif (self:IsMythic() and spellId == 180115) or spellId == 186879 then--Mythic regular, or heroic/normal enrage
			timerFelOutpouringCD:Start(11)
			self:Schedule(11, delayedFelOutpouring, self, 84)--95
			timerSwatCD:Start(31, 1)
			self:Schedule(31, delayedSwat, self, 32, 2)
			self:Schedule(53, delayedSwat, self, 32, 3)
			timerPoundCD:Start(37, 1)
			self:Schedule(37, delayedPound, self, 48)--85
			timerExplosiveRunesCD:Start(53)
			timerGraspingHandsCD:Start(69)
			countdownGraspingHands:Start(69)
			timerLeapCD:Start()
		else
			timerFelOutpouringCD:Start(13)
			self:Schedule(13, delayedFelOutpouring, self, 100)--113
			timerSwatCD:Start(37, 1)
			self:Schedule(37, delayedSwat, self, 38, 2)
			self:Schedule(75, delayedSwat, self, 38, 3)
			timerPoundCD:Start(45, 1)
			self:Schedule(45, delayedPound, self, 50)--95
			timerExplosiveRunesCD:Start(63)
			voiceGraspingHands:Schedule(78, "gather")
			timerGraspingHandsCD:Start(83)
			countdownGraspingHands:Start(83)
			timerLeapCD:Start(135.5)
		end
	--Non LFR phase changes need reworking post mechanics changes.
	--Probably still mostly right but need minor tweaks
	elseif spellId == 180116 or spellId == 186880 then--Explosive Energy (186880 enrage version)
		self.vb.poundCount = 0
		self.vb.explosiveBurst = 0
		warnExplosiveEnergy:Show()
		self:RuneStart(181297)
		if (self:IsMythic() and spellId == 186880) then
			timerExplosiveRunesCD:Start(8)
			self:Schedule(8, delayedExplosiveRunes, self, 40)--48
			timerExplosiveBurstCD:Start(15, 1)
			self:Schedule(15, delayedExplosiveBurst, self, 23, 2)
			self:Schedule(38, delayedExplosiveBurst, self, 30, 3)
			timerPoundCD:Start(19, 1)
			self:Schedule(19, delayedPound, self, 35)--54
			timerGraspingHandsCD:Start(35)
			countdownGraspingHands:Start(35)
			timerFelOutpouringCD:Start(49)
			timerLeapCD:Start(96)
		elseif (self:IsMythic() and spellId == 180116) or spellId == 186880 then
			timerExplosiveRunesCD:Start(11)
			self:Schedule(11, delayedExplosiveRunes, self, 48)--59
			timerExplosiveBurstCD:Start(21, 1)
			self:Schedule(21, delayedExplosiveBurst, self, 32, 2)
			self:Schedule(53, delayedExplosiveBurst, self, 42, 3)
			timerPoundCD:Start(27, 1)
			self:Schedule(27, delayedPound, self, 42)--69
			timerGraspingHandsCD:Start(43)
			countdownGraspingHands:Start(43)
			timerFelOutpouringCD:Start(59)
			timerLeapCD:Start()
		else
			timerExplosiveRunesCD:Start(13)
			self:Schedule(13, delayedExplosiveRunes, self, 58)--71
			timerExplosiveBurstCD:Start(25, 1)
			self:Schedule(25, delayedExplosiveBurst, self, 38, 2)
			self:Schedule(63, delayedExplosiveBurst, self, 50, 3)
			timerPoundCD:Start(33, 1)
			self:Schedule(33, delayedPound, self, 62)--95
			voiceGraspingHands:Schedule(46, "gather")
			timerGraspingHandsCD:Start(51)
			countdownGraspingHands:Start(51)
			timerFelOutpouringCD:Start(71)
			timerLeapCD:Start(135.5)
		end
	elseif spellId == 180117 or spellId == 186881 then--Foul Energy (186881 enrage version)
		self.vb.poundCount = 0
		self.vb.foulCrush = 0
		warnFoulEnergy:Show()
		self:RuneStart(181300)
		if (self:IsMythic() and spellId == 186881) then
			timerGraspingHandsCD:Start(8)
			countdownGraspingHands:Start(8)
			self:Schedule(8, delayedHands, self, 75)--83
			timerFoulCrushCD:Start(15, 1)
			self:Schedule(15, delayedFowlCrush, self, 31, 2)
			self:Schedule(46, delayedFowlCrush, self, 23, 3)
			timerPoundCD:Start(19, 1)
			self:Schedule(19, delayedPound, self, 43)--62
			timerFelOutpouringCD:Start(31)
			timerExplosiveRunesCD:Start(50)
			timerLeapCD:Start(96)
		elseif (self:IsMythic() and spellId == 180117) or spellId == 186881 then
			timerGraspingHandsCD:Start(11)
			countdownGraspingHands:Start(11)
			self:Schedule(11, delayedHands, self, 90)--101
			timerFoulCrushCD:Start(21, 1)
			self:Schedule(21, delayedFowlCrush, self, 42, 2)
			self:Schedule(63, delayedFowlCrush, self, 32, 3)
			timerPoundCD:Start(27, 1)
			self:Schedule(27, delayedPound, self, 52)--79
			timerFelOutpouringCD:Start(43.5)
			timerExplosiveRunesCD:Start(69)
			timerLeapCD:Start()
		else
			voiceGraspingHands:Schedule(8, "gather")
			timerGraspingHandsCD:Start(13)
			countdownGraspingHands:Start(13)
			self:Schedule(13, delayedHands, self, 108)--121
			timerFoulCrushCD:Start(25, 1)
			self:Schedule(25, delayedFowlCrush, self, 50, 2)
			self:Schedule(75, delayedFowlCrush, self, 38, 3)
			timerPoundCD:Start(33, 1)
			self:Schedule(33, delayedPound, self, 62)--95
			timerFelOutpouringCD:Start(51)
			timerExplosiveRunesCD:Start(83)
			timerLeapCD:Start(135.5)
		end
	--LFR is an ENTIRELY different fight
	--Fortunately it's also different spellids for phase changes so easy separate rules
	elseif spellId == 189197 then--Shadow Energy
		--10 Outpouring, 40 pound, 55 outporing, 75 pound, 100 outpouring
		self.vb.poundCount = 0
		warnShadowEnergy:Show()
		timerFelOutpouringCD:Start(10)
		self:Schedule(10, delayedFelOutpouring, self, 45)--55
		self:Schedule(45, delayedFelOutpouring, self, 45)--100
		timerPoundCD:Start(40, 1)
		self:Schedule(40, delayedPound, self, 35)--75
		timerLeapCD:Start(124)
	elseif spellId == 189198 then--Explosive Energy
		--10 Runes, 30 pound, 45 runes, 55 pound, 80 runes
		self.vb.poundCount = 0
		warnExplosiveEnergy:Show()
		timerExplosiveRunesCD:Start(10)
		self:Schedule(10, delayedExplosiveRunes, self, 35)--45
		self:Schedule(45, delayedExplosiveRunes, self, 35)--80
		timerPoundCD:Start(30, 1)
		self:Schedule(30, delayedPound, self, 25)--55
		timerLeapCD:Start(93)
	elseif spellId == 189199 then--Foul Energy
		--10 grasping, 30 pound, 45 grasping, 55 pound, 80 grasping
		self.vb.poundCount = 0
		warnFoulEnergy:Show()
		timerGraspingHandsCD:Start(10)
		voiceGraspingHands:Schedule(5, "gather")
		countdownGraspingHands:Start(10)
		self:Schedule(10, delayedHands, self, 35)--45
		self:Schedule(45, delayedHands, self, 35)--80
		timerPoundCD:Start(30, 1)
		self:Schedule(30, delayedPound, self, 25)--55
		timerLeapCD:Start(93)
	elseif spellId == 186882 then
		self.vb.enraged = true
		warnEnrage:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 181306 then
		self.vb.explodingTank = nil
		self:Unschedule(trippleBurstCheck)
		countdownExplosiveBurst:Cancel()
		updateRangeCheck(self)
	elseif spellId == 180244 then
		self.vb.poundActive = false
		updateRangeCheck(self)
	end
end

do
	RegisterAddonMessagePrefix("EXRTADD")
	local playerName = UnitName("player")
	local Ambiguate = Ambiguate
	local assignedPositionOrange, assignedPositionGreen, assignedPositionPurple
	local function delayedNotice(self, sender)
		DBM:AddMsg(L.ExRTNotice:format(sender, (assignedPositionOrange or NONE), (assignedPositionGreen or NONE), (assignedPositionPurple or NONE)))
	end
	--Exorsus Raid Tools Comm snooping to detect player assignment even if player isn't running Exorsus Raid Tools.
	local runes = {
		[1] = {-388.10,4209.00},
		[2] = {-354.50,4208.60},
		[3] = {-339.80,4210.80},
		[4] = {-321.50,4210.20},
		[5] = {-396.90,4227.70},
		[6] = {-380.00,4223.90},
		[7] = {-365.50,4224.90},
		[8] = {-345.40,4223.80},
		[9] = {-331.50,4220.00},
		[10] = {-388.60,4241.30},
		[11] = {-367.80,4241.80},
		[12] = {-354.90,4238.60},
		[13] = {-338.40,4243.40},
		[14] = {-321.70,4243.10},
		[15] = {-394.80,4258.40},
		[16] = {-384.40,4253.80},
		[17] = {-363.00,4258.30},
		[18] = {-347.70,4253.60},
		[19] = {-328.10,4252.60},
		[20] = {-308.90,4253.00},
		[21] = {-389.80,4269.90},
		[22] = {-372.70,4271.60},
		[23] = {-356.70,4270.40},
		[24] = {-336.10,4270.40},
		[25] = {-318.90,4271.40},
		[26] = {-302.50,4271.00},
		[27] = {-362.50,4283.60},
		[28] = {-345.30,4283.00},
		[29] = {-329.70,4287.20},
		[30] = {-355.60,4301.30},
		[31] = {-336.30,4299.70},
		[32] = {-320.60,4303.30},
		[33] = {-304.10,4301.50},
		[34] = {-300.10,4240.10},
		[35] = {-294.10,4255.20},
		[36] = {-311.10,4281.70},
		[37] = {-295.40,4285.90},
		[38] = {-284.20,4270.00},
		[39] = {-343.30,4316.10},
		[40] = {-328.00,4318.30},
		[41] = {-310.80,4318.40},
		[42] = {-294.40,4316.50},
		[43] = {-273.20,4315.90},
		[44] = {-259.50,4317.70},
		[45] = {-241.50,4315.60},
		[46] = {-332.80,4329.70},
		[47] = {-318.50,4332.70},
		[48] = {-301.50,4333.20},
		[49] = {-286.20,4329.10},
		[50] = {-268.70,4329.80},
		[51] = {-313.60,4344.40},
		[52] = {-292.10,4344.00},
		[53] = {-360.50,4318.30},
		[54] = {-354.60,4329.70},
		[55] = {-326.80,4343.50},
		[56] = {-274.10,4345.40},
		[57] = {-248.40,4329.20},
		[58] = {-235.10,4332.30},
		[59] = {-285.10,4299.00},
		[60] = {-265.20,4299.00},
		[61] = {-249.50,4303.40},
		[62] = {-230.90,4297.20},
		[63] = {-275.00,4288.40},
		[64] = {-259.00,4283.00},
		[65] = {-240.50,4284.10},
		[66] = {-222.50,4286.70},
		[67] = {-269.60,4272.00},
		[68] = {-249.50,4269.60},
		[69] = {-231.50,4267.30},
		[70] = {-257.30,4253.20},
		[71] = {-240.20,4253.80},
		[72] = {-278.90,4255.20},
	}
	function mod:CHAT_MSG_ADDON(prefix, message, channel, sender)
		if prefix ~= "EXRTADD" then return end
		local subPrefix,pos1,name1,pos2,name2,pos3,name3 = strsplit("\t", message)
		if subPrefix ~= "kormrok" then return end
		sender = Ambiguate(sender, "none")
		if DBM:GetRaidRank(sender) == 0 and IsInGroup() then return end
		local tempPos1, tempPos2, TempPos3 = pos1 or "nil", pos2 or "nil", pos3 or "nil"
		DBM:Debug("Sender: "..sender.."Pos1: "..tempPos1..", Name1: "..(name1 or "nil")..", Pos2: "..tempPos2..", Name2: "..(name2 or "nil")..", Pos3: "..TempPos3..", Name3: "..(name3 or "nil"), 3)
		--Check if player removed from a cached assignment
		--Now the add player assignment code
		if name1 and Ambiguate(name1, "none") == playerName then
			local number = tonumber(pos1)
			if number < 100 then--Orange
				assignedPositionOrange = number
				playerOrangeX, playerOrangeY = runes[assignedPositionOrange][2], runes[assignedPositionOrange][1]
			elseif number < 200 then--Green
				assignedPositionGreen = number-100
				playerGreenX, playerGreenY = runes[assignedPositionGreen][2], runes[assignedPositionGreen][1]
			else--Purple
				assignedPositionPurple = number-200
				playerPurpleX, playerPurpleY = runes[assignedPositionPurple][2], runes[assignedPositionPurple][1]
			end
		end
		if name2 and Ambiguate(name2, "none") == playerName then
			local number = tonumber(pos2)
			if number < 100 then--Orange
				assignedPositionOrange = number
				playerOrangeX, playerOrangeY = runes[assignedPositionOrange][2], runes[assignedPositionOrange][1]
			elseif number < 200 then--Green
				assignedPositionGreen = number-100
				playerGreenX, playerGreenY = runes[assignedPositionGreen][2], runes[assignedPositionGreen][1]
			else--Purple
				assignedPositionPurple = number-200
				playerPurpleX, playerPurpleY = runes[assignedPositionPurple][2], runes[assignedPositionPurple][1]
			end
		end
		if name3 and Ambiguate(name3, "none") == playerName then
			local number = tonumber(pos3)
			if number < 100 then--Orange
				assignedPositionOrange = number
				playerOrangeX, playerOrangeY = runes[assignedPositionOrange][2], runes[assignedPositionOrange][1]
			elseif number < 200 then--Green
				assignedPositionGreen = number-100
				playerGreenX, playerGreenY = runes[assignedPositionGreen][2], runes[assignedPositionGreen][1]
			else--Purple
				assignedPositionPurple = number-200
				playerPurpleX, playerPurpleY = runes[assignedPositionPurple][2], runes[assignedPositionPurple][1]
			end
		end
		self:Unschedule(delayedNotice)
		self:Schedule(1, delayedNotice, self, sender)
	end
end
