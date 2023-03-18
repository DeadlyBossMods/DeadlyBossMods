local L

---------------------------
--  Kazzara --
---------------------------
--L= DBM:GetModLocalization(2522)

--L:SetWarningLocalization({
--})
--
--L:SetTimerLocalization{
--}
--
--L:SetOptionLocalization({
--})
--
--L:SetMiscLocalization({
--})

---------------------------
--  The Amalgamation Chamber --
---------------------------
L= DBM:GetModLocalization(2529)

L:SetOptionLocalization({
	AdvancedBossFiltering	= "Actively scan distance to each of bosses in stage 1 and automatically hide certain alerts and fade timers for the boss you are NOT near (more than 43 distance)"
})

---------------------------
--  The Forgotten Experiments --
---------------------------
--L= DBM:GetModLocalization(2530)

---------------------------
--  Assault of the Zaqali --
---------------------------
--L= DBM:GetModLocalization(2524)

---------------------------
--  Rashok --
---------------------------
L= DBM:GetModLocalization(2525)

L:SetOptionLocalization({
	TankSwapBehavior	= "Set mod behavior for tank swaps",
	OnlyIfDanger		= "Shows taunt warning only if other tank is about to take unsafe hit",
	MinMaxSoak			= "Shows taunt warning after a combos first attack, or if other tank is about to take unsafe hit",
	DoubleSoak			= "Shows taunt warning after a combo has ended, or if other tank is about to take unsafe hit"--Default
})

---------------------------
--  The Vigilant Steward, Zskarn --
---------------------------
--L= DBM:GetModLocalization(2532)

---------------------------
--  Magmorax --
---------------------------
--L= DBM:GetModLocalization(2527)

---------------------------
--  Echo of Neltharion --
---------------------------
--L= DBM:GetModLocalization(2523)

---------------------------
--  Scalecommander Sarkareth --
---------------------------
--L= DBM:GetModLocalization(2520)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AberrusTrash")

L:SetGeneralLocalization({
	name =	"Aberrus Trash"
})
