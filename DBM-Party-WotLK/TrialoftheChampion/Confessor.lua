local mod = DBM:NewMod("Confessor", "DBM-Party-WotLK", 13)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 559 $"):sub(12, -3))
mod:SetCreatureID(34928)
--mod:SetZone()

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.YellCombatEnd)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local isDispeller = select(2, UnitClass("player")) == "MAGE"
				 or select(2, UnitClass("player")) == "PRIEST"
				 or select(2, UnitClass("player")) == "SHAMAN"

local warnReflectiveShield	= mod:NewSpellAnnounce(66515)
local warnRenew				= mod:NewSpellAnnounce(66537)
--local specwarnRenew			= mod:NewSpecialWarning("specwarnRenew", isDispeller) Commented out for time being do to it's spaming when it's wrong. Still needs to be redone to make it only warn for dispel if it's on a target that is NOT shielded by 66515. Currently it spams for dispels even when it's not dispelable.

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(66515) then							-- Shield Gained
		warnReflectiveShield:Show(args.destName)
	elseif args:IsSpellID(66537, 67675) then					-- Renew
		warnRenew:Show(args.destName)
--		specwarnRenew:Show(args.destName)
	end
end


