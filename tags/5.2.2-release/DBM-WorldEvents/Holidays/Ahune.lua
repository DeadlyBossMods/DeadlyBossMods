local mod	= DBM:NewMod("Ahune", "DBM-WorldEvents", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(25740)--25740 Ahune, 25755, 25756 the two types of adds
mod:SetModelID(23447)--Frozen Core, ahunes looks pretty bad.
mod:RegisterCombat("say", L.Pull)
mod:SetMinCombatTime(15)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnSubmerged				= mod:NewAnnounce("Submerged", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnEmerged				= mod:NewAnnounce("Emerged", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")

local specWarnAttack			= mod:NewSpecialWarning("specWarnAttack")

local timerCombatStart			= mod:NewTimer(10, "TimerCombat", 2457)--rollplay for first pull
local timerEmerge				= mod:NewTimer(40, "EmergeTimer", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local timerSubmerge				= mod:NewTimer(95, "SubmergTimer", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")

function mod:OnCombatStart(delay)
	timerCombatStart:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 45954 then				-- Ahunes Shield
		warnEmerged:Show()
		timerSubmerge:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 45954 then				-- Ahunes Shield
		warnSubmerged:Show()
		timerEmerge:Start()
		specWarnAttack:Show()
	end
end