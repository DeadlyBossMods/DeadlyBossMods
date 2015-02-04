if GetLocale() ~= "deDE" then return end
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
	TorrentYell	= "Torrent fading in %d"--translate
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
	threeTrains		= " 3 Random Lanes",--translate
	helperMessage	= "Empfehlung: Bei diesem Boss sollte das Addon \"Thogar Assist\" zusammen mit DBM genutzt werden. Verfügbar hier: http://wow.curseforge.com/addons/thogar-assist/"
})

--------------------------
-- The Iron Maidens --
--------------------------
L= DBM:GetModLocalization(1203)

L:SetMiscLocalization({
	shipMessage		= "prepares to man the Dreadnaught's Main Cannon!"--translate
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
	name =	"Trash der Schwarzfelsgießerei"
})
