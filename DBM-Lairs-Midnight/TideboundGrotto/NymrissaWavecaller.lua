if DBM:GetTOC() < 120100 then return end
local mod	= DBM:NewMod(2849, "DBM-Lairs-Midnight", 1, 1317)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(238693)
mod:SetEncounterID(3379)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2987)

mod:RegisterCombat("combat")

--654, 655, and 745 also belong to this fight even though assigned encounter 0
--371 connects to an ability that does not exist in data files anymore 1273013
--977 belongs to https://www.wowhead.com/ptr/spell=1294159/alluring-bubble
--976 belongs to https://www.wowhead.com/ptr/spell=1313393/chilling-frost
--372 is linked to https://www.wowhead.com/ptr/spell=1276710/call-of-the-bubble which may be actual summon event for murlocs and not Alluring bubble
--TODO, verify which alerts are actually personal and what aren't in world without private auras
--TODO, is rush an aoe or something you dodge or both?
DBM:RegisterAltSpellName(1257717, DBM_COMMON_L.ADDS)--Alluring Bubble --> Adds
local specWarnWaterJet					= mod:NewSpecialWarningBlizzYou(1268562, nil, nil, nil, 1, 17, 4, nil, "lineyou")--Mythic version
local specWarnWaterFlurry				= mod:NewSpecialWarningBlizzYou(1282937, nil, nil, nil, 1, 17, 4, nil, "lineyou")--Non Mythic version
local specWarnAlluringBubble			= mod:NewSpecialWarningCount(1257717, nil, nil, nil, 2, 2, nil, nil, "killmob")
local specWarnChillingFrost				= mod:NewSpecialWarningBlizzYou(1313393, nil, nil, nil, 1, 2, 3, nil, "orbrun")
local specWarnTidepiercersRush			= mod:NewSpecialWarningCount(1258668, nil, nil, nil, 2, 2, nil, nil, "watchstep")
local specWarnAbyssalRain				= mod:NewSpecialWarningCount(1260837, nil, nil, nil, 2, 2, nil, nil, "aesoon")

local timerWaterJetCD					= mod:NewCDCountTimer(20.5, 1268562, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Mythic version
local timerWaterFlurryCD				= mod:NewCDCountTimer(20.5, 1282937, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Non Mythic version
local timerAlluringBubbleCD				= mod:NewCDCountTimer(20.5, 1257717, nil, nil, nil, 1)
local timerChillingFrostCD				= mod:NewCDCountTimer(20.5, 1313393, nil, nil, nil, 3)
local timerTidepiercersRushCD			= mod:NewCDCountTimer(20.5, 1258668, nil, nil, nil, 3)
local timerAbyssalRainCD				= mod:NewCDCountTimer(20.5, 1260837, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerBerserkCD					= mod:NewBerserkTimer(600)--Unending Tides

--mod:AddAuraSoundOption(1221639, true, 1221622, 1, 1, "fixateyou", 19)--Mob fixates from awaken fungi (may stop being a private aura soon enough

mod.vb.tankWaterCount = 0--Water Jet/Flurry
mod.vb.alluringBubbleCount = 0
mod.vb.ChillingFrostCount = 0
mod.vb.tidepiercersRushCount = 0
mod.vb.abyssalRainCount = 0
local badStateDetected = false--Used to track if hardcode features have failed and we need to fall back to blizz API

---@param self DBMMod
---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		if self:IsTank() then
			specWarnWaterJet:SetAlert(366, "lineyou", 17, 3, 0)--TODO, verify it's actually personal
			specWarnWaterFlurry:SetAlert(654, "lineyou", 17, 3, 0)--TODO, verify it's actually personal
		end
		specWarnAlluringBubble:SetAlert(367, "killmob", 2, 2)
		specWarnChillingFrost:SetAlert(976, "orbrun", 2, 3, 0)--TODO, verify it's actually personal
		specWarnTidepiercersRush:SetAlert(369, "watchstep", 2, 2)
		specWarnAbyssalRain:SetAlert(370, "aesoon", 2, 2)
	end
	--If user has DBM bars enabled, we only want to register colors to the blizz api so that the blizz bars are also colorized.
	--If user has bars disabled, or we are in a bad state, onlyColor is false and we register countdowns as well.
	local onlyColor = not DBM.Options.HideDBMBars and not badStateDetected
	timerWaterJetCD:SetTimeline(366, onlyColor)
	timerAlluringBubbleCD:SetTimeline(367, onlyColor)
	timerChillingFrostCD:SetTimeline(976, onlyColor)
	timerTidepiercersRushCD:SetTimeline(369, onlyColor)
	timerAbyssalRainCD:SetTimeline(370, onlyColor)
	timerWaterFlurryCD:SetTimeline(654, onlyColor)
	timerBerserkCD:SetTimeline(745, onlyColor)--Berserk
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
	self.vb.tankWaterCount = 1
	self.vb.alluringBubbleCount = 1
	self.vb.ChillingFrostCount = 1
	self.vb.tidepiercersRushCount = 1
	self.vb.abyssalRainCount = 1
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
