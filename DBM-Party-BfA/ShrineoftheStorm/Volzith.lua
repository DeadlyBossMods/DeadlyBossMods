local mod	= DBM:NewMod(2156, "DBM-Party-BfA", 4, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(134069)
mod:SetEncounterID(2133)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED 267444",
	"SPELL_CAST_START 269399 267299 267385 267360",
	"SPELL_ENERGIZE 267310"
)

--TODO, verify/fix SPELL_ENERGIZE 267310
local warnTentacleSlam				= mod:NewCastAnnounce(267385, 2)

local specWarnYawningGate			= mod:NewSpecialWarningRun(269399, "Melee", nil, nil, 4, 2)
local specWarnCalltheAbyss			= mod:NewSpecialWarningMove(267299, "Tank", nil, nil, 1, 2)
local specWarnGrasp					= mod:NewSpecialWarningSpell(267360, nil, nil, nil, 2, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

local timerYawningGateCD			= mod:NewCDTimer(21, 269399, nil, nil, nil, 3)
local timerCalltheAbyssCD			= mod:NewNextTimer(90, 267299, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerGraspCD					= mod:NewNextTimer(50, 267360, nil, nil, nil, 6, nil, nil, nil, 1, 4)


function mod:OnCombatStart(delay)
	timerYawningGateCD:Start(13-delay)
	timerGraspCD:Start(20.5-delay)
	--if not self:IsNormal() then
		--timerCalltheAbyssCD:Start(73-delay)
	--end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 267444 then
		if not self:IsNormal() then
			timerCalltheAbyssCD:Start(5.5)
		end
		timerYawningGateCD:Start(16.3)
		timerGraspCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 269399 then
		specWarnYawningGate:Show()
		specWarnYawningGate:Play("justrun")
		timerYawningGateCD:Start()
	elseif spellId == 267299 then
		specWarnCalltheAbyss:Show()
		specWarnCalltheAbyss:Play("moveboss")
		timerCalltheAbyssCD:Start()
	elseif spellId == 267385 and self:AntiSpam(1.5, 2) then
		warnTentacleSlam:Show()
	elseif spellId == 267360 then
		specWarnGrasp:Show()
		specWarnGrasp:Play("phasechange")
		timerYawningGateCD:Stop()
		timerCalltheAbyssCD:Stop()
	end
end

function mod:SPELL_ENERGIZE(_, _, _, _, destGUID, _, _, _, spellId, _, _, amount)
	if spellId == 267310 and destGUID == UnitGUID("boss1") then
		--TODO, even more complex marked for death checks here to factor that into energy updating.
		DBM:Debug("SPELL_ENERGIZE fired. Amount: "..amount)
		local bossPower = UnitPower("boss1")
		bossPower = bossPower / 2--2 energy per second, grasp every 50 seconds there abouts.
		local remaining = 50-bossPower
		local newTimer = 50-remaining
		timerGraspCD:Update(newTimer, 50)
	end
end
