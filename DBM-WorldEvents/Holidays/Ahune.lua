local mod	= DBM:NewMod("d286", "DBM-WorldEvents", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(25740)--25740 Ahune, 25755, 25756 the two types of adds
mod:SetModelID(23447)--Frozen Core, ahunes looks pretty bad.

mod:SetReCombatTime(10)
mod:RegisterCombat("combat")
mod:SetMinCombatTime(15)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 45954",
	"SPELL_AURA_REMOVED 45954"
)

local warnSubmerged				= mod:NewSpellAnnounce(37751, 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnEmerged				= mod:NewAnnounce("Emerged", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")

local specWarnAttack			= mod:NewSpecialWarning("specWarnAttack", nil, nil, nil, 1, 2)

local timerEmerge				= mod:NewTimer(33.5, "EmergeTimer", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6)
local timerSubmerge				= mod:NewTimer(92, "SubmergeTimer", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", nil, nil, 6)--Variable, 92-96

function mod:OnCombatStart(delay)
	if self:AntiSpam(4, 1) then
		timerSubmerge:Start(95-delay)--first is 95, rest are 92
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 45954 and self:AntiSpam(4, 1) then -- Ahunes Shield
		warnEmerged:Show()
		timerSubmerge:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 45954 then -- Ahunes Shield
		warnSubmerged:Show()
		timerEmerge:Start()
		specWarnAttack:Show()
		specWarnAttack:Play("changetarget")
	end
end
