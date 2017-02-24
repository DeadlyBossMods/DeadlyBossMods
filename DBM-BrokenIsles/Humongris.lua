local mod	= DBM:NewMod(1770, "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(108879)
mod:SetEncounterID(1917)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 216428 216430 216432",
	"SPELL_CAST_SUCCESS 216817",
	"SPELL_AURA_APPLIED 216467 216817",
	"SPELL_AURA_REMOVED 216817"
)

--TODO, evaluate severity of some warnings and promote/demote between warn/specwarn as needed
local warnIceFist				= mod:NewTargetAnnounce(216432, 3)
local warnSnow					= mod:NewSpellAnnounce(216467, 3)
local warnFireBoom				= mod:NewTargetAnnounce(216428, 2)

local specWarnFireBoom			= mod:NewSpecialWarningMoveAway(216428, nil, nil, nil, 1, 2)
local yellFireBoom				= mod:NewYell(216428)
local specWarnFireBoomNear		= mod:NewSpecialWarningClose(216428, nil, nil, nil, 1, 2)
local specWarnIceFist			= mod:NewSpecialWarningMoveAway(216432, nil, nil, nil, 1, 2)
local yellIceFist				= mod:NewYell(216428)
local specWarnStomp				= mod:NewSpecialWarningSpell(216430, nil, nil, nil, 2, 2)
local specWarnGoBangYou			= mod:NewSpecialWarningMoveAway(216817, nil, nil, nil, 3, 2)
local yellGoBang				= mod:NewFadesYell(216817)
local specWarnGoBangSwap		= mod:NewSpecialWarningTaunt(216817, nil, nil, nil, 1, 2)

local timerFireBoomCD			= mod:NewCDTimer(14, 216428, nil, nil, nil, 3)
local timerStompCD				= mod:NewCDTimer(28.8, 216430, nil, nil, nil, 2)--28-37
local timerIceFistCD			= mod:NewCDTimer(29, 216432, nil, nil, nil, 2)--29-37
local timerSnowCD				= mod:NewCDTimer(35, 216467, nil, nil, nil, 2)
local timerGoBangCD				= mod:NewCDTimer(24.4, 216817, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerGoBangStarts			= mod:NewTargetTimer(12, 216817, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)

local countdownBangEnds			= mod:NewCountdown("Alt12", 216817)

local voiceFireBoom				= mod:NewVoice(216428)--runout
local voiceIceFist				= mod:NewVoice(216428)--runout
local voiceStomp				= mod:NewVoice(216430)--carefly
local voiceGoBank				= mod:NewVoice(216817)--runout/tauntboss

--mod:AddReadyCheckOption(37460, false)
mod:AddRangeFrameOption(8, 216432)

function mod:BoomTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnFireBoom:Show()
		voiceFireBoom:Play("runout")
		yellFireBoom:Yell()
	elseif self:CheckNearby(10, targetname) then
		specWarnFireBoomNear:Show(targetname)
		voiceFireBoom:Play("watchstep")
	else
		warnFireBoom:Show(targetname)
	end
end

function mod:IceFists(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnIceFist:Show()
		voiceIceFist:Play("runout")
		yellIceFist:Yell()
	else
		warnIceFist:Show(targetname)
	end
end

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 216428 then
		timerFireBoomCD:Start()
		self:BossTargetScanner(args.sourceGUID, "BoomTarget", 0.1, 14, nil, nil, nil, nil, true)
	elseif spellId == 216430 then
		specWarnStomp:Show()
		voiceStomp:Play("carefly")
		timerStompCD:Start()
	elseif spellId == 216432 then
		self:BossTargetScanner(args.sourceGUID, "IceFists", 0.1, 9, nil, nil, nil, nil, true)
		timerIceFistCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 216817 then
		timerGoBangCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 216467 then
		warnSnow:Show()
		timerSnowCD:Start()
	elseif spellId == 216817 then
		timerGoBangStarts:Start(args.destName)
		if args:IsPlayer() then
			specWarnGoBangYou:Show()
			voiceGoBank:Play("runout")
			yellGoBang:Schedule(11, 1)
			yellGoBang:Schedule(10, 2)
			yellGoBang:Schedule(9, 3)
			countdownBangEnds:Start()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(25)
			end
		else
			specWarnGoBangSwap:Show(args.destName)
			voiceGoBank:Play("tauntboss")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 216817 then
		timerGoBangStarts:Stop(args.destName)
		if args:IsPlayer() then
			yellGoBang:Cancel()
			countdownBangEnds:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	end
end
