if (GetLocale() == "zhTW") then
--Chinese Translate by Nightkiller@日落沼澤(kc10577@巴哈;Azael)
DBM_TEMPEST_KEEP	= "風暴要塞";


-- Void Reaver
DBM_VOIDREAVER_NAME				= "虛無搶奪者";
DBM_VOIDREAVER_DESCRIPTION			= "提示秘法寶珠及猛擊警告";
DBM_VOIDREAVER_OPTION_WARN_ORB			= "提示秘法寶珠目標";
DBM_VOIDREAVER_OPTION_YELL_ORB			= "當秘法寶珠在你身上時大叫";
DBM_VOIDREAVER_OPTION_ORB_ICON			= "標記秘法寶珠目標";
DBM_VOIDREAVER_OPTION_WARN_POUNDING		= "提示猛擊";
DBM_VOIDREAVER_OPTION_WARN_POUNDINGSOON		= "顯示\"即將發動猛擊\"警告";
DBM_VOIDREAVER_OPTION_SOUND			= "當秘法寶珠在你身上時播放音效"

DBM_VOIDREAVER_POUNDING				= "猛擊";

DBM_VOIDREAVER_WARN_ORB				= "*** 秘法寶珠目標： >%s< ***";
DBM_VOIDREAVER_YELL_ORB				= "秘法寶珠向著我來了!不想死的快閃開!";
DBM_VOIDREAVER_WARN_ENRAGE			= "*** %s %s後狂暴 ***";
DBM_VOIDREAVER_WARN_POUNDING			= "*** 猛擊 ***";
DBM_VOIDREAVER_WARN_POUNDING_SOON		= "*** 即將發動猛擊 ***";
DBM_VOIDREAVER_SPECWARN_ORB			= "秘法寶珠在你身上!";

DBM_VOIDREAVER_R_FURY				= "正義之怒"

DBM_SBT["Enrage"] 				= "狂怒";
DBM_SBT["Pounding"]				= "猛擊";
DBM_SBT["Next Pounding"]			= "下一次猛擊";

-- Solarian
DBM_SOLARIAN_NAME				= "高階星術師索拉瑞恩";
DBM_SOLARIAN_DESCRIPTION			= "提示星術師之怒及小怪出現";
DBM_SOLARIAN_OPTION_WARN_WRATH			= "提示星術師之怒";
DBM_SOLARIAN_OPTION_ICON_WRATH			= "標記中了星術師之怒的人";
DBM_SOLARIAN_OPTION_SPECWARN_WRATH		= "顯示特別警告當你中了星術師之怒";
DBM_SOLARIAN_OPTION_WARN_PHASE			= "提示小怪出現";
DBM_SOLARIAN_OPTION_WHISPER_WRATH		= "發送密語給中了星術師之怒的人"
DBM_SOLARIAN_OPTION_SOUND			= "當你中了星術師之怒時播放音效"

DBM_SOLARIAN_DEBUFF_WRATH			= "(.+)受到(.*)星術師之怒效果的影響。"
DBM_SOLARIAN_CAST_SPLIT				= "高階星術師索拉瑞恩施放了星術師分身。";
DBM_SOLARIAN_YELL_ENRAGE			= "夠了!現在我要呼喚宇宙中失衡的能量。"

DBM_SOLARIAN_SPECWARN_WRATH			= "你中了星術師之怒!快跑離人群!!";
DBM_SOLARIAN_ANNOUNCE_WRATH			= "*** 星術師之怒: >%s< ***";
DBM_SOLARIAN_ANNOUNCE_SPLIT			= "*** 分裂! 5秒後 密探 ***";
DBM_SOLARIAN_ANNOUNCE_PRIESTS_SOON		= "*** 5秒後 牧師和索拉瑞恩 ***";
DBM_SOLARIAN_ANNOUNCE_PRIESTS_NOW		= "*** 牧師和索拉瑞恩 出現了 ***";
DBM_SOLARIAN_ANNOUNCE_AGENTS_NOW		= "*** 密探 出現了 ***";
DBM_SOLARIAN_ANNOUNCE_SPLIT_SOON		= "*** 5秒後 分裂 ***";
DBM_SOLARIAN_ANNOUNCE_ENRAGE_PHASE		= "*** 虛空行者階段 ***";

DBM_SBT["Split"] 				= "分裂";
DBM_SBT["Priests & Solarian"] 			= "牧師和索拉瑞恩";
DBM_SBT["Agents"] 				= "密探";
DBM_SBT["Solarian"] = {
	[1] = {"Wrath: (.*)","星術師之怒: %1"},
};


-- Al'ar
DBM_ALAR_NAME					= "歐爾";
DBM_ALAR_DESCRIPTION				= "為歐爾顯示計時和警告.";
DBM_ALAR_OPTION_MELTARMOR			= "提示熔化護甲";
DBM_ALAR_OPTION_METEOR				= "提示隕石";

DBM_ALAR_CAST_REBIRTH				= "歐爾開始施放復生。";
DBM_ALAR_DEBUFF_MELTARMOR			= "(.+)受到(.*)熔化護甲效果的影響。";
DBM_ALAR_DEBUFF_FIRE_YOU			= "你受到了烈焰助長效果的影響。";
DBM_ALAR_FLAME_BUFFET				= "烈焰打擊";

DBM_ALAR_WARN_MELTARMOR				= "*** 熔化護甲: >%s< ***";
DBM_ALAR_WARN_REBIRTH				= "*** 復生! - 47秒後隕石 ***";
DBM_ALAR_WARN_FIRE				= "烈焰助長";
DBM_ALAR_WARN_ADD				= "*** 下一個平台 - 歐爾餘燼即將出現 ***";
DBM_ALAR_WARN_METEOR				= "*** 隕石術! ***";
DBM_ALAR_WARN_METEOR_SOON			= "*** 隕石術即將到來! ***";
DBM_ALAR_WARN_ENRAGE				= "*** %s %s後狂暴 ***";

DBM_SBT["Enrage"] 				= "狂怒";
DBM_SBT["Next Platform"] 			= "下一個平台";
DBM_SBT["Meteor"] 				= "隕石術";
DBM_SBT["Alar"] = {
	{"Melt Armor: (.*)","熔化護甲: %1"},
};

-- Kael'thas
DBM_KAEL_NAME					= "凱爾薩斯·逐日者";
DBM_KAEL_DESCRIPTION				= "顯示凱爾薩斯戰鬥各種事件計時";

DBM_KAEL_OPTION_PHASE				= "提示階段";
DBM_KAEL_OPTION_ICON_P1				= "標記薩拉瑞德注視的目標";
DBM_KAEL_OPTION_WHISPER_P1			= "發送密語給薩拉瑞德的目標";
DBM_KAEL_OPTION_RANGECHECK			= "顯示距離框";
DBM_KAEL_OPTION_CONFLAG				= "提示燃燒";
DBM_KAEL_OPTION_CONFLAG2			= "提示第三階段的燃燒";
DBM_KAEL_OPTION_CONFLAGTIMER2			= "顯示第三階段的燃燒計時";
DBM_KAEL_OPTION_FEAR				= "提示恐懼";
DBM_KAEL_OPTION_FEARSOON			= "顯示\"即將恐懼\"警告";
DBM_KAEL_OPTION_TOY				= "提示遙控玩具在第一階段";
DBM_KAEL_OPTION_FRAME				= "顯示武器的血量";
DBM_KAEL_OPTION_ADDFRAME			= "顯示顧問的血量";
DBM_KAEL_OPTION_PYRO				= "提示炎爆術";
DBM_KAEL_OPTION_BARRIER				= "提示震擊屏障";
DBM_KAEL_OPTION_BARRIER2			= "提示第五階段的震擊屏障";
DBM_KAEL_OPTION_PHOENIX				= "提示鳳凰出現";
DBM_KAEL_OPTION_WARNMC				= "提示精神控制";
DBM_KAEL_OPTION_ICONMC				= "標記中了精神控制的人";
DBM_KAEL_OPTION_GRAVITY				= "提示重力流逝";

DBM_KAEL_YELL_PHASE1				= "能量。力量。我的人民陷入其中不能自拔……自從太陽之井被摧毀之後就顯得更加明顯。歡迎來到未來。真遺憾，你們無法阻止什麼。沒有人可以阻止我了﹗(薩拉斯語)為了人民的正義!";
DBM_KAEL_EMOTE_THALADRED_TARGET			= "凝視著(.+)!";
DBM_KAEL_YELL_PHASE1_SANGUINAR			= "你已經努力的打敗了我的幾位最忠誠的諫言者…但是沒有人可以抵抗血錘的力量。等著看桑古納爾的力量吧!";
DBM_KAEL_YELL_PHASE1_CAPERNIAN			= "卡普尼恩將保證你們不會在這裡停留太久。";
DBM_KAEL_YELL_PHASE1_TELONICUS			= "做得好，你已經證明你的實力足以挑戰我的工程大師泰隆尼卡斯。";
DBM_KAEL_CAST_FEAR				= "桑古納爾領主開始施放低沉咆哮。";
DBM_KAEL_DEBUFF_FEAR1				= "受到低沉咆哮";
DBM_KAEL_DEBUFF_FEAR2				= "桑古納爾領主的低沉咆哮";
DBM_KAEL_DEBUFF_CONFLAGRATION			= "(.+)受到(.*)燃燒效果的影響。";
DBM_KAEL_DEBUFF_REMOTETOY			= "(.+)受到(.*)遙控玩具效果的影響。";
DBM_KAEL_YELL_THALA_DOWN			= "原諒我，我的王子!我...失敗了。";
DBM_KAEL_YELL_CAPERNIAN_DOWN			= "事情還沒結束!";

DBM_KAEL_YELL_PHASE2				= "你們看，我的個人收藏中有許多武器……";
DBM_KAEL_YELL_PHASE3				= "也許我低估了你。要你一次對付四位諫言者也許對你來說是不太公平，但是……我的人民從未得到公平的對待。我只是以牙還牙而已。";
DBM_KAEL_YELL_PHASE4				= "唉，有些時候，有些事情，必須得親自解決才行。(薩拉斯語)受死吧!";
DBM_KAEL_YELL_PHASE5				= "我的心血是不會被你們輕易浪費的!我精心謀劃的未來是不會被你們輕易破壞的!感受我真正的力量吧!";

DBM_KAEL_WEAPONS = {
	["瓦解之杖"] = 1,
	["無盡之刃"] = 2,
	["宇宙灌溉者"] = 3,
	["扭曲分割者"] = 4,
	["毀滅"] = 5,
	["虛空之絃長弓"] = 6,
	["相位壁壘"] = 7
};
DBM_KAEL_WEAPONS_NAMES = {
	"法杖",
	"匕首",
	"錘",
	"劍",
	"斧",
	"弓",
	"盾"
};


DBM_KAEL_ADVISORS = {
	["扭曲預言家薩拉瑞德"] = 1,
	["桑古納爾領主"] = 2,
	["大星術師卡普尼恩"] = 3,
	["工程大師泰隆尼卡斯"] = 4,
};

DBM_KAEL_ADVISORS_NAMES = {
	"薩拉瑞德",
	"桑古納爾",
	"卡普尼恩",
	"泰隆尼卡斯"
};

DBM_KAEL_INFOFRAME_TITLE			= "武器";
DBM_KAEL_INFOFRAME_ADDS_TITLE			= "顧問";

DBM_KAEL_CAST_PHOENIX_REBIRTH			= "鳳凰開始施放復生。";
DBM_KAEL_EMOTE_PYROBLAST			= "凱爾薩斯·逐日者開始施放炎爆術!";
DBM_KAEL_CAST_PYROBLAST				= "凱爾薩斯·逐日者開始施放炎爆術。";
DBM_KAEL_GAIN_SHOCK_BARRIER			= "凱爾薩斯·逐日者獲得了震擊屏障的效果。";
DBM_KAEL_FADE_SHOCK_BARRIER			= "震擊屏障效果從凱爾薩斯·逐日者身上消失。";
DBM_KAEL_CAST_PHOENIX				= "凱爾薩斯·逐日者施放了鳳凰。";
DBM_KAEL_DEBUFF_MINDCONTROL			= "(.+)受到(.*)精神控制效果的影響。";
DBM_KAEL_FADE_MINDCONTROL			= "(.+)的精神控制";
DBM_KAEL_FADE_MINDCONTROL_YOU			= "你的精神控制";
DBM_KAEL_EGG					= "鳳凰蛋";
DBM_KAEL_YELL_GRAVITY_LAPSE			= "站不住腳了嗎?";
DBM_KAEL_YELL_GRAVITY_LAPSE2			= "如果世界變得上下顛倒，你們會怎麼辦呢?";


DBM_KAEL_SPECWARN_THALADRED_TARGET		= "快跑！";
DBM_KAEL_WARN_THALADRED_TARGET			= "*** 薩拉瑞德正凝視著 >%s< ***";
DBM_KAEL_WHISPER_THALADRED_TARGET		= "薩拉瑞德正在注視你！快逃！";
DBM_KAEL_WARN_INC				= "*** %s 即將來臨 ***";
DBM_KAEL_SANGUINAR				= "桑古納爾";
DBM_KAEL_CAPERNIAN				= "卡普尼恩";
DBM_KAEL_TELONICUS				= "泰隆尼卡斯";
DBM_KAEL_WARN_FEAR				= "*** 1.5秒後發動恐懼 ***";
DBM_KAEL_WARN_FEAR_SOON				= "*** 即將發動恐懼 ***";
DBM_KAEL_WARN_CONFLAGRATION			= "*** 燃燒: >%s< ***";
DBM_KAEL_WARN_REMOTETOY				= "*** 遙控玩具: >%s< ***";

DBM_KAEL_WARN_PHASE1				= "*** 第一階段 - 薩拉瑞德 ***";
DBM_KAEL_WARN_PHASE2				= "*** 第二階段 - 武器 ***";
DBM_KAEL_WARN_PHASE3				= "*** 第三階段 - 顧問重生 ***";
DBM_KAEL_WARN_PHASE4				= "*** 第四階段 - 凱爾薩斯 ***";
DBM_KAEL_WARN_PHASE5				= "*** 第五階段 ***";

DBM_KAEL_WARN_PYRO				= "*** 炎爆術 ***";
DBM_KAEL_WARN_BARRIER_SOON			= "*** 5秒後 震擊屏障 ***";
DBM_KAEL_WARN_BARRIER_NOW			= "*** 震擊屏障 ***";
DBM_KAEL_WARN_BARRIER_DOWN			= "*** 屏障消失! ***";
DBM_KAEL_WARN_PHOENIX				= "*** 鳳凰出現 ***";
DBM_KAEL_WARN_MC_TARGETS			= "*** 精神控制: %s ***";
DBM_KAEL_WARN_REBIRTH				= "*** 鳳凰倒下 - 卵出現 ***";
DBM_KAEL_WARN_GRAVITY_LAPSE			= "*** 重力流逝 ***";
DBM_KAEL_GRAVITY_SOON				= "*** 即將發動重力流逝 ***";
DBM_KAEL_GRAVITY_END_SOON			= "*** 重力流逝將於5秒後結束 ***";

DBM_SBT["Thaladred"] 				= "薩拉瑞德";
DBM_SBT["Lord Sanguinar"] 			= "桑古納爾";
DBM_SBT["Capernian"] 				= "卡普尼恩";
DBM_SBT["Telonicus"] 				= "泰隆尼卡斯";
DBM_SBT["Next Gravity Lapse"] 			= "下一次重力流逝";
DBM_SBT["Gravity Lapse"] 			= "重力流逝";
DBM_SBT["Next Shock Barrier"] 			= "下一次震擊屏障";
DBM_SBT["Shock Barrier"] 			= "震擊屏障";
DBM_SBT["Phoenix"] 				= "鳳凰";
DBM_SBT["Next Fear"] 				= "下一次恐懼";
DBM_SBT["Fear"] 				= "恐懼";
DBM_SBT["Pyroblast"] 				= "炎爆術";
DBM_SBT["Rebirth"] 				= "復生";
DBM_SBT["Phase 3"] 				= "第三階段";
DBM_SBT["Phase 4"] 				= "第四階段";
DBM_SBT["Gaze Cooldown"] 				= "凝視冷卻";
DBM_SBT["KaelThas"] = {
	{"Conflagration: (.*)","燃燒: %1"},
	{"Remote Toy: (.*)","遙控玩具: %1"},
};

end