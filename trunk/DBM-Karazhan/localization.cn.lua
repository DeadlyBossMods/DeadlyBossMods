-- ------------------------------------------- --
--   Deadly Boss Mods - Chinese localization   --
--    by Diablohu<白银之手> @ 二区-轻风之语    --
--              www.dreamgen.cn                --
--                 10/17/2007                  --
-- ------------------------------------------- --

if (GetLocale() == "zhCN") then

	DBM_KARAZHAN		= "卡拉赞";
	DBM_KARAZHAN_TAB	= "Karazhan";

--Attumen
	DBM_ATH_NAME		= "猎手阿图门";
	DBM_ATH_DESCRIPTION	= "警报诅咒";
	DBM_ATH_OPTION_1	= "显示5秒警报";

	DBM_ATH_WARN_CURSE	= "*** 诅咒 ***";
	DBM_ATH_CURSE_SOON	= "*** 诅咒 - 即将施放 ***";

	DBM_ATH_MIDNIGHT	= "午夜";
	DBM_ATH_CURSE		= "受到了无形效果的影响";
	DBM_ATH_YELL_1		= "来吧，午夜，让我们解决这群乌合之众！";

	DBM_SBT["Curse"]	= "诅咒";


--Moroes
	DBM_MOROES_NAME			= "莫罗斯";
	DBM_MOROES_DESCRIPTION	= "警报消失";
	DBM_MOROES_OPTION_1		= "警报获得消失";
	DBM_MOROES_OPTION_2		= "警报消失效果消失";
	DBM_MOROES_OPTION_3		= "警报即将消失";
	DBM_MOROES_OPTION_4		= "警报锁喉";

	DBM_MOROES_VANISH_WARN	= "*** 消失 ***";
	DBM_MOROES_VANISH_FADED	= "*** 消失 - 效果消失 ***";
	DBM_MOROES_VANISH_SOON	= "*** 消失 - 即将施放 ***";
	DBM_MOROES_GARROTE_WARN	= "*** 锁喉 -> >%s< ***";

	DBM_MOROES_YELL_START	= "啊，不速之客。我得准备一下……";
	DBM_MOROES_VANISH_GAIN	= "莫罗斯获得了消失的效果。";
	DBM_MOROES_VANISH_FADES	= "消失效果从莫罗斯身上消失。";
	DBM_MOROES_GARROTE		= "([^%s]+)受([^%s]+)锁喉效果的影响。";

	DBM_SBT["Vanish"]	= "消失";


-- Maiden of Virtue
	DBM_MOV_NAME		= "贞节圣女";
	DBM_MOV_DESCRIPTION	= "警报悔改和神圣之火";
	DBM_MOV_OPTION_1	= "显示距离框体";
	DBM_MOV_OPTION_2	= "警报神圣之火";
	
	DBM_MOV_YELL_PULL		= "你们的行为是不可饶恕的。";
	DBM_MOV_REPENTANCE		= "受到了悔改效果的影响";
	DBM_MOV_YELL_REP_1		= "抛弃一切堕落的杂念。";
	DBM_MOV_YELL_REP_2		= "你们必须得到净化。";
	DBM_MOV_WARN_REP		= "*** 悔改 ***";
	DBM_MOV_WARN_REP_SOON	= "*** 悔改 - 即将施放 ***";

	DBM_MOV_DEBUFF_HOLYFIRE	= "([^%s]+)受([^%s]+)神圣之火效果的影响。";
	DBM_MOV_WARN_HOLYFIRE	= "*** 神圣之火 -> >%s< ***";

	DBM_SBT["Next Repentance"]	= "下一次悔改";
	DBM_SBT["Repentance"]		= "悔改";


-- Romulo and Julianne
	DBM_RJ_NAME			= "罗密欧与朱丽叶";
	DBM_RJ_DESCRIPTION	= "警报罗密欧的鲁莽以及朱丽叶的虔诚";
	DBM_RJ_OPTION_1		= "警报朱丽叶的治疗";
	DBM_RJ_OPTION_2		= "警报浸毒之刺";

	DBM_RJ_DARING_WARN		= "*** 罗密欧获得了卤莽效果 ***";
	DBM_RJ_DEVOTION_WARN	= "*** 朱丽叶获得了虔诚效果 ***";
	DBM_RJ_HEAL_WARN		= "*** 朱丽叶开始施放治疗 ***";
	DBM_RJ_POISON_WARN		= "浸毒之刺 -> >%s<";

	DBM_RJ_ROMULO			= "罗密欧";
	DBM_RJ_JULIANNE			= "朱丽叶";
	DBM_RJ_GAIN_DARING		= "罗密欧获得了卤莽的效果。";
	DBM_RJ_GAIN_DEVOTION 	= "朱丽叶获得了虔诚的效果。";
	DBM_RJ_CAST_HEAL		= "朱丽叶开始施放永恒之爱。";
	DBM_RJ_PHASE2_YELL		= "来吧，可爱的黑颜的夜，把我的罗密欧给我！";
	DBM_RJ_POISON			= "([^%s]+)受([^%s]+)浸毒之刺效果的影响。";

	DBM_SBT["Heal"]	= "治疗";


-- Big Bad Wolf
	DBM_BBW_NAME		= "大灰狼";
	DBM_BBW_DESCRIPTION	= "警报小红帽技能";
	DBM_BBW_OPTION_1	= "警报恐惧";
	DBM_BBW_OPTION_2	= "密语玩家";

	DBM_BBW_YELL_1			= "可以一口把你吃掉呀！";
	DBM_BBW_GAIN_DEBUFF		= "(.+)获得了小红帽的效果。";
	DBM_BBW_AFFLICTED_DEBUFF= "([^%s]+)受([^%s]+)小红帽效果的影响。";
	DBM_BBW_YOU_GAIN		= "你获得了小红帽的效果。"
	DBM_BBW_FEAR_EXP		= "恐吓嚎叫";

	DBM_BBW_FEAR_WARN		= "*** 恐惧 ***";
	DBM_BBW_FEAR_SOON		= "*** 恐惧 - 即将施放 ***";
	DBM_BBW_RRH_WARN		= "*** >%s< 成为了小红帽 ***";
	DBM_BBW_RUN_AWAY		= "快跑！";
	DBM_BBW_RUN_AWAY_WHISP	= "你成为了小红帽！快跑！";
	DBM_BBW_RRH_SOON_WARN	= "*** 小红帽 - 即将施放 ***";

	DBM_SBT["Next Red Riding Hood"]	= "下一次小红帽施放";
	DBM_SBT["Red Riding Hood"]		= "小红帽";
	DBM_SBT["Fear"]					= "恐惧";


-- Curator
	DBM_CURA_NAME			= "馆长";
	DBM_CURA_DESCRIPTION	= "警报唤醒";

	DBM_CURA_YELL_PULL	= "展览厅只对访客开放。";
	DBM_CURA_YELL_OOM	= "你的请求未能得到批准。";

	DBM_CURA_EVO_NOW	= "*** 唤醒 ***";
	DBM_CURA_EVO_SOON	= "*** 唤醒 - 即将施放 ***";
	DBM_CURA_EVO_1MIN	= "唤醒 - 1分钟后施放"

	DBM_SBT["Next Evocation"]	= "下一次唤醒施放";
	DBM_SBT["Evocation"]		= "唤醒";


-- Terestian Illhoof
	DBM_TI_NAME				= "特雷斯坦·邪蹄";
	DBM_TI_DESCRIPTION		= "警报恶魔锁链以及虚弱阶段";
	DBM_TI_OPTION_1			= "警报召唤小鬼";

	DBM_TI_YELL_PULL		= "啊，你们来的正是时候。仪式就要开始了！";
	DBM_TI_SACRIFICE		= "([^%s]+)受([^%s]+)牺牲效果的影响。";
	DBM_TI_EMOTE_IMP		= "%s痛苦地尖叫着，并指向他的主人。";
	DBM_TI_CAST_IMP			= "特雷斯坦·邪蹄施放了召唤小鬼。";

	DBM_TI_SACRIFICE_WARN	= "*** >%s< 成为了祭品 ***";
	DBM_TI_SACRIFICE_SOON	= "*** 牺牲 - 即将施放 ***";
	DBM_TI_WEAKENED_WARN	= "*** 虚弱阶段 ***";
	DBM_TI_IMP_SOON			= "*** 基尔里克即将复活 ***";
	DBM_TI_IMP_RESPAWNED	= "*** 基尔里克复活 ***";

	DBM_SBT["Weakened"]		= "虚弱阶段";
	DBM_SBT["Sacrifice"]	= "牺牲";


-- Shade of Aran
	DBM_ARAN_NAME			= "埃兰之影";
	DBM_ARAN_DESCRIPTION	= "警报烈焰花环以及魔爆术";

	DBM_ARAN_CAST_WREATH	= "埃兰之影开始施放烈焰花环。";
	DBM_ARAN_CAST_AE		= "埃兰之影开始施放魔爆术。";
	DBM_ARAN_CAST_BLIZZ		= "埃兰之影开始施放召唤暴风雪。";
	DBM_ARAN_YELL_ADDS		= "还没完！我还有几招没有用呢……";
	DBM_ARAN_YELL_BLIZZ1	= "回到寒冷的黑暗中去吧！";
	DBM_ARAN_YELL_BLIZZ2	= "我要把你们全都冰冻！";

	DBM_ARAN_WREATH_WARN	= "*** 烈焰花环 - 5秒后施放 ***";
	DBM_ARAN_AE_WARN		= "*** 魔爆术 ***";
	DBM_ARAN_BLIZZ_WARN		= "*** 暴风雪 ***";
	DBM_ARAN_ADDS_WARN		= "*** 召唤元素 ***";
	DBM_ARAN_DO_NOT_MOVE	= "不要移动！";

	DBM_SBT["Flame Wreath Cast"]		= "烈焰花环正在施放";
	DBM_SBT["Flame Wreath"]				= "烈焰花环";
	DBM_SBT["Arcane Explosion"]			= "魔爆术";
	DBM_SBT["Blizzard"]					= "暴风雪";
	DBM_SBT["Elementals despawn in"]	= "召唤元素";


--Netherspite
	DBM_NS_NAME			= "虚空幽龙";
	DBM_NS_DESCRIPTION	= "警报阶段切换、虚空吐吸和虚空领域";
	DBM_NS_OPTION_1		= "警报阶段切换";
	DBM_NS_OPTION_2		= "显示阶段切换5秒警报";
	DBM_NS_OPTION_3		= "警报虚空领域";
	DBM_NS_OPTION_4		= "警报虚空吐吸";

	DBM_NS_CAST_MODE_SWAP	= "虚空幽龙施放了模式切换。";
	DBM_NS_CAST_VOID_ZONE	= "虚空幽龙施放了虚空领域。";
	DBM_NS_CAST_BREATH		= "虚空幽龙开始施放虚空吐息。";
	DBM_NS_EMOTE_PHASE_2	= "%s的怒火甚至可以充满整个虚空！";
	DBM_NS_EMOTE_PHASE_1	= "%s在撤退中大声呼喊着，打开了回到虚空的传送门。";

	DBM_NS_WARN_PORTAL		= "*** 虚空门阶段 ***";
	DBM_NS_WARN_BANISH		= "*** 放逐阶段 ***";
	DBM_NS_WARN_PORTAL_SOON	= "*** 5秒后进入虚空门阶段 ***";
	DBM_NS_WARN_BANISH_SOON	= "*** 5秒后进入放逐阶段 ***";
	DBM_NS_WARN_BREATH		= "*** 虚空吐息 ***";
	DBM_NS_WARN_VOID_ZONE	= "*** 虚空领域 ***";
	DBM_NS_WARN_ENRAGE		= "*** %s%s后激怒 ***";

	DBM_SBT["Portal Phase"]	= "虚空门阶段";
	DBM_SBT["Banish Phase"]	= "放逐阶段";
	DBM_SBT["Netherbreath"]	= "虚空吐吸";
	DBM_SBT["Enrage"]		= "激怒";


--Prince Malchezaar
	DBM_PRINCE_NAME			= "玛克扎尔王子"
	DBM_PRINCE_DESCRIPTION	= "警报地狱火、衰弱、痛以及暗影新星";
	DBM_PRINCE_OPTION_1		= "警报暗影新星";
	DBM_PRINCE_OPTION_2		= "警报能量衰弱";
	DBM_PRINCE_OPTION_3		= "密语玩家";
	DBM_PRINCE_OPTION_4		= "警报暗言术：痛";
	DBM_PRINCE_OPTION_5		= "警报地狱火";

	DBM_PRINCE_YELL_PULL	= "疯狂将你们带到我的面前，而我将以死亡终结你们！";
	DBM_PRINCE_YELL_P2		= "愚蠢的家伙！时间就是吞噬你躯体的烈焰！";
	DBM_PRINCE_YELL_P3		= "你如何抵挡这无坚不摧的力量？";
	DBM_PRINCE_YELL_INF1	= "所有的世界都向我敞开大门！";
	DBM_PRINCE_YELL_INF2	= "你面对的不仅仅是玛克扎尔，还有我所号令的军团！";
	DBM_PRINCE_SWP			= "([^%s]+)受([^%s]+)暗言术：痛效果的影响";
	DBM_PRINCE_ENFEEBLE		= "([^%s]+)受([^%s]+)能量衰弱效果的影响";
	DBM_PRINCE_CAST_NOVA	= "玛克扎尔王子开始施放暗影新星。";
	DBM_PRINCE_INF_SPAWN	= "地狱火获得了地狱烈焰的效果。";

	DBM_PRINCE_WARN_NOVA		= "*** 暗影新星 - 2秒后施放 ***";
	DBM_PRINCE_WARN_ENFEEBLE	= "*** 能量衰弱 ***";
	DBM_PRINCE_WHISP_ENFEEBLE	= "你的能量被衰弱了！";
	DBM_PRINCE_WARN_SWP			= "*** 暗言术：痛 -> >%s< ***";
	DBM_PRINCE_WARN_INF			= "*** 地狱火#%s ***";
	DBM_PRINCE_WARN_INF_SOON	= "*** 地狱火#%s - 即将出现 ***"
	DBM_PRINCE_WARN_PHASE		= "*** 第%s阶段 ***";

	DBM_SBT["Infernal"]		= "地狱火";
	DBM_SBT["Enfeeble"]		= "能量衰弱";
	DBM_SBT["Shadow Nova"]	= "暗影新星";


-- Nightbane
	DBM_NB_NAME			= "夜之魇";
	DBM_NB_DESCRIPTION	= "警报恐惧、灼烧土地、分神之灰、白骨之雨、烟雾冲击以及空中阶段";
	DBM_NB_OPTION_1		= "当受到灼烧土地效果时显示特殊警报";
	DBM_NB_OPTION_2		= "警报施放于远程杀伤职业和治疗职业的分神之灰";
	DBM_NB_OPTION_3		= "警报白骨之雨";
	DBM_NB_OPTION_4		= "警报烟雾冲击";
	DBM_NB_OPTION_5		= "当夜之魇对你施放烟雾冲击时显示特殊警报";
	DBM_NB_OPTION_ICON	= "对白骨之雨的目标添加标注（骷髅）";

	DBM_NB_EMOTE_PULL	= "一个远古的生物在远处被唤醒了……";
	DBM_NB_YELL_PULL	= "愚蠢的家伙！我会很快终结你们的痛苦！";
	DBM_NB_YELL_AIR		= "可怜的渣滓。我要腾空而起，让你尝尝毁灭的滋味！";
	DBM_NB_YELL_GROUND	= "够了！我要落下来把你们打得粉碎！";
	DBM_NB_YELL_GROUND2	= "没用的虫子！让你们见识一下我的力量吧！";
	DBM_NB_CAST_FEAR	= "夜之魇开始施放低沉咆哮。";
	DBM_NB_EARTH_YOU	= "你受到了灼烧土地效果的影响。";
	DBM_NB_CAST_BONES	= "([^%s]+)受([^%s]+)白骨之雨效果的影响。";
	DBM_NB_CAST_ASH		= "([^%s]+)受([^%s]+)分神之灰效果的影响。";
	DBM_NB_CAST_SMOKE	= "([^%s]+)受([^%s]+)灼热灰烬效果的影响。";
	DBM_NB_DOWN_WARN 	= "*** 15秒后夜之魇着陆 ***";
	DBM_NB_DOWN_WARN2 	= "*** 5秒后夜之魇着陆 ***";

	DBM_NB_FEAR_WARN		= "*** 恐惧 ***";
	DBM_NB_FEAR_SOON_WARN	= "*** 恐惧 - 即将施放 ***";
	DBM_NB_AIR_WARN			= "*** 空中阶段 ***";
	DBM_NB_EARTH_WARN		= "灼烧土地";
	DBM_NB_SMOKE_SPECWARN	= "烟雾冲击";
	DBM_NB_BONES_WARN		= "*** 白骨之雨 ***";
	DBM_NB_ASH_WARN			= "*** 分神之灰 -> >%s< ***";
	DBM_NB_SMOKE_WARN		= "*** 烟雾冲击 -> >%s< ***";	

	DBM_SBT["Nightbane"]	= "夜之魇";
	DBM_SBT["Air Phase"]	= "空中阶段";
	DBM_SBT["Fear"]			= "恐惧";
	DBM_SBT["Next Fear"]	= "下一次恐惧";


-- Wizard of Oz
	DBM_OZ_NAME			= "绿野仙踪";
	DBM_OZ_DESCRIPTION	= "警报敌人的出现";
	DBM_OZ_OPTION_1		= "在第2阶段显示距离框体";

	DBM_OZ_CRONE_NAME		= "巫婆";
	DBM_OZ_YELL_DOROTHEE	= "啊，托托，我们必须找到回家的路！那位老巫师是我们唯一的希望了！稻草人、狮子，还有铁皮人，你们能不能——呀，有人来了！";
	DBM_OZ_YELL_ROAR		= "我不怕你们！你们想打架？那就来呀！来呀！我不用前爪都可以打败你们！";
	DBM_OZ_YELL_STRAWMAN	= "我该把你怎么办？我完全不知道。";
	DBM_OZ_YELL_TINHEAD		= "我真的需要一颗心。啊，用你的行吗？";
	DBM_OZ_YELL_TITO		= "托托，你不会让这些家伙伤害我们的，对吧？";
	DBM_OZ_YELL_CRONE		= "我为你们感到可悲，小家伙们！";
	DBM_OZ_SUMMON_TITO		= "多萝茜开始施放召唤托托。";

	DBM_OZ_WARN_TITO		= "*** 托托 ***";
	DBM_OZ_WARN_ROAR		= "*** 胆小的狮子 ***";
	DBM_OZ_WARN_STRAWMAN	= "*** 稻草人 ***";
	DBM_OZ_WARN_TINHEAD		= "*** 铁皮人 ***";
	DBM_OZ_WARN_CRONE		= "*** 巫婆 ***";

	DBM_SBT["Roar"]		= "胆小的狮子";
	DBM_SBT["Strawman"]	= "稻草人";
	DBM_SBT["Tinhead"]	= "铁皮人";
	DBM_SBT["Tito"]		= "托托";


-- Named Beasts
	DBM_SHAD_NAME			= "滑翔者沙德基斯";
	DBM_HYA_NAME			= "潜伏者希亚其斯";
	DBM_ROKAD_NAME			= "蹂躏者洛卡德";

end