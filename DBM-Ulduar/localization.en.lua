local L

---------------
--  Malygos  --
---------------
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

