local mod	= DBM:NewMod("Koralon", "DBM-Battlegrounds")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(35013)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)


local enrageTimer	= mod:NewEnrageTimer(300)

local warnBreath	= mod:NewSpellAnnounce(66665)
local timerBreath	= mod:NewBuffActiveTimer(4.5, 66665)

local warnMeteor		= mod:NewSpellAnnounce(67331, 3, 66809)
local warnMeteorSoon	= mod:NewPreWarnAnnounce(67331, 5, 1, 66809)
local timerNextMeteor	= mod:NewNextTimer(47, 66725, nil, nil, nil, 66809)

local specWarnCinder	= mod:NewSpecialWarning("SpecWarnCinder")
mod:AddBoolOption("PlaySoundOnCinder")

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerNextMeteor:Start(-delay)
	warnMeteorSoon:Schedule(42 - delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(67328, 66665) then
		warnBreath:Show()
		timerBreath:Start()
	elseif args:IsSpellID(66725, 68161) and self:IsInCombat() then
		warnMeteor:Show()
		timerNextMeteor:Start()
		warnMeteorSoon:Schedule(42)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsPlayer() and args:IsSpellID(66684, 67332) then
		specWarnCinder:Show()
		if self.Options.PlaySoundOnCinder then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end