local mod	= DBM:NewMod("Omen", "DBM-WorldEvents", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15467)
mod:SetModelID(15879)
mod:SetReCombatTime(10)
mod:SetZone(1)--Kalimdor

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 104903 26540",
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
	local spellId = args.spellId
	if spellId == 104903 then
		warnCleave:Show()
		timerCleaveCD:Start()
	elseif spellId == 26540 then
		warnStarfall:Show()
		timerStarfallCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 26540 and destGUID == UnitGUID("player") and self:AntiSpam(3) then
		specWarnStarfall:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
