local mod	= DBM:NewMod("Confessor", "DBM-Party-WotLK", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(34928)
--mod:SetZone()

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.YellCombatEnd)

mod:RegisterEvents(
   "SPELL_AURA_APPLIED",
   "SPELL_AURA_REMOVED"
)

local isDispeller = select(2, UnitClass("player")) == "MAGE"
             or select(2, UnitClass("player")) == "PRIEST"
             or select(2, UnitClass("player")) == "SHAMAN"

local warnReflectiveShield	= mod:NewTargetAnnounce(66515)
local warnRenew				= mod:NewTargetAnnounce(66537)
local warnOldWounds			= mod:NewTargetAnnounce(67679)
local timerOldWounds		= mod:NewTargetTimer(12, 67679)
local warnHolyFire			= mod:NewTargetAnnounce(67676)
local timerHolyFire			= mod:NewTargetTimer(8, 67676)
local specwarnRenew			= mod:NewSpecialWarning("specwarnRenew", isDispeller)

local shielded				= false

function mod:OnCombatStart(delay)
   shielded = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(66515) then                     -- Shield Gained
		warnReflectiveShield:Show(args.destName)
		shielded = true
	elseif args:IsSpellID(66537, 67675) and not args:IsDestTypePlayer() then               -- Renew
		warnRenew:Show(args.destName)
		if args.destName == L.name and shielded then
			-- nothing, she casted it on herself and you cant dispel
		else
			specwarnRenew:Show(args.destName)
		end
	elseif args:IsSpellID(66620, 67679) then                     -- Old Wounds
		warnOldWounds:Show(args.destName)
		timerOldWounds:Show(args.destName)
	elseif args:IsSpellID(66538, 67676) then                     -- Holy Fire
		warnHolyFire:Show(args.destName)
		timerHolyFire:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(66515) then
		shielded = false
	end
end