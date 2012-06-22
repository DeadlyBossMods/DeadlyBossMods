local mod	= DBM:NewMod("KarshSteelbender", "DBM-Party-Cataclysm", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39698)
mod:SetModelID(31710)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"	
)

local warnObsidianArmor		= mod:NewSpellAnnounce(75842, 2)
local warnSuperheated		= mod:NewCountAnnounce(75846, 3)

local timerSuperheated		= mod:NewTimer(17, "TimerSuperheated", 75846)

local specWarnSuperheated	= mod:NewSpecialWarningStack(75846, mod:IsTank(), 5)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(75842) then
		warnObsidianArmor:Show()
	elseif args:IsSpellID(75846, 93567) then
		timerSuperheated:Cancel()--Cancel any previous timer before starting new one. No args means it'll cancel any timer with name "timerSuperheated"
		timerSuperheated:Start(17, args.amount or 1)
		if self:AntiSpam(3) then
			warnSuperheated:Show(args.amount or 1)
			if args.amount and args.amount >= 5 then
				specWarnSuperheated:Show(args.amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
