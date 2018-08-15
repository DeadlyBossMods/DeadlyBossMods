local mod	= DBM:NewMod(2130, "DBM-Party-BfA", 8, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(131383)
mod:SetEncounterID(2112)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 259718",
	"SPELL_AURA_REMOVED 259718",
	"SPELL_CAST_START 259732 272457",
	"SPELL_CAST_SUCCESS 259830 273271 259718"
)

--local warnBoundlessrot				= mod:NewSpellAnnounce(259830, 3)--Use if too spammy as special warning
local warnUpheaval					= mod:NewTargetAnnounce(259718, 3)

local specWarnFesteringHarvest		= mod:NewSpecialWarningSpell(259732, nil, nil, nil, 2, 2)
local specWarnBoundlessRot			= mod:NewSpecialWarningDodge(259830, nil, nil, nil, 2, 2)
local specWarnVolatilePods			= mod:NewSpecialWarningDodge(273271, nil, nil, nil, 2, 2)
local specWarnShockwave				= mod:NewSpecialWarningSpell(272457, "Tank", nil, nil, 1, 2)
local specWarnUpheaval				= mod:NewSpecialWarningMoveAway(259718, nil, nil, nil, 1, 2)
local yellUpheaval					= mod:NewYell(259718)
local yellUpheavalFades				= mod:NewShortFadesYell(259718)
local specWarnUpheavalNear			= mod:NewSpecialWarningClose(259718, nil, nil, nil, 1, 2)

local timerFesteringHarvestCD		= mod:NewAITimer(13, 259732, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerBoundlessRotCD			= mod:NewAITimer(13, 259830, nil, nil, nil, 3)
local timerVolatilePodsCD			= mod:NewAITimer(13, 273271, nil, nil, nil, 3)
local timerShockwaveCD				= mod:NewAITimer(13, 272457, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerUpheavalCD				= mod:NewAITimer(13, 259718, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerFesteringHarvestCD:Start(1-delay)
	timerBoundlessRotCD:Start(1-delay)
	timerShockwaveCD:Start(1-delay)
	timerUpheavalCD:Start(1-delay)
	if not self:IsNormal() then
		timerVolatilePodsCD:Start(1-delay)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 259718 then
		if args:IsPlayer() then
			specWarnUpheaval:Show()
			specWarnUpheaval:Play("runout")
			yellUpheaval:Yell()
			yellUpheavalFades:Countdown(6)
		elseif self:CheckNearby(8, args.destName) then
			specWarnUpheavalNear:Show(args.destName)
			specWarnUpheavalNear:Play("runaway")
		else
			warnUpheaval:Show(args.destName)
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
	elseif spellId == 272457 then
		specWarnShockwave:Show()
		specWarnShockwave:Play("shockwave")
		timerShockwaveCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 259830 then
		specWarnBoundlessRot:Show()
		specWarnBoundlessRot:Play("watchstep")
		timerBoundlessRotCD:Start()
	elseif spellId == 273271 then
		specWarnVolatilePods:Show()
		specWarnVolatilePods:Play("watchstep")
		timerVolatilePodsCD:Start()
	elseif spellId == 259718 then
		timerUpheavalCD:Start()
	end
end
