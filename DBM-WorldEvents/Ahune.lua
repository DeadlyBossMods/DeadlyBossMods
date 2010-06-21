local mod	= DBM:NewMod("Ahune", "DBM-WorldEvents")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(25740)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnSubmerged				= mod:NewAnnounce("Submerged", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnEmerged				= mod:NewAnnounce("Emerged", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")

local specWarnAttack			= mod:NewSpecialWarning("specWarnAttack")

local timerSubmerge				= mod:NewTimer(40, "SubmergTimer", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local timerEmerge				= mod:NewTimer(95, "EmergeTimer", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local timerAttack				= mod:NewTimer(45, "AttackTimer", 2457)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(45954) then				-- Ahunes Shield
		warnEmerged:Show()
		timerEmerge:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(45954) then				-- Ahunes Shield
		warnSubmerged:Show()
		timerSubmerge:Start()
		specWarnAttack:Show()
		timerAttack:Start()
	end
end