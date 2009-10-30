if GetLocale() ~= "frFR" then return end

local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name = "Anub'Rekhan"
})

L:SetWarningLocalization({
	SpecialLocust		= "Nuée de sauterelles!",
	WarningLocustSoon	= "Nuée de sauterelles dans 15 sec",
	WarningLocustNow	= "Nuée de sauterelles!",
	WarningLocustFaded	= "Fin de la nuée de sauterelles"
})

L:SetTimerLocalization({
	TimerLocustIn	= "Nuée de sauterelles",
	TimerLocustFade = "Nuée de sauterelles active"
})

L:SetOptionLocalization({
	SpecialLocust		= "Activer l'avertissement special pour la Nuée de sauterelles",
	WarningLocustSoon	= "Activer le pré-avertissement pour la Nuée de sauterelles",
	WarningLocustNow	= "Activer l'avertissement pour la Nuée de sauterelles",
	WarningLocustFaded	= "Avertir à la fin de la Nuée de sauterelles",
	TimerLocustIn		= "Afficher le timer pour la Nuée de sauterelles",
	TimerLocustFade 	= "Afficher le timer pour la fin de la Nuée de sauterelles"
})


----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "Grande Veuve Faerlina"
})

L:SetWarningLocalization({
	WarningEmbraceActive	= "Baisé de la veuve actif",
	WarningEmbraceExpire	= "Fin du baisé de la veuve dans 5 sec",
	WarningEmbraceExpired	= "Baisé de la veuve terminé",
	WarningEnrageSoon		= "Enragée dans 5 sec",
	WarningEnrageNow		= "Enragée!"
})

L:SetTimerLocalization({
	TimerEmbrace	= "Baisé actif",
	TimerEnrage		= "Enragée",
})

L:SetOptionLocalization({
	TimerEmbrace			= "Activer le timer pour le baisé de la veuve",
	WarningEmbraceActive	= "Activer l'avertissement pour le baisé de la veuve",
	WarningEmbraceExpire	= "Activer l'avertissement de fin du baisé de la veuve",
	WarningEmbraceExpired	= "Afficher un avertissement quand le baisé de la veuve va se terminer",
	WarningEnrageSoon		= "Montre une alerte avant la Frénésie",
	WarningEnrageNow		= "Montre une alerte pour la Frénésie",
	TimerEnrage				= "Montre le timer pour la Frénésie"
})


---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
	name = "Maexxna"
})

L:SetWarningLocalization({
	WarningWebWrap		= "Cocon sur: >%s<",
	WarningWebSpraySoon	= "Jet de rets dans 5 sec",
	WarningWebSprayNow	= "Jet de rets!",
	WarningSpidersSoon	= "Araignées dans 5 sec",
	WarningSpidersNow	= "Arrivée des araignées!"
})

L:SetTimerLocalization({
	TimerWebSpray	= "Jet de rets",
	TimerSpider		= "Araignées"
})

L:SetOptionLocalization({
	WarningWebWrap		= "Annoncer les cibles du cocon",
	WarningWebSpraySoon	= "Activer le pré-avertissement pour les Jet de rets",
	WarningWebSprayNow	= "Activer l'avertissement pour les Jet de rets",
	WarningSpidersSoon	= "Activer le pré-avertissement pour les araignées",
	WarningSpidersNow	= "Activer l'avertissement pour les araignées",
	TimerWebSpray		= "Activer le timer pour les Jet de rets",
	TimerSpider			= "Activer le timer pour les araignées"
})

L:SetMiscLocalization({
	YellWebWrap			= "Je suis dans un cocon! Aidez-moi!"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name = "Noth le Porte-peste"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Téléportation!",
	WarningTeleportSoon	= "Téléportation dans in 20 sec",
	WarningCurse		= "Malédiction!"
})

L:SetTimerLocalization({
	TimerTeleport		= "Téléportation",
	TimerTeleportBack	= "Retour de TP"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "Activer l'avertissement pour la téléporation",
	WarningTeleportSoon		= "Activer le pré-avertissement pour la téléporation",
	WarningCurse			= "Activer l'avertissement pour la malédiction",
	TimerTeleport			= "Activer le timer pour la téléporation",
	TimerTeleportBack		= "Activer le timer pour le retour de North"
})


--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "Heigan l'Impur"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Téléportation!",
	WarningTeleportSoon	= "Téléporation dans %d sec",
})

L:SetTimerLocalization({
	TimerTeleport		= "Téléporation",
})

L:SetOptionLocalization({
	WarningTeleportNow		= "Activer l'avertissement de Téléporation",
	WarningTeleportSoon		= "Activer le pré-avertissement de Téléporation",
	WarningCurse			= "Activer l'avertissement pour la Malédiction",
	TimerTeleport			= "Activer le timer pour la Téléporation",
	TimerTeleportBack		= "Activer le timer pour le retour de Heigan"
})


----------------
--  Lolotheb  --
----------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "Horreb"
})

L:SetWarningLocalization({
	WarningSporeNow		= "Arrivée d'un spore!",
	WarningSporeSoon	= "Spore dans 5 sec",
	WarningDoomNow		= "Malédiction inévitable #%d",
	WarningHealSoon		= "Soins possibles dans 3 sec",
	WarningHealNow		= "SOIGNEZ MAINTENANT!"
})

L:SetTimerLocalization({
	TimerDoom			= "Malédiction inévitable #%d",
	TimerSpore			= "Prochain spore",
	TimerAura			= "Aura nécrotique"
})

L:SetOptionLocalization({
	WarningSporeNow		= "Activer l'avertissement pour les Spores",
	WarningSporeSoon	= "Activer le pré-avertissement pour les Spores",
	WarningDoomNow		= "Activer l'avertissement pour les Malédictions inévitables",
	WarningHealSoon		= "Activer l'avertissement \"Soins dans 3 sec\" ",
	WarningHealNow		= "Activer l'avertissement \"SOIGNEZ MAINTENANT\" ",
	TimerDoom			= "Activer le timer pour la Malédiction inévitable",
	TimerSpore			= "Activer le timer pour les Spores",
	TimerAura			= "Activer le timer pour l'Aura Nécrotique"
})



-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "Le recousu"
})

L:SetOptionLocalization({
	WarningHateful = "Annoncer les Frappes Haineuses au raid\n(vous devez être promote ou le raid leader pour le faire)"
})

L:SetMiscLocalization({
	yell1 = "R'cousu veut jouer !",
	yell2 = "R'cousu avatar de guerre pour Kel'Thuzad !",
	HatefulStrike = "Frappe Haineuse --> %s [%s]"
})


-----------------
--  Grobbulus  --
-----------------
L = DBM:GetModLocalization("Grobbulus")

L:SetGeneralLocalization({
	name = "Grobbulus"
})

L:SetOptionLocalization({
	WarningInjection		= "Activer l'avertissement pour l'Injection mutante",
	SpecialWarningInjection	= "Activer l'avertissement spécial quand vous êtes affecté par l'Injection mutante"
})

L:SetWarningLocalization({
	WarningInjection		= "Injection mutante sur: >%s<",
	SpecialWarningInjection	= "Injection mutante sur toi!"
})

L:SetTimerLocalization({
})


-------------
--  Gluth  --
-------------
L = DBM:GetModLocalization("Gluth")

L:SetGeneralLocalization({
	name = "Gluth"
})

L:SetOptionLocalization({
	WarningDecimateNow	= "Activer l'avertissement pour \"Décimer\" ",
	WarningDecimateSoon	= "Activer le pré-avertissement pour \"Décimer\" ",
	TimerDecimate		= "Activer le timer pour \"Décimer\" "
})

L:SetWarningLocalization({
	WarningDecimateNow	= "Décimer!",
	WarningDecimateSoon	= "Décimer dans 10 sec"
})

L:SetTimerLocalization({
	TimerDecimate		= "Décimer"
})


----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
	name = "Thaddius"
})

L:SetMiscLocalization({
	Yell	= "Stalagg écraser toi !",
	Emote	= "%s entre en surcharge !", -- ?
	Emote2	= "Bobine de Tesla entre en surcharge !", -- ?
	Boss1 = "Feugen",
	Boss2 = "Stalagg",
	Charge1 = "négative",
	Charge2 = "positive",
})

L:SetOptionLocalization({
	WarningShiftCasting		= "Actier l'avertissement du changement de Polarité",
	WarningChargeChanged	= "Activer l'avertissement spécial quand votre polarité a changé",
	WarningChargeNotChanged	= "Activer l'avertissement spécial quand votre polarité n'a pas changé",
	TimerShiftCast			= "Afficher le timer pour le cast du changement de polarité",
	TimerNextShift			= "Afficher le timer du temps de recharge du changement de polarité",
	ArrowsEnabled			= "Afficher les flèches (stratégie normale : \"2 camps\")",
	ArrowsRightLeft			= "Afficher les flèches droite/gauche pour la stratégie \"4 camps\" (flèche gauche si la polarité a changé et droite sinon)",
	ArrowsInverse			= "Inverser la statégie \"4 camps\" (afficher la flèche droite si la polarité a changé et la gauche sinon)",
	WarningThrow			= "Activer l'avertissement pour le jet de Tank",
	WarningThrowSoon		= "Activer le pré-avertissement pour le jet de tank",
	TimerThrow				= "Afficher le timer pour le jet de tank"
})

L:SetWarningLocalization({
	WarningShiftCasting		= "Changement de polarité dans 3 sec!",
	WarningChargeChanged	= "Polarité changée : %s",
	WarningChargeNotChanged	= "Même polarité",
	WarningThrow			= "Jet de tank!",
	WarningThrowSoon		= "Jet de tank dans 3 sec"
})

L:SetTimerLocalization({
	TimerShiftCast			= "Lancement du changement de polarité",
	TimerNextShift			= "Prochain changement de polarité",
	TimerThrow				= "Jet de tank"
})

L:SetOptionCatLocalization({
	Arrows	= "Flèches",
})


-----------------
--  Razuvious  --
-----------------
L = DBM:GetModLocalization("Razuvious")

L:SetGeneralLocalization({
	name = "Razuvious"
})

L:SetMiscLocalization({
	Yell1 = "Pas de quartier !",
	Yell2 = "Les cours sont terminés ! Montrez-moi ce que vous avez appris !",
	Yell3 = "Faites ce que vous ai appris !",
	Yell4 = "Frappe-le à la jambe"
})

L:SetOptionLocalization({
	WarningShoutNow		= "Activer l'avertissement pour les Cris perturbants",
	WarningShoutSoon	= "Activer le pré-avertissement pour les Cris perturbants",
	TimerShout			= "Afficher le timer pour les Cris perturbants",
	WarningShieldWallSoon	= "Activer l'avertissement du Mur de Bouclier",
	TimerShieldWall			= "Afficher le timer du Mur de Bouclier",
	TimerTaunt				= "Afficher le timer du Taunt"
})

L:SetWarningLocalization({
	WarningShoutNow		= "Cri perturbant!",
	WarningShoutSoon	= "Cri perturbant dans 5 sec",
	WarningShieldWallSoon	= "Mur de Bouclier expire dans 5 sec"
})

L:SetTimerLocalization({
	TimerShout			= "Cri perturbant",
	TimerTaunt			= "Taunt",
	TimerShieldWall		= "Mur de Bouclier"
})

--------------
--  Gothik  --
--------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "Gothik"
})

L:SetOptionLocalization({
	TimerWave			= "Afficher le timer des vagues",
	TimerPhase2			= "Afficher le timer pour la Phase 2",
	WarningWaveSoon		= "Activer le pré-avertissement pour les Vagues",
	WarningWaveSpawned	= "Avertir quand une vague est arrivée",
	WarningRiderDown	= "Avertir quand un Cavalier meurt",
	WarningKnightDown	= "Avertir quand un Chevalier meurt",
	WarningPhase2		= "Activer l'avertissement pour la Phase 2"
})

L:SetTimerLocalization({
	TimerWave	= "Vague #%d",
	TimerPhase2	= "Phase 2"
})

L:SetWarningLocalization({
	WarningWaveSoon		= "Vague %d: %s dans 3 sec",
	WarningWaveSpawned	= "Vague %d: %s arrivée",
	WarningRiderDown	= "Cavalier down",
	WarningKnightDown	= "Chevalier down",
	WarningPhase2		= "Phase 2"
})

L:SetMiscLocalization({
	yell			= "Dans votre folie, vous avez provoqué votre propre mort.",
	WarningWave1	= "%d %s",
	WarningWave2	= "%d %s et %d %s",
	WarningWave3	= "%d %s, %d %s et %d %s",
	Trainee			= "Recrues",
	Knight			= "Chevaliers",
	Rider			= "Cavaliers",
})


----------------
--  Horsemen  --
----------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "Les quatre Cavaliers"
})

L:SetOptionLocalization({
	TimerMark					= "Afficher le timer des Marques",
	WarningMarkSoon				= "Activer le pré-avertissement des Marques",
	WarningMarkNow				= "Activer l'avertissement des Marques",
	SpecialWarningMarkOnPlayer	= "Avertissement spécial quand vous avez plus de 4 marques sur vous"
})

L:SetTimerLocalization({
	TimerMark = "Marque %d"
})

L:SetWarningLocalization({
	WarningMarkSoon				= "Marque %d dans 3 sec",
	WarningMarkNow				= "Marque %d!",
	SpecialWarningMarkOnPlayer	= "%s: %s",
})

L:SetMiscLocalization({
	Korthazz	= "Thane Korth'azz",
	Rivendare	= "Baron Vaillefendre",
	Blaumeux	= "Dame Blaumeux",
	Zeliek		= "Sire Zeliek",
})


-----------------
--  Sapphiron  --
-----------------
L = DBM:GetModLocalization("Sapphiron")

L:SetGeneralLocalization({
	name = "Sapphiron"
})

L:SetOptionLocalization({
	WarningDrainLifeNow		= "Activer l'avertissement pour le Drain de vie",
	WarningDrainLifeSoon	= "Activer le pré-avertissement du Drain de vie",
	WarningAirPhaseSoon		= "Activer le pré-avertissement de la phase en vol",
	WarningAirPhaseNow		= "Activer l'avertissement de la phase en vol",
	WarningLanded			= "Activer l'avertissement pour la phase au sol",
	TimerDrainLifeCD		= "Afficher le timer du Drain de vie",
	TimerAir				= "Afficher le timer de la phase en vol",
	TimerLanding			= "Afficher le timer de l'atterrissage",
	TimerIceBlast			= "Afficher le timer du Deep Breath",
	WarningDeepBreath		= "Activer l'avertissement spécial pour le Deep Breath",
	WarningIceblock			= "Crie dans un glaçon"
})

L:SetMiscLocalization({
	EmoteBreath			= "%s prend une grande inspiration...",
	WarningYellIceblock	= "Je suis un bloc de glace!"
})

L:SetWarningLocalization({
	WarningDrainLifeNow		= "Drain de vie!",
	WarningDrainLifeSoon	= "Drain de vie imminent",
	WarningAirPhaseSoon		= "Envol dans 10 sec",
	WarningAirPhaseNow		= "Dans les airs",
	WarningLanded			= "Atterrissage de Sapphiron",
	WarningDeepBreath		= "Deep Breath!",
})

L:SetTimerLocalization({
	TimerDrainLifeCD		= "CD du drain de vie",
	TimerAir				= "Envol",
	TimerLanding			= "Atterrissage dans",
	TimerIceBlast			= "Deep Breath"	
})

------------------
--  Kel'thuzad  --
------------------

L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name = "Kel'Thuzad"
})

L:SetOptionLocalization({
	BlastTimer			= "Timer pour Trait de glace : 4 secondes avant que la victime ne meurt",
	TimerPhase2			= "Afficher le timer pour la Phase 2",
	WarningBlastTargets	= "Activer l'avertissement pour le Trait de glace",
	WarningPhase2		= "Activer l'avertissement pour la Phase 2",
	WarningFissure		= "Activer l'avertissement pour la Fissure d'ombre",
	WarningMana			= "Activer l'avertissement pour le Mana détonant",
	WarningChainsTargets= "Activer l'avertissement pour les Chaînes de Kel'Thuzad",
	specwarnP2Soon 		= "Montre un timer pour prévenir 10 secondes avant l'arrivée de Kel'Thuzad",
	ShowRange			= "Active l'indicateur de portée quand la phase 2 débute"
})

L:SetMiscLocalization({
	Yell = "Serviteurs, valets et soldats des ténèbres glaciales ! Répondez à l'appel de Kel'Thuzad !"
})

L:SetWarningLocalization({
	WarningBlastTargets		= "Trait de glace: >%s<",
	WarningPhase2			= "Phase 2",
	WarningFissure			= "Arrivée d'une Fissure d'ombre",
	WarningMana				= "Mana détonant: >%s<",
	WarningChainsTargets	= "Chaînes de Kel'Thuzad: >%s<",
	specwarnP2Soon  		= "Kel'Thuzad sera actif dans 10 secondes"
})

L:SetTimerLocalization({
	TimerPhase2			= "Phase 2",
	BlastTimer			= "Heal Maintenant !"
})



