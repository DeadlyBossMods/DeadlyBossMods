-- ------------------------------------------- --
--   Deadly Boss Mods - Chinese localization   --
--    by Diablohu<白银之手> @ 二区-轻风之语    --
--              www.dreamgen.cn                --
--                  3/28/2008                  --
-- ------------------------------------------- --

if (GetLocale() == "zhCN") then

	DBM_ZULAMAN		= "祖阿曼"
	DBM_ZULAMAN_TAB	= "DBM_ZULAMAN_TAB";

-- Nalorakk
	DBM_NALO_NAME					= "纳洛拉克"
	DBM_NALO_DESCRIPTION			= "警报形态转换和沉默"
	DBM_NALO_OPTION_PHASEPRE		= "显示形态切换5秒警报"
	DBM_NALO_OPTION_SILENCE			= "警报沉默"

	DBM_NALO_YELL_PULL				= "你马上就要死了！"
	DBM_NALO_YELL_BEAR				= "你们召唤野兽？你马上就要大大的后悔了！"
	DBM_NALO_YELL_NORMAL			= "纳洛拉克，变形，出发！"
	DBM_NALO_DEBUFF_SILENCE			= "受到了震耳咆哮效果的影响"
	DBM_NALO_SPELLID_SILENCE		= 42398
	
	DBM_NALO_WARN_NORMAL_SOON		= "5秒后变为人形态"
	DBM_NALO_WARN_BEAR_SOON			= "5秒后变为熊形态"
	DBM_NALO_WARN_NORMAL			= "人形态"
	DBM_NALO_WARN_BEAR				= "熊形态"
	DBM_NALO_WARN_SILENCE			= "沉默"

	DBM_SBT["Bear Form"]	= "熊形态";
	DBM_SBT["Normal Form"]	= "人形态";


-- Akil'zon
	DBM_AKIL_NAME					= "埃基尔松"
	DBM_AKIL_DESCRIPTION			= "警报电能风暴并在小地图上添加标记"
	DBM_AKIL_OPTION_RANGE			= "显示距离框体"

	DBM_AKIL_YELL_PULL				= "我是猎鹰，而你们，就是猎物！"
	DBM_AKIL_DEBUFF_STORM			= "([^%s]+)受([^%s]+)电能风暴效果的影响。"
	DBM_AKIL_SPELLID_STORM			= 43648

	DBM_AKIL_WARN_STORM_SOON		= "电能风暴 - 即将施放"
	DBM_AKIL_WARN_STORM_ON			= "电能风暴 -> >%s<"

	DBM_SBT["Enrage"]			= "激怒";
	DBM_SBT["Electrical Storm"]	= "电能风暴";


-- Jan'alai
	DBM_JANALAI_NAME				= "加亚莱"
	DBM_JANALAI_DESCRIPTION			= "警报传送和孵化"

	DBM_JANALAI_YELL_PULL			= "风之圣魂将是你的梦魇！"
	DBM_JANALAI_YELL_EXPLOSION		= "烧死你们！"
	DBM_JANALAI_YELL_HATCHER		= "雌鹰哪里去了？快去孵蛋！"

	DBM_JANALAI_WARN_EXPLOSION		= "传送"
	DBM_JANALAI_WARN_EXPLOSION_INC	= "1秒后爆炸"
	DBM_JANALAI_WARN_HATCHER		= "孵化者出现"
	DBM_JANALAI_WARN_HATCHER_SOON	= "孵化者10秒后出现"

	DBM_SBT["Enrage"]		= "激怒";
	DBM_SBT["Hatcher"]		= "孵化者";
	DBM_SBT["Explosion"]	= "爆炸";


-- Halazzi
	DBM_HALAZZI_NAME				= "哈尔拉兹"
	DBM_HALAZZI_DESCRIPTION			= "警报阶段变化、图腾和狂乱"
	DBM_HALAZZI_OPTION_FRENZY		= "警报狂乱"
	DBM_HALAZZI_OPTION_TOTEM		= "警报闪电图腾"

	DBM_HALAZZI_YELL_PULL			= "在利爪与尖牙面前，下跪吧，祈祷吧，颤栗吧！"
	DBM_HALAZZI_YELL_SPIRIT			= "狂野的灵魂与我同在……"
	DBM_HALAZZI_YELL_SPIRIT_DESP	= "灵魂，到我这里来！"
	DBM_HALAZZI_CAST_TOTEM			= "哈尔拉兹开始施放闪电图腾。" -- 2 spaces? wtf?
	DBM_HALAZZI_GAIN_FRENZY			= "哈尔拉兹获得了狂乱的效果。"
	DBM_HALAZZI_SPELLID_TOTEM		= 43302

	DBM_HALAZZI_WARN_SPIRIT			= "灵魂分裂"
	DBM_HALAZZI_WARN_SPIRIT_DESP	= "灵魂消失"
	DBM_HALAZZI_WARN_TOTEM			= "闪电图腾"
	DBM_HALAZZI_WARN_FRENZY			= "狂乱 - 宁神射击" -- tranq shot...wtf....


-- Malacrass
	DBM_MALACRASS_NAME				= "妖术领主玛拉卡斯"
	DBM_MALACRASS_DESCRIPTION		= "警报灵魂虹吸和灵魂之箭"

	DBM_MALACRASS_OPTION_MC			= "警报精神控制"

	DBM_MALACRASS_YELL_PULL			= "阴影将会降临在你们头上……"
	DBM_MALACRASS_DEBUFF_SIPHON		= "([^%s]+)受([^%s]+)灵魂虹吸效果的影响。"
	DBM_MALACRASS_YELL_BOLTS		= "你的灵魂在流血！"
	DBM_MALACRASS_SPELLID_SIPHON	= 43501

	DBM_MALACRASS_WARN_SIPHON		= "灵魂虹吸 -> >%s<"
	DBM_MALACRASS_WARN_MC			= "精神控制 -> >%s<"
	DBM_MALACRASS_WARN_BOLTS		= "灵魂之箭"
	DBM_MALACRASS_WARN_BOLTS_SOON	= "灵魂之箭 - 5秒后施放"
	
	DBM_SBT["Next Spirit Bolts"]	= "下一次灵魂之箭";
	DBM_SBT["Spirit Bolts"]			= "灵魂之箭";

	DBM_SBT["Malacrass"] = {
		  [1] = {"Siphon Soul: (.*)", "灵魂虹吸 -> %1"},
	}
	DBM_SBT["妖术领主玛拉卡斯"] = DBM_SBT["Malacrass"]


-- Zul'jin
	DBM_ZULJIN_NAME					= "祖尔金"
	DBM_ZULJIN_DESCRIPTION			= "警报阶段变化、重伤投掷、麻痹蔓延和利爪之怒"

	DBM_ZULJIN_OPTION_PARA			= "警报麻痹蔓延"
	DBM_ZULJIN_OPTION_LYNX			= "警报利爪之怒"

	DBM_ZULJIN_YELL_PULL			= "我最厉害！"
	DBN_ZULJIN_YELL_PHASE_2			= "你看我有许多新招，变个熊……"
	DBM_ZULJIN_YELL_PHASE_3			= "变成猎鹰，谁也别想逃出我的眼睛！"
	DBM_ZULJIN_YELL_PHASE_4			= "现在来让你看看我的尖牙和利爪！"
	DBM_ZULJIN_YELL_PHASE_5			= "龙鹰，不用抬头就能看见！"

	DBM_ZULJIN_DEBUFF_PARALYSIS		= "受到了麻痹蔓延"
	DBM_ZULJIN_DEBUFF_LYNX			= "([^%s]+)受([^%s]+)利爪之怒效果的影响。"
	DBM_ZULJIN_DEBUFF_DOT			= "([^%s]+)受([^%s]+)重伤投掷效果的影响。"
	DBM_ZULJIN_SPELLID_PARALYSIS	= 43095
	DBM_ZULJIN_SPELLID_LYNX			= 43150
	DBM_ZULJIN_SPELLID_DOT			= 43093

	DBM_ZULJIN_WARN_PHASE_1			= "第一阶段 - 巨魔形态"
	DBM_ZULJIN_WARN_PHASE_2			= "第二阶段 - 野熊形态"
	DBM_ZULJIN_WARN_PHASE_3			= "第三阶段 - 雄鹰形态"
	DBM_ZULJIN_WARN_PHASE_4			= "第四阶段 - 山猫形态"
	DBM_ZULJIN_WARN_PHASE_5			= "第五阶段 - 龙鹰形态"

	DBM_ZULJIN_WARN_PARALYSIS		= "麻痹蔓延"
	DBM_ZULJIN_WARN_PARALYSIS_SOON	= "麻痹蔓延 - 即将施放"
	DBM_ZULJIN_WARN_LYNX			= "利爪之怒 -> >%s<"
	DBM_ZULJIN_WARN_DOT				= "重伤投掷 -> >%s<"

	DBM_SBT["Creeping Paralysis"]	= "麻痹蔓延";

end