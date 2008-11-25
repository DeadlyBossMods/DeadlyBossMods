local mod = DBM:NewMod("ChronoLordEpoch", "DBM-Party-WotLK", 3)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26532)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

local warningTime = mod:NewAnnounce("WarningTime", 3, 58848)
local warningStrike = mod:NewAnnounce("WarningStrike", 3, 52771)
local warningCurse = mod:NewAnnounce("WarningCurse", 3, 52772)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 58848 then
		warningTime:Show("Stop")
	elseif args.spellId == 52766 then
		warningTime:Show("Warp")
	elseif args.spellId == 52771 or args.spellId == 58830 then
		warningStrike:Show(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 52772 then
		warningCurse:Show(args.destName)
	end
end