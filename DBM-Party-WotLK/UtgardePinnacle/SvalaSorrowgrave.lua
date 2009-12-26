local mod	= DBM:NewMod("SvalaSorrowgrave", "DBM-Party-WotLK", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26668)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warningSacrifice	= mod:NewTargetAnnounce(48267, 2)
local timerSacrifice	= mod:NewBuffActiveTimer(25, 48276)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(48267) then
		warningSacrifice:Show(args.destName)
	elseif args:IsSpellID(48276) then
		timerSacrifice:Start()
	end
end