DBM_SERPENT_TAB	= "SCTab"
if GetLocale() == "enGB" or GetLocale() == "enUS" then
	DBM_COILFANG	= "Serpentshrine Cavern";
end

-- Hydross the Unstable
DBM_HYDROSS_NAME			= "Hydross the Unstable";
DBM_HYDROSS_DESCRIPTION		= "Announces marks, phases and Water Tomb.";
DBM_HYDROSS_OPTION_1		= "Show range check frame";
DBM_HYDROSS_OPTION_2		= "Announce marks";
DBM_HYDROSS_OPTION_3		= "Show 5 second warnings for all marks";
DBM_HYDROSS_OPTION_4		= "Announce phases";
DBM_HYDROSS_OPTION_5		= "Announce Water Tomb";
DBM_HYDROSS_OPTION_NATURE	= "Mark of Corruption"
DBM_HYDROSS_OPTION_FROST	= "Mark of Hydross"

DBM_HYDROSS_YELL_PULL		= "I cannot allow you to interfere!";
DBM_HYDROSS_YELL_NATURE		= "Aaghh, the poison...";
DBM_HYDROSS_YELL_FROST		= "Better, much better.";

DBM_HYDROSS_FROST_MARK_NOW	= "*** Frost Mark #%s ***";
DBM_HYDROSS_NATURE_MARK_NOW	= "*** Nature Mark #%s ***";
DBM_HYDROSS_FROST_SOON		= "*** Frost Mark #%s in 5 sec ***";
DBM_HYDROSS_NATURE_SOON		= "*** Nature Mark #%s in 5 sec ***";

DBM_HYDROSS_FROST_PHASE		= "*** Frost Phase ***";
DBM_HYDROSS_NATURE_PHASE	= "*** Nature Phase ***";

DBM_HYDROSS_TOMB_WARN		= "*** >%s< is afflicted by Water Tomb ***";

-- Morogrim Tidewalker
DBM_TIDEWALKER_NAME					= "Morogrim Tidewalker";
DBM_TIDEWALKER_DESCRIPTION			= "Announces Watery Grave and Murlocs.";
DBM_TIDEWALKER_OPTION_1				= "Announce Murlocs";
DBM_TIDEWALKER_OPTION_2				= "Announce Watery Grave";

DBM_TIDEWALKER_YELL_PULL			= "Flood of the deep, take you!";
DBM_TIDEWALKER_EMOTE_MURLOCS		= "The violent earthquake has alerted nearby Murlocs!";
DBM_TIDEWALKER_EMOTE_GLOBES			= "%s summons watery globules!";
DBM_TIDEWALKER_EMOTE_GRAVE			= "%s sends his enemies to their watery graves!";
DBM_TIDEWALKER_DEBUFF_GRAVE			= "([^%s]+) (%w+) afflicted by Watery Grave.";

DBM_TIDEWALKER_WARN_MURLOCS			= "*** Murlocs ***";
DBM_TIDEWALKER_WARN_MURLOCS_SOON	= "*** Murlocs soon ***";
DBM_TIDEWALKER_WARN_GRAVE			= "*** Watery Grave on %s ***";
DBM_TIDEWALKER_WARN_GLOBES			= "*** Watery Globules ***";

-- Fathom-Lord Karathress
DBM_FATHOMLORD_NAME					= "Fathom-Lord Karathress";
DBM_FATHOMLORD_DESCRIPTION			= "Announces Spitfire Totems and Healing Wave.";

DBM_FATHOMLORD_YELL_PULL			= "Guards, attention! We have visitors....";
DBM_FATHOMLORD_OPTION_TOTEM_1		= "Announce Fathom-Guard Tidalvess' Spitfire Totem";
DBM_FATHOMLORD_OPTION_TOTEM_2		= "Announce Fathom-Lord Karathress' Spitfire Totem";
DBM_FATHOMLORD_OPTION_HEAL			= "Announce Healing Wave";

DBM_FATHOMLORD_TIDALVESS_TOTEM		= "Fathom-Guard Tidalvess casts Spitfire Totem.";
DBM_FATHOMLORD_KARATHRESS_TOTEM		= "Fathom-Lord Karathress casts Spitfire Totem.";
DBM_FATHOMLORD_CAST_HEAL			= "Fathom-Guard Caribdis begins to cast Healing Wave.";

DBM_FATHOMLORD_SFTOTEM1_WARN		= "*** Spitfire Totem @ Tidalvess ***";
DBM_FATHOMLORD_SFTOTEM2_WARN		= "*** Spitfire Totem @ Karathress ***";
DBM_FATHOMLORD_HEAL_WARN			= "*** Healing Wave ***";

-- The Lurker Below
DBM_LURKER_NAME						= "The Lurker Below";
DBM_LURKER_DESCRIPTION				= "Announces Submerge, Emerge, Spout and Whirl. The \"Whirl soon\" warning is unreliable because it uses this ability every 18-28 seconds.";
DBM_LURKER_OPTION_WHIRL				= "Announce Whirl";
DBM_LURKER_OPTION_WHIRLSOON			= "Show \"Whirl soon\" warning";
DBM_LURKER_OPTION_SPOUT				= "Announce Spout";

DBM_LURKER_EMOTE_SPOUT				= "%s takes a deep breath!";
DBM_LURKER_CAST_SPOUT				= "The Lurker Below%s*'s Spout";
DBM_LURKER_CAST_WHIRL				= "The Lurker Below%s*'s Whirl";
DBM_LURKER_CAST_GEYSER				= "The Lurker Below%s*'s Geyser hits ([^%s]+) for";

DBM_LURKER_WARN_SPOUT_SOON			= "*** Spout soon ***";
DBM_LURKER_WARN_SPOUT				= "*** Spout ***";
DBM_LURKER_WARN_SUBMERGE			= "*** Submerged ***";
DBM_LURKER_WARN_EMERGE				= "*** Emerged ***";

DBM_LURKER_WARN_WHIRL				= "*** Whirl ***";
DBM_LURKER_WARN_WHIRL_SOON			= "*** Whirl soon ***";

DBM_LURKER_WARN_SUBMERGE_SOON		= "*** Submerge in %s sec ***";

-- Leotheras the Blind
DBM_LEO_NAME						= "Leotheras the Blind";
DBM_LEO_DESCRIPTION					= "Announces Whirlwind, Insidious Whisper and his phases.";
DBM_LEO_OPTION_WHIRL				= "Announce Whirlwind";
DBM_LEO_OPTION_DEMON				= "Announce Inner Demons";
DBM_LEO_OPTION_DEMONWARN			= "Announce Inner Demons targets";

DBM_LEO_YELL_PULL					= "Finally, my banishment ends!";
DBM_LEO_YELL_DEMON					= "Be gone, trifling elf%.%s*I am in control now!"; -- stupid spaces...there are 2 spaces at the moment :[
DBM_LEO_YELL_SHADOW					= "No... no! What have you done? I am the master! Do you hear me? I am... aaggh! Can't... contain him.";
DBM_LEO_YELL_WHISPER				= "We all have our demons";

DBM_LEO_WARN_ENRAGE					= "*** Enrage in %s %s ***";
DBM_LEO_WARN_WHIRL					= "*** Whirlwind ***";
DBM_LEO_WARN_WHIRL_SOON				= "*** Whirlwind in 5 sec ***";
DBM_LEO_WARN_WHIRL_SOON_2			= "*** Whirlwind soon ***";
DBM_LEO_WARN_WHIRL_FADED			= "*** Whirlwind faded ***";
DBM_LEO_WARN_SHADOW					= "*** Shadow of Leotheras spawned ***";
DBM_LEO_WARN_DEMON_PHASE			= "*** Demon Phase ***";
DBM_LEO_WARN_NORMAL_PHASE			= "*** Normal Phase ***";
DBM_LEO_WARN_DEMON_PHASE_SOON		= "*** Demon Phase in 5 sec ***";
DBM_LEO_WARN_NORMAL_PHASE_SOON		= "*** Normal Phase in 5 sec ***";
DBM_LEO_SPECWARN_INNER_DEMON		= "Inner Demon";
DBM_LEO_WHISPER_INNER_DEMON			= "Kill your inner demon!"
DBM_LEO_WARN_DEMONS_INC				= "*** Inner Demons incoming ***";
DBM_LEO_WARN_DEMONS_NOW				= "*** Inner Demons ***";
DBM_LEO_WARN_DEMON_TARGETS			= "*** Inner Demons on: %s ***";

-- Lady Vashj
DBM_VASHJ_NAME						= "Lady Vashj";
DBM_VASHJ_DESCRIPTION				= "Announce Static Charge, spawns, phases, Tainted Cores, Magic Barriers and Enrage."

DBM_VASHJ_OPTION_RANGECHECK			= "Show distance frame";
DBM_VASHJ_OPTION_CHARGE				= "Announce Static Charge";
DBM_VASHJ_OPTION_CHARGEICON			= "Set icons on static charge targets";
DBM_VASHJ_OPTION_SPAWNS				= "Announce spawns in phase 2";
DBM_VASHJ_OPTION_COREWARN			= "Announce who loots the Tainted Cores";
DBM_VASHJ_OPTION_COREICON			= "Set icon on players with a Tainted Core";
DBM_VASHJ_OPTION_CORESPECWARN		= "Show special warning if you receive a Tainted Core";


DBM_VASHJ_YELL_PULL1				= "I spit on you, surface filth! ";
DBM_VASHJ_YELL_PULL2				= "Victory to Lord Illidan! ";
DBM_VASHJ_YELL_PULL3 				= "Death to the outsiders! Victory to Lord Illidan! ";
DBM_VASHJ_YELL_PULL4				= "I did not wish to low myself by engaging your kind, but you leave me little coice... ";
DBM_VASHJ_YELL_PHASE2				= "The time is now! Leave none standing!";
DBM_VASHJ_ELEMENT_DIES				= "Tainted Elemental";
DBM_VASHJ_YELL_PHASE3				= "You may want to take cover.";
DBM_VASHJ_LOOT						= "([^%s]+).*Hitem:(%d+)";

DBM_VASHJ_WARN_CHARGE				= "*** Static Charge on >%s< ***";
DBM_VASHJ_SPECWARN_CHARGE			= "Static Charge on you!";

DBM_VASHJ_WARN_PHASE2				= "*** Phase 2 ***";
DBM_VASHJ_WARN_ELE_SOON				= "*** Tainted Elemental in 5 sec ***";
DBM_VASHJ_WARN_ELE_NOW				= "*** Tainted Elemental spawned ***";
DBM_VASHJ_WARN_STRIDER_SOON			= "*** Strider in 5 sec ***";
DBM_VASHJ_WARN_STRIDER_NOW			= "*** Strider spawned ***";
DBM_VASHJ_WARN_NAGA_SOON			= "*** Naga in 5 sec ***";
DBM_VASHJ_WARN_NAGA_NOW				= "*** Naga spawned ***";
DBM_VASHJ_WARN_SHIELD_FADED			= "*** Shield %d/4 down ***";
DBM_VASHJ_WARN_CORE_LOOT			= "*** >%s< has the Tainted Core ***";
DBM_VASHJ_SPECWARN_CORE				= "You have the Tainted Core!";

DBM_VASHJ_WARN_PHASE3				= "*** Shield 4/4 down - Phase 3 ***";
DBM_VASHJ_WARN_ENRAGE				= "*** Enrage in %s %s ***";



