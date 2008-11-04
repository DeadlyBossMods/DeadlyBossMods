if (GetLocale() == "zhTW") then
--Chinese Translate by Nightkiller@日落沼澤(kc10577@巴哈;Azael)
DBM_BGMOD_LANG = {}
DBM_BGMOD_LANG["NAME"] 		= "戰場";
DBM_BGMOD_LANG["INFO"] 		= "顯示計時條為奧特蘭克山谷及阿拉希盆地旗幟佔領倒數計時. "
					            .."顯示戰歌旗幟持有者以及在奧特蘭克山谷自動繳交物資.";
DBM_BGMOD_LANG["THANKS"] 		= "感謝你使用 La Vendetta BossMods, 快樂的 PvP 吧";
DBM_BGMOD_LANG["WINS"]			= "(.+)勝利了!";
DBM_BGMOD_LANG["BEGINS"]		= "即將開始";	-- BAR
DBM_BGMOD_LANG["ALLIANCE"]		= "聯盟";
DBM_BGMOD_LANG["HORDE"]			= "部落";
DBM_BGMOD_LANG["ALLI_TAKE_ANNOUNCE"] 	= "*** 聯盟佔領了 %s ***";
DBM_BGMOD_LANG["HORDE_TAKE_ANNOUNCE"]	= "*** 部落佔領了 %s ***";

		-- AV
DBM_BGMOD_LANG["AV_ZONE"] 		= "奧特蘭克山谷";
DBM_BGMOD_LANG["AV_START60SEC"]		= "奧特蘭克山谷一分鐘後開始戰鬥。";
DBM_BGMOD_LANG["AV_START30SEC"]		= "奧特蘭克山谷30秒後開始戰鬥。";
DBM_BGMOD_LANG["AV_TURNININFO"] 	= "自動繳交聲望物品";
DBM_BGMOD_LANG["AV_NPC"] = {
			["SMITHREGZAR"] 			= "鐵匠雷格薩";			-- armor
			["PRIMALISTTHURLOGA"] 			= "原獵者瑟魯加";		-- icelord
			["WINGCOMMANDERJEZTOR"] 		= "空軍指揮官傑斯托";		
			["WINGCOMMANDERGUSE"] 			= "空軍指揮官古斯";
			["WINGCOMMANDERMULVERICK"]	 	= "空軍指揮官穆維里克";
			["MURGOTDEEPFORGE"] 			= "莫高特·深爐";		-- armor
			["ARHDRUIDRENFERAL"] 			= "大德魯伊雷弗拉爾";		-- forestlord
			["WINGCOMMANDERVIPORE"] 		= "空軍指揮官維波里";
			["WINDCOMMANDERSLIDORE"]	 	= "空軍指揮官斯里多爾";
			["WINGCOMMANDERICHMAN"] 		= "空軍指揮官艾克曼";
			["STORMPIKERAMRIDERCOMMANDER"]		= "雷矛山羊騎兵指揮官";
			["FROSTWOLFWOLFRIDERCOMMANDER"]		= "霜狼騎兵指揮官";
};
DBM_BGMOD_LANG["AV_ITEM"] 		= {
			["ARMORSCRAPS"] 	= "護甲碎片";
			["SOLDIERSBLOOD"] 	= "聯盟士兵的血";
			["LIEUTENANTSFLESH"] 	= "聯盟士官的食物";
			["SOLDIERSFLESH"] 	= "聯盟士兵的食物";
			["COMMANDERSFLESH"] 	= "聯盟指揮官的食物";
			["STORMCRYSTAL"]    	= "風暴水晶";
			["LIEUTENANTSMEDAL"] 	= "部落士官的勳章";
			["SOLDIERSMEDAL"] 	= "部落士兵的勳章";
			["COMMANDERSMEDAL"] 	= "部落指揮官的勳章";
			["FROSTWOLFHIDE"] 	= "霜狼毛皮";
			["ALTERACRAMHIDE"] 	= "奧特蘭克山羊皮";
};

DBM_BGMOD_LANG["AV_TARGETS"] = {
	"雷矛急救站",
	"丹巴達爾北部碉堡",
	"丹巴達爾南部碉堡",
	"雷矛墓地",
	"冰翼碉堡",
	"石爐墓地",
	"石爐碉堡",
	"落雪墓地",
	"冰血哨塔",
	"冰血墓地",
	"哨塔高地",
	"霜狼墓地",
	"西部霜狼哨塔",
	"東部霜狼哨塔",
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

DBM_BGMOD_LANG["AV_UNDERATTACK"]	= "(.+)受到攻擊!(.*)不採取措施(.*)，(.+)(.*)(.+)(.*)!";	-- Graveyard // Towers
DBM_BGMOD_LANG["AV_WASTAKENBY"]		= "(.+)被(.+)佔領了!";
DBM_BGMOD_LANG["AV_WASDESTROYED"]	= "(.+)被(.+)摧毀了!";
DBM_BGMOD_LANG["AV_IVUS"]          	= "Wicked, Wicked, Mortals! The forest weeps";
DBM_BGMOD_LANG["AV_ICEY"]          	= "誰敢召喚冰雪之王";

		-- AB
DBM_BGMOD_LANG["AB_ZONE"] 		= "阿拉希盆地";
DBM_BGMOD_LANG["AB_INFOFRAME_INFO"]	= "顯示戰鬥結束時雙方資源預計值.";
DBM_BGMOD_LANG["AB_START60SEC"]		= "阿拉希盆地的戰鬥將在1分鐘後開始。";
DBM_BGMOD_LANG["AB_START30SEC"]		= "阿拉希盆地的戰鬥將在30秒後開始。";
DBM_BGMOD_LANG["AB_CLAIMSTHE"]	   	= "(.+)突襲了(.+)!如果沒有其他人採取行動的話，(.+)將在一分鐘內控制它!";
DBM_BGMOD_LANG["AB_HASTAKENTHE"]	= "(.+)奪取了(.+)!";
DBM_BGMOD_LANG["AB_HASDEFENDEDTHE"] 	= "(.+)守住了(.+)!";
DBM_BGMOD_LANG["AB_HASASSAULTED"]	= "攻佔了";
DBM_BGMOD_LANG["AB_SCOREEXP"] 		= "基地:(%d+) 資源:(%d+)/2000";
DBM_BGMOD_LANG["AB_WINALLY"] 		= "聯盟勝利還需";
DBM_BGMOD_LANG["AB_WINHORDE"] 		= "部落勝利還需";
DBM_BGMOD_LANG["AB_TARGETS"] 		= {
        "農場",
        "伐木場",
        "鐵匠舖",
        "礦坑",
        "獸欄"
	};

		-- WSG
DBM_BGMOD_LANG["WSG_ZONE"] 		= "戰歌峽谷";
DBM_BGMOD_LANG["WSG_START60SEC"]	= "戰歌峽谷戰鬥將在1分鐘內開始。";
DBM_BGMOD_LANG["WSG_START30SEC"]	= "戰歌峽谷戰鬥將在30秒鐘內開始。做好準備!";
DBM_BGMOD_LANG["WSG_INFOFRAME_INFO"]	= "在戰歌峽谷中顯示搶奪旗幟視窗";
DBM_BGMOD_LANG["WSG_FLAG_PICKUP"] 	= "(.+)的旗幟被(.+)拔掉了!";			-- . because the F is not allways large char 
DBM_BGMOD_LANG["WSG_FLAG_RETURN"]	= "(.+)的旗幟被(.+)還到了它的基地";
DBM_BGMOD_LANG["WSG_ALLYFLAG"]		= "聯盟: ";
DBM_BGMOD_LANG["WSG_HORDEFLAG"]		= "部落: ";
DBM_BGMOD_LANG["WSG_FLAG_BASE"]		= "基地";
DBM_BGMOD_LANG["WSG_HASCAPTURED"]	= "(.+)佔據了(.+)的旗幟!";

		-- NEW Added 08.11.06
DBM_BGMOD_LANG["WSG_INFOFRAME_TITLE"]	= "戰歌旗幟所在";
DBM_BGMOD_LANG["WSG_INFOFRAME_TEXT"]	= "顯示旗幟持有者";
DBM_BGMOD_LANG["AB_STRINGALLIANCE"]	= "聯盟:";
DBM_BGMOD_LANG["AB_STRINGHORDE"]	= "部落:";
DBM_BGMOD_LANG["WSG_BOOTS_EXPR"]	= "受到(.*)速度提升";

-- ADDED 9.12.06
DBM_BGMOD_LANG["ARENA_BEGIN"]		= "1分鐘後競技場戰鬥開始!";
DBM_BGMOD_LANG["ARENA_BEGIN30"]		= "30秒後競技場戰鬥開始!";
DBM_BGMOD_LANG["ARENA_BEGIN15"]		= "15秒後競技場戰鬥開始!";

DBM_BGMOD_EN_TARGET_AV = DBM_BGMOD_LANG.AV_TARGETS;
DBM_BGMOD_EN_TARGET_AB = DBM_BGMOD_LANG.AB_TARGETS;

-- DBM_SBT["Alliance: Lumber mill"] = "聯盟: 伐木場";
-- DBM_SBT["Horde: Lumber mill"] = "部落: 伐木場";
-- DBM_SBT["Flag respawn"] = "";
-- DBM_SBT["Ivus spawn"] = "";
-- DBM_SBT["Ice spawn"] = "";
DBM_SBT["Begins"] 	= DBM_BGMOD_LANG["BEGINS"];
DBM_SBT["AB_WINHORDE"] 	= DBM_BGMOD_LANG.AB_WINHORDE;
DBM_SBT["AB_WINALLY"] 	= DBM_BGMOD_LANG.AB_WINALLY;

DBM_SBT["Speed Boots"] 	= "加速鞋";
DBM_SBT["Flag respawn"] = "旗幟重生";
DBM_SBT["Ivus spawn"] 	= "伊弗斯出生";
DBM_SBT["Ice spawn"] 	= "冰雪之王出生";

-- 17.12.06
DBM_BGMOD_LANG["COLOR_BY_CLASS"] = "在得分視窗中設置玩家名為職業顏色";
DBM_BGMOD_LANG["SHOW_INV_TIMER"] = "顯示戰場組隊計時"

--sux a bit..^_^
DBM_SBT["Alliance: 雷矛急救站"] = "雷矛急救站";
DBM_SBT["Alliance: 丹巴達爾北部碉堡"] = "丹巴達爾北部碉堡";
DBM_SBT["Alliance: 丹巴達爾南部碉堡"] = "丹巴達爾南部碉堡";
DBM_SBT["Alliance: 雷矛墓地"] = "雷矛墓地";
DBM_SBT["Alliance: 冰翼碉堡"] = "冰翼碉堡";
DBM_SBT["Alliance: 石爐墓地"] = "石爐墓地";
DBM_SBT["Alliance: 石爐碉堡"] = "石爐碉堡";
DBM_SBT["Alliance: 落雪墓地"] = "落雪墓地";
DBM_SBT["Alliance: 東側防禦塔點"] = "東側防禦塔點";
DBM_SBT["Alliance: 冰血墓地"] = "冰血墓地";
DBM_SBT["Alliance: 西側防禦塔點"] = "西側防禦塔點";
DBM_SBT["Alliance: 霜狼墓地"] = "霜狼墓地";
DBM_SBT["Alliance: 西部霜狼哨塔"] = "西部霜狼哨塔";
DBM_SBT["Alliance: 東部霜狼哨塔"] = "東部霜狼哨塔";
DBM_SBT["Alliance: 霜狼急救站"] = "霜狼急救站";
DBM_SBT["Alliance: 農場"] = "農場";
DBM_SBT["Alliance: 伐木場"] = "伐木場";
DBM_SBT["Alliance: 鐵匠舖"] = "鐵匠舖";
DBM_SBT["Alliance: 礦坑"] = "礦坑";
DBM_SBT["Alliance: 獸欄"] = "獸欄";

DBM_SBT["Horde: 雷矛急救站"] = "雷矛急救站";
DBM_SBT["Horde: 丹巴達爾北部碉堡"] = "丹巴達爾北部碉堡";
DBM_SBT["Horde: 丹巴達爾南部碉堡"] = "丹巴達爾南部碉堡";
DBM_SBT["Horde: 雷矛墓地"] = "雷矛墓地";
DBM_SBT["Horde: 冰翼碉堡"] = "冰翼碉堡";
DBM_SBT["Horde: 石爐墓地"] = "石爐墓地";
DBM_SBT["Horde: 石爐碉堡"] = "石爐碉堡";
DBM_SBT["Horde: 落雪墓地"] = "落雪墓地";
DBM_SBT["Horde: 東側防禦塔點"] = "東側防禦塔點";
DBM_SBT["Horde: 冰血墓地"] = "冰血墓地";
DBM_SBT["Horde: 西側防禦塔點"] = "西側防禦塔點";
DBM_SBT["Horde: 霜狼墓地"] = "霜狼墓地";
DBM_SBT["Horde: 西部霜狼哨塔"] = "西部霜狼哨塔";
DBM_SBT["Horde: 東部霜狼哨塔"] = "東部霜狼哨塔";
DBM_SBT["Horde: 霜狼急救站"] = "霜狼急救站";
DBM_SBT["Horde: 農場"] = "農場";
DBM_SBT["Horde: 伐木場"] = "伐木場";
DBM_SBT["Horde: 鐵匠舖"] = "鐵匠舖";
DBM_SBT["Horde: 礦坑"] = "礦坑";
DBM_SBT["Horde: 獸欄"] = "獸欄";
	
--added 2.1.07
DBM_BGMOD_LANG["AB_DESCRIPTION"]	= "顯示資源奪取進度和預計勝利方";
DBM_BGMOD_LANG["AV_DESCRIPTION"]	= "顯示墓地和哨塔的奪取進度";
DBM_BGMOD_LANG["WS_DESCRIPTION"]	= "顯示旗幟攜帶者";

--added 7.1.07
DBM_BGMOD_LANG["UPGRADETROOPS"]		= "升級到";

DBM_ARENAS				= "競技場";
DBM_ARENAS_DESCRIPTION			= "顯示計時條為競技場計時.";
	
-- eye of the storm
DBM_EOTS_NAME			= "暴風之眼";
DBM_EOTS_DESCRIPTION		= "顯示資源奪取進度和預計勝利方 和 顯示旗幟攜帶者";

DBM_EOTS_BEGINS_60		= "戰鬥在1分鐘內開始!";
DBM_EOTS_BEGINS_30		= "戰鬥在30秒內開始!";

DBM_EOTS_FLAG_TAKEN		= "(.+)已經奪走了旗幟!";
DBM_EOTS_FLAG_RESET		= "旗幟已重置!";
DBM_EOTS_FLAG_CAPTURED		= "(.+)已奪得旗幟!";
DBM_EOTS_FLAG_DROPPED		= "旗幟已經掉落!";

DBM_EOTS_POINTS			= "基地:(%d+) 勝利點數:(%d+)/2000";

DBM_EOTS_FLAG			= "旗幟";

DBM_SBT["Alliance wins in"] 		= "聯盟勝利還需";
DBM_SBT["Horde wins in"] 		= "部落勝利還需";

--added 27.7.07
DBM_BGMOD_LANG["WSG_INFOFRAME_ERRORINFO"] = "當正在戰鬥時顯示旗幟錯誤提示。"
DBM_BGMOD_LANG["WSG_INFOFRAME_ERRORTEXT"] = "當你離開戰鬥後，旗幟框架將會回復。"

--added 1.8.07
DBM_BGMOD_LANG["AB_BASESTOWIN_INFO"] = "顯示戰鬥勝利所需基地數目"
DBM_BGMOD_LANG["AB_BASESTOWIN_TEXT"] = "所需基地數目: "


DBM_BGMOD_OPTION_AUTOSPIRIT			= "自動釋放靈魂"

DBM_BGMOD_AV_BARS = {}

DBM_BGMOD_LANG.AV_OPTION_FLASH		= "開啟閃光效果"

end
