local mod	= DBM:NewMod("Ozumat", "DBM-Party-Cataclysm", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(42172)
mod:SetModelID(35100)--32911Looks like crap, definitely doesn't scale well. so just use one of his tenticles instead
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnPhase3		= mod:NewPhaseAnnounce(3)
local warnBlightSpray	= mod:NewSpellAnnounce(83985, 2)

local timerBlightSpray	= mod:NewBuffActiveTimer(4, 83985)

local warnedPhase2
local warnedPhase3

function mod:OnCombatStart(delay)
	warnedPhase2 = false
	warnedPhase3 = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(83463) and not warnedPhase2 then
		warnPhase2:Show(2)
		warnedPhase2 = true
	elseif args:IsSpellID(76133) and not warnedPhase3 then
		warnPhase3:Show(3)
		warnedPhase3 = true
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(83985, 83986, 91511) then
		warnBlightSpray:Show()
		timerBlightSpray:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 42172 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.02 then--This boss doesn't die, the event ends when he reaches 1 health. So we assume if he's less than 2% he's probably dead
		self:SendSync("bossdown")
	end
end

function mod:OnSync(msg)
	if msg == "bossdown" then
		DBM:EndCombat(self)
	end
end