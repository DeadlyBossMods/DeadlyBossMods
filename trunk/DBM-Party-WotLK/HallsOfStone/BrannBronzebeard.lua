local mod = DBM:NewMod("BrannBronzebeard", "DBM-Party-WotLK", 7)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28070)
mod:SetZone()

mod:RegisterCombat("yell", L.Pull)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local warningPhase	= mod:NewAnnounce("WarningPhase", 3)

function mod:CHAT_MSG_MONSTER_YELL(msg, sender)
	if msg:find(L.Phase1) then
		warningPhase:Show(1)
	elseif msg:find(L.Phase2) then
		warningPhase:Show(2)
	elseif msg:find(L.Phase3) then
		warningPhase:Show(3)
	end
end