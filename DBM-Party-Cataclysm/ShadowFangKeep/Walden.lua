local mod	= DBM:NewMod("Walden", "DBM-Party-Cataclysm", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(46963)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)

local warnFrostMix	= mod:NewSpellAnnounce(93702, 3)
local warnIceShards	= mod:NewSpellAnnounce(93527, 3)
local warnPoisonMix	= mod:NewSpellAnnounce(93704, 4)
--local warnRedMix	= mod:NewSpellAnnounce(93704, 4)--don't know spellid yet

local specWarnCoagulant	= mod:NewSpecialWarningMove(93617)
--local specWarnRedMix	= mod:NewSpecialWarning("DoNOTMove")--Need a combat log i keep forgetting and wowhead doesn't have it catagorized.

local timerIceShards	= mod:NewBuffActiveTimer(5, 93527)

local lastCoagulant = 0

function mod:OnCombatStart(delay)
	lastCoagulant = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(93527) then
		warnIceShards:Show()
		timerIceShards:Start()
	elseif args:IsSpellID(93617) and args:IsPlayer() and GetTime() - lastCoagulant > 4 then
		specWarnCoagulant:Show()
		lastCoagulant = GetTime()
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93702) then
		warnFrostMix:Show()
	elseif args:IsSpellID(93704) then
		warnPoisonMix:Show()
	end
end