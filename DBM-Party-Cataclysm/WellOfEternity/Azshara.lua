local mod	= DBM:NewMod("Azshara", "DBM-Party-Cataclysm", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(54853)
mod:SetModelID(39391)
mod:SetZone()

mod:RegisterCombat("combat")
--Needs working kill detection, right now always wipes on victories, my logging failed and i didn't get what i need. maybe another time.

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnServant		= mod:NewSpellAnnounce(102334, 4)
local warnObedience		= mod:NewSpellAnnounce(103241, 4)

local specWarnServant	= mod:NewSpecialWarningSpell(102334, nil, nil, nil, true)
local specWarnObedience	= mod:NewSpecialWarningInterrupt(103241)

local timerServantCD	= mod:NewCDTimer(26, 102334)--Still don't have good logs, and encounter bugs a lot so i can't get any reliable timers except for first casts on engage.
local timerObedienceCD	= mod:NewCDTimer(37, 103241)

function mod:OnCombatStart(delay)
	timerServantCD:Start(24-delay)
	timerObedienceCD:Start(36-delay)
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