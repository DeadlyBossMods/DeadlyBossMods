if (GetLocale() == "zhTW") then
--Chinese Translate by Nightkiller@日落沼澤(kc10577@巴哈;Azael)
DBM_COILFANG	= "毒蛇神殿洞穴";

-- Hydross the Unstable
DBM_HYDROSS_NAME		= "不穩定者海卓司";
DBM_HYDROSS_DESCRIPTION		= "提示印記, 階段及水之墳.";
DBM_HYDROSS_OPTION_1		= "顯示距離框";
DBM_HYDROSS_OPTION_2		= "提示印記";
DBM_HYDROSS_OPTION_3		= "為印記顯示5秒警告";
DBM_HYDROSS_OPTION_4		= "提示階段";
DBM_HYDROSS_OPTION_5		= "提示水之墳";
DBM_HYDROSS_OPTION_NATURE	= "墮落印記"
DBM_HYDROSS_OPTION_FROST	= "海卓司印記"

DBM_HYDROSS_YELL_PULL		= "我不准你涉入這件事!";
DBM_HYDROSS_YELL_NATURE		= "啊，毒……";
DBM_HYDROSS_YELL_FROST		= "很好，舒服多了。";

DBM_HYDROSS_MARK_FROST		= "海卓司印記";
DBM_HYDROSS_MARK_NATURE		= "墮落印記";
DBM_HYDROSS_WATER_TOMB		= "(.+)受到(.*)水之墳效果的影響。";

DBM_HYDROSS_FROST_MARK_NOW	= "*** 冰霜印記 #%s ***";
DBM_HYDROSS_NATURE_MARK_NOW	= "*** 自然印記 #%s ***";
DBM_HYDROSS_FROST_SOON		= "*** 5秒後 冰霜印記 #%s ***";
DBM_HYDROSS_NATURE_SOON		= "*** 5秒後 自然印記 #%s ***";

DBM_HYDROSS_FROST_PHASE		= "*** 冰霜階段 ***";
DBM_HYDROSS_NATURE_PHASE	= "*** 毒性階段 ***";

DBM_HYDROSS_TOMB_WARN		= "*** >%s< 受到了水之墳 ***";

DBM_SBT["Enrage"] 		= "狂怒";
DBM_SBT["Water Tomb"] 		= "水之墳";
DBM_SBT["Hydross"] = {
	{"Mark of Hydross #", "冰霜印記 #"},
	{"Mark of Corruption #", "自然印記 #"},
}

-- Morogrim Tidewalker
DBM_TIDEWALKER_NAME				= "莫洛葛利姆·潮行者";
DBM_TIDEWALKER_DESCRIPTION			= "提示水墓穴和魚人.";
DBM_TIDEWALKER_OPTION_1				= "提示魚人";
DBM_TIDEWALKER_OPTION_2				= "提示水墓穴";

DBM_TIDEWALKER_YELL_PULL			= "深海的洪水，淹沒吧!";
DBM_TIDEWALKER_EMOTE_MURLOCS			= "強烈的地震改變了附近的魚人!";
DBM_TIDEWALKER_EMOTE_GLOBES			= "%s召喚出水珠!";
DBM_TIDEWALKER_EMOTE_GRAVE			= "%s將敵人放進他們的水墓穴中!";
DBM_TIDEWALKER_DEBUFF_GRAVE			= "(.+)受到(.*)水之墓效果的影響。";

DBM_TIDEWALKER_WARN_MURLOCS			= "*** 魚人出現 ***";
DBM_TIDEWALKER_WARN_MURLOCS_SOON		= "*** 即將出現魚人 ***";
DBM_TIDEWALKER_WARN_GRAVE			= "*** 水之墓: %s ***";
DBM_TIDEWALKER_WARN_GLOBES			= "*** 水珠 ***";

DBM_SBT["Murlocs"] 			= "魚人出現";
DBM_SBT["Watery Grave"] 		= "水之墓";

-- Fathom-Lord Karathress
DBM_FATHOMLORD_NAME				= "深淵之王卡拉薩瑞斯";
DBM_FATHOMLORD_DESCRIPTION			= "提示飛火圖騰和治療波.";

DBM_FATHOMLORD_YELL_PULL			= "守衛，注意!我們有訪客了……";
DBM_FATHOMLORD_OPTION_TOTEM_1			= "提示深淵守衛提達費斯的飛火圖騰";
DBM_FATHOMLORD_OPTION_TOTEM_2			= "提示深淵之王卡拉薩瑞斯的飛火圖騰";
DBM_FATHOMLORD_OPTION_HEAL			= "提示治療波";

DBM_FATHOMLORD_TIDALVESS_TOTEM			= "深淵守衛提達費斯施放了飛火圖騰。";
DBM_FATHOMLORD_KARATHRESS_TOTEM			= "深淵之王卡拉薩瑞斯施放了飛火圖騰。";
DBM_FATHOMLORD_CAST_HEAL			= "深淵守衛卡利迪斯開始施放治療波。";

DBM_FATHOMLORD_SFTOTEM1_WARN			= "*** 薩滿: 飛火圖騰 ***";
DBM_FATHOMLORD_SFTOTEM2_WARN			= "*** BOSS: 飛火圖騰 ***";
DBM_FATHOMLORD_HEAL_WARN			= "*** 牧師: 施放治療 ***";

DBM_SBT["Enrage"] 			= "狂怒";
DBM_SBT["Healing Wave"] 		= "治療波";

-- The Lurker Below
DBM_LURKER_NAME					= "海底潛伏者";
DBM_LURKER_DESCRIPTION				= "提示潛水, 浮現, 噴射和旋風. \"即將旋風\" 警告可能不準確,因為王是每18~28秒使用該技能.";
DBM_LURKER_OPTION_WHIRL				= "提示旋風";
DBM_LURKER_OPTION_WHIRLSOON			= "顯示 \"即將旋風\" 警告";
DBM_LURKER_OPTION_SPOUT				= "提示噴射";

DBM_LURKER_EMOTE_SPOUT				= "%s深深的吸了一口氣!";
DBM_LURKER_CAST_SPOUT				= "海底潛伏者的噴射";
DBM_LURKER_CAST_WHIRL				= "海底潛伏者的旋風";
DBM_LURKER_CAST_GEYSER				= "海底潛伏者的噴泉擊中(.+)造成";

DBM_LURKER_WARN_SPOUT_SOON			= "*** 即將噴射水柱 ***";
DBM_LURKER_WARN_SPOUT				= "*** 噴射水柱，閃！ ***";
DBM_LURKER_WARN_SUBMERGE			= "*** 潛水 - 人員就位打小兵，60秒後王浮現 ***";
DBM_LURKER_WARN_EMERGE				= "*** 浮現 - 等王用完旋風及噴水再貼王打！ ***";

DBM_LURKER_WARN_WHIRL				= "*** 旋風 ***";
DBM_LURKER_WARN_WHIRL_SOON			= "*** 即將旋風，近戰快閃開！ ***";

DBM_LURKER_WARN_SUBMERGE_SOON			= "*** %s 秒後潛水 ***";

DBM_SBT["Emerge"] 		= "浮現";
DBM_SBT["Submerge"] 		= "潛水";
DBM_SBT["Spout"] 		= "噴射水柱";
DBM_SBT["Next Spout"] 		= "下一次噴射水柱";
DBM_SBT["Whirl"] 		= "旋風";

-- Leotheras the Blind
DBM_LEO_NAME					= "『盲目者』李奧薩拉斯";
DBM_LEO_DESCRIPTION				= "提示旋風斬、 陰險之語和階段轉換";
DBM_LEO_OPTION_WHIRL				= "提示旋風斬";
DBM_LEO_OPTION_DEMON				= "提示內心的惡靈";
DBM_LEO_OPTION_DEMONWARN			= "提示內心的惡靈目標";

DBM_LEO_YELL_PULL				= "終於結束了我的流放生涯!";
DBM_LEO_YELL_DEMON				= "消失吧，微不足道的精靈。現在開始由我掌管!"; -- stupid spaces...there are 2 spaces at the moment :[
DBM_LEO_YELL_SHADOW				= "不…不!你做了什麼?我是主人!你沒聽見我在說話嗎?我…..啊!無法…控制它。";
DBM_LEO_GAIN_WHIRLWIND				= "『盲目者』李奧薩拉斯獲得了旋風斬的效果。";
DBM_LEO_FADE_WHIRLWIND				= "旋風斬效果從『盲目者』李奧薩拉斯身上消失。";
DBM_LEO_DEBUFF_WHISPER				= "(.+)受到(.*)陰險之語效果的影響。";
DBM_LEO_CAST_WHISPER				= "『盲目者』李奧薩拉斯開始施放陰險之語";
DBM_LEO_YELL_WHISPER				= "我們所有人都有屬於自己的惡魔……";

DBM_LEO_WARN_ENRAGE			= "*** %s %s後狂怒 ***";
DBM_LEO_WARN_WHIRL			= "*** 旋風斬 12秒！全力打王！閃BOSS！ ***";
DBM_LEO_WARN_WHIRL_SOON			= "*** 旋風斬可能於 5 秒後發動！ ***";
DBM_LEO_WARN_WHIRL_SOON_2		= "*** 旋風斬CD結束！隨時發動！ ***";
DBM_LEO_WARN_WHIRL_FADED		= "*** 旋風斬結束！停火等MT抓！ ***";
DBM_LEO_WARN_SHADOW			= "*** 15% - 分身王出現！散開站！打人形王！ ***";
DBM_LEO_WARN_DEMON_PHASE		= "*** 惡魔階段 60秒！停火等MT抓！ ***";
DBM_LEO_WARN_NORMAL_PHASE		= "*** 人型階段 45秒！停火等MT抓！ ***";
DBM_LEO_WARN_DEMON_PHASE_SOON		= "*** 5秒後 惡魔階段！準備停火等MT抓！ ***";
DBM_LEO_WARN_NORMAL_PHASE_SOON		= "*** 5秒後 人型階段！準備停火等MT抓！ ***";
DBM_LEO_SPECWARN_INNER_DEMON		= "內心的惡靈";
DBM_LEO_WHISPER_INNER_DEMON		= "殺了你內心的惡靈！"
DBM_LEO_WARN_DEMONS_INC			= "*** 內心的惡靈即將出現 ***";
DBM_LEO_WARN_DEMONS_NOW			= "*** 內心的惡靈 ***";
DBM_LEO_WARN_DEMON_TARGETS		= "*** 內心的惡靈: %s ***";

DBM_SBT["Enrage"] 		= "狂怒";
DBM_SBT["Demon Form"] 		= "惡魔階段";
DBM_SBT["Normal Form"] 		= "人型階段";
DBM_SBT["Next Whirlwind"] 	= "下一次旋風斬";
DBM_SBT["Whirlwind"] 		= "旋風斬";
DBM_SBT["Inner Demons"] 	= "內心的惡靈";


-- Lady Vashj
DBM_VASHJ_NAME					= "瓦許女士";
DBM_VASHJ_DESCRIPTION				= "提示靜電衝鋒, 召喚, 階段, 受污染的核心, 魔法屏障 和狂怒."

DBM_VASHJ_OPTION_RANGECHECK			= "顯示距離框";
DBM_VASHJ_OPTION_CHARGE				= "提示靜電衝鋒";
DBM_VASHJ_OPTION_CHARGEICON			= "標記中了靜電衝鋒的人";
DBM_VASHJ_OPTION_SPAWNS				= "提示第二階段的召喚";
DBM_VASHJ_OPTION_COREWARN			= "提示誰拾取了受污染的核心";
DBM_VASHJ_OPTION_COREICON			= "標記擁有受污染的核心的人";
DBM_VASHJ_OPTION_CORESPECWARN			= "顯示特別警告當你擁有受污染的核心";


DBM_VASHJ_YELL_PULL1				= "我唾棄你們，地表的渣滓!";
DBM_VASHJ_YELL_PULL2				= "伊利丹王必勝!";
DBM_VASHJ_YELL_PULL3 				= "我要把你們全部殺死!";
DBM_VASHJ_YELL_PULL4				= "我不想要因為跟你這種人交手而降低我自己的身份，但是你們讓我別無選擇……";
DBM_VASHJ_CAST_CHARGE				= "(.+)受到(.*)靜電衝鋒";
DBM_VASHJ_YELL_PHASE2				= "機會來了!一個活口都不要留下!";
DBM_VASHJ_ELEMENT_DIES				= "污染的元素";
DBM_VASHJ_FADE_SHIELD				= "魔法屏障效果從瓦許女士身上消失。";
DBM_VASHJ_DEBUFF_CORE				= "(.+)受到(.*)麻痹效果的影響。";
DBM_VASHJ_YELL_PHASE3				= "你們最好找掩護。";
DBM_VASHJ_LOOT					= "(.+)(.*)了物品:(%d+)。";

DBM_VASHJ_WARN_CHARGE				= "*** 靜電衝鋒: >%s< ***";
DBM_VASHJ_SPECWARN_CHARGE			= "靜電衝鋒在你身上!";

DBM_VASHJ_WARN_PHASE2				= "*** 第二階段! ***";
DBM_VASHJ_WARN_ELE_SOON				= "*** 5秒後 污染的元素! ***";
DBM_VASHJ_WARN_ELE_NOW				= "*** 污染的元素出現!優先殺死它! ***";
DBM_VASHJ_WARN_STRIDER_SOON			= "*** 5秒後 盤牙旅行者! ***";
DBM_VASHJ_WARN_STRIDER_NOW			= "*** 盤牙旅行者出現!牧師漸隱! ***";
DBM_VASHJ_WARN_NAGA_SOON			= "*** 5秒後 盤牙精英! ***";
DBM_VASHJ_WARN_NAGA_NOW				= "*** 盤牙精英出現!中間坦克注意! ***";
DBM_VASHJ_WARN_SHIELD_FADED			= "*** 魔法屏障 %d/4 消失! ***";
DBM_VASHJ_WARN_CORE_LOOT			= "*** >%s< 擁有受污染的核心! ***";
DBM_VASHJ_SPECWARN_CORE				= "你擁有受污染的核心!";

DBM_VASHJ_WARN_PHASE3				= "*** 魔法屏障 4/4 消失! - 進入第三階段! ***";
DBM_VASHJ_WARN_ENRAGE				= "*** %s %s後狂暴! ***";

DBM_SBT["Strider"] 			= "盤牙旅行者";
DBM_SBT["Tainted Elemental"] 		= "污染的元素";
DBM_SBT["Naga"] 			= "盤牙精英";
DBM_SBT["Enrage"] 			= "狂怒";
DBM_SBT["Vashj"] = {
	{"Static Charge: (.*)", "靜電衝鋒: %1"},
};

end