local mod	= DBM:NewMod(1236, "DBM-Party-WoD", 4, 558)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(80805, 80816, 80808)
mod:SetEncounterID(1748)
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 163665 163390 163379",
	"SPELL_AURA_APPLIED 163689",
	"SPELL_AURA_REMOVED 163689",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

mod:SetBossHealthInfo(80816, 80805, 80808)

local warnSanguineSphere		= mod:NewTargetAnnounce(163689, 3)
local warnFlamingSlash			= mod:NewCastAnnounce(163665, 4)
local warnLavaSwipe				= mod:NewSpellAnnounce(165152, 2)
local warnOgreTraps				= mod:NewCastAnnounce(163390, 3)
local warnBigBoom				= mod:NewSpellAnnounce(163379, 1)

local specWarnSanguineSphere	= mod:NewSpecialWarningReflect("OptionVersion2", 163689, "-Healer")
local specWarnSanguineSphereEnd	= mod:NewSpecialWarningEnd("OptionVersion2", 163689, "-Healer")
local specWarnFlamingSlash		= mod:NewSpecialWarningDodge(163665, nil, nil, nil, 3)--Devastating in challenge modes. move or die.
local specWarnLavaSwipe			= mod:NewSpecialWarningSpell(165152, nil, nil, nil, 2)
local specWarnOgreTraps			= mod:NewSpecialWarningSpell("OptionVersion2", 163390, false)--Pre warning for bomb immediately after. Maybe change to a Soon warning with bomb spellid instead so that's clear?
local specWarnBigBoom			= mod:NewSpecialWarningSpell(163379, nil, nil, nil, 2)--maybe use switch.

local timerSanguineSphere		= mod:NewTargetTimer(15, 163689)
local timerFlamingSlashCD		= mod:NewNextTimer(29, 163665)
local timerLavaSwipeCD			= mod:NewNextTimer(29, 165152)
local timerOgreTrapsCD			= mod:NewCDTimer(25, 163390)--25-30 variation.

local countdownFlamingSlash		= mod:NewCountdown(29, 163665)

local voiceSanguineSphere		= mod:NewVoice(163689, "-Healer")

function mod:OnCombatStart(delay)
	timerFlamingSlashCD:Start(5-delay)
	countdownFlamingSlash:Start(5-delay)
	timerOgreTrapsCD:Start(19.5-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 163665 then
		warnFlamingSlash:Show()
		specWarnFlamingSlash:Show()
		if self:IsHeroic() then
			timerFlamingSlashCD:Start()
		else
			timerFlamingSlashCD:Start(41.5)
		end
		countdownFlamingSlash:Start()
	elseif spellId == 163390 then
		warnOgreTraps:Show()
		specWarnOgreTraps:Show()
		timerOgreTrapsCD:Start()
	elseif spellId == 163379 then
		warnBigBoom:Show()
		specWarnBigBoom:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 163689 then
		warnSanguineSphere:Show(args.destName)
		specWarnSanguineSphere:Show(args.destName)
		voiceSanguineSphere:Play("stopattack")
		local unitid
		for i = 1, 3 do
			if UnitGUID("boss"..i) == args.destGUID then
				unitid = "boss"..i
			end
		end
		if unitid then
			local _, _, _, _, _, duration, expires, _, _ = UnitBuff(unitid, args.spellName)
			if expires then
				timerSanguineSphere:Start(expires-GetTime(), args.destName)
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 163689 then
		timerSanguineSphere:Cancel(args.destName)
		specWarnSanguineSphereEnd:Show()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 80805 then--Makogg Emberblade
		timerFlamingSlashCD:Cancel()
		countdownFlamingSlash:Cancel()
		timerLavaSwipeCD:Cancel()
	elseif cid == 80808 then--Neesa Nox
		timerOgreTrapsCD:Cancel()
	elseif cid == 80816 then
		timerSanguineSphere:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 164956 and self:AntiSpam(5, 2) then
		warnLavaSwipe:Show()
		specWarnLavaSwipe:Show()
		if self:IsHeroic() then
			timerLavaSwipeCD:Start()
		else
			timerLavaSwipeCD:Start(41.5)
		end
	end
end
