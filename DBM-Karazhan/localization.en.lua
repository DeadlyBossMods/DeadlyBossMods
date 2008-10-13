-- DBM_Karazhan _must_ be nil if the client language is not support - a default (=english) value will cause errors
if GetLocale() == "enGB" or GetLocale() == "enUS" then
	DBM_KARAZHAN		= "Karazhan";
end

DBM_KARAZHAN_TAB	= "Karazhan";

--Attumen
DBM_ATH_NAME			= "Attumen the Huntsman";
DBM_ATH_DESCRIPTION		= "Shows a timer for his curse.";
DBM_ATH_OPTION_1		= "Show 5 second warning";

DBM_ATH_WARN_CURSE		= "*** Curse ***";
DBM_ATH_CURSE_SOON		= "*** Curse soon ***";

DBM_ATH_MIDNIGHT		= "Midnight";
DBM_ATH_YELL_1			= "Come Midnight, let's disperse this petty rabble!";


--Moroes
DBM_MOROES_NAME			= "Moroes";
DBM_MOROES_DESCRIPTION	= "Shows a timer for his vanish.";
DBM_MOROES_OPTION_1		= "Show vanish warning";
DBM_MOROES_OPTION_2		= "Show vanish fade warning";
DBM_MOROES_OPTION_3		= "Show vanish soon warning";
DBM_MOROES_OPTION_4		= "Show garrote warning";

DBM_MOROES_VANISH_WARN	= "*** Vanish ***";
DBM_MOROES_VANISH_FADED	= "*** Vanish faded ***";
DBM_MOROES_VANISH_SOON	= "*** Vanish in 5 sec ***";
DBM_MOROES_GARROTE_WARN	= "*** Garrote on >%s< ***";

DBM_MOROES_YELL_START	= "Hm, unannounced visitors. Preparations must be made...";




-- Maiden of Virtue
DBM_MOV_NAME			= "Maiden of Virtue";
DBM_MOV_DESCRIPTION		= "Provides a timer for Repentance, shows a warning for Holy Fire and shows the range check frame.";
DBM_MOV_OPTION_1		= "Show range check frame";
DBM_MOV_OPTION_2		= "Announce Holy Fire";

DBM_MOV_YELL_PULL		= "Your behavior will not be tolerated.";
DBM_MOV_YELL_REP_1		= "Cast out your corrupt thoughts.";
DBM_MOV_YELL_REP_2		= "Your impurity must be cleansed.";
DBM_MOV_WARN_REP		= "*** Repentance ***";
DBM_MOV_WARN_REP_SOON	= "*** Repentance soon ***";

DBM_MOV_WARN_HOLYFIRE	= "*** Holy Fire on >%s< ***";



-- Romulo and Julianne
DBM_RJ_NAME				= "Romulo and Julianne";
DBM_RJ_DESCRIPTION		= "Announces Romulo's Daring and Julianne's Devotion.";
DBM_RJ_OPTION_1			= "Announce Julianne's heal";
DBM_RJ_OPTION_2			= "Announce Poisoned Thrust";

DBM_RJ_DARING_WARN		= "*** Romulo gains Daring ***";
DBM_RJ_DEVOTION_WARN	= "*** Julianne gains Devotion ***";
DBM_RJ_HEAL_WARN		= "*** Heal ***";
DBM_RJ_POISON_WARN		= "Poisoned Thrust on >%s<";

DBM_RJ_ROMULO			= "Romulo";
DBM_RJ_JULIANNE			= "Julianne";
DBM_RJ_PHASE2_YELL		= "Come, gentle night; and give me back my Romulo!";


-- Big Bad Wolf
DBM_BBW_NAME			= "The Big Bad Wolf";
DBM_BBW_DESCRIPTION		= "Announces and shows a timer for \"Little Red Riding Hood\".";
DBM_BBW_OPTION_1		= "Announce fear";
DBM_BBW_OPTION_2		= "Send whisper";

DBM_BBW_YELL_1			= "The better to own you with!";
DBM_BBW_FEAR_EXP		= "Terrifying Howl";

DBM_BBW_FEAR_WARN		= "*** Fear ***";
DBM_BBW_FEAR_SOON		= "*** Fear soon ***";
DBM_BBW_RRH_WARN		= "*** >%s< is Little Red Riding Hood ***";
DBM_BBW_RUN_AWAY		= "Run away!";
DBM_BBW_RUN_AWAY_WHISP	= "You are Little Red Riding Hood! Run away!";
DBM_BBW_RRH_SOON_WARN	= "*** Red Riding Hood soon ***";

-- Curator
DBM_CURA_NAME			= "The Curator";
DBM_CURA_DESCRIPTION	= "Shows a timer for his evocation.";

DBM_CURA_YELL_PULL		= "The Menagerie is for guests only.";
DBM_CURA_YELL_OOM		= "Your request cannot be processed.";

DBM_CURA_EVO_NOW		= "*** Evocation ***";
DBM_CURA_EVO_SOON		= "*** Evocation soon ***";
DBM_CURA_EVO_1MIN		= "Evocation in 1 min"

-- Terestian Illhoof
DBM_TI_NAME				= "Terestian Illhoof";
DBM_TI_DESCRIPTION		= "Announces Demonic Chains and weakened phases.";
DBM_TI_OPTION_1			= "Announce imp respawn";

DBM_TI_YELL_PULL		= "Ah, you're just in time. The rituals are about to begin!";
DBM_TI_SACRIFICE		= "([^%s]+) (%w+) afflicted by Sacrifice%.";
DBM_TI_EMOTE_IMP		= "%s shrieks in pain and points at his master.";
DBM_TI_CAST_IMP			= "Terestian Illhoof casts Summon Imp.";

DBM_TI_SACRIFICE_WARN	= "*** >%s< is being sacrificed ***";
DBM_TI_SACRIFICE_SOON	= "*** Sacrifice soon ***";
DBM_TI_WEAKENED_WARN	= "*** Weakened ***";
DBM_TI_IMP_SOON			= "*** Imp respawn soon ***";
DBM_TI_IMP_RESPAWNED	= "*** Imp respawned ***";


-- Shade of Aran
DBM_ARAN_NAME			= "Shade of Aran";
DBM_ARAN_DESCRIPTION	= "Announces Flame Wreath and Arcane Explosion.";

DBM_ARAN_CAST_WREATH	= "Shade of Aran begins to cast Flame Wreath.";
DBM_ARAN_CAST_AE		= "Shade of Aran begins to cast Arcane Explosion.";
DBM_ARAN_CAST_BLIZZ		= "Shade of Aran begins to cast Summon Blizzard.";
DBM_ARAN_YELL_ADDS		= "I'm not finished yet! No, I have a few more tricks up my sleeve...";
DBM_ARAN_YELL_BLIZZ1	= "Back to the cold dark with you!";
DBM_ARAN_YELL_BLIZZ2	= "I'll freeze you all!";

DBM_ARAN_WREATH_WARN	= "*** Flame Wreath in 5 seconds ***";
DBM_ARAN_AE_WARN		= "*** Arcane Explosion ***";
DBM_ARAN_BLIZZ_WARN		= "*** Blizzard ***";
DBM_ARAN_ADDS_WARN		= "*** Elementals ***";
DBM_ARAN_DO_NOT_MOVE	= "Do not move!";

--Netherspite
DBM_NS_NAME				= "Netherspite";
DBM_NS_DESCRIPTION		= "Shows timers for his phases and announces Netherbreath and Void Zones.";
DBM_NS_OPTION_1			= "Announce phases";
DBM_NS_OPTION_2			= "Show 5 second warning for phases";
DBM_NS_OPTION_3			= "Announce Void Zones";
DBM_NS_OPTION_4			= "Announce Netherbreath";

DBM_NS_EMOTE_PHASE_2	= "%s goes into a nether-fed rage!";
DBM_NS_EMOTE_PHASE_1	= "%s cries out in withdrawal, opening gates to the nether.";

DBM_NS_WARN_PORTAL		= "*** Portal phase ***";
DBM_NS_WARN_BANISH		= "*** Banish phase ***";
DBM_NS_WARN_PORTAL_SOON	= "*** Portal phase in 5 sec ***";
DBM_NS_WARN_BANISH_SOON	= "*** Banish phase in 5 sec ***";
DBM_NS_WARN_BREATH		= "*** Netherbreath ***";
DBM_NS_WARN_VOID_ZONE	= "*** Void Zone ***";
DBM_NS_WARN_ENRAGE		= "*** Enrage in %s %s ***";

--Prince Malchezaar
DBM_PRINCE_NAME			= "Prince Malchezaar"
DBM_PRINCE_DESCRIPTION	= "Announces Infernals, Enfeeble, Shadow Word: Pain and Shadow Nova.";
DBM_PRINCE_OPTION_1		= "Announce Shadow Nova";
DBM_PRINCE_OPTION_2		= "Announce Enfeeble";
DBM_PRINCE_OPTION_3		= "Send whisper";
DBM_PRINCE_OPTION_4		= "Announce Shadow Word: Pain";
DBM_PRINCE_OPTION_5		= "Announce Infernal";

DBM_PRINCE_YELL_PULL	= "Madness has brought you here to me. I shall be your undoing!";
DBM_PRINCE_YELL_P2		= "Simple fools! Time is the fire in which you'll burn!";
DBM_PRINCE_YELL_P3		= "How can you hope to stand against such overwhelming power?";
DBM_PRINCE_YELL_INF1	= "All realities, all dimensions are open to me!";
DBM_PRINCE_YELL_INF2	= "You face not Malchezaar alone, but the legions I command!";

DBM_PRINCE_WARN_NOVA		= "*** Shadow Nova in 2 sec ***";
DBM_PRINCE_WARN_ENFEEBLE	= "*** Enfeeble ***";
DBM_PRINCE_WHISP_ENFEEBLE	= "You are afflicted by Enfeeble!";
DBM_PRINCE_WARN_SWP			= "*** Shadow Word: Pain on >%s< ***";
DBM_PRINCE_WARN_INF			= "*** Infernal #%s ***";
DBM_PRINCE_WARN_INF_SOON	= "*** Infernal #%s soon ***"
DBM_PRINCE_WARN_PHASE		= "*** Phase %s ***";

-- Nightbane
DBM_NB_NAME				= "Nightbane";
DBM_NB_DESCRIPTION		= "Announces Fear, Charred Earth, Distracting Ash, Rain of Bones, Smoking Blast and his air phases.";
DBM_NB_OPTION_1			= "Show special warning for Charred Earth";
DBM_NB_OPTION_2			= "Announce Distracting Ash on ranged dps/healers";
DBM_NB_OPTION_3			= "Announce Rain of Bones";
DBM_NB_OPTION_4			= "Announce Smoking Blast";
DBM_NB_OPTION_5			= "Show Special Warning when Nightbane casts Smoking Blast on you";
DBM_NB_OPTION_ICON		= "Set icon (skull) on Rain of Bones target";

DBM_NB_EMOTE_PULL		= "An ancient being awakens in the distance...";
DBM_NB_YELL_PULL		= "What fools! I shall bring a quick end to your suffering!";
DBM_NB_YELL_AIR			= "Miserable vermin. I shall exterminate you from the air!";
DBM_NB_YELL_GROUND		= "Enough! I shall land and crush you myself!";
DBM_NB_YELL_GROUND2		= "Insects! Let me show you my strength up close!";

DBM_NB_FEAR_WARN		= "*** Fear ***";
DBM_NB_FEAR_SOON_WARN	= "*** Fear soon ***";
DBM_NB_AIR_WARN			= "*** Air Phase ***";
DBM_NB_EARTH_WARN		= "Charred Earth";
DBM_NB_SMOKE_SPECWARN	= "Smoking Blast";
DBM_NB_BONES_WARN		= "*** Rain of Bones ***";
DBM_NB_ASH_WARN			= "*** Distracting Ash on >%s< ***";
DBM_NB_SMOKE_WARN		= "*** Smoking Blast on >%s< ***";
DBM_NB_DOWN_WARN 		= "*** Ground Phase in 15 sec ***";
DBM_NB_DOWN_WARN2 		= "*** Ground Phase in 5 sec ***";

-- Wizard of Oz
DBM_OZ_NAME				= "Wizard of Oz";
DBM_OZ_DESCRIPTION		= "Announces the spawn of Roar, Strawman, Tinhead and The Crone.";
DBM_OZ_OPTION_1			= "Show range check frame in phase 2";

DBM_OZ_CRONE_NAME		= "The Crone";
DBM_OZ_YELL_DOROTHEE	= "Oh Tito, we simply must find a way home! The old wizard could be our only hope! Strawman, Roar, Tinhead, will you - wait... oh golly, look we have visitors!";
DBM_OZ_YELL_ROAR		= "I'm not afraid a' you! Do you wanna' fight? Huh, do ya'? C'mon! I'll fight ya' with both paws behind my back!";
DBM_OZ_YELL_STRAWMAN	= "Now what should I do with you? I simply can't make up my mind.";
DBM_OZ_YELL_TINHEAD		= "I could really use a heart. Say, can I have yours?";
DBM_OZ_YELL_TITO		= "Don't let them hurt us Tito! Oh, you won't, will you?";
DBM_OZ_YELL_CRONE		= "Woe to each and every one of you, my pretties!";

DBM_OZ_WARN_TITO		= "*** Tito ***";
DBM_OZ_WARN_ROAR		= "*** Roar ***";
DBM_OZ_WARN_STRAWMAN	= "*** Strawman ***";
DBM_OZ_WARN_TINHEAD		= "*** Tinhead ***";
DBM_OZ_WARN_CRONE		= "*** The Crone ***";

-- Named Beasts
DBM_SHAD_NAME			= "Shadikith the Glider";
DBM_HYA_NAME			= "Hyakiss the Lurker";
DBM_ROKAD_NAME			= "Rokad the Ravager";
