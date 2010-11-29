local mod	= DBM:NewMod("Atramedes", "DBM-BlackwingDescent", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(41442)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL"
)

local warnSonicBreath		= mod:NewSpellAnnounce(78075, 3)
local warnAirphase			= mod:NewAnnounce("WarnAirphase", 3)
local warnGroundphase		= mod:NewAnnounce("WarnGroundphase", 3)
local warnShieldsLeft		= mod:NewAnnounce("WarnShieldsLeft", 3, 77611)

local timerSonicBreath		= mod:NewCDTimer(41, 78075)
local timerSearingFlame		= mod:NewNextTimer(50, 77840)
local timerAirphase			= mod:NewTimer(90, "TimerAirphase")
local timerGroundphase		= mod:NewTimer(35, "TimerGroundphase")

local shieldsLeft = 10

local groundphase = function()
	timerAirphase:Start()
	timerSonicBreath:Start(28)
	timerSearingFlame:Start()
end

function mod:OnCombatStart(delay)
	timerSonicBreath:Start(25-delay)
	timerSearingFlame:Start(45-delay)
	shieldsLeft = 10
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(78075) then
		timerSonicBreath:Start()
		warnSonicBreath:Show()
	elseif args:IsSpellID(77840) then
		warnSearingFlame:Show()
	elseif args:IsSpellID(77611) then
		shields = shields - 1
		warnShieldsLeft:Show(shields)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Airphase then
		warnAirphase:Show()
		timerSonicBreath:Cancel()
		timerSearingFlame:Cancel()
		timerGroundphase:Start()
		self:Schedule(35, groundphase())
	end
end