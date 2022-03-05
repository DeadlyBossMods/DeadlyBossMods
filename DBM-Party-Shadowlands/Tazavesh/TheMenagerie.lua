local mod	= DBM:NewMod(2454, "DBM-Party-Shadowlands", 9, 1194)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(176556, 176555, 176705)
mod:SetEncounterID(2441)
mod:SetUsedIcons(1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 349663 349797 349987 349934 349954 350086 350101",
	"SPELL_CAST_SUCCESS 181089",
	"SPELL_AURA_APPLIED 349627 349933 349954 350101",
	"SPELL_AURA_REMOVED 349627 349933",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
--	"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, target scan grasp to warn target during cast?
--TODO, find way of detecting hard mode and start engage timers for incoming bosses
--General
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(320366, nil, nil, nil, 1, 8)
--Alcruux
mod:AddTimerLine(DBM:EJ_GetSectionInfo(23159))
local warnGluttony					= mod:NewTargetNoFilterAnnounce(349627, 2)

local specWarnGluttony				= mod:NewSpecialWarningYou(349627, nil, nil, nil, 1, 2)
local yellGluttony					= mod:NewYell(349627)
local yellGluttonyFades				= mod:NewShortFadesYell(349627)
local specWarnGripofHunger			= mod:NewSpecialWarningRun(349663, nil, nil, nil, 4, 2)
local specWarnGrandConsumption		= mod:NewSpecialWarningDodge(349663, nil, nil, nil, 2, 2)

local timerGripofHungerCD			= mod:NewAITimer(11, 349663, nil, nil, nil, 2)
local timerGrandconsumptionCD		= mod:NewAITimer(11, 349797, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnGluttony", 349627, true, false, {1})
--Achillite
mod:AddTimerLine(DBM:EJ_GetSectionInfo(23231))
local specWarnVentingProtocol		= mod:NewSpecialWarningDodge(349987, nil, nil, nil, 2, 2)
local specWarnPurificationProtocol	= mod:NewSpecialWarningDispel(349954, "RemoveMagic", nil, nil, 1, 2)

local timerAchilliteCD				= mod:NewNextTimer(11, "ej23231", nil, nil, nil, 1, "132349")
local timerVentingProtocolCD		= mod:NewAITimer(11, 349987, nil, nil, nil, 3)
local timerFlagellationProtocolCD	= mod:NewAITimer(11, 349934, nil, nil, nil, 3)
local timerPurificationProtocolCD	= mod:NewAITimer(15.8, 320200, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)

mod:AddInfoFrameOption(349934, true)
--Venza Goldfuse
mod:AddTimerLine(DBM:EJ_GetSectionInfo(23241))
local specWarnWhirlingAnnihilation	= mod:NewSpecialWarningRun(350086, nil, nil, nil, 4, 2)
local specWarnChainsofDamnation		= mod:NewSpecialWarningSwitch(350101, "-Healer", nil, nil, 1, 2)
local yellChainsofDamnation			= mod:NewYell(350101, nil, nil, nil, "YELL")

local timerVenzaCD					= mod:NewNextTimer(11, "ej23241", nil, nil, nil, 1, "132349")
local timerWhirlingAnnihilationCD	= mod:NewAITimer(15.8, 350086, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerChainsofDamnationCD		= mod:NewAITimer(11, 350101, nil, nil, nil, 1)

local activeBossGUIDS = {}

function mod:OnCombatStart(delay)
	--Alcruux timers
	timerGripofHungerCD:Start(1-delay)
	timerGrandconsumptionCD:Start(1-delay)
	--if hardmode stuff then
		--timerAchilliteCD:Start(28-delay)
		--timerVenzaCD:Start(65-delay)
	--end
end

function mod:OnCombatEnd()
	table.wipe(activeBossGUIDS)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 349663 then
		specWarnGripofHunger:Show()
		specWarnGripofHunger:Play("justrun")
		timerGripofHungerCD:Start()
	elseif spellId == 349797 then
		specWarnGrandConsumption:Show()
		specWarnGrandConsumption:Play("watchorb")
		timerGrandconsumptionCD:Start()
	elseif spellId == 349987 then
		specWarnVentingProtocol:Show()
		specWarnVentingProtocol:Play("watchorb")
		timerVentingProtocolCD:Start()
	elseif spellId == 349934 then
		timerFlagellationProtocolCD:Start()
	elseif spellId == 349954 then
		timerPurificationProtocolCD:Start()
	elseif spellId == 350086 then
		specWarnWhirlingAnnihilation:Show()
		specWarnWhirlingAnnihilation:Play("justrun")
		specWarnWhirlingAnnihilation:ScheduleVoice(1, "keepmove")
		timerWhirlingAnnihilationCD:Start()
	elseif spellId == 350101 then
		timerChainsofDamnationCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 181089 then
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 176555 then--Achillite
			timerVentingProtocolCD:Start(1)
			timerFlagellationProtocolCD:Start(1)
			timerPurificationProtocolCD:Start(1)
		elseif cid == 176705 then--Venza Gldfuse
			timerWhirlingAnnihilationCD:Start(1)
			timerChainsofDamnationCD:Start(1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 349627 then
		if args:IsPlayer() then
			specWarnGluttony:Show()
			specWarnGluttony:Play("targetyou")
			yellGluttony:Yell()
			yellGluttonyFades:Countdown(spellId)
		else
			warnGluttony:Show(args.destName)
		end
		if self.Options.SetIconOnGluttony then
			self:SetIcon(args.destName, 1)
		end
	elseif spellId == 349933 then
		if self.Options.InfoFrame then
			local bossUnitID = self:GetUnitIdFromGUID(args.destGUID)
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, bossUnitID)
		end
	elseif spellId == 349954 then
		specWarnPurificationProtocol:CombinedShow(0.3, args.destName)
		specWarnPurificationProtocol:ScheduleVoice(0.3, "helpdispel")
	elseif spellId == 350101 then
		if args:IsPlayer() then
			yellChainsofDamnation:Yell()
		else
			specWarnChainsofDamnation:Show(args.destName)
			specWarnChainsofDamnation:Play("killmob")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 349627 then
		if args:IsPlayer() then
			yellGluttonyFades:Cancel()
		end
		if self.Options.SetIconOnGluttony then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 349933 then
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 320366 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 176556 then--Alcruux
		timerGripofHungerCD:Stop()
		timerGrandconsumptionCD:Stop()
	elseif cid == 176555 then--Achillite
		timerVentingProtocolCD:Stop()
		timerPurificationProtocolCD:Stop()
	elseif cid == 176705 then--Venza Gldfuse
		timerWhirlingAnnihilationCD:Stop()
		timerChainsofDamnationCD:Stop()
	end
end

--[[
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local unitGUID = UnitGUID(unitID)
		if UnitExists(unitID) and not activeBossGUIDS[unitGUID] then
			activeBossGUIDS[unitGUID] = true
			local cid = self:GetUnitCreatureId(unitID)
			if cid == 176555 then--Achillite
				timerVentingProtocolCD:Start(1)
				timerFlagellationProtocolCD:Start(1)
				timerPurificationProtocolCD:Start(1)
			elseif cid == 176705 then--Venza Gldfuse
				timerWhirlingAnnihilationCD:Start(1)
				timerChainsofDamnationCD:Start(1)
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
