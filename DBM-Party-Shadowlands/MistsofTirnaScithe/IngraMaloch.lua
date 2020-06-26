local mod	= DBM:NewMod(2400, "DBM-Party-Shadowlands", 3, 1184)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164567)
mod:SetEncounterID(2397)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 321952 323059 323137",
	"SPELL_AURA_REMOVED 321952 323059",
	"SPELL_CAST_START 323057 323149 323137 328756",
	"SPELL_CAST_SUCCESS 323177",
	"SPELL_PERIODIC_DAMAGE 323250",
	"SPELL_PERIODIC_MISSED 323250"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, is it alternating two phases until dead, or do you literally only cycle through each phase a single time?
--TODO, change Embrace darkness to a reflect/stopattack warning if strat becomes to stop damage on boss during it
--TODO, can tank dodge Enchanted Pollen?
--Phases
local warnSoulShackle				= mod:NewTargetNoFilterAnnounce(321005, 3)
local warnDromansWrath				= mod:NewTargetNoFilterAnnounce(323059, 1)

--Boss
local specWarnSpiritBolt			= mod:NewSpecialWarningInterrupt(323057, "HasInterrupt", nil, nil, 1, 2)
local specWarnEmbraceDarkness		= mod:NewSpecialWarningSpell(323149, nil, nil, nil, 2, 2)
local specWarnRepulsiveVisage		= mod:NewSpecialWarningSpell(328756, nil, nil, nil, 2, 2)
--Droman Oulfarran
local specWarnEnchantedPollen		= mod:NewSpecialWarningSpell(323137, "Tank", nil, nil, 1, 2)
local specWarnEnchantedPollenDispel	= mod:NewSpecialWarningDispel(323137, "RemoveMagic", nil, nil, 1, 2)
local specWarnTearsoftheForrest		= mod:NewSpecialWarningDodge(323177, nil, nil, nil, 2, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(323250, nil, nil, nil, 1, 8)

--Phases
local timerDromansWrath				= mod:NewBuffActiveTimer(15, 323059, nil, nil, nil, 6)
local timerSpiritBoltCD				= mod:NewAITimer(13, 323057, nil, nil, nil, 4, nil, DBM_CORE_L.INTERRUPT_ICON)
local timerEmbraceDarknessCD		= mod:NewAITimer(15.8, 323149, nil, nil, nil, 2, nil, DBM_CORE_L.HEALER_ICON)
local timerRepulsiveVisageCD		= mod:NewAITimer(15.8, 328756, nil, nil, nil, 2, nil, DBM_CORE_L.MAGIC_ICON)
--Droman Oulfarran
local timerEnchantedPollenCD		= mod:NewAITimer(15.8, 323137, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerTearsoftheForestCD		= mod:NewAITimer(15.8, 323177, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
--	timerSpiritBoltCD:Start(1-delay)
--	timerEmbraceDarknessCD:Start(1-delay)
--	timerRepulsiveVisageCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 323057 then
		timerSpiritBoltCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnSpiritBolt:Show(args.sourceName)
			specWarnSpiritBolt:Play("kickcast")
		end
	elseif spellId == 323149 then
		specWarnEmbraceDarkness:Show()
		specWarnEmbraceDarkness:Play("aesoon")
	elseif spellId == 323137 then
		specWarnEnchantedPollen:Show()
		specWarnEnchantedPollen:Play("shockwave")
		timerEnchantedPollenCD:Start()
	elseif spellId == 328756 then
		specWarnRepulsiveVisage:Show()
		specWarnRepulsiveVisage:Play("fearsoon")
		timerRepulsiveVisageCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 323177 then
		specWarnTearsoftheForrest:Show()
		specWarnTearsoftheForrest:Play("watchstep")
		timerTearsoftheForestCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 321952 then
		warnSoulShackle:Show(args.destName)
		--Droman
		timerEnchantedPollenCD:Start(2)
		timerTearsoftheForestCD:Start(2)
	elseif spellId == 323059 then
		warnDromansWrath:Show(args.destName)
		timerDromansWrath:Start(15)
		--Boss
		timerSpiritBoltCD:Stop()
		timerEmbraceDarknessCD:Stop()
		timerRepulsiveVisageCD:Stop()
	elseif spellId == 323137 and self:CheckDispelFilter() then
		specWarnEnchantedPollenDispel:CombinedShow(0.3, args.destName)
		specWarnEnchantedPollenDispel:ScheduleVoice(0.3, "helpdispel")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 321952 then
		timerEnchantedPollenCD:Stop()
		timerTearsoftheForestCD:Stop()
	elseif spellId == 323059 then
		timerDromansWrath:Stop()
		--Boss (if they reset)
		timerSpiritBoltCD:Start(2)
		timerEmbraceDarknessCD:Start(2)
		timerRepulsiveVisageCD:Start(2)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 323250 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
