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
	"SPELL_CAST_START 385652 385137 386059 386259",
	"SPELL_CAST_SUCCESS 386680"
)

local warnAwakenCrag					= mod:NewSpellAnnounce(385506, 2)--Bigger alert if needed
local warnFracturingTremor				= mod:NewSpellAnnounce(385270, 2)--Bigger alert if needed
local warnShaleBeath					= mod:NewSpellAnnounce(385137, 3, nil, "Tank|Healer", nil, nil, nil, 2)

local specWarnSundneringCrash			= mod:NewSpecialWarningDodge(386259, nil, nil, nil, 2, 2)
local specWarnEarthBolt					= mod:NewSpecialWarningInterrupt(385652, "HasInterrupt", nil, nil, 1, 2)

local timerSunderingCrashCD				= mod:NewCDTimer(65, 386259, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerAwakenCragCD					= mod:NewCDTimer(31.6, 385506, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)--Wild Variation, but also world lag
local timerFracturingTremorCD			= mod:NewCDTimer(13.9, 385270, nil, nil, nil, 3)
local timerShaleBreathCD				= mod:NewCDTimer(15.9, 385137, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

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
	if spellId == 385652 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnEarthBolt:Show(args.sourceName)
		specWarnEarthBolt:Play("kickcast")
	elseif spellId == 385137 then
		warnShaleBeath:Show()
		warnShaleBeath:Play("breathsoon")
		timerShaleBreathCD:Start()
	elseif spellId == 386059 and self:AntiSpam(5, 1) then
		warnAwakenCrag:Show()
		timerAwakenCragCD:Start()
	elseif spellId == 386259 then
		specWarnSundneringCrash:Show()
		specWarnSundneringCrash:Play("watchstep")
		timerSunderingCrashCD:Start()
	end
end


function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 386680 and self:AntiSpam(5, 2) then
		warnFracturingTremor:Show()
		timerFracturingTremorCD:Start()
	end
end
