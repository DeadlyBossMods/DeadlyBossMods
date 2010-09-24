local mod	= DBM:NewMod("Slabhide", "DBM-Party-Cataclysm", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43214)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)

-- comment:  every 50secs he flies up and throws 'rocks' --	