if (GetLocale() == "zhTW") then
--Chinese Translate by Nightkiller@日落沼澤(kc10577@巴哈;Azael)
DBM_ZULAMAN		= "祖阿曼"
DBM_ZULAMAN_TAB	= "DBM_ZULAMAN_TAB";

-- Nalorakk
DBM_NALO_NAME				= "納羅拉克"
DBM_NALO_DESCRIPTION			= "為熊/人型階段和沉默提供提示和計時."
DBM_NALO_OPTION_PHASEPRE		= "為階段顯示5秒警告"
DBM_NALO_OPTION_SILENCE			= "提示沉默"

DBM_NALO_YELL_PULL			= "你很快就會死了!"
DBM_NALO_YELL_BEAR			= "你們既然將野獸召喚出來，就將付出更多的代價!"
DBM_NALO_YELL_NORMAL			= "沒有人可以擋在納羅拉克的面前!"
DBM_NALO_DEBUFF_SILENCE			= "受到消音咆哮"
DBM_NALO_SPELLID_SILENCE		= 42398

DBM_NALO_WARN_NORMAL_SOON		= "5秒後 普通階段"
DBM_NALO_WARN_BEAR_SOON			= "5秒後 熊階段"
DBM_NALO_WARN_NORMAL			= "普通階段"
DBM_NALO_WARN_BEAR			= "熊階段"
DBM_NALO_WARN_SILENCE			= "沉默"

DBM_SBT["Enrage"] 			= "狂怒";
DBM_SBT["Bear Form"] 			= "熊階段";
DBM_SBT["Normal Form"] 			= "普通階段";

-- Akil'zon
DBM_AKIL_NAME				= "阿奇爾森"
DBM_AKIL_DESCRIPTION			= "提示電荷風暴和點擊小地圖."
DBM_AKIL_OPTION_RANGE			= "顯示距離框"

DBM_AKIL_YELL_PULL			= "我是掠食者!而你們，就是獵物!"
DBM_AKIL_DEBUFF_STORM			= "(.+)受到(.*)電荷風暴效果的影響。"
DBM_AKIL_SPELLID_STORM			= 43657

DBM_AKIL_WARN_STORM_SOON		= "即將發動電荷風暴"
DBM_AKIL_WARN_STORM_ON			= "電荷風暴: >%s<"

DBM_SBT["Enrage"] 			= "狂怒";
DBM_SBT["Electrical Storm"] 		= "電荷風暴";

-- Jan'alai
DBM_JANALAI_NAME			= "賈納雷"
DBM_JANALAI_DESCRIPTION			= "提示傳送和孵化者."

DBM_JANALAI_YELL_PULL			= "風之聖魂將是你的夢魘!"
DBM_JANALAI_YELL_EXPLOSION		= "燒死你們!"
DBM_JANALAI_YELL_HATCHER		= "雌鷹哪裡去啦?快去孵蛋!"

DBM_JANALAI_WARN_EXPLOSION		= "傳送"
DBM_JANALAI_WARN_EXPLOSION_INC		= "1秒後 發動燃燒彈"
DBM_JANALAI_WARN_HATCHER		= "孵化者"
DBM_JANALAI_WARN_HATCHER_SOON		= "10秒後出現孵化者"

DBM_SBT["Enrage"] 			= "狂怒";
DBM_SBT["Hatcher"] 			= "孵化者";
DBM_SBT["Explosion"] 			= "燃燒彈";

-- Halazzi
DBM_HALAZZI_NAME			= "哈拉齊"
DBM_HALAZZI_DESCRIPTION			= "提示階段, 圖騰和狂亂."
DBM_HALAZZI_OPTION_FRENZY		= "提示狂亂"
DBM_HALAZZI_OPTION_TOTEM		= "提示閃電圖騰"

DBM_HALAZZI_YELL_PULL			= "在利爪與尖牙面前下跪吧，祈禱吧，顫慄吧!"
DBM_HALAZZI_YELL_SPIRIT			= "狂野的靈魂與我同在......"
DBM_HALAZZI_YELL_SPIRIT_DESP		= "靈魂，回到我這裡來!"
DBM_HALAZZI_CAST_TOTEM			= "哈拉齊開始施放閃電圖騰。"
DBM_HALAZZI_GAIN_FRENZY			= "哈拉齊獲得了狂亂的效果。"
DBM_HALAZZI_SPELLID_TOTEM		= 43302

DBM_HALAZZI_WARN_SPIRIT			= "靈魂出現了"
DBM_HALAZZI_WARN_SPIRIT_DESP		= "靈魂消失了"
DBM_HALAZZI_WARN_TOTEM			= "墮落的閃電圖騰"
DBM_HALAZZI_WARN_FRENZY			= "狂亂 - 寧神射擊" -- tranq shot...wtf....

-- Malacrass
DBM_MALACRASS_NAME			= "妖術領主瑪拉克雷斯"
DBM_MALACRASS_DESCRIPTION		= "提示虹吸靈魂和靈魂箭."

DBM_MALACRASS_OPTION_MC			= "提示精神控制"

DBM_MALACRASS_DEBUFF_SIPHON		= "(.+)受到(.*)虹吸靈魂效果的影響。"
--DBM_MALACRASS_DEBUFF_MC		= "(.+)受到(.*)精神控制效果的影響。" --Domesticate?
DBM_MALACRASS_YELL_BOLTS		= "你的靈魂將會受到傷害!"
DBM_MALACRASS_SPELLID_SIPHON		= 43501

DBM_MALACRASS_WARN_SIPHON		= "虹吸靈魂: >%s<"
DBM_MALACRASS_WARN_MC			= "精神控制: >%s<"
DBM_MALACRASS_WARN_BOLTS		= "靈魂箭"
DBM_MALACRASS_WARN_BOLTS_SOON		= "5秒後 靈魂箭"

DBM_SBT["Next Spirit Bolts"] 		= "下一次靈魂箭";
DBM_SBT["Spirit Bolts"] 		= "靈魂箭";
DBM_SBT["Malacrass"] = {
	{"Siphon Soul: (.*)","虹吸靈魂: %1"},
}; 

-- Zul'jin
DBM_ZULJIN_NAME = "祖爾金"
DBM_ZULJIN_DESCRIPTION 			= "提示階段, 嚴重擲傷, 慢性麻痹和利爪之怒."

DBM_ZULJIN_OPTION_PARA 			= "提示慢性麻痹"
DBM_ZULJIN_OPTION_LYNX 			= "提示利爪之怒"

DBM_ZULJIN_YELL_PULL 			= "沒有人比我更強!"
DBN_ZULJIN_YELL_PHASE_2 		= "賜給我一些新的力量……讓我像熊一樣……"
DBM_ZULJIN_YELL_PHASE_3 		= "在雄鷹之下無所遁形!"
DBM_ZULJIN_YELL_PHASE_4 		= "讓我來介紹我的新兄弟:尖牙和利爪!"
DBM_ZULJIN_YELL_PHASE_5 		= "你不需要仰望天空才看得到龍鷹!"

DBM_ZULJIN_DEBUFF_PARALYSIS 		= "受到慢性麻痹"
DBM_ZULJIN_DEBUFF_LYNX 			= "(.+)受到(.*)利爪之怒效果的影響。"
DBM_ZULJIN_DEBUFF_DOT			= "(.+)受到(.*)嚴重擲傷效果的影響。"
DBM_ZULJIN_SPELLID_PARALYSIS		= 43095
DBM_ZULJIN_SPELLID_LYNX			= 43150
DBM_ZULJIN_SPELLID_DOT			= 43093

DBM_ZULJIN_WARN_PHASE_1 		= "第一階段 - 食人妖"
DBM_ZULJIN_WARN_PHASE_2 		= "第二階段 - 熊之化身"
DBM_ZULJIN_WARN_PHASE_3 		= "第三階段 - 雄鷹化身"
DBM_ZULJIN_WARN_PHASE_4 		= "第四階段 - 山貓化身"
DBM_ZULJIN_WARN_PHASE_5 		= "第五階段 - 龍鷹化身"

DBM_ZULJIN_WARN_PARALYSIS 		= "慢性麻痹"
DBM_ZULJIN_WARN_PARALYSIS_SOON 		= "即將發動慢性麻痹"
DBM_ZULJIN_WARN_LYNX 			= "利爪之怒: >%s<"
DBM_ZULJIN_WARN_DOT			= "嚴重擲傷: >%s<"

DBM_SBT["Creeping Paralysis"] 		= "慢性麻痹";

end