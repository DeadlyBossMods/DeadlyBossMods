local mod	= DBM:NewMod(2736, "DBM-Raids-Midnight", 3, 1307)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(240432)
mod:SetEncounterID(3179)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2912)

mod:RegisterCombat("combat")

--local warnDespoticCommand					= mod:NewCountAnnounce(1248697, 2)--Hardcode only

local specWarnVoidConvergence				= mod:NewSpecialWarningCount(1243453, nil, nil, DBM_COMMON_L.ORBS, 2, 2)
local specWarnFracturedProjection			= mod:NewSpecialWarningCount(1254081, "HasInterrupt", nil, nil, 2, 2)
local specWarnShatteringTwilight			= mod:NewSpecialWarningCount(1253024, nil, nil, nil, 2, 2)
local specWarnTwilightObscurity				= mod:NewSpecialWarningCount(1250686, nil, nil, DBM_COMMON_L.AOEDAMAGE, 2, 2)
local specWarnEntropicUnraveling			= mod:NewSpecialWarningCount(1246175, nil, nil, nil, 2, 2)

local timerVoidConvergenceCD				= mod:NewCDCountTimer(20.5, 1243453, DBM_COMMON_L.ORBS.." (%s)", nil, nil, 5)
local timerDespoticCommandCD				= mod:NewCDCountTimer(20.5, 1248697, DBM_COMMON_L.POOLS.." (%s)", nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)
local timerFracturedProjectionCD			= mod:NewCDCountTimer(20.5, 1254081, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerShatteringTwilightCD				= mod:NewCDCountTimer(20.5, 1253024, 1248137, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--shortname "Dark Star"
local timerTwilightObscurityCD				= mod:NewCDCountTimer(20.5, 1250686, DBM_COMMON_L.AOEDAMAGE.." (%s)", nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerEntropicUnravelingCD				= mod:NewCDCountTimer(20.5, 1246175, DBM_COMMON_L.LINES.." (%s)", nil, nil, 6, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerBerserkCD						= mod:NewBerserkTimer(600)

mod:AddPrivateAuraSoundOption(1250828, true, 1243453, 1, 3, "watchfeet", 8)--Void Exposure (People who soak void convergence)
mod:AddPrivateAuraSoundOption(1248697, true, 1248697, 1, 1, "poolyou", 18)--Despotic Command
mod:AddPrivateAuraSoundOption(1245592, true, 1245592, 1, 2, "watchfeet", 8)--Torturous Extract (dropped by 3 diff mechanics so not bundled)
mod:AddPrivateAuraSoundOption({1253024, 1268992}, true, 1253024, 1, 1, "runout", 2)--Shattering Twilight
mod:AddPrivateAuraSoundOption(1251213, true, 1253024, 1, 2, "watchfeet", 8)--Twilight Spikes (pool from Shattering Twilight)
mod:AddPrivateAuraSoundOption(1250991, false, 1243453, 1, 3, "debuffyou", 17)--Dark Radiation (dot from void convergence)

mod.vb.convergenceCount = 0
mod.vb.despoticCommandCount = 0
mod.vb.fracturedProjectionCount = 0
mod.vb.shatteringTwilightCount = 0
mod.vb.twilightObscurityCount = 0
mod.vb.entropicUnravelingCount = 0
local badStateDetected = false
local next45Type = nil

local function resetCounts(self)
	self.vb.convergenceCount = 1
	self.vb.despoticCommandCount = 1
	self.vb.fracturedProjectionCount = 1
	self.vb.shatteringTwilightCount = 1
	self.vb.twilightObscurityCount = 1
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
	resetCounts(self)
	self.vb.entropicUnravelingCount = 1
	next45Type = nil

	if DBM.Options.HardcodedTimer and self:IsEasy() and not badStateDetected then
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		)
	else
		--Blizz API fallbacks
		specWarnVoidConvergence:SetAlert(139, "targetchange", 2, 3)
		timerVoidConvergenceCD:SetTimeline(139)
		timerDespoticCommandCD:SetTimeline(140)
		specWarnFracturedProjection:SetAlert(141, "crowdcontrol", 2, 3)
		timerFracturedProjectionCD:SetTimeline(141)
		specWarnShatteringTwilight:SetAlert(142, "watchstep", 2, 3)--Alert for rest of raid
		timerShatteringTwilightCD:SetTimeline(142)
		specWarnTwilightObscurity:SetAlert(143, "aesoon", 2, 2)
		timerTwilightObscurityCD:SetTimeline(143)
		specWarnEntropicUnraveling:SetAlert(148, "dpshard", 2, 2, 0)
		timerEntropicUnravelingCD:SetTimeline(148)
		timerBerserkCD:SetTimeline(633)
	end

end

--Note, bar stage changing and canceling is handled by core
function mod:OnCombatEnd()
	self:TLCountReset()
	self:UnregisterShortTermEvents()
end

do
	---@param self DBMMod
	---@param timer number
	---@param eventID number
	local function timersEasy(self, timer, eventID)
		--Logic confirmed against normal and LFR
		if timer == 490 then--Berserk
			timerBerserkCD:Start(490)
		elseif timer == 100 then--Entropic Unraveling, phase change marker
			if not self:AntiSpam(2, 1) then
				return--Bugged duplicate add at the same moment, ignore second event
			end
	--		resetCounts(self)--Phase reset point
			next45Type = "twisted"--Shared 45s open as Twisted/Fractured after phase transition
			timerEntropicUnravelingCD:TLStart(timer, eventID, self:TLCountStart(eventID, "entropic", "entropicUnravelingCount"))
		elseif timer == 27 or timer == 46 then--Despotic Command
			timerDespoticCommandCD:TLStart(timer, eventID, self:TLCountStart(eventID, "despotic", "despoticCommandCount"))
			if timer == 46 then
				next45Type = "shattering"
			end
		elseif timer == 18 then--Fractured Projection
			timerFracturedProjectionCD:TLStart(timer, eventID, self:TLCountStart(eventID, "fractured", "fracturedProjectionCount"))
		elseif timer == 42 then--Shattering Twilight
			timerShatteringTwilightCD:TLStart(timer, eventID, self:TLCountStart(eventID, "shattering", "shatteringTwilightCount"))
		elseif timer == 11 or timer == 47 then--Void Convergence
			timerVoidConvergenceCD:TLStart(timer, eventID, self:TLCountStart(eventID, "convergence", "convergenceCount"))
			next45Type = "twisted"
		elseif timer == 15 then--Twisting Obscurity opener
			timerTwilightObscurityCD:TLStart(timer, eventID, self:TLCountStart(eventID, "twisted", "twilightObscurityCount"))
			next45Type = "fractured"
		elseif timer == 45 then--Shared duration among Twisted/Fractured/Shattering
			if next45Type == "twisted" then
				timerTwilightObscurityCD:TLStart(timer, eventID, self:TLCountStart(eventID, "twisted", "twilightObscurityCount"))
				next45Type = "fractured"
			elseif next45Type == "fractured" then
				timerFracturedProjectionCD:TLStart(timer, eventID, self:TLCountStart(eventID, "fractured", "fracturedProjectionCount"))
				next45Type = "shattering"
			elseif next45Type == "shattering" then
				timerShatteringTwilightCD:TLStart(timer, eventID, self:TLCountStart(eventID, "shattering", "shatteringTwilightCount"))
				next45Type = nil
			else--Reached end of chain without finding a valid timer, this means hardcode mod has failed, so we need to disable hardcoded features and fall back to blizz API
				badStateDetected = true
				if DBM.Options.IgnoreBlizzAPI then
					DBM.Options.IgnoreBlizzAPI = false
					DBM:FireEvent("DBM_ResumeBlizzAPI")
				end
				self:UnregisterShortTermEvents()
				DBM:Debug("|cffff0000TheDreamrift: Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			end
		else--Reached end of chain without finding a valid timer, this means hardcode mod has failed, so we need to disable hardcoded features and fall back to blizz API
			if not DBM.Options.DebugMode then
				badStateDetected = true
				if DBM.Options.IgnoreBlizzAPI then
					DBM.Options.IgnoreBlizzAPI = false
					DBM:FireEvent("DBM_ResumeBlizzAPI")
				end
				self:UnregisterShortTermEvents()
				DBM:Debug("|cffff0000TheDreamrift: Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			else
				DBM:Debug("|cffff0000TheDreamrift: Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
			end
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
		if eventInfo.source ~= 0 then return end
		local eventID = eventInfo.id
		local timer = math.floor(eventInfo.duration + 0.5)
		if not badStateDetected then
			if self:IsEasy() then
				timersEasy(self, timer, eventID)
			end
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		if eventState == 2 then--Finished (A bar that's ending, meaning now the cast should be happening soon)
			local eventType, eventCount = self:TLCountFinish(eventID)
			if eventType and eventCount then
				if eventType == "convergence" then
					specWarnVoidConvergence:Show(eventCount)
					specWarnVoidConvergence:Play("targetchange")
				elseif eventType == "fractured" then
					specWarnFracturedProjection:Show(eventCount)
					specWarnFracturedProjection:Play("crowdcontrol")
				elseif eventType == "twisted" then
					specWarnTwilightObscurity:Show(eventCount)
					specWarnTwilightObscurity:Play("aesoon")
				elseif eventType == "entropic" then
					specWarnEntropicUnraveling:Show(eventCount)
					specWarnEntropicUnraveling:Play("dpshard")
				elseif eventType == "despotic" then
				elseif eventType == "shattering" then
					--Schedule 5 seconds after event, which is when spikes should come out
					specWarnShatteringTwilight:Schedule(3.5, eventCount)
					specWarnShatteringTwilight:ScheduleVoice(3.5, "watchstep")
				end
			end
		elseif eventState == 3 then--Canceled/removed
			self:TLCountCancel(eventID)
		end
	end
end
