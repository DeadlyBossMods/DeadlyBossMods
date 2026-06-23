if DBM:GetTOC() < 120100 then return end
local mod	= DBM:NewMod(2888, "DBM-Raids-Midnight", 1, 1320)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(238693)
mod:SetEncounterID(3470)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(3004)

mod:RegisterCombat("combat")

--TODO, peresonal essence Rend alert if it has ENCOUNTER_WARNING, else auras api if there is one by 12.1 launch.
--TODO, Entwined step might be redundant, Invoke is parent ability and has own script/ID, mod has both for now since need to see which blizz links to timer
--TODO, https://www.wowhead.com/ptr/spell=1289923/call-of-devotion has an ID of 694 but doesn't exist in journal
--TODO, https://www.wowhead.com/ptr/spell=1290679/vengeful-hiss has an ID of 696 but doesn't exist in journal
--TODO, split posession barriage to a threat based run out warning for one tank and taunt warning for other
--TODO, verify https://www.wowhead.com/ptr/spell=1290003/uncoiling is triggered by ID 712 as ENCOUNTER_WARNING (script uses 1290001 but it has no tooltip)
--TODO, verify if intermission abilities neeed counts or not (some might some might not)
--DBM:RegisterAltSpellName(1257717, DBM_COMMON_L.ADDS)--Alluring Bubble --> Adds
local warnPhase2						= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)

local specWarnEssenceRend				= mod:NewSpecialWarningCount(1287426, nil, nil, nil, 1, 2, nil, nil, "lineyou")
local specWarnSoulcoilIgnition			= mod:NewSpecialWarningCount(1285681, nil, nil, nil, 2, 2, nil, nil, "aesoon")
local specWarnEntwinedStep				= mod:NewSpecialWarningCount(1293497, nil, nil, nil, 2, 2, nil, nil, "watchstep")
local specWarnCallofDevotion			= mod:NewSpecialWarningCount(1289923, nil, nil, nil, 2, 2, nil, nil, "helpsoak")--Possibly unused
local specWarnRestlessAmani				= mod:NewSpecialWarningCount(1297630, nil, nil, nil, 2, 2, nil, nil, "killmob")--Script uses 1295397 but it has no tooltip, so we use 1297630 on purpose
local specWarnPossessionBarrage			= mod:NewSpecialWarningRunCount(1284103, nil, nil, nil, 4, 2, nil, nil, "justrun")--Script uses 1292036 but it has no tooltip, so we use 1284103 on purpose
--local specWarnPossessionBarrageTaunt	= mod:NewSpecialWarningTaunt(1284103, nil, nil, nil, 1, 2, nil, nil, "tauntboss")
local specWarnGraspingDepths			= mod:NewSpecialWarningCount(1293212, nil, nil, nil, 2, 12, nil, nil, "pullin")
local specWarnInvoke					= mod:NewSpecialWarningCount(1299673, nil, nil, nil, 2, 2, nil, nil, "specialsoon")
local specWarnHungeringPyre				= mod:NewSpecialWarningCount(1290679, nil, nil, nil, 2, 2, nil, nil, "helpsoak")--Script uses 1305421 but it has no tooltip, so we use 1289855 on purpose
local specWarnResidualToll				= mod:NewSpecialWarningCount(1298698, nil, nil, nil, 2, 2, nil, nil, "aesoon")--Script uses 1305993, but it has no tooltip, so we use 1298698 on purpose

local timerEssenceRendCD				= mod:NewCDCountTimer(20.5, 1287426, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerSoulcoilIgnitionCD			= mod:NewCDCountTimer(20.5, 1285681, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerEntwinedStepCD				= mod:NewCDCountTimer(20.5, 1293497, nil, nil, nil, 3)
local timerCallofDevotionCD				= mod:NewCDCountTimer(20.5, 1289923, nil, nil, nil, 5)--Possibly unused
local timerRestlessAmaniCD				= mod:NewCDCountTimer(20.5, 1297630, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerPossessionBarrageCD			= mod:NewCDCountTimer(20.5, 1284103, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerGraspingDepthsCD				= mod:NewCDCountTimer(20.5, 1293212, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerInvokeCD						= mod:NewCDCountTimer(20.5, 1299673, nil, nil, nil, 6)
local timerHungeringPyreCD				= mod:NewCDCountTimer(20.5, 1290679, nil, nil, nil, 5)
local timerResidualTollCD				= mod:NewCDCountTimer(20.5, 1298698, nil, nil, nil, 2)
--local timerBerserkCD					= mod:NewBerserkTimer(600)--Unending Tides

--local badStateDetected = false--Used to track if hardcode features have failed and we need to fall back to blizz API
mod.vb.RendCount = 0
mod.vb.IgnitionCount = 0
mod.vb.EntwinedStepCount = 0
mod.vb.CallofDevotionCount = 0
mod.vb.RestlessAmaniCount = 0
mod.vb.PossessionBarrageCount = 0
mod.vb.GraspingDepthsCount = 0
mod.vb.InvokeCount = 0
mod.vb.HungeringPyreCount = 0
mod.vb.ResidualTollCount = 0

---@param self DBMMod
---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		if self:IsTank() then
			specWarnPossessionBarrage:SetAlert(710, "justrun", 2, 2)
		end
		specWarnEssenceRend:SetAlert(675, "runout", 2, 2, 0)
		specWarnSoulcoilIgnition:SetAlert(676, "aesoon", 2, 2)
		specWarnEntwinedStep:SetAlert(693, "watchstep", 2, 2)
		specWarnCallofDevotion:SetAlert(694, "helpsoak", 2, 2)
		specWarnRestlessAmani:SetAlert(695, "killmob", 2, 2)
		warnPhase2:SetAlert(712, "ptwo", 2, 2, 0)
		specWarnGraspingDepths:SetAlert(731, "pullin", 12, 2)
		specWarnInvoke:SetAlert(804, "specialsoon", 2, 2)
		specWarnHungeringPyre:SetAlert(865, "helpsoak", 2, 2)
		specWarnResidualToll:SetAlert(1298698, "aesoon", 2, 2)
	end
	local onlyColor = not DBM.Options.HideDBMBars
	timerEssenceRendCD:SetTimeline(675, onlyColor)
	timerSoulcoilIgnitionCD:SetTimeline(676, onlyColor)
	timerEntwinedStepCD:SetTimeline(693, onlyColor)
	timerCallofDevotionCD:SetTimeline(694, onlyColor)
	timerRestlessAmaniCD:SetTimeline(695, onlyColor)
	timerPossessionBarrageCD:SetTimeline(710, onlyColor)
	timerGraspingDepthsCD:SetTimeline(731, onlyColor)
	timerInvokeCD:SetTimeline(804, onlyColor)
	timerHungeringPyreCD:SetTimeline(865, onlyColor)
	timerResidualTollCD:SetTimeline(877, onlyColor)
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
	self.vb.RendCount = 1
	self.vb.IgnitionCount = 1
	self.vb.EntwinedStepCount = 1
	self.vb.CallofDevotionCount = 1
	self.vb.RestlessAmaniCount = 1
	self.vb.PossessionBarrageCount = 1
	self.vb.GraspingDepthsCount = 1
	self.vb.InvokeCount = 1
	self.vb.HungeringPyreCount = 1
	self.vb.ResidualTollCount = 1
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
			timerEssenceRendCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "essencerend", "RendCount"))
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
			if eventType == "essencerend" then
				--specWarnEssenceRend:Show(eventCount, "runout")
			end
		elseif eventState == 3 then
			self:TLCountCancel(eventID)
		end
	end
end
--]]
