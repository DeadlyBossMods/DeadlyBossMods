local mod	= DBM:NewMod(99, "DBM-Party-Cataclysm", 6, 64)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(46963)
mod:SetModelID(34612)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)

local warnFrostMix		= mod:NewSpellAnnounce(93702, 3)
local warnIceShards		= mod:NewSpellAnnounce(93527, 3)
local warnPoisonMix		= mod:NewSpellAnnounce(93704, 3)
local warnGreenMix		= mod:NewSpellAnnounce(93617, 4)
local warnRedMix		= mod:NewSpellAnnounce(93689, 4)

local specWarnGreenMix	= mod:NewSpecialWarning("specWarnCoagulant", nil, false)
local specWarnRedMix	= mod:NewSpecialWarning("specWarnRedMix", nil, false)
mod:AddBoolOption("RedLightGreenLight", true, "announce")

local timerIceShards	= mod:NewBuffActiveTimer(5, 93527)
local timerRedMix		= mod:NewBuffActiveTimer(10, 93689)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(93527) then
		warnIceShards:Show()
		timerIceShards:Start()
	elseif args:IsSpellID(93689) and self:AntiSpam(4, 1) then--Red Light
		warnRedMix:Show()
		timerRedMix:Start()
		if self.Options.RedLightGreenLight then
			specWarnRedMix:Show()
		end
	elseif args:IsSpellID(93617) and self:AntiSpam(10, 2) then--Green Light
		warnGreenMix:Show()
		if self.Options.RedLightGreenLight then
			specWarnGreenMix:Show()
		end
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