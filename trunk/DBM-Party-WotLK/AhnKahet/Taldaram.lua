local mod = DBM:NewMod("Taldaram", "DBM-Party-WotLK", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 106 $"):sub(12, -3))
mod:SetCreatureID(29308)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_SUMMON",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warningEmbrace		= mod:NewAnnounce("WarningEmbrace", 3, 55959)
local warningFlame		= mod:NewAnnounce("WarningFlame", 3, 55931)

local timerEmbrace		= mod:NewTimer(20, "TimerEmbrace", 55959)

function mod:SPELL_SUMMON(args)
	if args.spellId	== 55931 then
		warningFlame:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 55959 then
		warningEmbrace:Show(args.destName)
		timerEmbrace:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 55959 then
		timerEmbrace:Cancel()
	end
end