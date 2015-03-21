local mod	= DBM:NewMod(1147, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76906)--81315 Crack-Shot, 81197 Raider, 77487 Grom'kar Firemender, 80791 Grom'kar Man-at-Arms, 81318 Iron Gunnery Sergeant, 77560 Obliterator Cannon, 81612 Deforester
mod:SetEncounterID(1692)
mod:SetZone()
mod:SetUsedIcons(8, 7, 2, 1)
mod:SetHotfixNoticeRev(12936)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 160140 163753 159481",
	"SPELL_CAST_SUCCESS 155864 159481",
	"SPELL_AURA_APPLIED 155921 165195 164380 160140",
	"SPELL_AURA_APPLIED_DOSE 155921 164380",
	"SPELL_AURA_REFRESH 155921",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL"
)

--Operator Thogar
local warnProtoGrenade				= mod:NewTargetAnnounce(155864, 3)
local warnEnkindle					= mod:NewStackAnnounce(155921, 2, nil, "Tank")
local warnTrain						= mod:NewTargetCountAnnounce(176312, 4)
--Adds
local warnDelayedSiegeBomb			= mod:NewTargetAnnounce(159481, 3)

--Operator Thogar
local specWarnProtoGrenade			= mod:NewSpecialWarningMove(165195, nil, nil, nil, nil, nil, 2)
local specWarnProtoGrenadeNear		= mod:NewSpecialWarningClose(165195)
local yellProtoGrenade				= mod:NewYell(165195)
local specWarnEnkindle				= mod:NewSpecialWarningStack(155921, nil, 2)--Maybe need 3 for new cd?
local specWarnEnkindleOther			= mod:NewSpecialWarningTaunt(155921)
local specWarnTrain					= mod:NewSpecialWarningDodge(176312, nil, nil, nil, 3)
local specWarnSplitSoon				= mod:NewSpecialWarning("specWarnSplitSoon")--TODO, maybe include types in the split?
--Adds
local specWarnCauterizingBolt		= mod:NewSpecialWarningInterrupt("OptionVersion2", 160140, "-Healer")
local specWarnCauterizingBoltDispel	= mod:NewSpecialWarningDispel(160140, "MagicDispeller")
local specWarnIronbellow			= mod:NewSpecialWarningSpell(163753, nil, nil, nil, 2)
local specWarnDelayedSiegeBomb		= mod:NewSpecialWarningYou(159481, nil, nil, nil, nil, nil, 2)
local specWarnDelayedSiegeBombMove	= mod:NewSpecialWarningMove(159481)
local yellDelayedSiegeBomb			= mod:NewCountYell(159481)
local specWarnManOArms				= mod:NewSpecialWarningSwitch("ej9549", "-Healer")
local specWarnBurning				= mod:NewSpecialWarningStack(164380, nil, 2)--Mythic

--Operator Thogar
local timerProtoGrenadeCD			= mod:NewCDTimer(11, 155864)
local timerEnkindleCD				= mod:NewCDTimer(12, 155921, nil, "Tank")
local timerTrainCD					= mod:NewNextCountTimer("d15", 176312)
--Adds
--local timerCauterizingBoltCD		= mod:NewNextTimer(30, 160140)
local timerIronbellowCD				= mod:NewCDTimer(8.5, 163753)
local timerDelayedSiegeBomb			= mod:NewNextCountTimer(6, 159481)

local berserkTimer					= mod:NewBerserkTimer(492)

local countdownTrain				= mod:NewCountdown(4.5, 176312)

local voiceTrain					= mod:NewVoice(176312) --see mythicVoice{} otherVoice{} tables for more details
local voiceProtoGrenade				= mod:NewVoice(165195) --runaway
local voiceDelayedSiegeBomb			= mod:NewVoice(159481)

mod:AddInfoFrameOption(176312)
mod:AddSetIconOption("SetIconOnAdds", "ej9549", false, true)
mod:AddHudMapOption("HudMapForTrain", 176312, false)
mod:AddDropdownOption("InfoFrameSpeed", {"Immediately", "Delayed"}, "Delayed", "misc")

mod.vb.trainCount = 0
mod.vb.infoCount = 0
local GetTime, UnitPosition = GetTime, UnitPosition
local UnitDebuff = UnitDebuff
local MovingTrain = GetSpellInfo(176312)
local Train = GetSpellInfo(174806)
local Cannon = GetSpellInfo(62357)
local Reinforcements = EJ_GetSectionInfo(9537)
local ManOArms = EJ_GetSectionInfo(9549)
local Deforester = EJ_GetSectionInfo(10329)
local fakeYellTime = 0
local bombFrom = nil

--Note, all trains spawn 5 second after yell for that train
--this means that for 5 second cd trains you may see a yell for NEXT train as previous train is showing up. Do not confuse this!
--Also be aware that older beta videos are wrong, blizz has changed train orders few times, so don't try to fill in missing data by putting "thogar" into youtube unless it's a RECENT LIVE video.

local mythicTrains = {
	[1] = { [4] = ManOArms },--+7 after pull.(00:07)
	[2] = { [1] = Deforester },--+5 after 1.(00:12)
	[3] = { [2] = Train },--+5 after 2.(00:17)
	[4] = { [3] = Train },--+15 after 3.(00:32)
	[5] = { ["specialw"] = L.threeTrains, ["speciali"] = L.threeRandom, [1] = Train, [2] = Train, [3] = Train, [4] = Train },--+20 after 4.(00:52)
	[6] = { ["specialw"] = L.threeTrains, ["speciali"] = L.threeRandom, [1] = Train, [2] = Train, [3] = Train, [4] = Train },--+15 after 5.(01:07)
	[7] = { [1] = Cannon, [4] = Cannon },--+10 after 6.(01:17)
	[8] = { [2] = Train },--+15 after 7.(01:32)
	[9] = { [3] = Train },--+15 after 8.(01:47)
	[10] = { [2] = Reinforcements, [3] = Reinforcements },--+35 after 9.(02:22) Split
	[11] = { [1] = Train, [4] = Train },--+25 after 10.(02:47)
	[12] = { [4] = Deforester },--+5 after 11.(02:52)
	[13] = { [1] = Deforester },--+5 after 12.(02:57)
	[14] = { [3] = Train },--+5 after 13.(03:02)
	[15] = { [2] = Train, [3] = Train },--+10(or +11?) after 14.(03:12)
	[16] = { ["specialw"] = L.threeTrains, ["speciali"] = L.threeRandom, [1] = Train, [2] = Train, [3] = Train, [4] = Train },--+20(or +19) after 15.(03:32)
	[17] = { ["specialw"] = L.threeTrains, ["speciali"] = L.threeRandom, [1] = Train, [2] = Train, [3] = Train, [4] = Train },--+15 after 16.(03:47)
	[18] = { [1] = ManOArms, [4] = Cannon },--+15 after 17.(04:02)
	[19] = { [1] = Deforester, [2] = Train, [3] = Train },--+20 after 18.(04:22)
	[20] = { [2] = Train, [3] = Train },--+20(or +21) after 19.(04:42)
	[21] = { [2] = Reinforcements, [3] = ManOArms },--+15 after 20.(04:57) Split
	[22] = { [1] = Train, [4] = Train },--+20 after 21.(05:17)
	[23] = { [2] = Train, [3] = Train },--+10 after 22.(05:27)
	[24] = { ["specialw"] = L.threeTrains, ["speciali"] = L.threeRandom, [1] = Train, [2] = Train, [3] = Train, [4] = Train },--+15 after 23.(05:42)
	[25] = { ["specialw"] = L.threeTrains, ["speciali"] = L.threeRandom, [1] = Train, [2] = Train, [3] = Train, [4] = Train },--+15 after 24.(05:57)
	[26] = { [4] = Reinforcements },--+5 after 25.(06:02)
	[27] = { [1] = Cannon },--+5 after 26.(06:07)
	[28] = { [2] = Deforester, [3] = Deforester },--+20 after 27.(06:27)
	[29] = { [1] = Train, [4] = Train },--+20 after 28.(06:47) (1 train is guessed)
	[30] = { [1] = Reinforcements, [4] = Deforester },--+15 after 29.(07:02)
	[31] = { [2] = Train },--+10 after 30.(07:12)
	[32] = { [3] = Deforester },--+5 after 31.(07:17)
	[33] = { [2] = Train },--+10 after 32.(07:27)
	[34] = { [1] = ManOArms },--+15 after 33.(07:42)
	[35] = { ["specialw"] = L.threeTrains, ["speciali"] = L.threeRandom, [1] = Train, [2] = Train, [3] = Train, [4] = Train },--+10 after 34.(07:52)
	[36] = { [1] = Train, [2] = Train, [3] = Train, [4] = Train },--+15 after 35.(08:07)--berserk.
}

local otherTrains = {
	[1] = { [4] = Train },--+12 after pull (0:12)
	[2] = { [2] = Train },--+10 after 1 (0:22)
	[3] = { [1] = Reinforcements },--+5 after 2 (0:27)
	[4] = { [3] = Train },--+15 after 3 (0:42)
	[5] = { [4] = Cannon },--+5 after 4 (0:47)
	[6] = { [2] = Train },--+25 after 5 (1:12)
	[7] = { [3] = ManOArms },--+5 after 6 (1:17)
	[8] = { [1] = Train },--+25 after 7 (1:42)
	[9] = { [2] = Reinforcements, [3] = Reinforcements },--+15 after 8 (1:57) Split
	[10] = { [1] = Train, [4] = Train },--+40 after 9 (2:37)
	[11] = { [1] = Cannon },--+10 after 10 (2:47)
	[12] = { [2] = Train },--+15 after 11 (3:02)
	[13] = { [4] = Reinforcements },--+10 after 12 (3:12)
	[14] = { [3] = Train },--+20 after 13 (3:32)
	[15] = { [2] = Train },--+10 after 14 (3:42)
	[16] = { [1] = Train },--+10 after 15 (3:52)
	[17] = { [2] = ManOArms, [4] = Cannon },--+15 after 16 (4:07)
	[18] = { [1] = Train },--+20 after 17 (4:27)
	[19] = { [3] = Train },--+5 after 18 (4:32)
	[20] = { [1] = Cannon, [4] = Cannon },--+30 after 19 (5:02)
	[21] = { [2] = Train },--+10 after 20 (5:12)
	[22] = { [2] = Train },--+25 after 21 (5:37)
	[23] = { [2] = Reinforcements, [3] = ManOArms },--+30 after 22 (6:07) Split
	[24] = { ["specialw"] = L.oneTrain, ["speciali"] = L.oneRandom, [2] = Train, [4] = Train },--+15 after 23? (6:22). Lane 4, but if reinforcements aren't dead from wave 23, lane 2 (because reinforcements cart still blocking lane 4) Not Actually random. But detecting if reinforcement cart still in way impossible :\
	[25] = { [1] = Train },--+20 after 24 (6:42)
	[26] = { [1] = Cannon, [4] = Reinforcements },--+10 after 25 (6:52)
	[27] = { [2] = Train },--+15 after 26 (7:07)
	[28] = { [3] = Train },--+10 after 27 (7:17)
	[29] = { [3] = ManOArms },--+20 after 28 (7:37)
	[30] = { [1] = Train, [4] = Train },--+5 after 29 (7:42) 
	[31] = { [4] = Train },--+15 after 30 (7:57) (guessed.)--seems berserk. 4 trains in a row (interval 4 sec.)
	[32] = { [3] = Train },--+4 after 31 (8:01)
	[33] = { [2] = Train },--+4 after 32 (8:05)
	[34] = { [1] = Train },--+4 after 33 (8:09)
	[35] = { [1] = Train, [2] = Train, [3] = Train, [4] = Train },--+? after 34 (8:??)
}

--Kind of sucks having an entirely new table for 2 changes, but whatever.
local lfrTrains = {
	[1] = { [4] = Train },--+12 after pull (0:12)
	[2] = { [2] = Train },--+10 after 1 (0:22)
	[3] = { [1] = Reinforcements },--+5 after 2 (0:27)
	[4] = { [3] = Train },--+15 after 3 (0:42)
	[5] = { [4] = Cannon },--+5 after 4 (0:47)
	[6] = { [2] = Train },--+25 after 5 (1:12)
	[7] = { [3] = ManOArms },--+5 after 6 (1:17)
	[8] = { [1] = Train },--+25 after 7 (1:42)
	[9] = { [3] = Reinforcements },--+15 after 8 (1:57) Just one train in LFR
	[10] = { [1] = Train, [4] = Train },--+40 after 9 (2:37)
	[11] = { [1] = Cannon },--+10 after 10 (2:47)
	[12] = { [2] = Train },--+15 after 11 (3:02)
	[13] = { [4] = Reinforcements },--+10 after 12 (3:12)
	[14] = { [3] = Train },--+20 after 13 (3:32)
	[15] = { [2] = Train },--+10 after 14 (3:42)
	[16] = { [1] = Train },--+10 after 15 (3:52)
	[17] = { [2] = ManOArms, [4] = Cannon },--+15 after 16 (4:07)
	[18] = { [1] = Train },--+20 after 17 (4:27)
	[19] = { [3] = Train },--+5 after 18 (4:32)
	[20] = { [1] = Cannon, [4] = Cannon },--+30 after 19 (5:02)
	[21] = { [2] = Train },--+10 after 20 (5:12)
	[22] = { [2] = Train },--+25 after 21 (5:37)
	--FIXME
	[23] = { [2] = Reinforcements, [3] = ManOArms },--+30 after 22 (6:07) Also not a split, but don't know what's changed
	--FIXME
	[24] = { ["specialw"] = L.oneTrain, ["speciali"] = L.oneRandom, [2] = Train, [4] = Train },--+15 after 23? (6:22). Lane 4, but if reinforcements aren't dead from wave 23, lane 2 (because reinforcements cart still blocking lane 4) Not Actually random. But detecting if reinforcement cart still in way impossible :\
	[25] = { [1] = Train },--+20 after 24 (6:42)
	[26] = { [1] = Cannon, [4] = Reinforcements },--+10 after 25 (6:52)
	[27] = { [2] = Train },--+15 after 26 (7:07)
	[28] = { [3] = Train },--+10 after 27 (7:17)
	[29] = { [3] = ManOArms },--+20 after 28 (7:37)
	[30] = { [1] = Train, [4] = Train },--+5 after 29 (7:42) 
	[31] = { [4] = Train },--+15 after 30 (7:57) (guessed.)--seems berserk. 4 trains in a row (interval 4 sec.)
	[32] = { [3] = Train },--+4 after 31 (8:01)
	[33] = { [2] = Train },--+4 after 32 (8:05)
	[34] = { [1] = Train },--+4 after 33 (8:09)
	[35] = { [1] = Train, [2] = Train, [3] = Train, [4] = Train },--+? after 34 (8:??)
}

local function fakeTrainYell(self)
	self:CHAT_MSG_MONSTER_YELL("Fake", nil, nil, nil, L.Train)
	DBM:Debug("Fake yell fired, Boss skipped a yell?")
end

--  Voicelist
--	A: just rushing through the lane(express)
--	B: small Adds(Reinforcements)
--	C: cannon
--	D: big Adds (ManOArms)
--	E: fire(Deforester) 
--	F: random express (3x trainType A)
--	X: random rail

local mythicVoice = {
	[1] = "D4",
	[2] = "E1",
	[3] = "A2",
	[4] = "A3",
	[5] = "F",
	[6] = "F",
	[7] = "C14",
	[8] = "A2",
	[9] = "A3",
	[10] = "B23",
	[11] = "A14",
	[12] = "E4",
	[13] = "E1",
	[14] = "A3",
	[15] = "A23",
	[16] = "F",
	[17] = "F",
	[18] = "D1C4",
	[19] = "E1A23",
	[20] = "A23",
	[21] = "B2D3",
	[22] = "A14",
	[23] = "A23",
	[24] = "F",
	[25] = "F",
	[26] = "B4",
	[27] = "C1",
	[28] = "E23",
	[29] = "A14",
	[30] = "B1E4",
	[31] = "A2",
	[32] = "E3",
	[33] = "A2",
	[34] = "D1",
	[35] = "F",
}

local otherVoice = {
	[1] = "A4",
	[2] = "A2",
	[3] = "B1",
	[4] = "A3",
	[5] = "C4",
	[6] = "A2",
	[7] = "D3",
	[8] = "A1",
	[9] = "B23",
	[10] = "A14",
	[11] = "C1",
	[12] = "A2",
	[13] = "B4",
	[14] = "A3",
	[15] = "A2",
	[16] = "A1",
	[17] = "D2C4",
	[18] = "A1",
	[19] = "A3",
	[20] = "C14",
	[21] = "A2",
	[22] = "A2",
	[23] = "B2D3",
	[24] = "AX",
	[25] = "A1",
	[26] = "C1D4",--Don't worry, B14 will be used on mythic i'm sure. sorry about this messup
	[27] = "A2",
	[28] = "A3",
	[29] = "D3",
	[30] = "A14",
	[31] = "A4",
	[32] = "A3",
	[33] = "A2",
	[34] = "A1",
}

local lfrVoice = {
	[1] = "A4",
	[2] = "A2",
	[3] = "B1",
	[4] = "A3",
	[5] = "C4",
	[6] = "A2",
	[7] = "D3",
	[8] = "A1",
	[9] = "B3",
	[10] = "A14",
	[11] = "C1",
	[12] = "A2",
	[13] = "B4",
	[14] = "A3",
	[15] = "A2",
	[16] = "A1",
	[17] = "D2C4",
	[18] = "A1",
	[19] = "A3",
	[20] = "C14",
	[21] = "A2",
	[22] = "A2",
	[23] = "B2D3",
	[24] = "AX",
	[25] = "A1",
	[26] = "C1D4",--Don't worry, B14 will be used on mythic i'm sure. sorry about this messup
	[27] = "A2",
	[28] = "A3",
	[29] = "D3",
	[30] = "A14",
	[31] = "A4",
	[32] = "A3",
	[33] = "A2",
	[34] = "A1",
}

local function showTrainWarning(self)
	local text = ""
	local textTable = {}
	local usedv = {}
	local train = self.vb.trainCount
	local trainTable = self:IsMythic() and mythicTrains or self:IsLFR() and lfrTrains or otherTrains
	if trainTable[train] then
		if trainTable[train]["specialw"] then
			text = text .. trainTable[train]["specialw"]..", "
		else
			for i = 1, 4 do
				if trainTable[train][i] then
					if not usedv[trainTable[train][i]] then
						usedv[trainTable[train][i]] = #textTable + 1
						local t = { vehicle = trainTable[train][i], lane = L.lane.." "..i }
						table.insert(textTable, t)
					else
						local t = textTable[usedv[trainTable[train][i]]]
						t.lane = t.lane..", "..i
					end
				end
			end
		end
	end
	for i = 1, #textTable do
		local t = textTable[i]
		text = text..t.lane..": "..t.vehicle..", "
	end
	text = string.sub(text, 1, text:len() - 2)
	text = "noStrip |cffffff9a"..text.."|r"
	warnTrain:Show(train, text)
end

local function lanePos()
	local posX = UnitPosition("player")--room is perfrect square, y coord not needed.
	local playerLane
	-- map coord from http://mysticalos.com/images/DBM/ThogarData/1.jpeg http://mysticalos.com/images/DBM/ThogarData/2.jpeg http://mysticalos.com/images/DBM/ThogarData/3.jpeg http://mysticalos.com/images/DBM/ThogarData/4.jpeg
	if posX > 577.8 then
		playerLane = 1
	elseif posX > 553.8 then
		playerLane = 2
	elseif posX > 529.6 then
		playerLane = 3
	else
		playerLane = 4
	end
	return playerLane
end

local function laneCheck(self)
	local trainTable = self:IsMythic() and mythicTrains or self:IsLFR() and lfrTrains or otherTrains
	local train = self.vb.trainCount
	local playerLane = lanePos()
	if trainTable[train] and trainTable[train][playerLane] then
		specWarnTrain:Show()
	end
end

local lines = {}

local function sortInfoFrame(a, b)
	local rexp = L.lane.." ".."%d"
	local c = string.match(a, rexp)
	local d = string.match(b, rexp)
	if c and not d then
		return true
	elseif not c and d then
		return false
	elseif c and d and c < d then 
		return true
	else
		return false
	end
end

local function updateInfoFrame()
	table.wipe(lines)
	local train = mod.vb.infoCount
	local trainTable = mod:IsMythic() and mythicTrains or mod:IsLFR() and lfrTrains or otherTrains
	if trainTable[train] then
		local playerLane = lanePos()
		for i = 1, 4 do
			local lanetext = (playerLane == i and "|cff00ffff" or "")..L.lane.." "..i..(playerLane == i and "|r" or "")
			if trainTable[train][i] then
				lines[lanetext] = trainTable[train][i]
			else
				lines[lanetext] = ""
			end
		end
		if trainTable[train]["speciali"] then
			lines[trainTable[train]["speciali"]] = ""
		end
	else
		lines[DBM_CORE_UNKNOWN] = ""
	end
	return lines
end

--Work In Progress
--Timing may need tweaks. more Moves need adding.
--Positions based on https://www.youtube.com/watch?v=0QC7BOEv2iE
local function showHud(self, train)
	if self.Options.HudMapForTrain then
		if train == 1 or train == 15 or train == 28.5 then--Move to triangle
			DBMHudMap:RegisterPositionMarker(176312, "TrainHelper", "triangle", 544, 3316, 3, 7, 1, 1, 1, 0.5):Pulse(0.5, 0.5)
		elseif train == 2 or train == 28 then--Move to Cross
			DBMHudMap:RegisterPositionMarker(176312, "TrainHelper", "cross", 566, 3277, 3, 7, 1, 1, 1, 0.5):Pulse(0.5, 0.5)
		elseif train == 7 or train == 21 or train == 23 or train == 26 then--Move to Triangle
			DBMHudMap:RegisterPositionMarker(176312, "TrainHelper", "triangle", 544, 3316, 3, 7, 1, 1, 1, 0.5):Pulse(0.5, 0.5)
		elseif train == 9 or train == 11 or train == 32 then--Move to diamond
			DBMHudMap:RegisterPositionMarker(176312, "TrainHelper", "diamond", 566, 3332, 3, 7, 1, 1, 1, 0.5):Pulse(0.5, 0.5)
		elseif train == 9.5 then--Move to Circle
			DBMHudMap:RegisterPositionMarker(176312, "TrainHelper", "circle", 590, 3313, 3, 7, 1, 1, 1, 0.5):Pulse(0.5, 0.5)
		elseif train == 14 then--Move to skull
			DBMHudMap:RegisterPositionMarker(176312, "TrainHelper", "skull", 517, 3353, 3, 7, 1, 1, 1, 0.5):Pulse(0.5, 0.5)
		elseif train == 17 then
			if self:IsMelee() then--Move to diamond for man at arms train
				DBMHudMap:RegisterPositionMarker(176312, "TrainHelper", "diamond", 566, 3332, 3, 7, 1, 1, 1, 0.5):Pulse(0.5, 0.5)
			else--Move to triangle for Cannon
				DBMHudMap:RegisterPositionMarker(176312, "TrainHelper", "triangle", 544, 3316, 3, 7, 1, 1, 1, 0.5):Pulse(0.5, 0.5)
			end
		elseif train == 19 then
			DBMHudMap:RegisterPositionMarker(176312, "TrainHelper", "square", 590, 3352, 3, 7, 1, 1, 1, 0.5):Pulse(0.5, 0.5)
		elseif train == 19.5 then----Move to star, also during train count 19, but later
			DBMHudMap:RegisterPositionMarker(176312, "TrainHelper", "star", 590, 3272, 3, 7, 1, 1, 1, 0.5):Pulse(0.5, 0.5)
		elseif train == 20 or train == 22 then--Move to Moon
			DBMHudMap:RegisterPositionMarker(176312, "TrainHelper", "moon", 517, 3280, 3, 7, 1, 1, 1, 0.5):Pulse(0.5, 0.5)
		end
	end
end

local function showInfoFrame(self)
	if self.Options.InfoFrame then
		self.vb.infoCount = self.vb.trainCount + 1
		DBM.InfoFrame:SetHeader(MovingTrain.." ("..(self.vb.infoCount)..")")
		DBM.InfoFrame:Show(5, "function", updateInfoFrame, sortInfoFrame)
	end
end

--/run DBM:GetModByName(1147):test(4)
function mod:test(num)
	self.vb.trainCount = num
	showTrainWarning(self)
	laneCheck(self)
	showInfoFrame(self)
end

function mod:BombTarget(targetname, uId, bossuId)
	if not targetname then return end
	warnDelayedSiegeBomb:CombinedShow(0.5, targetname)
	if targetname == UnitName("player") then
		specWarnDelayedSiegeBomb:Show()
		voiceDelayedSiegeBomb:Play("bombrun")
		local _, _, _, _, startTime, endTime = UnitCastingInfo(bossuId)
		local time = ((endTime or 0) - (startTime or 0)) / 1000
		if time then
			specWarnDelayedSiegeBombMove:Schedule(time - 0.5, 1)
			timerDelayedSiegeBomb:Start(time, 1)
		else
			specWarnDelayedSiegeBombMove:Schedule(4.4, 1)
			timerDelayedSiegeBomb:Start(4.9, 1)
		end
	end
end

function mod:GrenadeTarget(targetname, uId)
	if not targetname or (uId and self:IsTanking(uId, "boss1")) then
		warnProtoGrenade:Show(DBM_CORE_UNKNOWN)
		return
	end
	if targetname == UnitName("player") then
		yellProtoGrenade:Yell()
		if self:AntiSpam(1.5, 5) then
			specWarnProtoGrenade:Show()
			voiceProtoGrenade:Play("runaway")
		end
	elseif self:CheckNearby(5, targetname) then
		specWarnProtoGrenadeNear:Show(targetname)
	else
		warnProtoGrenade:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	fakeYellTime = 0
	bombFrom = nil
	self.vb.trainCount = 0
	self.vb.infoCount = 0
	timerProtoGrenadeCD:Start(6-delay)
	if not self.Options.ShowedThogarMessage then
		DBM:AddMsg(L.helperMessage)
		self.Options.ShowedThogarMessage = true
	end
	if self:IsMythic() then
		self:Schedule(9.5, fakeTrainYell, self)
		timerTrainCD:Start(12-delay, 1)
		berserkTimer:Start()
	else
		self:Schedule(14.5, fakeTrainYell, self)
		timerTrainCD:Start(17-delay, 1)
	end
	showInfoFrame(self)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155864 and self:AntiSpam(2, 4) then
		self:BossTargetScanner(76906, "GrenadeTarget", 0.02, 50, true, nil, nil, nil, true)
		timerProtoGrenadeCD:Start()
	elseif spellId == 159481 and args:IsPlayer() then
		bombFrom = args.sourceGUID
		voiceDelayedSiegeBomb:Play("keepmoving")
		yellDelayedSiegeBomb:Yell(1)
		specWarnDelayedSiegeBombMove:Show()
		timerDelayedSiegeBomb:Start(3, 2)
		yellDelayedSiegeBomb:Schedule(3, 2)
		specWarnDelayedSiegeBombMove:Schedule(2.5)
		timerDelayedSiegeBomb:Schedule(3, 3, 3)
		yellDelayedSiegeBomb:Schedule(6, 3)
		specWarnDelayedSiegeBombMove:Schedule(5.5)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 160140 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnCauterizingBolt:Show(args.sourceName)
	elseif spellId == 163753 then
		if self:AntiSpam(3, 1) then
			specWarnIronbellow:Show()
		end
		timerIronbellowCD:Start(nil, args.sourceGUID)
	elseif spellId == 159481 then
		self:BossTargetScanner(args.sourceGUID, "BombTarget", 0.05, 25)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155921 then
		local amount = args.amount or 1
		warnEnkindle:Show(args.destName, amount)
		timerEnkindleCD:Start()
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnEnkindle:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				local _, _, _, _, _, duration, expires = UnitDebuff("player", args.spellName)
				local debuffTime = 0
				if expires then
					debuffTime = expires - GetTime()
				end
				if debuffTime < 12 and not UnitIsDeadOrGhost("player") then--No debuff, or debuff will expire before next cast.
					specWarnEnkindleOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 165195 and args:IsPlayer() and self:AntiSpam(1.5, 5) then
		specWarnProtoGrenade:Show()
		voiceProtoGrenade:Play("runaway")
	--Applied debuffs, not damage. Damage occurs for 15 seconds even when player moves out of it, but player gains stack of debuff every second standing in fire.
	elseif spellId == 164380 and args:IsPlayer() and self:AntiSpam(2, 3) then
		local amount = args.amount or 1
		if amount >= 2 then
			specWarnBurning:Show(amount)
		end
	elseif spellId == 160140 and (args:GetDestCreatureID() == 80791 or args:GetDestCreatureID() == 77487) then--Mender or Man at arms. Filter the rest
		specWarnCauterizingBoltDispel:CombinedShow(0.3, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 80791 then
		timerIronbellowCD:Cancel(args.destGUID)
	elseif bombFrom and args.destGUID == bombFrom then
		yellDelayedSiegeBomb:Cancel()
		specWarnDelayedSiegeBombMove:Cancel()
		timerDelayedSiegeBomb:Cancel()
		timerDelayedSiegeBomb:Unschedule()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
	local trainLimit = self:IsMythic() and 36 or 35
	if target == L.Train and self.vb.trainCount <= trainLimit then
		local adjusted = (GetTime() - fakeYellTime) < 2-- yell followed by fakeyell within 2 sec. this should realyell of scheduled fakeyell. so do not increase count and only do adjust.
		local fakeAdjust = 0
		self:Unschedule(fakeTrainYell)--Always unschedule
		if not adjusted then--do not adjust visible warn to prevent confusing. (although fakeyell worked early, maximum 3.5 sec. this is no matter. only adjust scheduled things.)
			self.vb.trainCount = self.vb.trainCount + 1
			showTrainWarning(self)
			if msg == "Fake" then
				countdownTrain:Start(3.0)
				laneCheck(self)
				fakeAdjust = 1.5
			else
				countdownTrain:Start()
				self:Schedule(1.5, laneCheck, self)
			end
		end
		self:Unschedule(showInfoFrame)
		local expectedTime
		local count = self.vb.trainCount
		if self:IsMythic() then
			if mythicVoice[count] and not adjusted then
				voiceTrain:Play("Thogar\\"..mythicVoice[count])
			end
			if count == 1 or count == 2 or count == 11 or count == 12 or count == 13 or count == 25 or count == 26 or count == 31 then
				expectedTime = 5
				if count == 1 or count == 11 or count == 26 then
					showHud(self, count)
				elseif count == 2 then
					self:Schedule(14-fakeAdjust, showHud, self, count)
				end
			elseif count == 6 or count == 14 or count == 22 or count == 30 or count == 32 or count == 34 then
				expectedTime = 10
				if count == 14 then
					self:Schedule(10-fakeAdjust, showHud, self, count)
				elseif count == 22 then
					self:Schedule(8-fakeAdjust, showHud, self, count)
				elseif count == 32 then
					self:Schedule(4-fakeAdjust, showHud, self, count)
				end
			elseif count == 3 or count == 5 or count == 7 or count == 8 or count == 16 or count == 17 or count == 20 or count == 23 or count == 24 or count == 29 or count == 33 then
				expectedTime = 15
				if count == 7 then
					showHud(self, count)
				elseif count == 17 or count == 23 then
					self:Schedule(10-fakeAdjust, showHud, self, count)
				elseif count == 20 then
					specWarnSplitSoon:Cancel()
					specWarnSplitSoon:Schedule(5-fakeAdjust)
					self:Schedule(8, showHud, self, count)
				end
			elseif count == 4 or count == 15 or count == 18 or count == 19  or count == 21 or count == 27 or count == 28 then
				expectedTime = 20
				if count == 15 then
					self:Schedule(12-fakeAdjust, showHud, self, count)
				elseif count == 19 then
					showHud(self, count)
					self:Schedule(20, showHud, self, 19.5)
				elseif count == 21 then
					self:Schedule(17, showHud, self, count)
				elseif count == 28 then
					showHud(self, count)
					self:Schedule(19, showHud, self, 28.5)
				end
			elseif count == 10 then
				expectedTime = 25
			elseif count == 9 then
				expectedTime = 35
				specWarnSplitSoon:Cancel()
				specWarnSplitSoon:Schedule(25)--10 is a split, pre warn 10 seconds before 10
				self:Schedule(30-fakeAdjust, showHud, self, 9.5)--hud marker 5 seconds before split. later you move the better the bomb placements.
			end
			if expectedTime then
				if msg == "Fake" then
					fakeYellTime = GetTime()
					expectedTime = expectedTime - 1.5
				end
				self:Schedule(expectedTime + 1.5, fakeTrainYell, self)--Schedule fake yell 1.5 seconds after we should have seen one.
				timerTrainCD:Unschedule(count+1)
				timerTrainCD:Schedule(5, expectedTime, count+1)
			end
			if (count == 1 or count == 18 or count == 21 or count == 34) and not adjusted then
				specWarnManOArms:Show()
				if self.Options.SetIconOnAdds then
					self:ScanForMobs(80791, 0, 8, 2, 0.2, 15)--Man At Arms scanner marking 8 down
					self:ScanForMobs(77487, 1, 1, 2, 0.2, 15)--Fire Mender scanner marking 1 up
				end
			end
		else
			local whatVoice = self:IsLFR() and lfrVoice[count] or otherVoice[count]
			if whatVoice and not adjusted then
				voiceTrain:Play("Thogar\\"..whatVoice)
			end
			if count == 31 or count == 32 or count == 33 then
				expectedTime = 4
			elseif count == 2 or count == 4 or count == 6 or count == 18  or count == 29 then
				expectedTime = 5
			elseif count == 1 or count == 10 or count == 12 or count == 14 or count == 15 or count == 20 or count == 25 or count == 27 then
				expectedTime = 10
			elseif count == 3 or count == 8 or count == 11 or count == 16 or count == 23 or count == 26 or count == 30 then
				expectedTime = 15
				if not self:IsLFR() and count == 8 then
					specWarnSplitSoon:Cancel()
					specWarnSplitSoon:Schedule(5)
				end
			elseif count == 13 or count == 17 or count == 24 or count == 28 then
				expectedTime = 20
			elseif count == 5 or count == 7 or count == 21 then
				expectedTime = 25
			elseif count == 19 or count == 22 then
				expectedTime = 30
				if not self:IsLFR() and count == 22 then
					specWarnSplitSoon:Cancel()
					specWarnSplitSoon:Schedule(20)
				end
			elseif count == 9 then
				expectedTime = 40
			end
			if expectedTime then
				if msg == "Fake" then
					fakeYellTime = GetTime()
					expectedTime = expectedTime - 1.5
				end
				self:Schedule(expectedTime + 1.5, fakeTrainYell, self)--Schedule fake yell 1.5 seconds after we should have seen one.
				timerTrainCD:Unschedule(count+1)
				timerTrainCD:Schedule(5, expectedTime, count+1)
			end
			if (count == 7 or count == 17 or count == 23 or count == 28) and not adjusted then--I'm sure they spawn again sometime later, find that data
				specWarnManOArms:Show()
				if self.Options.SetIconOnAdds then
					self:ScanForMobs(80791, 0, 8, 2, 0.2, 15)--Man At Arms scanner marking 8 down
					self:ScanForMobs(77487, 1, 1, 2, 0.2, 15)--Fire Mender scanner marking 1 up
				end
			end
		end
		if self.Options.InfoFrameSpeed == "Delayed" then
			local adjust = 0
			if msg == "Fake" then
				if expectedTime and expectedTime == 4 then adjust = 1 end
				self:Schedule(2.5-adjust, showInfoFrame, self)
			else
				self:Schedule(4-adjust, showInfoFrame, self)
			end
		else
			showInfoFrame(self)
		end
	end
end
