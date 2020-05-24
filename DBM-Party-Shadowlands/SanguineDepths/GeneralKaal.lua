local mod	= DBM:NewMod(2407, "DBM-Party-Shadowlands", 8, 1189)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(168112)
mod:SetEncounterID(2363)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 323810 324103",
	"SPELL_CAST_SUCCESS 323845",
	"SPELL_AURA_APPLIED 323845",
	"SPELL_AURA_REMOVED 323845"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnWickedRush				= mod:NewTargetAnnounce(323845, 3)

local specWarnWickedRush			= mod:NewSpecialWarningMoveAway(323845, nil, nil, nil, 1, 2)
local yellWickedRush				= mod:NewYell(323845)
local yellWickedRushFades			= mod:NewShortFadesYell(323845)
local specWarnPiercingBlur			= mod:NewSpecialWarningDodge(323810, nil, nil, nil, 2, 2)
local specWarnGloomSquall			= mod:NewSpecialWarningSpell(324103, nil, nil, nil, 3, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerWickedRushCD				= mod:NewAITimer(15.8, 323845, nil, nil, nil, 3)
local timerPiercingBlurCD			= mod:NewAITimer(13, 323810, nil, nil, nil, 3)
local timerGloomSquallCD			= mod:NewAITimer(13, 324103, nil, nil, nil, 2, nil, DBM_CORE_Translations.IMPORTANT_ICON)

function mod:OnCombatStart(delay)
	timerWickedRushCD:Start(1-delay)
	timerPiercingBlurCD:Start(1-delay)
	timerGloomSquallCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 323810 then
		specWarnPiercingBlur:Show()
		specWarnPiercingBlur:Play("watchstep")
		timerPiercingBlurCD:Start()
	elseif spellId == 324103 or spellId == 322903 then
		specWarnGloomSquall:Show()
		if spellId == 324103 then--5 second cast with knockback
			specWarnGloomSquall:Play("carefly")
		else--3 second cast with just aoe damage
			specWarnGloomSquall:Play("aesoon")
		end
		timerGloomSquallCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 323845 then
		timerWickedRushCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 323845 then
		warnWickedRush:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnWickedRush:Show()
			specWarnWickedRush:Play("runout")
			yellWickedRush:Yell()
			yellWickedRushFades:Countdown(spellId)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 323845 then
		if args:IsPlayer() then
			yellWickedRushFades:Cancel()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 309991 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
