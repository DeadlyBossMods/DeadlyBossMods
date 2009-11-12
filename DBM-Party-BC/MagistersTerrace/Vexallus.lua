local mod = DBM:NewMod("Vexallus", "DBM-Party-BC", 16)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))

mod:SetCreatureID(24744)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local WarnEnergy		= mod:NewAnnounce("WarnEnergy")

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Discharge then
        WarnEnergy:Show()
	end
end