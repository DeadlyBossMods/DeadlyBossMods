local mod = DBM:NewMod("Ignis", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(33118)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnFlameJetsCast			= mod:NewSpecialWarning("SpecWarnJetsCast")
local timerFlameJetsCast		= mod:NewCastTimer(2.7, 63472)
local timerFlameJetsCooldown		= mod:NewCDTimer(35, 63472)
local timerScorchCooldown		= mod:NewNextTimer(25, 63473)
local timerScorchCast			= mod:NewCastTimer(3, 63473)

local announceSlagPot			= mod:NewAnnounce("WarningSlagPot", 3, 63477)
local timerSlagPot			= mod:NewTargetTimer(10, 63477)

local timerAchieve			= mod:NewAchievementTimer(240, 2930, "TimerSpeedKill")

mod:AddBoolOption("SlagPotIcon")

function mod:OnCombatStart(delay)
	timerAchieve:Start()
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


