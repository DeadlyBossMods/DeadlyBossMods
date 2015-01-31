local L

---------------
-- Gruul --
---------------
L= DBM:GetModLocalization(1161)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------
-- Oregorger, The Devourer --
---------------------------
L= DBM:GetModLocalization(1202)

---------------------------
-- The Blast Furnace --
---------------------------
L= DBM:GetModLocalization(1154)

------------------
-- Hans'gar And Franzok --
------------------
L= DBM:GetModLocalization(1155)

--------------
-- Flamebender Ka'graz --
--------------
L= DBM:GetModLocalization(1123)

L:SetMiscLocalization({
	return1		= "Wait till they get a load of me."--Not used yet but just in case my current hack to avoid localizing doesn't work
})

--------------------
--Kromog, Legend of the Mountain --
--------------------
L= DBM:GetModLocalization(1162)

--------------------------
-- Beastlord Darmac --
--------------------------
L= DBM:GetModLocalization(1122)

--------------------------
-- Operator Thogar --
--------------------------
L= DBM:GetModLocalization(1147)

L:SetMiscLocalization({
	--Might not even need to use yells if my npc target works in all languages.
	--depends on if "Train" is boss target in all languages and if that spellid hack also matches it in all languages.
	--At the very least this helps read transcriptor logs :)
	cannonTrain		= "Cannon",
	threeTrains		= " 3 Random Lanes",
	helperMessage	= "It is recommended you use 'Thogar Assist' in combination with DBM on this boss. Available from: http://wow.curseforge.com/addons/thogar-assist/",
	commandTrain1	= "The command car is here.",
	commandTrain2	= "Here comes the brass.",
	moreThanOne1	= "Trains inbound!",
	moreThanOne2	= "Double-time.",
	moreThanOne3	= "Clear the tracks!",
	cannon1			= "Here's my artillery.",
	cannon2			= "Here come the boomers!",
	driveBy1		= "Faster! Bat the stack off her!",
	driveBy2		= "Express, coming through.",
	driveBy3		= "Redball incoming!",
	driveBy4		= "Send 'er on down the line!",
	driveBy5		= "Coming in hot.",
	smallAdds1		= "Here they come - hit the grit, boys!",
	smallAdds2		= "Troop train - inbound!",
	smallAdds3		= "Ah - reinforcements.",
	--Some of these flamethrowers are iffy so verify flamethrower again in videos to be very sure.
	--These may also be something else entirely so going to only debug these right now
	flameThrower1	= "I have a schedule to keep!",
	flameThrower2	= "You are running out of time...",
	flameThrower3	= "I'm not impressed. More trains are inbound!",
	flameThrower4	= "You're just in time for the rush.!",
	flameThrower5	= "Let's step up the pace."
})

--------------------------
-- The Iron Maidens --
--------------------------
L= DBM:GetModLocalization(1203)

L:SetMiscLocalization({
	shipMessage		= "prepares to man the Dreadnaught's Main Cannon!"
})

--------------------------
-- Blackhand --
--------------------------
L= DBM:GetModLocalization(959)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("BlackrockFoundryTrash")

L:SetGeneralLocalization({
	name =	"Blackrock Foundry Trash"
})
