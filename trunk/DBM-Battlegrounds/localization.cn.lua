-- ------------------------------------------- --
--   Deadly Boss Mods - Chinese localization   --
--    by Diablohu<白银之手> @ 二区-轻风之语    --
--              www.dreamgen.cn                --
--                  4/13/2008                  --
-- ------------------------------------------- --

if (GetLocale() == "zhCN") then
	DBM_BGMOD_LANG = {}
	DBM_BGMOD_LANG["NAME"] 				= "战场";
	DBM_BGMOD_LANG["INFO"] 				= "显示阿拉希盆地和奥特兰克山谷的旗帜信息，"
								.."显示战歌峡谷的旗帜携带者，并可自动上交奥特兰克山谷声望物品";
	DBM_BGMOD_LANG["THANKS"] 				= "感谢您使用 Deadly BossMods, 祝您获胜";
	DBM_BGMOD_LANG["WINS"]					= "([^%s]+)获胜";
	DBM_BGMOD_LANG["BEGINS"]				= "战斗即将开始";	-- BAR
	DBM_BGMOD_LANG["ALLIANCE"]				= "联盟";
	DBM_BGMOD_LANG["HORDE"]					= "部落";
	DBM_BGMOD_LANG["ALLI_TAKE_ANNOUNCE"] 	= "*** 联盟夺取了%s ***";
	DBM_BGMOD_LANG["HORDE_TAKE_ANNOUNCE"]	= "*** 部落夺取了%s ***";
	
	-- AV
	DBM_BGMOD_LANG["AV_ZONE"] 			= "奥特兰克山谷";
	DBM_BGMOD_LANG["AV_START60SEC"]		= "奥特兰克山谷的战斗将在1分钟之后开始。";
	DBM_BGMOD_LANG["AV_START30SEC"]		= "奥特兰克山谷的战斗将在30秒之后开始。";
	DBM_BGMOD_LANG["AV_TURNININFO"] 	= "自动上交声望物品";
	DBM_BGMOD_LANG["AV_NPC"] = {
			["SMITHREGZAR"] 				= "铁匠雷格萨",			-- armor
			["PRIMALISTTHURLOGA"] 			= "指挥官瑟鲁加",		-- icelord
			["WINGCOMMANDERJEZTOR"] 		= "空军指挥官杰斯托",		
			["WINGCOMMANDERGUSE"] 			= "空军指挥官古斯",
			["WINGCOMMANDERMULVERICK"] 		= "空军指挥官穆维里克",
			["MURGOTDEEPFORGE"] 			= "莫高特·深炉",		-- armor
			["ARCHDRUIDRENFERAL"] 			= "大德鲁伊雷弗拉尔",	-- forestlord
			["WINGCOMMANDERVIPORE"] 		= "空军指挥官维波里",
			["WINDCOMMANDERSLIDORE"] 		= "空军指挥官斯里多尔",
			["WINGCOMMANDERICHMAN"] 		= "空军指挥官艾克曼",
			["STORMPIKERAMRIDERCOMMANDER"]	= "雷矛山羊骑兵指挥官",
			["FROSTWOLFWOLFRIDERCOMMANDER"]	= "霜狼骑兵指挥官",
		};
	DBM_BGMOD_LANG["AV_ITEM"] = {
			["ARMORSCRAPS"] 		= "护甲碎片",
			["SOLDIERSBLOOD"] 		= "联盟士兵的血",
			["LIEUTENANTSFLESH"] 	= "联盟士官的食物",
			["SOLDIERSFLESH"] 		= "联盟士兵的食物",
			["COMMANDERSFLESH"] 	= "联盟指挥官的食物",
			["STORMCRYSTAL"] 		= "风暴水晶",
			["LIEUTENANTSMEDAL"] 	= "部落士官的勋章",
			["SOLDIERSMEDAL"] 		= "部落士兵的勋章",
			["COMMANDERSMEDAL"] 	= "部落指挥官的勋章",
			["FROSTWOLFHIDE"]		= "霜狼毛皮",
			["ALTERACRAMHIDE"] 		= "奥特兰克山羊皮",
		};
	DBM_BGMOD_LANG["AV_TARGETS"] = {
			"雷矛急救站",
			"丹巴达尔北部碉堡",
			"丹巴达尔南部碉堡",
			"雷矛墓地",
			"冰翼碉堡",
			"石炉墓地",
			"石炉碉堡",
			"雪落墓地",
			"冰血哨塔",
			"冰血墓地",
			"哨塔高地",
			"霜狼墓地",
			"西侧霜狼哨塔",
			"东侧霜狼哨塔",
			"霜狼急救站"
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
	
	DBM_BGMOD_LANG["AV_UNDERATTACK"]	= "([^%s]+)受到攻击！如果我们不尽快采取措施，([^%s]+)会([^%s]+)它的！";	-- Graveyard // Tower
	DBM_BGMOD_LANG["AV_WASTAKENBY"]		= "([^%s]+)被([^%s]+)占领了！";
	DBM_BGMOD_LANG["AV_WASDESTROYED"]	= "([^%s]+)被([^%s]+)摧毁了！";
	DBM_BGMOD_LANG["AV_IVUS"]			= "邪恶,太邪恶了,人类!森林在哭泣。大自然的力量面对毁灭退缩了。伊弗斯必须把你从这世上清除！";
	DBM_BGMOD_LANG["AV_ICEY"]			= "谁敢召唤冰雪之王洛克霍拉？";
	
	-- AB
	DBM_BGMOD_LANG["AB_ZONE"] 			= "阿拉希盆地";
	DBM_BGMOD_LANG["AB_INFOFRAME_INFO"]	= "显示战斗结束时双方资源预计值";
	DBM_BGMOD_LANG["AB_START60SEC"]		= "阿拉希盆地的战斗将在1分钟后开始。";
	DBM_BGMOD_LANG["AB_START30SEC"]		= "阿拉希盆地的战斗将在30秒后开始。";
	DBM_BGMOD_LANG["AB_CLAIMSTHE"]		= "([^%s]+)攻占了([^%s]+)！如果不赶快采取行动的话，([^%s]+)在1分钟内([^%s]+)它！";
	DBM_BGMOD_LANG["AB_HASTAKENTHE"]	= "([^%s]+)夺取了([^%s]+)！";
	DBM_BGMOD_LANG["AB_HASDEFENDEDTHE"]	= "([^%s]+)守住了([^%s]+)！";
	DBM_BGMOD_LANG["AB_HASASSAULTED"]	= "突袭了";
	DBM_BGMOD_LANG["AB_SCOREEXP"] 		= "基地：(%d+)  资源：(%d+)/2000";
	DBM_BGMOD_LANG["AB_WINALLY"] 		= "联盟即将获胜";
	DBM_BGMOD_LANG["AB_WINHORDE"] 		= "部落即将获胜";
	DBM_BGMOD_LANG["AB_TARGETS"] = {
			"农场",
			"伐木场",
			"铁匠铺",
			"矿洞",
			"兽栏"
		};
	
	-- WSG
	DBM_BGMOD_LANG["WSG_ZONE"] 				= "战歌峡谷";
	DBM_BGMOD_LANG["WSG_START60SEC"]		= "战歌峡谷战斗将在1分钟内开始。";
	DBM_BGMOD_LANG["WSG_START30SEC"]		= "战歌峡谷战斗将在30秒钟内开始。做好准备！";
	DBM_BGMOD_LANG["WSG_INFOFRAME_INFO"]	= "显示旗帜携带者";
	DBM_BGMOD_LANG["WSG_FLAG_PICKUP"] 		= "([^%s]+)的旗帜被([^%s]+)拔起了！";
	DBM_BGMOD_LANG["WSG_FLAG_RETURN"]		= "([^%s]+)的旗帜被([^%s]+)还到了它的基地中！";
	DBM_BGMOD_LANG["WSG_ALLYFLAG"]			= "联盟: ";
	DBM_BGMOD_LANG["WSG_HORDEFLAG"]			= "部落: ";
	DBM_BGMOD_LANG["WSG_FLAG_BASE"]			= "基地";
	DBM_BGMOD_LANG["WSG_HASCAPTURED"]		= "([^%s]+)夺取([^%s]+)的旗帜！";
	DBM_BGMOD_LANG["WSG_FLAGRESPAWN"] 		= "旗帜即将刷新";

	-- NEW Added 08.11.06
	DBM_BGMOD_LANG["WSG_INFOFRAME_TITLE"]	= "战歌峡谷旗帜监视";
	DBM_BGMOD_LANG["WSG_INFOFRAME_TEXT"]	= "显示旗帜携带者";
	DBM_BGMOD_LANG["AB_STRINGALLIANCE"]		= "联盟: ";
	DBM_BGMOD_LANG["AB_STRINGHORDE"]		= "部落: ";
	DBM_BGMOD_LANG["WSG_BOOTS_EXPR"]		= "受到了加速效果的影响。";

	-- ADDED 9.12.06
	DBM_BGMOD_LANG["ARENA_BEGIN"]		= "竞技场战斗将在一分钟后开始！";
	DBM_BGMOD_LANG["ARENA_BEGIN30"]		= "竞技场战斗将在三十秒后开始！";
	DBM_BGMOD_LANG["ARENA_BEGIN15"]		= "竞技场战斗将在十五秒后开始！";

	DBM_BGMOD_EN_TARGET_AV = DBM_BGMOD_LANG.AV_TARGETS;
	DBM_BGMOD_EN_TARGET_AB = DBM_BGMOD_LANG.AB_TARGETS;
	
	--DBM_SBT["Ice spawn"] 	= DBM_BGMOD_LANG["ICEYTXT"];
	DBM_SBT["Begins"] 		= DBM_BGMOD_LANG.BEGINS;
	DBM_SBT["Flag respawn"] = DBM_BGMOD_LANG.WSG_FLAGRESPAWN;
	DBM_SBT["AB_WINHORDE"] 	= DBM_BGMOD_LANG.AB_WINHORDE;
	DBM_SBT["AB_WINALLY"] 	= DBM_BGMOD_LANG.AB_WINALLY;
	DBM_SBT["Ivus spawn"] 	= "伊弗斯出现";
	DBM_SBT["Speed Boots"] 	= "加速靴效果";

	-- 17.12.06
	DBM_BGMOD_LANG["COLOR_BY_CLASS"] = "在得分窗口中设置玩家名为职业颜色";
	DBM_BGMOD_LANG["SHOW_INV_TIMER"] = "显示战场传送倒计时"

	--sux a bit..^_^
	DBM_SBT["Alliance: 雷矛急救站"] = "雷矛急救站";
	DBM_SBT["Alliance: 丹巴达尔北部碉堡"] = "丹巴达尔北部碉堡";
	DBM_SBT["Alliance: 丹巴达尔南部碉堡"] = "丹巴达尔南部碉堡";
	DBM_SBT["Alliance: 雷矛墓地"] = "雷矛墓地";
	DBM_SBT["Alliance: 冰翼碉堡"] = "冰翼碉堡";
	DBM_SBT["Alliance: 石炉墓地"] = "石炉墓地";
	DBM_SBT["Alliance: 石炉碉堡"] = "石炉碉堡";
	DBM_SBT["Alliance: 雪落墓地"] = "雪落墓地";
	DBM_SBT["Alliance: 冰血哨塔"] = "冰血哨塔";
	DBM_SBT["Alliance: 冰血墓地"] = "冰血墓地";
	DBM_SBT["Alliance: 哨塔高地"] = "哨塔高地";
	DBM_SBT["Alliance: 霜狼墓地"] = "霜狼墓地";
	DBM_SBT["Alliance: 西侧霜狼哨塔"] = "西侧霜狼哨塔";
	DBM_SBT["Alliance: 东侧霜狼哨塔"] = "东侧霜狼哨塔";
	DBM_SBT["Alliance: 霜狼急救站"] = "霜狼急救站";
	DBM_SBT["Alliance: 农场"] = "农场";
	DBM_SBT["Alliance: 伐木场"] = "伐木场";
	DBM_SBT["Alliance: 铁匠铺"] = "铁匠铺";
	DBM_SBT["Alliance: 矿洞"] = "矿洞";
	DBM_SBT["Alliance: 兽栏"] = "兽栏";

	DBM_SBT["Horde: 雷矛急救站"] = "雷矛急救站";
	DBM_SBT["Horde: 丹巴达尔北部碉堡"] = "丹巴达尔北部碉堡";
	DBM_SBT["Horde: 丹巴达尔南部碉堡"] = "丹巴达尔南部碉堡";
	DBM_SBT["Horde: 雷矛墓地"] = "雷矛墓地";
	DBM_SBT["Horde: 冰翼碉堡"] = "冰翼碉堡";
	DBM_SBT["Horde: 石炉墓地"] = "石炉墓地";
	DBM_SBT["Horde: 石炉碉堡"] = "石炉碉堡";
	DBM_SBT["Horde: 雪落墓地"] = "雪落墓地";
	DBM_SBT["Horde: 冰血哨塔"] = "冰血哨塔";
	DBM_SBT["Horde: 冰血墓地"] = "冰血墓地";
	DBM_SBT["Horde: 哨塔高地"] = "哨塔高地";
	DBM_SBT["Horde: 霜狼墓地"] = "霜狼墓地";
	DBM_SBT["Horde: 西侧霜狼哨塔"] = "西侧霜狼哨塔";
	DBM_SBT["Horde: 东侧霜狼哨塔"] = "东侧霜狼哨塔";
	DBM_SBT["Horde: 霜狼急救站"] = "霜狼急救站";
	DBM_SBT["Horde: 农场"] = "农场";
	DBM_SBT["Horde: 伐木场"] = "伐木场";
	DBM_SBT["Horde: 铁匠铺"] = "铁匠铺";
	DBM_SBT["Horde: 矿洞"] = "矿洞";
	DBM_SBT["Horde: 兽栏"] = "兽栏";
	
--added 2.1.07
	DBM_BGMOD_LANG["AB_DESCRIPTION"]	= "显示资源夺取进度和预计胜利方";
	DBM_BGMOD_LANG["AV_DESCRIPTION"]	= "显示墓地和哨塔的夺取进度";
	DBM_BGMOD_LANG["WS_DESCRIPTION"]	= "显示旗帜携带者";

--added 7.1.07
	DBM_BGMOD_LANG["UPGRADETROOPS"]		= "升级到";

	DBM_ARENAS				= "竞技场";
	DBM_ARENAS_DESCRIPTION	= "显示竞技场计时";
	
-- eye of the storm
	DBM_EOTS_NAME			= "风暴之眼";
	DBM_EOTS_DESCRIPTION	= "估算战场结束时间并显示旗帜携带者";

	DBM_EOTS_BEGINS_60		= "战斗将在1分钟后开始！";
	DBM_EOTS_BEGINS_30		= "战斗将在30秒后开始！";

	DBM_EOTS_FLAG_TAKEN		= "([^%s]+)夺走了旗帜！";
	DBM_EOTS_FLAG_RESET		= "旗帜被重新放置了。";
	DBM_EOTS_FLAG_CAPTURED	= ".+夺得了旗帜！";
	DBM_EOTS_FLAG_DROPPED	= "旗帜被扔掉了！";

	DBM_EOTS_POINTS			= "基地：(%d+)  胜利点数：(%d+)/2000";

	DBM_EOTS_FLAG			= "旗帜";

--added 27.7.07
	DBM_BGMOD_LANG["WSG_INFOFRAME_ERRORINFO"] = "显示因在战斗状态而产生的旗帜携带者框架错误信息"
	DBM_BGMOD_LANG["WSG_INFOFRAME_ERRORTEXT"] = "选择旗帜携带者目标将会在你离开战斗状态后自动修复。"

--added 1.8.07
	DBM_BGMOD_LANG["AB_BASESTOWIN_INFO"] = "显示战斗胜利所需基地数"
	DBM_BGMOD_LANG["AB_BASESTOWIN_TEXT"] = "所需基地数："
	
	DBM_SBT["Horde wins in"] 	= "部落即将获胜";
	DBM_SBT["Alliance wins in"] = "联盟即将获胜";

	DBM_BGMOD_OPTION_AUTOSPIRIT	= "自动释放灵魂"

	DBM_BGMOD_AV_BARS = {}
	DBM_BGMOD_LANG.AV_OPTION_FLASH = "启用屏幕闪光效果"

end
