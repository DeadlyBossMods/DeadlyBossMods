local mod	= DBM:NewMod(852, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71543)
mod:SetEncounterID(1602)
mod:SetReCombatTime(45)--Lets just assume he has same bug as tsulong in advance and avoid problems
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Victory)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 143436 143309",
	"SPELL_AURA_APPLIED 143459 143524 143297 143574",
	"SPELL_AURA_APPLIED_DOSE 143459 143524",
	"SPELL_AURA_REMOVED 143459 143524 143574",
	"SPELL_PERIODIC_DAMAGE 143297",
	"SPELL_PERIODIC_MISSED 143297",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnBreath						= mod:NewSpellAnnounce(143436, 3, nil, mod:IsTank() or mod:IsHealer())
local warnShaBolt						= mod:NewSpellAnnounce(143295, 3, nil, false)
local warnSwirl							= mod:NewSpellAnnounce(143309, 4)
local warnSplit							= mod:NewSpellAnnounce(143020, 2)
local warnReform						= mod:NewSpellAnnounce(143469, 2)
local warnSwellingCorruptionCast		= mod:NewSpellAnnounce(143578, 2, 143574)--Heroic (this is the boss spellcast trigger spell NOT personal debuff warning)

local specWarnBreath					= mod:NewSpecialWarningSpell(143436, mod:IsTank())
local specWarnShaSplash					= mod:NewSpecialWarningMove(143297)
local specWarnSwirl						= mod:NewSpecialWarningSpell(143309, nil, nil, nil, 2)
local specWarnSwellingCorruptionTarget	= mod:NewSpecialWarningTarget(143578)
local specWarnSwellingCorruptionFades	= mod:NewSpecialWarningFades(143578)

local timerBreathCD						= mod:NewCDTimer(35, 143436, nil, mod:IsTank() or mod:IsHealer())--35-65 second variation wtf?
local timerSwirl						= mod:NewBuffActiveTimer(13, 143309)
local timerShaBoltCD					= mod:NewCDTimer(6, 143295, nil, false)--every 6-20 seconds (yeah it variates that much)
local timerSwirlCD						= mod:NewCDTimer(48.5, 143309)
local timerShaResidue					= mod:NewBuffFadesTimer("OptionVersion2", 10, 143459, nil, false)
local timerPurifiedResidue				= mod:NewBuffFadesTimer("OptionVersion2", 15, 143524, nil, false)
local timerSwellingCorruptionCD			= mod:NewCDTimer(75, 143578, nil, nil, nil, 143574)

local berserkTimer						= mod:NewBerserkTimer(605)

function mod:OnCombatStart(delay)
	timerBreathCD:Start(10-delay)
	timerSwirlCD:Start(20-delay)
	berserkTimer:Start(-delay)
	if self:IsHeroic() then
		timerSwellingCorruptionCD:Start(10-delay)--10-14sec variation
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 143436 then
		warnBreath:Show()
		specWarnBreath:Show()
		timerBreathCD:Start()
	elseif spellId == 143309 then
		warnSwirl:Show()
		specWarnSwirl:Show()
		timerSwirl:Start()
		timerSwirlCD:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 143459 and args:IsPlayer() then
		timerShaResidue:Start()
	elseif spellId == 143524 and args:IsPlayer() then
		timerPurifiedResidue:Start()
	elseif spellId == 143297 and args:IsPlayer() and self:AntiSpam(2, 1) then
		specWarnShaSplash:Show()
	elseif spellId == 143574 then
		specWarnSwellingCorruptionTarget:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 143459 and args:IsPlayer() then
		timerShaResidue:Cancel()
	elseif spellId == 143524 and args:IsPlayer() then
		timerPurifiedResidue:Cancel()
	elseif spellId == 143574 then
		specWarnSwellingCorruptionFades:Show()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 143297 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnShaSplash:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 143293 and self:AntiSpam(3, 2) then--Sha Bolt
		warnShaBolt:Show()
		timerShaBoltCD:Start()
	elseif spellId == 143578 then--Swelling Corruption
		warnSwellingCorruptionCast:Show()
		timerSwellingCorruptionCD:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:143469") then--Reforms
		warnReform:Show()
		timerBreathCD:Start(14)
		timerSwirlCD:Start(24)
		if self:IsHeroic() then
			timerSwellingCorruptionCD:Start(17)
		end
	elseif msg:find("spell:143020") then--split
		warnSplit:Show()
		timerBreathCD:Cancel()
		timerSwirlCD:Cancel()
		timerShaBoltCD:Cancel()
		timerSwellingCorruptionCD:Cancel()
	end
end
