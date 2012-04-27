local mod	= DBM:NewMod(666, "DBM-Party-MoP", 7, 246)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(58722)--58722 is Body, 58791 is soul. Body is engaged first
--mod:SetModelID(40256)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"SPELL_MISSED"
)


--honestly, another one that cannot be done right without mods enabled to use transcriptor and record it.
--again, piss poor detection in combat log of certain events, so a lot of these timers won't cancel when phases change. I cannot promise accuracy on phase transitions completely, especially depending on how you deal with spirit/body (ie killing which first)
--TODO, perfect phase transitions and how they effect ability timers. Find out what happens if you kill BODY first in phase 3, does it get rezzed again?
local warnShadowShiv		= mod:NewSpellAnnounce(115362, 2)
local warnDeathsGrasp		= mod:NewSpellAnnounce(111570, 3)
local warnUnleashedAnguish	= mod:NewSpellAnnounce(111649, 2)
local warnFixateAnger		= mod:NewTargetAnnounce(115350, 4)
local warnReanimateCorpse	= mod:NewSpellAnnounce(114262, 3)

local specwarnDeathsGrasp	= mod:NewSpecialWarningSpell(111570, nil, nil, nil, true)
local specwarnDarkBlaze		= mod:NewSpecialWarningMove(111585)
local specwarnFixateAnger	= mod:NewSpecialWarningRun(115350)

local timerShadowShivCD		= mod:NewCDTimer(12.5, 115362)--every 12.5-15.5 sec
local timerDeathsGraspCD	= mod:NewCDTimer(34, 111570)
local timerFixateAngerCD	= mod:NewCDTimer(12, 115350)
local timerFixateAnger		= mod:NewtargetTimer(10, 115350)

local soundFixateAnger		= mod:NewSound(115350)

function mod:OnCombatStart(delay)
	timerShadowShivCD:Start(12-delay)
	timerDeathsGraspCD:Start(30-delay)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(111585) and args:IsPlayer() and self:AntiSpam() then
		specwarnDarkBlaze:Show()
	elseif args:IsSpellID(111649) then--Soul released and body becomes inactive, phase 2.
		timerShadowShivCD:Cancel()
		timerDeathsGraspCD:Cancel()
		warnUnleashedAnguish:Show()
		timerFixateAngerCD:Start()
	elseif args:IsSpellID(115350) then
		warnFixateAnger:Show(args.destName)
		timerFixateAnger:Start(args.destName)
		timerFixateAngerCD:Start()
		if args:IsPlayer() then
			specwarnFixateAnger:Show()
			soundFixateAnger:Play()
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(111570) then
		warnDeathsGrasp:Show()
		specwarnDeathsGrasp:Show()
		timerDeathsGraspCD:Start()
		timerShadowShivCD:Start()--Resets CD when she casts Grasp
	elseif args:IsSpellID(111775, 115362) then
		warnShadowShiv:Show()
		timerShadowShivCD:Start()
	elseif args:IsSpellID(114262) then--Phase 3, body rezzed and you have soul and body up together.
		self:RegisterShortTermEvents(
			"SWING_DAMAGE",
			"SPELL_PERIODIC_DAMAGE",
			"RANGE_DAMAGE"
		)
		warnReanimateCorpse:Show()
		timerDeathsGraspCD:Start(9)
		timerShadowShivCD:Start(20.5)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, _, _, _, overkill)--120037 is a weak version of same spell by exit points, 115219 is the 50k per second icewall that will most definitely wipe your group if it consumes the room cause you're dps sucks.
	if (overkill or 0) > 0 then
		local cid = self:GetCIDFromGUID(destGUID)
		if cid == 58791 then--fight is over when soul dies (atleast from my log, but EJ says it's over when body dies, wtf?)
			DBM:EndCombat(self)
		end
	elseif (spellId == 111628 or spellId == 115361) and destGUID == UnitGUID("player") and self:AntiSpam() then
		specwarnDarkBlaze:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
mod.SPELL_PERIODIC_DAMAGE = mod.SPELL_DAMAGE
mod.RANGE_DAMAGE = mod.SPELL_DAMAGE

function mod:SWING_DAMAGE(_, _, _, _, destGUID, _, _, _, _, overkill)
	if (overkill or 0) > 0 then
		local cid = self:GetCIDFromGUID(destGUID)
		if cid == 58791 then
			DBM:EndCombat(self)
		end
	end
end
