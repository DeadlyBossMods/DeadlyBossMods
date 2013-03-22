local mod	= DBM:NewMod(666, "DBM-Party-MoP", 7, 246)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(58722)--58722 is Body, 58791 is soul. Body is engaged first
mod:SetModelID(40256)
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Kill)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED"
)


--honestly, another one that cannot be done right without mods enabled to use transcriptor and record it.
--again, piss poor detection in combat log of certain events, so a lot of these timers won't cancel when phases change. I cannot promise accuracy on phase transitions completely, especially depending on how you deal with spirit/body (ie killing which first)
--TODO, perfect phase transitions and how they effect ability timers. Find out what happens if you kill BODY first in phase 3, does it get rezzed again?
local warnShadowShiv		= mod:NewSpellAnnounce(111775, 2)
local warnDeathsGrasp		= mod:NewSpellAnnounce(111570, 3)
local warnUnleashedAnguish	= mod:NewSpellAnnounce(111649, 2)
local warnFixateAnger		= mod:NewTargetAnnounce(115350, 4)
local warnReanimateCorpse	= mod:NewSpellAnnounce(114262, 3)

local specWarnDeathsGrasp	= mod:NewSpecialWarningSpell(111570, nil, nil, nil, true)
local specWarnDarkBlaze		= mod:NewSpecialWarningMove(111585)
local specWarnFixateAnger	= mod:NewSpecialWarningRun(115350)

local timerShadowShivCD		= mod:NewCDTimer(12.5, 111775)--every 12.5-15.5 sec
local timerDeathsGraspCD	= mod:NewCDTimer(34, 111570)
local timerFixateAngerCD	= mod:NewCDTimer(12, 115350)
local timerFixateAnger		= mod:NewTargetTimer(10, 115350)
local timerDarkBlaze		= mod:NewBuffActiveTimer(8, 111585)

local soundFixateAnger		= mod:NewSound(115350)

function mod:OnCombatStart(delay)
	timerShadowShivCD:Start(12-delay)
	timerDeathsGraspCD:Start(30-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 111585 and args:IsPlayer() and self:AntiSpam() then
		specWarnDarkBlaze:Show()
	elseif args.spellId == 111649 then--Soul released and body becomes inactive, phase 2.
		timerShadowShivCD:Cancel()
		timerDeathsGraspCD:Cancel()
		warnUnleashedAnguish:Show()
		timerFixateAngerCD:Start()
	elseif args.spellId == 115350 then
		warnFixateAnger:Show(args.destName)
		timerFixateAnger:Start(args.destName)
		timerFixateAngerCD:Start()
		if args:IsPlayer() then
			specWarnFixateAnger:Show()
			soundFixateAnger:Play()
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 111570 then
		warnDeathsGrasp:Show()
		specWarnDeathsGrasp:Show()
		timerDeathsGraspCD:Start()
		timerShadowShivCD:Start()--Resets CD when she casts Grasp
	elseif args:IsSpellID(111775, 115362) then
		warnShadowShiv:Show()
		timerShadowShivCD:Start()
	elseif args.spellId == 114262 then--Phase 3, body rezzed and you have soul and body up together.
		warnReanimateCorpse:Show()
		timerDeathsGraspCD:Start(9)
		timerShadowShivCD:Start(20.5)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 111585 then
		timerDarkBlaze:Start()
	end
end

-- he dies before health 1, so can't use overkill hack.
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, _, _, _, overkill)
	if (spellId == 111628 or spellId == 115361) and destGUID == UnitGUID("player") and self:AntiSpam(2) then
		specWarnDarkBlaze:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
