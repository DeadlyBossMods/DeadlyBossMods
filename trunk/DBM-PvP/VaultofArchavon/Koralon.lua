local mod	= DBM:NewMod("Koralon", "DBM-PvP", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2521 $"):sub(12, -3))
mod:SetCreatureID(35013)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)

local warnBreath			= mod:NewSpellAnnounce(67328)
local timerBreath			= mod:NewBuffActiveTimer(4.5, 67328)
local timerBreathCD			= mod:NewCDTimer(45, 67328)--Seems to variate, but 45sec cooldown looks like a good testing number to start.

local warnMeteor			= mod:NewSpellAnnounce(67333, 3)
local warnMeteorSoon		= mod:NewPreWarnAnnounce(68161, 5, 1)
local timerNextMeteor		= mod:NewNextTimer(47, 68161)
local WarnBurningFury		= mod:NewAnnounce("BurningFury", 3)
local timerNextBurningFury	= mod:NewNextTimer(20, 66721)

local specWarnCinder		= mod:NewSpecialWarning("SpecWarnCinder")

local timerKoralonEnrage	= mod:NewTimer(300, "KoralonEnrage", 26662)

mod:AddBoolOption("PlaySoundOnCinder")

function mod:OnCombatStart(delay)
	timerKoralonEnrage:Start(-delay)
	timerNextMeteor:Start(-delay)
	timerBreathCD:Start(12-delay)
	warnMeteorSoon:Schedule(42-delay)
	timerNextBurningFury:Start()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(67328, 66665) then
		warnBreath:Show()
		timerBreath:Start()
		timerBreathCD:Start()
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
	elseif args:IsSpellID(66721) then
		WarnBurningFury:Show(args.amount)
		timerNextBurningFury:Start()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(66721) then		-- Burning Fury
		WarnBurningFury:Show(args.amount)
		timerNextBurningFury:Start()
	end
end