-- ------------------------------------------- --
--   Deadly Boss Mods - Chinese localization   --
--    by Diablohu<白银之手> @ 二区-轻风之语    --
--              www.dreamgen.cn                --
--                 11/23/2007                  --
-- ------------------------------------------- --

if (GetLocale() == "zhCN") then

	DBM_EYE_TAB			= "EyeTab"
	DBM_TEMPEST_KEEP	= "风暴要塞";


-- Void Reaver
	DBM_VOIDREAVER_NAME						= "空灵机甲";
	DBM_VOIDREAVER_DESCRIPTION				= "警报奥术宝珠以及重击";
	DBM_VOIDREAVER_OPTION_WARN_ORB			= "警报奥术宝珠的目标";
	DBM_VOIDREAVER_OPTION_YELL_ORB			= "当奥术宝珠对你施放时喊话";
	DBM_VOIDREAVER_OPTION_ORB_ICON			= "对奥术宝珠的目标添加标注";
	DBM_VOIDREAVER_OPTION_WARN_POUNDING		= "警报重击";
	DBM_VOIDREAVER_OPTION_WARN_POUNDINGSOON	= "显示“重击 - 即将施放”警报";
	DBM_VOIDREAVER_OPTION_SOUND				= "当奥术宝珠对你施放时播放声音警报";

	DBM_VOIDREAVER_POUNDING					= "重击";

	DBM_VOIDREAVER_WARN_ORB					= "*** 奥术宝珠 -> >%s< ***";
	DBM_VOIDREAVER_YELL_ORB					= "奥术宝珠于我！远离我！";
	DBM_VOIDREAVER_WARN_ENRAGE				= "*** %s%s后激怒 ***";
	DBM_VOIDREAVER_WARN_POUNDING			= "*** 重击 ***";
	DBM_VOIDREAVER_WARN_POUNDING_SOON		= "*** 重击 - 即将施放 ***";
	DBM_VOIDREAVER_SPECWARN_ORB				= "奥术宝珠于你！";

	DBM_VOIDREAVER_R_FURY					= "正义之怒"

	DBM_SBT["Enrage"]			= "激怒";
	DBM_SBT["Next Pounding"]	= "下一次重击";
	DBM_SBT["Pounding"]			= "重击";


-- Solarian
	DBM_SOLARIAN_NAME						= "大星术师索兰莉安";
	DBM_SOLARIAN_DESCRIPTION				= "警报星术师之怒以及下属出现";
	DBM_SOLARIAN_OPTION_WARN_WRATH			= "警报星术师之怒";
	DBM_SOLARIAN_OPTION_ICON_WRATH			= "对星术师之怒的目标添加标注";
	DBM_SOLARIAN_OPTION_SPECWARN_WRATH		= "当你受到星术师之怒效果时显示特殊警报";
	DBM_SOLARIAN_OPTION_WARN_PHASE			= "警报下属出现";
	DBM_SOLARIAN_OPTION_SOUND				= "当你受到星术师之怒效果时播放声音警报"
	DBM_SOLARIAN_OPTION_WHISPER_WRATH		= "向受到星术师之怒效果的目标发送密语"

	DBM_SOLARIAN_DEBUFF_WRATH				= "([^%s]+)受([^%s]+)星术师之怒效果的影响。"
	DBM_SOLARIAN_CAST_SPLIT					= "大星术师索兰莉安施放了星术师分裂。";
	DBM_SOLARIAN_YELL_ENRAGE				= "我受够了！现在我要让你们看看宇宙的愤怒！"

	DBM_SOLARIAN_SPECWARN_WRATH				= "星术师之怒！";
	DBM_SOLARIAN_ANNOUNCE_WRATH				= "*** 星术师之怒 -> >%s< ***";
	DBM_SOLARIAN_ANNOUNCE_SPLIT				= "*** 下属即将出现 ***";
	DBM_SOLARIAN_ANNOUNCE_PRIESTS_SOON		= "*** 祭司与索兰莉安 - 5秒后出现 ***";
	DBM_SOLARIAN_ANNOUNCE_PRIESTS_NOW		= "*** 祭司与索兰莉安出现 ***";
	DBM_SOLARIAN_ANNOUNCE_AGENTS_NOW		= "*** 密探出现 ***";
	DBM_SOLARIAN_ANNOUNCE_SPLIT_SOON		= "*** 5秒后分裂 ***";
	DBM_SOLARIAN_ANNOUNCE_ENRAGE_PHASE		= "*** 虚空行者阶段 ***";

	DBM_SBT["Split"]				= "分裂";
	DBM_SBT["Priests & Solarian"]	= "祭司与索兰莉安";
	DBM_SBT["Agents"]				= "密探";
	
	DBM_SBT["Solarian"] = {
		  [1] = {"Wrath: (.*)", "星术师之怒 -> %1"},
	}
	DBM_SBT["大星术师索兰莉安"] = DBM_SBT["Solarian"]


-- Al'ar
	DBM_ALAR_NAME				= "奥";
	DBM_ALAR_DESCRIPTION		= "显示计时警报。";
	DBM_ALAR_OPTION_MELTARMOR	= "警报熔化护甲";
	DBM_ALAR_OPTION_METEOR		= "警报流星";

	DBM_ALAR_CAST_REBIRTH		= "奥开始施放复生。";
	DBM_ALAR_DEBUFF_MELTARMOR	= "([^%s]+)受([^%s]+)熔化护甲效果的影响。";
	DBM_ALAR_DEBUFF_FIRE_YOU	= "你受到了烈焰之地效果的影响。";
	DBM_ALAR_FLAME_BUFFET		= "烈焰击打";

	DBM_ALAR_WARN_MELTARMOR		= "*** 熔化护甲 -> >%s< ***";
	DBM_ALAR_WARN_REBIRTH		= "*** 复生 ***";
	DBM_ALAR_WARN_FIRE			= "烈焰之地";
	DBM_ALAR_WARN_ADD			= "*** 下一个位置 - 小怪出现 ***";
	DBM_ALAR_WARN_METEOR		= "*** 流星 ***";
	DBM_ALAR_WARN_METEOR_SOON	= "*** 流星 - 即将施放 ***";
	DBM_ALAR_WARN_ENRAGE		= "*** %s%s后激怒 ***";

	DBM_SBT["Next Platform"]	= "下一个位置";
	DBM_SBT["Meteor"]			= "流星";
	DBM_SBT["Enrage"]			= "激怒";
	
	DBM_SBT["Alar"] = {
		  [1] = {"Melt Armor: (.*)", "熔化护甲 -> %1"},
	}
	DBM_SBT["奥"] = DBM_SBT["Alar"]


-- Kael'thas
	DBM_KAEL_NAME							= "凯尔萨斯·逐日者";
	DBM_KAEL_DESCRIPTION					= "战斗计时警报";

	DBM_KAEL_OPTION_PHASE					= "警报阶段变化";
	DBM_KAEL_OPTION_ICON_P1					= "对萨拉德雷的目标添加标注";
	DBM_KAEL_OPTION_WHISPER_P1				= "对萨拉德雷的目标发送密语";
	DBM_KAEL_OPTION_RANGECHECK				= "显示距离框体";
	DBM_KAEL_OPTION_CONFLAG					= "警报燃烧";
	DBM_KAEL_OPTION_CONFLAG2				= "警报第三阶段的燃烧";
	DBM_KAEL_OPTION_CONFLAGTIMER2			= "在第三阶段显示燃烧技能计时";
	DBM_KAEL_OPTION_FEAR					= "警报恐惧";
	DBM_KAEL_OPTION_FEARSOON				= "显示“恐惧 - 即将施放”警报";
	DBM_KAEL_OPTION_TOY						= "警报第一阶段的遥控玩具";
	DBM_KAEL_OPTION_FRAME					= "显示武器的生命值";
	DBM_KAEL_OPTION_ADDFRAME				= "显示顾问的生命值";
	DBM_KAEL_OPTION_PYRO					= "警报炎爆术";
	DBM_KAEL_OPTION_BARRIER					= "警报冲击屏障";
	DBM_KAEL_OPTION_BARRIER2				= "警报第五阶段的冲击屏障";
	DBM_KAEL_OPTION_PHOENIX					= "警报凤凰刷新";
	DBM_KAEL_OPTION_WARNMC					= "警报精神控制";
	DBM_KAEL_OPTION_ICONMC					= "对精神控制的目标添加标注";
	DBM_KAEL_OPTION_GRAVITY					= "警报引力失效";

	DBM_KAEL_YELL_PHASE1					= "魔法，能量，我的人民陷入其中不能自拔……自从太阳之井被摧毁之后就是如此。欢迎来到未来。真遗憾，你们无法阻止什么。没有人可以阻止我了！Selama ashal’anore！！";
	DBM_KAEL_YELL_PHASE1_SANGUINAR			= "你们击败了我最强大的顾问……但是没有人能战胜鲜血之锤。出来吧，萨古纳尔男爵！";
	DBM_KAEL_YELL_PHASE1_CAPERNIAN			= "卡波妮娅会很快解决你们的。";
	DBM_KAEL_YELL_PHASE1_TELONICUS			= "干得不错。看来你们有能力挑战我的首席技师，塔隆尼库斯。";
	DBM_KAEL_YELL_THALA_DOWN				= "原谅我，王子殿下！我……失败了。";
	DBM_KAEL_YELL_CAPERNIAN_DOWN			= "还没完！";

	DBM_KAEL_EMOTE_THALADRED_TARGET			= "凝视着([^%s]+)！";
	DBM_KAEL_CAST_FEAR						= "萨古纳尔男爵开始施放咆哮。";
	DBM_KAEL_DEBUFF_FEAR1					= "受到了咆哮效果的影响";
	DBM_KAEL_DEBUFF_FEAR2					= "萨古纳尔男爵的咆哮";
	DBM_KAEL_DEBUFF_CONFLAGRATION			= "([^%s]+)受([^%s]+)燃烧效果的影响。";
	DBM_KAEL_DEBUFF_REMOTETOY				= "([^%s]+)受([^%s]+)遥控玩具效果的影响。";

	DBM_KAEL_YELL_PHASE2					= "你们看，我的个人收藏中有许多武器……";
	DBM_KAEL_YELL_PHASE3					= "也许我确实低估了你们。虽然让你们同时面对我的四位顾问显得有些不公平，但是我的人民从来都没有得到过公平的待遇。我只是在以牙还牙。";
	DBM_KAEL_YELL_PHASE4					= "唉，有些时候，有些事情，必须得亲自解决才行。Balamore shanal！";
	DBM_KAEL_YELL_PHASE5					= "我的心血是不会被你们轻易浪费的！我精心谋划的未来是不会被你们轻易破坏的！感受我真正的力量吧！";

	DBM_KAEL_WEAPONS = {
		["瓦解法杖"] = 1,
		["无尽之刃"] = 2,
		["宇宙灌注者"] = 3,
		["迁跃切割者"] = 4,
		["毁灭"] = 5,
		["灵弦长弓"] = 6,
		["相位壁垒"] = 7
	};

	DBM_KAEL_WEAPONS_NAMES = {
		"法杖",
		"匕首",
		"锤",
		"剑",
		"斧",
		"弓",
		"盾牌"
	};

	DBM_KAEL_ADVISORS = {
		["亵渎者萨拉德雷"] = 1,
		["萨古纳尔男爵"] = 2,
		["星术师卡波妮娅"] = 3,
		["首席技师塔隆尼库斯"] = 4,
	};

	DBM_KAEL_ADVISORS_NAMES = {
		"萨拉德雷",
		"萨古纳尔",
		"卡波妮娅",
		"塔隆尼库斯"
	};

	DBM_KAEL_INFOFRAME_TITLE				= "武器";
	DBM_KAEL_INFOFRAME_ADDS_TITLE			= "顾问";

	DBM_KAEL_CAST_PHOENIX_REBIRTH			= "凤凰开始施放复生。";
	DBM_KAEL_EMOTE_PYROBLAST				= "开始施放炎爆术";
	DBM_KAEL_CAST_PYROBLAST					= "凯尔萨斯·逐日者开始施放炎爆术。";
	DBM_KAEL_GAIN_SHOCK_BARRIER				= "凯尔萨斯·逐日者获得了冲击屏障的效果。";
	DBM_KAEL_FADE_SHOCK_BARRIER				= "冲击屏障效果从凯尔萨斯·逐日者身上消失。";
	DBM_KAEL_CAST_PHOENIX					= "凯尔萨斯·逐日者施放了凤凰。";
	DBM_KAEL_DEBUFF_MINDCONTROL				= "([^%s]+)受([^%s]+)精神控制效果的影响。";
	DBM_KAEL_FADE_MINDCONTROL				= "([^%s]+)的精神控制被移除了。";
	DBM_KAEL_FADE_MINDCONTROL_YOU			= "你的精神控制制被移除了。";
	DBM_KAEL_EGG							= "凤凰卵";
	DBM_KAEL_YELL_GRAVITY_LAPSE				= "站不住脚了吗？";
	DBM_KAEL_YELL_GRAVITY_LAPSE2			= "如果世界变得上下颠倒，你们会怎么办呢？";

	DBM_KAEL_SPECWARN_THALADRED_TARGET		= "快跑！";
	DBM_KAEL_WARN_THALADRED_TARGET			= "*** 萨拉德雷注视着>%s< ***";
	DBM_KAEL_WHISPER_THALADRED_TARGET		= "萨拉德雷注视着你！快跑！";
	DBM_KAEL_WARN_INC						= "*** %s - 即将触发 ***";
	DBM_KAEL_SANGUINAR						= "萨古纳尔";
	DBM_KAEL_CAPERNIAN						= "卡波妮娅";
	DBM_KAEL_TELONICUS						= "塔隆尼库斯";
	DBM_KAEL_WARN_FEAR						= "*** 恐惧 - 1.5秒后施放 ***";
	DBM_KAEL_WARN_FEAR_SOON					= "*** 恐惧 - 即将施放 ***";
	DBM_KAEL_WARN_CONFLAGRATION				= "*** 燃烧 -> >%s< ***";
	DBM_KAEL_WARN_REMOTETOY					= "*** 遥控玩具 -> >%s< ***";

	DBM_KAEL_WARN_PHASE1					= "*** 第一阶段 - 萨拉德雷即将触发 ***";
	DBM_KAEL_WARN_PHASE2					= "*** 第二阶段 - 准备与神器作战 ***";
	DBM_KAEL_WARN_PHASE3					= "*** 第三阶段 - 顾问复生 ***";
	DBM_KAEL_WARN_PHASE4					= "*** 第四阶段 - 凯尔萨斯即将触发 ***";
	DBM_KAEL_WARN_PHASE5					= "*** 第五阶段 ***";

	DBM_KAEL_WARN_PYRO						= "*** 炎爆术 ***";
	DBM_KAEL_WARN_BARRIER_SOON				= "*** 冲击屏障 - 5秒后施放 ***";
	DBM_KAEL_WARN_BARRIER_NOW				= "*** 冲击屏障 ***";
	DBM_KAEL_WARN_BARRIER_DOWN				= "*** 屏障消失 ***";
	DBM_KAEL_WARN_PHOENIX					= "*** 凤凰出现 ***";
	DBM_KAEL_WARN_MC_TARGETS				= "*** 精神控制 -> %s ***";
	DBM_KAEL_WARN_REBIRTH					= "*** 凤凰倒下 - 卵出现 ***";
	DBM_KAEL_WARN_GRAVITY_LAPSE				= "*** 引力失效 ***";
	DBM_KAEL_GRAVITY_SOON					= "*** 引力失效 - 即将释放 ***";
	DBM_KAEL_GRAVITY_END_SOON				= "*** 引力失效 - 5秒后结束 ***";

	DBM_SBT["Thaladred"]			= "萨拉德雷";
	DBM_SBT["Lord Sanguinar"]		= "萨古纳尔";
	DBM_SBT["Capernian"]			= "卡波妮娅";
	DBM_SBT["Telonicus"]			= "塔隆尼库斯";
	DBM_SBT["Phase 3"]				= "第三阶段";
	DBM_SBT["Phase 4"]				= "第四阶段";
	DBM_SBT["Next Gravity Lapse"]	= "下一次引力失效";
	DBM_SBT["Next Shock Barrier"]	= "下一次冲击屏障";
	DBM_SBT["Next Fear"]			= "下一次恐惧";
	DBM_SBT["Phoenix"]				= "凤凰";
	DBM_SBT["Rebirth"]				= "复生";
	DBM_SBT["Fear"]					= "恐惧";
	DBM_SBT["Pyroblast"]			= "炎爆术";
	DBM_SBT["Shock Barrier"]		= "冲击屏障";
	DBM_SBT["Gravity Lapse"]		= "引力失效";
	DBM_SBT["Gaze Cooldown"]		= "凝视冷却";
	
	DBM_SBT["KaelThas"] = {
		  [1] = {"Conflagration: (.*)", "燃烧 -> %1"},
		  [2] = {"Remote Toy: (.*)", "遥控玩具 -> %1"},
	}
	DBM_SBT["凯尔萨斯·逐日者"] = DBM_SBT["KaelThas"]

end

