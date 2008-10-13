if GetLocale() == "esES" then
--Attumen
DBM_ATH_NAME			= "Attumen el Montero";
DBM_ATH_DESCRIPTION		= "Muestra el tiempo para sus maldiciones.";
DBM_ATH_OPTION_1		= "Muestra el Warning de 5 segundos";

DBM_ATH_WARN_CURSE		= "*** Maldicion ***";
DBM_ATH_CURSE_SOON		= "*** Maldicion en %s segundos ***";

DBM_ATH_MIDNIGHT		= "Medianoche";
DBM_ATH_CURSE			= "sufre de Presencia intangible";
DBM_ATH_YELL_1			= "Come Midnight, let's disperse this petty rabble!";


--Moroes
DBM_MOROES_NAME			= "Moroes";
DBM_MOROES_DESCRIPTION	= "Muestra el tiempo del Vanish.";
DBM_MOROES_OPTION_1		= "Muestra un warning cuando haga Vanish";
DBM_MOROES_OPTION_2		= "Muestra un warning cuando se le acabe el Vanish";
DBM_MOROES_OPTION_3		= "Muestra un warning cuando quede poco para el Vanish";
DBM_MOROES_OPTION_4		= "Muestra un Warning cuando haga Garrote";

DBM_MOROES_VANISH_WARN	= "*** Vanish ***";
DBM_MOROES_VANISH_FADED	= "*** Vanish acabado ***";
DBM_MOROES_VANISH_SOON	= "*** Vanish pronto ***";
DBM_MOROES_GARROTE_WARN	= "*** Garrote en >%s< ***";

DBM_MOROES_YELL_START	= "Mm, visitantes inesperados. Hay que hacer preparativos...";
DBM_MOROES_VANISH_GAIN	= "Moroes gana Esfumarse.";
DBM_MOROES_VANISH_FADES	= "Esfumarse desaparece de Moroes.";
DBM_MOROES_GARROTE		= "([^%s]+) (%w+) sufre de Garrote.";



-- Maiden of Virtue
DBM_MOV_NAME			= "Doncella de la Virtud";
DBM_MOV_DESCRIPTION		= "Muestra el tiempo aproximado para el arrepentimiento, un cuadro de test de rango, y los afectados por el fuego sagrado.";
DBM_MOV_OPTION_1		= "Muestra un Cuadro de test de rango";
DBM_MOV_OPTION_2		= "Anunciar Holy Fire";

DBM_MOV_REPENTANCE		= "sufre de Arrepentimiento";
DBM_MOV_WARN_REP		= "*** Arrepentimiento ***";
DBM_MOV_WARN_REP_SOON	= "*** Arrepentimiento pronto ***";

DBM_MOV_DEBUFF_HOLYFIRE	= "([^%s]+) (%w+) sufre de Fuego sagrado.";
DBM_MOV_WARN_HOLYFIRE	= "*** Fuego Sagrado en >%s< ***";



-- Romulo and Julianne
DBM_RJ_NAME				= "Romulo y Julianne";
DBM_RJ_DESCRIPTION		= "Anuncia el bufo de arrojo en Romulo y devocion en Julianne.";
DBM_RJ_OPTION_1			= "Anuncia cuando julianne se esta curando";

DBM_RJ_DARING_WARN		= "*** Romulo tiene arrojo ***";
DBM_RJ_DEVOTION_WARN	= "*** Julianne se ha bufeado Devoción ***";
DBM_RJ_HEAL_WARN		= "*** ¡¡Julianne se esta curando!! ***";

DBM_RJ_ROMULO			= "Romulo";
DBM_RJ_JULIANNE			= "Julianne";
DBM_RJ_GAIN_DARING		= "Romulo gana Arrojo.";
DBM_RJ_GAIN_DEVOTION 	        = "Julianne gana Devoción.";
DBM_RJ_CAST_HEAL		= "Julianne comienza a lanzar Afección eterna.";
DBM_RJ_PHASE2_YELL		= "¡Ven, dulce noche; y devuélveme a mi Romulo!";

-- Big Bad Wolf
DBM_BBW_NAME			= "The Big Bad Wolf";
DBM_BBW_DESCRIPTION		= "Announces and shows a timer for \"Little Red Riding Hood\".";
DBM_BBW_OPTION_1		= "Announce fear";

DBM_BBW_YELL_1			= "The better to own you with!";
DBM_BBW_GAIN_DEBUFF		= "(.+) gana Caperucita roja.";
DBM_BBW_YOU_GAIN		= "ganas Caperucita roja."
DBM_BBW_FEAR_EXP		= "Aullido aterrador";

DBM_BBW_FEAR_WARN		= "*** Fear ***";
DBM_BBW_FEAR_SOON		= "*** Fear pronto ***";
DBM_BBW_RRH_WARN		= "*** >%s< es Caperucita Roja ***";
DBM_BBW_RUN_AWAY		= "¡Corre!";
DBM_BBW_RUN_AWAY_WHISP	= "¡Eres Caperucita Roja! ¡Corre!";

-- Curator
DBM_CURA_NAME			= "Curator";
DBM_CURA_DESCRIPTION	= "Shows a timer for his evocation.";

DBM_CURA_YELL_PULL		= "La Galeria es solo para los invitados.";
DBM_CURA_YELL_OOM		= "No se puede procesar tu solicitud.";

DBM_CURA_EVO_NOW		= "*** Evocacion ***";
DBM_CURA_EVO_SOON		= "*** Evocacion pronto ***";

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

DBM_NS_CAST_MODE_SWAP	= "Netherspite casts Mode Swap.";
DBM_NS_CAST_VOID_ZONE	= "Netherspite casts Void Zone.";
DBM_NS_CAST_BREATH		= "Netherspite begins to cast Netherbreath.";
DBM_NS_EMOTE_PHASE_2	= "%s goes into a nether-fed rage!";
DBM_NS_EMOTE_PHASE_1	= "%s cries out in withdrawal, opening gates to the nether.";

DBM_NS_WARN_PORTAL		= "*** Portal phase ***";
DBM_NS_WARN_BANISH		= "*** Banish phase ***";
DBM_NS_WARN_PORTAL_SOON	= "*** Portal phase in 5 sec ***";
DBM_NS_WARN_BANISH_SOON	= "*** Banish phase in 5 sec ***";
DBM_NS_WARN_BREATH		= "*** Netherbreath ***";
DBM_NS_WARN_VOID_ZONE	= "*** Void Zone ***";


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
DBM_PRINCE_YELL_INF2	= "You face not Malchezzar alone, but the legions I command!";
DBM_PRINCE_SWP			= "([^%s]+) (%w+) afflicted by Shadow Word: Pain";
DBM_PRINCE_ENFEEBLE		= "([^%s]+) (%w+) afflicted by Enfeeble.";
DBM_PRINCE_CAST_NOVA	= "Prince Malchezaar begins to cast Shadow Nova.";
DBM_PRINCE_INF_SPAWN	= "Infernal gains Hellfire";


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

DBM_NB_EMOTE_PULL		= "An ancient being awakens in the distance...";
DBM_NB_YELL_PULL		= "What fools! I shall bring a quick end to your suffering!";
DBM_NB_YELL_AIR			= "Miserable vermin. I shall exterminate you from the air!";
DBM_NB_YELL_GROUND		= "Enough! I shall land and crush you myself!";
DBM_NB_YELL_GROUND2		= "Insects! Let me show you my strength up close!";
DBM_NB_CAST_FEAR		= "Nightbane begins to cast Bellowing Roar.";
DBM_NB_EARTH_YOU		= "You are afflicted by Charred Earth.";
DBM_NB_CAST_BONES		= "([^%s]+) (%w+) afflicted by Rain of Bones%.";
DBM_NB_CAST_ASH			= "([^%s]+) (%w+) afflicted by Distracting Ash.";
DBM_NB_CAST_SMOKE		= "([^%s]+) (%w+) afflicted by Searing Cinders%.";

DBM_NB_FEAR_WARN		= "*** Fear ***";
DBM_NB_AIR_WARN			= "*** Air Phase ***";
DBM_NB_EARTH_WARN		= "Charred Earth";
DBM_NB_SMOKE_SPECWARN	= "Smoking Blast";
DBM_NB_BONES_WARN		= "*** Rain of Bones ***";
DBM_NB_ASH_WARN			= "*** Distracting Ash on >%s< ***";
DBM_NB_SMOKE_WARN		= "*** Smoking Blast on >%s< ***";	

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
DBM_OZ_SUMMON_TITO		= "Dorothee begins to cast Summon Tito.";

DBM_OZ_WARN_TITO		= "*** Tito ***";
DBM_OZ_WARN_ROAR		= "*** Roar ***";
DBM_OZ_WARN_STRAWMAN	= "*** Strawman ***";
DBM_OZ_WARN_TINHEAD		= "*** Tinhead ***";
DBM_OZ_WARN_CRONE		= "*** The Crone ***";

-- Named Beasts
DBM_SHAD_NAME			= "Shadikith the Glider";
DBM_HYA_NAME			= "Hyakiss the Lurker";
DBM_ROKAD_NAME			= "Rokad the Ravager";
end