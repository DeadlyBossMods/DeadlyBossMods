if (GetLocale() == "zhTW") then
--Chinese Translate by Nightkiller@日落沼澤(kc10577@巴哈;Azael)
DBM_HYJAL_TAB		= "HyjalTab"
DBM_MOUNT_HYJAL		= "海加爾山";

-- Rage Winterchill
DBM_RAGE_NAME						= "瑞齊·凜冬";
DBM_RAGE_DESCRIPTION					= "提示冰箭和死亡凋零.";

DBM_RAGE_OPTION_ICEBOLT					= "提示冰箭";
DBM_RAGE_OPTION_DND					= "提示死亡凋零";
DBM_RAGE_OPTION_ICON					= "標記冰箭目標";
DBM_RAGE_OPTION_DND_SOON				= "顯示\"即將發動死亡凋零\"警告";

DBM_RAGE_YELL_PULL					= "燃燒軍團最後的征戰已經開始了!世界的掌控權再次落入我們手中。無人可以倖免!";

DBM_RAGE_DEBUFF_ICEBOLT					= "(.+)受到(.*)寒冰箭效果的影響。";
DBM_RAGE_SPELL_DEATH_DECAY				= "死亡凋零";
DBM_RAGE_CAST_DEATH_DECAY				= "瑞齊·凜冬開始施放死亡凋零。";
DBM_RAGE_DEBUFF_DND_YOU					= "你受到了死亡凋零效果的影響。"

DBM_RAGE_WARN_ICEBOLT					= "*** 冰箭: >%s< ***";
DBM_RAGE_WARN_DND					= "*** 死亡凋零 ***";
DBM_RAGE_WARN_DND_END					= "*** 死亡凋零結束 ***";
DBM_RAGE_WARN_DND_SOON					= "*** 即將發動死亡凋零 ***";
DBM_RAGE_SPECWARN_DND_YOU				= "死亡凋零在你身上! 走吧!";

DBM_SBT["Next Death & Decay"] 				= "下一次死亡凋零";
DBM_SBT["Death & Decay"] 				= "死亡凋零";

-- Anetheron
DBM_ANETHERON_NAME					= "安納塞隆";
DBM_ANETHERON_DESCRIPTION				= "提示地獄火和腐肉成群.";
DBM_ANEETHERON_OPTION_CARRION				= "提示腐肉成群";
DBM_ANEETHERON_OPTION_INFERNAL				= "提示地獄火";

DBM_ANETHERON_YELL_PULL					= "你們要守護的世界躲不了毀滅的命運!逃離這兒，也許可以延長你們那可悲的生命!";

DBM_ANETHERON_INFERNO					= "地獄火";
DBM_ANETHERON_CARRION_SWARM				= "腐肉成群";
DBM_ANETHERON_CAST_INFERNO				= "安納塞隆開始施展地獄火。";

DBM_ANETHERON_WARN_CARRION				= "*** 腐肉成群 ***";
DBM_ANETHERON_WARN_INFERNO				= "*** 地獄火: >%s< ***";
DBM_ANETHERON_WARN_INFERNO_SOON				= "*** 地獄火即將到來 ***";

DBM_SBT["Carrion Swarm"] 				= "腐肉成群";
DBM_SBT["Infernal"] 					= "地獄火";

-- Kaz'rogal
DBM_KAZROGAL_NAME					= "卡茲洛加";
DBM_KAZROGAL_DESCRIPTION				= "提示卡茲洛加的印記.";

DBM_KAZROGAL_YELL_PULL					= "哭著乞求憐憫吧!不久之後你們將喪失無意義的生命!";
DBM_KAZROGAL_DEBUFF_MARK				= "受到卡茲洛加的印記";

DBM_KAZROGAL_WARN_MARK					= "*** 卡茲洛加的印記 #%s ***";

-- Azgalor
DBM_AZGALOR_NAME					= "亞茲加洛";
DBM_AZGALOR_DESCRIPTION					= "提示災厄降臨和沉默.";
DBM_AZGALOR_OPTION_SILENCE				= "提示沉默";
DBM_AZGALOR_OPTION_ICON					= "標記中了災厄降臨的目標";

DBM_AZGALOR_YELL_PULL					= "放棄希望吧!燃燒軍團已經捲土重來，誓言要完成多年前開始的毀滅計畫。這次，沒有人能活著離開!";

DBM_AZGALOR_DEBUFF_DOOM					= "(.+)受到(.*)災厄降臨效果的影響。";
DBM_AZGALOR_DEBUFF_SILENCE				= "受到亞茲加洛之吼";

DBM_AZGALOR_SPECWARN_DOOM_YOU				= "災厄降臨!";
DBM_AZGALOR_WARN_DOOM					= "*** 災厄降臨: >%s< ***";
DBM_AZGALOR_WARN_SILENCE				= "*** 沉默 ***";
DBM_AZGALOR_WARN_SILENCESOON				= "*** 即將發動沉默 ***";

DBM_SBT["Silence"] 					= "下一次沉默";
DBM_SBT["Azgalor"] = {
	{"Doom: (.*)","災厄降臨: %1"},
};

-- Archimonde
DBM_ARCHIMONDE_NAME					= "阿克蒙德";
DBM_ARCHIMONDE_DESCRIPTION				= "提示軍團之握, 恐懼, 狂暴和空氣炸裂.";
DBM_ARCHIMONDE_OPTION_GRIP				= "提示軍團之握"
DBM_ARCHIMONDE_OPTION_BURST				= "提示空氣炸裂"
DBM_ARCHIMONDE_OPTION_BURSTICON				= "標記中了空氣炸裂的人"
DBM_ARCHIMONDE_OPTION_BURSTSAY				= "當空氣炸裂施放在你身上時大叫"
DBM_ARCHIMONDE_OPTION_BURSTSPECWARN			= "顯示特別警告當你中了空氣炸裂"

DBM_ARCHIMONDE_YELL_PULL				= "你反抗是沒有用的。";

DBM_ARCHIMONDE_DEBUFF_GRIP				= "(.+)受到(.*)軍團之握效果的影響。";
DBM_ARCHIMONDE_CAST_FEAR				= "阿克蒙德開始施放恐懼術。"
DBM_ARCHIMONDE_CAST_BURST				= "阿克蒙德開始施放空氣炸裂。"

DBM_ARCHIMONDE_WARN_GRIP				= "*** 軍團之握: >%s< ****"
DBM_ARCHIMONDE_WARN_ENRAGE				= "*** %s %s後狂暴 ***";
DBM_ARCHIMONDE_WARN_FEAR				= "*** 恐懼 ***";
DBM_ARCHIMONDE_WARN_FEARSOON				= "*** 即將發動恐懼 ***";
DBM_ARCHIMONDE_WARN_BURST				= "*** 空氣炸裂: >%s< ***";
DBM_ARCHIMONDE_WARN_BURST_ME				= "空氣炸裂要來了!你們快跑!";
DBM_ARCHIMONDE_SPECWARN_BURST				= "空氣炸裂! 準備使用物品!";

DBM_SBT["Enrage"] 					= "狂怒";
DBM_SBT["Fear"] 					= "恐懼";

-- MHTrash
DBM_MHT_NAME						= "小怪模組"
DBM_MHT_DESCRIPTION					= "提供波數計時, 小怪提示, 食屍提示"
DBM_MHT_DESCRIPTION1					= "提示即將到來的小怪種類數量"
DBM_MHT_DESCRIPTION2					= "提示食屍鬼的食屍";
DBM_MHT_OPTION_WAVE					= "提示即將到來的小怪"

DBM_MHT_GHOUL_CHECK					= "食屍鬼獲得了食屍的效果。";
DBM_MHT_WARN_GHOUL					= "食屍鬼正在食屍!!"
DBM_MHT_WAVE_CHECK					= "目前波數 = (%d+)/8"
DBM_MHT_WAVE_SOON					= "下一波小怪即將到來"
DBM_MHT_WAVE_NOW					= "下一波小怪!"
DBM_MHT_BOSS_SOON					= "BOSS即將到來"
DBM_MHT_BOSS_NOW					= "Boss來了!"

DBM_MHT_JAINA						= "珍娜·普勞德摩爾女士"
DBM_MHT_THRALL						= "索爾"
DBM_MHT_THRALL_DIES					= "索爾死亡了。"
DBM_MHT_JAINA_DIES					= "珍娜·普勞德摩爾女士死亡了。"
DBM_MHT_RAGE_MSG					= "我和我的同伴都與你同在，普勞德摩爾女士。"
DBM_MHT_ANETHERON_MSG					= "不管阿克蒙德要派誰來對付我們，我們都已經準備好了，普勞德摩爾女士。"
DBM_MHT_KAZROGAL_MSG					= "我與你同在，索爾。"
DBM_MHT_AZGALOR_MSG					= "我們無所畏懼。"
DBM_MHT_BOSS_DIES					= "%s死亡了。"

DBM_MHT_WAVE_INC_WARNING1				= "*** 第 %s/8 波 - %s %s  ***";
DBM_MHT_WAVE_INC_WARNING2				= "*** 第 %s/8 波 - %s %s 和 %s %s ***";
DBM_MHT_WAVE_INC_WARNING3				= "*** 第 %s/8 波 - %s %s, %s %s 和 %s %s ***";
DBM_MHT_WAVE_INC_WARNING4				= "*** 第 %s/8 波 - %s %s, %s %s, %s %s 和 %s %s ***";
DBM_MHT_WAVE_INC_WARNING5				= "*** 第 %s/8 波 - %s %s, %s %s, %s %s, %s %s 和 %s %s ***";

DBM_MHT_GHOUL						= "食屍鬼"
DBM_MHT_ABOMINATION					= "憎惡"
DBM_MHT_NECROMANCER					= "死靈法師"
DBM_MHT_BANSHEE						= "女妖"
DBM_MHT_FIEND						= "地穴惡魔"
DBM_MHT_GARGOYLE					= "石像鬼"
DBM_MHT_WYRM						= "冰龍"
DBM_MHT_STALKER						= "惡魔捕獵者"
DBM_MHT_INFERNAL					= "巨型地獄火"

DBM_SBT["Next Wave"] 					= "下一波";

end