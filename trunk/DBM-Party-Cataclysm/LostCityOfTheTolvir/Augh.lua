local mod	= DBM:NewMod("Augh", "DBM-Party-Cataclysm", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(44895)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnSmokeBomb		= mod:NewSpellAnnounce(84768, 3)
local warnParalyticDart		= mod:NewTargetAnnounce(84799, 3)
local warnWhirlWind		= mod:NewSpellAnnounce(84784, 3)

local timerParalyticDart	= mod:NewTargetTimer(9, 84799)

local spamSmokeBomb = 0

function mod:OnCombatStart(delay)
	spamSmokeBomb = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(84768) and GetTime() - spamSmokeBomb > 5 then
		warnSmokeBomb:Show()
		spamSmokeBomb = GetTime()
	elseif args:IsSpellID(84799) then
		warnParalyticDart:Show(args.destName)
		timerParalyticDart:Start(args.destName)
	elseif args:IsSpellID(84784) then
		warnWhirlWind:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(84799) then
		timerParalyticDart:Cancel()
	end
end