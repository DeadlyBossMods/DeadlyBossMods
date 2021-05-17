local mod	= DBM:NewMod(2454, "DBM-Party-Shadowlands", 9, 1194)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(176556, 176555, 176705)
mod:SetEncounterID(2441)
mod:SetUsedIcons(1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 349663 349797 349987 349934 349954 350086 350101",
	"SPELL_AURA_APPLIED 349627 349933 349954 350101",
	"SPELL_AURA_REMOVED 349627 349933",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, target scan grasp to warn target during cast?
--General
local warnGluttonousFeast			= mod:NewTargetNoFilterAnnounce(349627, 2)

--General
local specWarnGluttonousFeast		= mod:NewSpecialWarningYou(349627, nil, nil, nil, 1, 2)
local yellGluttonousFeast			= mod:NewYell(349627)
local yellGluttonousFeastFades		= mod:NewShortFadesYell(349627)
--Alcruux
local specWarnGripofHunger			= mod:NewSpecialWarningRun(349663, nil, nil, nil, 4, 2)
local specWarnGrandConsumption		= mod:NewSpecialWarningDodge(349663, nil, nil, nil, 2, 2)
--Achillite
local specWarnVentingProtocol		= mod:NewSpecialWarningDodge(349987, nil, nil, nil, 2, 2)
local specWarnPurificationProtocol	= mod:NewSpecialWarningDispel(349954, "RemoveMagic", nil, nil, 1, 2)
--Last Dude
local specWarnWhirlingAnnihilation	= mod:NewSpecialWarningRun(350086, nil, nil, nil, 4, 2)
local specWarnGraspoftheDead		= mod:NewSpecialWarningSwitch(350101, "-Healer", nil, nil, 1, 2)
local yellGraspoftheDead			= mod:NewYell(350101, nil, nil, nil, "YELL")
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(320366, nil, nil, nil, 1, 8)

--Alcruux
local timerGripofHungerCD			= mod:NewAITimer(11, 349663, nil, nil, nil, 2)
local timerGrandconsumptionCD		= mod:NewAITimer(11, 349797, nil, nil, nil, 3)
--Achillite
local timerVentingProtocolCD		= mod:NewAITimer(11, 349987, nil, nil, nil, 3)
local timerFlagellationProtocolCD	= mod:NewAITimer(11, 349934, nil, nil, nil, 3)
local timerPurificationProtocolCD	= mod:NewAITimer(15.8, 320200, nil, nil, nil, 3, nil, DBM_CORE_L.MAGIC_ICON)
local timerWhirlingAnnihilationCD	= mod:NewAITimer(15.8, 350086, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)
local timerGraspoftheDeadCD			= mod:NewAITimer(11, 350101, nil, nil, nil, 1)

mod:AddSetIconOption("SetIconOnFeast", 349627, true, false, {1})
mod:AddInfoFrameOption(349933, true)

function mod:OnCombatStart(delay)
	timerGripofHungerCD:Start(1-delay)
	timerGrandconsumptionCD:Start(1-delay)
end

function mod:OnCombatEnd()
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
		timerGraspoftheDeadCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 349627 then
		if args:IsPlayer() then
			specWarnGluttonousFeast:Show()
			specWarnGluttonousFeast:Play("targetyou")
			yellGluttonousFeast:Yell()
			yellGluttonousFeastFades:Countdown(spellId)
		else
			warnGluttonousFeast:Show(args.destName)
		end
		if self.Options.SetIconOnFeast then
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
			yellGraspoftheDead:Yell()
		else
			specWarnGraspoftheDead:Show(args.destName)
			specWarnGraspoftheDead:Play("killmob")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 349627 then
		if args:IsPlayer() then
			yellGluttonousFeastFades:Cancel()
		end
		if self.Options.SetIconOnFeast then
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
		timerGraspoftheDeadCD:Stop()
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
