-- Traducción por Herenvarno C'thun


if (GetLocale()=="esES") then
	DBM_BGMOD_LANG["THANKS"] 		= "Gracias pecadores por usarme";
	DBM_BGMOD_LANG["WINS"]			= "¡La (%w+) gana!"; 
	DBM_BGMOD_LANG["BEGINS"]		= "Campo de Batalla en";
	DBM_BGMOD_LANG["ALLIANCE"]		= "Alianza";
	DBM_BGMOD_LANG["HORDE"]		= "Horda";
	DBM_BGMOD_LANG["ALLI_TAKE_ANNOUNCE"] 	= "*** La Alianza ha tomado %s  ***";
	DBM_BGMOD_LANG["HORDE_TAKE_ANNOUNCE"]	= "*** La Horda ha tomado %s ***";


		-- AV
	DBM_BGMOD_LANG["AV_ZONE"] 		= "Valle de Alterac";
	DBM_BGMOD_LANG["AV_START60SEC"]	= "1 minuto para que dé comienzo la batalla por el Valle de Alterac.";
	DBM_BGMOD_LANG["AV_START30SEC"]	= "30 segundos para que dé comienzo la batalla por el Valle de Alterac.";
	DBM_BGMOD_LANG["AV_TURNININFO"] 	= "Auto turn-in reputation items";
	DBM_BGMOD_LANG["AV_NPC"] 		= {
			["SMITHREGZAR"] = "Schmied Regzar", -- armor
			["PRIMALISTTHURLOGA"] = "Primalist Thurloga", -- icelord
			["WINGCOMMANDERJEZTOR"] = "Comandante del Aire Jeztor", 
			["WINGCOMMANDERGUSE"] = "Comandante del Aire Guse",
			["WINGCOMMANDERMULVERICK"] = "Comandante del Aire Mulverick",
			["MURGOTDEEPFORGE"] = "Murgot Deepforge", -- armor
			["ARCHDRUIDRENFERAL"] = "Arch Druid Renferal", -- forestlord
			["WINGCOMMANDERVIPORE"] = "Comandante del Aire Vipore",
			["WINDCOMMANDERSLIDORE"] = "Comandante del Aire Slidore",
			["WINGCOMMANDERICHMAN"] = "Comandante del Aire Ichman",
			["STORMPIKERAMRIDERCOMMANDER"] = "Stormpike Ram Rider Commander", -- riders
			["FROSTWOLFWOLFRIDERCOMMANDER"] = "Frostwolf Wolf Rider Commander",
		};
	DBM_BGMOD_LANG["AV_ITEM"] 		= {
			["ARMORSCRAPS"] = "Trocitos de armadura",
			["SOLDIERSBLOOD"] = "Sangre de Soldado Picotormenta",
			["LIEUTENANTSFLESH"] = "Carne de Teniente Picotormenta",
			["SOLDIERSFLESH"] = "Carne de Soldado Picotormenta",
			["COMMANDERSFLESH"] = "Carne de Comandante Picotormenta";
			["STORMCRYSTAL"] = "Cristal de tormenta",
			["LIEUTENANTSMEDAL"] = "Medalla de Teniente Lobo Gélido",
			["SOLDIERSMEDAL"] = "Medalla de Soldado Lobo Gélido",
			["COMMANDERSMEDAL"] = "Medalla de Comandante Lobo Gélido",
			["FROSTWOLFHIDE"] = "Pellejo Lobo Gélido",
			["ALTERACRAMHIDE"] = "Pellejo Carnero de Alterac",
		};
	DBM_BGMOD_LANG["AV_TARGETS"] 		= {
			"Puesto de Auxilio Pico Tormenta",
			"Búnker Norte de Dun Baldar",
			"Búnker Sur de Dun Baldar",
			"Cementerio Pico Tormenta",
			"Búnker de Ala Gélida",
			"Cementerio Piedrahogar",
			"Búnker Piedrahogar",
			"Cementerio Avalancha",
			"Torre Sangre Fría",
			"Cementerio Sangre Fría",
			"Torre de la Punta",
			"Cementerio Lobo Gélido",
			"La Torre Oeste Lobo Gélido",
			"La Torre Este Lobo Gélido",
			"Puesto de Auxilio Lobo Gélido"
	};
	DBM_BGMOD_LANG["AV_UNDERATTACK"]	= "¡(.*) (.+) (.*)! ¡Si no hacemos algo, la (%w+) (.*)!";
	DBM_BGMOD_LANG["AV_WASTAKENBY"]	= "La (%w+) ha (.*) (.+)";
	DBM_BGMOD_LANG["AV_WASDESTROYED"]	= "(.+) fue destruido por la (%w+)!";	
	--DBM_BGMOD_LANG["AV_IVUS"]		= "Wicked, Wicked, Mortals! The forest weeps";
	--DBM_BGMOD_LANG["AV_ICEY"]		= "WHO DARES SUMMON LOKHOLAR";


		-- AB
	DBM_BGMOD_LANG["AB_ZONE"] = "Cuenca de Arathi";
	DBM_BGMOD_LANG["AB_INFOFRAME_INFO"]	= "Show estimated final points";
	DBM_BGMOD_LANG["AB_START60SEC"] = "1 minuto para que dé comienzo la batalla por la Cuenca de Arathi.";
	DBM_BGMOD_LANG["AB_START30SEC"] = "30 segundos para que dé comienzo la batalla por la Cuenca de Arathi.";
	DBM_BGMOD_LANG["AB_CLAIMSTHE"] = "(.+) claims the (.+)!  If left unchallenged, the (%w+) will control it in 1 minute!";
	DBM_BGMOD_LANG["AB_HASTAKENTHE"] = "La (%w+) ha tomado (.+)!";
	DBM_BGMOD_LANG["AB_HASDEFENDEDTHE"] = "(.+) ha defendido (.+)!";
	DBM_BGMOD_LANG["AB_HASASSAULTED"] = "ha asaltado";
	DBM_BGMOD_LANG["AB_SCOREEXP"] = "Bases: (%d+)  Recursos: (%d+)/2000"; -- beware of the dual spaces
	DBM_BGMOD_LANG["AB_WINALLY"] = "Alianza gana en";
	DBM_BGMOD_LANG["AB_WINHORDE"] = "Horda gana en";
	DBM_BGMOD_LANG["AB_TARGETS"] 		= {
			"granja",
			"serrería",
			"herrería",
			"mina",
			"Establos"
		};

	DBM_BGMOD_LANG["AB_TARGETS_ANNOUNCE"] 		= {
			"La Granja",
			"La Serrería",
			"La Herrería",
			"La mina",
			"Los Establos"
	};
		
		-- WSG
	DBM_BGMOD_LANG["WSG_ZONE"] = "Grito de guerra";
	DBM_BGMOD_LANG["WSG_START60SEC"] = "Comenzamos en 1 Minuto.";
	DBM_BGMOD_LANG["WSG_START30SEC"] = "Comenzamos en 30 segundos";
	DBM_BGMOD_LANG["WSG_INFOFRAME_INFO"] = "Show flag carrier";
	DBM_BGMOD_LANG["WSG_FLAG_PICKUP"] = "The (%w+) .lag was picked up by (.+)!";
	DBM_BGMOD_LANG["WSG_FLAG_RETURN"] = "The (%w+) .lag was returned to its base by (.+)!";
	DBM_BGMOD_LANG["WSG_ALLYFLAG"] = "Bandera de la Alianza: ";
	DBM_BGMOD_LANG["WSG_HORDEFLAG"] = "Bandera de la Horda: ";
	DBM_BGMOD_LANG["WSG_FLAG_BASE"] = "Base";
	DBM_BGMOD_LANG["WSG_HASCAPTURED"] = "¡¡(.+) ha capturado la bandera de la (%w+)!!";

	--added 9.12
	DBM_BGMOD_LANG["ARENA_BEGIN"]		= "One minute until the Arena battle begins!";
	DBM_BGMOD_LANG["ARENA_BEGIN30"]	= "Thirty seconds until the Arena battle begins!";
	DBM_BGMOD_LANG["ARENA_BEGIN15"]	= "Fifteen seconds until the Arena battle begins!";
	


	-- DBM_SBT["Flag respawn"] = "Bandera reaparece en";
	-- DBM_SBT["Ivus spawn"] = "";
	-- DBM_SBT["Ice spawn"] = "";
	DBM_SBT["Begins"] = DBM_BGMOD_LANG["BEGINS"];
	DBM_SBT["AB_WINHORDE"] = DBM_BGMOD_LANG.AB_WINHORDE;
	DBM_SBT["AB_WINALLY"] = DBM_BGMOD_LANG.AB_WINALLY;
	DBM_BGMOD_LANG["SHOW_INV_TIMER"] = "Show battleground join timer";
	DBM_BGMOD_LANG["COLOR_BY_CLASS"] = "Set name color to class color in the score frame";
	
	
	DBM_BGMOD_LANG["AB_DESCRIPTION"]	= "Control de timers de bases.";
	DBM_BGMOD_LANG["AV_DESCRIPTION"]	= "Control de los timers de cementerios y torres.";
	DBM_BGMOD_LANG["WS_DESCRIPTION"]	= "Control de Banderas";
	

	DBM_ARENAS				= "Arenas";
	DBM_ARENAS_DESCRIPTION	= "Temporizadores de arenas";

	
	-- eye of the storm

	DBM_EOTS_NAME			= "Ojo de la Tormenta";
	DBM_EOTS_DESCRIPTION	= "Muestra el tiempo estimado hasta qeu un bando gane.";

	DBM_EOTS_BEGINS_60		= "The battle begins in 1 minute!";
	DBM_EOTS_BEGINS_30		= "The battle begins in 30 seconds!";

	DBM_EOTS_FLAG_TAKEN		= "(.+) has taken the flag!";
	DBM_EOTS_FLAG_RESET		= "The flag has been reset!";
	DBM_EOTS_FLAG_CAPTURED	= "The .+ ha%w+ captured the flag!"; 
	DBM_EOTS_FLAG_DROPPED	= "The flag has been dropped!";

	DBM_EOTS_POINTS			= "Bases: (%d+)  Puntos de Victoria: (%d+)/2000";
	DBM_EOTS_FLAG			= "Bandera";	

	DBM_SBT["Alliance wins in"] = "Alianza gana en";
	DBM_SBT["Horde wins in"] = "Horda gana en";
	

	DBM_BGMOD_OPTION_AUTOSPIRIT			= "Auto-release spirit"
	
	DBM_BGMOD_AV_BARS = {
		[13] = "La Torre Oeste Lobo Gélido",
		[14] = "La Torre Este Lobo Gélido",
	}
end
