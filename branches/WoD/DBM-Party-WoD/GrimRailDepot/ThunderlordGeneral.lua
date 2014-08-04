local mod	= DBM:NewMod(1133, "DBM-Party-WoD", 3, 536)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(80005)
mod:SetEncounterID(1736)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 162066 162058",
	"SPELL_PERIODIC_DAMAGE 161588",
	"SPELL_PERIODIC_MISSED 161588"
)


local warnFreezingSnare			= mod:NewSpellAnnounce(162066, 3)
local warnThunderousBreath		= mod:NewSpellAnnounce(119374, 4)
local warnSpinningSpear			= mod:NewSpellAnnounce(162058, 3)

local specWarnFreezingSnare		= mod:NewSpecialWarningSpell(162066)
local specWarnThunderousBreath	= mod:NewSpecialWarningSpell(161801, nil, nil, nil, 2)
local specWarnDiffusedEnergy	= mod:NewSpecialWarningMove(161588)

local timerFreezingSnareCD		= mod:NewNextTimer(17, 162066)
local timerThunderousBreath		= mod:NewNextTimer(17, 161801)

function mod:OnCombatStart(delay)
	timerFreezingSnareCD:Start(5.5-delay)
	timerThunderousBreath:Start(11-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 162066 then
		warnFreezingSnare:Show()
		specWarnFreezingSnare:Show()
		timerFreezingSnareCD:Start()
		--Because using SPELL_CAST_SUCCESS is a bit ugly and it's always 5-6 sec after trap anyways
		warnThunderousBreath:Schedule(5)
		specWarnThunderousBreath:Schedule(5)
		timerThunderousBreath:Schedule(5)
	elseif args.spellId == 162066 then
		warnSpinningSpear:Show()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 161588 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnDiffusedEnergy:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
