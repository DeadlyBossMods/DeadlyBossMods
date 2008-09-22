if (GetLocale() == "zhTW") then
--Chinese Translate by Nightkiller@日落沼澤(kc10577@巴哈;Azael)
DBM_BT_TAB		= "TempleTab"
DBM_BLACK_TEMPLE	= "黑暗神廟";


-- High Warlord Naj'entus
DBM_NAJENTUS_NAME				= "高階督軍納珍塔斯";
DBM_NAJENTUS_DESCRIPTION			= "提示尖刺脊椎和潮汐之盾.";

DBM_NAJENTUS_OPTION_ICON			= "標記尖刺脊椎目標";
DBM_NAJENTUS_OPTION_RANGECHECK			= "顯示距離框";
DBM_NAJENTUS_OPTION_FRAME			= "顯示玩家生命值低於8500";

DBM_NAJENTUS_YELL_PULL				= "你會以瓦許女士之名而死!";
DBM_NAJENTUS_DEBUFF_SPINE			= "(.+)受到(.*)尖刺脊椎效果的影響。"
DBM_NAJENTUS_DEBUFF_SHIELD			= "高階督軍納珍塔斯受到潮汐之盾效果的影響。";
DBM_NAJENTUS_FADE_SHIELD			= "潮汐之盾效果從高階督軍納珍塔斯身上消失。";

DBM_NAJENTUS_WARN_SPINE				= "*** 尖刺脊椎: >%s< ***";
DBM_NAJENTUS_WARN_ENRAGE			= "*** %s %s後狂暴 ***";
DBM_NAJENTUS_WARN_SHIELD			= "*** 潮汐之盾 ***";
DBM_NAJENTUS_WARN_SHIELD_SOON			= "*** 即將發動潮汐之盾 ***";

DBM_NAJENTUS_FRAME_TITLE			= "納珍塔斯"
DBM_NAJENTUS_FRAME_TEXT				= "玩家生命值低於8500:"
DBM_NAJENTUS_SPELL_PWS				= "真言術:盾"
DBM_NAJENTUS_SPELL_FW				= "防護冰霜結界"
DBM_NAJENTUS_SPELL_FB				= "魔獄樹花"

DBM_SBT["Enrage"] 				= "狂怒";
DBM_SBT["Next Tidal Shield"] 			= "下一次潮汐之盾";

-- Supremus
DBM_SUPREMUS_NAME				= "瑟普莫斯";
DBM_SUPREMUS_DESCRIPTION			= "提示階段和目標.";
DBM_SUPREMUS_OPTION_TARGETWARN			= "提示第二階段瑟普莫斯的目標";
DBM_SUPREMUS_OPTION_TARGETICON			= "標記瑟普莫斯的目標";
DBM_SUPREMUS_OPTION_TARGETWHISPER		= "發送密語給瑟普莫斯的目標";

DBM_SUPREMUS_EMOTE_PHASE1			= "瑟普莫斯憤怒的捶擊地面!";
DBM_SUPREMUS_EMOTE_PHASE2			= "地上開始裂開!";
DBM_SUPREMUS_EMOTE_NEWTARGET			= "瑟普莫斯需要一個新目標!";
DBM_SUPREMUS_DEBUFF_FIRE			= "你受到了熔火之焰效果的影響。";
DBM_SUPREMUS_DEBUFF_VOLCANO			= "你受到了火山噴泉效果的影響。";

DBM_SUPREMUS_WARN_KITE_TARGET			= "目標: >%s<";
DBM_SUPREMUS_WARN_PHASE_1_SOON			= "*** 10秒後第一階段(坦&殺&補) ***";
DBM_SUPREMUS_WARN_PHASE_2_SOON			= "*** 10秒後第二階段(放風箏) ***";
DBM_SUPREMUS_WARN_PHASE_1			= "*** 第一階段(坦&殺&補) ****";
DBM_SUPREMUS_WARN_PHASE_2			= "*** 第二階段(放風箏) ***";
DBM_SUPREMUS_SPECWARN_FIRE			= "熔火之焰";
DBM_SUPREMUS_SPECWARN_VOLCANO			= "火山噴泉";
DBM_SUPREMUS_WHISPER_RUN_AWAY			= "瑟普莫斯正在注視你！快逃！";

DBM_SBT["Enrage"] 				= "狂怒";
DBM_SBT["Kite Phase"] 				= "第二階段(放風箏)";
DBM_SBT["Tank & Spank Phase"] 			= "第一階段(坦&殺&補)";

-- Shade of Akama
DBM_AKAMA_NAME					= "阿卡瑪的黑暗面";
DBM_AKAMA_DESCRIPTION				= nil;

DBM_AKAMA_MOB_AKAMA				= "阿卡瑪";
DBM_AKAMA_MOB_DEFENDER				= "灰舌防衛者";
DBM_AKAMA_MOB_CHANNELER				= "灰舌導魔師";
DBM_AKAMA_MOB_SORCERER				= "灰舌巫士";
DBM_AKAMA_MOB_DIES				= "%s死亡了。";

DBM_AKAMA_WARN_CHANNELER_DOWN			= "**** %s/6 導魔師死亡 ****";
DBM_AKAMA_WARN_SORCERER_DOWN			= "**** %s 巫士死亡 ****";

-- Teron Gorefiend
DBM_GOREFIEND_NAME				= "泰朗·血魔";
DBM_GOREFIEND_DESCRIPTION			= "提示死亡之影和燒盡.";

DBM_GOREFIEND_OPTION_INCINERATE			= "提示燒盡";

DBM_GOREFIEND_YELL_PULL				= "我要復仇﹗";
DBM_GOREFIEND_DEBUFF_SOD			= "(.+)受到(.*)死亡之影效果的影響。";
DBM_GOREFIEND_DEBUFF_INCINERATE			= "(.+)受到(.*)燒盡效果的影響。";

DBM_GOREFIEND_WARN_SOD				= "*** 死亡之影: >%s< ***";
DBM_GOREFIEND_WARN_INCINERATE			= "*** 燒盡: >%s< ***";

DBM_GOREFIEND_SPECWARN_SOD			= "死亡之影";

DBM_SBT["TeronGorefiend"] = {
	{"Vengeful Spirit: (.*)", "復仇靈魂: %1"},
	{"Shadow of Death: (.*)", "死亡之影: %1"},
};

-- Bloodboil
DBM_BLOODBOIL_NAME				= "葛塔格·血沸";
DBM_BLOODBOIL_DESCRIPTION			= "提示血液沸騰,惡魔之怒和圓弧斬.";
DBM_BLOODBOIL_OPTION_SMASH			= "提示圓弧斬";

DBM_BLOODBOIL_YELL_PULL				= "部落會……毀滅你們。";
DBM_BLOODBOIL_DEBUFF_BLOODBOIL			= "受到血液沸騰";
DBM_BLOODBOIL_GAIN_FEL_RAGE			= "葛塔格·血沸獲得了惡魔之怒的效果。";
DBM_BLOODBOIL_FADE_FEL_RAGE			= "惡魔之怒效果從葛塔格·血沸身上消失。";
DBM_BLOODBOIL_DEBUFF_FEL_RAGE			= "(.+)受到(.*)惡魔之怒效果的影響。";
DBM_BLOODBOIL_DEBUFF_SMASH			= "(.+)受到(.*)圓弧斬效果的影響。";

DBM_BLOODBOIL_WARN_BLOODBOIL			= "*** 血液沸騰 #%s ***";
DBM_BLOODBOIL_WARN_ENRAGE			= "*** %s %s後狂暴 ***";
DBM_BLOODBOIL_WARN_FELRAGE_SOON			= "*** 即將發動惡魔之怒 ***";
DBM_BLOODBOIL_WARN_NORMAL_SOON			= "*** 5秒後回到普通階段 ***";
DBM_BLOODBOIL_WARN_FELRAGE			= "*** 惡魔之怒: >%s< ***";
DBM_BLOODBOIL_WARN_NORMALPHASE			= "*** 普通階段 ***";
DBM_BLOODBOIL_WARN_SMASH			= "*** 圓弧斬 ***";
DBM_BLOODBOIL_WARN_SMASH_SOON			= "*** 即將發動圓弧斬 ***";

DBM_SBT["Enrage"] 				= "狂怒";
DBM_SBT["Fel Rage"] 				= "惡魔之怒";
DBM_SBT["Arcing Smash"] 			= "圓弧斬";
DBM_SBT["Bloodboil"] = {
	{"Normal Phase", "普通階段"},
	{"Bloodboil", "血液沸騰"},
}

-- Essence (Reliquary) of Souls
DBM_SOULS_NAME					= "靈魂精華"
DBM_SOULS_DESCRIPTION				= "提示狂怒, 凝視, 靈魂消耗, 符文護盾, 麻木, 惡意和靈魂尖嘯."
DBM_SOULS_OPTION_DRAIN				= "提示靈魂消耗"
DBM_SOULS_OPTION_DRAIN_CAST			= "提示靈魂消耗施放 (對驅散職業有用)"
DBM_SOULS_OPTION_FIXATE				= "提示凝視"
DBM_SOULS_OPTION_SPITE				= "提示惡意"
DBM_SOULS_OPTION_SCREAM				= "提示靈魂尖嘯"
DBM_SOULS_OPTION_SPECWARN_SPITE			= "顯示特別警告當你中了惡意"
DBM_SOULS_OPTION_WHISPER_SPITE			= "發送密語給中了惡意的目標"

DBM_SOULS_BOSS_SUFFERING			= "受難精華"
DBM_SOULS_BOSS_DESIRE				= "慾望精華"
DBM_SOULS_BOSS_KILL_NAME			= "憤怒精華"
DBM_SOULS_YELL_PULL				= "等待你們的只有痛苦與折磨﹗" -- Essence of Suffering
DBM_SOULS_EMOTE_ENRAGE				= "%s暴怒了起來!"
DBM_SOULS_GAIN_RUNESHIELD			= "慾望精華獲得了符文護盾的效果。"
DBM_SOULS_CAST_SPIRIT_SHOCK			= "慾望精華開始施放靈魂震擊。"
DBM_SOULS_CAST_DEADEN				= "慾望精華開始施放麻木。"
DBM_SOULS_CAST_SOULDRAIN			= "受難精華開始施放靈魂消耗。"
DBM_SOULS_YELL_DESIRE				= "你可以得到任何你想要的東西……只要付得起代價。"
DBM_SOULS_YELL_DESIRE_DEMONIC			= "[惡魔語]  Revola Soranaman ZennshinagasZar"
DBM_SOULS_DEBUFF_SPITE				= "(.+)受到(.*)惡意效果的影響。"
DBM_SOULS_DEBUFF_SOULDRAIN			= "(.+)受到(.*)靈魂消耗效果的影響。"
DBM_SOULS_DEBUFF_FIXATE				= "(.+)受到(.*)凝視效果的影響。"
DBM_SOULS_CAST_SOULSCREAM			= "憤怒精華的靈魂尖嘯擊中"
DBM_SOULS_YELL_ANGER_INC			= "當心吧，我復活了﹗"

DBM_SOULS_WARN_ENRAGE_SOON			= "*** 即將狂怒 ***"
DBM_SOULS_WARN_ENRAGE				= "*** 狂怒 - 維持15秒 ***"
DBM_SOULS_WARN_ENRAGE_OVER			= "*** 狂怒結束 ***"
DBM_SOULS_WARN_RUNESHIELD			= "*** 符文護盾 ***"
DBM_SOULS_WARN_RUNESHIELD_SOON			= "*** 3秒後 符文護盾 ***"
DBM_SOULS_WARN_DEADEN				= "*** 麻木施放中 ***"
DBM_SOULS_WARN_DEADEN_SOON			= "*** 5秒後 麻木 ***"
DBM_SOULS_WARN_DESIRE_INC			= "*** 欲望精華 - 大約3分鐘後沒人有藍了 ***"
DBM_SOULS_WARN_MANADRAIN			= "*** 20秒後 沒人有藍了 ***"
DBM_SOULS_WARN_SPITE				= "*** 惡意: %s ***"
DBM_SOULS_WARN_SOULDRAIN			= "*** 靈魂消耗: %s ***"
DBM_SOULS_WARN_SOULDRAIN_CAST			= "*** 正在施放靈魂消耗 準備驅散 ***"
DBM_SOULS_WARN_FIXATE				= "*** 凝視: >%s< ***"
DBM_SOULS_SPECWARN_FIXATE			= "凝視!"
DBM_SOULS_WARN_SCREAM				= "*** 靈魂尖嘯 ***"
DBM_SOULS_SPECWARN_SPITE			= "惡意!"
DBM_SOULS_WARN_ANGER_INC			= "*** 憤怒精華 ***";
DBM_SOULS_WHISPER_SPITE				= "惡意在你身上!"

DBM_SBT["Enrage"] 				= "狂怒";
DBM_SBT["Next Enrage"]				= "下一次狂怒"
DBM_SBT["Mana Drain"]				= "法力消耗"
DBM_SBT["Rune Shield"]				= "符文護盾"
DBM_SBT["Deaden"]				= "麻木"
DBM_SBT["Soul Scream"]				= "靈魂尖嘯"
DBM_SBT["Souls"] = {
	{"Fixate: (.*)", "凝視: %1"},
}

-- Mother Shahraz
DBM_SHAHRAZ_NAME				= "薩拉茲女士"
DBM_SHAHRAZ_DESCRIPTION				= "提示致命的吸引力, 標記和傳送密語. 提供波動提示和計時器."
DBM_SHAHRAZ_OPTION_BEAM				= "提示波動"
DBM_SHAHRAZ_OPTION_BEAM_SOON			= "顯示\"即將發動波動\"警告"

DBM_SHAHRAZ_YELL_PULL				= "是辦正事還找樂子呢?"
DBM_SHAHRAZ_AFFLICT_FA				= "(.+)受到(.*)致命的吸引力效果的影響。"
DBM_SHAHRAZ_BEAM_VILE				= "受到卑鄙波動"
DBM_SHAHRAZ_BEAM_SINISTER			= "薩拉茲女士的陰險波動"
DBM_SHAHRAZ_BEAM_SINFUL				= "薩拉茲女士的罪惡波動"
DBM_SHAHRAZ_BEAM_WICKED				= "薩拉茲女士的邪惡波動"

DBM_SHAHRAZ_WARN_ENRAGE				= "*** %s %s後狂暴 ***"
DBM_SHAHRAZ_WARN_FA				= "*** 致命的吸引力: %s ***"
DBM_SHAHRAZ_SPECWARN_FA				= "致命的吸引力"
DBM_SHAHRAZ_WHISPER_FA				= "你中了致命的吸引力!"
DBM_SHAHRAZ_WARN_BEAM_VILE			= "*** 卑鄙波動 ***"
DBM_SHAHRAZ_WARN_BEAM_SINISTER			= "*** 陰險波動 ***"
DBM_SHAHRAZ_WARN_BEAM_SINFUL			= "*** 罪惡波動 ***"
DBM_SHAHRAZ_WARN_BEAM_WICKED			= "*** 邪惡波動 ***"
DBM_SHAHRAZ_WARN_BEAM_SOON			= "*** 3秒後 發動波動 ***"

DBM_SBT["Enrage"] 				= "狂怒";
DBM_SBT["Next Beam"]				= "下一次波動";

-- Illidari Council
DBM_COUNCIL_NAME				= "伊利達瑞議會"
DBM_COUNCIL_DESCRIPTION				= "提示治療之環, 致命毒藥, 神聖之怒, 消失和護盾."
DBM_COUNCIL_OPTION_COH				= "提示治療之環"
DBM_COUNCIL_OPTION_DP				= "提示致命毒藥"
DBM_COUNCIL_OPTION_DW				= "提示神聖之怒"
DBM_COUNCIL_OPTION_VANISH			= "提示消失"
DBM_COUNCIL_OPTION_VANISHFADED			= "顯示特別警告當王失去消失"
DBM_COUNCIL_OPTION_VANISHFADESOON		= "顯示5秒內王重新出現警告"
DBM_COUNCIL_OPTION_SN				= "提示反射護盾"
DBM_COUNCIL_OPTION_SS				= "提示法術護盾"
DBM_COUNCIL_OPTION_SM				= "提示物理護盾"
DBM_COUNCIL_OPTION_DEVAURA			= "提示虔誠光環"
DBM_COUNCIL_OPTION_RESAURA			= "提示多重抗性光環"

DBM_COUNCIL_MOB_GATHIOS				= "粉碎者高希歐"
DBM_COUNCIL_MOB_MALANDE				= "瑪蘭黛女士"
DBM_COUNCIL_MOB_ZEREVOR				= "高等虛空術師札瑞佛"
DBM_COUNCIL_MOB_VERAS				= "維拉斯·深影"

DBM_COUNCIL_MOB_GATHIOS_EN			= "Gathios the Shatterer"
DBM_COUNCIL_MOB_MALANDE_EN			= "Lady Malande"
DBM_COUNCIL_MOB_ZEREVOR_EN			= "High Nethermancer Zerevor"
DBM_COUNCIL_MOB_VERAS_EN			= "Veras Darkshadow"

DBM_COUNCIL_YELL_PULL1				= "通用語...多麼粗俗的語言。"
DBM_COUNCIL_YELL_PULL2				= "你們要考驗我嗎?"
DBM_COUNCIL_YELL_PULL3				= "我還有更重要的事情要做……"
DBM_COUNCIL_YELL_PULL4				= "不逃走就受死吧!"

DBM_COUNCIL_CAST_DW				= "瑪蘭黛女士開始施放神聖之怒。" 
DBM_COUNCIL_CAST_COH				= "瑪蘭黛女士開始施放治療之環。"
DBM_COUNCIL_HEAL_COH				= "瑪蘭黛女士的治療之環治療了"
DBM_COUNCIL_INTERRUPT_COH			= "打斷了瑪蘭黛女士的治療之環"
DBM_COUNCIL_BUFF_VANISH				= "維拉斯·深影獲得了消失的效果。"
DBM_COUNCIL_FADE_VANISH				= "消失效果從維拉斯·深影身上消失。"
DBM_COUNCIL_DEBUFF_POISON			= "(.+)受到(.*)致命毒藥效果的影響。"
DBM_COUNCIL_BUFF_SPELLWARD			= "(.-)獲得了法術結界祝福的效果。"
DBM_COUNCIL_BUFF_PROTECTION			= "(.-)獲得了保護祝福的效果。"
DBM_COUNCIL_BUFF_SHIELD				= "瑪蘭黛女士獲得了反射護盾的效果。"
DBM_COUNCIL_DEBUFF_WRATH			= "(.+)受到(.*)神聖之怒效果的影響。"
DBM_COUNCIL_BUFF_DEV_AURA			= "獲得了虔誠光環的效果。"
DBM_COUNCIL_BUFF_RES_AURA			= "獲得了多重抗性光環的效果。"

DBM_COUNCIL_WARN_CAST_COH			= "治療之環"
DBM_COUNCIL_WARN_POISON				= "致命毒藥: >%s<"
DBM_COUNCIL_WARN_SHIELD_NORMAL			= "反射護盾"
DBM_COUNCIL_WARN_SHIELD_SPELL			= "法術護盾: %s"
DBM_COUNCIL_WARN_SHIELD_MELEE			= "物理護盾: %s"
DBM_COUNCIL_WARN_VANISH				= "消失"
DBM_COUNCIL_WARN_VANISH_FADED			= "消失結束"
DBM_COUNCIL_WARN_WRATH				= "神聖之怒: >%s<"
DBM_COUNCIL_WARN_AURA_DEV			= "虔誠光環"
DBM_COUNCIL_WARN_AURA_RES			= "多重抗性光環"
DBM_COUNCIL_WARN_VANISHFADE_SOON		= "5秒內王重新出現，牧師漸隱"

DBM_SBT["Enrage"] 				= "狂怒";
DBM_SBT["Circle of Healing"] 			= "治療之環";
DBM_SBT["Next Circle of Healing"] 		= "下一次治療之環";
DBM_SBT["Reflective Shield"] 			= "反射護盾";
DBM_SBT["Divine Wrath"] 			= "神聖之怒";
DBM_SBT["Vanish"] 				= "消失";
DBM_SBT["Devotion Aura"] 			= "虔誠光環";
DBM_SBT["Resistance Aura"] 			= "多重抗性光環";
DBM_SBT["Council"] = {
	{"Spell Shield: (.*)", "法術護盾: %1"},
	{"Melee Shield: (.*)", "物理護盾: %1"},
}

-- Illidan Stormrage
DBM_ILLIDAN_NAME				= "伊利丹·怒風"
DBM_ILLIDAN_DESCRIPTION				= "提示階段, 銳減, 寄生暗影惡魔, 黑暗侵襲, 眼棱, 苦惱之焰, 暗影惡魔, 烈焰爆擊和狂怒."
DBM_ILLIDAN_OPTION_RANGECHECK			= "在第三階段顯示距離框"
DBM_ILLIDAN_OPTION_PHASES			= "提示階段"
DBM_ILLIDAN_OPTION_SHEARCAST			= "提示施放銳減"
DBM_ILLIDAN_OPTION_SHEAR			= "提示銳減"
DBM_ILLIDAN_OPTION_SHADOWFIEND			= "提示寄生"
DBM_ILLIDAN_OPTION_ICONFIEND			= "標記中了寄生的人"
DBM_ILLIDAN_OPTION_BARRAGE			= "提示黑暗侵襲"
DBM_ILLIDAN_OPTION_BARRAGE_SOON			= "顯示\"黑暗侵襲 即將發動\"警告"
DBM_ILLIDAN_OPTION_EYEBEAM			= "提示眼棱"
DBM_ILLIDAN_OPTION_FLAMES			= "提示苦惱之焰"
DBM_ILLIDAN_OPTION_DEMONFORM			= "提示惡魔/人形 形態"
DBM_ILLIDAN_OPTION_FLAMEBURST			= "提示烈焰爆擊"
DBM_ILLIDAN_OPTION_SHADOWDEMONS			= "提示暗影惡魔"
DBM_ILLIDAN_OPTION_EYEBEAMSOON			= "顯示\"眼棱即將到來\"警告"

DBM_ILLIDAN_YELL_PULL				= "時機來臨了，終於等到這一刻了﹗"
DBM_ILLIDAN_DEBUFF_SHEAR			= "(.+)受到(.*)銳減效果的影響。"
DBM_ILLIDAN_DEBUFF_SHADOWFIEND			= "(.+)受到(.*)寄生暗影惡魔效果的影響。"
DBM_ILLIDAN_DEBUFF_DARKBARRAGE			= "(.+)受到(.*)黑暗侵襲效果的影響。"
DBM_ILLIDAN_YELL_EYEBEAM			= "直視背叛者的雙眼吧!"
DBM_ILLIDAN_DEBUFF_FLAMES			= "(.+)受到(.*)苦惱之焰效果的影響。"
DBM_ILLIDAN_CAST_PHASE2				= "埃辛諾斯之刃施放了召喚埃辛諾斯之淚。"
DBM_ILLIDAN_YELL_DEMONFORM			= "感受我體內的惡魔之力吧!"
DBM_ILLIDAN_YELL_PHASE4				= "你們就這點本事嗎?這就是你們全部的能耐?"
DBM_ILLIDAN_FLAME_DOWN				= "埃辛諾斯火焰死亡了。"
DBM_ILLIDAN_CAST_FLAMEBURST			= "烈焰爆擊擊中(.+)"
DBM_ILLIDAN_CAST_SHADOWDEMS			= "伊利丹怒風開始施放召喚暗影惡魔。" -- nobody should be in range for this event (damage aura)
DBM_ILLIDAN_SPELL_SHADOWDEMONS			= "召喚暗影惡魔"
DBM_ILLIDAN_SPELL_SHEAR				= "銳減"
DBM_ILLIDAN_YELL_START				= "阿卡瑪。你的謊言真是老套。我很久前就應該殺了你和你那些畸形的同胞。"
DBM_ILLIDAN_DEBUFF_DEMON			= "(.+)受到(.*)麻痹效果的影響。"
DBM_ILLIDAN_DEBUFF_PRISON			= "你受到了暗影之牢效果的影響。"
DBM_ILLIDAN_GAIN_ENRAGE				= "伊利丹·怒風獲得了激怒的效果。"

DBM_ILLIDAN_WARN_SHEAR				= "銳減: >%s<"
DBM_ILLIDAN_WARN_SHADOWFIEND			= "寄生暗影惡魔: >%s<"
DBM_ILLIDAN_WARN_BARRAGE			= "黑暗侵襲: >%s<"
DBM_ILLIDAN_WARN_BARRAGE_SOON			= "黑暗侵襲 即將發動"
DBM_ILLIDAN_WARN_EYEBEAM			= "暗眼衝擊波"
DBM_ILLIDAN_WARN_FLAMES				= "苦惱之焰: %s"
DBM_ILLIDAN_WARN_PHASE2				= "第二階段"
DBM_ILLIDAN_WARN_PHASE3				= "第三階段"
DBM_ILLIDAN_WARN_PHASE4				= "第四階段"
DBM_ILLIDAN_WARN_PHASE_DEMON			= "惡魔階段"
DBM_ILLIDAN_WARN_FLAMEBURST			= "烈焰爆擊 #%s"
DBM_ILLIDAN_WARN_FLAMEBURST_SOON		= "烈焰爆擊 即將發動"
DBM_ILLIDAN_WARN_SHADOWDEMSSOON			= "暗影惡魔 即將發動"
DBM_ILLIDAN_WARN_SHADOWDEMS			= "暗影惡魔"
DBM_ILLIDAN_WARN_NORMALPHASE_SOON		= "10秒後 人形階段"
DBM_ILLIDAN_WARN_CASTSHEAR			= "正在施放銳減"
DBM_ILLIDAN_WARN_EYEBEAM_SOON			= "眼棱即將到來"
DBM_ILLIDAN_WARN_PHASE_NORMAL			= "人形階段"
DBM_ILLIDAN_WARN_DEMONPHASE_SOON		= "10秒後 惡魔階段"
DBM_ILLIDAN_WARN_SHADOWDEMSON			= "暗影惡魔: %s"
DBM_ILLIDAN_STATUSMSG_PHASE2			= "第二階段"
DBM_ILLIDAN_WARN_PRISON				= "暗影之牢"
DBM_ILLIDAN_WARN_P4ENRAGE_SOON			= "5秒后激怒"
DBM_ILLIDAN_WARN_P4ENRAGE_NOW			= "激怒"
DBM_ILLIDAN_WARN_CAGED				= "伊利丹中了陷阱"

DBM_ILLIDAN_SELFWARN_SHADOWFIEND		= "你中了寄生暗影惡魔!快跑到指定位置!"
DBM_ILLIDAN_SELFWARN_SHADOW			= "你中了苦惱之焰!"
DBM_ILLIDAN_SELFWARN_DEMONS			= "暗影惡魔"

DBM_SBT["Enrage"]				= "狂怒";
DBM_SBT["Illidan Stormrage"]			= "伊利丹·怒風";
DBM_SBT["Next Eye Blast"]			= "下一次暗眼衝擊波"; --not using now
DBM_SBT["Next Dark Barrage"]			= "下一次黑暗侵襲";
DBM_SBT["Demon Phase"]				= "惡魔階段";
DBM_SBT["Shadow Demons"]			= "暗影惡魔";
DBM_SBT["Next Flame Burst"]			= "下一次烈焰爆擊";
DBM_SBT["Shadow Prison"]			= "暗影之牢";
DBM_SBT["Enrage2"]				= "激怒" -- you cannot have two timers with the same id, so the 2nd enrage bar needs a "localization"
DBM_SBT["Illidan"] = {
	{"Shear: (.*)", "銳減: %1"},
	{"Shadowfiend: (.*)", "寄生暗影惡魔: %1"},
	{"Dark Barrage: (.*)", "黑暗侵襲: %1"},
	{"Flames: (.*)", "苦惱之焰: %1"},
	{"Normal Phase", "人形階段"},
}
end