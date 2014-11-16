local mod	= DBM:NewMod(1236, "DBM-Party-WoD", 4, 558)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(80805, 80816, 80808)
mod:SetEncounterID(1748)
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 163665 163390",
	"SPELL_AURA_APPLIED 163689",
	"SPELL_AURA_REMOVED 163689",
	"UNIT_DIED"
)

local warnSanguineSphere		= mod:NewTargetAnnounce(163689, 3)
local warnFlamingSlash			= mod:NewCastAnnounce(163665, 4)
local warnOgreTraps				= mod:NewCastAnnounce(163390, 3)

local specWarnSanguineSphere	= mod:NewSpecialWarningReflect(163689)
local specWarnFlamingSlash		= mod:NewSpecialWarningSpell(163665, nil, nil, nil, 3)--Devastating in challenge modes. move or die.
local specWarnOgreTraps			= mod:NewSpecialWarningSpell(163390, mod:IsRanged())--Pre warning for bomb immediately after. Maybe change to a Soon warning with bomb spellid instead so that's clear?

local timerSanguineSphere      	= mod:NewTargetTimer(15, 163689)
local timerSanguineSphereCD    	= mod:NewCDTimer(43.5, 163689)
local timerFlamingSlashCD      	= mod:NewCDTimer(29, 163665)
local timerOgreTrapsCD      	= mod:NewCDTimer(25, 163390)--25-30 variation.

local countdownFlamingSlash		= mod:NewCountdown(29, 163665)

function mod:OnCombatStart(delay)
	timerFlamingSlashCD:Start(5-delay)
	countdownFlamingSlash:Start(5-delay)
	timerOgreTrapsCD:Start(19.5-delay)
	timerSanguineSphereCD:Start(47-delay)--Cast is technically 45 but 47 is how long you have to kill before first shield which is what matters for high ranking CMs
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 163665 then
		warnFlamingSlash:Show()
		specWarnFlamingSlash:Show()
		timerFlamingSlashCD:Start()
		countdownFlamingSlash:Start()
	elseif spellId == 163390 then
		warnOgreTraps:Show()
		specWarnOgreTraps:Show()
		timerOgreTrapsCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 163689 then
		warnSanguineSphere:Show(args.destName)
		specWarnSanguineSphere:Show(args.destName)
		timerSanguineSphere:Start(args.destName)
		timerSanguineSphereCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 163689 then
		timerSanguineSphere:Cancel(args.destName)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 80805 then--Makogg Emberblade
		timerFlamingSlashCD:Cancel()
		countdownFlamingSlash:Cancel()
	elseif cid == 80816 then--Ahri'ok Dugru
		timerSanguineSphereCD:Cancel()
	elseif cid == 80808 then--Neesa Nox
		timerOgreTrapsCD:Cancel()
	end
end
