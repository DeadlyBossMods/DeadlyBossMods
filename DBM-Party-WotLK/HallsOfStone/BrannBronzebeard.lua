local mod	= DBM:NewMod("BrannBronzebeard", "DBM-Party-WotLK", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28070)
mod:SetZone()

mod:RegisterCombat("yell", L.Pull)
mod:RegisterKill("yell", L.Kill)
mod:SetMinCombatTime(313)--This boss you leave combat every set of new mobs so this is only work around.
--[[		["REGEN_ENABLED"] = {
			"<58.7>  -- < Regen Enabled : Leaving combat! -- < ", -- [1]
			"<80.7>  -- < Regen Enabled : Leaving combat! -- < ", -- [2]
			"<103.7>  -- < Regen Enabled : Leaving combat! -- < ", -- [3]
			"<110.5>  -- < Regen Enabled : Leaving combat! -- < ", -- [4]
			"<133.4>  -- < Regen Enabled : Leaving combat! -- < ", -- [5]
			"<159.1>  -- < Regen Enabled : Leaving combat! -- < ", -- [6]
			"<178.0>  -- < Regen Enabled : Leaving combat! -- < ", -- [7]
			"<188.0>  -- < Regen Enabled : Leaving combat! -- < ", -- [8]
			"<200.9>  -- < Regen Enabled : Leaving combat! -- < ", -- [9]
			"<208.9>  -- < Regen Enabled : Leaving combat! -- < ", -- [10]
			"<239.1>  -- < Regen Enabled : Leaving combat! -- < ", -- [11]
			"<250.7>  -- < Regen Enabled : Leaving combat! -- < ", -- [12]
			"<261.2>  -- < Regen Enabled : Leaving combat! -- < ", -- [13]
			"<273.2>  -- < Regen Enabled : Leaving combat! -- < ", -- [14]
			"<281.2>  -- < Regen Enabled : Leaving combat! -- < ", -- [15]
			"<298.5>  -- < Regen Enabled : Leaving combat! -- < ", -- [16]
			"<313.8>  -- < Regen Enabled : Leaving combat! -- < ", -- [17]--]]

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local warningPhase	= mod:NewAnnounce("WarningPhase", 3)
local timerEvent	= mod:NewTimer(312, "timerEvent")

function mod:OnCombatStart(delay)
	timerEvent:Start(-delay)
end

function mod:CHAT_MSG_MONSTER_YELL(msg, sender)
	if L.Phase1 == msg then
		warningPhase:Show(1)
	elseif msg == L.Phase2 then
		warningPhase:Show(2)
	elseif msg == L.Phase3 then
		warningPhase:Show(3)
	end
end


