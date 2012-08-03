local mod	= DBM:NewMod(104, "DBM-Party-Cataclysm", 9, 65)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(40792)--42172 is Ozumat, but we need Neptulon for engage trigger.
mod:SetModelID(35100)--32911Looks like crap, definitely doesn't scale well. so just use one of his tenticles instead
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnPhase3		= mod:NewPhaseAnnounce(3)
local warnBlightSpray	= mod:NewSpellAnnounce(83985, 2)

local timerBlightSpray	= mod:NewBuffActiveTimer(4, 83985)

local warnedPhase2 = false
local warnedPhase3 = false

function mod:OnCombatStart(delay)
	warnedPhase2 = false
	warnedPhase3 = false
	DBM.Bars:CreateBar(95, "Phase 2")--Can be done right later once consistency is confirmed.
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if spellName == GetSpellInfo(83909) then --Clear Tidal Surge
		self:SendSync("bossdown")
	end
end

function mod:OnSync(msg)
	if msg == "bossdown" then
		DBM:EndCombat(self)
	end
end