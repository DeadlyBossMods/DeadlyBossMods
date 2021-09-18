local tinsert, unpack = table.insert, unpack

local L = DBM_CORE_L

do
	local counts = {
		{	text	= "Corsica",value 	= "Corsica", path = "Interface\\AddOns\\DBM-Core\\Sounds\\Corsica\\", max = 10},
		{	text	= "Koltrane",value 	= "Kolt", path = "Interface\\AddOns\\DBM-Core\\Sounds\\Kolt\\", max = 10},
		{	text	= "Smooth",value 	= "Smooth", path = "Interface\\AddOns\\DBM-Core\\Sounds\\Smooth\\", max = 10},
		{	text	= "Smooth (Reverb)",value 	= "SmoothR", path = "Interface\\AddOns\\DBM-Core\\Sounds\\SmoothReverb\\", max = 10},
		{	text	= "Pewsey",value 	= "Pewsey", path = "Interface\\AddOns\\DBM-Core\\Sounds\\Pewsey\\", max = 10},
		{	text	= "Bear (Child)",value = "Bear", path = "Interface\\AddOns\\DBM-Core\\Sounds\\Bear\\", max = 10},
		{	text	= "Moshne",	value 	= "Mosh", path = "Interface\\AddOns\\DBM-Core\\Sounds\\Mosh\\", max = 5},
		{	text	= "Anshlun (ptBR)",value = "Anshlun", path = "Interface\\AddOns\\DBM-Core\\Sounds\\Anshlun\\", max = 10},
		{	text	= "Neryssa (ptBR)",value = "Neryssa", path = "Interface\\AddOns\\DBM-Core\\Sounds\\Neryssa\\", max = 10},
	}
	local hasCached = false
	local cachedTable
	DBM.Counts = counts -- @Deprecated: Use new utility functions

	function DBM:GetCountSounds()
		if not hasCached then
			cachedTable = {unpack(counts)}
		end
		return cachedTable
	end

	function DBM:AddCountSound(text, value, path, max)
		tinsert(counts, {
			text	= text,
			value	= value or text,
			path	= path,
			max		= max or 10
		})
		hasCached = false
	end
end

do
	local victory = {
		{text = L.NONE,value  = "None"},
		{text = L.RANDOM,value  = "Random"},
		{text = "Blakbyrd: FF Fanfare",value = "Interface\\AddOns\\DBM-Core\\sounds\\Victory\\bbvictory.ogg", length=4},
		{text = "SMG: FF Fanfare",value = "Interface\\AddOns\\DBM-Core\\sounds\\Victory\\SmoothMcGroove_Fanfare.ogg", length=4},
	}
	local hasCached = false
	local cachedTable
	DBM.Victory = victory -- @Deprecated: Use new utility functions

	function DBM:GetVictorySounds()
		if not hasCached then
			cachedTable = {unpack(victory)}
		end
		return cachedTable
	end

	function DBM:AddVictorySound(text, value, length)
		tinsert(victory, {
			text	= text,
			value	= value,
			length	= length
		})
		hasCached = false
	end
end

do
	local defeat = {
		{text = L.NONE,value  = "None"},
		{text = L.RANDOM,value  = "Random"},
		{text = "Alizabal: Incompetent Raiders",value = 25780, length=4},--"Sound\\Creature\\ALIZABAL\\VO_BH_ALIZABAL_RESET_01.ogg"
		{text = "Bwonsamdi: Over Your Head",value = 109293, length=4},--"Sound\\Creature\\bwonsamdi\\vo_801_bwonsamdi_35_m.ogg"
		{text = "Bwonsamdi: Pour Little Thing",value = 109295, length=4},--"Sound\\Creature\\bwonsamdi\\vo_801_bwonsamdi_37_m.ogg"
		{text = "Bwonsamdi: Impressive Death",value = 109296, length=4},--"Sound\\Creature\\bwonsamdi\\vo_801_bwonsamdi_38_m.ogg"
		{text = "Bwonsamdi: All That Armor",value = 109308, length=4},--"Sound\\Creature\\bwonsamdi\\vo_801_bwonsamdi_50_m.ogg"
		{text = "Kologarn: You Fail",value = 15588, length=4},--"Sound\\Creature\\Kologarn\\UR_Kologarn_Slay02.ogg"
		{text = "Hodir: Tragic",value = 15553, length=4},--"Sound\\Creature\\Hodir\\UR_Hodir_Slay01.ogg"
		{text = "Scrollsage Nola: Cycle",value = 109069, length=4},--"sound/creature/scrollsage_nola/vo_801_scrollsage_nola_34_f.ogg"
		{text = "Thorim: Failures",value = 15742, length=4},--"Sound\\Creature\\Thorim\\UR_Thorim_P1Wipe01.ogg"
		{text = "Valithria: Failures",value = 17067, length=4},--"Sound\\Creature\\ValithriaDreamwalker\\IC_Valithria_Berserk01.ogg"
		{text = "Yogg-Saron: Laugh",value = 15757, length=4},--"Sound\\Creature\\YoggSaron\\UR_YoggSaron_Slay01.ogg"
	}
	local hasCached = false
	local cachedTable
	DBM.Defeat = defeat -- @Deprecated: Use new utility functions

	function DBM:GetDefeatSounds()
		if not hasCached then
			cachedTable = {unpack(defeat)}
		end
		return cachedTable
	end

	function DBM:AddDefeatSound(text, value, length)
		tinsert(defeat, {
			text	= text,
			value	= value,
			length	= length
		})
		hasCached = false
	end
end

do
	-- Filtered list of media assigned to dungeon/raid background music catagory
	local dungeonMusic = {
		{text = L.NONE,value  = "None"},
		{text = L.RANDOM,value  = "Random"},
		{text = "Anduin Part 1 B",value = 1417242, length=140},--"sound\\music\\Legion\\MUS_70_AnduinPt1_B.mp3" Soundkit: 68230
		{text = "Nightsong",value = 441705, length=160},--"Sound\\Music\\cataclysm\\MUS_NightElves_GU01.mp3" Soundkit: 71181
		{text = "Ulduar: Titan Orchestra",value = 298910, length=102},--"Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_TitanOrchestraIntro.mp3" Soundkit: 15873
	}
	local hasCached = false
	local cachedTable
	DBM.DungeonMusic = dungeonMusic -- @Deprecated: Use new utility functions

	function DBM:GetDungeonMusic()
		if not hasCached then
			cachedTable = {unpack(dungeonMusic)}
		end
		return cachedTable
	end

	function DBM:AddDungeonMusic(text, value, length)
		tinsert(dungeonMusic, {
			text	= text,
			value	= value,
			length	= length
		})
		hasCached = false
	end
end

do
	-- Filtered list of media assigned to boss/encounter background music catagory
	local battleMusic = {
		{text = L.NONE,value  = "None"},
		{text = L.RANDOM,value  = "Random"},
		{text = "Anduin Part 2 B",value = 1417248, length=111},--"sound\\music\\Legion\\MUS_70_AnduinPt2_B.mp3" Soundkit: 68230
		{text = "Bronze Jam",value = 350021, length=116},--"Sound\\Music\\ZoneMusic\\IcecrownRaid\\IR_BronzeJam.mp3" Soundkit: 118800
		{text = "Invincible",value = 1100052, length=197},--"Sound\\Music\\Draenor\\MUS_Invincible.mp3" Soundkit: 49536
	}
	local hasCached = false
	local cachedTable
	DBM.BattleMusic = battleMusic -- @Deprecated: Use new utility functions

	function DBM:GetBattleMusic()
		if not hasCached then
			cachedTable = {unpack(battleMusic)}
		end
		return cachedTable
	end

	function DBM:AddBattleMusic(text, value, length)
		tinsert(battleMusic, {
			text	= text,
			value	= value,
			length	= length
		})
		hasCached = false
	end
end

do
	-- Contains all music media, period
	local music = {
		{text = L.NONE,value  = "None"},
		{text = L.RANDOM,value  = "Random"},
		{text = "Anduin Part 1 B",value = 1417242, length=140},--"sound\\music\\Legion\\MUS_70_AnduinPt1_B.mp3" Soundkit: 68230
		{text = "Anduin Part 2 B",value = 1417248, length=111},--"sound\\music\\Legion\\MUS_70_AnduinPt2_B.mp3" Soundkit: 68230
		{text = "Bronze Jam",value = 350021, length=116},--"Sound\\Music\\ZoneMusic\\IcecrownRaid\\IR_BronzeJam.mp3" Soundkit: 118800
		{text = "Invincible",value = 1100052, length=197},--"Sound\\Music\\Draenor\\MUS_Invincible.mp3" Soundkit: 49536
		{text = "Nightsong",value = 441705, length=160},--"Sound\\Music\\cataclysm\\MUS_NightElves_GU01.mp3" Soundkit: 71181
		{text = "Ulduar: Titan Orchestra",value = 298910, length=102},--"Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_TitanOrchestraIntro.mp3" Soundkit: 15873
	}
	local hasCached = false
	local cachedTable
	DBM.Music = music -- @Deprecated: Use new utility functions

	function DBM:GetMusic()
		if not hasCached then
			cachedTable = {unpack(music)}
		end
		return cachedTable
	end

	function DBM:AddMusic(text, value, length)
		tinsert(music, {
			text	= text,
			value	= value,
			length	= length
		})
		hasCached = false
	end
end
