local mod	= DBM:NewMod("GSSTimer", "DBM-Party-MoP", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 9412 $"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("challenge", 875)

--this is basically a stub mod to enable instance completion timers, such as a "fastast clear" timer for a challenge mode. :)
--TODO: maybe expand this with options to enable it's use beyond just challenge modes (such as supporting timer in normal heroic or challenge)
mod:RemoveOption("HealthFrame")
