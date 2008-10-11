-- ------------------------------------------- --
--   Deadly Boss Mods - Chinese localization   --
--    by Diablohu<白银之手> @ 二区-轻风之语    --
--              www.dreamgen.cn                --
--                 1/5/2008                    --
-- ------------------------------------------- --

if (GetLocale() == "zhCN") then

	DBM_HYJAL_TAB		= "HyjalTab"
	DBM_MOUNT_HYJAL		= "海加尔峰";

-- Rage Winterchill
	DBM_RAGE_NAME							= "雷基·冬寒";
	DBM_RAGE_DESCRIPTION					= "警报寒冰箭和死亡凋零";

	DBM_RAGE_OPTION_ICEBOLT					= "警报寒冰箭";
	DBM_RAGE_OPTION_DND						= "警报死亡凋零";
	DBM_RAGE_OPTION_ICON					= "对寒冰箭的目标添加标记";
	DBM_RAGE_OPTION_DND_SOON				= "显示“死亡凋零 - 即将施放”警报";

	DBM_RAGE_YELL_PULL						= "燃烧军团的最终战役开始了！这个世界再一次任凭我们宰割。不要留任何活口!";

	DBM_RAGE_DEBUFF_ICEBOLT					= "([^%s]+)受([^%s]+)寒冰箭效果的影响。";
	DBM_RAGE_SPELL_DEATH_DECAY				= "死亡凋零";
	DBM_RAGE_CAST_DEATH_DECAY				= "雷基·冬寒开始施放死亡凋零。";
	DBM_RAGE_DEBUFF_DND_YOU					= "你受到了死亡凋零效果的影响。"

	DBM_RAGE_WARN_ICEBOLT					= "*** 寒冰箭 -> >%s< ***";
	DBM_RAGE_WARN_DND						= "*** 死亡凋零 ***";
	DBM_RAGE_WARN_DND_END					= "*** 死亡凋零 - 效果消失 ***";
	DBM_RAGE_WARN_DND_SOON					= "*** 死亡凋零 - 即将施放 ***";
	DBM_RAGE_SPECWARN_DND_YOU				= "死亡凋零！快跑开！";

	DBM_SBT["Death & Decay"]		= "死亡凋零";
	DBM_SBT["Next Death & Decay"]	= "下一次死亡凋零";


-- Anetheron
	DBM_ANETHERON_NAME						= "安纳塞隆";
	DBM_ANETHERON_DESCRIPTION				= "警报地狱火和腐臭虫群";
	DBM_ANEETHERON_OPTION_CARRION			= "警报腐臭虫群";
	DBM_ANEETHERON_OPTION_INFERNAL			= "警报地狱火";

	DBM_ANETHERON_YELL_PULL					= "你们在保卫一个注定要毁灭的世界！逃走吧，那样也许你们还能多活几天！";

	DBM_ANETHERON_INFERNO					= "地狱火";
	DBM_ANETHERON_CARRION_SWARM				= "腐臭虫群";
	DBM_ANETHERON_CAST_INFERNO				= "安纳塞隆开始施展地狱火。";

	DBM_ANETHERON_WARN_CARRION				= "*** 腐臭虫群 ***";
	DBM_ANETHERON_WARN_INFERNO				= "*** 地狱火 -> >%s< ***";
	DBM_ANETHERON_WARN_INFERNO_SOON			= "*** 地狱火 - 即将施放 ***";

	DBM_SBT["Infernal"]	= "地狱火";


-- Kaz'rogal
	DBM_KAZROGAL_NAME						= "卡兹洛加";
	DBM_KAZROGAL_DESCRIPTION				= "警报卡兹洛加印记";

	DBM_KAZROGAL_YELL_PULL					= "哭喊着求饶吧！你们毫无意义的生命就要结束了！";
	DBM_KAZROGAL_DEBUFF_MARK				= "受到了卡兹洛加印记效果的影响";

	DBM_KAZROGAL_WARN_MARK					= "*** 印记 #%s ***";


-- Azgalor
	DBM_AZGALOR_NAME						= "阿兹加洛";
	DBM_AZGALOR_DESCRIPTION					= "警报厄运和沉默";
	DBM_AZGALOR_OPTION_SILENCE				= "警报沉默";
	DBM_AZGALOR_OPTION_ICON					= "对厄运的目标添加标记";

	DBM_AZGALOR_YELL_PULL					= "放弃所有希望吧！燃烧军团要完成这许多年前就注定的使命。这一次，一切都无可挽回了!";

	DBM_AZGALOR_DEBUFF_DOOM					= "([^%s]+)受([^%s]+)厄运效果的影响。";
	DBM_AZGALOR_DEBUFF_SILENCE				= "受到了阿兹加洛之嚎效果的影响";

	DBM_AZGALOR_SPECWARN_DOOM_YOU			= "厄运!";
	DBM_AZGALOR_WARN_DOOM					= "*** 厄运 -> >%s< ***";
	DBM_AZGALOR_WARN_SILENCE				= "*** 沉默 ***";
	DBM_AZGALOR_WARN_SILENCESOON			= "*** 沉默 - 即将施放 ***";

	DBM_SBT["Silence"]	= "沉默";
	
	DBM_SBT["Azgalor"] = {
		  [1] = {"Doom: (.*)", "厄运 -> %1"},
	}
	DBM_SBT["阿兹加洛"] = DBM_SBT["Azgalor"]


-- Archimonde
	DBM_ARCHIMONDE_NAME						= "阿克蒙德";
	DBM_ARCHIMONDE_DESCRIPTION				= "警报军团之握、恐惧、激怒和空气爆裂";
	DBM_ARCHIMONDE_OPTION_GRIP				= "警报军团之握"
	DBM_ARCHIMONDE_OPTION_BURST				= "警报空气爆裂"
	DBM_ARCHIMONDE_OPTION_BURSTICON			= "对空气爆裂的目标添加标记"
	DBM_ARCHIMONDE_OPTION_BURSTSAY			= "当你收到空气爆裂效果时喊话"
	DBM_ARCHIMONDE_OPTION_BURSTSPECWARN		= "当你受到空气爆裂效果时显示特殊警报"

	DBM_ARCHIMONDE_YELL_PULL				= "放弃毫无意义的反抗吧。";

	DBM_ARCHIMONDE_DEBUFF_GRIP				= "([^%s]+)受([^%s]+)军团之握效果的影响。";
	DBM_ARCHIMONDE_CAST_FEAR				= "阿克蒙德开始施放恐惧。"
	DBM_ARCHIMONDE_CAST_BURST				= "阿克蒙德开始施放空气爆裂。"

	DBM_ARCHIMONDE_WARN_GRIP				= "*** 军团之握 -> >%s< ****"
	DBM_ARCHIMONDE_WARN_ENRAGE				= "*** %s%s后激怒 ***";
	DBM_ARCHIMONDE_WARN_FEAR				= "*** 恐惧 ***";
	DBM_ARCHIMONDE_WARN_FEARSOON			= "*** 恐惧 - 即将施放 ***";
	DBM_ARCHIMONDE_WARN_BURST				= "*** 空气爆裂 -> >%s< ***";
	DBM_ARCHIMONDE_WARN_BURST_ME			= "空气爆裂要来了！";
	DBM_ARCHIMONDE_SPECWARN_BURST			= "空气爆裂！";

	DBM_SBT["Enrage"]	= "激怒";
	DBM_SBT["Fear"]		= "恐惧";


-- MHTrash
	DBM_MHT_NAME					= "普通怪物"
	DBM_MHT_DESCRIPTION				= "显示敌人到来的倒计时"
	DBM_MHT_DESCRIPTION1			= "警报即将到来的敌人的种类"
	DBM_MHT_DESCRIPTION2			= "警报食尸鬼的食尸";
	DBM_MHT_OPTION_WAVE				= "警报即将到来的敌人"

	DBM_MHT_GHOUL_CHECK				= "食尸鬼获得了食尸的效果。";
	DBM_MHT_WARN_GHOUL				= "食尸鬼正在吞食尸体"
	DBM_MHT_WAVE_CHECK				= "当前波次：(%d+)/8"
	DBM_MHT_WAVE_SOON				= "下一波敌人即将到来"
	DBM_MHT_WAVE_NOW				= "敌人来了！"
	DBM_MHT_BOSS_SOON				= "首领即将到来"
	DBM_MHT_BOSS_NOW				= "首领来了！"

	DBM_MHT_THRALL					= "萨尔"
	DBM_MHT_JAINA					= "吉安娜·普罗德摩尔" 
	DBM_MHT_THRALL_DIES				= "萨尔死亡了。"
	DBM_MHT_JAINA_DIES				= "吉安娜·普罗德摩尔死亡了。"
	DBM_MHT_RAGE_MSG				= "我和我的伙伴们将与您并肩作战，普罗德摩尔女士。"
	DBM_MHT_ANETHERON_MSG			= "我们已经准备好对付阿克蒙德的任何爪牙了，普罗德摩尔女士。"
	DBM_MHT_KAZROGAL_MSG			= "我与你并肩作战，萨尔。"
	DBM_MHT_AZGALOR_MSG				= "我们无所畏惧。"
	DBM_MHT_BOSS_DIES				= "([^%s]+)死亡了。";

	DBM_MHT_WAVE_INC_WARNING1			= "*** 第%s/8波 - %s%s  ***";
	DBM_MHT_WAVE_INC_WARNING2			= "*** 第%s/8波 - %s%s 和 %s%s ***";
	DBM_MHT_WAVE_INC_WARNING3			= "*** 第%s/8波 - %s%s, %s%s 和 %s%s ***";
	DBM_MHT_WAVE_INC_WARNING4			= "*** 第%s/8波 - %s%s, %s%s, %s%s 和 %s%s ***";
	DBM_MHT_WAVE_INC_WARNING5			= "*** 第%s/8波 - %s%s, %s%s, %s%s, %s%s 和 %s%s ***";

	DBM_MHT_GHOUL					= "食尸鬼"
	DBM_MHT_ABOMINATION				= "憎恶"
	DBM_MHT_NECROMANCER				= "亡灵巫师"
	DBM_MHT_BANSHEE					= "女妖"
	DBM_MHT_FIEND					= "地穴恶魔"
	DBM_MHT_GARGOYLE				= "石像鬼"
	DBM_MHT_WYRM					= "冰霜巨龙"
	DBM_MHT_STALKER					= "恶魔猎犬"
	DBM_MHT_INFERNAL				= "地狱火"
	DBM_MHT_ARCHIMONDE				= "祝你好运";

	DBM_SBT["Next Wave"]	= "下一波敌人";

end