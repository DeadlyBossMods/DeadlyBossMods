if (GetLocale()=="ruRU") then
--[[
DBM_BGMOD_LANG = {}
DBM_BGMOD_LANG["NAME"] 		= "Поля Боя";
DBM_BGMOD_LANG["INFO"] 		                            = "Показать таймеры для Альтеракской долины и Низины Арати. "
					.."Отображает также курьера Ущелья Песни Войны и позволяет использовать авто-сдачу квестовых предметов из Альтеракской долины.";

DBM_BGMOD_LANG["THANKS"] 		= "Спасибо за использование La Vendetta Boss Mods! :)";
DBM_BGMOD_LANG["WINS"]			= "The (%w+) wins";
DBM_BGMOD_LANG["BEGINS"]		= "Игра начнется через";	-- BAR
DBM_BGMOD_LANG["ALLIANCE"]		= "Альянс";
DBM_BGMOD_LANG["HORDE"]		= "Орда";
DBM_BGMOD_LANG["ALLI_TAKE_ANNOUNCE"] 	= "*** Альянсом захвачен(о) %s ***";
DBM_BGMOD_LANG["HORDE_TAKE_ANNOUNCE"]	= "*** Ордой захвачен(о) %s ***";

		-- AV
DBM_BGMOD_LANG["AV_ZONE"] 		= "Альтеракская долина";
DBM_BGMOD_LANG["AV_START60SEC"]	= "1 минута до начала битвы за Альтеракскую Долину.";
DBM_BGMOD_LANG["AV_START30SEC"]	= "30 секунд до начала битвы за Альтеракскую Долину.";
DBM_BGMOD_LANG["AV_TURNININFO"] 	= "Авто-сдача предметов для репутации";
DBM_BGMOD_LANG["AV_NPC"] = {}
DBM_BGMOD_LANG["AV_NPC"]["SMITHREGZAR"] 			    = "Кузнец Регзар";  -- armor
DBM_BGMOD_LANG["AV_NPC"]["PRIMALISTTHURLOGA"] 			= "Старейшина Турлога"; -- icelord
DBM_BGMOD_LANG["AV_NPC"]["WINGCOMMANDERJEZTOR"] 		= "Командир звена Мааша";		
DBM_BGMOD_LANG["AV_NPC"]["WINGCOMMANDERGUSE"] 			= "Командир звена Смуггл";
DBM_BGMOD_LANG["AV_NPC"]["WINGCOMMANDERMULVERICK"]	 	= "Командир звена Малверик";
DBM_BGMOD_LANG["AV_NPC"]["MURGOTDEEPFORGE"] 			= "Мургот Подземная Кузня";	-- armor
DBM_BGMOD_LANG["AV_NPC"]["ARCHDRUIDRENFERAL"] 			= "Верховный друид Дикая Лань";    -- forestlord
DBM_BGMOD_LANG["AV_NPC"]["WINGCOMMANDERVIPORE"] 		= "Командир звена Сквороц";
DBM_BGMOD_LANG["AV_NPC"]["WINDCOMMANDERSLIDORE"]	 	= "Командир звена Макарч";
DBM_BGMOD_LANG["AV_NPC"]["WINGCOMMANDERICHMAN"] 		= "Командир звена Ичман";
DBM_BGMOD_LANG["AV_NPC"]["STORMPIKERAMRIDERCOMMANDER"]	= "Командир наездников на баранах из клана Грозовой Вершины";
DBM_BGMOD_LANG["AV_NPC"]["FROSTWOLFWOLFRIDERCOMMANDER"]	= "Командир наездников на волках клана Северного Волка";
DBM_BGMOD_LANG["AV_ITEM"] = {}
DBM_BGMOD_LANG["AV_ITEM"]["ARMORSCRAPS"] 	            = "Обломки брони";
DBM_BGMOD_LANG["AV_ITEM"]["SOLDIERSBLOOD"] 	            = "Кровь солдата Грозовой Вершины";
DBM_BGMOD_LANG["AV_ITEM"]["LIEUTENANTSFLESH"] 	        = "Плоть лейтенанта Грозовой Вершины";
DBM_BGMOD_LANG["AV_ITEM"]["SOLDIERSFLESH"] 	            = "Плоть солдата Грозовой Вершины";
DBM_BGMOD_LANG["AV_ITEM"]["COMMANDERSFLESH"] 	        = "Плоть командира Грозовой Вершины";
DBM_BGMOD_LANG["AV_ITEM"]["STORMCRYSTAL"] 	            = "Кристалл Бури";
DBM_BGMOD_LANG["AV_ITEM"]["LIEUTENANTSMEDAL"] 	        = "Жетон лейтенанта Северного Волка";
DBM_BGMOD_LANG["AV_ITEM"]["SOLDIERSMEDAL"] 	            = "Жетон солдата Северного Волка";
DBM_BGMOD_LANG["AV_ITEM"]["COMMANDERSMEDAL"] 	        = "Жетон командира Северного Волка";
DBM_BGMOD_LANG["AV_ITEM"]["FROSTWOLFHIDE"] 	            = "Шкура Северного волка";
DBM_BGMOD_LANG["AV_ITEM"]["ALTERACRAMHIDE"] 	        = "Шкура альтеракского барана";
DBM_BGMOD_LANG["AV_TARGETS"] = {
		"Лазарет Грозовой Вершины",
		"Северный Оплот Дун Болдара",
		"Южный Оплот Дун Болдара",
		"Кладбище Грозовой Вершины",
		"Укрытие Ледяного Крыла",
		"Кладбище Каменного Очага",
		"Укрытие Каменного Очага",
		"Кладбище Снегопада",
		"Башня Стылой Крови",
		"Кладбище Стылой Крови",
		"Смотровая башня",
		"Кладбище Северного Волка",
		"Западная башня Северного Волка",
		"Восточная башня Северного Волка",
		"Приют Северного Волка"
};

DBM_BGMOD_LANG["AV_TARGET_TYPE"] = { --not really a localization table... -> DO NOT TRANSLATE!
	"graveyard",
	"tower",
	"tower",
	"graveyard",
	"tower",
	"graveyard",
	"tower",
	"graveyard",
	"tower",
	"graveyard",
	"tower",
	"graveyard",
	"tower",
	"tower",
	"graveyard",
};

DBM_BGMOD_LANG["AV_UNDERATTACK"]	                = "(.+) - под атакой!  Если оставившеся неконтролируемыме, (%w+), будет (%w+).";	-- Graveyard // Tower
DBM_BGMOD_LANG["AV_WASTAKENBY"]	                    = "(.+) был захвачен (%w+)!";
DBM_BGMOD_LANG["AV_WASDESTROYED"]	                = "(.+) был разрушен (%w+)!";
DBM_BGMOD_LANG["AV_IVUS"]							= "Wicked, Wicked, Mortals! The forest weeps";
DBM_BGMOD_LANG["AV_ICEY"]							= "It is done! The Ice Lord has arrived! Bow to the might of the Horde, fools!";

		-- AB
DBM_BGMOD_LANG["AB_ZONE"] 		                    = "Низина Арати";
DBM_BGMOD_LANG["AB_INFOFRAME_INFO"]	                = "Показать предполагаемый счет в финале";
DBM_BGMOD_LANG["AB_START60SEC"]	                    = "Битва за Низину Арати начнется через минуту.";
DBM_BGMOD_LANG["AB_START30SEC"]	                    = "Битва за Низину Арати начнется через 30 секунд.";
DBM_BGMOD_LANG["AB_CLAIMSTHE"]	                    = "(.+) требуется (.+)! Если нет соперников, (%w+) будет под контролем через 1 минуту!";
DBM_BGMOD_LANG["AB_HASTAKENTHE"]	                = "(%w+) захватил (.+)!";
DBM_BGMOD_LANG["AB_HASDEFENDEDTHE"]	                = "(.+) отразил (.+) нападение на (.+)!";
DBM_BGMOD_LANG["AB_HASASSAULTED"]	                = "атакует";
DBM_BGMOD_LANG["AB_SCOREEXP"] 		                = "Базы: (%d+) Ресурсы: (%d+)/2000";
DBM_BGMOD_LANG["AB_WINALLY"] 		                = "Альянс победит через:";
DBM_BGMOD_LANG["AB_WINHORDE"] 		                = "Орда победит через:";
DBM_BGMOD_LANG["AB_TARGETS"] 		= {
		"ферму",
		"лесопилку",
		"кузницу",
		"рудник",
		"стойла"
	};

		-- WSG
DBM_BGMOD_LANG["WSG_ZONE"] 		                    = "Ущелье Песни Войны";
DBM_BGMOD_LANG["WSG_START60SEC"]	                = "Битва за Ущелье Песни Войны начнется через 1 минуту.";
DBM_BGMOD_LANG["WSG_START30SEC"]	                = "Битва за Ущелье Песни Войны начнется через 30 секунд. Подготовьтесь!";
DBM_BGMOD_LANG["WSG_INFOFRAME_INFO"]	            = "Показать флагоносца";
DBM_BGMOD_LANG["WSG_FLAG_PICKUP"] 	                = "Флаг (%w+) у (.+)!";			-- . because the F is not allways large char 
DBM_BGMOD_LANG["WSG_FLAG_RETURN"]	                = "(%w+) вернул на базу флаг (.+)!";
DBM_BGMOD_LANG["WSG_ALLYFLAG"]		                = "Флаг Альянса: ";
DBM_BGMOD_LANG["WSG_HORDEFLAG"]	                    = "Флаг Орды: ";
DBM_BGMOD_LANG["WSG_FLAG_BASE"]	                    = "База";  				-- not found in Warsong.lua
DBM_BGMOD_LANG["WSG_HASCAPTURED"]	                = "(.+) захватил флаг (%w+)!";
DBM_BGMOD_LANG["WSG_FLAGRESPAWN"] 		            = "Флаг появляется";

		-- NEW Added 08.11.06
DBM_BGMOD_LANG["WSG_INFOFRAME_TITLE"]	            = "Захват флага на УПВ";
DBM_BGMOD_LANG["WSG_INFOFRAME_TEXT"]	            = "Показать флагоносца";
DBM_BGMOD_LANG["AB_STRINGALLIANCE"]	                = "Альянс:";
DBM_BGMOD_LANG["AB_STRINGHORDE"]	                = "Орда:";
DBM_BGMOD_LANG["WSG_BOOTS_EXPR"]	                = "под воздействием эффекта Скорость";


-- ADDED 9.12.06
DBM_BGMOD_LANG["ARENA_BEGIN"]		                = "Битва на Арене начнется через 1 минуту!";
DBM_BGMOD_LANG["ARENA_BEGIN30"]	                    = "Битва на Арене начнется через 30 секунд!";
DBM_BGMOD_LANG["ARENA_BEGIN15"]	                    = "Битва на Арене начнется через 15 секунд!";

--DBM_BGMOD_EN_TARGET_AV = DBM_BGMOD_LANG.AV_TARGETS; <-- the variable ..._EN_... should always point to the english localizations (which are used to sync timers)
--DBM_BGMOD_EN_TARGET_AB = DBM_BGMOD_LANG.AB_TARGETS;

DBM_SBT["Begins"] = DBM_BGMOD_LANG["BEGINS"];
DBM_SBT["AB_WINHORDE"] = DBM_BGMOD_LANG.AB_WINHORDE;
DBM_SBT["AB_WINALLY"] = DBM_BGMOD_LANG.AB_WINALLY;

-- 17.12.06
DBM_BGMOD_LANG["COLOR_BY_CLASS"] = "Показывать класс цветом в таблице очков";
DBM_BGMOD_LANG["SHOW_INV_TIMER"] = "Показывать таймер на вход на БГ"


--added 2.1.07

DBM_BGMOD_LANG["AB_DESCRIPTION"]	= "Показывает время до захвата и вычисляет время до конца битвы.";
DBM_BGMOD_LANG["AV_DESCRIPTION"]	= "Показывать таймеры для башен и кладбонов.";
DBM_BGMOD_LANG["WS_DESCRIPTION"]	= "Показывать флагоносца";


--added 7.1.07
DBM_BGMOD_LANG["UPGRADETROOPS"]		            = "обновление до";


DBM_ARENAS				= "Арены";
DBM_ARENAS_DESCRIPTION	= "Показывать таймеры на аренах.";



-- eye of the storm
DBM_EOTS_NAME			                        = "Око Бури";
DBM_EOTS_DESCRIPTION	                        = "Показать время до победы и флагоносца.";

DBM_EOTS_BEGINS_60		                        = "Битва начнется через минуту!";
DBM_EOTS_BEGINS_30		                        = "Битва начнется через 30 секунд!";

DBM_EOTS_FLAG_TAKEN		                        = "(.+) захватывает флаг!";
DBM_EOTS_FLAG_RESET		                        = "Флаг вернули на место.";
DBM_EOTS_FLAG_CAPTURED	                        = "(%w) захватил флаг!";
DBM_EOTS_FLAG_DROPPED	                        = "Флаг был уронен!";

DBM_EOTS_POINTS			                        = "Базы: (%d+)  Очки победы: (%d+)/2000";

DBM_EOTS_FLAG			                        = "Флаг";

--added 27.7.07
DBM_BGMOD_LANG["WSG_INFOFRAME_ERRORINFO"]       = "Показать ошибки транспортировки флага в бою."
DBM_BGMOD_LANG["WSG_INFOFRAME_ERRORTEXT"]       = "Взять в цель флагоносца, будет восстановлена при выходе из боя."



--added 1.8.07
DBM_BGMOD_LANG["AB_BASESTOWIN_INFO"]            = "Показать количество необходимых для победы баз"
DBM_BGMOD_LANG["AB_BASESTOWIN_TEXT"]            = "Баз для победы: "

DBM_SBT["Horde wins in"] 	                    = "Орда выигрывает в";
DBM_SBT["Alliance wins in"]                     = "Альянс выигрывает в";

DBM_BGMOD_OPTION_AUTOSPIRIT			            = "Авто-выход в форму духа"

DBM_BGMOD_AV_BARS = {}
DBM_BGMOD_LANG.AV_OPTION_FLASH		            = "Включить визуальные эффекты"
]]--
end