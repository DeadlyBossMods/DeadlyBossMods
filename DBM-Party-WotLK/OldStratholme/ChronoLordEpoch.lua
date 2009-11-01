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

local warningTime 	= mod:NewSpellAnnounce(58848, 3)
local warningCurse 	= mod:NewTargetAnnounce(52772, 2)
local timerCurse	= mod:NewTargetTimer(10, 52772)
local timerTimeCD	= mod:NewCDTimer(25, 58848)

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(58848, 52766)  then
		warningTime:Show()
		timerTimeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(52772) then
		warningCurse:Show(args.destName)
		timerCurse:Start(args.destName)
	end
end