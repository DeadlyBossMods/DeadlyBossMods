local mod	= DBM:NewMod("GeneralHusam", "DBM-Party-Cataclysm", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision:$"):sub(12, -3))
mod:SetCreatureID(44577)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warnShockwave 	= mod:NewCastAnnounce(83445, 3)

local timerShockwave	= mod:NewCastTimer(5, 83445)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(83445) then
		warnShockwave:Show()
		timerShockwave:Start()
	end
end