local mod	= DBM:NewMod(179, "DBM-Party-Cataclysm", 11, 76)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5749 $"):sub(12, -3))
mod:SetCreatureID(52269)
mod:SetModelID(37830)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warnVanish			= mod:NewSpellAnnounce(96639, 3)
local warnBlades			= mod:NewSpellAnnounce(96646, 4)

local specWarnBlades		= mod:NewSpecialWarningRun(96646)

local timerBlades			= mod:NewBuffActiveTimer(11, 96646)--3sec cast + 8 sec duration
local timerBladesCD			= mod:NewCDTimer(45, 96646)--Speculated, since log only cast it twice.
local timerVanishCD			= mod:NewCDTimer(46.5, 96639)--Speculated, since log only cast it twice.
local timerAmbush			= mod:NewNextTimer(2.5, 96640)--2.5 seconds after vanish.

local soundBlades			= mod:NewSound(96646)

function mod:OnCombatStart(delay)
	timerVanishCD:Start(15-delay)--Consistent?
	timerBladesCD:Start(34-delay)--^^
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(96646) then
        warnBlades:Show()
        specWarnBlades:Show()
        soundBlades:Play()
		timerBlades:Start()
		timerBladesCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(96639) then
		warnVanish:Show()
		timerVanishCD:Start()
		timerAmbush:Start()
	end
end