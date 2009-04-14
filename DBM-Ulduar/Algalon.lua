local mod = DBM:NewMod("Algalon", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID() -- ??
mod:SetZone()

-- disclaimer: we never did this boss on the PTR, this boss mod is based on combat logs and movies. This boss mod might be completely wrong or broken, we will replace it with an updated version asap


mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local timerBigBangCast		= mod:NewTimer(8, "TimerBigBangCast", 64584)
local announceBlackHole		= mod:NewAnnounce("WarningBlackHole", 2, 65108)
local announcePhasePunch	= mod:NewAnnounce("WarningPhasePunch", 4, 65108)
local specWarnPhasePunch	= mod:NewSpecialWarning("SpecWarnPhasePunch")


function mod:SPELL_CAST_START(args)
	if args.spellId == 65108 then 	-- Black Hole Explosion
		announceBlackHole:Show()

	--elseif args.spellId == 62311 then	-- Cosmic Smash
	--elseif args.spellId == 64395 then	-- Quantum Strike
	--elseif args.spellId == 64412 then 	-- Phase Punch

	elseif args.spellId == 64584 then 	-- Big Bang
		timerBigBangCast:Start()
	end
end


function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 64412 then
		if args.destName == UnitName("player") then
			specWarnPhasePunch:Show()
		end
		announcePhasePunch:Show(args.destName)
	end
end

