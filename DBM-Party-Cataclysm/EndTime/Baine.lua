if tonumber((select(4, GetBuildInfo()))) < 40300 then return end

local mod	= DBM:NewMod("EchoBaine", "DBM-Party-Cataclysm", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(54431)
mod:SetModelID(38791)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON"
)

-- Just adding all I can find, no idea how usefull they will be on Live :)

local warnTotem		= mod:NewSpellAnnounce(101614, 3)
local warnMoltenBlast	= mod:NewTargetAnnounce(101840, 3)
local warnPulverize	= mod:NewSpellAnnounce(101625, 3)

local timerTotem	= mod:NewNextTimer(25, 101614)
local timerMoltenBlast	= mod:NewTargetTimer(10, 101840)
local timerPulverize	= mod:NewNextTimer(40, 101625)

local spamBlast = 0
local spamPulverize = 0
local totemCount = 0

function mod:OnCombatStart(delay)
	timerTotem:Start(30-delay)
	timerPulverize:Start(10-delay)
	spamBlast = 0
	spamPulverize = 0
	totemCount = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(101840) and GetTime() - spamBlast > 3 then
		warnMoltenBlast:Show(args.destName)
		timerMoltenBlast:Start(args.destName)
		spamBlast = GetTime()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(101840) then
		timerMoltenBlast:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(101625) and GetTime() - spamPulverize > 3 then
		warnPulverize:Show()
		timerPulverize:Start()
		spamPulverize = GetTime()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(101614) then
		warnTotem:Show()
		timerTotem:Start()
	end
end