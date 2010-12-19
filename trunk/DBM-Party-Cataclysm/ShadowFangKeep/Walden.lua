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
local warnRedMix	= mod:NewSpellAnnounce(93562, 4)

local specWarnCoagulant	= mod:NewSpecialWarning("specWarnCoagulant", nil, false)
local specWarnRedMix	= mod:NewSpecialWarning("specWarnRedMix", nil, false)
mod:AddBoolOption("RedLightGreenLight", true, "announce")

local timerIceShards	= mod:NewBuffActiveTimer(5, 93527)
local timerGreenMix		= mod:NewBuffActiveTimer(16.5, 93704)--It's 15 second buff plus 1.5sec cast. using 16.5 to be safe.
local timerRedMix		= mod:NewBuffActiveTimer(12, 93562)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(93527) then
		warnIceShards:Show()
		timerIceShards:Start()
	elseif args:IsSpellID(93562) then--Red Light
		warnRedMix:Show()
		timerRedMix:Start()
		if self.Options.RedLightGreenLight then
			specWarnRedMix:Show()
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93702) then
		warnFrostMix:Show()
	elseif args:IsSpellID(93704) then--Green Light
		warnPoisonMix:Show()
		timerGreenMix:Start()
		if self.Options.RedLightGreenLight then
			specWarnCoagulant:Show()
		end
	end
end