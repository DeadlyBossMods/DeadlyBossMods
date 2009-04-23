local mod = DBM:NewMod("Ignis", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(33118)
mod:SetZone()



mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnFlameJetsCast			= mod:NewSpecialWarning("SpecWarnJetsCast")	-- spell interrupt (according to the tooltip)
local timerFlameJetsCast		= mod:NewTimer(2.7, "TimerFlameJetsCast", 63472)
local timerFlameJetsCooldown	= mod:NewTimer(35, "TimerFlameJetsCooldown", 63472)

local timerScorchCooldown	= mod:NewTimer(25, "TimerScorch", 63473)
local timerScorchCast		= mod:NewTimer(3, "TimerScorchCast", 63473)

local announceSlagPot		= mod:NewAnnounce("WarningSlagPot", 3, 63477)
local timerSlagPot			= mod:NewTimer(10, "TimerSlagPot", 63477)


mod:AddBoolOption("SlagPotIcon")

function mod:OnCombatStart(delay)
	timerScorchCooldown:Start(12-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 62680  or args.spellId == 63472 then		-- Flame Jets
		timerFlameJetsCast:Start()
		warnFlameJetsCast:Show()
		timerFlameJetsCooldown:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 62548 or args.spellId == 63474 then	-- Scorch
		timerScorchCast:Start()
		timerScorchCooldown:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62717 or args.spellId == 63477 then		-- Slag Pot
		announceSlagPot:Show(args.destName)
		timerSlagPot:Start(args.destName)
		if self.Options.SlagPotIcon then
			self:SetIcon(args.destName, 8, 10)
		end
	end
end


