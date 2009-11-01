local mod = DBM:NewMod("Anub'Rekhan", "DBM-Naxx", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15956)

mod:RegisterCombat("combat")

mod:EnableModel()

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_REMOVED"
)

local specialWarningLocust	= mod:NewSpecialWarning("SpecialLocust")
local warningLocustSoon		= mod:NewAnnounce("WarningLocustSoon", 2, 28785)
local warningLocustNow		= mod:NewAnnounce("WarningLocustNow", 3, 28785)
local warningLocustFaded	= mod:NewAnnounce("WarningLocustFaded", 1, 28785)

local timerLocustIn			= mod:NewTimer(80, "TimerLocustIn", 28785)
local timerLocustFade 		= mod:NewTimer(26, "TimerLocustFade", 28785)


function mod:OnCombatStart(delay)
	if mod:IsDifficulty("heroic25") then
		timerLocustIn:Start(90 - delay)
		warningLocustSoon:Schedule(75 - delay)
	else
		timerLocustIn:Start(91 - delay)
		warningLocustSoon:Schedule(76 - delay)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(28785, 54021) then  -- Locust Swarm
		warningLocustNow:Show()
		specialWarningLocust:Show()
		timerLocustIn:Stop()
		if mod:IsDifficulty("heroic25") then
			timerLocustFade:Start(26)
		else
			timerLocustFade:Start(19)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(28785, 54021)
	and args.auraType == "BUFF" then
		warningLocustFaded:Show()
		timerLocustIn:Start()
		warningLocustSoon:Schedule(62)
	end
end

