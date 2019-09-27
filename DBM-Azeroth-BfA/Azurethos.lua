local mod	= DBM:NewMod(2199, "DBM-Azeroth-BfA", 1, 1028)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(136385)
--mod:SetEncounterID(1880)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 274839 274829 274832"
)

--TODO, see if can detect gale force teleport target
local warnGaleForce					= mod:NewTargetAnnounce(274829, 3)

local specWarnAzurethosFury			= mod:NewSpecialWarningDodge(274839, nil, nil, nil, 2, 2)
local specWarnGaleForce				= mod:NewSpecialWarningDodge(274829, nil, nil, nil, 2, 2)
local specWarnWingBuffet			= mod:NewSpecialWarningDodge(274832, nil, nil, nil, 1, 2)

local timerAzurethosFuryCD			= mod:NewCDTimer(46.8, 274839, nil, nil, nil, 2)
--"Gale Force-274829-npc:136385 = pull:40.7, 47.1, 19.8, 33.7, 47.5, 19.6, 31.9, 18.4, 32.2", --
--local timerGaleForceCD			= mod:NewAITimer(16, 274829, nil, nil, nil, 3)--2 timers alternating, problem is, joining mid fight you don't know what count you're on
--"Wing Buffet-274832-npc:136385 = pull:2.8, 42.1, 11.2, 35.9, 11.1, 42.8, 11.5, 35.8, 11.4, 39.8, 10.7, 40.0"
--local timerWingBuffetCD				= mod:NewAITimer(16, 274832, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--Also alternating timers. on a world boss this just won't work

--mod:AddRangeFrameOption(5, 194966)
--mod:AddReadyCheckOption(37460, false)

function mod:GaleForce(targetname, uId)
	if not targetname then return end
	warnGaleForce:Show(targetname)
end

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerAzurethosFuryCD:Start(1-delay)
		--timerGaleForceCD:Start(1-delay)
		--timerWingBuffetCD:Start(1-delay)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 274839 then
		specWarnAzurethosFury:Show()
		specWarnAzurethosFury:Play("watchstep")
		timerAzurethosFuryCD:Start()
	elseif spellId == 274829 then
		specWarnGaleForce:Show()
		specWarnGaleForce:Play("shockwave")
		--timerGaleForceCD:Start()
		self:BossTargetScanner(args.sourceGUID, "GaleForce", 0.05, 1)--One check, boss is already looking at target at time of start, and stops looking at target almost immediately, we need target boss has soon as cast starts
	elseif spellId == 274832 then
		specWarnWingBuffet:Show()
		specWarnWingBuffet:Play("shockwave")
		--timerWingBuffetCD:Start()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
