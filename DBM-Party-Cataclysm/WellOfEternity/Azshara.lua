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
local timerAdds			= mod:NewTimer(36, "TimerAdds")

local addsCount = 0
function mod:Adds()
	addsCount = addsCount + 1
	if addsCount == 3 then return end
	timerAdds:Start()
	warnAdds:Schedule(31)
	self:ScheduleMethod(36, "Adds")
end

function mod:OnCombatStart(delay)
	timerServantCD:Start(24-delay)
	timerObedienceCD:Start(36-delay)
	timerAdds:Start(17-delay)
	warnAdds:Schedule(14-delay)
	self:ScheduleMethod(17, "Adds")
	addsCount = 0
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(103241) then
		warnObedience:Show()
		specWarnObedience:Show(args.sourceName)
--		timerObedienceCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 102334 and self:AntiSpam() then
		warnServant:Show()
		specWarnServant:Show()
--		timerServantCD:Start()
	end
end