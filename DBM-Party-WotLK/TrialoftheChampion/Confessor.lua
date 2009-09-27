local mod = DBM:NewMod("Confessor", "DBM-Party-WotLK", 13)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 559 $"):sub(12, -3))
mod:SetCreatureID(34928)
--mod:SetZone()

mod:RegisterCombat("combat")
--	shielded = false

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local isDispeller = select(2, UnitClass("player")) == "MAGE"
              or select(2, UnitClass("player")) == "PRIEST"
              or select(2, UnitClass("player")) == "SHAMAN"

local warnReflectiveShield	= mod:NewAnnounce("warnReflectiveShield")
local warnRenew	= mod:NewAnnounce("warnRenew")
local specwarnRenew	= mod:NewSpecialWarning("specwarnRenew", isDispeller)

function mod:SPELL_CAST_START(args)
--	if args:IsSpellID(66537, 67675) and shielded == false then							-- Renew
	if args:IsSpellID(66537, 67675) then							-- Renew
		warnRenew:Show(args.destName)
		specwarnRenew:Show(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(66515) then							-- Shield Gained
		warnReflectiveShield:Show(args.spellName)
--			shielded = true
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(66515) then							-- Shield Lost
--			shielded = false
	end
end

--Comment note, she usually spams add with renew and not herself so I felt it prudent to warn on renew. But be adviced if she does heal herself at first, it cannot be dispelled and it will warn on dbm anyways. I need to find a better way to handle it so it won't warn if she casts on self but will if she casts on add, while shielded.