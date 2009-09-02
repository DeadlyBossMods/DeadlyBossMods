local mod = DBM:NewMod("Koralon", "DBM-Battlegrounds")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(35013)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

-- Koralon the Flame Watcher casts Meteor Fists!

local enrageTimer	= mod:NewEnrageTimer(300)
local warnMeteor	= mod:NewSpellAnnounce(67331, 3)

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Meteor then
		warnMeteor:Show()
	end
end
