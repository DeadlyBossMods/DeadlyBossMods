local mod = DBM:NewMod("Confessor", "DBM-Party-WotLK", 13)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 559 $"):sub(12, -3))
mod:SetCreatureID(34928)
--mod:SetZone()

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.YellCombatEnd)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local isDispeller = select(2, UnitClass("player")) == "MAGE"
				 or select(2, UnitClass("player")) == "PRIEST"
				 or select(2, UnitClass("player")) == "SHAMAN"

local warnReflectiveShield	= mod:NewAnnounce("warnReflectiveShield")
local warnRenew				= mod:NewSpellAnnounce(66537)
local specwarnRenew			= mod:NewSpecialWarning("specwarnRenew", isDispeller)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(66537, 67675) then					-- Renew
		warnRenew:Show(args.destName)
		specwarnRenew:Show(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(66515) then							-- Shield Gained
		warnReflectiveShield:Show(args.spellName)
	end
end


