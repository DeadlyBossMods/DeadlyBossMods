local mod	= DBM:NewMod(2355, "DBM-Party-BfA", 11, 1178)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(155157)
mod:SetEncounterID(2291)--VERIFY
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 296080 302274 303885 303252",
	"SPELL_AURA_REMOVED 296080 303885",
	"SPELL_CAST_START 295536 296464 295445 296522 295939",
	"SPELL_CAST_SUCCESS 302274 303885"
	"UNIT_DIED"
)

--TODO, can tank dodge wreck?
--TODO, additional warnings/timers for platform stuff?
--TODO, what CID is boss health/win for this fight?
local warnReinforcementRelay		= mod:NewSpellAnnounce(296464, 2)
local warnSelfDestruct				= mod:NewCastAnnounce(296522, 4)
local warnHaywire					= mod:NewTargetNoFilterAnnounce(296080, 1)
local warnFulminatingZap			= mod:NewTargetNoFilterAnnounce(302274, 2, nil, "Healer")

local specWarnCannonBlast			= mod:NewSpecialWarningDodge(295536, nil, nil, nil, 2, 2)
local specWarnWreck					= mod:NewSpecialWarningDefensive(295445, "Tank", nil, nil, 1, 2)
local specWarnFulminatingBurst		= mod:NewSpecialWarningMoveTo(303885, nil, nil, nil, 1, 2)
local yellFulminatingBurst			= mod:NewYell(303885)
local yellFulminatingBurstFades		= mod:NewShortFadesYell(303885)
--Stage 2
local specWarnAnnihilationRay		= mod:NewSpecialWarningSpell(295939, nil, nil, nil, 2, 2)
local specWarnAntiTresField			= mod:NewSpecialWarningMoveTo(303252, nil, nil, nil, 1, 2)
local yellAntiTresField				= mod:NewYell(303252)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

local timerCannonBlastCD			= mod:NewAITimer(31.6, 295536, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerReinforcementRelayCD		= mod:NewAITimer(31.6, 296464, nil, nil, nil, 1)
local timerWreckCD					= mod:NewAITimer(31.6, 295445, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerFulminatingZapCD			= mod:NewAITimer(31.6, 302274, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON)
local timerFulminatingBurstCD		= mod:NewAITimer(31.6, 303885, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON)--Hard Mode
--Stage 2
local timerAnnihilationRayCD		= mod:NewAITimer(31.6, 295939, nil, nil, nil, 6)
local timerHaywire					= mod:NewBuffActiveTimer(30, 296080, nil, nil, nil, 6)
--local timerHowlingFearCD			= mod:NewAITimer(13.4, 257791, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)

--mod:AddRangeFrameOption(5, 194966)
mod:AddNamePlateOption("NPAuraOnWalkieShockie", 296522, false)

mod.vb.phase = 1

local function checkHardMode(self, delay)
	local found = false
	for i = 1, 5 do
		local unitID = "boss"..i
		if UnitExists(unitID) then
			local cid = self:GetUnitCreatureId(unitID)
			if cid == 150295 then--Mk1
				found = true
				timerCannonBlastCD:Start(1)
				timerReinforcementRelayCD:Start(1)
				timerAnnihilationRayCD:Start(1)
				timerFulminatingZapCD:Start(1)--SUCCESS
			elseif cid == 155760 then--MK2 (hard mode)
				found = true
				timerCannonBlastCD:Start(1)
				timerReinforcementRelayCD:Start(1)
				timerAnnihilationRayCD:Start(1)
				timerFulminatingBurstCD:Start(1)--SUCCESS
			end
		end
	end
	if not found then
		DBM:AddMsg("checkHardMode failed, tell DBM author")
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self:Schedule(1-delay, checkHardMode, self)
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
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnWalkieShockie then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
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
			yellFulminatingBurstFades:Countdown(9)
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
		timerAnnihilationRayCD:Start(2)--Assumed
		timerReinforcementRelayCD:Start(2)--Assumed
		timerCannonBlastCD:Start(2)
	elseif spellId == 303885 then
		if args:IsPlayer() then
			yellFulminatingBurstFades:Cancel()
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 295536 then
		specWarnCannonBlast:Show()
		specWarnCannonBlast:Play("farfromline")
		timerCannonBlastCD:Start()
	elseif spellId == 296464 then
		warnReinforcementRelay:Show()
		timerReinforcementRelayCD:Start()
	elseif spellId == 295445 then
		specWarnWreck:Show()
		specWarnWreck:Play("defensive")
		timerWreckCD:Start(nil, args.sourceGUID)
	elseif spellId == 296522 then
		warnSelfDestruct:Show()
	elseif spellId == 295939 then
		specWarnAnnihilationRay:Show()
		specWarnAnnihilationRay:Play("phasechange")
		--timerAnnihilationRayCD:Start()
		--Possibly redundant
		timerReinforcementRelayCD:Stop()--Assumed
		timerCannonBlastCD:Stop()
		timerFulminatingZapCD:Stop()
		timerFulminatingBurstCD:Stop()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 302274 then
		timerFulminatingZapCD:Start()
	elseif spellId == 303885 then
		timerFulminatingBurstCD:Start()
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
		self.vb.phase = 2
		timerWreckCD:Stop(args.destGUID)
		--Possibly Wrong
		timerCannonBlastCD:Stop()
		timerFulminatingZapCD:Stop()
		timerFulminatingBurstCD:Stop()
		timerReinforcementRelayCD:Stop()
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
