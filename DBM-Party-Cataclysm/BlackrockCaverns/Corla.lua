local mod	= DBM:NewMod("Corla", "DBM-Party-Cataclysm", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39679)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_INTERRUPT"
)

local warnDarkCommandCast	= mod:NewCastAnnounce(75823, 3)
local warnDarkCommand		= mod:NewTargetAnnounce(75823, 4)
local warnShadowStrike		= mod:NewSpellAnnounce(82362, 3)
local warnAdd				= mod:NewAnnounce("WarnAdd", 4)

local timerDarkCommandCast	= mod:NewCastTimer(4, 75823)
local timerDarkCommand		= mod:NewTargetTimer(4, 75823)
local timerDarkCommandCD	= mod:NewCDTimer(25, 75823)
local timerShadowStrike		= mod:NewCastTimer(2, 82362)
local timerEvolution		= mod:NewBuffActiveTimer(20, 75697)

local specWarnShadowStrike	= mod:NewSpecialWarningInterrupt(82362)
local specWarnDarkCommand	= mod:NewSpecialWarningInterrupt(93462)
local specWarnEvolution		= mod:NewSpecialWarningStack(75697, true, 80)

local spamEvolution = 0

function mod:OnCombatStart(delay)
	spamEvolution = 0
	timerDarkCommandCD:Start(22-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(75823, 93462) then
		warnDarkCommand:Show(args.destName)
		timerDarkCommand:Start(args.destName)
	elseif args:IsSpellID(75697, 87378) and args:IsPlayer() then
		timerEvolution:Start()
		if (args.amount or 1) >= 80 and GetTime() - spamEvolution > 5 then
			specWarnEvolution:Show(args.amount)
			spamEvolution = GetTime()
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(75608) then
		warnAdd:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(75823, 93462) then
		warnDarkCommandCast:Show()
		specWarnDarkCommand:Show()
		timerDarkCommandCast:Start()
		timerDarkCommandCD:Start()
	elseif args:IsSpellID(82362, 87374) then
		warnShadowStrike:Show()
		specWarnShadowStrike:Show()
		if mod:IsDifficulty("heroic5") then
			timerShadowStrike:Start()
		else
			timerShadowStrike:Start(3)
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and (args.extraSpellId == 82362 or args.extraSpellId == 87374) then
		timerShadowStrike:Cancel()
	elseif type(args.extraSpellId) == "number" and (args.extraSpellId == 75823 or args.extraSpellId == 93462) then
		timerDarkCommandCast:Cancel()
	end
end