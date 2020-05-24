local mod	= DBM:NewMod(2417, "DBM-Party-Shadowlands", 6, 1187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(165946)
mod:SetEncounterID(2404)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 324079 323608 324449 324589",
	"SPELL_CAST_SUCCESS 323685",
	"SPELL_AURA_APPLIED 324449",
	"SPELL_AURA_REMOVED 324449"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, interrupt Cd long enough to justify timers for up to 5 adds at once?
--https://shadowlands.wowhead.com/npc=166524/deathwalker
local warnDeathGrasp				= mod:NewTargetNoFilterAnnounce(323831, 4)

local specWarnReapingScythe			= mod:NewSpecialWarningDefensive(324079, "Tank", nil, nil, 1, 2)
local specWarnDarkDevastation		= mod:NewSpecialWarningDodge(323608, nil, nil, nil, 2, 2)
local specWarnManifestDeath			= mod:NewSpecialWarningMoveAway(324449, nil, nil, nil, 1, 2)
local yellManifestDeath				= mod:NewShortYell(324449)--Everyone gets, so short yell (no player names)
local yellManifestDeathFades		= mod:NewShortFadesYell(324449)
local specWarnSoulBolt				= mod:NewSpecialWarningInterrupt(324589, "HasInterrupt", nil, nil, 1, 2)
local specWarnGraspingRift			= mod:NewSpecialWarningRun(323685, nil, nil, nil, 4, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerReapingScytheCD			= mod:NewAITimer(15.8, 324079, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerDarkDevastationCD		= mod:NewAITimer(15.8, 323608, nil, nil, nil, 3)
local timerManifesstDeathCD			= mod:NewAITimer(15.8, 324449, nil, nil, nil, 3)
local timerGraspingriftCD			= mod:NewAITimer(15.8, 323685, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerReapingScytheCD:Start(1-delay)
	timerDarkDevastationCD:Start(1-delay)
	timerManifesstDeathCD:Start(1-delay)
	timerGraspingriftCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 324079 then
		specWarnReapingScythe:Show()
		specWarnReapingScythe:Play("defensive")
		timerReapingScytheCD:Start()
	elseif spellId == 323608 then
		specWarnDarkDevastation:Show()
		specWarnDarkDevastation:Play("farfromline")
		timerDarkDevastationCD:Start()
	elseif spellId == 324449 then
		timerManifesstDeathCD:Start()
	elseif spellId == 324589 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSoulBolt:Show(args.sourceName)
		specWarnSoulBolt:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 323685 then
		specWarnGraspingRift:Show()
		specWarnGraspingRift:Play("justrun")
		timerGraspingriftCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 324449 then
		if args:IsPlayer() then
			specWarnManifestDeath:Show()
			specWarnManifestDeath:Play("runout")
			yellManifestDeath:Yell()
			yellManifestDeathFades:Countdown(spellId)
		end
	elseif spellId == 323831 then
		warnDeathGrasp:CombinedShow(0.3, args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 324449 then
		if args:IsPlayer() then
			yellManifestDeathFades:Cancel()
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
