-- ------------------------------------------- --
--   Deadly Boss Mods - Chinese localization   --
--    by Diablohu<白银之手> @ 二区-轻风之语    --
--              www.dreamgen.cn                --
--                  3/26/2008                  --
-- ------------------------------------------- --

if (GetLocale() == "zhCN") then

	DBM_SERPENT_TAB	= "SCTab"
	DBM_COILFANG	= "毒蛇神殿";

-- Hydross the Unstable
	DBM_HYDROSS_NAME			= "不稳定的海度斯";
	DBM_HYDROSS_DESCRIPTION		= "警报印记、阶段变化以及水之墓";
	DBM_HYDROSS_OPTION_1		= "显示距离框体";
	DBM_HYDROSS_OPTION_2		= "警报印记";
	DBM_HYDROSS_OPTION_3		= "显示印记5秒警报";
	DBM_HYDROSS_OPTION_4		= "警报阶段变化";
	DBM_HYDROSS_OPTION_5		= "警报水之墓";
	DBM_HYDROSS_OPTION_NATURE	= "腐蚀印记"
	DBM_HYDROSS_OPTION_FROST	= "海度斯印记"

	DBM_HYDROSS_YELL_PULL		= "我不能允许你们介入！";
	DBM_HYDROSS_YELL_NATURE		= "啊……毒性侵袭了我……";
	DBM_HYDROSS_YELL_FROST		= "感觉好多了。";

	DBM_HYDROSS_MARK_FROST		= "受到了海度斯印记效果的影响";
	DBM_HYDROSS_MARK_NATURE		= "受到了腐蚀印记效果的影响";
	DBM_HYDROSS_WATER_TOMB		= "([^%s]+)受([^%s]+)水之墓效果的影响。";

	DBM_HYDROSS_FROST_MARK_NOW	= "*** 冰霜印记 #%s ***";
	DBM_HYDROSS_NATURE_MARK_NOW	= "*** 自然印记 #%s ***";
	DBM_HYDROSS_FROST_SOON		= "*** 冰霜印记 #%s - 5秒后施放 ***";
	DBM_HYDROSS_NATURE_SOON		= "*** 自然印记 #%s - 5秒后施放 ***";

	DBM_HYDROSS_FROST_PHASE		= "*** 冰霜阶段 ***";
	DBM_HYDROSS_NATURE_PHASE	= "*** 自然阶段 ***";

	DBM_HYDROSS_TOMB_WARN		= "*** 水之墓 -> >%s< ***";

	DBM_SBT["Enrage"]		= "激怒";
	DBM_SBT["Water Tomb"]	= "水之墓";
	
	DBM_SBT["Hydross"] = {
		  [1] = {"Mark of Hydross #", "海度斯印记 #"},
		  [2] = {"Mark of Corruption #", "腐蚀印记 #"},
	}
	DBM_SBT["不稳定的海度斯"] = DBM_SBT["Hydross"]


-- Morogrim Tidewalker
	DBM_TIDEWALKER_NAME					= "莫洛格里·踏潮者";
	DBM_TIDEWALKER_DESCRIPTION			= "警报水之墓穴以及鱼人群";
	DBM_TIDEWALKER_OPTION_1				= "警报鱼人群";
	DBM_TIDEWALKER_OPTION_2				= "警报水之墓穴";

	DBM_TIDEWALKER_YELL_PULL			= "深渊中的洪水会淹没你们！";
	DBM_TIDEWALKER_EMOTE_MURLOCS		= "猛烈的地震警告了附近的鱼人们！";
	DBM_TIDEWALKER_EMOTE_GLOBES			= "%s召唤了水泡！";
	DBM_TIDEWALKER_EMOTE_GRAVE			= "%s把他的敌人送入了水下的坟墓！";
	DBM_TIDEWALKER_DEBUFF_GRAVE			= "([^%s]+)受([^%s]+)水之墓穴效果的影响。";

	DBM_TIDEWALKER_WARN_MURLOCS			= "*** 鱼人群出现 ***";
	DBM_TIDEWALKER_WARN_MURLOCS_SOON	= "*** 鱼人群 - 即将出现 ***";
	DBM_TIDEWALKER_WARN_GRAVE			= "*** 水之墓穴 -> %s ***";
	DBM_TIDEWALKER_WARN_GLOBES			= "*** 水泡 ***";

	DBM_SBT["Murlocs"]		= "鱼人群";
	DBM_SBT["Watery Grave"]	= "水之墓穴";


-- Fathom-Lord Karathress
	DBM_FATHOMLORD_NAME					= "深水领主卡拉瑟雷斯";
	DBM_FATHOMLORD_DESCRIPTION			= "警报溅火图腾以及治疗波";

	DBM_FATHOMLORD_YELL_PULL			= "卫兵！提高警惕！我们有客人来了……";
	DBM_FATHOMLORD_OPTION_TOTEM_1		= "警报泰达维斯的溅火图腾";
	DBM_FATHOMLORD_OPTION_TOTEM_2		= "警报卡拉瑟雷斯的溅火图腾";
	DBM_FATHOMLORD_OPTION_HEAL			= "警报治疗波";

	DBM_FATHOMLORD_TIDALVESS_TOTEM		= "深水卫士泰达维斯施放了飞火图腾。";
	DBM_FATHOMLORD_KARATHRESS_TOTEM		= "深水领主卡拉瑟雷斯施放了飞火图腾。";
	DBM_FATHOMLORD_CAST_HEAL			= "深水卫士卡莉蒂丝开始施放治疗波。";

	DBM_FATHOMLORD_SFTOTEM1_WARN		= "*** 溅火图腾 @ 泰达维斯 ***";
	DBM_FATHOMLORD_SFTOTEM2_WARN		= "*** 溅火图腾 @ 卡拉瑟雷斯 ***";
	DBM_FATHOMLORD_HEAL_WARN			= "*** 治疗波 ***";

	DBM_SBT["Enrage"]		= "激怒";
	DBM_SBT["Healing Wave"]	= "治疗波";


-- The Lurker Below
	DBM_LURKER_NAME						= "鱼斯拉";
	DBM_LURKER_DESCRIPTION				= "警报下潜、喷涌以及旋风";
	DBM_LURKER_OPTION_WHIRL				= "警报旋风";
	DBM_LURKER_OPTION_WHIRLSOON			= "显示“旋风 - 即将施放”警报（由于旋风技能的施法间隔有波动，故该警报不是相当准确）";
	DBM_LURKER_OPTION_SPOUT				= "警报喷涌";

	DBM_LURKER_EMOTE_SPOUT				= "%s深深吸了一口气！";
	DBM_LURKER_CAST_SPOUT				= "鱼斯拉的喷涌";
	DBM_LURKER_CAST_WHIRL				= "鱼斯拉的旋风";
	DBM_LURKER_CAST_GEYSER				= "鱼斯拉的喷泉击中([^%s]+)造成";

	DBM_LURKER_WARN_SPOUT_SOON			= "*** 喷涌 - 即将施放 ***";
	DBM_LURKER_WARN_SPOUT				= "*** 喷涌 ***";
	DBM_LURKER_WARN_SUBMERGE			= "*** 下潜 ***";
	DBM_LURKER_WARN_EMERGE				= "*** 重新出现 ***";

	DBM_LURKER_WARN_WHIRL				= "*** 旋风 ***";
	DBM_LURKER_WARN_WHIRL_SOON			= "*** 旋风 - 即将施放 ***";

	DBM_LURKER_WARN_SUBMERGE_SOON		= "*** %s秒后下潜 ***";

	DBM_SBT["Submerge"]		= "下潜";
	DBM_SBT["Emerge"]		= "重新出现";
	DBM_SBT["Spout"]		= "喷涌";
	DBM_SBT["Next Spout"]	= "下一次喷涌";
	DBM_SBT["Whirl"]		= "旋风";


-- Leotheras the Blind
	DBM_LEO_NAME						= "盲眼者莱欧瑟拉斯";
	DBM_LEO_DESCRIPTION					= "警报旋风斩、心魔以及阶段变化";
	DBM_LEO_OPTION_WHIRL				= "警报旋风斩";
	DBM_LEO_OPTION_DEMON				= "警报心魔";
	DBM_LEO_OPTION_DEMONWARN			= "警报心魔的目标";

	DBM_LEO_YELL_PULL					= "我的放逐终于结束了！";
	DBM_LEO_YELL_DEMON					= "滚开吧，脆弱的精灵。现在我说了算！";
	DBM_LEO_YELL_SHADOW					= "不……不！你在干什么？我才是主宰！你听到没有？我……啊啊啊啊！控制……不住了。";
	DBM_LEO_GAIN_WHIRLWIND				= "盲眼者莱欧瑟拉斯获得了旋风斩的效果。";
	DBM_LEO_FADE_WHIRLWIND				= "旋风斩效果从盲眼者莱欧瑟拉斯身上消失。";
	DBM_LEO_DEBUFF_WHISPER				= "([^%s]+)受([^%s]+)因斯迪安低语效果的影响。";
	DBM_LEO_CAST_WHISPER				= "盲眼者莱欧瑟拉斯开始施放因斯迪安低语。";
	DBM_LEO_YELL_WHISPER				= "所有人的内心之中都有一只恶魔……";

	DBM_LEO_WARN_ENRAGE					= "*** %s%s后激怒 ***";
	DBM_LEO_WARN_WHIRL					= "*** 旋风斩 ***";
	DBM_LEO_WARN_WHIRL_SOON				= "*** 旋风斩 - 5秒后施放 ***";
	DBM_LEO_WARN_WHIRL_SOON_2			= "*** 旋风斩 - 即将施放 ***";
	DBM_LEO_WARN_WHIRL_FADED			= "*** 旋风斩效果消失 ***";
	DBM_LEO_WARN_SHADOW					= "*** 莱欧瑟拉斯之影出现 ***";
	DBM_LEO_WARN_DEMON_PHASE			= "*** 恶魔形态 ***";
	DBM_LEO_WARN_NORMAL_PHASE			= "*** 人形态 ***";
	DBM_LEO_WARN_DEMON_PHASE_SOON		= "*** 5秒后变为恶魔形态 ***";
	DBM_LEO_WARN_NORMAL_PHASE_SOON		= "*** 5秒后变为人形态 ***";
	DBM_LEO_SPECWARN_INNER_DEMON		= "心魔";
	DBM_LEO_WHISPER_INNER_DEMON			= "杀掉你的心魔！"
	DBM_LEO_WARN_DEMONS_INC				= "*** 心魔 - 即将出现 ***";
	DBM_LEO_WARN_DEMONS_NOW				= "*** 心魔 ***";
	DBM_LEO_WARN_DEMON_TARGETS			= "*** 心魔 -> %s ***";

	DBM_SBT["Enrage"]			= "激怒";
	DBM_SBT["Demon Form"]		= "恶魔形态";
	DBM_SBT["Normal Form"]		= "一般形态";
	DBM_SBT["Next Whirlwind"]	= "下一次旋风斩";
	DBM_SBT["Inner Demons"]		= "心魔";
	DBM_SBT["Whirlwind"]		= "旋风斩";


-- Lady Vashj
	DBM_VASHJ_NAME						= "瓦丝琪";
	DBM_VASHJ_DESCRIPTION				= "警报静电充能、阶段变化、魔法屏障以及激怒"

	DBM_VASHJ_OPTION_RANGECHECK			= "显示距离框体";
	DBM_VASHJ_OPTION_CHARGE				= "警报静电充能";
	DBM_VASHJ_OPTION_CHARGEICON			= "对静电充能的目标添加标注";
	DBM_VASHJ_OPTION_SPAWNS				= "警报第二阶段的敌人出现";
	DBM_VASHJ_OPTION_COREWARN			= "警报是谁拾取了污染之核";
	DBM_VASHJ_OPTION_COREICON			= "对拾取了污染之核的队友添加标注";
	DBM_VASHJ_OPTION_CORESPECWARN		= "当你拾取污染之核时显示特殊警报";

	DBM_VASHJ_YELL_PULL1				= "我唾弃你们，地表的渣滓！";
	DBM_VASHJ_YELL_PULL2				= "伊利丹大人必胜！";
	DBM_VASHJ_YELL_PULL3 				= "我要把你们全都杀死！";
	DBM_VASHJ_YELL_PULL4				= "我不想贬低自己来获取你的宽容，但是你让我别无选择……";
	DBM_VASHJ_CAST_CHARGE				= "([^%s]+)受([^%s]+)静电充能效果的影响。";
	DBM_VASHJ_YELL_PHASE2				= "机会来了！一个活口都不要留下！";
	DBM_VASHJ_ELEMENT_DIES				= "被污染的元素";
	DBM_VASHJ_FADE_SHIELD				= "魔法屏障效果从瓦丝琪身上消失。";
	DBM_VASHJ_DEBUFF_CORE				= "([^%s]+)受([^%s]+)麻痹效果的影响。";
	DBM_VASHJ_YELL_PHASE3				= "你们最好找掩护。";

	DBM_VASHJ_WARN_CHARGE				= "*** 静电充能 -> >%s< ***";
	DBM_VASHJ_SPECWARN_CHARGE			= "你受到了静电充能效果！";

	DBM_VASHJ_WARN_PHASE2				= "*** 第二阶段 ***";
	DBM_VASHJ_WARN_ELE_SOON				= "*** 被污染的元素 - 5秒后出现 ***";
	DBM_VASHJ_WARN_ELE_NOW				= "*** 被污染的元素出现 ***";
	DBM_VASHJ_WARN_STRIDER_SOON			= "*** 盘牙巡逻者 - 5秒后出现 ***";
	DBM_VASHJ_WARN_STRIDER_NOW			= "*** 盘牙巡逻者出现 ***";
	DBM_VASHJ_WARN_NAGA_SOON			= "*** 盘牙精英 - 5秒后出现 ***";
	DBM_VASHJ_WARN_NAGA_NOW				= "*** 盘牙精英出现 ***";
	DBM_VASHJ_WARN_SHIELD_FADED			= "*** 护盾 - %d/4被击碎 ***";
	DBM_VASHJ_WARN_CORE_LOOT			= "*** >%s<获得了污染之核 ***";
	DBM_VASHJ_SPECWARN_CORE				= "你获得了污染之核！";
	DBM_VASHJ_LOOT						= "(.+)(.*)了物品：(%d+)。";

	DBM_VASHJ_WARN_PHASE3				= "*** 护盾被完全击碎 - 第三阶段开始 ***";
	DBM_VASHJ_WARN_ENRAGE				= "*** %s%s后激怒 ***";

	DBM_SBT["Enrage"]				= "激怒";
	DBM_SBT["Strider"]				= "盘牙巡逻者";
	DBM_SBT["Tainted Elemental"]	= "被污染的元素";
	DBM_SBT["Naga"]					= "盘牙精英";
	
	DBM_SBT["Vashj"] = {
		  [1] = {"Static Charge: (.*)", "静电充能 -> %1"},
	}
	DBM_SBT["瓦丝琪"] = DBM_SBT["Vashj"]


end

