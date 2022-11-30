local mod	= DBM:NewMod(2506, "DBM-DragonIsles", nil, 1205)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(193535)
mod:SetEncounterID(2640)
mod:SetReCombatTime(20)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")
--mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 386259 385652 385137",
	"SPELL_CAST_SUCCESS 385506 385270"
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
)

--TODO, Awaken Crag trigger correct?
--TODO, fracturing tremor correct?
--local warnFuriousSlam					= mod:NewTargetNoFilterAnnounce(361209, 2)
--local warnDarkDeterrence				= mod:NewStackAnnounce(361390, 2, nil, "Tank|Healer")
local warnAwakenCrag					= mod:NewSpellAnnounce(385506, 2)--Bigger alert if needed
local warnFracturingTremor				= mod:NewSpellAnnounce(385270, 2)--Bigger alert if needed
local warnShaleBeath					= mod:NewSpellAnnounce(385137, 3, nil, "Tank|Healer", nil, nil, nil, 2)

local specWarnSundneringCrash			= mod:NewSpecialWarningDodge(386259, nil, nil, nil, 2, 2)
local specWarnEarthBolt					= mod:NewSpecialWarningInterrupt(385652, "HasInterrupt", nil, nil, 1, 2)

local timerSunderingCrashCD				= mod:NewAITimer(74.7, 386259, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerAwakenCragCD					= mod:NewAITimer(9.7, 385506, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerFracturingTremorCD			= mod:NewAITimer(74.7, 385270, nil, nil, nil, 3)
local timerShaleBreathCD				= mod:NewAITimer(9.7, 385137, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--mod:AddRangeFrameOption(5, 361632)

function mod:OnCombatStart(delay, yellTriggered)
--	if yellTriggered then
		--timerSunderingCrashCD:Start(1-delay)
		--timerAwakenCragCD:Start(1-delay)
		--timerFracturingTremorCD:Start(1-delay)
		--timerShaleBreathCD:Start(1-delay)
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

--function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--end


function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 386259 then
		specWarnSundneringCrash:Show()
		specWarnSundneringCrash:Play("watchstep")
		timerSunderingCrashCD:Start()
	elseif spellId == 385652 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnEarthBolt:Show(args.sourceName)
		specWarnEarthBolt:Play("kickcast")
	elseif spellId == 385137 then
		warnShaleBeath:Show()
		warnShaleBeath:Play("breathsoon")
		timerShaleBreathCD:Start()
	end
end


function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 385506 and self:AntiSpam(5, 1) then
		warnAwakenCrag:Show()
		timerAwakenCragCD:Start()
	elseif spellId == 385270 and self:AntiSpam(5, 2) then
		warnFracturingTremor:Show()
		timerFracturingTremorCD:Start()
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 361632 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 361632 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 361335 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]
