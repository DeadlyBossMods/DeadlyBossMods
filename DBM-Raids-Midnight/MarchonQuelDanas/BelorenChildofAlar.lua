local mod	= DBM:NewMod(2739, "DBM-Raids-Midnight", 1, 1308)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID()--No Data Yet, has 4 CIDs
mod:SetEncounterID(3182)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2913)

mod:RegisterCombat("combat")

--NOTES: Light quill has encounter event if private aura gets removed. https://www.wowhead.com/spell=1241992/light-quill 384
--https://www.wowhead.com/spell=1242091/void-quill is 385
--Twilight Seal is a mechanic not in journal but has both private auras and encounter events 417 and 418
--Stage 1
local warnVoidlightConvergenceSoon		= mod:NewSoonAnnounce(1242515, 3)

local specWarnEmbersofBeloren			= mod:NewSpecialWarningCount(1241282, nil, nil, DBM_COMMON_L.ADDS, 1, 2)
local specWarnRadiantEchoes				= mod:NewSpecialWarningCount(1242981, nil, nil, DBM_COMMON_L.ORBS, 2, 2)
local specWarnGuardiansEdict			= mod:NewSpecialWarningCount(1260763, nil, nil, DBM_COMMON_L.TANKCOMBO, 1, 2)
local specWarnVoidlightConvergence		= mod:NewSpecialWarningBlizzYou(1242515, nil, nil, nil, 2, 2)--No PA to detect color, can only just warn to check color
local specWarnLightFeather				= mod:NewSpecialWarningYou(1241162, nil, nil, nil, 1, 2)--Untested
local specWarnVoidFeather				= mod:NewSpecialWarningYou(1241163, nil, nil, nil, 1, 2)--Untested
--mod:GroupSpells(1242515, 1241162, 1241163)--Uncomment group when hardcode enables parent warning
local specWarnDeathDrop					= mod:NewSpecialWarningCount(1246709, nil, nil, nil, 2, 2)
--Adds
local specWarnLightDiver				= mod:NewSpecialWarningYou(1241292, nil, nil, DBM_COMMON_L.GROUPSOAK, 1, 2)
local specWarnVoidDiver					= mod:NewSpecialWarningYou(1241339, nil, nil, DBM_COMMON_L.GROUPSOAK, 1, 2)

local timerEmbersofBelorenCD			= mod:NewCDCountTimer(20.5, 1241282, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1)
local timerRadiantEchoesCD				= mod:NewCDCountTimer(20.5, 1242981, DBM_COMMON_L.ORBS.." (%s)", nil, nil, 5)
local timerGuardiansEdictCD				= mod:NewCDCountTimer(20.5, 1260763, DBM_COMMON_L.TANKCOMBO.." (%s)", "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK)
local timerEternalBurnsCD				= mod:NewCDCountTimer(20.5, 1244344, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)
local timerInfusedQuillsCD				= mod:NewCDCountTimer(20.5, 1242260, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerVoidlightConvergenceCD		= mod:NewCDCountTimer(20.5, 1242515, L.ColorSwap.." (%s)", nil, nil, 2, nil, DBM_COMMON_L.IMPORTANT_ICON)
local timerDeathDropCD					= mod:NewCDCountTimer(20.5, 1246709, nil, nil, nil, 6)--Stage bar, unless fight actually fires a diff stage bar then we'll use that
local timerBerserkCD					= mod:NewBerserkTimer(600)

mod:AddPrivateAuraSoundOption(1244348, true, 1244344, 1, 3, "absorbyou", 19)--Light Burn (sub spell of Eternal Burns)
mod:AddPrivateAuraSoundOption(1266404, true, 1244344, 1, 3, "absorbyou", 19)--Void Burn (sub spell of Eternal Burns)
mod:AddPrivateAuraSoundOption(1241992, true, 1242260, 1, 1, "lineyou", 17)--Light Quill (sub spell of Infused Quills)
mod:AddPrivateAuraSoundOption(1242091, true, 1242260, 1, 1, "lineyou", 17)--Void Quill (sub spell of Infused Quills)
mod:AddPrivateAuraSoundOption(1241840, true, 1241292, 1, 2, "watchfeet", 8)--Light Patch (dropped by Light Dive)
mod:AddPrivateAuraSoundOption(1241841, true, 1241339, 1, 2, "watchfeet", 8)--Void Patch (dropped by Void Dive)
--Stage 2
local specWarnIncubationofFlames		= mod:NewSpecialWarningCount(1242792, nil, nil, nil, 2, 2)
local specWarnRebirth					= mod:NewSpecialWarningCount(1241313, nil, nil, nil, 1, 2)

local timerIncubationofFlamesCD			= mod:NewCDCountTimer(20.5, 1242792, nil, nil, nil, 3)--Might not even have a timer, if not kill object
local timerRebirthCD					= mod:NewCastTimer(20.5, 1241313, nil, nil, nil, 6)--Iffy

mod:AddPrivateAuraSoundOption(1242803, true, 1242792, 1, 2, "watchfeet", 8)--Light Flames (dropped by Incubation of Flames)
mod:AddPrivateAuraSoundOption(1242815, true, 1242792, 1, 2, "watchfeet", 8)--Void Flames (dropped by Incubation of Flames)

mod.vb.embersCount = 0
mod.vb.echoesCount = 0
mod.vb.edictCount = 0
mod.vb.burnsCount = 0
mod.vb.quillsCount = 0
mod.vb.convergenceCount = 0
mod.vb.deathDropCount = 0
mod.vb.incubationCount = 0
local badStateDetected = false
local lastEmbersEventID = 0
local heroicSequenceSlot = 0

---@param self DBMMod
---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is ONLY using timeline, therefor we must enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		specWarnEmbersofBeloren:SetAlert(128, "mobsoon", 2, 3)
		specWarnRadiantEchoes:SetAlert(130, "orbsincoming", 19, 3)
		if self:IsTank() or self:IsHealer() then
			specWarnGuardiansEdict:SetAlert(134, "tankcombo", 19, 3)
		end
		specWarnVoidlightConvergence:SetAlert(218, "colorchange", 19, 3)
		specWarnDeathDrop:SetAlert(272, "justrun", 2, 3)
		specWarnIncubationofFlames:SetAlert(273, "watchstep", 2, 3)
		specWarnLightFeather:SetAlert(482, "lightyou", 19, 3, 0)
		specWarnVoidFeather:SetAlert(483, "voidyou", 19, 3, 0)
		specWarnLightDiver:SetAlert(494, "lightsoak", 19, 3, 0)
		specWarnVoidDiver:SetAlert(495, "voidsoak", 19, 3, 0)
		specWarnRebirth:SetAlert(497, "dpshard", 16, 3, 0)
	end

	timerEmbersofBelorenCD:SetTimeline(128)
	timerRadiantEchoesCD:SetTimeline(130)
	timerGuardiansEdictCD:SetTimeline(134)
	timerEternalBurnsCD:SetTimeline(138)
	timerInfusedQuillsCD:SetTimeline(161)
	timerVoidlightConvergenceCD:SetTimeline(218)
	timerDeathDropCD:SetTimeline(272)
	timerIncubationofFlamesCD:SetTimeline(273)
	timerRebirthCD:SetTimeline(497)
	timerBerserkCD:SetTimeline(500)
end

function mod:OnLimitedCombatStart(delay)
	self:TLCountReset()
	lastEmbersEventID = 0
	heroicSequenceSlot = 0
	self.vb.embersCount = 1
	self.vb.echoesCount = 1
	self.vb.edictCount = 1
	self.vb.burnsCount = 1
	self.vb.quillsCount = 1
	self.vb.convergenceCount = 1
	self.vb.deathDropCount = 1
	self.vb.incubationCount = 1
	--Hardcode features first
	if DBM.Options.HardcodedTimer and (self:IsEasy() or self:IsHeroic()) and not badStateDetected then
		self:SetStage(1)
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		)
		--SetTimeline events since user has disabled DBM Bars (so they can still get countdowns in blizzard timeline API instead)
		if DBM.Options.HideDBMBars then
			setFallback(self, true)
		end
	else
		setFallback(self)
	end
end

function mod:OnCombatEnd()
	self:TLCountReset()
	lastEmbersEventID = 0
	heroicSequenceSlot = 0
	self:UnregisterShortTermEvents()
end

do
	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersEasy(self, timer, timerExact, eventID)
		if self:GetStage(2) then
			--Rebirth stage. Any bars ending/restarting around here are treated as cycle boundary.
			if timer == 30 or timer == 40 then
				self:TLCountStart(eventID, "rebirth")
				timerRebirthCD:TLStart(timerExact, eventID)
				return
			elseif timer == 10 or timer == 6 or timer == 18 or timer == 20 or timer == 34 or timer == 50 then
				self:SetStage(1)
				lastEmbersEventID = 0
				return timersEasy(self, timer, timerExact, eventID)
			end
			badStateDetected = true
			self:ResumeBlizzardAPI()
			self:UnregisterShortTermEvents()
			setFallback(self)
			DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			return
		end

		if timer == 10 then--Embers of Belo'ren
			lastEmbersEventID = eventID
			timerEmbersofBelorenCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "embers", "embersCount"))
		elseif timer == 6 then--Radiant Echoes OR Death Drop
			if lastEmbersEventID > 0 and (eventID - lastEmbersEventID) <= 2 then
				timerRadiantEchoesCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "echoes", "echoesCount"))
			else
				timerDeathDropCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "deathDrop", "deathDropCount"))
			end
		elseif timer == 18 or timer == 20 then--Guardian's Edict
			timerGuardiansEdictCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "edict", "edictCount"))
		elseif timer == 34 then--Eternal Burns
			timerEternalBurnsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "burns", "burnsCount"))
		elseif timer == 50 then--Voidlight Convergence
			--Blizzard fires ENCOUNTER_WARNING immediately after starting timer for NEXT cast
			--Blizzard warning does NOT line up with state changes. So we dispatch here
			specWarnVoidlightConvergence:Show(self.vb.convergenceCount, "colorchange")

			timerVoidlightConvergenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "convergence", "convergenceCount"))
			warnVoidlightConvergenceSoon:Schedule(timerExact - 5)
			warnVoidlightConvergenceSoon:ScheduleVoice(timerExact - 5, "colorchangesoon")
		elseif timer == 30 or timer == 40 then--Rebirth stage transition (health based)
			self:SetStage(2)
			lastEmbersEventID = 0
			timerRebirthCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rebirth"))
		else
			badStateDetected = true
			self:ResumeBlizzardAPI()
			self:UnregisterShortTermEvents()
			setFallback(self)
			DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
		end
	end

	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersHeroic(self, timer, timerExact, eventID)
		if self:GetStage(2) then
			if timer == 30 or timer == 40 then
				self:TLCountStart(eventID, "rebirth")
				timerRebirthCD:TLStart(timerExact, eventID)
				return
			elseif timer == 10 or timer == 21 or timer == 6 or timer == 18 or timer == 20 or timer == 34 or timer == 50 then
				self:SetStage(1)
				heroicSequenceSlot = 0
				return timersHeroic(self, timer, timerExact, eventID)
			end
			badStateDetected = true
			self:ResumeBlizzardAPI()
			self:UnregisterShortTermEvents()
			setFallback(self)
			DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			return
		end

		-- Logic confirmed against Heroic Week4 logs.
		if timer == 10 then--Cycle opener Embers, or follow-up Infused Quills
			if heroicSequenceSlot == 0 or heroicSequenceSlot == 9 then
				heroicSequenceSlot = 1
				timerEmbersofBelorenCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "embers", "embersCount"))
			elseif heroicSequenceSlot == 7 or heroicSequenceSlot == 8 then
				heroicSequenceSlot = heroicSequenceSlot + 1
				timerInfusedQuillsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "quills", "quillsCount"))
			else
				badStateDetected = true
				self:ResumeBlizzardAPI()
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			end
		elseif timer == 21 then--Cycle opener Infused Quills
			if heroicSequenceSlot == 1 then
				heroicSequenceSlot = 2
				timerInfusedQuillsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "quills", "quillsCount"))
			else
				badStateDetected = true
				self:ResumeBlizzardAPI()
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			end
		elseif timer == 6 then--Radiant Echoes opener, otherwise Death Drop transition
			if heroicSequenceSlot == 2 then
				heroicSequenceSlot = 3
				timerRadiantEchoesCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "echoes", "echoesCount"))
			else
				heroicSequenceSlot = 0
				timerDeathDropCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "deathDrop", "deathDropCount"))
			end
		elseif timer == 34 then--Eternal Burns
			if heroicSequenceSlot == 3 then
				heroicSequenceSlot = 4
				timerEternalBurnsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "burns", "burnsCount"))
			else
				badStateDetected = true
				self:ResumeBlizzardAPI()
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			end
		elseif timer == 20 then--Cycle opener Guardian's Edict
			if heroicSequenceSlot == 4 then
				heroicSequenceSlot = 5
				timerGuardiansEdictCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "edict", "edictCount"))
			else
				badStateDetected = true
				self:ResumeBlizzardAPI()
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			end
		elseif timer == 50 then--Voidlight Convergence
			if heroicSequenceSlot == 5 then
				heroicSequenceSlot = 6
				timerVoidlightConvergenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "convergence", "convergenceCount"))
			else
				badStateDetected = true
				self:ResumeBlizzardAPI()
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			end
		elseif timer == 18 then--Follow-up Guardian's Edict
			if heroicSequenceSlot == 6 then
				heroicSequenceSlot = 7
				timerGuardiansEdictCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "edict", "edictCount"))
			else
				badStateDetected = true
				self:ResumeBlizzardAPI()
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			end
		elseif timer == 30 or timer == 40 then--Rebirth stage transition (health based)
			self:SetStage(2)
			heroicSequenceSlot = 0
			self:TLCountStart(eventID, "rebirth")
			timerRebirthCD:TLStart(timerExact, eventID)
		else
			badStateDetected = true
			self:ResumeBlizzardAPI()
			self:UnregisterShortTermEvents()
			setFallback(self)
			DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
		if eventInfo.source ~= 0 then return end
		local eventID = eventInfo.id
		local timerExact = eventInfo.duration
		local timer = math.floor(timerExact + 0.5)
		if not badStateDetected then
			if self:IsEasy() then
				timersEasy(self, timer, timerExact, eventID)
			elseif self:IsHeroic() then
				timersHeroic(self, timer, timerExact, eventID)
			end
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		if eventState == 2 then
			local eventType, eventCount = self:TLCountFinish(eventID)
			if not eventType then return end
			if eventType == "rebirth" then
				self:SetStage(1)
				lastEmbersEventID = 0
				heroicSequenceSlot = 0
			end
			if not eventCount then return end
			if eventType == "embers" then
				specWarnEmbersofBeloren:Show(eventCount)
				specWarnEmbersofBeloren:Play("mobsoon")
			elseif eventType == "echoes" then
				specWarnRadiantEchoes:Show(eventCount)
				specWarnRadiantEchoes:Play("orbsincoming")
			elseif eventType == "edict" then
				if self:IsTank() or self:IsHealer() then
					specWarnGuardiansEdict:Show(eventCount)
					specWarnGuardiansEdict:Play("tankcombo")
				end
			elseif eventType == "deathDrop" then
				specWarnDeathDrop:Show(eventCount)
				specWarnDeathDrop:Play("justrun")
			elseif eventType == "rebirth" then
				specWarnRebirth:Show(eventCount)
				specWarnRebirth:Play("dpshard")
--			elseif eventType == "convergence" then

			end
		elseif eventState == 3 then
			local eventType = self:TLCountCancel(eventID)
			if eventType == "rebirth" then
				self:SetStage(1)
				lastEmbersEventID = 0
				heroicSequenceSlot = 0
			elseif eventType == "convergence" then
				warnVoidlightConvergenceSoon:Cancel()
				warnVoidlightConvergenceSoon:CancelVoice()
			end
		end
	end
end
