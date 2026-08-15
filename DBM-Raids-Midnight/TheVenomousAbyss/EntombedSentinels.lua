local mod	= DBM:NewMod(2874, "DBM-Raids-Midnight", 1, 1320)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(238693)
mod:SetEncounterID(3445)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(3004)

mod:RegisterCombat("combat")

--TODO, tank threat based checks to antispam tank alerts
--TODO, personal alerts for blighted Blood? or just generic warning fine?
--TODO, https://www.wowhead.com/ptr/spell=1284485/debilitating-miasma isn't in journal but https://www.wowhead.com/ptr/spell=1288232/unstable-miasma is. I suspect only one of them exists (ID 642)
--TODO, find encounter event Ids for warnings that will likely hook up to mythic venom types. they're probably assigned to Dungeon Ecounter 0
DBM:RegisterAltSpellName(1284483, DBM_COMMON_L.DISPELS)--Blighted Blood --> Dispels
local warnVitriolicStasis				= mod:NewCountAnnounce(1284588, 2)--Hardcode only
local warnUnstableMiasma				= mod:NewCountAnnounce(1288232, 2)--Hardcode only

local specWarnVenomCoagulation			= mod:NewSpecialWarningCount(1284251, nil, nil, nil, 2, 2, nil, nil, "bigmob")
local specWarnToxicDroplets				= mod:NewSpecialWarningCount(1284434, nil, nil, nil, 2, 2, nil, nil, "helpsoak")
local specWarnEmpoweringSlam			= mod:NewSpecialWarningCount(1284458, nil, nil, nil, 1, 2, nil, nil, "defensive")
local specWarnBloodvenomInjection		= mod:NewSpecialWarningCount(1284487, nil, nil, nil, 1, 2, nil, nil, "defensive")
--local specWarnBlightedBlood				= mod:NewSpecialWarningCount(1284483, "Healer", nil, nil, 2, 2, nil, nil, "helpdispel")--Verify we want to dispel right away first
--local specWarnDebilitatingMiasma		= mod:NewSpecialWarningCount(1284485, nil, nil, nil, 2, 2, nil, nil, "keepmove")--Possibly unused
--local specWarnUnstableMiasma			= mod:NewSpecialWarningSoakCount(1288232, nil, nil, nil, 2, 2, nil, nil, "gathershare")--Aura used instead
local specWarnShiftingProtovenom		= mod:NewSpecialWarningCount(1296878, nil, nil, nil, 3, 19, 4, nil, "colorchange")

local timerVenomCoagulationCD			= mod:NewCDCountTimer(20.5, 1284251, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerToxicDropletsCD				= mod:NewCDCountTimer(20.5, 1284434, nil, nil, nil, 5)
local timerEmpoweringSlamCD				= mod:NewCDCountTimer(20.5, 1284458, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerBloodvenomInjectionCD		= mod:NewCDCountTimer(20.5, 1284487, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerBlightedBloodCD				= mod:NewCDCountTimer(20.5, 1284483, nil, "Healer", nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
--local timerDebilitatingMiasmaCD			= mod:NewCDCountTimer(20.5, 1284485, nil, nil, nil, 3)--Possibly unused
local timerVitriolicStasisCD			= mod:NewCDCountTimer(20.5, 1284588, nil, nil, nil, 6)
local timerUnstableMiasmaCD				= mod:NewCDCountTimer(20.5, 1288232, nil, nil, nil, 3)
local timerShiftingProtovenomCD			= mod:NewCDCountTimer(20.5, 1296878, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerBerserkCD					= mod:NewBerserkTimer(600)

--Evidence Log https://www.warcraftlogs.com/reports/xdTc1fhtKWPrbCVv?fight=29&type=auras&spells=debuffs
mod:AddAuraSoundOption(1284590, true, 1284588, 1, 1, "toxic", 2, 0)--Helical Toxins (better audio?)
mod:AddAuraSoundOption(1284471, true, 1284483, 1, 1, "poolyou", 18, 0)--Blighted Blood
mod:AddAuraSoundOption(1284210, true, 1284210, 1, 2, "watchfeet", 8, 0)--Blood Venom (1284208 is target ID but not logged so probbably no aura either)
mod:AddAuraSoundOption(1288260, true, 1288232, 1, 1, "gathershare", 2, 0)--Unstable Miasma
mod:AddAuraSoundOption(1288297, true, 1288232, 1, 3, "poolyou", 18, 0)--Clinging Mark (stacks from soaking unstalbe Miasma)
mod:AddAuraSoundOption(1284491, true, 1284491, 1, 1, "poolyou", 18, 1)--Bloodvenom Injection (stacks only, cause you swap at 2+ stacks)
--Debuffs that do not appear in combat log but MIGHT still work with aura sounds?
mod:AddAuraSoundOption(1296880, true, 1296878, 1, 1, "movetopartner", 20, 0)--Shifting Protovenom

local badStateDetected = false--Used to track if hardcode features have failed and we need to fall back to blizz API
local firstBerserkIgnored = false
local next22Event = "empoweringslam"
local mythic20EventCycleIndex = 1
local batchTimerValues = {
	[4] = true,
	[6] = true,
	[8] = true,
	[12] = true,
	[16] = true,
	[40] = true,
}

mod.vb.VenomCoagulationCount = 0
mod.vb.ToxicDropletsCount = 0
mod.vb.EmpoweringSlamCount = 0
mod.vb.BloodvenomInjectionCount = 0
mod.vb.BlightedBloodCount = 0
mod.vb.DebilitatingMiasmaCount = 0
mod.vb.VitriolicStasisCount = 0
mod.vb.UnstableMiasmaCount = 0
mod.vb.ShiftingProtovenomCount = 0

---@param self DBMMod
---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		if self:IsTank() then
			specWarnEmpoweringSlam:SetAlert(639, "defensive", 2, 2)
			specWarnBloodvenomInjection:SetAlert(640, "defensive", 2, 2)
		end
		--if self:IsHealer() then
		--	specWarnBlightedBlood:SetAlert(641, "helpdispel", 2, 2)
		--end
		specWarnVenomCoagulation:SetAlert(637, "bigmob", 2, 2)
		specWarnToxicDroplets:SetAlert(638, "helpsoak", 2, 2)
		specWarnShiftingProtovenom:SetAlert(788, "colorchange", 19, 3)
	end
	--If user has DBM bars enabled, we only want to register colors to the blizz api so that the blizz bars are also colorized.
	--If user has bars disabled, or we are in a bad state, onlyColor is false and we register countdowns as well.
	local onlyColor = not DBM.Options.HideDBMBars and not badStateDetected
	timerVenomCoagulationCD:SetTimeline(637, onlyColor)
	timerToxicDropletsCD:SetTimeline(638, onlyColor)
	timerEmpoweringSlamCD:SetTimeline(639, onlyColor)
	timerBloodvenomInjectionCD:SetTimeline(640, onlyColor)
	timerBlightedBloodCD:SetTimeline(641, onlyColor)
	timerVitriolicStasisCD:SetTimeline(643, onlyColor)
	timerUnstableMiasmaCD:SetTimeline(673, onlyColor)
	timerBerserkCD:SetTimeline(668, onlyColor)
	timerShiftingProtovenomCD:SetTimeline(788, onlyColor)
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
	self:TLBatchReset()
	firstBerserkIgnored = false
	next22Event = "empoweringslam"
	mythic20EventCycleIndex = 1
	self.vb.VenomCoagulationCount = 1
	self.vb.ToxicDropletsCount = 1
	self.vb.EmpoweringSlamCount = 1
	self.vb.BloodvenomInjectionCount = 1
	self.vb.BlightedBloodCount = 1
	self.vb.DebilitatingMiasmaCount = 1
	self.vb.VitriolicStasisCount = 1
	self.vb.UnstableMiasmaCount = 1
	self.vb.ShiftingProtovenomCount = 1
	--Hardcode features first
	if DBM.Options.HardcodedTimer and (self:IsHeroic() or self:IsMythic()) and not badStateDetected then
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		)
		setFallback(self, true)
	else
		setFallback(self)
	end
end


function mod:OnCombatEnd()
	self:TLCountReset()
	self:TLBatchReset()
	firstBerserkIgnored = false
	next22Event = "empoweringslam"
	mythic20EventCycleIndex = 1
	self:UnregisterShortTermEvents()
end

do
	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersHeroic(self, timer, timerExact, eventID)
		local handled = false
		if timer == 540 then
			handled = true
			if firstBerserkIgnored then
				timerBerserkCD:Start(timerExact)
			else
				firstBerserkIgnored = true
			end
		elseif timer == 4 then
			handled = true
			self:TLBatchTrackLatest(timer, eventID, batchTimerValues)
			timerEmpoweringSlamCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "empoweringslam", "EmpoweringSlamCount"))
		elseif timer == 6 then
			handled = true
			self:TLBatchTrackLatest(timer, eventID, batchTimerValues)
			timerBloodvenomInjectionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "bloodvenominjection", "BloodvenomInjectionCount"))
		elseif timer == 8 then
			handled = true
			self:TLBatchTrackLatest(timer, eventID, batchTimerValues)
			timerVenomCoagulationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "venomcoagulation", "VenomCoagulationCount"))
		elseif timer == 12 then
			handled = true
			self:TLBatchTrackLatest(timer, eventID, batchTimerValues)
			timerToxicDropletsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "toxicdroplets", "ToxicDropletsCount"))
		elseif timer == 16 then
			handled = true
			self:TLBatchTrackLatest(timer, eventID, batchTimerValues)
			timerUnstableMiasmaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "unstablemiasma", "UnstableMiasmaCount"))
		elseif timer == 20 then
			handled = true
			if self:IsMythic() then
				-- Mythic 20s cadence is repeating S, V, S (Shifting, Vitriolic, Shifting)
				if mythic20EventCycleIndex == 2 then
					timerVitriolicStasisCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vitriolicstasis", "VitriolicStasisCount"))
				else
					timerShiftingProtovenomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "shiftingprotovenom", "ShiftingProtovenomCount"))
				end
				mythic20EventCycleIndex = mythic20EventCycleIndex + 1
				if mythic20EventCycleIndex > 3 then
					mythic20EventCycleIndex = 1
				end
			else
				timerVitriolicStasisCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vitriolicstasis", "VitriolicStasisCount"))
			end
		elseif timer == 22 then
			handled = true
			if next22Event == "empoweringslam" then
				next22Event = "bloodvenominjection"
				timerEmpoweringSlamCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "empoweringslam", "EmpoweringSlamCount"))
			else
				next22Event = "empoweringslam"
				timerBloodvenomInjectionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "bloodvenominjection", "BloodvenomInjectionCount"))
			end
		elseif timer == 32 then
			handled = true
			timerToxicDropletsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "toxicdroplets", "ToxicDropletsCount"))
		elseif timer == 40 then
			handled = true
			self:TLBatchTrackLatest(timer, eventID, batchTimerValues)
			timerBlightedBloodCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "blightedblood", "BlightedBloodCount"))
		elseif timer == 41 then
			handled = true
			timerUnstableMiasmaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "unstablemiasma", "UnstableMiasmaCount"))
		elseif timer == 51 then
			--Known issue: Unstable Miasma with rounded value 51 always cancels.
			handled = true
		elseif timer == 52 then
			handled = true
			if timerExact == 51.5 then
				timerVenomCoagulationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "venomcoagulation", "VenomCoagulationCount"))
			else
				--Known issue: Blighted Blood with rounded value 52 always cancels.
			end
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
		if not (self:IsHeroic() or self:IsMythic()) then return end
		local eventID = eventInfo.id
		local timerExact = eventInfo.duration
		local timer = math.floor(timerExact + 0.5)
		if not badStateDetected then
			timersHeroic(self, timer, timerExact, eventID)
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		self:TLBatchUntrack(eventID)
		if eventState == 2 then
			local eventType, eventCount = self:TLCountFinish(eventID)
			if not eventType or not eventCount then return end
			if eventType == "venomcoagulation" then
				specWarnVenomCoagulation:Show(eventCount)
				specWarnVenomCoagulation:Play("bigmob")
			elseif eventType == "toxicdroplets" then
				specWarnToxicDroplets:Show(eventCount)
				specWarnToxicDroplets:Play("helpsoak")
			elseif eventType == "empoweringslam" then
				specWarnEmpoweringSlam:Show(eventCount)
				specWarnEmpoweringSlam:Play("defensive")
			elseif eventType == "bloodvenominjection" then
				specWarnBloodvenomInjection:Show(eventCount)
				specWarnBloodvenomInjection:Play("defensive")
			elseif eventType == "blightedblood" then
			--	specWarnBlightedBlood:Show(eventCount)
			--	specWarnBlightedBlood:Play("helpdispel")
			elseif eventType == "unstablemiasma" then
				warnUnstableMiasma:Show(eventCount)
			elseif eventType == "shiftingprotovenom" then
				specWarnShiftingProtovenom:Show(eventCount)
				specWarnShiftingProtovenom:Play("colorchange")
			elseif eventType == "vitriolicstasis" then
				warnVitriolicStasis:Show(eventCount)
			end
		elseif eventState == 3 then
			self:TLCountCancel(eventID)
		end
	end
end
