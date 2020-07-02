local mod	= DBM:NewMod(2391, "DBM-Party-Shadowlands", 1, 1182)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(168543)
mod:SetEncounterID(2388)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 320012",
	"SPELL_CAST_START 322493 321247 320170",
	"SPELL_CAST_SUCCESS 321226 333493"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, which interrupt is priority?
local specWarnLandoftheDead			= mod:NewSpecialWarningSwitch(321226, "-Healer", nil, nil, 1, 2)
local specWarnFinalHarvest			= mod:NewSpecialWarningDodge(321247, nil, nil, nil, 2, 2)
--local specWarnNecroticBreath		= mod:NewSpecialWarningDodge(333493, nil, nil, nil, 2, 2)
--local yellBlackPowder				= mod:NewYell(257314)
local specWarnFrostboltVolley		= mod:NewSpecialWarningInterrupt(322493, "HasInterrupt", nil, nil, 1, 2)
local specWarnNecroticBolt			= mod:NewSpecialWarningInterrupt(320170, "HasInterrupt", nil, nil, 1, 2)
local specWarnUnholyFrenzy			= mod:NewSpecialWarningDispel(320012, "RemoveEnrage", nil, nil, 1, 2)
local specWarnUnholyFrenzyTank		= mod:NewSpecialWarningDefensive(320012, "Tank", nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerLandoftheDeadCD			= mod:NewAITimer(13, 321226, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)
local timerFinalHarvestCD			= mod:NewAITimer(15.8, 321247, nil, nil, nil, 2)
local timerNecroticBreathCD			= mod:NewAITimer(15.8, 333493, nil, nil, nil, 3)
local timerUnholyFrenzyCD			= mod:NewAITimer(13, 320012, nil, nil, nil, 5, nil, DBM_CORE_L.ENRAGE_ICON..DBM_CORE_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerLandoftheDeadCD:Start(1-delay)--SUCCESS
	timerFinalHarvestCD:Start(1-delay)
	timerNecroticBreathCD:Start(1-delay)
	timerUnholyFrenzyCD:Start(1-delay)--SUCCESS
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 322493 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnFrostboltVolley:Show(args.sourceName)
		specWarnFrostboltVolley:Play("kickcast")
	elseif spellId == 320170 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnNecroticBolt:Show(args.sourceName)
		specWarnNecroticBolt:Play("kickcast")
	elseif spellId == 321247 then
		specWarnFinalHarvest:Show()
		specWarnFinalHarvest:Play("watchstep")
		timerFinalHarvestCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 321226 then
		specWarnLandoftheDead:Show()
		specWarnLandoftheDead:Play("killmob")
		timerLandoftheDeadCD:Start()
	elseif spellId == 320012 then
		timerUnholyFrenzyCD:Start()
	elseif spellId == 333493 then
--		specWarnNecroticBreath:Show()
--		specWarnNecroticBreath:Play("watchstep")
		timerNecroticBreathCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 320012 then
		if self.Options.SpecWarn320012dispel then
			specWarnUnholyFrenzy:Show(args.destName)
			specWarnUnholyFrenzy:Play("enrage")
		else
			specWarnUnholyFrenzyTank:Show()
			specWarnUnholyFrenzyTank:Play("defensive")
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
