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
	"SPELL_AURA_APPLIED 349627 349933 349954 350101 350037",
	"SPELL_AURA_REMOVED 349627 349933",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
)

--TODO, target scan grasp to warn target during cast?
--TODO, find way of detecting hard mode timers
--[[
(ability.id = 349663 or ability.id = 349797 or ability.id = 349987 or ability.id = 349934 or ability.id = 349954 or ability.id = 350086 or ability.id = 350101) and type = "begincast"
 or ability.id = 181089 and type = "cast"
 or ability.id = 350037 and type = "applybuff"
 or target.id = 176556 and type = "death"
 or type = "dungeonencounterstart" or type = "dungeonencounterend"
--]]
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

local timerGripofHungerCD			= mod:NewCDTimer(23, 349663, nil, nil, nil, 2)--23-30
local timerGrandconsumptionCD		= mod:NewCDTimer(30.3, 349797, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnGluttony", 349627, true, false, {1})
--Achillite
mod:AddTimerLine(DBM:EJ_GetSectionInfo(23231))
local specWarnVentingProtocol		= mod:NewSpecialWarningDodge(349987, nil, nil, nil, 2, 2)
local specWarnPurificationProtocol	= mod:NewSpecialWarningDispel(349954, "RemoveMagic", nil, nil, 1, 2)

--local timerAchilliteCD			= mod:NewNextTimer(11, "ej23231", nil, nil, nil, 1, "132349")
local timerVentingProtocolCD		= mod:NewCDTimer(26.6, 349987, nil, nil, nil, 3)
local timerFlagellationProtocolCD	= mod:NewCDTimer(23, 349934, nil, nil, nil, 3)
local timerPurificationProtocolCD	= mod:NewCDTimer(18.2, 320200, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)

mod:AddInfoFrameOption(349934, true)
--Venza Goldfuse
mod:AddTimerLine(DBM:EJ_GetSectionInfo(23241))
local specWarnWhirlingAnnihilation	= mod:NewSpecialWarningRun(350086, nil, nil, nil, 4, 2)
local specWarnChainsofDamnation		= mod:NewSpecialWarningSwitch(350101, "-Healer", nil, nil, 1, 2)
local yellChainsofDamnation			= mod:NewYell(350101, nil, nil, nil, "YELL")

--local timerVenzaCD				= mod:NewNextTimer(11, "ej23241", nil, nil, nil, 1, "132349")
local timerWhirlingAnnihilationCD	= mod:NewCDTimer(30.3, 350086, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerChainsofDamnationCD		= mod:NewCDCountTimer(30.3, 350101, nil, nil, nil, 1)

local activeBossGUIDS = {}
mod.vb.chainsCast = 0

function mod:OnCombatStart(delay)
	--Alcruux timers
	timerGripofHungerCD:Start(11.8-delay)
	timerGrandconsumptionCD:Start(24.2-delay)
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
		self.vb.chainsCast = self.vb.chainsCast + 1
		timerChainsofDamnationCD:Start(self.vb.chainsCast == 1 and 21.8 or 30.3, self.vb.chainsCast+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 181089 then
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 176555 then--Achillite
			timerPurificationProtocolCD:Start(4.7)
			timerFlagellationProtocolCD:Start(14.5)
			timerVentingProtocolCD:Start(21.7)
		elseif cid == 176705 then--Venza Gldfuse
			self.vb.chainsCast = 0
			timerChainsofDamnationCD:Start(4.8, 1)
			timerWhirlingAnnihilationCD:Start(16.9)
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
	elseif spellId == 350037 then--Achillite "dying" (doesn't fire UNIT_DIED)
		timerVentingProtocolCD:Stop()
		timerFlagellationProtocolCD:Stop()
		timerPurificationProtocolCD:Stop()
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
	end
end
