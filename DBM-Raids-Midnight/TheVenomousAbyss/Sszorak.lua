if DBM:GetTOC() < 120100 then return end
local mod	= DBM:NewMod(2871, "DBM-Raids-Midnight", 1, 1320)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(238693)
mod:SetEncounterID(3420)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(3004)

mod:RegisterCombat("combat")

--TODO, verify raging crosswinds actually has a personal ENCOUNTER_WARNING. Also, recored custom audio after test if it does ("winds on you" likely)
DBM:RegisterAltSpellName(1277025, DBM_COMMON_L.TANKCOMBO)--Apex Predator --> Tank Combo
local specWarnRagingCrosswinds			= mod:NewSpecialWarningYouCount(1285425, nil, nil, nil, 1, 17, nil, nil, "debuffyou")
local specWarnVenomousSurge				= mod:NewSpecialWarningCount(1305959, nil, nil, nil, 1, 18, nil, nil, "poolyou")
local specWarnApexPedator				= mod:NewSpecialWarningCount(1285430, nil, nil, nil, 1, 19, nil, nil, "tankcombo")
local specWarnHowlingMaelstrom			= mod:NewSpecialWarningCount(1285732, nil, nil, nil, 2, 13, nil, nil, "pushbackincoming")
local specWarnCausticClaws				= mod:NewSpecialWarningCount(1285733, nil, nil, nil, 2, 2, nil, nil, "scatter")--Sub mechanic of Venomous Surge

local timerRagingCrosswindsCD			= mod:NewCDCountTimer(20.5, 1285425, nil, nil, nil, 3)
local timerVenomousSurgeCD				= mod:NewCDCountTimer(20.5, 1305959, nil, nil, nil, 3)
local timerApexPedatorCD				= mod:NewCDCountTimer(20.5, 1285430, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerHowlingMaelstromCD			= mod:NewCDCountTimer(20.5, 1285732, nil, nil, nil, 2, nil, DBM_COMMON_L.IMPORTANT_ICON)
local timerBerserkCD					= mod:NewBerserkTimer(600)

--local badStateDetected = false--Used to track if hardcode features have failed and we need to fall back to blizz API

mod.vb.RagingCrosswindsCount = 0
mod.vb.VenomousSurgeCount = 0
mod.vb.ApexPedatorCount = 0
mod.vb.HowlingMaelstromCount = 0

---@param self DBMMod
---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		if self:IsTank() then
			specWarnApexPedator:SetAlert(664, "tankcombo", 19, 2)
		end
		specWarnRagingCrosswinds:SetAlert(652, "debuffyou", 17, 2, 0)
		specWarnVenomousSurge:SetAlert(653, "poolyou", 18, 2, 0)
		specWarnHowlingMaelstrom:SetAlert(665, "pushbackincoming", 13, 2)
		specWarnCausticClaws:SetAlert(851, "scatter", 2, 2)
	end
	local onlyColor = not DBM.Options.HideDBMBars
	timerRagingCrosswindsCD:SetTimeline(652, onlyColor)
	timerVenomousSurgeCD:SetTimeline(653, onlyColor)
	timerApexPedatorCD:SetTimeline(664, onlyColor)
	timerHowlingMaelstromCD:SetTimeline(665, onlyColor)
	timerBerserkCD:SetTimeline(863, onlyColor)
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
	self.vb.RagingCrosswindsCount = 1
	self.vb.VenomousSurgeCount = 1
	self.vb.ApexPedatorCount = 1
	self.vb.HowlingMaelstromCount = 1
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
