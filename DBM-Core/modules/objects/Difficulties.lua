---@class DBMCoreNamespace
local private = select(2, ...)

local L = DBM_CORE_L
local CL = DBM_COMMON_L

---@class DBM
local DBM = private:GetPrototype("DBM")

---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")

---@class Difficulties
local difficulties = private:GetPrototype("Difficulties")
DBM.Difficulties = difficulties

local test = private:GetPrototype("DBMTest")

difficulties.savedDifficulty = nil
difficulties.difficultyIndex = nil
difficulties.difficultyText = nil
difficulties.difficultyModifier = nil

local groupSize = 0

difficulties.statVarTable = {
	--Current
	["event5"] = "normal",
	["event20"] = "lfr25",
	["event40"] = "lfr25",
	["quest"] = "follower",--For now, unless a conflict arises
	["follower"] = "follower",
	["story"] = "story",
	["normal5"] = "normal",
	["heroic5"] = "heroic",
	["challenge5"] = "challenge",
	["lfr"] = "lfr25",
	["normal"] = "normal",
	["heroic"] = "heroic",
	["mythic"] = "mythic",
	["mythic5"] = "mythic",
	["worldboss"] = "normal",
	["timewalker"] = "timewalker",
	["progressivechallenges"] = "normal",
	["delves"] = "normal",
	["duos"] = "duos",
	--BFA
	["normalwarfront"] = "normal",
	["heroicwarfront"] = "heroic",
	["normalisland"] = "normal",
	["heroicisland"] = "heroic",
	["mythicisland"] = "mythic",
	["teamingisland"] = "mythic",--Blizz uses mythic as fallback, so I will too
	--Shadowlands
	["couragescenario"] = "normal",--Map PoA scenaris to different stats for each difficulty
	["loyaltyscenario"] = "heroic",
	["wisdomscenario"] = "mythic",
	["humilityscenario"] = "challenge",
	--Legacy
	["lfr25"] = "lfr25",
	["normal10"] = "normal",
	["normal20"] = "normal",
	["normal25"] = "normal25",--Legacy raids that have two normal difficulties still (10/25)
	["normal40"] = "normal",
	["heroic10"] = "heroic",
	["heroic25"] = "heroic25",--Legacy raids that have two heroic difficulties still (10/25)
	["normalscenario"] = "normal",
	["heroicscenario"] = "heroic",
}


--[InstanceID] = {level,zoneType}
--zoneType: 1 = outdoor, 2 = dungeon, 3 = raid, 4 = delves, 5 = player challenges
local instanceDifficultyBylevel, seasonalDungeons
if private.isRetail then
	instanceDifficultyBylevel = {
		--World
		[0] = {50, 1}, [1] = {50, 1},--Eastern Kingdoms and Kalimdor world events/bosses. These would be warfront and aniversery world bosses, so they'd be set to 50 for now. Likely 60 next year
		[530] = {30, 1},--Outlands World Bosses
		[870] = {30, 1}, [1064] = {30, 1},--MoP World Bosses
		[1116] = {40, 1}, [1159] = {40, 1}, [1331] = {40, 1}, [1158] = {40, 1}, [1153] = {40, 1}, [1152] = {40, 1}, [1330] = {40, 1}, [1160] = {40, 1}, [1154] = {40, 1}, [1464] = {40, 1},--Wod World and Garrison Bosses
		[1220] = {45, 1}, [1779] = {45, 1},--Legion World bosses
		[1643] = {50, 1}, [1642] = {50, 1}, [1718] = {50, 1}, [1943] = {50, 1}, [1876] = {50, 1}, [2105] = {50, 1}, [2111] = {50, 1}, [2275] = {50, 1},--Bfa World bosses and warfronts
		[2222] = {60, 1}, [2374] = {60, 1},--Shadowlands World Bosses
		[2444] = {70, 1}, [2512] = {70, 1}, [2574] = {70, 1}, [2454] = {70, 1}, [2548] = {70, 1},--Dragonflight World Bosses
		[2774] = {80, 1}, [2552] = {80, 1}, [2601] = {80, 1},--War Within World Bosses
		--Raids
		[509] = {30, 3}, [531] = {30, 3}, [469] = {30, 3}, [409] = {30, 3},--Classic Raids
		[564] = {30, 3}, [534] = {30, 3}, [532] = {30, 3}, [565] = {30, 3}, [544] = {30, 3}, [548] = {30, 3}, [580] = {30, 3}, [550] = {30, 3},--BC Raids
		[615] = {30, 3}, [724] = {30, 3}, [649] = {30, 3}, [616] = {30, 3}, [631] = {30, 3}, [533] = {30, 3}, [249] = {30, 3}, [603] = {30, 3}, [624] = {30, 3},--Wrath Raids
		[757] = {35, 3}, [671] = {35, 3}, [669] = {35, 3}, [967] = {35, 3}, [720] = {35, 3}, [951] = {35, 3}, [754] = {35, 3},--Cata Raids
		[1009] = {35, 3}, [1008] = {35, 3}, [1136] = {35, 3}, [996] = {35, 3}, [1098] = {35, 3},--MoP Raids
		[1205] = {40, 3}, [1448] = {40, 3}, [1228] = {40, 3},--WoD Raids (yes, only 3 kekw)
		[1712] = {50, 3}, [1520] = {50, 3}, [1530] = {50, 3}, [1676] = {50, 3}, [1648] = {50, 3},--Legion Raids (Set to 50 because 45 tuning makes them difficult even at 55)
		[1861] = {50, 3}, [2070] = {50, 3}, [2096] = {50, 3}, [2164] = {50, 3}, [2217] = {50, 3},--BfA Raids
		[2296] = {60, 3}, [2450] = {60, 3}, [2481] = {60, 3},--Shadowlands Raids (yes, only 3 kekw, seconded)
		[2522] = {70, 3}, [2569] = {70, 3}, [2549] = {70, 3},--Dragonflight Raids
		[2657] = {80, 3}, [2792] = {80, 3}, [2769] = {80, 3}, [2810] = {80, 3},--War Within Raids
		--Dungeons
		[48] = {30, 2}, [230] = {30, 2}, [429] = {30, 2}, [389] = {30, 2}, [34] = {30, 2},--Classic Dungeons
		[540] = {30, 2}, [558] = {30, 2}, [556] = {30, 2}, [555] = {30, 2}, [542] = {30, 2}, [546] = {30, 2}, [545] = {30, 2}, [547] = {30, 2}, [553] = {30, 2}, [554] = {30, 2}, [552] = {30, 2}, [557] = {30, 2}, [269] = {30, 2}, [560] = {30, 2}, [543] = {30, 2}, [585] = {30, 2},--BC Dungeons
		[619] = {30, 2}, [601] = {30, 2}, [595] = {30, 2}, [600] = {30, 2}, [604] = {30, 2}, [602] = {30, 2}, [599] = {30, 2}, [576] = {30, 2}, [578] = {30, 2}, [574] = {30, 2}, [575] = {30, 2}, [608] = {30, 2}, [658] = {30, 2}, [632] = {30, 2}, [668] = {30, 2}, [650] = {30, 2},--Wrath Dungeons
		[755] = {35, 2}, [645] = {35, 2}, [36] = {35, 2}, [670] = {35, 2}, [644] = {35, 2}, [33] = {35, 2}, [643] = {35, 2}, [725] = {35, 2}, [657] = {35, 2}, [309] = {35, 2}, [859] = {35, 2}, [568] = {35, 2}, [938] = {35, 2}, [940] = {35, 2}, [939] = {35, 2}, [646] = {35, 2},--Cata Dungeons
		[960] = {35, 2}, [961] = {35, 2}, [959] = {35, 2}, [962] = {35, 2}, [994] = {35, 2}, [1011] = {35, 2}, [1007] = {35, 2}, [1001] = {35, 2}, [1004] = {35, 2},--MoP Dungeons
		[1182] = {40, 2}, [1175] = {40, 2}, [1208] = {40, 2}, [1195] = {40, 2}, [1279] = {40, 2}, [1176] = {40, 2}, [1209] = {40, 2}, [1358] = {40, 2},--WoD Dungeons
		[1501] = {45, 2}, [1466] = {45, 2}, [1456] = {45, 2}, [1477] = {45, 2}, [1458] = {45, 2}, [1516] = {45, 2}, [1571] = {45, 2}, [1492] = {45, 2}, [1544] = {45, 2}, [1493] = {45, 2}, [1651] = {45, 2}, [1677] = {45, 2}, [1753] = {45, 2},--Legion Dungeons
		[1763] = {50, 2}, [1754] = {50, 2}, [1762] = {50, 2}, [1864] = {50, 2}, [1822] = {50, 2}, [1877] = {50, 2}, [1594] = {50, 2}, [1841] = {50, 2}, [1771] = {50, 2}, [1862] = {50, 2}, [2097] = {50, 2},--Bfa Dungeons
		[2286] = {60, 2}, [2289] = {60, 2}, [2290] = {60, 2}, [2287] = {60, 2}, [2285] = {60, 2}, [2293] = {60, 2}, [2291] = {60, 2}, [2284] = {60, 2}, [2441] = {60, 2},--Shadowlands Dungeons
		[2520] = {70, 2}, [2451] = {70, 2}, [2516] = {70, 2}, [2519] = {70, 2}, [2526] = {70, 2}, [2515] = {70, 2}, [2521] = {70, 2}, [2527] = {70, 2}, [2579] = {70, 2},--Dragonflight Dungeons
		[2652] = {80, 2}, [2662] = {80, 2}, [2660] = {80, 2}, [2669] = {80, 2}, [2651] = {80, 2}, [2649] = {80, 2}, [2648] = {80, 2}, [2661] = {80, 2}, [2773] = {80, 2}, [2830] = {80, 2},--War Within Dungeons
		--Delves
		[2664] = {80, 4}, [2679] = {80, 4}, [2680] = {80, 4}, [2681] = {80, 4}, [2682] = {80, 4}, [2683] = {80, 4}, [2684] = {80, 4}, [2685] = {80, 4}, [2686] = {80, 4}, [2687] = {80, 4}, [2688] = {80, 4}, [2689] = {80, 4}, [2690] = {80, 4}, [2767] = {80, 4}, [2768] = {80, 4}, [2831] = {80, 4}, [2815] = {80, 4}, [2826] = {80, 4}, [2803] = {80, 4}, [2951] = {80, 4},--War Within Delves
		--Challenges (Mage tower, visions, torghast, proving grounds)
		[2212] = {50, 5}, [2213] = {50, 5}, [2827] = {80, 5}, [2828] = {80, 5}, [2162]= {80, 5}, [1148] = {80, 5}, [1698] = {80, 5}, [1710] = {80, 5}, [1703] = {80, 5}, [1702] = {80, 5}, [1684] = {80, 5}, [1673] = {80, 5}, [1616] = {80, 5},
	}
	--seasonalDungeons = {[2662]=true, [2660]=true, [2773]=true, [2649]=true, [2830]=true, [2287]=true, [2441]=true}--TWW Season 3
	seasonalDungeons = {[2651]=true, [2649]=true, [2648]=true, [2661]=true, [1594]=true, [2097]=true, [2293]=true, [2773]=true, [2662]=true, [2660]=true, [2830]=true, [2287]=true, [2441]=true}--TWW Season 2 and 3
elseif private.isCata or private.isMop then
	--Since 2 dungeons were changed from vanilla to cata dungeons, Cata and MoP need own table
	--Still has to remain separate from retail due to level squishes retail has had
	instanceDifficultyBylevel = {
		--World
		[0] = {60, 1}, [1] = {60, 1},--Eastern Kingdoms and Kalimdor world bosses.
		[530] = {70, 1},--Outlands World Bosses
		[870] = {90, 1}, [1064] = {90, 1},--MoP World Bosses
		--Raids
		[509] = {60, 3}, [531] = {60, 3}, [469] = {60, 3}, [409] = {60, 3},--Classic Raids (309 is legacy ZG)
		[564] = {70, 3}, [534] = {70, 3}, [532] = {70, 3}, [565] = {70, 3}, [544] = {70, 3}, [548] = {70, 3}, [580] = {70, 3}, [550] = {70, 3},--BC Raids (568 is legacy ZA)
		[615] = {80, 3}, [724] = {80, 3}, [649] = {80, 3}, [616] = {80, 3}, [631] = {80, 3}, [533] = {80, 3}, [249] = {80, 3}, [603] = {80, 3}, [624] = {80, 3},--Wrath Raids
		[757] = {85, 3}, [671] = {85, 3}, [669] = {85, 3}, [967] = {85, 3}, [720] = {85, 3}, [951] = {85, 3}, [754] = {85, 3},--Cata Raids
		[1009] = {90, 3}, [1008] = {90, 3}, [1136] = {90, 3}, [996] = {90, 3}, [1098] = {90, 3},--MoP Raids
		--Dungeons
		[429] = {45, 2}, [389] = {18, 2}, [349] = {52, 2}, [329] = {60, 2}, [289] = {60, 2}, [230] = {60, 2}, [229] = {60, 2}, [209] = {54, 2}, [189] = {45, 2}, [129] = {47, 2}, [109] = {60, 2}, [90] = {34, 2}, [70] = {52, 2}, [48] = {32, 2}, [47] = {42, 2}, [43] = {27, 2}, [34] = {32, 2},--Classic Dungeons
		[540] = {70, 2}, [558] = {70, 2}, [556] = {70, 2}, [555] = {70, 2}, [542] = {70, 2}, [546] = {70, 2}, [545] = {70, 2}, [547] = {70, 2}, [553] = {70, 2}, [554] = {70, 2}, [552] = {70, 2}, [557] = {70, 2}, [269] = {70, 2}, [560] = {70, 2}, [543] = {70, 2}, [585] = {70, 2},--BC Dungeons
		[619] = {80, 2}, [601] = {80, 2}, [595] = {80, 2}, [600] = {80, 2}, [604] = {80, 2}, [602] = {80, 2}, [599] = {80, 2}, [576] = {80, 2}, [578] = {80, 2}, [574] = {80, 2}, [575] = {80, 2}, [608] = {80, 2}, [658] = {80, 2}, [632] = {80, 2}, [668] = {80, 2}, [650] = {80, 2},--Wrath Dungeons
		[755] = {85, 2}, [645] = {85, 2}, [36] = {85, 2}, [670] = {85, 2}, [644] = {85, 2}, [33] = {85, 2}, [643] = {85, 2}, [725] = {85, 2}, [657] = {85, 2}, [309] = {85, 2}, [859] = {85, 2}, [568] = {85, 2}, [938] = {85, 2}, [940] = {85, 2}, [939] = {85, 2}, [646] = {85, 2},--Cata Dungeons
		[960] = {90, 2}, [961] = {90, 2}, [959] = {90, 2}, [962] = {90, 2}, [994] = {90, 2}, [1011] = {90, 2}, [1007] = {90, 2}, [1001] = {90, 2}, [1004] = {90, 2},--MoP Dungeons
	}
	seasonalDungeons = {}--None
elseif private.isWrath then
	--Since naxx is moved to northrend, wrath and cata can't use tbc/classics table
	instanceDifficultyBylevel = {
		--World
		[0] = {60, 1}, [1] = {60, 1},--Eastern Kingdoms and Kalimdor world bosses.
		[530] = {70, 1},--Outlands World Bosses
		--Raids
		[509] = {60, 3}, [531] = {60, 3}, [469] = {60, 3}, [409] = {60, 3}, [309] = {60, 3},--Classic Raids (309 is legacy ZG)
		[564] = {70, 3}, [534] = {70, 3}, [532] = {70, 3}, [565] = {70, 3}, [544] = {70, 3}, [548] = {70, 3}, [580] = {70, 3}, [550] = {70, 3}, [568] = {70, 3},--BC Raids (568 is legacy ZA)
		[615] = {80, 3}, [724] = {80, 3}, [649] = {80, 3}, [616] = {80, 3}, [631] = {80, 3}, [533] = {80, 3}, [249] = {80, 3}, [603] = {80, 3}, [624] = {80, 3},--Wrath Raids
		--Dungeons
		[429] = {45, 2}, [389] = {18, 2}, [349] = {52, 2}, [329] = {60, 2}, [289] = {60, 2}, [230] = {60, 2}, [229] = {60, 2}, [209] = {54, 2}, [189] = {45, 2}, [129] = {47, 2}, [109] = {60, 2}, [90] = {34, 2}, [70] = {52, 2}, [48] = {32, 2}, [47] = {42, 2}, [43] = {27, 2}, [36] = {25, 2}, [34] = {32, 2}, [33] = {30, 2},--Classic Dungeons
		[540] = {70, 2}, [558] = {70, 2}, [556] = {70, 2}, [555] = {70, 2}, [542] = {70, 2}, [546] = {70, 2}, [545] = {70, 2}, [547] = {70, 2}, [553] = {70, 2}, [554] = {70, 2}, [552] = {70, 2}, [557] = {70, 2}, [269] = {70, 2}, [560] = {70, 2}, [543] = {70, 2}, [585] = {70, 2},--BC Dungeons
		[619] = {80, 2}, [601] = {80, 2}, [595] = {80, 2}, [600] = {80, 2}, [604] = {80, 2}, [602] = {80, 2}, [599] = {80, 2}, [576] = {80, 2}, [578] = {80, 2}, [574] = {80, 2}, [575] = {80, 2}, [608] = {80, 2}, [658] = {80, 2}, [632] = {80, 2}, [668] = {80, 2}, [650] = {80, 2},--Wrath Dungeons
	}
	seasonalDungeons = {}--None
else--TBC and Vanilla
	instanceDifficultyBylevel = {
		--World
		[0] = {60, 1}, [1] = {60, 1},--Eastern Kingdoms and Kalimdor world bosses.
		[530] = {70, 1},--Outlands World Bosses
		--Raids
		[509] = {60, 3}, [531] = {60, 3}, [469] = {60, 3}, [409] = {60, 3}, [533] = {60, 3}, [309] = {60, 3}, [249] = {60, 3},--Classic Raids (309 is legacy ZG)
		[564] = {70, 3}, [534] = {70, 3}, [532] = {70, 3}, [565] = {70, 3}, [544] = {70, 3}, [548] = {70, 3}, [580] = {70, 3}, [550] = {70, 3}, [568] = {70, 3},--BC Raids (568 is legacy ZA)
		--Dungeons
		[429] = {45, 2}, [389] = {18, 2}, [349] = {52, 2}, [329] = {60, 2}, [289] = {60, 2}, [230] = {60, 2}, [229] = {60, 2}, [209] = {54, 2}, [189] = {45, 2}, [129] = {47, 2}, [109] = {60, 2}, [90] = {34, 2}, [70] = {52, 2}, [48] = {32, 2}, [47] = {42, 2}, [43] = {27, 2}, [36] = {25, 2}, [34] = {32, 2}, [33] = {30, 2},--Classic Dungeons
		[540] = {70, 2}, [558] = {70, 2}, [556] = {70, 2}, [555] = {70, 2}, [542] = {70, 2}, [546] = {70, 2}, [545] = {70, 2}, [547] = {70, 2}, [553] = {70, 2}, [554] = {70, 2}, [552] = {70, 2}, [557] = {70, 2}, [269] = {70, 2}, [560] = {70, 2}, [543] = {70, 2}, [585] = {70, 2},--BC Dungeons
	}
	seasonalDungeons = {}--None
	-- Season of Discovery
	if Enum.SeasonID and private.currentSeason == Enum.SeasonID.SeasonOfDiscovery then
		instanceDifficultyBylevel[48] = {25, 3} -- Blackfathom deeps level up raid
		instanceDifficultyBylevel[90] = {40, 3} -- Gnomeregan level up raid
		instanceDifficultyBylevel[109] = {50, 3} -- Sunken Temple level up raid
		instanceDifficultyBylevel[2784] = {60, 2} -- Demon Fall Canyon dungeon
		instanceDifficultyBylevel[2789] = {60, 3} -- Lord kazzak
		instanceDifficultyBylevel[2791] = {60, 3} -- Azuregos
		instanceDifficultyBylevel[2784] = {60, 3} -- Azgaloth
		instanceDifficultyBylevel[2804] = {60, 3} -- Prince Thunderaan
		instanceDifficultyBylevel[2806] = {60, 2} -- Shadow Hold
		instanceDifficultyBylevel[2807] = {60, 2} -- Burning of Andorhal
		instanceDifficultyBylevel[2817] = {60, 2} -- Starfall Barrow Den
		instanceDifficultyBylevel[2832] = {60, 3} -- Nightmare Grove
		instanceDifficultyBylevel[2856] = {60, 3} -- Scarlet Enclave
		instanceDifficultyBylevel[2875] = {60, 2} -- Karazhan Crypts
	end
end


function difficulties:RefreshCache(force)
	if force or not self.savedDifficulty or not self.difficultyText or not self.difficultyIndex then
		self.savedDifficulty, self.difficultyText, self.difficultyIndex, groupSize, self.difficultyModifier = DBM:GetCurrentInstanceDifficulty()
		DBM:Debug(("GetInstanceInfo() = %s, %s, %s, %s, %s, %s, %s, %s, %s"):format(tostringall(GetInstanceInfo())), 3, nil, true)
		DBM:Debug(("DBM:GetCurrentInstanceDifficulty() = %s, %s, %s, %s, %s"):format(tostringall(self.savedDifficulty, self.difficultyText, self.difficultyIndex, groupSize, self.difficultyModifier)), 3, nil, true)
	end
end

function DBM:GetCurrentDifficulty()
	return difficulties.difficultyIndex
end

function DBM:GetGroupSize()
	return groupSize
end

---Useful for M+, Delves, or tiered SoD raids when you specifically need to know modifier level
function DBM:GetModifierLevel()
	return difficulties.difficultyModifier
end

function difficulties:InstanceType(instanceId)
	return instanceDifficultyBylevel[instanceId] and instanceDifficultyBylevel[instanceId][2] or 0
end

function difficulties:IsSeasonalDungeon(instanceId)
	return seasonalDungeons[instanceId] or false
end

---@param self DBM|DBMMod
function DBM:IsTrivial(customLevel)
	if test.testRunning then
		return false
	end
	local lastInstanceMapId = DBM:GetCurrentArea()
	--if timewalking or chromie time or challenge modes. it's always non trivial content
	if C_PlayerInfo.IsPlayerInChromieTime and C_PlayerInfo.IsPlayerInChromieTime() or self:IsRemix() or difficulties.difficultyIndex == 24 or difficulties.difficultyIndex == 33 or difficulties.difficultyIndex == 8 then
		return false
	end
	--if current season dungeon (which blizzard auto scales up to current level on ALL difficulties now)
	if seasonalDungeons[lastInstanceMapId] then
		return false
	end
	--if custom level passed, we always hard check that level for trivial vs non trivial
	if customLevel then--Custom level parameter
		if private.playerLevel >= customLevel then
			return true
		end
	else
		--First, auto bail and return non trivial if it's an instance not in table to prevent nil error
		if not instanceDifficultyBylevel[lastInstanceMapId] then return false end
		--Content is trivial if player level is 10 higher than content involved
		local levelDiff = private.isRetail and 10 or 15
		if private.playerLevel >= (instanceDifficultyBylevel[lastInstanceMapId][1] + levelDiff) then
			return true
		end
	end
	return false
end
bossModPrototype.IsTrivial = DBM.IsTrivial

---@param self DBM|DBMMod
function DBM:IsFated()
	--Returns table if fated, nil otherwise
	if C_ModifiedInstance and C_ModifiedInstance.GetModifiedInstanceInfoFromMapID(DBM:GetCurrentArea()) then
		return true
	end
	return false
end
bossModPrototype.IsFated = DBM.IsFated

---Function for verifying whether a timerunning season is active.
---@param self DBM|DBMMod
---@param match number? Use if you need to know if it's a SPECIFIC season (otherwise it returns true for any active season)
---@return boolean
function DBM:IsRemix(match)
	local seasonID = PlayerGetTimerunningSeasonID and PlayerGetTimerunningSeasonID() or 0
	if match and seasonID == match then
		return true
	elseif seasonID >= 1 then
		return true
	end
	return false
end
bossModPrototype.IsRemix = DBM.IsRemix

function bossModPrototype:IsDifficulty(...)
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	for i = 1, select("#", ...) do
		if diff == select(i, ...) then
			return true
		end
	end
	return false
end

function bossModPrototype:IsLFR()
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "lfr" or diff == "lfr25"
end

---Dungeons: follower, normal. (Raids excluded)
function bossModPrototype:IsEasyDungeon()
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "normal5" or diff == "follower" or diff == "quest"
end

---Dungeons: Any 5 man dungeon
function bossModPrototype:IsDungeon()
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "heroic5" or diff == "mythic5" or diff == "challenge5" or diff == "normal5"
end

---Dungeons: follower, normal, heroic. Raids: LFR, normal (rescope this to exclude heroic now that heroic5 is the new mythic 0?)
function bossModPrototype:IsEasy()
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "normal" or diff == "lfr" or diff == "lfr25" or diff == "heroic5" or diff == "normal5" or diff == "follower" or diff == "quest"
end

---Dungeons: mythic, mythic+. Raids: heroic, mythic
function bossModPrototype:IsHard()
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "mythic" or diff == "mythic5" or diff == "challenge5" or diff == "heroic" or diff == "humilityscenario"
end

---Pretty much ANYTHING that has a normal mode
function bossModPrototype:IsNormal()
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "normal" or diff == "normal5" or diff == "normal10" or diff == "normal20" or diff == "normal25" or diff == "normal40" or diff == "normalisland" or diff == "normalwarfront" or diff == "follower"
end

---Dungeons with AI "follower" npcs. 1-5 players
function bossModPrototype:IsFollower()
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "follower"
end

---Dungeons designed for just the player. "quest dungeons"
---<br> NOT to be confused with follower, which are just normal dungeons with AI followers
function bossModPrototype:IsStory()
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "quest" or diff == "story"
end

---Pretty much ANYTHING that has a heroic mode
function bossModPrototype:IsHeroic()
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "heroic" or diff == "heroic5" or diff == "heroic10" or diff == "heroic25" or diff == "heroicisland" or diff == "heroicwarfront"
end

---Pretty much ANYTHING that has mythic mode, with mythic+ included
function bossModPrototype:IsMythic()
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return (diff == "mythic" or diff == "challenge5" or diff == "mythicisland" or diff == "mythic5") and not self:IsMop()
end

function bossModPrototype:IsMythicPlus()
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "challenge5" and not self:IsMop()
end

-- Check if the SoD "Black Essence" buff in BWL is enabled. Do not use outside of SoD BWL.
function bossModPrototype:IsBwlBlackEssenceEnabled()
	-- I don't really like having something specific to SoD BWL in here, but it's cleaner than putting that logic in BWL mods
	return difficulties.difficultyModifier and difficulties.difficultyModifier % 2 == 1
end

function bossModPrototype:IsEvent()
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "event5" or diff == "event20" or diff == "event40"
end

function bossModPrototype:IsWarfront()
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "normalwarfront" or diff == "heroicwarfront"
end

function bossModPrototype:IsIsland()
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "normalisland" or diff == "heroicisland" or diff == "mythicisland"
end

function bossModPrototype:IsScenario()
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "normalscenario" or diff == "heroicscenario" or diff == "couragescenario" or diff == "loyaltyscenario" or diff == "wisdomscenario" or diff == "humilityscenario"
end

function bossModPrototype:IsDelve()
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "delves"
end

function bossModPrototype:IsDuo()
	local diff = difficulties.savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "duos"
end

difficulties.SOD_BWL_TRIAL_BLACK  = 1
difficulties.SOD_BWL_TRIAL_GREEN  = 2
difficulties.SOD_BWL_TRIAL_BLUE	  = 4
difficulties.SOD_BWL_TRIAL_BRONZE = 8
difficulties.SOD_BWL_TRIAL_RED    = 16

--TODO C_IslandsQueue.GetIslandDifficultyInfo(), if 38-40 don't work
function DBM:GetCurrentInstanceDifficulty()
	local _, instanceType, difficulty, difficultyName, _, _, _, instanceID, instanceGroupSize = private.GetInstanceInfo()
	if difficulty == 0 or difficulty == 172 or (difficulty == 1 and instanceType == "none") or (C_Garrison and C_Garrison:IsOnGarrisonMap()) then--draenor field returns 1, causing world boss mod bug.
		return "worldboss", RAID_INFO_WORLD_BOSS .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 1 or difficulty == 173 or difficulty == 184 or difficulty == 150 or difficulty == 201 then--5 man Normal Dungeon / 201 is SoD 5 man ID for a dungeon that's also a 10/20 man SoD Raid.
		return "normal5", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 2 or difficulty == 174 then--5 man Heroic Dungeon
		return "heroic5", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 3 or difficulty == 175 or difficulty == 198 then--Legacy 10 man Normal Raid/SoD 10 man raid
		return "normal10", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 4 or difficulty == 176 then--Legacy 25 man Normal Raid
		return "normal25", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 5 or difficulty == 193 then--Legacy 10 man Heroic Raid
		return "heroic10", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 6 or difficulty == 194 then--Legacy 25 man Heroic Raid
		return "heroic25", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 7 then--Legacy 25 man LFR (ie pre WoD zones)
		return "lfr25", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 8 then--Dungeon, Mythic+ (Challenge modes in mists and wod)
		local keystoneLevel = C_ChallengeMode and C_ChallengeMode.GetActiveKeystoneInfo() or 0
		return "challenge5", PLAYER_DIFFICULTY6 .. "+ (" .. keystoneLevel .. ") - ", difficulty, instanceGroupSize, keystoneLevel
	 --20 man classic raids:
	 -- 226 is SoD 20 (and 10/20 flex)
	 -- 186 is era 40 and SoD 20/40 flex, only SoD 186 is handled here because they are considered 20 player raids
	elseif difficulty == 148 or difficulty == 185 or difficulty == 215 or difficulty == 226 or (difficulty == 186 and DBM:IsSeasonal("SeasonOfDiscovery")) then
		if instanceID == 309 then --ZG, force return 10 man
			return "normal10", difficultyName .. " - ", difficulty, instanceGroupSize, 0
		end
		local modifierLevel = 0
		local difficultyId = "normal20" -- Keep as "normal20" here even though some are technically 40 in SoD to not mess with old stats before the 20/40 mess was added
		local modifierName = ""
		if DBM:IsSeasonal("SeasonOfDiscovery") and (difficulty == 226 or difficulty == 186) then -- SoD difficulties
			-- Note: not necessary to check for actual instance, the buffs are only active in the instances anyways
			-- Molten Core heat levels
			if self:UnitDebuff("player", 458841) then--Sweltering Heat
				modifierLevel = 1
			elseif self:UnitDebuff("player", 458842) then--Blistering Heat
				modifierLevel = 2
			elseif self:UnitDebuff("player", 458843) then--Molten Heat
				modifierLevel = 3
			end
			-- BWL trials: we follow the definition from Warcraft Logs: https://www.archon.gg/classic-sod/articles/news/phase-5-bwl-and-zg-on-warcraft-logs
			-- That unfortunately means that you can have something that is considered Heroic but does not include the extra mechanics from Black Essence
			-- So mods will need to check explicitly for this modifier instead of relying on :IsHeroic()/:IsMythic() :()
			-- Trials are stored by using difficultyModifier as bit field, see definitions of SOD_BWL_TRIAL_* above
			local trialCount = 0 -- bit.popcount() would be great to have
			if self:UnitBuff("player", 467047) then
				modifierLevel = modifierLevel + difficulties.SOD_BWL_TRIAL_BLACK
				modifierName = modifierName .. CL.BLACK .. " + "
				trialCount = trialCount + 1
			end
			if self:UnitBuff("player", 466416) then -- Green
				modifierLevel = modifierLevel + difficulties.SOD_BWL_TRIAL_GREEN
				modifierName = modifierName .. CL.GREEN .. " + "
				trialCount = trialCount + 1
			end
			if self:UnitBuff("player", 466277) then
				modifierLevel = modifierLevel + difficulties.SOD_BWL_TRIAL_BLUE
				modifierName = modifierName .. CL.BLUE .. " + "
				trialCount = trialCount + 1
			end
			if self:UnitBuff("player", 466071) then
				modifierLevel = modifierLevel + difficulties.SOD_BWL_TRIAL_BRONZE
				modifierName = modifierName .. CL.BRONZE .. " + "
				trialCount = trialCount + 1
			end
			if self:UnitBuff("player", 466261) then
				modifierLevel = modifierLevel + difficulties.SOD_BWL_TRIAL_RED
				modifierName = modifierName .. CL.RED .. " + "
				trialCount = trialCount + 1
			end
			modifierName = modifierName:sub(0, -4)
			-- BWL Heroic: "1-2 trials, or 3-4 trials without Black" (Warcraft Logs)
			if trialCount == 1 or trialCount == 2 or (trialCount >= 3 and modifierLevel % 2 == 0) then
				difficultyId = "heroic" -- Just use heroic/mythic without player qualifiers like flex raids would do
				difficultyName = PLAYER_DIFFICULTY2
			-- BWL Mythic: "3+ trials with Black required" (Warcraft Logs)
			elseif trialCount >= 3 and modifierLevel % 2 == 1 then
				difficultyId = "mythic"
				difficultyName = PLAYER_DIFFICULTY6
			end
			-- Naxxramas Hardmode
			-- The different levels (sometimes) use different buffs? The debuff still has the right number of stacks
			-- Do not check for 1224428 here, it's active on normal (despite the description saying "The forces of the Scourge grow stronger.")
			local naxxModifier = select(3, self:UnitDebuff("player", 1218283, 1218271, 1218275, 1218276))
			if naxxModifier == 0 then naxxModifier = 1 end -- First level has no count
			if naxxModifier then
				modifierLevel = naxxModifier
				-- Warcraft Logs defines everything >= 1 as heroic and == 4 as Mythic, regardless of whether the current wing is empowered
				if naxxModifier >= 4 then -- Max level is a bit unclear, on the PTR it was 10 at first (with up to 5 working), but now it seems to be 4?
					difficultyId = "mythic"
					difficultyName = PLAYER_DIFFICULTY6
				else
					difficultyId = "heroic"
					difficultyName = PLAYER_DIFFICULTY2
				end
			end
			local scarletEnclaveModifier = select(3, self:UnitDebuff("player", 1232014))
			if scarletEnclaveModifier == 0 then scarletEnclaveModifier = 1 end
			if scarletEnclaveModifier then
				modifierLevel = scarletEnclaveModifier
			end
		end
		if modifierLevel == 0 then
			return difficultyId, difficultyName .. " - ", difficulty, instanceGroupSize, 0
		else
			modifierName = modifierName == "" and tostring(modifierLevel) or modifierName
			return difficultyId, difficultyName .. " (" .. modifierName .. ") - ", difficulty, instanceGroupSize, modifierLevel
		end
	elseif difficulty == 9 or difficulty == 186 then--Legacy 40 man raids, no longer returned as index 3 (normal 10man raids)
		return "normal40", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 11 then--Heroic Scenario (mostly Mists of pandaria)
		return "heroicscenario", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 12 or difficulty == 152 then--Normal Scenario (mostly Mists of pandaria and Visions of Nzoth scenarios)
		return "normalscenario", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 14 then--Flexible Normal Raid
		return "normal", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 15 then--Flexible Heroic Raid
		return "heroic", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 16 then--Mythic 20 man Raid
		return "mythic", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 17 or difficulty == 151 then--Flexible LFR (ie post WoD zones)/8.3+ LFR
		return "lfr", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 18 then--Special event 40 player LFR Queue (used by molten core aniversery event)
		return "event40", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 19 then--Special event 5 player queue (used by wod pre expansion event that had miniturized version of UBRS remake)
		return "event5", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 20 then--Special event 20 player LFR Queue (never used yet)
		return "event20", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 23 then--Mythic 5 man Dungeon
		return "mythic5", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 24 or difficulty == 33 then--Timewalking Dungeon, Timewalking Raid
		return "timewalker", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 38 then--Normal BfA Island expedition
		return "normalisland", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 39 then--Heroic BfA Island expedition
		return "heroicisland", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 40 then--Mythic BfA Island expedition
		return "mythicisland", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 147 then--Normal BfA Warfront
		return "normalwarfront", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 149 then--Heroic BfA Warfront
		return "heroicwarfront", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 152 or difficulty == 167 then--Visions of Nzoth (bfa), Torghast (shadowlands)
		return "progressivechallenges", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 153 then---Teaming BfA? Island expedition
		return "teamingisland", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 168 then--Path of Ascention (Shadowlands)
		return "couragescenario", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 169 then--Path of Ascention (Shadowlands)
		return "loyaltyscenario", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 170 then--Path of Ascention (Shadowlands)
		return "wisdomscenario", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 171 then--Path of Ascention (Shadowlands)
		return "humilityscenario", difficultyName .. " - ", difficulty, instanceGroupSize, 0
--	elseif difficulty == 192 then--Non Instanced Challenge 1 (Unknown)
--		return "delve1", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 205 then--Follower (Party Dungeon - Dragonflight 10.2.5+)
		return "follower", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 207 then--SoD 1 player dungeon? Assigning as follower for now but will sort it out later
		return "follower", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 208 then--Delves (War Within 11.0.0+)
		local delveInfo, delveInfo2, delveInfo3 = C_UIWidgetManager.GetScenarioHeaderDelvesWidgetVisualizationInfo(6183), C_UIWidgetManager.GetScenarioHeaderDelvesWidgetVisualizationInfo(6184), C_UIWidgetManager.GetScenarioHeaderDelvesWidgetVisualizationInfo(6185)
		local usedDelveInfo
		--Zekvir Hack to normal/mythic since his tiers aren't numbers
		if delveInfo2 and delveInfo2.shownState and delveInfo2.shownState == 1 then
			return "normal", difficultyName .. "(?) - ", 1, instanceGroupSize, 0--Returns 1 for normal 1-5man
		elseif delveInfo3 and delveInfo3.shownState and delveInfo3.shownState == 1 then
			return "mythic", difficultyName .. "(??) - ", 23, instanceGroupSize, 0--returns 23 for mythic 1-5man
		elseif delveInfo and delveInfo.shownState and delveInfo.shownState == 1 then
			usedDelveInfo = C_UIWidgetManager.GetScenarioHeaderDelvesWidgetVisualizationInfo(6183)
		end
		local delveTier = 0
		if usedDelveInfo and usedDelveInfo.tierText then
			---@diagnostic disable-next-line: cast-local-type
			delveTier = tonumber(usedDelveInfo.tierText)
		end
		return "delves", difficultyName .. "(" .. delveTier .. ") - ", difficulty, instanceGroupSize, delveTier or 0
	elseif difficulty == 213 then--Infinite Dungeon (timewalking in sod?)
		return "timewalker", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 216 then--Quest (Party Dungeon - War Within 11.0.0+)
		return "quest", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 220 then--Story (Raid Dungeon - War Within 11.0.0+)
		return "story", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 231 then--SoD BWL (and other raids?)
		--Do fancy stuff here, TODO for paul :D
		--if Enum.SeasonID and private.currentSeason == Enum.SeasonID.SeasonOfDiscovery then--Molten Core SoD
		--	if self:UnitDebuff("player", 458841) then--Sweltering Heat
		--		return "normal", difficultyName .. " - ", difficulty, instanceGroupSize, 0
		--	elseif self:UnitDebuff("player", 458842) then--Blistering Heat
		--		return "heroic", difficultyName .. " - ", difficulty, instanceGroupSize, 0
		--	elseif self:UnitDebuff("player", 458843) then--Molten Heat
		--		return "mythic", difficultyName .. " - ", difficulty, instanceGroupSize, 0
		--	end
		--end
		return "normal", "", difficulty, instanceGroupSize, 0
	elseif difficulty == 232 then--Duos
		return "duos", "", difficulty, instanceGroupSize, 0
	else--failsafe
		return "normal", "", difficulty, instanceGroupSize, 0
	end
end

function DBM:IsLogableContent(force)
	--1: Check for any broad global filters like LFG/LFR filter
	--2: Check for what content specifically selected for logging
	--3: Boss Only filter is handled somewhere else (where StartLogging is called)
	local lastInstanceMapId = DBM:GetCurrentArea()
	if self.Options.DoNotLogLFG and (private.isRetail or private.isCata) and IsPartyLFG() then
		return false
	end

	--First checks are manual index checks versus table because even old content can be scaled up using M+ or TW scaling tech
	--Current player level Mythic+
	if self.Options.LogCurrentMPlus and (force or (difficulties.difficultyIndex or 0) == 8) then
		return true
	end
	--Timewalking or Chromie Time raid
	if self.Options.LogTWRaids and (C_PlayerInfo.IsPlayerInChromieTime and C_PlayerInfo.IsPlayerInChromieTime() or difficulties.difficultyIndex == 24 or difficulties.difficultyIndex == 33) and (instanceDifficultyBylevel[lastInstanceMapId] and instanceDifficultyBylevel[lastInstanceMapId][2] == 3) then
		return true
	end
	--Timewalking or Chromie Time Dungeon
	if self.Options.LogTWDungeons and (C_PlayerInfo.IsPlayerInChromieTime and C_PlayerInfo.IsPlayerInChromieTime() or difficulties.difficultyIndex == 24 or difficulties.difficultyIndex == 33) and (instanceDifficultyBylevel[lastInstanceMapId] and instanceDifficultyBylevel[lastInstanceMapId][2] == 2) then
		return true
	end

	--Now we do checks relying on pre coded trivial check table
	--Current level Mythic raid
	if self.Options.LogCurrentMythicRaids and instanceDifficultyBylevel[lastInstanceMapId] and not self:IsTrivial() and (instanceDifficultyBylevel[lastInstanceMapId] and instanceDifficultyBylevel[lastInstanceMapId][2] == 3) and difficulties.difficultyIndex == 16 then
		return true
	end
	--Current player level non Mythic raid
	if self.Options.LogCurrentRaids and instanceDifficultyBylevel[lastInstanceMapId] and not self:IsTrivial() and (instanceDifficultyBylevel[lastInstanceMapId][2] == 3) and difficulties.difficultyIndex ~= 16 then
		return true
	end
	--Trivial raid (ie one below players level)
	if self.Options.LogTrivialRaids and instanceDifficultyBylevel[lastInstanceMapId] and self:IsTrivial() and (instanceDifficultyBylevel[lastInstanceMapId][2] == 3) then
		return true
	end
	--Current level Mythic dungeon
	if self.Options.LogCurrentMythicZero and instanceDifficultyBylevel[lastInstanceMapId] and not self:IsTrivial() and (instanceDifficultyBylevel[lastInstanceMapId][2] == 2) and difficulties.difficultyIndex == 23 then
		return true
	end
	--Current level Heroic dungeon
	if self.Options.LogCurrentHeroic and instanceDifficultyBylevel[lastInstanceMapId] and not self:IsTrivial() and (instanceDifficultyBylevel[lastInstanceMapId][2] == 2) and (difficulties.difficultyIndex == 2 or difficulties.difficultyIndex == 174) then
		return true
	end

	--Current level delve
	if self.Options.LogDelves and instanceDifficultyBylevel[lastInstanceMapId] and not self:IsTrivial() and (instanceDifficultyBylevel[lastInstanceMapId][2] == 4) then
		return true
	end

	--Current level Challenges
	if self.Options.LogChallenges and instanceDifficultyBylevel[lastInstanceMapId] and not self:IsTrivial() and (instanceDifficultyBylevel[lastInstanceMapId][2] == 5) then
		return true
	end

	return false
end
