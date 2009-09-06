if GetLocale() ~= "frFR" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Les Bêtes du Norfendre"
}

L:SetMiscLocalization{
	Charge	= "^%%s fusille (%S+) du regard et lâche un rugissement assourdissant !",
	CombatStart		= "Arrivant tout droit des plus noires et profondes cavernes des pics Foudroyés, Gormok l'Empaleur !",
	Phase3			= "L'air se gèle à l'entrée de notre prochain combattant, Glace-hurlante ! Tuez ou soyez tués, champions !"
}

L:SetOptionLocalization{
	WarningImpale				= "Montre une alerte spéciale pour Empaler",
	WarningFireBomb				= "Montre une alerte spéciale pour les Bombe incendiaire",
	WarningBreath				= "Montre une alerte spéciale pour les Souffle arctique",
--	WarningSpray				= "Montre une alerte spéciale pour les Jet paralysant",
	WarningRage					= "Montre une alerte spéciale pour la Rage écumeuse",
	WarningCharge				= "Montre une alerte spéciale pour la cible de la charge",
	WarningToxin				= "Montre une alerte pour la cible de la Toxine paralysante",
	WarningBile					= "Montre une alerte pour la cible de la Bile brûlante",
	SpecialWarningImpale3		= "Montre une alerte spéciale pour l'empaler (>=3 Stacks)",
	SpecialWarningFireBomb		= "Montre une alerte spéciale quand la Bombe incendiaire est sur vous",
	SpecialWarningSlimePool		= "Montre une alerte spéciale pour les Flaque de bave",
	SpecialWarningSilence		= "Montre une alerte spéciale pour le Piétinement ahurissant",
	SpecialWarningSpray			= "Montre une alerte spéciale si vous êtes victime d'un Jet paralysant",
	SpecialWarningToxin			= "Montre une alerte spéciale si vous êtes victime de la Toxine paralysante",
	SpecialWarningBile			= "Montre une alerte spéciale si vous avez la Bile brûlante sur Vous",
	SpecialWarningCharge		= "Montre une alerte spéciale quand Icehowl est sur le point de vous charger",
	SpecialWarningChargeNear	= "Montre une alerte spéciale quand Icehowl charge a coter de vous",
	SetIconOnChargeTarget		= "Met une icone sur la cible de la charge ( Tête de mort )",
	SetIconOnBileTarget			= "Met une icone sur la cible de la Bile brûlante",
	ClearIconsOnIceHowl			= "Enlève toutes les icones avant la prochaine charge",
	TimerNextBoss				= "Montre le timer pour l'arrivée du prochain boss"
}

L:SetTimerLocalization{
	TimerNextBoss				= "Prochain Boss Dans"
}

L:SetWarningLocalization{
	WarningImpale				= "%s sur >%s<",
	WarningFireBomb				= "Bombe incendiaire",
--	WarningSpray				= "%s sur >%s<",
	WarningBreath				= "Souffle arctique",
	WarningRage					= "Rage écumeuse",
	WarningCharge				= "Charge sur >%s<",
	WarningToxin				= "Toxine paralysante sur >%s<",
	WarningBile					= "Bile brûlante sur >%s<",
	SpecialWarningImpale3		= "Empaler >%d< sur VOUS",
	SpecialWarningFireBomb		= "Bombe incendiaire sur VOUS",
	SpecialWarningSlimePool		= "Flaque de bave, BOUGEZ!",
	SpecialWarningSilence		= "Piétinement ahurissant dans ~1.5 Seconde!",
	SpecialWarningSpray			= "Jet paralysant",
	SpecialWarningToxin			= "Toxine paralysante sur vous, BOUGEZ!",
	SpecialWarningCharge		= "Charge sur vous! COUREZ!",
	SpecialWarningChargeNear	= "Charge a coter de vous! COUREZ!",
	SpecialWarningBile			= "Bile brûlante sur VOUS !"
}



-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Seigneur Jaraxxus"
}

L:SetWarningLocalization{
	WarnFlame				= "Flamme de la Légion sur >%s<",
	WarnTouch				= "Toucher de Jaraxxus sur >%s<",
	WarnNetherPower			= "Puissance du Néant sur Jaraxxus! Dispel Maintenant!",
	WarnPortalSoon			= "Portail de Néant bientôt!",
	WarnVolcanoSoon			= "Inferno brûlant bientôt!",
	SpecWarnFlesh			= "Incinérer la chair sur VOUS!",
	SpecWarnTouch			= "Toucher de Jaraxxus sur VOUS!",
	SpecWarnKiss			= "Baiser de la Maîtresse",
	SpecWarnTouchNear		= "Toucher de Jaraxxus sur >%s< a coter de vous",
	SpecWarnFlame			= "Flamme de la Légion! COUREZ!",
	SpecWarnNetherPower		= "Dispell Maintenant!",
	SpecWarnFelInferno		= "Inferno gangrené! Courez plus loin!"
}

L:SetMiscLocalization{
	WhisperFlame			= "Flamme de la Légion sur VOUS!",
}

L:SetOptionLocalization{
	WarnFlame				= "Alerte pour les Flamme de la Légion",
	WarnTouch				= "Montre une alerte pour le Toucher de Jaraxxus",
	WarnNetherPower			= "Alerte quand Jaraxxus gagne Puissance du Néant (Pour le dispel)",
	WarnPortalSoon			= "Montre une alerte avant qu'un Portail de Néant arrive",
	WarnVolcanoSoon			= "Montre une alerte avant qu'un Inferno brûlant arrive",
	SpecWarnFlame			= "Montre une alerte spéciale quand vous avez Flamme de la Légion",
	SpecWarnFlesh			= "Montre une alerte spéciale quand vous avez Incinérer la chair",
	SpecWarnTouch			= "Montre une alerte spéciale quand le Toucher de Jaraxxus est sur vous",
	SpecWarnTouchNear		= "Montre une alerte spéciale quand le Toucher de Jaraxxus est a coter de vous",
	SpecWarnKiss			= "Montre une alerte spéciale pour le Baiser de la Maîtresse",
	SpecWarnNetherPower		= "Montre une alerte spéciale pour la Puissance du Néant (Pour dispell Jaraxxus)",
	SpecWarnFelInferno		= "Montre une alerte spéciale quand vous êtes pret d'un Inferno gangrené",
	TouchJaraxxusIcon		= "Met une icone sur la cible du Toucher de Jaraxxus (Croix)",
	IncinerateFleshIcon		= "Met une icone sur la cible d' Incinérer la chair (Tête de mort)",
	LegionFlameIcon			= "Met une icone sur la cible des Flamme de la Légion (Carré)",
	LegionFlameWhisper		= "Chuchotte a la cible des Flamme de la Légion pour la prévenir"
}


-----------------------
-- Faction Champions --
-----------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "Champion des Factions"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarnHellfire		= "Flammes infernales",
	SpecWarnHellfire	= "Flammes infernales ! BOUGEZ !"
}

L:SetMiscLocalization{
	Gorgrim		= "DK - Gorgrim Shadowcleave",		-- 34458
	Birana 		= "D - Birana Stormhoof",			-- 34451
	Erin		= "D - Erin Misthoof",				-- 34459
	Rujkah		= "H - Ruj'kah",					-- 34448
	Ginselle	= "M - Ginselle Blightslinger",		-- 34449
	Liandra		= "P - Liandra Suncaller",			-- 34445
	Malithas	= "P - Malithas Brightblade",		-- 34456
	Caiphus		= "PR - Caiphus the Stern",			-- 34447
	Vivienne	= "PR - Vivienne Blackwhisper",		-- 34441
	Mazdinah	= "R - Maz'dinah",					-- 34454
	Thrakgar	= "S - Thrakgar",					-- 34444
	Broln		= "S - Broln Stouthorn",			-- 34455
	Harkzog		= "WL - Harkzog",					-- 34450
	Narrhok		= "W - Narrhok Steelbreaker",		-- 34453
	YellKill	= "Une victoire tragique et depourvue de sens. La perte subie aujourd'hui nous affaiblira tous, car qui d'autre que le roi-liche pourrait beneficier d'une telle folie?? De grands guerriers ont perdu la vie. Et pour quoi?? La vraie menace plane a l'horizon?: le roi-liche nous attend, tous, dans la mort."
} 

L:SetOptionLocalization{
	WarnHellfire			= "Alerte quand Harzog incante les Flammes infernales",
	SpecWarnHellfire		= "Montre une alerte spéciale quand vous subissez des dégats provenant des Flammes infernales"
}


------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "Soeurs Val'kyr"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Prochaine Abiliter Spéciale"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "Abiliter spéciale Bientôt !",
	SpecWarnSpecial				= "Changement de couleur !",
	SpecWarnEmpoweredDarkness	= "Ténèbres surpuissantes",
	SpecWarnEmpoweredLight		= "Lumière surpuissante"
}

L:SetMiscLocalization{
	YellPull 	= "Au nom de notre ténébreux maître. Pour le roi-liche. Vous. Allez. Mourir.",
	Fjola 		= "Fjola Plaie-lumineuse",
	Eydis		= "Eydis Plaie-sombre"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "Montre une alerte spéciale pour la prochaine Abiliter spéciale",
	WarnSpecialSpellSoon		= "Montre une Pré-Alerte pour la prochaine Abiliter spéciale",
	SpecWarnSpecial				= "Montre une alerte spéciale quand vous avez changer de couleur",
	SpecWarnEmpoweredDarkness	= "Montre une alerte spéciale pour les Ténèbres surpuissantes",
	SpecWarnEmpoweredLight		= "Montre une alerte spéciale pour la Lumière surpuissante",
}


------------------
-- Anub'arak --
------------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name = "Anub'Arak"
}

L:SetTimerLocalization{
	TimerEmerge			= "Sort du sol",
	TimerSubmerge		= "Rentre dans le sol"
}

L:SetWarningLocalization{
	WarnEmerge			= "Anub'arak Sort du sol",
	WarnEmergeSoon		= "Anub'arak Sort du sol dans 10 sec",
	WarnSubmerge		= "Anub'arak Rentre dans le sol",
	WarnSubmergeSoon	= "Anub'arak Rentre dans le sol dans 10 sec",
	WarnPursue			= "Poursuivi >%s<",
	SpecWarnPursue		= "Vous êtes poursuivi"
}

L:SetMiscLocalization{
	YellPull			= "Ce terreau sera votre tombeau !",
	Swarm				= "L'essaim va vous submerger !",
	Emerge				= "%s surgit de la terre !",
	Burrow				= "%s s'enfonce dans le sol !"
}

L:SetOptionLocalization{
	WarnEmerge			= "Montre une alerte quand le boss sort du sol",
	WarnEmergeSoon		= "Montre une alerte avant que le boss sorte du sol",
	WarnSubmerge		= "Montre une alerte quand le boss rentre dans le sol",
	WarnSubmergeSoon	= "Montre une alerte avant que le boss ne rentre dans le sol",
	SpecWarnPursue		= "Montre une alerte quand vous commancer a être suivi",
	TimerEmerge			= "Montre le timer pour la sortie du boss",
	TimerSubmerge		= "Montre le timer pour la rentrer du boss dans la terre",
	PlaySoundOnPursue	= "Joue un sons quand vous êtes suivi",
	PursueIcon			= "Met une icone sur la tête du joueur qui est suivi",
	WarnPursue			= "Annonce le joueur qui est suivi"
}
