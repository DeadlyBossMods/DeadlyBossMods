local mod	= DBM:NewMod("Azshara", "DBM-Party-Cataclysm", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(54853)
mod:SetModelID(39391)
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Kill)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnServant		= mod:NewSpellAnnounce(102334, 4)
local warnObedience		= mod:NewSpellAnnounce(103241, 4)
local warnAdds			= mod:NewAnnounce("WarnAdds", 3)

local specWarnServant	= mod:NewSpecialWarningSpell(102334, nil, nil, nil, true)
local specWarnObedience	= mod:NewSpecialWarningInterrupt(103241)

local timerServantCD	= mod:NewCDTimer(26, 102334)--Still don't have good logs, and encounter bugs a lot so i can't get any reliable timers except for first casts on engage.
local timerObedienceCD	= mod:NewCDTimer(37, 103241)
local timerAdds		= mod:NewTimer(42, "TimerAdds")

function mod:Adds()
	timerAdds:Start()
	warnAdds:Schedule(37)
	self:ScheduleMethod(42, "Adds")
end

function mod:OnCombatStart(delay)
	timerServantCD:Start(24-delay)
	timerObedienceCD:Start(36-delay)
	timerAdds:Start(18-delay)
	warnAdds:Schedule(14-delay)
	self:ScheduleMethod(18, "Adds")
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(103241) then
		warnObedience:Show()
		specWarnObedience:Show()
--		timerObedienceCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if uId ~= "boss1" then return end--Anti spam to ignore all other args (like target/focus/mouseover)
	if spellName == GetSpellInfo(102334) then
		warnServant:Show()
		specWarnServant:Show()
--		timerServantCD:Start()
	end
end