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

local timerShadowclawSlamCD				= mod:NewCDCountTimer(20.5, 1241836, 182557, nil, nil, 2)--Shortname "Slam"
--local timerVoidBreathCD					= mod:NewCDCountTimer(20.5, 1243853, 17088, nil, nil, 3)--Shortname "Breath"
local timerParasiteExpulsionCD			= mod:NewCDCountTimer(20.5, 1254199, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1)
local timerPrimordialRoarCD				= mod:NewCDCountTimer(20.5, 1260046, 140459, nil, nil, 2)--Shortname "Roar"

mod:AddPrivateAuraSoundOption(1243270, true, 1243270, 1, 2)--Dark Goo
mod:AddPrivateAuraSoundOption(1241844, false, 1241836, 1, 3)--Smashed (debuff from shadowclaw slam)
mod:AddPrivateAuraSoundOption(1272527, false, 1272527, 1, 1)--Creep Spit
mod:AddPrivateAuraSoundOption(1259186, true, 1259186, 1, 1)--Blisterburst
mod:AddPrivateAuraSoundOption(1254113, true, 1254113, 1, 2)--Fixate

mod.vb.clawCount = 0
mod.vb.breathCount = 0
mod.vb.expulsionCount = 0
mod.vb.roarCount = 0
local badStateDetected = false
local cachedEventIDs = {}

function mod:OnLimitedCombatStart()
	table.wipe(cachedEventIDs)
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
		--Blizz API fallbacks
		specWarnShadowclawSlam:SetAlert({59, 60}, "slamincoming", 19, 2)
		timerShadowclawSlamCD:SetTimeline({59, 60})
--		timerVoidBreathCD:SetTimeline(61)
		specWarnParasiteExpulsion:SetAlert(62, "watchstep", 2, 2)
		timerParasiteExpulsionCD:SetTimeline(62)
		specWarnPrimordialRoar:SetAlert(133, "pullin", 12, 3)
		timerPrimordialRoarCD:SetTimeline(133)
--		specWarnFixateParasite:SetAlert(557, "fixateyou", 19, 3, 0)
	end
	specWarnVoidBreath:SetAlert(61, "breathsoon", 2, 4, 0)--Doesn't have a timeline event, so we still use blizz api regardless if hardcode enabled or not
	self:EnablePrivateAuraSound(1243270, "watchfeet", 8)
	self:EnablePrivateAuraSound(1241844, "debuffyou", 17)
	self:EnablePrivateAuraSound(1272527, "debuffyou", 17)
	self:EnablePrivateAuraSound(1259186, "debuffyou", 17)
	self:EnablePrivateAuraSound(1254113, "fixateyou", 19)
end

function mod:OnCombatEnd()
	table.wipe(cachedEventIDs)
	self:UnregisterShortTermEvents()
end

do
	local function timersEasy(self, timer, eventID)
		if timer == 6 or timer == 120 then--Primordial Roar
			timerPrimordialRoarCD:TLStart(timer, eventID, self.vb.roarCount)
			cachedEventIDs[eventID] = "roar"
		elseif timer == 57 or timer == 123 then--Parasite Expulsion
			timerParasiteExpulsionCD:TLStart(timer, eventID, self.vb.expulsionCount)
			cachedEventIDs[eventID] = "expulsion"
		elseif timer == 16 or timer == 136 or timer == 240 then--Shadowclaw Slam
			timerShadowclawSlamCD:TLStart(timer, eventID, self.vb.clawCount)
			cachedEventIDs[eventID] = "slam"
		else--Reached end of chain without finding a valid timer, this means hardcode mod has failed, so we need to disable hardcoded features and fall back to blizz API
			badStateDetected = true
			if DBM.Options.IgnoreBlizzAPI then
				DBM.Options.IgnoreBlizzAPI = false
				DBM:FireEvent("DBM_ResumeBlizzAPI")
			end
			self:UnregisterShortTermEvents()
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
			local eventType = cachedEventIDs[eventID]
			if eventType == "roar" then
				self.vb.roarCount = self.vb.roarCount + 1
				specWarnPrimordialRoar:Show(self.vb.roarCount)
				specWarnPrimordialRoar:Play("pullin")
			elseif eventType == "expulsion" then
				self.vb.expulsionCount = self.vb.expulsionCount + 1
				specWarnParasiteExpulsion:Show(self.vb.expulsionCount)
				specWarnParasiteExpulsion:Play("watchstep")
			elseif eventType == "slam" then
				self.vb.clawCount = self.vb.clawCount + 1
				specWarnShadowclawSlam:Show(self.vb.clawCount)
				specWarnShadowclawSlam:Play("slamincoming")
			end
			cachedEventIDs[eventID] = nil
		elseif eventState == 3 then
			cachedEventIDs[eventID] = nil
		end
	end
end
