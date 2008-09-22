-- ------------------------------------------- --
--   Deadly Boss Mods - Chinese localization   --
--    by Diablohu<白银之手> @ 二区-轻风之语    --
--              www.dreamgen.cn                --
--                  4/19/2008                  --
-- ------------------------------------------- --

if (GetLocale() == "zhCN") then

	DBM_BT_TAB			= "TempleTab"
	DBM_BLACK_TEMPLE	= "黑暗神殿";


-- High Warlord Naj'entus
	DBM_NAJENTUS_NAME					= "高阶督军纳因图斯";
	DBM_NAJENTUS_DESCRIPTION			= "警报穿刺之脊和海潮之盾";

	DBM_NAJENTUS_OPTION_ICON			= "对穿刺之脊的目标添加标记";
	DBM_NAJENTUS_OPTION_RANGECHECK		= "显示距离框体";
	DBM_NAJENTUS_OPTION_FRAME			= "显示生命值少于8500点的队友";

	DBM_NAJENTUS_YELL_PULL				= "以瓦丝琪女王的名义，去死吧！";
	DBM_NAJENTUS_DEBUFF_SPINE			= "([^%s]+)受([^%s]+)穿刺之脊效果的影响。";
	DBM_NAJENTUS_DEBUFF_SHIELD			= "高阶督军纳因图斯受到了海潮之盾效果的影响。";
	DBM_NAJENTUS_FADE_SHIELD			= "海潮之盾效果从高阶督军纳因图斯身上消失。";

	DBM_NAJENTUS_WARN_SPINE				= "*** 穿刺之脊 -> >%s< ***";
	DBM_NAJENTUS_WARN_ENRAGE			= "*** %s%s后激怒 ***";
	DBM_NAJENTUS_WARN_SHIELD			= "*** 海潮之盾 ***";
	DBM_NAJENTUS_WARN_SHIELD_SOON		= "*** 海潮之盾 - 即将施放 ***";

	DBM_NAJENTUS_FRAME_TITLE			= "高阶督军纳因图斯"
	DBM_NAJENTUS_FRAME_TEXT				= "生命值少于8500的队友:"
	DBM_NAJENTUS_SPELL_PWS				= "真言术：盾"
	DBM_NAJENTUS_SPELL_FW				= "防护冰霜结界"
	DBM_NAJENTUS_SPELL_FB				= "野魔花"

	DBM_SBT["Enrage"]				= "激怒";
	DBM_SBT["Next Tidal Shield"]	= "下一次海潮之盾";


-- Supremus
	DBM_SUPREMUS_NAME					= "苏普雷姆斯";
	DBM_SUPREMUS_DESCRIPTION			= "警报阶段和目标变化";
	DBM_SUPREMUS_OPTION_TARGETWARN		= "在第二阶段警报苏普雷姆斯的目标变化";
	DBM_SUPREMUS_OPTION_TARGETICON		= "对苏普雷姆斯的目标添加标记";
	DBM_SUPREMUS_OPTION_TARGETWHISPER	= "对苏普雷姆斯的目标发送密语";

	DBM_SUPREMUS_EMOTE_PHASE1			= "愤怒地击打着地面！";
	DBM_SUPREMUS_EMOTE_PHASE2			= "地面崩裂了！";
	DBM_SUPREMUS_EMOTE_NEWTARGET		= "锁定了一个新目标！";
	DBM_SUPREMUS_DEBUFF_FIRE			= "你受到了熔岩烈焰效果的影响。";
	DBM_SUPREMUS_DEBUFF_VOLCANO			= "你受到了火山喷射效果的影响。";

	DBM_SUPREMUS_WARN_KITE_TARGET		= "目标 -> >%s<";
	DBM_SUPREMUS_WARN_PHASE_1_SOON		= "*** 10秒后进入阵地战阶段 ***";
	DBM_SUPREMUS_WARN_PHASE_2_SOON		= "*** 10秒后进入风筝阶段 ***";
	DBM_SUPREMUS_WARN_PHASE_1			= "*** 阵地战阶段 ****";
	DBM_SUPREMUS_WARN_PHASE_2			= "*** 风筝阶段 ***";
	DBM_SUPREMUS_SPECWARN_FIRE			= "熔岩烈焰";
	DBM_SUPREMUS_SPECWARN_VOLCANO		= "火山喷射";
	DBM_SUPREMUS_WHISPER_RUN_AWAY		= "跑!";

	DBM_SBT["Enrage"]				= "激怒";
	DBM_SBT["Kite Phase"]			= "风筝阶段";
	DBM_SBT["Tank & Spank Phase"]	= "阵地战阶段";


-- Shade of Akama
	DBM_AKAMA_NAME						= "阿卡玛之影";
	DBM_AKAMA_DESCRIPTION				= nil;

	DBM_AKAMA_MOB_AKAMA					= "阿卡玛";
	DBM_AKAMA_MOB_DEFENDER				= "灰舌防御者";
	DBM_AKAMA_MOB_CHANNELER				= "灰舌导魔师";
	DBM_AKAMA_MOB_SORCERER				= "灰舌巫师";
	DBM_AKAMA_MOB_DIES					= "%s死亡了。";

	DBM_AKAMA_WARN_CHANNELER_DOWN		= "**** 已击杀%s/6名导魔师 ****";
	DBM_AKAMA_WARN_SORCERER_DOWN		= "**** 已击杀%s名巫师 ****";


-- Teron Gorefiend
	DBM_GOREFIEND_NAME					= "塔隆·血魔";
	DBM_GOREFIEND_DESCRIPTION			= "警报死亡之影和烧尽";

	DBM_GOREFIEND_OPTION_INCINERATE		= "警报烧尽";

	DBM_GOREFIEND_YELL_PULL				= "我要复仇！";
	DBM_GOREFIEND_DEBUFF_SOD			= "([^%s]+)受([^%s]+)死亡之影效果的影响。";
	DBM_GOREFIEND_DEBUFF_INCINERATE		= "([^%s]+)受([^%s]+)烧尽效果的影响。";

	DBM_GOREFIEND_WARN_SOD				= "*** 死亡之影 -> >%s< ***";
	DBM_GOREFIEND_WARN_INCINERATE		= "*** 烧尽 -> >%s< ***";

	DBM_GOREFIEND_SPECWARN_SOD			= "死亡之影";
	
	DBM_SBT["TeronGorefiend"] = {
		  [1] = {"Vengeful Spirit: (.*)", "复仇之魂 -> %1"},
		  [2] = {"Shadow of Death: (.*)", "死亡之影 -> %1"},
	}
	DBM_SBT["塔隆·血魔"] = DBM_SBT["TeronGorefiend"]


-- Bloodboil
	DBM_BLOODBOIL_NAME					= "古尔图格·血沸";
	DBM_BLOODBOIL_DESCRIPTION			= "警报血沸, 邪能狂怒和弧光打击";
	DBM_BLOODBOIL_OPTION_SMASH			= "警报弧光打击";

	DBM_BLOODBOIL_YELL_PULL				= "部落会……毁灭你们。";
	DBM_BLOODBOIL_DEBUFF_BLOODBOIL		= "受到了血沸效果的影响";
	DBM_BLOODBOIL_GAIN_FEL_RAGE			= "古尔图格·血沸获得了邪能狂怒的效果。";
	DBM_BLOODBOIL_FADE_FEL_RAGE			= "邪能狂怒效果从古尔图格·血沸身上消失。";
	DBM_BLOODBOIL_DEBUFF_FEL_RAGE		= "([^%s]+)受([^%s]+)邪能狂怒效果的影响。";
	DBM_BLOODBOIL_DEBUFF_SMASH			= "([^%s]+)受([^%s]+)弧光打击效果的影响。";

	DBM_BLOODBOIL_WARN_BLOODBOIL		= "*** 血沸 #%s ***";
	DBM_BLOODBOIL_WARN_ENRAGE			= "*** %s%s后激怒 ***";
	DBM_BLOODBOIL_WARN_FELRAGE_SOON		= "*** 邪能狂怒 - 即将施放 ***";
	DBM_BLOODBOIL_WARN_NORMAL_SOON		= "*** 5秒后进入普通阶段 ***";
	DBM_BLOODBOIL_WARN_FELRAGE			= "*** 邪能狂怒 -> >%s< ***";
	DBM_BLOODBOIL_WARN_NORMALPHASE		= "*** 普通阶段 ***";
	DBM_BLOODBOIL_WARN_SMASH			= "*** 弧光打击 ***";
	DBM_BLOODBOIL_WARN_SMASH_SOON		= "*** 弧光打击 - 即将施放 ***";

	DBM_SBT["Enrage"]		= "激怒";
	DBM_SBT["Bloodboil"]	= "血沸";
	DBM_SBT["Fel Rage"]		= "邪能狂怒";
	DBM_SBT["Normal Phase"]	= "普通阶段";
	DBM_SBT["Arcing Smash"]	= "弧光打击";


-- Essence (Reliquary) of Souls
	DBM_SOULS_NAME						= "灵魂之匣"
	DBM_SOULS_DESCRIPTION				= "警报激怒, 注视, 灵魂吸取, 符文护盾, 衰减和敌意"
	DBM_SOULS_OPTION_DRAIN				= "警报灵魂吸取"
	DBM_SOULS_OPTION_DRAIN_CAST			= "警报灵魂吸取的施放 (对于群体驱散很有用)"
	DBM_SOULS_OPTION_FIXATE				= "警报注视"
	DBM_SOULS_OPTION_SPITE				= "警报敌意"
	DBM_SOULS_OPTION_SCREAM				= "警报灵魂尖啸"
	DBM_SOULS_OPTION_SPECWARN_SPITE		= "当你受到敌意效果时显示特殊警报"
	DBM_SOULS_OPTION_WHISPER_SPITE		= "对敌意的目标发送密语"

	DBM_SOULS_BOSS_SUFFERING			= "苦痛精华"
	DBM_SOULS_BOSS_DESIRE				= "欲望精华"
	DBM_SOULS_BOSS_KILL_NAME			= "愤怒精华"
	DBM_SOULS_YELL_PULL					= "等待你们的只有痛苦与折磨！" -- Essence of Suffering
	DBM_SOULS_EMOTE_ENRAGE				= "%s变得愤怒了！"
	DBM_SOULS_GAIN_RUNESHIELD			= "欲望精华获得了符文护盾的效果。"
	DBM_SOULS_CAST_SPIRIT_SHOCK			= "欲望精华开始施放灵魂震击。"
	DBM_SOULS_CAST_DEADEN				= "欲望精华开始施放衰减。"
	DBM_SOULS_CAST_SOULDRAIN			= "苦痛精华开始施放灵魂吸取。"
	DBM_SOULS_YELL_DESIRE				= "你可以获得任何你想要的东西……只要付得起代价。"
	DBM_SOULS_YELL_DESIRE_DEMONIC		= "Shi shi rikk rukadare shi tichar kar x gular"
	DBM_SOULS_DEBUFF_SPITE				= "([^%s]+)受([^%s]+)敌意效果的影响。"
	DBM_SOULS_DEBUFF_SOULDRAIN			= "([^%s]+)受([^%s]+)灵魂吸取效果的影响。"
	DBM_SOULS_DEBUFF_FIXATE				= "([^%s]+)受([^%s]+)注视效果的影响。"
	DBM_SOULS_CAST_SOULSCREAM			= "愤怒精华的灵魂尖啸击中"
	DBM_SOULS_YELL_ANGER_INC			= "当心吧，我复活了！"

	DBM_SOULS_WARN_ENRAGE_SOON			= "*** 即将激怒 ***"
	DBM_SOULS_WARN_ENRAGE				= "*** 激怒 ***"
	DBM_SOULS_WARN_ENRAGE_OVER			= "*** 激怒结束 ***"
	DBM_SOULS_WARN_RUNESHIELD			= "*** 符文护盾 ***"
	DBM_SOULS_WARN_RUNESHIELD_SOON		= "*** 符文护盾 - 3秒后施放 ***"
	DBM_SOULS_WARN_DEADEN				= "*** 衰减 ****"
	DBM_SOULS_WARN_DEADEN_SOON			= "*** 衰减 - 5秒后施放 ***"
	DBM_SOULS_WARN_DESIRE_INC			= "*** 欲望精华 - 约3分钟后法力消耗殆尽 ***"
	DBM_SOULS_WARN_MANADRAIN			= "*** 20秒后法力消耗殆尽 ***"
	DBM_SOULS_WARN_SPITE				= "*** 敌意 -> %s ***"
	DBM_SOULS_WARN_SOULDRAIN			= "*** 灵魂吸取 -> %s ***"
	DBM_SOULS_WARN_SOULDRAIN_CAST		= "*** 灵魂吸取 - 正在施放 ***"
	DBM_SOULS_WARN_FIXATE				= "*** 注视 -> >%s< ***"
	DBM_SOULS_SPECWARN_FIXATE			= "注视!"
	DBM_SOULS_WARN_SCREAM				= "*** 灵魂尖啸 ***"
	DBM_SOULS_SPECWARN_SPITE			= "敌意!"
	DBM_SOULS_WARN_ANGER_INC			= "*** 愤怒精华 ***";
	DBM_SOULS_WHISPER_SPITE				= "敌意于你!"
	
	DBM_SBT["Enrage"]		= "激怒";
	DBM_SBT["Next Enrage"]	= "下一次激怒";
	DBM_SBT["Mana Drain"]	= "法力吸取";
	DBM_SBT["Rune Shield"]	= "符文护盾";
	DBM_SBT["Deaden"]		= "衰减";
	DBM_SBT["Soul Scream"]	= "灵魂尖啸";

	DBM_SBT["Souls"] = {
		  [1] = {"Fixate: (.*)", "凝视 -> %1"},
	}
	DBM_SBT["灵魂之匣"] = DBM_SBT["Souls"]


-- Mother Shahraz
	DBM_SHAHRAZ_NAME					= "莎赫拉丝主母"
	DBM_SHAHRAZ_DESCRIPTION				= "警报致命吸引和败德射线"
	DBM_SHAHRAZ_OPTION_BEAM				= "警报射线"
	DBM_SHAHRAZ_OPTION_BEAM_SOON		= "显示“射线 - 即将施放”警报"

	DBM_SHAHRAZ_YELL_PULL				= "是办正事还是找乐子呢？"
	DBM_SHAHRAZ_AFFLICT_FA				= "([^%s]+)受([^%s]+)致命吸引效果的影响。"
	DBM_SHAHRAZ_BEAM_VILE				= "受到了败德射线效果的影响"
	DBM_SHAHRAZ_BEAM_SINISTER			= "莎赫拉丝主母的邪恶射线"
	DBM_SHAHRAZ_BEAM_SINFUL				= "莎赫拉丝主母的罪孽射线"
	DBM_SHAHRAZ_BEAM_WICKED				= "莎赫拉丝主母的堕落射线"

	DBM_SHAHRAZ_WARN_ENRAGE				= "*** %s%s后激怒 ***"
	DBM_SHAHRAZ_WARN_FA					= "*** 致命吸引 -> %s ***"
	DBM_SHAHRAZ_SPECWARN_FA				= "致命吸引"
	DBM_SHAHRAZ_WHISPER_FA				= "致命吸引于你!"
	DBM_SHAHRAZ_WARN_BEAM_VILE			= "*** 败德射线 ***"
	DBM_SHAHRAZ_WARN_BEAM_SINISTER		= "*** 邪恶射线 ***"
	DBM_SHAHRAZ_WARN_BEAM_SINFUL		= "*** 罪孽射线 ***"
	DBM_SHAHRAZ_WARN_BEAM_WICKED		= "*** 堕落射线 ***"
	DBM_SHAHRAZ_WARN_BEAM_SOON			= "*** 射线 - 3秒后施放 ***"
	
	DBM_SBT["Enrage"]		= "激怒";
	DBM_SBT["Next Beam"]	= "下一次射线";


-- Illidari Council
	DBM_COUNCIL_NAME					= "伊利达雷议会"
	DBM_COUNCIL_DESCRIPTION				= "警报治疗之环, 致命药膏, 神圣愤怒, 消失和护盾"
	DBM_COUNCIL_OPTION_COH				= "警报治疗之环"
	DBM_COUNCIL_OPTION_DP				= "警报致命药膏"
	DBM_COUNCIL_OPTION_DW				= "警报神圣愤怒"
	DBM_COUNCIL_OPTION_VANISH			= "警报消失"
	DBM_COUNCIL_OPTION_VANISHFADED		= "警报消失效果的消失"
	DBM_COUNCIL_OPTION_VANISHFADESOON	= "警报消失效果即将消失"
	DBM_COUNCIL_OPTION_SN				= "警报反射护盾"
	DBM_COUNCIL_OPTION_SS				= "警报法术护盾"
	DBM_COUNCIL_OPTION_SM				= "警报物理护盾"
	DBM_COUNCIL_OPTION_DEVAURA			= "警报虔诚光环"
	DBM_COUNCIL_OPTION_RESAURA			= "警报多彩抗性光环"

	DBM_COUNCIL_MOB_GATHIOS				= "击碎者加西奥斯"
	DBM_COUNCIL_MOB_MALANDE				= "女公爵玛兰德"
	DBM_COUNCIL_MOB_ZEREVOR				= "高阶灵术师塞勒沃尔"
	DBM_COUNCIL_MOB_VERAS				= "薇尔莱丝·深影"

	DBM_COUNCIL_MOB_GATHIOS_EN			= "击碎者加西奥斯"
	DBM_COUNCIL_MOB_MALANDE_EN			= "女公爵玛兰德"
	DBM_COUNCIL_MOB_ZEREVOR_EN			= "高阶灵术师塞勒沃尔"
	DBM_COUNCIL_MOB_VERAS_EN			= "薇尔莱丝·深影"

	DBM_COUNCIL_YELL_PULL1				= "通用语……多么粗俗的语言。Bandal！"
	DBM_COUNCIL_YELL_PULL2				= "你想考验我？"
	DBM_COUNCIL_YELL_PULL3				= "我还有更重要的事情要做……"
	DBM_COUNCIL_YELL_PULL4				= "逃吧，否则就来受死！"

	DBM_COUNCIL_CAST_DW					= "女公爵玛兰德开始施放神圣愤怒。" 
	DBM_COUNCIL_CAST_COH				= "女公爵玛兰德开始施放治疗之环。"
	DBM_COUNCIL_HEAL_COH				= "女公爵玛兰德的治疗之环为"
	DBM_COUNCIL_INTERRUPT_COH			= "打断了女公爵玛兰德的治疗之环"
	DBM_COUNCIL_BUFF_VANISH				= "薇尔莱丝·深影获得了消失的效果。"
	DBM_COUNCIL_FADE_VANISH				= "消失效果从薇尔莱丝·深影身上消失。"
	DBM_COUNCIL_DEBUFF_POISON			= "([^%s]+)受([^%s]+)致命药膏效果的影响。"
	DBM_COUNCIL_BUFF_SPELLWARD			= "([^%s]+)获得了法术结界祝福的效果。"
	DBM_COUNCIL_BUFF_PROTECTION			= "([^%s]+)获得了保护祝福的效果。"
	DBM_COUNCIL_BUFF_SHIELD				= "女公爵玛兰德获得了反射护盾的效果。"
	DBM_COUNCIL_DEBUFF_WRATH			= "([^%s]+)受([^%s]+)神圣愤怒效果的影响。"
	DBM_COUNCIL_BUFF_DEV_AURA			= "获得了虔诚光环的效果。"
	DBM_COUNCIL_BUFF_RES_AURA			= "获得了多彩抗性光环的效果。"

	DBM_COUNCIL_WARN_CAST_COH			= "治疗之环"
	DBM_COUNCIL_WARN_POISON				= "致命药膏 -> >%s<"
	DBM_COUNCIL_WARN_SHIELD_NORMAL		= "反射护盾"
	DBM_COUNCIL_WARN_SHIELD_SPELL		= "法术护盾 -> %s"
	DBM_COUNCIL_WARN_SHIELD_MELEE		= "物理护盾 -> %s"
	DBM_COUNCIL_WARN_VANISH				= "消失"
	DBM_COUNCIL_WARN_VANISH_FADED		= "消失 - 效果消失"
	DBM_COUNCIL_WARN_WRATH				= "神圣愤怒 -> >%s<"
	DBM_COUNCIL_WARN_AURA_DEV			= "虔诚光环"
	DBM_COUNCIL_WARN_AURA_RES			= "多彩抗性光环"
	DBM_COUNCIL_WARN_VANISHFADE_SOON	= "消失 - 5秒后结束"

	DBM_SBT["Enrage"]					= "激怒";
	DBM_SBT["Circle of Healing"]		= "治疗之环";
	DBM_SBT["Next Circle of Healing"]	= "下一次治疗之环";
	DBM_SBT["Reflective Shield"]		= "反射护盾";
	DBM_SBT["Vanish"]					= "消失";
	DBM_SBT["Devotion Aura"]			= "虔诚光环";
	DBM_SBT["Resistance Aura"]			= "多彩抗性光环";
	DBM_SBT["Divine Wrath"]				= "神圣愤怒";

	DBM_SBT["Council"] = {
		  [1] = {"Spell Shield: (.*)", "法术护盾 -> %1"},
		  [2] = {"Melee Shield: (.*)", "物理护盾 -> %1"},
	}
	DBM_SBT["伊利达雷议会"] = DBM_SBT["Council"]


-- Illidan Stormrage
	DBM_ILLIDAN_NAME					= "伊利丹·怒风"
	DBM_ILLIDAN_DESCRIPTION				= "警报阶段变化, 剪切, 寄生暗影魔, 黑暗壁垒, 魔眼冲击, 苦痛之焰, 影魔, 火焰爆裂和激怒"
	DBM_ILLIDAN_OPTION_RANGECHECK		= "在第三阶段显示距离框体"
	DBM_ILLIDAN_OPTION_PHASES			= "警报阶段变化"
	DBM_ILLIDAN_OPTION_SHEARCAST		= "警报剪切施放"
	DBM_ILLIDAN_OPTION_SHEAR			= "警报剪切"
	DBM_ILLIDAN_OPTION_SHADOWFIEND		= "警报寄生暗影魔"
	DBM_ILLIDAN_OPTION_ICONFIEND		= "对寄生暗影魔的目标添加标记"
	DBM_ILLIDAN_OPTION_BARRAGE			= "警报黑暗壁垒"
	DBM_ILLIDAN_OPTION_BARRAGE_SOON		= "显示“黑暗壁垒 - 即将施放”警报"
	DBM_ILLIDAN_OPTION_EYEBEAM			= "警报魔眼冲击"
	DBM_ILLIDAN_OPTION_FLAMES			= "警报苦痛之焰"
	DBM_ILLIDAN_OPTION_DEMONFORM		= "警报恶魔/普通形态的变化"
	DBM_ILLIDAN_OPTION_FLAMEBURST		= "警报火焰爆裂"
	DBM_ILLIDAN_OPTION_SHADOWDEMONS		= "警报影魔"
	DBM_ILLIDAN_OPTION_EYEBEAMSOON		= "显示“魔眼冲击 - 即将施放”警报"

	DBM_ILLIDAN_YELL_PULL				= "时机来临了，终于等到这一刻了！"
	DBM_ILLIDAN_DEBUFF_SHEAR			= "([^%s]+)受([^%s]+)剪切效果的影响。"
	DBM_ILLIDAN_DEBUFF_SHADOWFIEND		= "([^%s]+)受([^%s]+)寄生暗影魔效果的影响。"
	DBM_ILLIDAN_DEBUFF_DARKBARRAGE		= "([^%s]+)受([^%s]+)黑暗壁垒效果的影响。"
	DBM_ILLIDAN_YELL_EYEBEAM			= "直视背叛者的双眼吧！"
	DBM_ILLIDAN_DEBUFF_FLAMES			= "([^%s]+)受([^%s]+)苦痛之焰效果的影响。"
	DBM_ILLIDAN_CAST_PHASE2				= "埃辛诺斯之刃施放了召唤埃辛诺斯之泪。"
	DBM_ILLIDAN_YELL_DEMONFORM			= "感受我体内的恶魔之力吧！"
	DBM_ILLIDAN_YELL_PHASE4				= "你们就这点本事吗？这就是你们全部的能耐？"
	DBM_ILLIDAN_FLAME_DOWN				= "埃辛诺斯之焰死亡了。"
	DBM_ILLIDAN_CAST_FLAMEBURST			= "火焰爆裂击中([^%s]+)"
	DBM_ILLIDAN_CAST_SHADOWDEMS			= "伊利丹·怒风开始施放召唤影魔。" -- nobody should be in range for this event (damage aura)
	DBM_ILLIDAN_SPELL_SHADOWDEMONS		= "召唤影魔"
	DBM_ILLIDAN_SPELL_SHEAR				= "剪切"
	DBM_ILLIDAN_YELL_START				= "阿卡玛。你的两面三刀并没有让我感到意外。我早就应该把你和你那些畸形的同胞全部杀掉。"
	DBM_ILLIDAN_DEBUFF_DEMON			= "([^%s]+)受([^%s]+)麻痹效果的影响。"
	DBM_ILLIDAN_DEBUFF_PRISON			= "你受到了暗影牢笼效果的影响。"
	DBM_ILLIDAN_GAIN_ENRAGE				= "伊利丹·怒风获得了激怒的效果。"

	DBM_ILLIDAN_WARN_SHEAR				= "剪切 -> >%s<"
	DBM_ILLIDAN_WARN_SHADOWFIEND		= "寄生暗影魔 -> >%s<"
	DBM_ILLIDAN_WARN_BARRAGE			= "黑暗壁垒 -> >%s<"
	DBM_ILLIDAN_WARN_BARRAGE_SOON		= "黑暗壁垒 - 即将施放"
	DBM_ILLIDAN_WARN_EYEBEAM			= "魔眼冲击"
	DBM_ILLIDAN_WARN_FLAMES				= "苦痛之焰 -> %s"
	DBM_ILLIDAN_WARN_PHASE2				= "第二阶段"
	DBM_ILLIDAN_WARN_PHASE3				= "第三阶段"
	DBM_ILLIDAN_WARN_PHASE4				= "第四阶段"
	DBM_ILLIDAN_WARN_PHASE_DEMON		= "恶魔形态"
	DBM_ILLIDAN_WARN_FLAMEBURST			= "火焰爆裂 #%s"
	DBM_ILLIDAN_WARN_FLAMEBURST_SOON	= "火焰爆裂 - 即将施放"
	DBM_ILLIDAN_WARN_SHADOWDEMSSOON		= "影魔 - 即将施放"
	DBM_ILLIDAN_WARN_SHADOWDEMS			= "影魔"
	DBM_ILLIDAN_WARN_NORMALPHASE_SOON	= "10秒后变为普通形态"
	DBM_ILLIDAN_WARN_CASTSHEAR			= "剪切 - 正在施放"
	DBM_ILLIDAN_WARN_EYEBEAM_SOON		= "魔眼冲击 - 即将施放"
	DBM_ILLIDAN_WARN_PHASE_NORMAL		= "普通形态"
	DBM_ILLIDAN_WARN_DEMONPHASE_SOON	= "10秒后变为恶魔形态"
	DBM_ILLIDAN_WARN_SHADOWDEMSON		= "影魔 -> %s"
	DBM_ILLIDAN_STATUSMSG_PHASE2		= "第二阶段"
	DBM_ILLIDAN_WARN_PRISON				= "暗影牢笼"
	DBM_ILLIDAN_WARN_P4ENRAGE_SOON		= "5秒后激怒"
	DBM_ILLIDAN_WARN_P4ENRAGE_NOW		= "激怒"
	DBM_ILLIDAN_WARN_CAGED				= "伊利丹进入了陷阱"
	
	DBM_ILLIDAN_SELFWARN_SHADOWFIEND	= "寄生暗影魔"
	DBM_ILLIDAN_SELFWARN_SHADOW			= "苦痛之焰"
	DBM_ILLIDAN_SELFWARN_DEMONS			= "影魔"

	DBM_SBT["Enrage"]				= "激怒";
	DBM_SBT["Illidan Stormrage"]	= "伊利丹·怒风";
	DBM_SBT["Next Dark Barrage"]	= "下一次黑暗壁垒";
	DBM_SBT["Demon Phase"]			= "恶魔形态";
	DBM_SBT["Normal Phase"]			= "普通形态";
	DBM_SBT["Shadow Demons"]		= "影魔";
	DBM_SBT["Next Flame Burst"]		= "下一次火焰爆裂";
	DBM_SBT["Shadow Prison"]		= "暗影牢笼";
	DBM_SBT["Enrage2"]				= "激怒" -- you cannot have two timers with the same id, so the 2nd enrage bar needs a "localization"

	DBM_SBT["Illidan"] = {
		  [1] = {"Shear: (.*)", "剪切 -> %1"},
		  [2] = {"Shadowfiend: (.*)", "寄生暗影魔 -> %1"},
		  [3] = {"Dark Barrage: (.*)", "黑暗壁垒 -> %1"},
		  [4] = {"Flames: (.*)", "苦痛之焰 -> %1"},
	}
	DBM_SBT["伊利丹·怒风"] = DBM_SBT["Illidan"]

end