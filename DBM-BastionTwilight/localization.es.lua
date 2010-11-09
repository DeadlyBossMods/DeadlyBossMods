if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization("ValionaTheralion")

L:SetGeneralLocalization({
	name =	"Valiona y Theralion"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L = DBM:GetModLocalization("HalfusWyrmbreaker")

L:SetGeneralLocalization({
	name =	"Halfus Partevermis"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"Consejo de ascendientes"
})

L:SetWarningLocalization({
	SpecWarnGrounded	= "Get Grounded buff",
	SpecWarnSearingWinds	= "Get Searing Winds buff"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	Quake			= "The ground beneath you rumbles ominously....",--translate
	Thundershock		= "The surrounding air crackles with energy....",--translate
	Switch			= "We will handle them!",--translate
	Phase3			= "BEHOLD YOUR DOOM!",--translate
	Ignacious		= "Ignacious",--translate
	Feludius		= "Feludius",--translate
	Arion			= "Arion",--translate
	Terrastra		= "Terrastra",--translate
	Monstrosity		= "Elementium Monstrosity"--translate
})

L:SetOptionLocalization({
	SpecWarnGrounded	= "Show special warning when you are missing $spell:83581 buff\n(~10sec before cast)",--translate
	SpecWarnSearingWinds	= "Show special warning when you are missing $spell:83500 buff\n(~10sec before cast)"--translate
})

----------------
--  Cho'gall  --
----------------
L = DBM:GetModLocalization("Chogall")

L:SetGeneralLocalization({
	name =	"Cho'gall"
})

L:SetWarningLocalization({
	WarnPhase2Soon	= "Fase 2 pronto"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "Mostrar preaviso para Fase 2"
})