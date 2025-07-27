---@class DBM
local DBM = DBM

DBM.fileBrowserData["Interface\\AddOns\\DBM-Core\\sounds\\Anshlun"] = {
	count = 1,
	files = {
		{ type = "soundData", text = "Anshlun (ptBR)", value = "Anshlun", category = "count", max = 10}
	}
}

DBM.fileBrowserData["Interface\\AddOns\\DBM-Core\\sounds\\Bear"] = {
	count = 1,
	files = {
		{ type = "soundData", text = "Bear (Child)", value = "Bear", category = "count", max = 10}
	}
}

DBM.fileBrowserData["Interface\\AddOns\\DBM-Core\\sounds\\BlakbyrdAlerts"] = {
	count = 3,
	files = {
		{ type = "sound", text = "Blakbyrd Alert 1", category = "sound", fileName = "Alert1.ogg"},
		{ type = "sound", text = "Blakbyrd Alert 2", category = "sound", fileName = "Alert2.ogg"},
		{ type = "sound", text = "Blakbyrd Alert 3", category = "sound", fileName = "Alert3.ogg"}
	}
}

DBM.fileBrowserData["Interface\\AddOns\\DBM-Core\\sounds\\ClassicSupport"] = {
	count = 5,
	files = {
		{ type = "sound", text = "Algalon: Beware!", value = 543587, category = "classicSound", fileName = "UR_Algalon_BHole01.ogg"},
		{ type = "sound", text = "BB Wolf: Run Away", value = 552035, category = "classicSound", fileName = "HoodWolfTransformPlayer01"},
		{ type = "sound", text = "Illidan: Not Prepared", value = 552503, category = "classicSound", fileName = "Black_Illidan_04.ogg"},
		{ type = "sound", text = "Illidan: Not Prepared2", value = 1412178, category = "classicSound", fileName = "VO_703_Illidan_Stormrage_03.ogg"},
		{ type = "sound", text = "Kil'Jaeden: Destruction", value = 553193, category = "classicSound", fileName = "KILJAEDEN02.ogg"}
	}
}

DBM.fileBrowserData["Interface\\AddOns\\DBM-Core\\sounds\\Corsica"] = {
	count = 1,
	files = {
		{ type = "soundData", text = "Corsica", value = "Corsica", category = "count", max = 10}
	}
}

DBM.fileBrowserData["Interface\\AddOns\\DBM-Core\\sounds\\Defeat"] = {
	count = 11,
	files = {
		--"Sound\\Creature\\ALIZABAL\\VO_BH_ALIZABAL_RESET_01.ogg"
		{ type = "soundData", text = "Alizabal: Incompetent Raiders", value = 572130, length=4, category = "defeat", version = "cata"},
		--"Sound\\Creature\\bwonsamdi\\vo_801_bwonsamdi_35_m.ogg"
		{ type = "soundData", text = "Bwonsamdi: Over Your Head", value = 2016732, length=4, category = "defeat", version = "retail"},
		--"Sound\\Creature\\bwonsamdi\\vo_801_bwonsamdi_37_m.ogg"
		{ type = "soundData", text = "Bwonsamdi: Pour Little Thing", value = 2016734, length=4, category = "defeat", version = "retail"},
		--"Sound\\Creature\\bwonsamdi\\vo_801_bwonsamdi_38_m.ogg"
		{ type = "soundData", text = "Bwonsamdi: Impressive Death", value = 2016735, length=4, category = "defeat", version = "retail"},
		--"Sound\\Creature\\bwonsamdi\\vo_801_bwonsamdi_50_m.ogg"
		{ type = "soundData", text = "Bwonsamdi: All That Armor", value = 2016747, length=4, category = "defeat", version = "retail"},
		--"Sound\\Creature\\Kologarn\\UR_Kologarn_Slay02.ogg"
		{ type = "soundData", text = "Kologarn: You Fail", value = 553345, length=4, category = "defeat", version = "wrath"},
		--"Sound\\Creature\\Hodir\\UR_Hodir_Slay01.ogg"
		{ type = "soundData", text = "Hodir: Tragic", value = 552023, length=4, category = "defeat", version = "wrath"},
		--"sound/creature/scrollsage_nola/vo_801_scrollsage_nola_34_f.ogg"
		{ type = "soundData", text = "Scrollsage Nola: Cycle", value = 2015891, length=4, category = "defeat", version = "retail"},
		--"Sound\\Creature\\Thorim\\UR_Thorim_P1Wipe01.ogg"
		{ type = "soundData", text = "Thorim: Failures", value = 562111, length=4, category = "defeat", version = "wrath"},
		--"Sound\\Creature\\ValithriaDreamwalker\\IC_Valithria_Berserk01.ogg"
		{ type = "soundData", text = "Valithria: Failures", value = 563333, length=4, category = "defeat", version = "wrath"},
		--"Sound\\Creature\\YoggSaron\\UR_YoggSaron_Slay01.ogg"
		{ type = "soundData", text = "Yogg-Saron: Laugh", value = 564859, length=4, category = "defeat", version = "wrath"},
		--{ type = "sound", text = "Yoda Death", length=4, category = "defeat", version = "custom", fileName = "lego-yoda-death-sound-effect.ogg"}
	}
}


DBM.fileBrowserData["Interface\\AddOns\\DBM-Core\\sounds\\Kolt"] = {
	count = 1,
	files = {
		{ type = "soundData", text = "Koltrane", value = "Kolt", category = "count", max = 10}
	}
}

DBM.fileBrowserData["Interface\\AddOns\\DBM-Core\\sounds\\Mosh"] = {
	count = 1,
	files = {
		{ type = "soundData", text = "Moshne", value = "Mosh", category = "count", max = 5}
	}
}

DBM.fileBrowserData["Interface\\AddOns\\DBM-Core\\sounds\\Music"] = {
	count = 6,
	files = {
		--"sound\\music\\Legion\\MUS_70_AnduinPt1_B.mp3"
		{ type = "soundData", text = "Anduin Part 1 B", value = 1417242, length=140, category = "dungeonMusic", version = "retail"},
		--"Sound\\Music\\cataclysm\\MUS_NightElves_GU01.mp3" Soundkit: 71181
		{ type = "soundData", text = "Nightsong", value = 441705, length=160, category = "dungeonMusic", version = "cata"},
		--"Sound\\Creature\\bwonsamdi\\vo_801_bwonsamdi_37_m.ogg"
		{ type = "soundData", text = "Bwonsamdi: Pour Little Thing", value = 298910, length=102, category = "dungeonMusic", version = "wrath"},
		{ type = "soundData", text = "Anduin Part 2 B", value = 1417248, length=111, category = "battleMusic", version = "retail"},
		--"Sound\\Music\\ZoneMusic\\IcecrownRaid\\IR_BronzeJam.mp3" Soundkit: 118800
		{ type = "soundData", text = "Bronze Jam", value = 350021, length=116, category = "battleMusic", version = "wrath"},
		--"Sound\\Music\\Draenor\\MUS_Invincible.mp3" Soundkit: 49536
		{ type = "soundData", text = "Invincible", value = 1100052, length=197, category = "battleMusic", version = "wrath"},
		--{ type = "sound", text = "Yoda Death", length=4, category = "battleMusic", version = "custom", fileName = "lego-yoda-death-sound-effect.ogg"}
	}
}


DBM.fileBrowserData["Interface\\AddOns\\DBM-Core\\sounds\\Neryssa"] = {
	count = 1,
	files = {
		{ type = "soundData", text = "Neryssa (ptBR)", value = "Neryssa", category = "count", max = 10}
	}
}


DBM.fileBrowserData["Interface\\AddOns\\DBM-Core\\sounds\\Pewsey"] = {
	count = 1,
	files = {
		{ type = "soundData", text = "Pewsey", value = "Pewsey", category = "count", max = 10}
	}
}

DBM.fileBrowserData["Interface\\AddOns\\DBM-Core\\sounds\\Smooth"] = {
	count = 1,
	files = {
		{ type = "soundData", text = "Smooth", value = "Smooth", category = "count", max = 10}
	}
}

DBM.fileBrowserData["Interface\\AddOns\\DBM-Core\\sounds\\SmoothReverb"] = {
	count = 1,
	files = {
		{ type = "soundData", text = "Smooth (Reverb)", value = "SmoothR", category = "count", max = 10}
	}
}

DBM.fileBrowserData["Interface\\AddOns\\DBM-Core\\sounds\\SoundClips"] = {
	count = 7,
	files = {
		{ type = "sound", text = "Jaina: Beware", category = "sound", fileName = "beware.ogg"},
		{ type = "sound", text = "Jaina: Beware (reverb)", category = "sound", fileName = "beware_with_reverb.ogg"},
		{ type = "sound", text = "Thrall: That's Incredible!", category = "sound", fileName = "incredible.ogg"},
		{ type = "sound", text = "Saurfang: Don't Die", category = "sound", fileName = "dontdie.ogg"},
		{ type = "sound", text = "AirHorn (DBM)", category = "sound", fileName = "AirHorn.ogg"},
		{ type = "sound", text = "RangeFrameSound1", category = "range_sound", fileName = "blip_8.ogg"},
		{ type = "sound", text = "RangeFrameSound2", category = "range_sound", fileName = "alarmclockbeeps.ogg"}
	}
}

DBM.fileBrowserData["Interface\\AddOns\\DBM-Core\\sounds\\SpecialAnnouncements"] = {
	count = 10,
	files = {
		{ type = "soundData", text = "Blizzard Raid Emote", value = 876098, category = "specialAnnouncement", version = "retail" },
		{ type = "soundData", text = "Headless Horseman: Laugh", value = 551703, category = "specialAnnouncement", version = "wrath" },
		{ type = "soundData", text = "Kaz'rogal: Marked", value = 553050, category = "specialAnnouncement", version = "wrath" },
		{ type = "soundData", text = "Lady Malande: Flee", value = 553566, category = "specialAnnouncement", version = "wrath" },
		{ type = "soundData", text = "Loatheb: I see you", value = 554236, category = "specialAnnouncement", version = "classic" },
		{ type = "soundData", text = "Milhouse: Light You Up", value = 555337, category = "specialAnnouncement", version = "wrath" },
		{ type = "soundData", text = "Night Elf Bell", value = 566558, category = "specialAnnouncement", version = "classic" },
		{ type = "soundData", text = "PvP Flag", value = 569200, category = "specialAnnouncement", version = "classic" },
		{ type = "soundData", text = "Void Reaver: Marked", value = 563787, category = "specialAnnouncement", version = "wrath" },
		{ type = "soundData", text = "Yogg Saron: Laugh", value = 564859, category = "specialAnnouncement", version = "wrath" }
	}
}

DBM.fileBrowserData["Interface\\AddOns\\DBM-Core\\sounds\\Victory"] = {
	count = 3,
	files = {
		{ type = "sound", text = "Blakbyrd: FF Fanfare", length=4, category = "victory", fileName="bbvictory.ogg"},
		{ type = "sound", text = "SMG: FF Fanfare", length=4, category = "victory", fileName="SmoothMcGroove_Fanfare.ogg"},
		{ type = "sound", text = "Yoda Death", length=4, category = "victory", fileName="lego-yoda-death-sound-effect.ogg"}
	}
}