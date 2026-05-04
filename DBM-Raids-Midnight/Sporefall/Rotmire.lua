if DBM:GetTOC() < 120007 then return end
local mod	= DBM:NewMod(2711, "DBM-Raids-Midnight", 4, 1305)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(254176)
mod:SetEncounterID(3159)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(1592)

mod:RegisterCombat("combat")

--Note: Poison Burst doesn't need PA sound, it just means you missed interrupt, non actionable.
--Note: blizzard flagged Bursting Pustules as a private aura but probably meant to flag Rotting Pustules
--Note: Bursting Doom Shroom PA needs no addition. it does 1 million damage initial and another 1 million per second.
--TODO, threat based tank defensive warning for Putrid Fist in the hardcode
--TODO, visit Festering Vines general count warning warning in hardcode
--TODO, swap mod order so this is on top when 12.0.7 goes live
--local warnAlndustUpheaval					= mod:NewBlizzTargetAnnounce(1262289, 2)

local specWarnFungalBloom					= mod:NewSpecialWarningCount(1221637, nil, nil, nil, 2, 2)
local specWarnAwakenFungi					= mod:NewSpecialWarningCount(1221622, nil, nil, nil, 2, 2)
local specWarnBurstingPustules				= mod:NewSpecialWarningCount(1221787, nil, nil, nil, 2, 2)
local specWarnPutridFist					= mod:NewSpecialWarningDefensive(1221781, nil, nil, nil, 1, 2)

local timerFungalBloomCD					= mod:NewCDCountTimer(20.5, 1221637, nil, nil, nil, 2)
local timerAwakenFungiCD					= mod:NewCDCountTimer(20.5, 1221622, nil, nil, nil, 1)
local timerBurstingPustulesCD				= mod:NewCDCountTimer(20.5, 1221787, nil, nil, nil, 2)
local timerPutridFistCD						= mod:NewCDCountTimer(20.5, 1221781, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerFesteringVinesCD					= mod:NewCDCountTimer(20.5, 1222088, nil, nil, nil, 3)
--local timerBerserkCD						= mod:NewBerserkTimer(600)

mod:AddPrivateAuraSoundOption(1221639, true, 1221622, 1, 1, "fixateyou", 19)--Mob fixates from awaken fungi
mod:AddPrivateAuraSoundOption(1222088, true, 1222088, 1, 1, "runout", 2)--Festering Vines
mod:AddPrivateAuraSoundOption(1222129, true, 1222088, 1, 2, "watchfeet", 8)--Writhing Vines (GTFO left by Festering Vines)

mod.vb.fungalBloomCount = 0
mod.vb.awakenFungiCount = 0
mod.vb.burstingPustulesCount = 0
mod.vb.putridFistCount = 0
mod.vb.festeringVinesCount = 0

---@param self DBMMod
---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		specWarnFungalBloom:SetAlert(424, "carefly", 2, 3)
		specWarnAwakenFungi:SetAlert(425, "mobsoon", 2, 3)
		specWarnBurstingPustules:SetAlert(426, "aesoon", 2, 3)
		if self:IsTank() then
			specWarnPutridFist:SetAlert(427, "defensive", 1, 3)
		end
	end
	timerFungalBloomCD:SetTimeline(424)
	timerAwakenFungiCD:SetTimeline(425)
	timerBurstingPustulesCD:SetTimeline(426)
	timerPutridFistCD:SetTimeline(427)
	timerFesteringVinesCD:SetTimeline(428)
end

function mod:OnLimitedCombatStart()
	self.vb.fungalBloomCount = 1
	self.vb.awakenFungiCount = 1
	self.vb.burstingPustulesCount = 1
	self.vb.putridFistCount = 1
	self.vb.festeringVinesCount = 1
--	self:TLCountReset()
	--Hardcode features first
	--if DBM.Options.HardcodedTimer and (self:IsEasy() or self:IsHeroic() or self:IsMythic()) and not badStateDetected then
		--self:SetStage(1)
		--self:IgnoreBlizzardAPI()
		--self:RegisterShortTermEvents(
		--	"ENCOUNTER_TIMELINE_EVENT_ADDED",
		--	"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		--)
		--if DBM.Options.HideDBMBars then
		--	setFallback(self, true)
		--end
	--else
		setFallback(self)
	--end
end

--[[
function mod:OnCombatEnd()
--	self:TLCountReset()
--	self:UnregisterShortTermEvents()
end

do
	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersEasy(self, timer, timerExact, eventID)
		if timer == 7 then
			--timerFungalBloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "bloom", "fungalBloomCount"))
		else--Reached end of chain without finding a valid timer, this means hardcode mod has failed, so we need to disable hardcoded features and fall back to blizz API
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
			if self:IsEasy() then
				timersEasy(self, timer, timerExact, eventID)
			end
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		if eventState == 2 then
			local eventType, eventCount = self:TLCountFinish(eventID)
			if eventType and eventCount then
				if eventType == "bloom" then

				end
			end
		elseif eventState == 3 then
			self:TLCountCancel(eventID)
		end
	end
end
--]]
