-- Last update: 12/20/2012 (20/12/2012 in french format)
-- By Edoz (stephanelc35@msn.com)
if GetLocale() ~= "frFR" then return end
local L

--------------------------
--  Blastenheimer 5000  --
--------------------------
L = DBM:GetModLocalization("Cannon")

L:SetGeneralLocalization({
	name = "Ultra-canon Explonheimer 5000"
})

-------------
--  Gnoll  --
-------------
L = DBM:GetModLocalization("Gnoll")

L:SetGeneralLocalization({
	name = "Cogne-gnoll"
})

L:SetWarningLocalization({
	warnGameOverQuest	= "Vous avez gagné %d des %d points possibles",
	warnGameOverNoQuest	= "Jeu terminé avec un total de %d points possibles",
	warnGnoll			= "Gnoll apparu",
	warnHogger			= "Lardeur apparu",
	specWarnHogger		= "Lardeur apparu!"
})

L:SetOptionLocalization({
	warnGameOver	= "Afficher le total des points qui était possibles quand le jeu est terminé",
	warnGnoll		= "Alerte quand un Gnoll apparait",
	warnHogger		= "Alerte quand Lardeur apparait",
	specWarnHogger	= "Alerte spécial quand Lardeur apparait"
})

------------------------
--  Shooting Gallery  --
------------------------
L = DBM:GetModLocalization("Shot")

L:SetGeneralLocalization({
	name = "Tir réflexe"
})

L:SetOptionLocalization({
	SetBubbles			= "Désactiver les bulles de texte pendant $spell:101871<br/>(Restaure les paramètres à la fin du jeu)"
})

----------------------
--  Tonk Challenge  --
----------------------
L = DBM:GetModLocalization("Tonks")

L:SetGeneralLocalization({
	name = "Jeu de chariottes"
})

-----------------------
--  Darkmoon Rabbit  --
-----------------------
L = DBM:GetModLocalization("Rabbit")

L:SetGeneralLocalization({
	name = "Lapin de Sombrelune"
})

--------------------------
--  Plants Vs. Zombies  --
--------------------------
L = DBM:GetModLocalization("PlantsVsZombies")

L:SetGeneralLocalization({
	name = "Plants Vs. Zombies"
})

L:SetWarningLocalization({
	warnTotalAdds	= "Total des zombies engendrées depuis la dernière vague massive : %d",
	specWarnWave	= "Vague Massive !"
})

L:SetTimerLocalization{
	timerWave		= "Prochaine Vague Massive"
}

L:SetOptionLocalization({
	warnTotalAdds	= "Afficher le nombre total d'add engendrées entre chaque vague massive",
	specWarnWave	= "Alerte spécial quand une Vague Massive arrive",
	timerWave		= "Délai avant la prochaine Vague Massive"
})

L:SetMiscLocalization({
	MassiveWave		= "Une Vague Massive de Zombies est en approche !"
})

