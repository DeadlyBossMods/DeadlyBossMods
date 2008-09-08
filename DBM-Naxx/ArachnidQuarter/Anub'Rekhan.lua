local mod = DBM:NewMod("Anub'Rekhan", "DBM-Naxx", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15956)
mod:SetZone(GetAddOnMetadata("DBM-Naxx", "X-DBM-Mod-LoadZone"))

mod:RegisterCombat("combat")


mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_REMOVED"
)

local specialWarningLocust	= mod:NewSpecialWarning("SpecialLocust")
local warningLocustSoon		= mod:NewAnnounce("WarningLocustSoon", 2, 28785)
local warningLocustNow		= mod:NewAnnounce("WarningLocustNow", 3, 28785)
local warningLocustFaded	= mod:NewAnnounce("WarningLocustFaded", 1, 28785)

local timerLocustIn			= mod:NewTimer(77, "TimerLocustIn", 28785)
local timerLocustFade 		= mod:NewTimer(19, "TimerLocustFade", 28785)


function mod:OnCombatStart(delay)
	timerLocustIn:Start(90 - delay)
	warningLocustSoon:Schedule(75 - delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 28785 then -- Locust Swarm
		warningLocustNow:Show()
		specialWarningLocust:Show()
		timerLocustIn:Stop()
		timerLocustFade:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 28785 and args.auraType == "BUFF" then -- Locust Swarm
		warningLocustFaded:Show()
		timerLocustIn:Start()
		warningLocustSoon:Schedule(62)
	end
end

