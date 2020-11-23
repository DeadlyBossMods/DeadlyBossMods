local mod	= DBM:NewMod(2413, "DBM-Party-Shadowlands", 4, 1185)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164218)
mod:SetEncounterID(2381)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 323393 323236 328791",
	"SPELL_CAST_SUCCESS 323437 329113",
	"SPELL_AURA_APPLIED 323437 323143"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 323393 or ability.id = 328791 or ability.id = 323236) and type = "begincast"
 or (ability.id = 329113 or ability.id = 323437) and type = "cast"
 or ability.id = 323143 and type = "applybuff"
--]]
local warnTelekineticToss			= mod:NewSpellAnnounce(323143, 2)
local warnStigmaofPride				= mod:NewTargetNoFilterAnnounce(323437, 4)

local specWarnUnleashedSuffering	= mod:NewSpecialWarningDodge(323236, nil, nil, nil, 2, 2)
local specWarnTelekineticOnslaught	= mod:NewSpecialWarningDodge(329113, nil, nil, nil, 2, 2)
local specWarnRitualofWoe			= mod:NewSpecialWarningSoak(323393, nil, nil, nil, 1, 7)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerTelekineticTossCD		= mod:NewCDTimer(11.5, 323143, nil, nil, nil, 3)--11.5-15.7
local timerUnleashedSufferingCD		= mod:NewCDTimer(5, 323236, nil, nil, nil, 3)--Unknown actual timer, need longer pull
local timerStigmaofPrideCD			= mod:NewCDTimer(27.8, 323437, nil, nil, nil, 5, nil, DBM_CORE_L.HEALER_ICON)
--Other phasae
local timerRitualofWoeCD			= mod:NewNextTimer(8.2, 328791, nil, nil, nil, 2)

function mod:OnCombatStart(delay)
	timerTelekineticTossCD:Start(6-delay)
	timerStigmaofPrideCD:Start(10-delay)--10-15, SUCCESS (13.6?)
	timerUnleashedSufferingCD:Start(15.7-delay)--But sometimes never cast and boss goes into more tosses instead
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 323393 or spellId == 328791 then--328791 is challenge (all statues), 323393 is non challenge (1 statue)
		specWarnRitualofWoe:Show()
		specWarnRitualofWoe:Play("helpsoak")
		timerStigmaofPrideCD:Start(17.6)--17.6-18.5
		timerTelekineticTossCD:Start(20)--Not always though, but consistently, but sometimes doesn't happen?
		timerUnleashedSufferingCD:Start(38.8)
	elseif spellId == 323236 and self:AntiSpam(3, 1) then--event fires multiple times
		specWarnUnleashedSuffering:Show()
		specWarnUnleashedSuffering:Play("shockwave")
		--timerUnleashedSufferingCD:Start()--TODO, need longer pulls that don't reset timer with Ritual of Woe
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 323437 then
		timerStigmaofPrideCD:Start()
	elseif spellId == 329113 then
		specWarnTelekineticOnslaught:Show()
		specWarnTelekineticOnslaught:Play("watchstep")
		timerTelekineticTossCD:Stop()
		timerStigmaofPrideCD:Stop()
		timerUnleashedSufferingCD:Stop()
		timerRitualofWoeCD:Start(8.2)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 323437 then
		warnStigmaofPride:CombinedShow(0.3, args.destName)
	elseif spellId == 323143 then
		warnTelekineticToss:Show()
		timerTelekineticTossCD:Start()
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
