local mod	= DBM:NewMod("Omen", "DBM-WorldEvents", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15467)
mod:SetModelID(15879)
mod:SetZone(241)--Moonglade

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED"
)

local warnCleave				= mod:NewSpellAnnounce(104903, 2)
local warnStarfall				= mod:NewSpellAnnounce(26540, 3)

local specWarnStarfall			= mod:NewSpecialWarningMove(26540)

local timerCleaveCD				= mod:NewCDTimer(8.5, 104903)
local timerStarfallCD			= mod:NewCDTimer(15, 26540)

function mod:OnCombatStart(delay)
	timerCleaveCD:Start(10.5-delay)--Consistent?
	timerStarfallCD:Start(11-delay)--^?
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 104903 then
		warnCleave:Show()
		timerCleaveCD:Start()
	elseif args.spellId == 26540 then
		warnStarfall:Show()
		timerStarfallCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId)
	if spellId == 26540 and destGUID == UnitGUID("player") and self:AntiSpam(3) then
		specWarnStarfall:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
