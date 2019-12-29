local mod	= DBM:NewMod(2130, "DBM-Party-BfA", 8, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(131383)
mod:SetEncounterID(2112)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 259718",
	"SPELL_AURA_REMOVED 259718",
	"SPELL_CAST_START 259732 272457",
	"SPELL_CAST_SUCCESS 259830 259718 259732",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--local warnBoundlessrot				= mod:NewSpellAnnounce(259830, 3)--Use if too spammy as special warning
local warnUpheaval					= mod:NewTargetAnnounce(259718, 3)

local specWarnFesteringHarvest		= mod:NewSpecialWarningSpell(259732, nil, nil, nil, 2, 2)
local specWarnVolatilePods			= mod:NewSpecialWarningDodge(273271, nil, nil, nil, 2, 2)
local specWarnShockwave				= mod:NewSpecialWarningSpell(272457, "Tank", nil, nil, 1, 2)
local specWarnUpheaval				= mod:NewSpecialWarningMoveAway(259718, nil, nil, nil, 1, 2)
local yellUpheaval					= mod:NewYell(259718)
local yellUpheavalFades				= mod:NewShortFadesYell(259718)
local specWarnUpheavalNear			= mod:NewSpecialWarningClose(259718, nil, nil, nil, 1, 2)

local timerFesteringHarvestCD		= mod:NewCDTimer(51, 259732, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
--local timerBoundlessRotCD			= mod:NewAITimer(13, 259830, nil, nil, nil, 3)
local timerVolatilePodsCD			= mod:NewCDTimer(31.3, 273271, nil, nil, nil, 3)
local timerShockwaveCD				= mod:NewCDTimer(14.6, 272457, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerUpheavalCD				= mod:NewCDTimer(20, 259718, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	--timerBoundlessRotCD:Start(1-delay)
	timerShockwaveCD:Start(10-delay)
	timerUpheavalCD:Start(17-delay)
	if not self:IsNormal() then
		timerVolatilePodsCD:Start(20.4-delay)
	end
	timerFesteringHarvestCD:Start(34.9-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 259718 then
		if args:IsPlayer() then
			specWarnUpheaval:Show()
			specWarnUpheaval:Play("runout")
			yellUpheaval:Yell()
			yellUpheavalFades:Countdown(6)
		elseif self:CheckNearby(8, args.destName) and not DBM:UnitDebuff("player", spellId) then
			specWarnUpheavalNear:CombinedShow(0.3, args.destName)
			specWarnUpheavalNear:ScheduleVoice(0.3, "runaway")
		else
			warnUpheaval:CombinedShow(0.3, args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 259718 and args:IsPlayer() then
		yellUpheavalFades:Cancel()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 259732 then
		specWarnFesteringHarvest:Show()
		specWarnFesteringHarvest:Play("specialsoon")
		timerFesteringHarvestCD:Start()
		if DBM.Options.DebugMode then
			timerShockwaveCD:Stop()
			timerUpheavalCD:Stop()
			timerVolatilePodsCD:Stop()
		end
	elseif spellId == 272457 then
		specWarnShockwave:Show()
		specWarnShockwave:Play("shockwave")
		timerShockwaveCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 259830 then
		--timerBoundlessRotCD:Start()
	elseif spellId == 259718 and self:AntiSpam(3, 1) then
		timerUpheavalCD:Start(20.6)
	elseif spellId == 259732 and DBM.Options.DebugMode then
		timerUpheavalCD:Start(10.5)
		if not self:IsNormal() then
			timerVolatilePodsCD:Start(12)
		end
		timerShockwaveCD:Start(19)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 273271 then--Volatile Pods
		specWarnVolatilePods:Show()
		specWarnVolatilePods:Play("watchstep")
		timerVolatilePodsCD:Start()
	end
end
