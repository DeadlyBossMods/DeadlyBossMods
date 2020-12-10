local mod	= DBM:NewMod(2404, "DBM-Party-Shadowlands", 2, 1183)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164267)
mod:SetEncounterID(2386)

mod:RegisterCombat("combat"

mod:RegisterEventsInCombat(
--	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START 322236 322232 322475",
	"SPELL_CAST_SUCCESS 322304",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"--Register all in case boss leaving coming back changes order with the spawns
)

--TODO, https://shadowlands.wowhead.com/spell=322490/plague-rot is passive, does it need an infoframe?
--TODO, figure out plague crash timer when there is a lot more time. there just isn't right now. More transcriptor logs from shittier groups would help too. WCL is USELESS for this fight
--[[
(ability.id = 322236 or ability.id = 322475 or ability.id = 322232) and type = "begincast"
 or ability.id = 322304 and type = "cast"
--]]
--local warnPlagueCrash				= mod:NewCountAnnounce(322473, 4)--Announces each cast of the sequence in regular warning

local specWarnMalignantGrowth		= mod:NewSpecialWarningSwitch(322304, "-Healer", nil, nil, 1, 7)
local specWarnTouchofSlime			= mod:NewSpecialWarningSoak(257314, "Tank", nil, nil, 1, 7)
local specWarnPlagueCrash			= mod:NewSpecialWarningDodge(322473, nil, nil, nil, 2, 2)--Announces beginning of sequence in special warning
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerMalignantGrowthCD		= mod:NewCDTimer(20.6, 322304, nil, nil, nil, 1, nil, DBM_CORE_L.TANK_ICON .. DBM_CORE_L.DAMAGE_ICON)
local timerInfectiousRainCD			= mod:NewCDTimer(17, 322232, nil, nil, nil, 3)
--local timerPlagueCrashCD			= mod:NewCDTimer(17, 322475, nil, nil, nil, 3)
local timerSinkPhase				= mod:NewPhaseTimer(27)
--Tentacle Add
local timerTouchofSlimeCD			= mod:NewCDTimer(6, 322236, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)

--mod.vb.crashCount = 0
mod.vb.sinkPhase = false
mod.vb.sinkPhaseCount = 0

function mod:OnCombatStart(delay)
--	self.vb.crashCount = 0
	self.vb.sinkPhase = false
	self.vb.sinkPhaseCount = 0
	timerMalignantGrowthCD:Start(5.6-delay)
	timerInfectiousRainCD:Start(15.4-delay)
--	if self:IsMythic() then
--		timerPlagueCrashCD:Start(14.4)
--	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:OnTimerRecovery()
	if self.vb.sinkPhase then
		self:RegisterShortTermEvents(
			"UNIT_TARGETABLE_CHANGED boss1 boss2 boss3 boss4 boss5"
		)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 322236 then
		specWarnTouchofSlime:Show()
		specWarnTouchofSlime:Play("helpsoak")
		timerTouchofSlimeCD:Start(6, args.sourceGUID)
	elseif spellId == 322232 then
		timerInfectiousRainCD:Start()
--	elseif spellId == 322475 and self:AntiSpam(5, 1) then
--		self.vb.crashCount = self.vb.crashCount + 1
--		warnPlagueCrash:Show(self.vb.crashCount)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 322304 then
		specWarnMalignantGrowth:Show()
		specWarnMalignantGrowth:Play("killmob")
		timerMalignantGrowthCD:Start()
		timerTouchofSlimeCD:Start(6)
		--if self:IsMythic() then
			--TODO, plague crash castbar?
		--end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 165430 then--Malignant MalignantGrowth
		timerTouchofSlimeCD:Stop(args.destGUID)
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 194966 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 309991 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 322477 then--Start Plague Crash Phase
		self.vb.sinkPhase = true
		self.vb.sinkPhaseCount = self.vb.sinkPhaseCount + 1
		timerMalignantGrowthCD:Stop()
		timerInfectiousRainCD:Stop()
		timerSinkPhase:Start(27)
		self:RegisterShortTermEvents(
			"UNIT_TARGETABLE_CHANGED boss1 boss2 boss3 boss4 boss5"
		)
	elseif (spellId == 333941 or spellId == 322473) and not self.vb.sinkPhase then--Plague Crash
		specWarnPlagueCrash:Show()
		specWarnPlagueCrash:Play("watchstep")
	end
end

function mod:UNIT_TARGETABLE_CHANGED(uId)
	local cid = self:GetUnitCreatureId(uId)
	if cid == 164267 and UnitCanAttack("player", uId) then
		self:UnregisterShortTermEvents()
		self.vb.sinkPhase = false
		if self.vb.sinkPhaseCount == 1 then
			timerMalignantGrowthCD:Start(5.6)
			timerInfectiousRainCD:Start(15.4)
		else--2
			timerInfectiousRainCD:Start(6)
		end
	end
end
