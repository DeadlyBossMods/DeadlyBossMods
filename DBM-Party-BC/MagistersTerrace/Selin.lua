local mod = DBM:NewMod("Selin", "DBM-Party-BC", 16)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))

mod:SetCreatureID(24723)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_EMOTE"
)

local warnChanneling		= mod:NewAnnounce("warnChanneling")

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg == L.ChannelCrystal then
        warnChanneling:Show()
	end
end