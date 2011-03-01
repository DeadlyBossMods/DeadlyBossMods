local mod	= DBM:NewMod("CommanderUlthok", "DBM-Party-Cataclysm", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(40765)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warnDarkFissure		= mod:NewSpellAnnounce(76047, 4)
local warnSqueeze		= mod:NewTargetAnnounce(76026, 3)
local warnEnrage		= mod:NewSpellAnnounce(76100, 2)
local warnCurse			= mod:NewTargetAnnounce(76094, 2)

local timerDarkFissure		= mod:NewCastTimer(2, 76047)
local timerDarkFissureCD	= mod:NewCDTimer(20, 76047)
local timerSqueeze		= mod:NewTargetTimer(6, 76026)
local timerSqueezeCD		= mod:NewCDTimer(29, 76026)
local timerEnrage		= mod:NewBuffActiveTimer(10, 76100)
local timerEnrageCast		= mod:NewCastTimer(2.5, 76100)
local timerCurse		= mod:NewTargetTimer(15, 76094)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(76094) then
		warnCurse:Show(args.destName)
		timerCurse:Start(args.destName)
	elseif args:IsSpellID(76100) then
		timerEnrage:Start()
	elseif args:IsSpellID(76026, 91484) then
		warnSqueeze:Show(args.destName)
		timerSqueeze:Start(args.destName)
		timerSqueezeCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(76094) then
		timerCurse:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(76047) then
		warnDarkFissure:Show()
		timerDarkFissure:Start()
		timerDarkFissureCD:Start()
	elseif args:IsSpellID(76100) then
		warnEnrage:Show()
		timerEnrageCast:Start()
	end
end