local mod	= DBM:NewMod(2734, "DBM-Raids-Midnight", 3, 1307)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(240434)
mod:SetEncounterID(3177)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2912)

mod:RegisterCombat("combat")

--TODO< https://www.wowhead.com/spell=1244346/colossal-throw has an event ID but doesn't exist on encounter?
--TODO, probably drop either 59 or 60 for eventIDs, one is for parent activation and one is for the additional slams we probably want to ignore/filter
--Hardcoded Objects that use Blizz api as fallback
local specWarnShadowclawSlam			= mod:NewSpecialWarningCount(1241836, nil, 182557, nil, 2, 2)
local specWarnVoidBreath				= mod:NewSpecialWarningDodgeCount(1243853, nil, 17088, nil, 2, 2)
local specWarnParasiteExpulsion			= mod:NewSpecialWarningDodgeCount(1254199, nil, nil, DBM_COMMON_L.ADDS, 2, 2)
local specWarnPrimordialRoar			= mod:NewSpecialWarningCount(1260046, nil, 140459, nil, 2, 2)
--local specWarnFixateParasite			= mod:NewSpecialWarningYou(1254112, nil, nil, nil, 1, 2)

local timerShadowclawSlamCD				= mod:NewCDCountTimer("d20.5", 1241836, 182557, nil, nil, 2)--Shortname "Slam"
--local timerVoidBreathCD				= mod:NewCDCountTimer(20.5, 1243853, 17088, nil, nil, 3)--Shortname "Breath"
local timerParasiteExpulsionCD			= mod:NewCDCountTimer(20.5, 1254199, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1)
local timerPrimordialRoarCD				= mod:NewCDCountTimer(20.5, 1260046, 140459, nil, nil, 2)--Shortname "Roar"

mod:AddPrivateAuraSoundOption(1243270, true, 1243270, 1, 2, "watchfeet", 8)--Dark Goo
mod:AddPrivateAuraSoundOption(1241844, false, 1241836, 1, 3, "debuffyou", 17)--Smashed (debuff from shadowclaw slam)
mod:AddPrivateAuraSoundOption(1272527, false, 1272527, 1, 1, "debuffyou", 17)--Creep Spit
mod:AddPrivateAuraSoundOption(1259186, true, 1259186, 1, 1, "debuffyou", 17)--Blisterburst
mod:AddPrivateAuraSoundOption(1254113, true, 1254113, 1, 2, "fixateyou", 19)--Fixate

mod.vb.clawCount = 0
mod.vb.breathCount = 0
mod.vb.expulsionCount = 0
mod.vb.roarCount = 0
local badStateDetected = false

local function setFallback(self)
	--Blizz API fallbacks
	specWarnShadowclawSlam:SetAlert({59, 60}, "slamincoming", 19, 2)
	timerShadowclawSlamCD:SetTimeline({59, 60})
--	timerVoidBreathCD:SetTimeline(61)
	specWarnParasiteExpulsion:SetAlert(62, "watchstep", 2, 2)
	timerParasiteExpulsionCD:SetTimeline(62)
	specWarnPrimordialRoar:SetAlert(133, "pullin", 12, 3)
	timerPrimordialRoarCD:SetTimeline(133)
--	specWarnFixateParasite:SetAlert(557, "fixateyou", 19, 3, 0)
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
	self.vb.clawCount = 1
	self.vb.breathCount = 1
	self.vb.expulsionCount = 1
	self.vb.roarCount = 1
	if DBM.Options.HardcodedTimer and self:IsEasy() and not badStateDetected then
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		)
	else
		setFallback(self)
	end
	specWarnVoidBreath:SetAlert(61, "breathsoon", 2, 4, 0)--Doesn't have a timeline event, so we still use blizz api regardless if hardcode enabled or not
end

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
		if timer == 6 or timer == 120 then--Primordial Roar
			timerPrimordialRoarCD:TLStart(timer, eventID, self:TLCountStart(eventID, "roar", "roarCount"))
		elseif timer == 57 or timer == 123 then--Parasite Expulsion
			timerParasiteExpulsionCD:TLStart(timer, eventID, self:TLCountStart(eventID, "expulsion", "expulsionCount"))
		elseif timer == 16 or timer == 136 or timer == 240 then--Shadowclaw Slam
			if timer == 240 then
				timer = 120--Blizzard doesn't even know their own timers
			end
			if timer == 136 then
				--Increment count by 1 since it'll start in parallel to the initial 16 second bar
				timerShadowclawSlamCD:TLStart(timer, eventID, self:TLCountStart(eventID, "slam", "clawCount") + 1)
			else
				timerShadowclawSlamCD:TLStart(timer, eventID, self:TLCountStart(eventID, "slam", "clawCount"))
			end
		else--Reached end of chain without finding a valid timer, this means hardcode mod has failed, so we need to disable hardcoded features and fall back to blizz API
			if not DBM.Options.DebugMode then
				badStateDetected = true
				if DBM.Options.IgnoreBlizzAPI then
					DBM.Options.IgnoreBlizzAPI = false
					DBM:FireEvent("DBM_ResumeBlizzAPI")
				end
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			else
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
			end
		end
	end
	--Note, bar stage changing and canceling is handled by core
	function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
		if eventInfo.source ~= 0 then return end
		local eventID = eventInfo.id
--		local eventState = C_EncounterTimeline.GetEventState(eventID)
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
		if eventState == 2 then
			local eventType, eventCount = self:TLCountFinish(eventID)
			if eventType and eventCount then
				if eventType == "roar" then
					specWarnPrimordialRoar:Show(eventCount)
					specWarnPrimordialRoar:Play("pullin")
				elseif eventType == "expulsion" then
					specWarnParasiteExpulsion:Show(eventCount)
					specWarnParasiteExpulsion:Play("watchstep")
				elseif eventType == "slam" then
					specWarnShadowclawSlam:Show(eventCount)
					specWarnShadowclawSlam:Play("slamincoming")
				end
			end
		elseif eventState == 3 then
			self:TLCountCancel(eventID)
		end
	end
end
