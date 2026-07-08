if DBM:GetTOC() < 120100 then return end
local mod	= DBM:NewMod(2894, "DBM-Raids-Midnight", 1, 1320)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(238693)
mod:SetEncounterID(3497)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(3004)

mod:RegisterCombat("combat")

--DBM:RegisterAltSpellName(1257717, DBM_COMMON_L.ADDS)--Alluring Bubble --> Adds
--TODO: Shell spin targets possible?
--TODO: Toss targets for toss mechanics?
--TODO, Frostfire Volley patches need GTFOs, when it's possible (aura api?)
--TODO, all of Mor'zahi mechanics are missing EncounterEvents (or assigned to invalid encounterIds)
--NOTE: Blink Nova has two spellids and two encounter event IDs. TODO, identify if maybe diff IDs are diff teleport locations and further refine voice pack
--NOTE: These 3 spells are not timeline based but activated on deaths that we cant detect so we'll use non hardcoded objects for them only. Cataclysmic Invocation, Relentless Escalation, and Smashing Shovel
mod:AddCustomAlertSoundOption(1291390, true, 2)--Cataclysmic Invocation
--mod:AddCustomAlertSoundOption(0, true, 2)--Relentless Escalation (no event ID?)
--mod:AddCustomAlertSoundOption(0, true, 2)--Smashing Shovel (no event ID?)
mod:AddCustomAlertSoundOption(1292779, true, 2, nil)--Empowered Ascension
local warnFlingFish						= mod:NewCountAnnounce(1295817, 3)--hardcode only?

local specWarnIceboundFlames			= mod:NewSpecialWarningInterruptCount(1286921, nil, nil, nil, 1, 2, nil, nil, "lineyou")
local specWarnBlinkNova					= mod:NewSpecialWarningRunCount(1290711, nil, nil, nil, 4, 2, nil, nil, "justrun")
local specWarnMightyThud				= mod:NewSpecialWarningSoakCount(1296092, nil, nil, nil, 2, 17, nil, nil, "soakincoming")
local specWarnShellSpin					= mod:NewSpecialWarningDodgeCount(1291759, nil, nil, nil, 2, 2, nil, nil, "farfromline")
local specWarnThrowJunk					= mod:NewSpecialWarningDodgeCount(1291933, nil, nil, nil, 2, 2, nil, nil, "watchstep")
local specWarnMushroomToss				= mod:NewSpecialWarningDodgeCount(1292104, nil, nil, nil, 2, 2, nil, nil, "watchstep")
local specWarnShreddingShards			= mod:NewSpecialWarningDodgeCount(1295854, nil, nil, nil, 1, 2, nil, nil, "defensive")
local specWarnFrostfireVolley			= mod:NewSpecialWarningDodgeCount(1295886, nil, nil, nil, 2, 2, nil, nil, "watchstep")
local specWarnExplosiveSurprise			= mod:NewSpecialWarningDodgeCount(1296249, nil, nil, nil, 2, 2, nil, nil, "bombnow")

local timerIceboundFlamesCD				= mod:NewCDCountTimer(20.5, 1286921, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerBlinkNovaCD					= mod:NewCDCountTimer(20.5, 1290711, nil, nil, nil, 2)
local timerMightyThudCD					= mod:NewCDCountTimer(20.5, 1296092, nil, nil, nil, 5)
local timerShellSpinCD					= mod:NewCDCountTimer(20.5, 1291759, nil, nil, nil, 3)
local timerThrowJunkCD					= mod:NewCDCountTimer(20.5, 1291933, nil, nil, nil, 3)
local timerFlingFishCD					= mod:NewCDCountTimer(20.5, 1295817, nil, nil, nil, 5)
local timerMushroomTossCD				= mod:NewCDCountTimer(20.5, 1292104, nil, nil, nil, 3)
local timerShreddingShardsCD			= mod:NewCDCountTimer(20.5, 1295854, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerFrostfireVolleyCD			= mod:NewCDCountTimer(20.5, 1295886, nil, nil, nil, 3)
local timerExplosiveSurpriseCD			= mod:NewCDCountTimer(20.5, 1296249, nil, nil, nil, 3)
--local timerBerserkCD					= mod:NewBerserkTimer(600)--Unending Tides

local badStateDetected = false--Used to track if hardcode features have failed and we need to fall back to blizz API

mod.vb.IceboundFlamesCount = 0
mod.vb.BlinkNovaCount = 0
mod.vb.MightyThudCount = 0
mod.vb.ShellSpinCount = 0
mod.vb.ThrowJunkCount = 0
mod.vb.FlingFishCount = 0
mod.vb.MushroomTossCount = 0
mod.vb.ShreddingShardsCount = 0
mod.vb.FrostfireVolleyCount = 0
mod.vb.ExplosiveSurpriseCount = 0

---@param self DBMMod
---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		if self:IsTank() then
			specWarnShreddingShards:SetAlert(768, "defensive", 2, 2)
		end
		specWarnIceboundFlames:SetAlert(722, "kickcast", 2, 2)
		specWarnBlinkNova:SetAlert({723, 724, 737, 738}, "justrun", 2, 3)--1290711, 1290742, 1290740, 1290743
		specWarnMightyThud:SetAlert(725, "soakincoming", 17, 2)
		specWarnShellSpin:SetAlert(726, "farfromline", 2, 2)
		specWarnThrowJunk:SetAlert(727, "watchstep", 2, 2)
		specWarnMushroomToss:SetAlert(729, "watchstep", 2, 2)
		specWarnFrostfireVolley:SetAlert({776, 777}, "watchstep", 2, 2)--1295886, 1295935
		specWarnExplosiveSurprise:SetAlert(781, "bombnow", 2, 2)
	end
	--If user has DBM bars enabled, we only want to register colors to the blizz api so that the blizz bars are also colorized.
	--If user has bars disabled, or we are in a bad state, onlyColor is false and we register countdowns as well.
	local onlyColor = not DBM.Options.HideDBMBars and not badStateDetected
	timerIceboundFlamesCD:SetTimeline(722, onlyColor)
	timerBlinkNovaCD:SetTimeline({723, 724, 737, 738}, onlyColor)
	timerMightyThudCD:SetTimeline(725, onlyColor)
	timerShellSpinCD:SetTimeline(726, onlyColor)
	timerThrowJunkCD:SetTimeline(727, onlyColor)
	timerFlingFishCD:SetTimeline(728, onlyColor)
	timerMushroomTossCD:SetTimeline(729, onlyColor)
	timerShreddingShardsCD:SetTimeline(768, onlyColor)
	timerFrostfireVolleyCD:SetTimeline({776, 777}, onlyColor)
	timerExplosiveSurpriseCD:SetTimeline(781, onlyColor)
end

function mod:OnLimitedCombatStart()
	self:EnableAlertOptions(1291390, 721, "stilldanger", 2)
	self:EnableAlertOptions(1292779, 783, "stilldanger", 4)
	self:TLCountReset()
	self.vb.IceboundFlamesCount = 1
	self.vb.BlinkNovaCount = 1
	self.vb.MightyThudCount = 1
	self.vb.ShellSpinCount = 1
	self.vb.ThrowJunkCount = 1
	self.vb.FlingFishCount = 1
	self.vb.MushroomTossCount = 1
	self.vb.ShreddingShardsCount = 1
	self.vb.FrostfireVolleyCount = 1
	self.vb.ExplosiveSurpriseCount = 1
	--Hardcode features first
	--if DBM.Options.HardcodedTimer and not badStateDetected then
	--	--self:SetStage(1)
	--	self:IgnoreBlizzardAPI()
	--	self:RegisterShortTermEvents(
	--		"ENCOUNTER_TIMELINE_EVENT_ADDED",
	--		"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
	--	)
	--	if DBM.Options.HideDBMBars then
	--		setFallback(self, true)
	--	end
	--else
		setFallback(self)
	--end
end


function mod:OnCombatEnd()
	self:TLCountReset()
	self:UnregisterShortTermEvents()
end

--[[
do
	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersAll(self, timer, timerExact, eventID)
		local handled
		if timer == 114 then
			handled = true
			timerWaterJetCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "waterjet", "tankWaterCount"))
		end

		if not handled then--Reached end of chain without finding a valid timer, this means hardcode mod has failed, so we need to disable hardcoded features and fall back to blizz API
			badStateDetected = true
			self:ResumeBlizzardAPI()
			self:UnregisterShortTermEvents()
			setFallback(self)
			DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
		end
	end

	--Note, bar state changing and canceling is handled by core

	function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
		if eventInfo.source ~= 0 then return end
		local eventID = eventInfo.id
		local timerExact = eventInfo.duration
		local timer = math.floor(timerExact + 0.5)
		if not badStateDetected then
			timersAll(self, timer, timerExact, eventID)
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		if eventState == 2 then
			local eventType, eventCount = self:TLCountFinish(eventID)
			if not eventType then return end
			if not eventCount then return end
			if eventType == "waterjet" then
				--specWarnWaterJet:Show(eventCount, "lineyou")
			end
		elseif eventState == 3 then
			self:TLCountCancel(eventID)
		end
	end
end
--]]
