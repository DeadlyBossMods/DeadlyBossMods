local mod	= DBM:NewMod(1162, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77692)
mod:SetEncounterID(1713)
mod:SetZone()
mod:SetHotfixNoticeRev(13105)
mod.respawnTime = 29.5

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 157060 157054 156704 157592 158217",
	"SPELL_CAST_SUCCESS 158130 170469",
	"SPELL_AURA_APPLIED 156766 161923 173917 156852 157059 156861",
	"SPELL_AURA_APPLIED_DOSE 156766"
)

mod:RegisterEvents(
	"CHAT_MSG_ADDON"--Has to be out of combat
)

--Expression:  (ability.id = 157060 or ability.id = 158217) and type = "begincast" or ability.id = 173917 and type = "applybuff"
--TODO, FUCK this fight and it's timers. It's impossible to make them correct in all cases. they are just FAR too god damn variable
--https://www.warcraftlogs.com/reports/rHwKLVfXPQCYBcvW#fight=3&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id+%3D+157060+or+ability.id+%3D+158217)+and+type+%3D+%22begincast%22+or+ability.id+%3D+173917+and+type+%3D+%22applybuff%22
--https://www.warcraftlogs.com/reports/W3Z9mzCvYADkfyG6#fight=27&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id+%3D+157060+or+ability.id+%3D+158217)+and+type+%3D+%22begincast%22+or+ability.id+%3D+173917+and+type+%3D+%22applybuff%22
--https://www.warcraftlogs.com/reports/kvpLjynmPgNMFJtB#fight=13&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id+%3D+157060+or+ability.id+%3D+158217)+and+type+%3D+%22begincast%22+or+ability.id+%3D+173917+and+type+%3D+%22applybuff%22+
--https://www.warcraftlogs.com/reports/dPLkxbZpCQj7R3D2#fight=8&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id+%3D+157060+or+ability.id+%3D+158217)+and+type+%3D+%22begincast%22+or+ability.id+%3D+173917+and+type+%3D+%22applybuff%22
--https://www.warcraftlogs.com/reports/tyV24fQzhNnKjbDk#pins=2%24Off%24%23244F4B%24expression%24+(ability.id+%3D+157060+or+ability.id+%3D+158217)+and+type+%3D+%22begincast%22+or+ability.id+%3D+173917+and+type+%3D+%22applybuff%22&view=events&fight=6
--Even more variations I don't have off hand. Basically because the cds are variable, and the two abilities delay eachother, it's a roulette and toss up what the fuck is even gonna happen from pull to pull.
--I still hold I at least try to get a lot closer than BW does which has even more wrong timers. However, it's IMPOSSIBLE to ever get them correct without the damn wow source code
local warnCrushingEarth				= mod:NewTargetAnnounce(161923, 3, nil, false)--Players who failed to move. Off by default since announcing failures is not something DBM generally does by default. Can't announce pre cast unfortunately. No detection
local warnStoneGeyser				= mod:NewSpellAnnounce(158130, 2)
local warnWarpedArmor				= mod:NewStackAnnounce(156766, 2, nil, "Tank")
local warnFrenzy					= mod:NewSpellAnnounce(156861, 3)

local specWarnGraspingEarth			= mod:NewSpecialWarningMoveTo(157060, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(157060), nil, nil, 2)
local specWarnThunderingBlows		= mod:NewSpecialWarningSpell(157054, nil, nil, nil, 3)
local specWarnRipplingSmash			= mod:NewSpecialWarningDodge(157592, nil, nil, nil, 2, 2)
local specWarnStoneBreath			= mod:NewSpecialWarningCount(156852, nil, nil, nil, 2, 2)
local specWarnSlam					= mod:NewSpecialWarningSpell(156704, "Tank")
local specWarnWarpedArmor			= mod:NewSpecialWarningStack(156766, nil, 2)
local specWarnWarpedArmorOther		= mod:NewSpecialWarningTaunt(156766)
local specWarnTremblingEarth		= mod:NewSpecialWarningCount(173917, nil, nil, nil, 2)
local specWarnCalloftheMountain		= mod:NewSpecialWarningCount(158217, nil, nil, nil, 3, 2)

local timerGraspingEarthCD			= mod:NewCDTimer(114, 157060, nil, nil, nil, 6)--Unless see new logs on normal showing it can still be 111, raising to 115, average i saw was 116-119
local timerThunderingBlowsCD		= mod:NewNextTimer(12, 157054, nil, nil, nil, 2)
local timerRipplingSmashCD			= mod:NewCDTimer(21, 157592, nil, nil, nil, 3)--If it comes off CD early enough into ThunderingBlows/Grasping Earth, he skips a cast. Else, he'll cast it very soon after.
local timerStoneBreathCD			= mod:NewCDCountTimer(22, 156852, nil, nil, nil, 2)
local timerSlamCD					= mod:NewCDTimer(23, 156704, nil, "Tank", nil, 5)
local timerWarpedArmorCD			= mod:NewCDTimer(14, 156766, nil, "Tank", nil, 5)
local timerTremblingEarthCD			= mod:NewCDTimer(153.5, 173917, nil, nil, nil, 6)
local timerTremblingEarth			= mod:NewBuffActiveTimer(25, 173917, nil, nil, nil, 6)
local timerCalloftheMountain		= mod:NewCastTimer(5, 158217)

local berserkTimer					= mod:NewBerserkTimer(540)

local countdownThunderingBlows		= mod:NewCountdown(12, 157054)
local countdownTremblingEarth		= mod:NewCountdownFades("Alt25", 173917)

local voiceGraspingEarth 			= mod:NewVoice(157060)--157060, safenow
local voiceCallofMountain			= mod:NewVoice(158217)--Findshelter
local voiceRipplingSmash			= mod:NewVoice(157592)
local voiceStoneBreath	 			= mod:NewVoice(156852)

mod:AddArrowOption("RuneArrow", 157060, false, 3)--Off by default, because hud does a much better job, and in case user is running both Exorsus Raid Tools and DBM (ExRT has it's own arrow)
mod:AddHudMapOption("HudMapForRune", 157060)--TODO, maybe custom option text explaining that this option only works if RL is running Exorsus Raid Tools and sends you assigned rune location

mod.vb.mountainCast = 0
mod.vb.stoneBreath = 0
mod.vb.tremblingCast = 0
mod.vb.frenzied = false
local playerX, playerY = nil, nil

--Not local functions, so they can also be used as a test functions as well
function mod:RuneStart()
	if playerX and playerY then
		if self.Options.RuneArrow then
			DBM.Arrow:ShowRunTo(playerX, playerY, 0)
		end
		if self.Options.HudMapForRune then
			DBMHudMap:RegisterPositionMarker(157060, "HudMapForRune", "highlight", playerX, playerY, 3, 20, 0, 1, 0, 0.5, nil, 4):Pulse(0.5, 0.5)
		end
	end
end

function mod:RuneOver()
	if self.Options.RuneArrow then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapForRune then
		DBMHudMap:Disable()
	end
end

function mod:OnCombatStart(delay)
	self.vb.mountainCast = 0
	self.vb.stoneBreath = 0
	self.vb.frenzied = false
	timerStoneBreathCD:Start(8-delay, 1)--8-10
	timerWarpedArmorCD:Start(15-delay)
	timerSlamCD:Start(14.5-delay)--first can be 14.5-26. Most of time it's 18-20
	timerRipplingSmashCD:Start(23.5-delay)
	timerGraspingEarthCD:Start(50-delay)--50-61 variable
	berserkTimer:Start(-delay)
	if self:IsMythic() then
		--Confirmed multiple pulls, ability IS 61 seconds after engage, but 9 times out of 10, delayed by the 50-61 variable cd that's on grasping earth, thus why it APPEARS to have 84-101 second timer most of time.
		timerTremblingEarthCD:Start(61-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.RuneArrow then
		DBM.Arrow:Hide()
	end
	if self.Options.HudMapForRune then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 157060 then
		specWarnGraspingEarth:Show(RUNES)
		timerStoneBreathCD:Cancel()
		if self:IsLFR() then
			timerThunderingBlowsCD:Start(20.5)
			countdownThunderingBlows:Start(20.5)
			timerStoneBreathCD:Start(28, self.vb.stoneBreath+1)
		else
			timerThunderingBlowsCD:Start()
			countdownThunderingBlows:Start()
			timerStoneBreathCD:Start(31, self.vb.stoneBreath+1)--Verified it happens on mythic, if rune of trembling earth doesn't come first
		end
		timerSlamCD:Cancel()
		timerRipplingSmashCD:Cancel()
		timerWarpedArmorCD:Cancel()
		voiceGraspingEarth:Play("157060")
		self:RuneStart()
		if self:IsMythic() then
			timerGraspingEarthCD:Start(66)
			local remaining = timerTremblingEarthCD:GetRemaining()
			if remaining < 32 then
				DBM:Debug("Trembling earth CD extended by Grasping Earth")
				timerTremblingEarthCD:Cancel()
				timerTremblingEarthCD:Start(32)
			end
		else
			timerGraspingEarthCD:Start()
			timerRipplingSmashCD:Start(35)
		end
	elseif spellId == 157054 then
		specWarnThunderingBlows:Show()
		--Hide rune arrow and hud at this point, if thundering is being cast, runes vanished
		self:RuneOver()
		--Starting timers for slam and rippling seem useless, 10-30 sec variation for first ones.
		--after that they get back into their consistency
	elseif spellId == 157592 then
		specWarnRipplingSmash:Show()
		if self.vb.frenzied then
			timerRipplingSmashCD:Start(18.2)
		else
			timerRipplingSmashCD:Start()
		end
		voiceRipplingSmash:Play("shockwave")
	elseif spellId == 156704 then
		specWarnSlam:Show()
		timerSlamCD:Start()
	elseif spellId == 158217 then--Probably not in combat log, it's scripted. Probably needs a UNIT_SPELLCAST event
		self.vb.mountainCast = self.vb.mountainCast + 1
		specWarnCalloftheMountain:Show(self.vb.mountainCast)
		timerCalloftheMountain:Start()
		voiceCallofMountain:Play("findshelter")
		if self.vb.mountainCast == 3 then--Start timers for resume normal phase
			timerStoneBreathCD:Start(8.7, self.vb.stoneBreath+1)--Or 12
			timerWarpedArmorCD:Start(12.2)--12.2-17
			--First slam and first rippling still too variable to start here.
			--after that they get back into their consistency
			--Rippling smash is WILDLY variable on mythic, to point that any timer for it is completely useless
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 158130 or spellId == 170469 then--Are both used? eliminate one that isn't if not
		warnStoneGeyser:Show()
		--Does it need a special warning?
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156766 then
		local amount = args.amount or 1
		if self.vb.frenzied then
			timerWarpedArmorCD:Start(10.2)
		else
			timerWarpedArmorCD:Start()
		end
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnWarpedArmor:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
					specWarnWarpedArmorOther:Show(args.destName)
				else
					warnWarpedArmor:Show(args.destName, amount)
				end
			end
		else
			warnWarpedArmor:Show(args.destName, amount)
		end
	elseif spellId == 161923 then
		warnCrushingEarth:CombinedShow(0.5, args.destName)
	elseif spellId == 173917 then
		self.vb.mountainCast = 0
		self.vb.tremblingCast = self.vb.tremblingCast + 1
		specWarnTremblingEarth:Show(self.vb.tremblingCast)
		timerTremblingEarth:Start()
		countdownTremblingEarth:Start()
		timerSlamCD:Cancel()
		timerRipplingSmashCD:Cancel()
		timerWarpedArmorCD:Cancel()
		timerStoneBreathCD:Cancel()
		timerTremblingEarthCD:Schedule(25)
		local remaining = timerGraspingEarthCD:GetRemaining()
		if remaining < 50 then--Will come off cd during mythic phase, update timer because mythic phase is coded to prevent this from happening and will push ability to about 12-17 seconds after mythic phase ended
			DBM:Debug("Grasping earth CD extended by Trembling Earth")
			timerGraspingEarthCD:Cancel()--Prevent timer debug from complaining
			timerGraspingEarthCD:Start(62)
		end
	elseif spellId == 156852 then
		self.vb.stoneBreath = self.vb.stoneBreath + 1
		specWarnStoneBreath:Show(self.vb.stoneBreath)
		timerStoneBreathCD:Start(nil, self.vb.stoneBreath+1)
		voiceStoneBreath:Play("breathsoon")
	elseif spellId == 157059 and args:IsPlayer() then
		voiceGraspingEarth:Play("safenow")
		self:RuneOver()
	elseif spellId == 156861 then
		self.vb.frenzied = true
		warnFrenzy:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

do
	--Exorsus Raid Tools Comm snooping to detect player assignment even if player isn't running Exorsus Raid Tools.
	--Runes locations are from ExRT and not 100% vetted accurate.
	local runes = {
		[1] = {3673.47,329.81},
		[2] = {3669.83,320.84},
		[3] = {3667.69,309.80},
		[4] = {3663.56,334.03},
		[5] = {3661.87,325.15},
		[6] = {3660.95,315.54},
		[7] = {3659.29,303.60},
		[8] = {3652.30,324.41},
		[9] = {3650.33,315.57},
		[10] = {3649.88,332.94},
		[11] = {3649.72,306.76},
		[12] = {3642.71,324.18},
		[13] = {3641.32,315.93},
		[14] = {3640.92,308.55},
		[15] = {3636.36,331.65},
		[16] = {3633.00,304.03},
		[17] = {3632.95,317.41},
		[18] = {3631.94,310.38},
		[19] = {3630.81,325.00},
		[20] = {3624.18,317.63},
		[21] = {3623.51,306.16},
		[22] = {3623.30,330.92},
		[23] = {3617.37,312.64},
		[24] = {3615.52,323.41},
		[25] = {3612.18,306.78},
		[26] = {3611.77,333.36},
		[27] = {3605.63,318.56},
		[28] = {3604.92,328.65},
		[29] = {3603.65,308.19},
		[30] = {3597.34,336.12},
		[31] = {3596.64,325.87},
		[32] = {3594.69,315.58},
		[33] = {3594.69,306.78},--Added manually
		[34] = {3587.57,323.10},
		[35] = {3587.45,333.16},
	}	
	RegisterAddonMessagePrefix("EXRTADD")
	local playerName = UnitName("player")
	local Ambiguate = Ambiguate
	local assignedPosition
	local lastPosition = nil
	function mod:CHAT_MSG_ADDON(prefix, message, channel, sender)
		if prefix ~= "EXRTADD" then return end
		local subPrefix,pos1,name1,pos2,name2,pos3,name3 = strsplit("\t", message)
		if subPrefix ~= "kromog" then return end
		sender = Ambiguate(sender, "none")
		if DBM:GetRaidRank(sender) == 0 and IsInGroup() then return end
		DBM:Debug("Sender: "..sender.."Pos1: "..pos1..", Name1: "..(name1 or "nil")..", Pos2: "..pos2..", Name2: "..(name2 or "nil")..", Pos3: "..pos3..", Name3: "..(name3 or "nil"), 3)
		--Check if player removed from a cached assignment
		local positionUpdate = false
		if assignedPosition and pos1 and tonumber(pos1) == assignedPosition and name1 ~= playerName then
			assignedPosition, playerX, playerY = nil, nil, nil
			DBM:Debug("Player is no longer asisgned to position "..pos1)
			lastPosition = nil
			positionUpdate = true
		end
		if assignedPosition and pos2 and tonumber(pos2) == assignedPosition and name2 ~= playerName then
			assignedPosition, playerX, playerY = nil, nil, nil
			DBM:Debug("Player is no longer asisgned to position "..pos2)
			lastPosition = nil
			positionUpdate = true
		end
		if assignedPosition and pos3 and tonumber(pos3) == assignedPosition and name3 ~= playerName then
			assignedPosition, playerX, playerY = nil, nil, nil
			DBM:Debug("Player is no longer asisgned to position "..pos3)
			lastPosition = nil
			positionUpdate = true
		end
		--Now the add player assignment code
		if name1 and Ambiguate(name1, "none") == playerName then
			assignedPosition = tonumber(pos1)
			playerX = runes[assignedPosition][2]
			playerY = runes[assignedPosition][1]
			DBM:Debug("Player is assigned to position "..assignedPosition..": "..playerX..", "..playerY, 2)
			if not lastPosition or lastPosition and lastPosition ~= assignedPosition then
				lastPosition = assignedPosition
				positionUpdate = true
			end
		end
		if name2 and Ambiguate(name2, "none") == playerName then
			assignedPosition = tonumber(pos2)
			playerX = runes[assignedPosition][2]
			playerY = runes[assignedPosition][1]
			DBM:Debug("Player is assigned to position "..assignedPosition..": "..playerX..", "..playerY, 2)
			if not lastPosition or lastPosition and lastPosition ~= assignedPosition then
				lastPosition = assignedPosition
				positionUpdate = true
			end
		end
		if name3 and Ambiguate(name3, "none") == playerName then
			assignedPosition = tonumber(pos3)
			playerX = runes[assignedPosition][2]
			playerY = runes[assignedPosition][1]
			DBM:Debug("Player is assigned to position "..assignedPosition..": "..playerX..", "..playerY, 2)
			if not lastPosition or lastPosition and lastPosition ~= assignedPosition then
				lastPosition = assignedPosition
				positionUpdate = true
			end
		end
		if positionUpdate then
			DBM:AddMsg(L.ExRTNotice:format(sender, (lastPosition or NONE)))
		end
	end
end
