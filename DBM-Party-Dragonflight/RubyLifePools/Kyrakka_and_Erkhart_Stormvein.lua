local mod	= DBM:NewMod(2503, "DBM-Party-Dragonflight", 7, 1202)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(193435, 190485)
mod:SetEncounterID(2609)
--mod:SetUsedIcons(1, 2, 3)
mod:SetBossHPInfoToHighest()
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 381605 381602 381525 381517 381512 385558 381516",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 381515"
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, stagechange trigger for when Erkhart mounts up Kyrakka and what timers cancel and what ones restart
--TODO, Flamespit correct ID and if target scan works
--TODO, verify breath target scan
--TODO, more with winds of change?
--TODO, make sure Zeyphr and Interupting Zeyphr have same timer
--[[
(ability.id = 381605 or ability.id = 381602 or ability.id = 381525 or ability.id = 381517 or ability.id = 381512 or ability.id = 385558 or ability.id = 381516) and type = "begincast"
--]]
--Kyrakka
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25365))
local warnFlamespit								= mod:NewTargetNoFilterAnnounce(381605, 3)

local yellFlamespit								= mod:NewYell(381605)
local specWarnRoaringFirebreath					= mod:NewSpecialWarningDodge(381525, nil, nil, nil, 2, 2)
local yellRoaringFirebreath						= mod:NewYell(381525)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

local timerFlamespitCD							= mod:NewCDTimer(15.7, 381605, nil, nil, nil, 3)
local timerRoaringFirebreathCD					= mod:NewCDTimer(35, 381525, nil, nil, nil, 3)
--Erkhart Stormvein
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25369))
local warnWindsofChange							= mod:NewSpellAnnounce(381517, 3)
local warnZephyr								= mod:NewSpellAnnounce(385558, 3)

local specWarnStormslam							= mod:NewSpecialWarningDefensive(381512, nil, nil, nil, 1, 2)
local specWarnStormslamDispel					= mod:NewSpecialWarningDispel(381512, "RemoveMagic", nil, nil, 1, 2)
local specWarnInterruptingZephyr				= mod:NewSpecialWarningCast(381516, "SpellCaster", nil, nil, 2, 2, 4)

local timerWindsofChangeCD						= mod:NewCDTimer(18, 381517, nil, nil, nil, 3)
local timerStormslamCD							= mod:NewCDTimer(10, 381512, nil, "Tank|RemoveMagic", nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerZephyrCD								= mod:NewCDTimer(18, 385558, nil, nil, nil, 2)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(381862, true)
--mod:AddSetIconOption("SetIconOnStaggeringBarrage", 361018, true, false, {1, 2, 3})

function mod:SpitTarget(targetname)
	if not targetname then return end
	warnFlamespit:Show(targetname)
	if targetname == UnitName("player") then
		yellFlamespit:Yell()
	end
end

function mod:BreathTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		yellRoaringFirebreath:Yell()
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	--Kyrakka
	timerFlamespitCD:Start(24.2-delay)
	timerRoaringFirebreathCD:Start(3.6-delay)
	--Erkhart Stormvein
--	timerWindsofChangeCD:Start(1-delay)--Cast on engage
	timerStormslamCD:Start(5.8-delay)
	timerZephyrCD:Start(10.7-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(381862))
		DBM.InfoFrame:Show(5, "playerdebuffremaining", 381862)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 381605 or spellId == 381602 then--381605 confirmed, 381602 unknown
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "SpitTarget", 0.1, 8, true)
		timerFlamespitCD:Start()
	elseif spellId == 381525 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "BreathTarget", 0.1, 8, true)
		specWarnRoaringFirebreath:Show()
		specWarnRoaringFirebreath:Play("breathsoon")
		timerRoaringFirebreathCD:Start(self.vb.phase == 1 and 27 or 18)
	elseif spellId == 381517 then
		warnWindsofChange:Show()
		timerWindsofChangeCD:Start()
	elseif spellId == 381512 then
		if self:IsTanking("player", nil, nil, nil, args.sourceGUID) then--Using GUID check because might be boss1 or boss2
			specWarnStormslam:Show()
			specWarnStormslam:Play("defensive")
		end
		timerStormslamCD:Start()--self.vb.phase == 1 and 10 or 14
	elseif spellId == 385558 or spellId == 381516 then
		if spellId == 381516 and self.Option.SpecWarn381516cast then--Mythic
			specWarnInterruptingZephyr:Show()
			specWarnInterruptingZephyr:Play("stopcast")
		else--Normal/Heroic
			warnZephyr:Show()
		end
		timerZephyrCD:Start()
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
	if spellId == 381515 and self:CheckDispelFilter() then
		specWarnStormslamDispel:Show(args.destName)
		specWarnStormslamDispel:Play("helpdispel")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 361966 then

	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 193435 then--Kyrakka

	elseif cid == 190485 then--Erkhart

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]
