local mod	= DBM:NewMod(2360, "DBM-Party-BfA", 11, 1178)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(153755, 150712)
mod:SetEncounterID(2312)
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START 298669 298718 298897 298940 298651 298571",--298946
--	"SPELL_CAST_SUCCESS"
	"UNIT_DIED"
)

--Trixie "The Tech" Tazer
local warnMegaTaze					= mod:NewTargetNoFilterAnnounce(298718, 3)
local warnJumpStart					= mod:NewSpellAnnounce(298897, 3)
--Naeno Megacrash
--local warnRollOut					= mod:NewSpellAnnounce(298946, 3)
local warnBurnout					= mod:NewSpellAnnounce(298571, 3)

--Trixie "The Tech" Tazer
local specWarnTaze					= mod:NewSpecialWarningInterrupt(298669, "HasInterrupt", nil, nil, 1, 2)
local specWarnMegaTaze				= mod:NewSpecialWarningMoveTo(298718, nil, nil, nil, 3, 2)
local yellMegaTaze					= mod:NewYell(298718)
--Naeno Megacrash
local specWarnBoltBuster			= mod:NewSpecialWarningDodge(298940, "Tank", nil, nil, 1, 2)
local specWarnPedaltotheMetal		= mod:NewSpecialWarningDodge(298651, nil, nil, nil, 2, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

--Trixie "The Tech" Tazer
local timerTazeCD					= mod:NewAITimer(13.4, 298669, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerMegaTazeCD				= mod:NewAITimer(13.4, 298718, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
--Naeno Megacrash
local timerBoltBusterCD				= mod:NewAITimer(13.4, 298940, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerPedaltotheMetalCD		= mod:NewAITimer(31.6, 298651, nil, nil, nil, 3)

--mod:AddRangeFrameOption(5, 194966)

local SmokeBombName = DBM:GetSpellInfo(298573)

function mod:MegaTazeTarget(targetname, uId)
	if not targetname then return end
	if self:AntiSpam(4, targetname) then--Antispam to lock out redundant later warning from firing if this one succeeds
		if targetname == UnitName("player") then
			specWarnMegaTaze:Show(SmokeBombName)
			specWarnMegaTaze:Play("findshelter")
			yellMegaTaze:Yell()
		else
			warnMegaTaze:Show(targetname)
		end
	end
end

function mod:OnCombatStart(delay)
	timerTazeCD:Start(1-delay)
	timerMegaTazeCD:Start(1-delay)
	timerBoltBusterCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 257777 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 257827 then

	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 298669 then
		timerTazeCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnTaze:Show(args.sourceName)
			specWarnTaze:Play("kickcast")
		end
	elseif spellId == 298718 then
		timerMegaTazeCD:Start()
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "MegaTazeTarget", 0.1, 12, true, nil, nil, nil, true)
	elseif spellId == 298897 then
		warnJumpStart:Show()
		--Guessed
		timerPedaltotheMetalCD:Start(2)
	elseif spellId == 298940 then
		specWarnBoltBuster:Show()
		specWarnBoltBuster:Play("shockwave")
		timerBoltBusterCD:Start()
--	elseif spellId == 298946 then
--		warnRollOut:Show()
	elseif spellId == 298651 then
		specWarnPedaltotheMetal:Show()
		specWarnPedaltotheMetal:Play("chargemove")
	elseif spellId == 298571 then
		warnBurnout:Show()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 257777 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 153755 then--Naeno

	elseif cid == 150712 then--Trixie
		timerTazeCD:Stop()
		timerMegaTazeCD:Stop()
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
