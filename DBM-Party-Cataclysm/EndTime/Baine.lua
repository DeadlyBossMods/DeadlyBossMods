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
	timerTotem:Start(10-delay)
	timerPulverize:Start(30-delay)
	spamBlast = 0
	spamPulverize = 0
	totemCount = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(101840) and self:AntiSpam(3, 1) then
		warnMoltenBlast:Show(args.destName)
		timerMoltenBlast:Start(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(101840) then
		timerMoltenBlast:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(101625) and self:AntiSpam(3, 2) then
		warnPulverize:Show()
		timerPulverize:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(101614) then
		warnTotem:Show()
		timerTotem:Start()
	end
end