local mod	= DBM:NewMod("IngvarThePlunderer", "DBM-Party-WotLK", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(23980, 23954)
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellCombatEnd)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warningSmash		= mod:NewSpellAnnounce(42723, 1)
local warningGrowl		= mod:NewSpellAnnounce(42708, 3)
local warningWoeStrike	= mod:NewTargetAnnounce(42730, 2)
local timerSmash		= mod:NewCastTimer(3, 42723)
local timerWoeStrike	= mod:NewTargetTimer(10, 42723)

local specWarnSpelllock	= mod:NewSpecialWarningCast(42729)


function mod:SPELL_CAST_START(args)
	if args:IsSpellID(42723, 42669, 59706) then
		warningSmash:Show()
		timerSmash:Start()
	elseif args:IsSpellID(42708, 42729, 59708, 59734) then
		warningGrowl:Show()
	end
	if args:IsSpellID(42729, 59734) then
		specWarnSpelllock:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(42730, 59735) then
		warningWoeStrike:Show(args.destName)
		timerWoeStrike:Start(args.destName)
		mod:SetIcon(args.destName, 8, 10)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(42730, 59735) then
		timerWoeStrike:Cancel()
	end
end