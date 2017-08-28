local mod	= DBM:NewMod(2011, "DBM-Argus", nil, 959)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(124625)
mod:SetEncounterID(2083)
--mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 247549 247604",
	"SPELL_CAST_SUCCESS 247517",
	"SPELL_AURA_APPLIED 247551 247544 247517",
	"SPELL_AURA_APPLIED_DOSE 247544"
)

--TODO, fine tune tank swaps?
local warnBeguilingCharm			= mod:NewTargetAnnounce(247549, 4)
local warnFelLash					= mod:NewSpellAnnounce(247604, 2)
local warnHeartBreaker				= mod:NewTargetAnnounce(247517, 2, nil, "Healer")

local specWarnBeguilingCharm		= mod:NewSpecialWarningLookAway(247549, nil, nil, nil, 3, 2)
local yellBeguilingCharm			= mod:NewYell(247549)
local specWarnSadist				= mod:NewSpecialWarningCount(247544, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack:format(8, 159515), nil, 1, 2)
local specWarnSadistOther			= mod:NewSpecialWarningTaunt(247544, nil, nil, nil, 1, 2)

local timerBeguilingCharmCD			= mod:NewAITimer(13.4, 247549, nil, nil, nil, 2, nil, DBM_CORE_IMPORTANT_ICON)
local timerFelLashCD				= mod:NewAITimer(13.4, 247604, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerHeartBreakerCD			= mod:NewAITimer(13.4, 247517, nil, "Healer", nil, 5, nil, DBM_CORE_HEALER_ICON)

local voiceBeguilingCharm			= mod:NewVoice(247549)--turnaway
local voiceSadist					= mod:NewVoice(247544)--changemt

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 247549 then
		specWarnBeguilingCharm:Show()
		voiceBeguilingCharm:Play("turnaway")
		timerBeguilingCharmCD:Start()
	elseif spellId == 247604 then
		warnFelLash:Show()
		timerFelLashCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 247517 then
		timerHeartBreakerCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 247551 then
		warnBeguilingCharm:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			yellBeguilingCharm:Yell()
		end
	elseif spellId == 247544 then
		local amount = args.amount or 1
		if (amount >= 8) and self:AntiSpam(4, 3) then--First warning at 8, then spam every 4 seconds above.
			local tanking, status = UnitDetailedThreatSituation("player", "boss1")
			if tanking or (status == 3) then
				specWarnSadist:Show(amount)
			else
				specWarnSadistOther:Show(L.name)
			end
			voiceSadist:Play("changemt")
		end
	elseif spellId == 247517 then
		warnHeartBreaker:CombinedShow(0.3, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
