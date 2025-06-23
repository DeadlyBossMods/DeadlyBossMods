if DBM:GetTOC() < 110200 then return end
local mod	= DBM:NewMod(2687, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(247989)
mod:SetEncounterID(3132)
mod:SetHotfixNoticeRev(20250622000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1228502 1228216 1228161 1227631 1231720 1234328 1248009 1232221",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 1228506 1228454 1228188 1233979 1240437 1233415 1243873",
	"SPELL_AURA_APPLIED_DOSE 1228506",
	"SPELL_AURA_REMOVED 1228454 1233979 1233415 1240437 1243873",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, tank stacks placeholder, or eliminate tank stacks if swaps just happen naturally with arcane obliteration
--TODO, see if https://www.wowhead.com/ptr-2/spell=1228220/arcane-echo spell summon logged?
--TODO, need a better understanding how echos work before implimenting their timer and alert handling correctly
--TODO, maybe announce people silenced by https://www.wowhead.com/ptr-2/spell=1228168/silencing-tempest
--TODO, better handling of arcane collector stuff
--TODO, nameplate timer for https://www.wowhead.com/ptr-2/spell=1228213/astral-harvest ?
--TODO, use https://www.wowhead.com/ptr-2/spell=1228214/astral-harvest if the 10 second debuff not exposed
--TODO, detect intermission arcane collector spawns and initial timers
--TODO, https://www.wowhead.com/ptr-2/spell=1232590/arcane-convergence ?
--TODO, tanks waps for https://www.wowhead.com/ptr-2/spell=1238266/ramping-power on Shielded Attendant?
--TODO, hungering gloom is coded same way as harvest so same questions with 3 spellids
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(28754))
local warnOverwhelmingPower							= mod:NewStackAnnounce(1228502, 2, nil, "Tank|Healer")

local specWarnOverwhelmingPower						= mod:NewSpecialWarningStack(1228502, nil, 10, nil, nil, 1, 6)
local specWarnOverwhelmingPowerTaunt				= mod:NewSpecialWarningTaunt(1228502, nil, nil, nil, 1, 2)
local specWarnArcaneObliteration					= mod:NewSpecialWarningCount(1228216, nil, nil, DBM_COMMON_L.GROUPSOAK, 2, 2)
local yellArcaneObliteration						= mod:NewShortYell(1228216, DBM_COMMON_L.GROUPSOAK, nil, nil, "YELL")
local yellArcaneObliterationFades					= mod:NewShortFadesYell(1228216, nil, nil, nil, "YELL")
local specWarnSilencingTempest						= mod:NewSpecialWarningDodgeCount(1228161, nil, nil, nil, 2, 2)
local yellSilencingTempest							= mod:NewShortYell(1228161)
local specWarnArcaneExpulsion						= mod:NewSpecialWarningDodgeCount(1227631, nil, nil, nil, 2, 2)
local specWarnInvokeCollector						= mod:NewSpecialWarningSwitchCount(1231720, "-Tank", nil, nil, 1, 2)--Tank should stay away
local specWarnAstralHarvest							= mod:NewSpecialWarningYou(1233979, nil, nil, nil, 1, 2)
local yellAstralHarvestFades						= mod:NewShortFadesYell(1233979)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(459785, nil, nil, nil, 1, 8)

local timerOverwhelmingPowerCD						= mod:NewAITimer(97.3, 1228502, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerArcaneObliterationCD						= mod:NewAITimer(97.3, 1228216, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerSilencingTempestCD						= mod:NewAITimer(97.3, 1228161, nil, nil, nil, 3)
local timerArcaneExpulsionCD						= mod:NewAITimer(97.3, 1227631, nil, nil, nil, 2)
local timerInvokeCollectorCD						= mod:NewAITimer(97.3, 1231720, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)

mod:AddNamePlateOption("NPAuraOnMarkofPower", 1238502)
--Intermission: Priming the Forge
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32397))
local warnManaSplinter								= mod:NewTargetNoFilterAnnounce(1233415, 1)
local warnManaSplinterFaded							= mod:NewFadesAnnounce(1233415, 2)
local specWarnPhotonBlast							= mod:NewSpecialWarningDodge(1234328, nil, nil, nil, 2, 15)
--Intermission: The Iris Opens
--No new mechanics
--Stage Two: Darkness Hungers
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32384))
local warnDarkTerminus								= mod:NewCastAnnounce(1248009, 2, nil, nil, nil, nil, nil, 2)

local specWarnHungeringGloom						= mod:NewSpecialWarningYou(1243873, nil, nil, nil, 1, 2)
local yellHungeringGloomFades						= mod:NewShortFadesYell(1243873)
local specWarnDeaththroes							= mod:NewSpecialWarningCount(1232221, nil, nil, nil, 2, 2, 4)

local timerHungeringGloomCD							= mod:NewAITimer(97.3, 1243873, nil, nil, nil, 3)
local timerDeaththroesCD							= mod:NewAITimer(97.3, 1232221, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)

mod.vb.obliterationCount = 0
mod.vb.silencingTempestCount = 0
mod.vb.arcaneExpulsionCount = 0
mod.vb.invokeCollectorCount = 0
mod.vb.hungeringGloomCount = 0
mod.vb.deaththroesCount = 0

---@param self DBMMod
local function delayedTankCheck(self)
	local _, unitID = self:GetBossTarget(247989)
	if unitID and UnitIsUnit("player", unitID) then
		yellArcaneObliteration:Yell()
		yellArcaneObliterationFades:Countdown(4.7)
	end
	specWarnArcaneObliteration:Show(self.vb.obliterationCount)
	if self:IsMythic() then
		if self.vb.obliterationCount % 2 == 0 then
			specWarnArcaneObliteration:Play("sharetwo")
		else
			specWarnArcaneObliteration:Play("shareone")
		end
	else
		specWarnArcaneObliteration:Play("helpsoak")
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.obliterationCount = 0
	self.vb.silencingTempestCount = 0
	self.vb.arcaneExpulsionCount = 0
	self.vb.invokeCollectorCount = 0
	self.vb.hungeringGloomCount = 0
	self.vb.deaththroesCount = 0
	timerOverwhelmingPowerCD:Start(1-delay)
	timerArcaneObliterationCD:Start(1-delay)
	timerSilencingTempestCD:Start(1-delay)
	timerArcaneExpulsionCD:Start(1-delay)
	timerInvokeCollectorCD:Start(1-delay)
	if self.Options.NPAuraOnMarkofPower then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnMarkofPower then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1228502 then
		timerOverwhelmingPowerCD:Start()
	elseif spellId == 1228216 then
		self.vb.obliterationCount = self.vb.obliterationCount + 1
		timerArcaneObliterationCD:Start()--nil, self.vb.obliterationCount+1
		--Delayed so it doesn't grab invalid target since boss might be looking at previous target on first frame
		self:Schedule(0.3, delayedTankCheck, self)
	elseif spellId == 1228161 then
		self.vb.silencingTempestCount = self.vb.silencingTempestCount + 1
		specWarnSilencingTempest:Show(self.vb.silencingTempestCount)
		specWarnSilencingTempest:Play("watchstep")
		timerSilencingTempestCD:Start()--nil, self.vb.silencingTempestCount+1
	elseif spellId == 1227631 then
		self.vb.arcaneExpulsionCount = self.vb.arcaneExpulsionCount + 1
		specWarnArcaneExpulsion:Show(self.vb.arcaneExpulsionCount)
		specWarnArcaneExpulsion:Play("carefly")
		timerArcaneExpulsionCD:Start()--nil, self.vb.arcaneExpulsionCount+1
	elseif spellId == 1231720 then
		self.vb.invokeCollectorCount = self.vb.invokeCollectorCount + 1
		specWarnInvokeCollector:Show(self.vb.invokeCollectorCount)
		specWarnInvokeCollector:Play("killmob")
		timerInvokeCollectorCD:Start()--nil, self.vb.invokeCollectorCount+1
	elseif spellId == 1234328 and self:AntiSpam(3, 1) then--antispam cause add count unknown
		specWarnPhotonBlast:Show()
		specWarnPhotonBlast:Play("frontal")
	elseif spellId == 1248009 then--Dark Terminus precast for singularity
		warnDarkTerminus:Show()
		warnDarkTerminus:Play("ptwo")
		--Start p2 timers
		timerOverwhelmingPowerCD:Start(2)
		timerSilencingTempestCD:Start(2)
		timerHungeringGloomCD:Start(2)
		if self:IsMythic() then
			timerDeaththroesCD:Start(2)
		end
	elseif spellId == 1232221 then--Deaththroes
		self.vb.deaththroesCount = self.vb.deaththroesCount + 1
		specWarnDeaththroes:Show(self.vb.deaththroesCount)
		specWarnDeaththroes:Play("specialsoon")
		timerDeaththroesCD:Start()--nil, self.vb.deaththroesCount+1
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 439559 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1228506 then
		local amount = args.amount or 1
		if amount >= 10 then--placeholder
			if args:IsPlayer() then
				specWarnOverwhelmingPower:Show(amount)
				specWarnOverwhelmingPower:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") then
					specWarnOverwhelmingPowerTaunt:Show(args.destName)
					specWarnOverwhelmingPowerTaunt:Play("tauntboss")
				end
			end
		else
			warnOverwhelmingPower:Show(args.destName, amount)
		end
	elseif spellId == 1228454 then
		if self.Options.NPAuraOnMarkofPower then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 1228188 and args:IsPlayer() then
		yellSilencingTempest:Yell()
	elseif spellId == 1233979 then
		if args:IsPlayer() then
			specWarnAstralHarvest:Show()
			specWarnAstralHarvest:Play("runout")
			yellAstralHarvestFades:Countdown(spellId)
		end
	elseif spellId == 1243873 then
		if self:AntiSpam(3, 2) then
			timerHungeringGloomCD:Start()
		end
		if args:IsPlayer() then
			specWarnHungeringGloom:Show()
			specWarnHungeringGloom:Play("runout")
			yellHungeringGloomFades:Countdown(spellId)
		end
		if self:GetStage(1) then
			self:SetStage(1.5)
			--Stop all timers
			timerOverwhelmingPowerCD:Stop()
			timerArcaneObliterationCD:Stop()
			timerSilencingTempestCD:Stop()
			timerArcaneExpulsionCD:Stop()
			timerInvokeCollectorCD:Stop()
		end
	elseif spellId == 1240437 then--Volatile Surge
		if self:GetStage(1) then
			self:SetStage(1.5)
			--Stop all timers
			timerOverwhelmingPowerCD:Stop()
			timerArcaneObliterationCD:Stop()
			timerSilencingTempestCD:Stop()
			timerArcaneExpulsionCD:Stop()
			timerInvokeCollectorCD:Stop()
		end
	elseif spellId == 1233415 then
		warnManaSplinter:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1228454 then
		if self.Options.NPAuraOnMarkofPower then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 1233979 then
		if args:IsPlayer() then
			yellAstralHarvestFades:Cancel()
		end
	elseif spellId == 1243873 then
		if args:IsPlayer() then
			yellHungeringGloomFades:Cancel()
		end
	elseif spellId == 1233415 then
		warnManaSplinterFaded:Show()
	elseif spellId == 1240437 then--Volatile Surge removed
		if self:GetStage(1.5) then
			self:SetStage(1)
			--Start all timers
			timerOverwhelmingPowerCD:Start(2)
			timerArcaneObliterationCD:Start(2)
			timerSilencingTempestCD:Start(2)
			timerArcaneExpulsionCD:Start(2)
			timerInvokeCollectorCD:Start(2)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 241923 then--Arcane Echo

	elseif cid == 241832 then--Shielded Attendant

	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 459785 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 1232410 then--Unstable Surge
		if self:GetStage(1.7, 1) then
			self:SetStage(1.7)
			--Stop all timers
			timerOverwhelmingPowerCD:Stop()
			timerArcaneObliterationCD:Stop()
			timerSilencingTempestCD:Stop()
			timerArcaneExpulsionCD:Stop()
			timerInvokeCollectorCD:Stop()
		end
	end
end
