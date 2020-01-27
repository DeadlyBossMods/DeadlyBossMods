local mod	= DBM:NewMod(2355, "DBM-Party-BfA", 11, 1178)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(150190)
mod:SetEncounterID(2291)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 295536 295939",
	"SPELL_CAST_SUCCESS 302274 303885 301351 303553 295445 301177",
	"SPELL_AURA_APPLIED 296080 302274 303885 303252",
	"SPELL_AURA_REMOVED 296080 303885",
	"UNIT_DIED"
)

--TODO, can tank dodge wreck?
--TODO, additional warnings/timers for platform stuff?
--TODO, Verify/update non hard mode timers
--TODO, need log that lets HK lift off and MK1 or MK2 to start a new cycle of all abilities at least once
--[[
(ability.id = 295536 or ability.id = 295939) and type = "begincast"
 or ability.id = 302274 or ability.id = 303885 or ability.id = 301351 or ability.id = 295445 or ability.id = 301177) and type = "cast"
 or (target.id = 150295 or target.id = 155760) and type = "death"
 --]]
local warnReinforcementRelay		= mod:NewSpellAnnounce(301351, 2)
local warnHaywire					= mod:NewTargetNoFilterAnnounce(296080, 1)
local warnFulminatingZap			= mod:NewTargetNoFilterAnnounce(302274, 2, nil, "Healer")

local specWarnCannonBlast			= mod:NewSpecialWarningDodge(295536, nil, nil, nil, 2, 2)
local specWarnWreck					= mod:NewSpecialWarningDefensive(295445, "Tank", nil, nil, 1, 2)
local specWarnFulminatingBurst		= mod:NewSpecialWarningMoveTo(303885, nil, nil, nil, 1, 2)
local yellFulminatingBurst			= mod:NewYell(303885, nil, nil, nil, "YELL")
local yellFulminatingBurstFades		= mod:NewShortFadesYell(303885, nil, nil, nil, "YELL")
--Stage 2
local specWarnAnnihilationRay		= mod:NewSpecialWarningSpell(295939, nil, nil, nil, 2, 2)
local specWarnAntiTresField			= mod:NewSpecialWarningMoveTo(303252, nil, nil, nil, 1, 2)
local yellAntiTresField				= mod:NewYell(303252)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

--local timerCannonBlastCD			= mod:NewCDTimer(7.7, 295536, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)--7.7-13.4 variation, useless timer
local timerReinforcementRelayCD		= mod:NewCDTimer(32.8, 301351, nil, nil, nil, 1)
local timerWreckCD					= mod:NewCDTimer(24.3, 295445, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerFulminatingZapCD			= mod:NewCDTimer(17.0, 302274, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON)--Assumed
local timerFulminatingBurstCD		= mod:NewCDTimer(17.0, 303885, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON)--Hard Mode
--Stage 2
local timerHaywire					= mod:NewBuffActiveTimer(30, 296080, nil, nil, nil, 6)
--local timerHowlingFearCD			= mod:NewAITimer(13.4, 257791, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)

--mod:AddRangeFrameOption(5, 194966)
mod:AddNamePlateOption("NPAuraOnWalkieShockie", 296522, false)

mod.vb.hard = false
local unitTracked = {}

local function checkHardMode(self)
	local found = false
	for i = 1, 5 do
		local unitID = "boss"..i
		if UnitExists(unitID) then
			local cid = self:GetUnitCreatureId(unitID)
			if cid == 150295 then--MK1
				found = true
				timerFulminatingZapCD:Start(8.4)--SUCCESS--Assumed
				timerWreckCD:Start(15.7)--Assumed
				timerReinforcementRelayCD:Start(19.8)--Assumed
			elseif cid == 155760 then--MK2 (hard mode)
				found = true
				self.vb.hard = true
				timerFulminatingBurstCD:Start(8.4)--SUCCESS--VERIFIED
				timerWreckCD:Start(15.7)--VERIFIED
				timerReinforcementRelayCD:Start(19.8)--VERIFIED
			end
		end
	end
	if not found then
		DBM:AddMsg("checkHardMode failed, tell DBM author")
	end
end

function mod:OnCombatStart(delay)
	self.vb.hard = false
	self:Schedule(1-delay, checkHardMode, self)
	table.wipe(unitTracked)
	if self.Options.NPAuraOnWalkieShockie then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
		self:RegisterOnUpdateHandler(function(self)
			for i = 1, 40 do
				local UnitID = "nameplate"..i
				local GUID = UnitGUID(UnitID)
				local cid = self:GetCIDFromGUID(GUID)
				if cid == 155645 or cid == 152703 then--Walkie Shockie X1 and X2
					local unitPower = UnitPower(UnitID)
					if not unitTracked[GUID] then unitTracked[GUID] = "None" end
					if (unitPower > 90) then
						if unitTracked[GUID] ~= "Green" then
							unitTracked[GUID] = "Green"
							DBM.Nameplate:Show(true, GUID, 276299, 463281)
						end
					elseif (unitPower > 60) then
						if unitTracked[GUID] ~= "Yellow" then
							unitTracked[GUID] = "Yellow"
							DBM.Nameplate:Hide(true, GUID, 276299, 463281)
							DBM.Nameplate:Show(true, GUID, 276299, 460954)
						end
					elseif (unitPower > 30) then
						if unitTracked[GUID] ~= "Red" then
							unitTracked[GUID] = "Red"
							DBM.Nameplate:Hide(true, GUID, 276299, 460954)
							DBM.Nameplate:Show(true, GUID, 276299, 463282)
						end
					elseif (unitPower > 10) then
						if unitTracked[GUID] ~= "Critical" then
							unitTracked[GUID] = "Critical"
							DBM.Nameplate:Hide(true, GUID, 276299, 463282)
							DBM.Nameplate:Show(true, GUID, 276299, 237521)
						end
					end
				end
			end
		end, 1)
	end
end

function mod:OnCombatEnd()
	table.wipe(unitTracked)
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnWalkieShockie then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 295536 then
		specWarnCannonBlast:Show()
		specWarnCannonBlast:Play("farfromline")
	elseif spellId == 295939 then
		specWarnAnnihilationRay:Show()
		specWarnAnnihilationRay:Play("phasechange")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 302274 then
		timerFulminatingZapCD:Start()
	elseif spellId == 303885 then
		timerFulminatingBurstCD:Start()
	elseif spellId == 301351 or spellId == 303553 then--Regular, Hard
		warnReinforcementRelay:Show()
		timerReinforcementRelayCD:Start()
	elseif spellId == 295445 then
		specWarnWreck:Show()
		specWarnWreck:Play("defensive")
		timerWreckCD:Start()
	elseif spellId == 301177 then--Lift Off (haywire ended, return to stage 1)
		--TODO, need a log that didn't one phase him, might be harder to come by these days
		--[[if self.vb.hard  then
			timerFulminatingBurstCD:Start(8.4)--SUCCESS--Assumed
			timerWreckCD:Start(15.7)--Assumed
			timerReinforcementRelayCD:Start(19.8)--Assumed
		else
			timerFulminatingZapCD:Start(8.4)--SUCCESS--Assumed
			timerWreckCD:Start(15.7)--Assumed
			timerReinforcementRelayCD:Start(19.8)--Assumed
		end--]]
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 296080 then
		warnHaywire:Show(args.destName)
		timerHaywire:Start()
	elseif spellId == 302274 then
		warnFulminatingZap:Show(args.destName)
	elseif spellId == 303885 then
		if args:IsPlayer() then
			specWarnFulminatingBurst:Show(DBM_ALLY)
			yellFulminatingBurst:Yell()
			yellFulminatingBurstFades:Countdown(spellId)
		else
			specWarnFulminatingBurst:Show(args.destName)
		end
		specWarnFulminatingBurst:Play("gathershare")
	elseif spellId == 303252 then
		if args:IsPlayer() then
			specWarnAntiTresField:Show(DBM_ALLY)
			yellAntiTresField:Yell()
		else
			specWarnAntiTresField:Show(args.destName)
		end
		specWarnAntiTresField:Play("gathershare")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 296080 then--Haywire
		timerHaywire:Stop()
	elseif spellId == 303885 then
		if args:IsPlayer() then
			yellFulminatingBurstFades:Cancel()
		end
	end
end

--[[
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
	if cid == 150295 or cid == 155760 then--tank-buster-mk1/tank-buster-mk2
		timerWreckCD:Stop()
		timerReinforcementRelayCD:Stop()
		timerFulminatingZapCD:Stop()
		timerFulminatingBurstCD:Stop()
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
