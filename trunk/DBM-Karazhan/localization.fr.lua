if ( GetLocale() == "frFR" ) then
	--Attumen
	DBM_ATH_NAME			= "Attumen le Veneur";
	DBM_ATH_DESCRIPTION		= "Affiche un timer pour sa malédiction.";
	DBM_ATH_OPTION_1		= "Affiche un avertissement 5 sec avant la malédiction.";
	
	DBM_ATH_WARN_CURSE		= "*** Malédiction ***";
	DBM_ATH_CURSE_SOON		= "*** Malédiction dans %s sec ***";
	
	DBM_ATH_MIDNIGHT		= "Minuit";
	DBM_ATH_CURSE			= "subit les effets %w+ Présence immatérielle";
	DBM_ATH_YELL_1			= "Viens, Minuit, allons disperser cette insignifiante racaille !";

	DBM_SBT["Curse"]		= "Malédiction";

	--Moroes
	DBM_MOROES_NAME			= "Moroes";
	DBM_MOROES_DESCRIPTION		= "Affiche un timer pour sa disparition.";
	DBM_MOROES_OPTION_1		= "Affiche un avertissement pour sa disparition";
	DBM_MOROES_OPTION_2		= "Affiche un avertissement pour son retour";
	DBM_MOROES_OPTION_3		= "Affiche un avertissement pour sa disparition imminente";
	DBM_MOROES_OPTION_4		= "Affiche un avertissement pour le Garrot";
	
	DBM_MOROES_VANISH_WARN	= "*** Disparition ***";
	DBM_MOROES_VANISH_FADED	= "*** Retour de Moroes ***";
	DBM_MOROES_VANISH_SOON	= "*** Disparition imminente ***";
	DBM_MOROES_GARROTE_WARN	= "*** Garrot sur >%s< ***";
	
	DBM_MOROES_YELL_START	= "Hum. Des visiteurs imprévus. Il va falloir se préparer.";
	DBM_MOROES_VANISH_GAIN	= "Moroes gagne Disparition.";
	DBM_MOROES_VANISH_FADES	= "Disparition sur Moroes vient de se dissiper.";
	DBM_MOROES_GARROTE		= "([^%s]+) (%w+) les effets %w+ Garrot.";
	
	DBM_SBT["Vanish"]		= "Disparition";

	-- Maiden of Virtue
	DBM_MOV_NAME			= "Damoiselle de vertu";
	DBM_MOV_DESCRIPTION		= "Affiche une estimation de temps du Repentir, Alerte des Flammes sacrées et affiche la fenêtre de contrôle de distance";
	DBM_MOV_OPTION_1		= "Affiche la fenêtre de contrôle de distance";
	DBM_MOV_OPTION_2		= "Alerte Flammes sacrées";
	
	DBM_MOV_REPENTANCE		= "subit les effets %w+ Repentir";
	DBM_MOV_WARN_REP		= "*** Repentir ***";
	DBM_MOV_WARN_REP_SOON		= "*** Repentir imminent ***";
	
	DBM_MOV_DEBUFF_HOLYFIRE	= "([^%s]+) (%w+) les effets %w+ Flammes sacrées.";
	DBM_MOV_WARN_HOLYFIRE	= "*** Flammes sacrées sur >%s< ***";


	-- Romulo and Julianne
	DBM_RJ_NAME			= "Romulo et Julianne";
	DBM_RJ_DESCRIPTION		= "Annonces des buff Hardiesse de Romulo et Dévotion de Julianne";
	DBM_RJ_OPTION_1			= "Annonce du soin de Julianne";
	
	DBM_RJ_DARING_WARN		= "*** Romulo gagne Hardiesse ! ***";
	DBM_RJ_DEVOTION_WARN		= "*** Julianne gagne Dévotion ! ***";
	DBM_RJ_HEAL_WARN		= "*** Soin ***";
	
	DBM_RJ_ROMULO			= "Romulo";
	DBM_RJ_JULIANNE			= "Julianne";
	DBM_RJ_GAIN_DARING		= "Romulo gagne Hardiesse.";
	DBM_RJ_GAIN_DEVOTION 		= "Julianne gagne Dévotion.";
	DBM_RJ_CAST_HEAL		= "Julianne commence à lancer Amour éternel.";
	DBM_RJ_PHASE2_YELL		= "Viens, gentille nuit ; rends-moi mon Romulo !";
	DBM_SBT["Heal"]			= "Soin";
	
	-- Big Bad Wolf
	DBM_BBW_NAME			= "Le grand méchant Loup";
	DBM_BBW_DESCRIPTION		= "Annonce et affiche un timer pour le petit chaperon rouge";
	DBM_BBW_OPTION_1		= "Annonce de la peur";
	
	DBM_BBW_YELL_1			= "The better to own you with!";
	DBM_BBW_GAIN_DEBUFF		= "(.+) gagne le Chaperon Rouge.";
	DBM_BBW_YOU_GAIN		= "Tu gagnes le Chaperon Rouge."
	DBM_BBW_FEAR_EXP		= "Terrifying Howl";
	
	DBM_BBW_FEAR_WARN		= "*** Peur ***";
	DBM_BBW_FEAR_SOON		= "*** Peur imminante ***";
	DBM_BBW_RRH_WARN		= "*** %s est le petit Chaperon Rouge ***";
	DBM_BBW_RUN_AWAY		= "Court!";
	DBM_BBW_RUN_AWAY_WHISP	= "Tu es le petit Chaperon Rouge ! Court !";
	
	DBM_SBT["Red Riding Hood"]	= "Petit Chaperon Rouge";
	DBM_SBT["Next Red Riding Hood"]	= "Prochain Petit Chaperon Rouge";
	
	-- Curator
	DBM_CURA_NAME			= "Le conservateur";
	DBM_CURA_DESCRIPTION		= "Affiche un timer pour son Evocation.";
	
	DBM_CURA_YELL_PULL		= "L'accès à la Ménagerie est réservé aux invités.";
	DBM_CURA_YELL_OOM		= "Impossible de traiter votre requête.";
	
	DBM_CURA_EVO_NOW		= "*** Evocation ***";
	DBM_CURA_EVO_SOON		= "*** Evocation imminente ***";
	
	DBM_SBT["Evocation"]		= "Evocation";
	DBM_SBT["Next Evocation"]	= "Prochaine Evocation";

	---- Terestian Malsabot
	DBM_TI_NAME				= "Terestian Malsabot";
	DBM_TI_DESCRIPTION		= "Annonce les cha\195\174nes d\195\169moniaques et la phase affaibli.";
	DBM_TI_OPTION_1			= "Annonce le repop du Diablotin";

	DBM_TI_YELL_PULL		= "Ah, vous arrivez juste \195\160 temps. Les rituels vont commencer.";
	DBM_TI_SACRIFICE		= "([^%s]+) (%w+) les effets .* Sacrifice";
	DDBM_TI_EMOTE_IMP		= "%s shrieks in pain and points at his master.";
	DBM_TI_CAST_IMP			= "Terestian Illhoof casts Summon Imp.";

	DBM_TI_SACRIFICE_WARN	= "*** >%s< est sacrifi\195\169! ***";
	DBM_TI_SACRIFICE_SOON	= "*** Sacrifice bient\195\180t ***";
	DBM_TI_WEAKENED_WARN	= "*** Affaibli ***";
	DBM_TI_IMP_SOON			= "*** Diablotin Repop Bient\195\180t ***";
	DBM_TI_IMP_RESPAWNED	= "*** Diablotin Repop ***";
	
	DBM_SBT["Weakened"]		= "Affaibli";
	DBM_SBT["Sacrifice"]	= "Sacrifice";

	-- Ombre d'Aran
	DBM_ARAN_NAME			= "Ombre d'Aran";
	DBM_ARAN_DESCRIPTION	= "Annonces la Couronne de flammes, le Blizzard et l'Explosion des arcanes.";

	DBM_ARAN_CAST_WREATH	= "Ombre d'Aran commence \195\160 lancer Couronne de flammes.";
	DBM_ARAN_CAST_AE		= "Ombre d'Aran commence \195\160 lancer Explosion des arcanes.";
	DBM_ARAN_CAST_BLIZZ		= "Ombre d'Aran commence \195\160 lancer Blizzard.";
	DBM_ARAN_YELL_ADDS		= "Je ne suis pas encore vaincu\194\160! Non, j\226\128\153ai encore quelques tours dans mon sac\226\128\166";
	DBM_ARAN_YELL_BLIZZ1	= "Retournez dans les t\195\169n\195\168bres glaciales\194\160!";
	DBM_ARAN_YELL_BLIZZ2	= "Je vais tous vous congeler\194\160!";

	DBM_ARAN_WREATH_WARN	= "*** Couronne de flammes dans 5 secondes ***";
	DBM_ARAN_AE_WARN		= "*** Explosion des Arcanes ***";
	DBM_ARAN_BLIZZ_WARN		= "*** Blizzard ***";
	DBM_ARAN_ADDS_WARN		= "*** El\195\169mentaires ***";
	DBM_ARAN_DO_NOT_MOVE	= "Ne bougez plus!";
	
	DBM_SBT["Flame Wreath Cast"]	= "cast Couronne de flammes";
	DBM_SBT["Flame Wreath"]			= "Couronne de flammes";
	DBM_SBT["Arcane Explosion"]		= "Explosion des arcanes";
	DBM_SBT["Blizzard"]				= "Blizzard";
	DBM_SBT["Elementals despawn in"]	= "El\195\169mentaires d\195\169pop dans";
	
	--Dédain-du-Néant
	DBM_NS_NAME				= "D\195\169dain-du-N\195\169ant";
	DBM_NS_DESCRIPTION		= "Montre un timer pour ses phases et annonce les Souffles de N\195\169ant et les Zones de vide.";
	DBM_NS_OPTION_1			= "Annonce les phases";
	DBM_NS_OPTION_2			= "Alertes 5 secondes pour les phases";
	DBM_NS_OPTION_3			= "Annonce Zone de vide";
	DBM_NS_OPTION_4			= "Annonce Souffle de N\195\169ant";

	DBM_NS_CAST_MODE_SWAP	= "D\195\169dain-du-N\195\169ant lance Affronter une cible al\195\169atoire.";
	DBM_NS_CAST_VOID_ZONE	= "D\195\169dain-du-N\195\169ant lance Zone de vide.";
	DBM_NS_CAST_BREATH		= "D\195\169dain-du-N\195\169ant commence \195\160 lancer Souffle de N\195\169ant.";
	DBM_NS_EMOTE_PHASE_2	= "%s entre dans une rage nourrie par le N\195\169ant\194\160!";
	DBM_NS_EMOTE_PHASE_1	= "%s se retire avec un cri en ouvrant un portail vers le N\195\169ant.";

	DBM_NS_WARN_PORTAL		= "*** Phase Portail ***";
	DBM_NS_WARN_BANISH		= "*** Phase Bannir ***";
	DBM_NS_WARN_PORTAL_SOON	= "*** Phase Portail dans 5 sec ***";
	DBM_NS_WARN_BANISH_SOON	= "*** Phase Bannir dans 5 sec ***";
	DBM_NS_WARN_BREATH		= "*** Souffle de N\195\169ant ***";
	DBM_NS_WARN_VOID_ZONE	= "*** Zone de vide ***";
	
	DBM_SBT["Portal Phase"]	= "Phase Portail";
	DBM_SBT["Banish Phase"]	= "Phase Bannir";
	DBM_SBT["Netherbreath"]	= "Souffle de N\195\169ant";
	
	--Prince Malchezaar
	DBM_PRINCE_NAME			= "Prince Malchezaar"
	DBM_PRINCE_DESCRIPTION	= "Annonce les Infernaux, affaiblir, Mot de l'ombre : Douleur et la Nova de l'ombre.";
	DBM_PRINCE_OPTION_1		= "Annonce Nova de l'ombre";
	DBM_PRINCE_OPTION_2		= "Annonce affaiblir";
	DBM_PRINCE_OPTION_3		= "Envoi un whisp";
	DBM_PRINCE_OPTION_4		= "Annonce Mot de l'ombre : Douleur";
	DBM_PRINCE_OPTION_5		= "Annonce Infernal";

	DBM_PRINCE_YELL_PULL	= "La folie vous a fait venir ici, devant moi. Et je serai votre perte !";
	DBM_PRINCE_YELL_P2		= "Imb\195\169ciles heureux ! Le temps est le brasier dans lequel vous br\195\187lerez !";
	DBM_PRINCE_YELL_P3		= "Comment pouvez-vous esp\195\169rer r\195\169sister devant un tel pouvoir ?";
	DBM_PRINCE_YELL_INF1	= "Toutes les r\195\169alit\195\169s, toutes les dimensions me sont ouvertes !";
	DBM_PRINCE_YELL_INF2	= "Vous n'affrontez pas seulement Malchezzar, mais les l\195\169gions que je commande !";
	DBM_PRINCE_SWP			= "([^%s]+) (%w+) subit les effets DE Mot de l'ombre : Douleur";
	DBM_PRINCE_ENFEEBLE		= "([^%s]+) (%w+) subit les effets DE Affaiblir";
	DBM_PRINCE_CAST_NOVA	= "Prince Malchezaar commence \195\160 lancer Nova de l'ombre.";
	DBM_PRINCE_INF_SPAWN	= "Infernal de D\195\169dain-du-N\195\169ant lance Flammes infernales.";


	DBM_PRINCE_WARN_NOVA		= "*** Nova de l'ombre dans 2 sec ***";
	DBM_PRINCE_WARN_ENFEEBLE	= "*** affaiblir ***";
	DBM_PRINCE_WHISP_ENFEEBLE	= "Tu a affaiblir!";
	DBM_PRINCE_WARN_SWP			= "*** Mot de l'ombre : Douleur sur >%s< ***";
	DBM_PRINCE_WARN_INF			= "*** Infernal #%s ***";
	DBM_PRINCE_WARN_INF_SOON	= "*** Infernal #%s bient\195\180t ***"
	DBM_PRINCE_WARN_PHASE		= "*** Phase %s ***";
	
	--Wizard of Oz
	DBM_OZ_NAME			= "Le magicien d'Oz";
	DBM_OZ_DESCRIPTION		= "Annonce les activations de Graou, Homme de paille, Tête de fer-blanc et de la Mégère.";
	DBM_OZ_OPTION_1			= "Affiche la fenêtre de contrôle de distance en phase 2";
	
	DBM_OZ_CRONE_NAME		= "La Mégère";
	DBM_OZ_YELL_DOROTHEE		= "Oh, Tito, nous devons trouver le moyen de rentrer à la maison ! Le vieux sorcier est notre dernier espoir ! Homme de paille, Graou, Tête de fer-blanc, vous voulez bien… Attendez… Oh, regardez, nous avons des visiteurs !";
	DBM_OZ_YELL_ROAR		= "J'ai peur d'personne ! Tu veux t'battre ! Hein, tu veux ? Vas-y ! Je te prends avec les deux pattes attachées dans l'dos !";
	DBM_OZ_YELL_STRAWMAN		= "Alors que vais-je faire de vous ? Je n'arrive tout simplement pas à me décider.";
	DBM_OZ_YELL_TINHEAD		= "J'aurais bien besoin d'un cœur. Dites, vous me donnez le vôtre ?";
	DBM_OZ_YELL_TITO		= "Ne les laisse pas nous faire du mal, Tito ! Oh, tu ne le feras pas, hein ?";
	DBM_OZ_YELL_CRONE		= "Malheur à chacun d’entre vous, mes mignons !";
	DBM_OZ_SUMMON_TITO		= "Dorothée commence à lancer Invocation de Tito.";
	
	DBM_OZ_WARN_TITO		= "*** Tito ***";
	DBM_OZ_WARN_ROAR		= "*** Graou ***";
	DBM_OZ_WARN_STRAWMAN		= "*** Homme de paille ***";
	DBM_OZ_WARN_TINHEAD		= "*** Tête de fer-blanc ***";
	DBM_OZ_WARN_CRONE		= "*** La Mégère ***";
	
	-- Plaie-de-nuit
	DBM_NB_NAME				= "Plaie-de-nuit";
	DBM_NB_DESCRIPTION		= "Announces Fear, Charred Earth, Distracting Ash, Rain of Bones, Smoking Blast and his air phases.";
	DBM_NB_OPTION_1			= "Show special warning for Charred Earth";
	DBM_NB_OPTION_2			= "Announce Distracting Ash on ranged dps/healers";
	DBM_NB_OPTION_3			= "Announce Rain of Bones";
	DBM_NB_OPTION_4			= "Announce Smoking Blast";
	DBM_NB_OPTION_5			= "Show Special Warning when Nightbane casts Smoking Blast on you";

	DBM_NB_EMOTE_PULL		= "Dans le lointain, un \195\170tre ancien s'\195\169veille...";
	DBM_NB_YELL_PULL		= "Fous ! Je vais mettre un terme \195\160 vos souffrances !";
	DBM_NB_YELL_AIR			= "Mis\195\169rable vermine. Je vais vous exterminer des airs !";
	DBM_NB_YELL_GROUND		= "Assez ! Je vais atterir et vous !";
	DBM_NB_YELL_GROUND2		= "Insectes ! Je vais vous montrer de quel bois je me chauffe !";
	DBM_NB_CAST_FEAR		= "Plaie-de-nuit commence \195\160 lancer Rugissement puissant.";
	DBM_NB_EARTH_YOU		= "Vous subissez les effets de Terre calcin\195\169e.";
	DBM_NB_CAST_BONES		= "([^%s]+) (%w+) subit les effets de Pluis d'os.";
	DBM_NB_CAST_ASH			= "([^%s]+) (%w+) subit les effets Cendre de diversion.";
	DBM_NB_CAST_SMOKE		= "([^%s]+) (%w+) subit les effets Cendre de diversion%.";

	DBM_NB_FEAR_WARN		= "*** Fear ***";
	DBM_NB_AIR_WARN			= "*** Air Phase ***";
	DBM_NB_EARTH_WARN		= "Charred Earth";
	DBM_NB_SMOKE_SPECWARN	= "Smoking Blast";
	DBM_NB_BONES_WARN		= "*** Rain of Bones ***";
	DBM_NB_ASH_WARN			= "*** Distracting Ash on >%s< ***";
	DBM_NB_SMOKE_WARN		= "*** Smoking Blast on >%s< ***";	
	
		
	-- Named Beasts
	DBM_SHAD_NAME			= "Shadikith le Glisseur";
	DBM_HYA_NAME			= "Hyakiss la R\195\180deuse";
	DBM_ROKAD_NAME			= "Rokad le Ravageur";
end