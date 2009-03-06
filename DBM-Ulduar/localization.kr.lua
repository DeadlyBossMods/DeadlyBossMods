if GetLocale() ~= "koKR" then return end

local L

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization({
	name = "Thorim"
})

L:SetWarningLocalization({
	WarningStormhammer	= "Stormhammer on %s",
})

L:SetTimerLocalization({
	TimerStormhammer	= "Next Stormhammer",  -- applys AE Silience on the target
})

L:SetOptionLocalization({
	TimerStormhammer	= "Show Stormhammer Cooldown",
	WarningStormhammer	= "Announce Stormhammer Target",
})

--L:SetMiscLocalization({ })

-------------------
--  IronCouncil  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization({
	name = "Iron Council"
})

L:SetWarningLocalization({
	WarningSupercharge	= "Supercharge incoming",
})

L:SetTimerLocalization({
	TimerSupercharge	= "Supercharge",  -- gives the other bosses more power
})

L:SetOptionLocalization({
	TimerSupercharge	= "Show Supercharge Timer",
	WarningSupercharge	= "Show warning when Supercharge casting",
})

L:SetMiscLocalization({
	"Steelbreaker"		= "Steelbreaker",
	"RunemasterMolgeim" 	= "Runemaster Molgeim",
	"StormcallerBrundir" 	= "Stormcaller Brundir",
})


-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization({
	name = "Hodir"
})

L:SetWarningLocalization({
	WarningFlashFreeze	= "Flesh Freeze",
	WarningBitingCold	= "Biting Cold - MOVE"
})

L:SetTimerLocalization({
	TimerFlashFreeze	= "Flesh Freeze incoming",  -- all ppl have to move on the rock patches
})

L:SetOptionLocalization({
	TimerFlashFreeze	= "Show Flash Freeze Cast-Timer",
	WarningFlashFreeze	= "Show Warning for Flash Freeze",
})

L:SetMiscLocalization({
	PlaySoundOnFlashFreeze	= "Play sound on Flash Freeze Cast",
})







