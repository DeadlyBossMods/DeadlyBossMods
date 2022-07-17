local mod	= DBM:NewMod(2475, "DBM-Party-Dragonflight", 2, 1197)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(181224)
mod:SetEncounterID(2555)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 369573 369563 369791 369781 369677 375924",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 369602 377825",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED"
	"SPELL_PERIODIC_DAMAGE 377825",
	"SPELL_PERIODIC_MISSED 377825"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, dwarves who are "defeated" don't die, they go on boat at 10%, so we need to detect them leaving to stop timers properly
--TODO, verify target scanners. If they work, maybe upgrade it to UNIT_TARGET method
--TODO, can wild cleave be dodged? Once known, create special warning to dodge it or defensive it.
--TODO, do more for dagger throw?
--TODO, verify defensive bulwark and event and if it's actually interruptable
--Baelog
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24740))
local warnHeavyArrow							= mod:NewTargetNoFilterAnnounce(369573, 3)
local warnWildCleave							= mod:NewSpellAnnounce(369563, 3, nil, "Tank")

local specWarnHeavyArrow						= mod:NewSpecialWarningYou(369573, nil, nil, nil, 1, 2)
local yellHeavyArrow							= mod:NewYell(369573)

local timerHeavyArrowCD							= mod:NewAITimer(35, 369573, nil, nil, nil, 3)
local timerWildCleaveCD							= mod:NewAITimer(35, 369563, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--Eric "The Swift"
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24781))
local warnSkullcracker							= mod:NewTargetNoFilterAnnounce(369791, 3)

local specWarnSkullcracker						= mod:NewSpecialWarningYou(369791, nil, nil, nil, 1, 2)
local yellSkullcracker							= mod:NewYell(369791)

local timerSkullcrackerCD						= mod:NewAITimer(35, 369791, nil, nil, nil, 3)
local timerDaggerThrowCD						= mod:NewAITimer(35, 369781, nil, nil, nil, 3)
--Olaf
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24782))
local warnRicochetingShield						= mod:NewTargetNoFilterAnnounce(369677, 3)

local specWarnRicochetingShield					= mod:NewSpecialWarningYou(369677, nil, nil, nil, 1, 2)
local yellRicochetingShield						= mod:NewYell(369677)
local specWarnDefensiveBulwark					= mod:NewSpecialWarningInterrupt(369602, "HasInterrupt", nil, nil, 1, 2)

local timerRicochetingShieldCD					= mod:NewAITimer(35, 369677, nil, nil, nil, 3)
local timerDefensiveBulwarkCD					= mod:NewAITimer(35, 369602, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
--Longboat Raid!
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24783))
local timerLongboatRaidCD						= mod:NewAITimer(35, 375924, nil, nil, nil, 6)

local specWarnGTFO								= mod:NewSpecialWarningGTFO(377825, nil, nil, nil, 1, 8)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(5, 369677)
--mod:AddInfoFrameOption(361651, true)
--mod:AddSetIconOption("SetIconOnStaggeringBarrage", 361018, true, false, {1, 2, 3})

function mod:ArrowTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnHeavyArrow:Show()
		specWarnHeavyArrow:Play("targetyou")
		yellHeavyArrow:Yell()
	else
		warnHeavyArrow:Show(targetname)
	end
end

function mod:SkullTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnSkullcracker:Show()
		specWarnSkullcracker:Play("targetyou")
		yellSkullcracker:Yell()
	else
		warnSkullcracker:Show(targetname)
	end
end

function mod:ShieldTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnRicochetingShield:Show()
		specWarnRicochetingShield:Play("targetyou")
		yellRicochetingShield:Yell()
	else
		warnRicochetingShield:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	--Baelog
	timerHeavyArrowCD:Start(1-delay)
	timerWildCleaveCD:Start(1-delay)
	--Eric
	timerSkullcrackerCD:Start(1-delay)
	timerDaggerThrowCD:Start(1-delay)
	--Olaf
	timerRicochetingShieldCD:Start(1-delay)
	timerDefensiveBulwarkCD:Start(1-delay)
	--Raid
	timerLongboatRaidCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 369573 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "ArrowTarget", 0.1, 8, true)
		timerHeavyArrowCD:Start()
	elseif spellId == 369563 then
		warnWildCleave:Show()
		timerWildCleaveCD:Start()
	elseif spellId == 369791 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "SkullTarget", 0.1, 8, true)
		timerSkullcrackerCD:Start()
	elseif spellId == 369677 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "ShieldTarget", 0.1, 8, true)
		timerRicochetingShieldCD:Start()
	elseif spellId == 375924 then
		--Do timers stop this way?
		--Baelog
--		timerHeavyArrowCD:Stop()
--		timerWildCleaveCD:Stop()
--		--Eric
--		timerSkullcrackerCD:Stop()
--		timerDaggerThrowCD:Stop()
--		--Olaf
--		timerRicochetingShieldCD:Stop()
--		timerDefensiveBulwarkCD:Stop()
		timerLongboatRaidCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 362805 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 369602 then
		timerDefensiveBulwarkCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnDefensiveBulwark:Show(args.sourceName)
			specWarnDefensiveBulwark:Play("kickcast")
		end
	elseif spellId == 377825 and args:IsPlayer() and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 377825 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]
