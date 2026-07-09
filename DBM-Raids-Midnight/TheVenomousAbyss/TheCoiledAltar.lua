if DBM:GetTOC() < 120100 then return end
local mod	= DBM:NewMod(2883, "DBM-Raids-Midnight", 1, 1320)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(238693)
mod:SetEncounterID(3429)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(3004)

mod:RegisterCombat("combat")

--TODO, see if fixation has a timer, it's not a core ability but a sub of another so probably not
--TODO, https://www.wowhead.com/ptr/spell=1287227/blighted-toxin has an encounter event ID of 669 and 681 but is not in journal
--TODO, Guillotine target. might be one ID for timeline event and another for actual primary target?
--TODO, https://www.wowhead.com/ptr/spell=1286308/shadowfang has an encounter event ID of 683 but is not in journal
--TODO confirm Gloombomb has a personal alert, if it doesn't it needs to be aoe one
--TODO, threat check to see WHICH tank is aiming frontal (Soul Severing) and give them a different audio from everyone else who is just dodging it
--TODO, refine audio for second step of Toxic Deluge?
--DBM:RegisterAltSpellName(1257717, DBM_COMMON_L.ADDS)--Alluring Bubble --> Adds
local warnPhase2						= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnPhase3						= mod:NewPhaseAnnounce(3, 2, nil, nil, nil, nil, nil, 2)

local specWarnUnnervingFixation			= mod:NewSpecialWarningYou(1285911, nil, nil, nil, 1, 19, nil, nil, "fixateyou")
local specWarnFangsoftheCrucible		= mod:NewSpecialWarningCount(1282487, nil, nil, nil, 2, 2, nil, nil, "specialsoon")
local specWarnGuilotine					= mod:NewSpecialWarningCount(1283485, nil, nil, nil, 2, 2, nil, nil, "helpsoak")
local specWarnVenomfang					= mod:NewSpecialWarningCount(1282281, "RemovePoison", nil, nil, 2, 2, nil, nil, "helpdispel")
local specWarnAxegrinder				= mod:NewSpecialWarningDodgeCount(1283832, nil, nil, nil, 2, 2, nil, nil, "watchstep")
local specWarnEternalNightfall			= mod:NewSpecialWarningCount(1286918, nil, nil, nil, 3, 2, nil, nil, "attackshield")
local specWarnGloombomb					= mod:NewSpecialWarningYou(1286895, nil, nil, nil, 1, 2, nil, nil, "bombyou")
local specWarnDeathmarch				= mod:NewSpecialWarningCount(1289900, nil, nil, nil, 2, 2, nil, nil, "findmc")
local specWarnSoulSevering				= mod:NewSpecialWarningCount(1286573, nil, nil, nil, 2, 15, nil, nil, "frontal")--Stage 2 tank sever
local specWarnSpiritcackle				= mod:NewSpecialWarningSwitchCount(1286441, nil, nil, nil, 1, 2, nil, nil, "killmob")
local specWarnDefilementoftheCrucible	= mod:NewSpecialWarningCount(1298381, nil, nil, nil, 2, 2, nil, nil, "specialsoon")--Stage 2 empowered version of Fang of the Crucible, same spellid but different encounter event ID
local specWarnGrimGuillotine			= mod:NewSpecialWarningCount(1299266, nil, nil, nil, 2, 2, nil, nil, "helpsoak")--Stage 2 empowered version of Guillotine, same spellid but different encounter event ID
local specWarnSever						= mod:NewSpecialWarningCount(1299680, nil, nil, nil, 2, 15, nil, nil, "frontal")--Stage 1 tank sever
local specWarnToxicDeluge				= mod:NewSpecialWarningCount(1299960, nil, nil, nil, 2, 2, nil, nil, "watchstep")
local specWarnBlightedSevering			= mod:NewSpecialWarningCount(1287227, nil, nil, nil, 2, 15, nil, nil, "frontal")--Stage 3 tank sever

local timerFangsoftheCrucibleCD			= mod:NewCDCountTimer(20.5, 1282487, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerGuilotineCD					= mod:NewCDCountTimer(20.5, 1283485, nil, nil, nil, 3)
local timerVenomfangCD					= mod:NewCDCountTimer(20.5, 1282281, nil, nil, nil, 3, nil, DBM_COMMON_L.POISON_ICON)
local timerAxegrinderCD					= mod:NewCDCountTimer(20.5, 1283832, nil, nil, nil, 3)
local timerEternalNightfallCD			= mod:NewCDCountTimer(20.5, 1286918, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON..DBM_COMMON_L.DEADLY_ICON)
local timerGloombombCD					= mod:NewCDCountTimer(20.5, 1286895, nil, nil, nil, 3)
local timerDeathmarchCD					= mod:NewCDCountTimer(20.5, 1289900, nil, nil, nil, 3)
local timerSoulSeveringCD				= mod:NewCDCountTimer(20.5, 1286573, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK)
local timerSpiritcackleCD				= mod:NewCDCountTimer(20.5, 1286441, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerDefilementoftheCrucibleCD	= mod:NewCDCountTimer(20.5, 1298381, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerGrimGuillotineCD				= mod:NewCDCountTimer(20.5, 1299266, nil, nil, nil, 3)
local timerSeverCD						= mod:NewCDCountTimer(20.5, 1299680, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerToxicDelugeCD				= mod:NewCDCountTimer(20.5, 1299960, nil, nil, nil, 3)
local timerBlightedSeveringCD			= mod:NewCDCountTimer(20.5, 1287227, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local timerBerserkCD					= mod:NewBerserkTimer(600)--Unending Tides

local badStateDetected = false--Used to track if hardcode features have failed and we need to fall back to blizz API
local stage1FortyThreeCount = 0
local stage2ThirtyFourCount = 0
local stage3FiftyNineCount = 0
local stage2YellFirstTime = 0
local stage2YellPairTime = 0
local lastYellTime = 0
local lastTLEvent = 0
local stage1CancelBurstCount = 0
local stage1CancelBurstStart = 0

mod.vb.CrucibleCount = 0--Used for fangs AND defilement. Reset on stage 2 start
mod.vb.GuilotineCount = 0--Used for guillotine AND grim guillotine. Reset on stage 2 start
mod.vb.VenomfangCount = 0
mod.vb.AxegrinderCount = 0
mod.vb.EternalNightfallCount = 0
mod.vb.GloombombCount = 0
mod.vb.DeathmarchCount = 0
mod.vb.SeverCount = 0--Used for all 3 versions of tank sever. Reset on stage 2 and stage 3 start
mod.vb.SpiritcackleCount = 0
mod.vb.ToxicDelugeCount = 0

---@param self DBMMod
---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		if self:IsTank() then

		end
		if self:CheckDispelFilter("poison") then
			specWarnVenomfang:SetAlert(679, "helpdispel", 2, 2)
		end
		specWarnUnnervingFixation:SetAlert(667, "fixateyou", 19, 2, 0)
		specWarnFangsoftheCrucible:SetAlert(677, "specialsoon", 2, 2)
		specWarnGuilotine:SetAlert(678, "helpsoak", 2, 2)
		specWarnAxegrinder:SetAlert(680, "watchstep", 2, 2)
		specWarnEternalNightfall:SetAlert(682, "attackshield", 2, 2)
		specWarnGloombomb:SetAlert(684, "bombyou", 2, 2, 0)
		specWarnDeathmarch:SetAlert(685, "findmc", 2, 2)
		specWarnSoulSevering:SetAlert(686, "frontal", 15, 2)
		specWarnSpiritcackle:SetAlert(687, "killmob", 2, 2)
		specWarnDefilementoftheCrucible:SetAlert(794, "specialsoon", 2, 2)
		specWarnGrimGuillotine:SetAlert(803, "helpsoak", 2, 2)
		specWarnSever:SetAlert(811, "frontal", 15, 2)
		specWarnToxicDeluge:SetAlert(812, "watchstep", 2, 2)
		specWarnBlightedSevering:SetAlert(898, "frontal", 15, 2)
	end
	--If user has DBM bars enabled, we only want to register colors to the blizz api so that the blizz bars are also colorized.
	--If user has bars disabled, or we are in a bad state, onlyColor is false and we register countdowns as well.
	local onlyColor = not DBM.Options.HideDBMBars and not badStateDetected
	timerFangsoftheCrucibleCD:SetTimeline(677, onlyColor)
	timerGuilotineCD:SetTimeline(678, onlyColor)
	timerVenomfangCD:SetTimeline(679, onlyColor)
	timerAxegrinderCD:SetTimeline(680, onlyColor)
	timerEternalNightfallCD:SetTimeline(682, onlyColor)
	timerGloombombCD:SetTimeline(684, onlyColor)
	timerDeathmarchCD:SetTimeline(685, onlyColor)
	timerSoulSeveringCD:SetTimeline(686, onlyColor)
	timerSpiritcackleCD:SetTimeline(687, onlyColor)
	timerDefilementoftheCrucibleCD:SetTimeline(794, onlyColor)
	timerGrimGuillotineCD:SetTimeline(803, onlyColor)
	timerSeverCD:SetTimeline(811, onlyColor)
	timerToxicDelugeCD:SetTimeline(812, onlyColor)
	timerBlightedSeveringCD:SetTimeline(898, onlyColor)
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
	self:SetStage(1)
	stage1FortyThreeCount = 0
	stage2ThirtyFourCount = 0
	stage3FiftyNineCount = 0
	stage2YellFirstTime = 0
	stage2YellPairTime = 0
	lastYellTime = 0
	lastTLEvent = GetTime()
	stage1CancelBurstCount = 0
	stage1CancelBurstStart = 0
	self.vb.CrucibleCount = 1
	self.vb.GuilotineCount = 1
	self.vb.VenomfangCount = 1
	self.vb.AxegrinderCount = 1
	self.vb.EternalNightfallCount = 1
	self.vb.GloombombCount = 1
	self.vb.DeathmarchCount = 1
	self.vb.SeverCount = 1
	self.vb.SpiritcackleCount = 1
	self.vb.ToxicDelugeCount = 1
	--Hardcode features first
	if DBM.Options.HardcodedTimer and self:IsHeroic() and not badStateDetected then
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED",
			"CHAT_MSG_MONSTER_YELL"
		)
		setFallback(self, true)
	else
		setFallback(self)
	end
end


function mod:OnCombatEnd()
	self:TLCountReset()
	stage1FortyThreeCount = 0
	stage2ThirtyFourCount = 0
	stage3FiftyNineCount = 0
	stage2YellFirstTime = 0
	stage2YellPairTime = 0
	lastYellTime = 0
	lastTLEvent = 0
	stage1CancelBurstCount = 0
	stage1CancelBurstStart = 0
	self:UnregisterShortTermEvents()
end

do
	---@param self DBMMod
	local function enterStage2(self)
		if self:GetStage() ~= 2 then
			self:SetStage(2)
			warnPhase2:Show()
			warnPhase2:Play("ptwo")
		end
		self.vb.CrucibleCount = 1
		self.vb.GuilotineCount = 1
		self.vb.SeverCount = 1
		self.vb.SpiritcackleCount = 1
		self.vb.GloombombCount = 1
		self.vb.DeathmarchCount = 1
		self.vb.EternalNightfallCount = 1
		stage2ThirtyFourCount = 0
		stage2YellFirstTime = 0
		stage2YellPairTime = 0
		lastYellTime = 0
		stage1CancelBurstCount = 0
		stage1CancelBurstStart = 0
	end

	---@param self DBMMod
	local function enterStage3(self)
		if self:GetStage() ~= 3 then
			self:SetStage(3)
			warnPhase3:Show()
			warnPhase3:Play("pthree")
		end
		self.vb.CrucibleCount = 1
		self.vb.GuilotineCount = 1
		self.vb.SeverCount = 1
		self.vb.GloombombCount = 1
		self.vb.DeathmarchCount = 1
		self.vb.EternalNightfallCount = 1
		self.vb.ToxicDelugeCount = 1
		stage3FiftyNineCount = 0
	end

	---@param timer number
	---@return boolean
	local function isStage2BucketTimer(timer)
		return timer == 6 or timer == 13 or timer == 22 or timer == 31 or timer == 33 or timer == 34 or timer == 38 or timer == 70
	end

	---@param timer number
	---@return boolean
	local function isStage3UniqueTimer(timer)
		return timer == 15 or timer == 29 or timer == 42 or timer == 51 or timer == 59 or timer == 66 or timer == 88 or timer == 94
	end

	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersHeroic(self, timer, timerExact, eventID)
		local handled
		local stage = self:GetStage()

		if stage == 1 then
			--Stage 1
			if isStage2BucketTimer(timer) then
				enterStage2(self)
				return timersHeroic(self, timer, timerExact, eventID)
			elseif timer == 2 then--Toxic Deluge
				handled = true
				timerToxicDelugeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "toxicDeluge", "ToxicDelugeCount"))
			elseif timer == 12 then--Axegrinder
				handled = true
				timerAxegrinderCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "axegrinder", "AxegrinderCount"))
			elseif timer == 17 or timer == 20 then--Sever
				handled = true
				timerSeverCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sever", "SeverCount"))
			elseif timer == 28 or timer == 35 then--Venomfang
				handled = true
				timerVenomfangCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "venomfang", "VenomfangCount"))
			elseif timer == 80 then--Fangs of the Crucible
				handled = true
				timerFangsoftheCrucibleCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "crucible", "CrucibleCount"))
			elseif timer == 43 then--Ambiguous: Guillotine OR Toxic Deluge
				handled = true
				stage1FortyThreeCount = stage1FortyThreeCount + 1
				if stage1FortyThreeCount % 2 == 1 then
					timerGuilotineCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "guilotine", "GuilotineCount"))
				else
					timerToxicDelugeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "toxicDeluge", "ToxicDelugeCount"))
				end
			end
		elseif stage == 2 then
			--Primary stage 3 transition: two yells then long gap before new timer bucket.
			if stage2YellPairTime > 0 and lastYellTime > 0 and (GetTime() - stage2YellPairTime) > 20 and (GetTime() - lastTLEvent) > 25 then
				enterStage3(self)
				return timersHeroic(self, timer, timerExact, eventID)
			end
			--Fallback stage 3 transition: unique stage 3 timer after long silence.
			if isStage3UniqueTimer(timer) and (GetTime() - lastTLEvent) > 20 then
				enterStage3(self)
				return timersHeroic(self, timer, timerExact, eventID)
			end
			if timer == 13 or timer == 33 then--Spiritcackle
				handled = true
				timerSpiritcackleCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "spiritcackle", "SpiritcackleCount"))
			elseif timer == 70 then--Eternal Nightfall
				handled = true
				timerEternalNightfallCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "eternalNightfall", "EternalNightfallCount"))
			elseif timer == 6 then--Dreadmarch
				handled = true
				timerDeathmarchCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "deathmarch", "DeathmarchCount"))
			elseif timer == 22 or timer == 38 then--Gloombomb
				handled = true
				timerGloombombCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloombomb", "GloombombCount"))
			elseif timer == 31 then--Soul Severing
				handled = true
				timerSoulSeveringCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "soulsevering", "SeverCount"))
			elseif timer == 34 then--Ambiguous: Soul Severing OR Dreadmarch
				handled = true
				stage2ThirtyFourCount = stage2ThirtyFourCount + 1
				if stage2ThirtyFourCount % 2 == 1 then
					timerSoulSeveringCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "soulsevering", "SeverCount"))
				else
					timerDeathmarchCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "deathmarch", "DeathmarchCount"))
				end
			end
		elseif stage == 3 then
			--Stage 3 (limited data; route confirmed timers and fail over on unknown)
			if timer == 2 or timer == 42 or timer == 51 then--Toxic Deluge
				handled = true
				timerToxicDelugeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "toxicDeluge", "ToxicDelugeCount"))
			elseif timer == 15 then--Grim Guillotine
				handled = true
				timerGrimGuillotineCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grimGuillotine", "GuilotineCount"))
			elseif timer == 22 then--Gloombomb
				handled = true
				timerGloombombCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloombomb", "GloombombCount"))
			elseif timer == 29 then--Blighted Severing
				handled = true
				timerBlightedSeveringCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "blightedSevering", "SeverCount"))
			elseif timer == 35 or timer == 88 then--Eternal Nightfall
				handled = true
				timerEternalNightfallCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "eternalNightfall", "EternalNightfallCount"))
			elseif timer == 66 then--Dreadmarch
				handled = true
				timerDeathmarchCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "deathmarch", "DeathmarchCount"))
			elseif timer == 94 then--Defilement of the Crucible
				handled = true
				timerDefilementoftheCrucibleCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "defilement", "CrucibleCount"))
			elseif timer == 59 then--Ambiguous: Grim Guillotine OR Gloombomb
				handled = true
				stage3FiftyNineCount = stage3FiftyNineCount + 1
				if stage3FiftyNineCount % 2 == 1 then
					timerGrimGuillotineCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grimGuillotine", "GuilotineCount"))
				else
					timerGloombombCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "gloombomb", "GloombombCount"))
				end
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

	function mod:CHAT_MSG_MONSTER_YELL()
		if self:GetStage() ~= 2 then return end
		if not self:AntiSpam(0.5, 1) then return end
		local now = GetTime()
		if stage2YellFirstTime == 0 then
			stage2YellFirstTime = now
			return
		end
		local delta = now - stage2YellFirstTime
		if delta >= 4 and delta <= 8.5 then
			stage2YellPairTime = now
			lastYellTime = now
			stage2YellFirstTime = 0
		else
			--Not a valid phase-transition yell pair (often incidental yells, e.g. deaths); restart candidate chain.
			stage2YellFirstTime = now
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
		if eventInfo.source ~= 0 then return end
		if not self:IsHeroic() then return end
		local eventID = eventInfo.id
		local timerExact = eventInfo.duration
		local timer = math.floor(timerExact + 0.5)
		if not badStateDetected then
			timersHeroic(self, timer, timerExact, eventID)
		end
		lastTLEvent = GetTime()
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		if not self:IsHeroic() then return end
		lastTLEvent = GetTime()
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		if eventState == 2 then
			local eventType, eventCount = self:TLCountFinish(eventID)
			if not eventType then return end
			if not eventCount then return end
			if eventType == "crucible" then
				specWarnFangsoftheCrucible:Show(eventCount)
				specWarnFangsoftheCrucible:Play("specialsoon")
			elseif eventType == "guilotine" then
				specWarnGuilotine:Show(eventCount)
				specWarnGuilotine:Play("helpsoak")
			elseif eventType == "venomfang" then
				specWarnVenomfang:Show(eventCount)
				specWarnVenomfang:Play("helpdispel")
			elseif eventType == "axegrinder" then
				specWarnAxegrinder:Show(eventCount)
				specWarnAxegrinder:Play("watchstep")
			elseif eventType == "eternalNightfall" then
				specWarnEternalNightfall:Show(eventCount)
				specWarnEternalNightfall:Play("attackshield")
			elseif eventType == "gloombomb" then
				specWarnGloombomb:Show()
				specWarnGloombomb:Play("bombyou")
			elseif eventType == "deathmarch" then
				specWarnDeathmarch:Show(eventCount)
				specWarnDeathmarch:Play("findmc")
			elseif eventType == "soulsevering" then
				specWarnSoulSevering:Show(eventCount)
				specWarnSoulSevering:Play("frontal")
			elseif eventType == "spiritcackle" then
				specWarnSpiritcackle:Show(eventCount)
				specWarnSpiritcackle:Play("killmob")
			elseif eventType == "defilement" then
				specWarnDefilementoftheCrucible:Show(eventCount)
				specWarnDefilementoftheCrucible:Play("specialsoon")
			elseif eventType == "grimGuillotine" then
				specWarnGrimGuillotine:Show(eventCount)
				specWarnGrimGuillotine:Play("helpsoak")
			elseif eventType == "sever" then
				specWarnSever:Show(eventCount)
				specWarnSever:Play("frontal")
			elseif eventType == "toxicDeluge" then
				specWarnToxicDeluge:Show(eventCount)
				specWarnToxicDeluge:Play("watchstep")
			elseif eventType == "blightedSevering" then
				specWarnBlightedSevering:Show(eventCount)
				specWarnBlightedSevering:Play("frontal")
			end
		elseif eventState == 3 then
			local eventType = self:TLCountCancel(eventID)
			if not eventType then return end
			if self:GetStage() == 1 and (eventType == "crucible" or eventType == "guilotine" or eventType == "venomfang" or eventType == "axegrinder" or eventType == "sever" or eventType == "toxicDeluge") then
				if stage1CancelBurstStart == 0 or (GetTime() - stage1CancelBurstStart) > 1.5 then
					stage1CancelBurstStart = GetTime()
					stage1CancelBurstCount = 1
				else
					stage1CancelBurstCount = stage1CancelBurstCount + 1
				end
				if stage1CancelBurstCount >= 6 then
					enterStage2(self)
				end
			end
		end
	end
end
