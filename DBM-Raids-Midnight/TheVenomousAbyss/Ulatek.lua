if DBM:GetTOC() < 120100 then return end
local mod	= DBM:NewMod(2895, "DBM-Raids-Midnight", 1, 1320)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(238693)
mod:SetEncounterID(3492)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(3004)

mod:RegisterCombat("combat")

--DBM:RegisterAltSpellName(1257717, DBM_COMMON_L.ADDS)--Alluring Bubble --> Adds
local specWarnWaterJet					= mod:NewSpecialWarningCount(1268562, nil, nil, nil, 2, 2, nil, nil, "lineyou")

local timerWaterJetCD					= mod:NewCDCountTimer(20.5, 1268562, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Mythic version
--local timerBerserkCD					= mod:NewBerserkTimer(600)--Unending Tides

--local badStateDetected = false--Used to track if hardcode features have failed and we need to fall back to blizz API

---@param self DBMMod
---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		if self:IsTank() then

		end
		specWarnWaterJet:SetAlert(367, "killmob", 2, 2)
	end
	local onlyColor = not DBM.Options.HideDBMBars
	timerWaterJetCD:SetTimeline(366, onlyColor)
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
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
