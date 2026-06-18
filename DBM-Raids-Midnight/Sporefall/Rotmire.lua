if DBM:GetTOC() < 120007 then return end
local mod	= DBM:NewMod(2711, "DBM-Raids-Midnight", 4, 1305)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(238693)
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

local specWarnFungalBloom					= mod:NewSpecialWarningCount(1221637, nil, nil, nil, 2, 2, nil, nil, "carefly")
local specWarnAwakenFungi					= mod:NewSpecialWarningCount(1221622, nil, nil, nil, 2, 2, nil, nil, "mobsoon")
local specWarnBurstingPustules				= mod:NewSpecialWarningCount(1221787, nil, nil, nil, 2, 2, nil, nil, "aesoon")
local specWarnPutridFist					= mod:NewSpecialWarningDefensive(1221781, nil, nil, nil, 1, 2, nil, nil, "defensive")
local specWarnPutridFistTaunt				= mod:NewSpecialWarningTaunt(1221781, nil, nil, nil, 1, 2, nil, nil, "tauntboss")
local specWarnFesteringVines				= mod:NewSpecialWarningBlizzYou(1222088, nil, nil, nil, 2, 2, nil, nil, "poolyou")
--local specWarnFunglingFixate				= mod:NewSpecialWarningYou(1299508, nil, nil, nil, 1, 2)
--local specWarnShroomingFixate				= mod:NewSpecialWarningYou(1221639, nil, nil, nil, 1, 2)

local timerFungalBloomCD					= mod:NewCDCountTimer(20.5, 1221637, nil, nil, nil, 2)
local timerAwakenFungiCD					= mod:NewCDCountTimer(20.5, 1221622, nil, nil, nil, 1)
local timerBurstingPustulesCD				= mod:NewCDCountTimer(20.5, 1221787, nil, nil, nil, 2)
local timerPutridFistCD						= mod:NewCDCountTimer(20.5, 1221781, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerFesteringVinesCD					= mod:NewCDCountTimer(20.5, 1222088, nil, nil, nil, 3)
--local timerBerserkCD						= mod:NewBerserkTimer(600)

mod:AddPrivateAuraSoundOption(1221639, true, 1221622, 1, 1, "fixateyou", 19)--Mob fixates from awaken fungi (may stop being a private aura soon enough
mod:AddPrivateAuraSoundOption(1299508, true, 1221622, 1, 1, "fixateyou", 19)--Mob fixates from awaken fungi (may stop being a private aura soon enough)
--mod:AddPrivateAuraSoundOption(1222088, true, 1222088, 1, 1, "runout", 2)--Festering Vines
mod:AddPrivateAuraSoundOption(1222129, true, 1222088, 1, 2, "watchfeet", 8)--Writhing Vines (GTFO left by Festering Vines)

mod.vb.fungalBloomCount = 0
mod.vb.awakenFungiCount = 0
mod.vb.burstingPustulesCount = 0
mod.vb.putridFistCount = 0
mod.vb.festeringVinesCount = 0
local badStateDetected = false--Used to track if hardcode features have failed and we need to fall back to blizz API
local mythic13Slot = 0
local mythic49Slot = 0

---@param self DBMMod
---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		specWarnFungalBloom:SetAlert(424, "carefly", 2, 3)
		specWarnAwakenFungi:SetAlert(425, "mobsoon", 2, 3)
		specWarnBurstingPustules:SetAlert(426, "aesoon", 2, 3)
		specWarnFesteringVines:SetAlert(428, "poolyou", 18, 3)
		if self:IsTank() then
			specWarnPutridFist:SetAlert(427, "defensive", 1, 3)
		end
		--specWarnFunglingFixate:SetAlert(808, "fixateyou", 1, 3)
		--specWarnShroomingFixate:SetAlert(809, "fixateyou", 1, 3)
	end
	local onlyColor = not DBM.Options.HideDBMBars
	timerFungalBloomCD:SetTimeline(424, onlyColor)
	timerAwakenFungiCD:SetTimeline(425, onlyColor)
	timerBurstingPustulesCD:SetTimeline(426, onlyColor)
	timerPutridFistCD:SetTimeline(427, onlyColor)
	timerFesteringVinesCD:SetTimeline(428, onlyColor)
end

function mod:OnLimitedCombatStart()
	self.vb.fungalBloomCount = 1
	self.vb.awakenFungiCount = 1
	self.vb.burstingPustulesCount = 1
	self.vb.putridFistCount = 1
	self.vb.festeringVinesCount = 1
	mythic13Slot = 0
	mythic49Slot = 0
	self:TLCountReset()
	--Hardcode features first
	if DBM.Options.HardcodedTimer and not badStateDetected then
		--self:SetStage(1)
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		)
		if DBM.Options.HideDBMBars then
			setFallback(self, true)
		end
	else
		setFallback(self)
	end
end


function mod:OnCombatEnd()
	mythic13Slot = 0
	mythic49Slot = 0
	self:TLCountReset()
	self:UnregisterShortTermEvents()
end

do
	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersAll(self, timer, timerExact, eventID)
		local handled
		if timer == 114 then
			handled = true
			timerFungalBloomCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "bloom", "fungalBloomCount"))
		elseif timer == 41 then
			handled = true
			timerFesteringVinesCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vines", "festeringVinesCount"))
		elseif timer == 24 or timer == 12 then
			handled = true
			timerPutridFistCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "fist", "putridFistCount"))
		elseif timer == 8 or timer == 21 then
			handled = true
			timerBurstingPustulesCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "burst", "burstingPustulesCount"))
		elseif timer == 13 then
			handled = true
			mythic13Slot = mythic13Slot + 1
			if mythic13Slot % 2 == 1 then
				timerAwakenFungiCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "awaken", "awakenFungiCount"))
			else
				timerPutridFistCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "fist", "putridFistCount"))
			end
		elseif timer == 49 then
			handled = true
			mythic49Slot = (mythic49Slot % 3) + 1
			if mythic49Slot == 1 then
				timerAwakenFungiCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "awaken", "awakenFungiCount"))
			elseif mythic49Slot == 2 then
				timerBurstingPustulesCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "burst", "burstingPustulesCount"))
			else
				timerFesteringVinesCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "vines", "festeringVinesCount"))
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
			if eventType == "bloom" then
				specWarnFungalBloom:Show(eventCount)
				specWarnFungalBloom:Play("carefly")
			elseif eventType == "awaken" then
				specWarnAwakenFungi:Show(eventCount)
				specWarnAwakenFungi:Play("mobsoon")
			elseif eventType == "burst" then
				specWarnBurstingPustules:Show(eventCount)
				specWarnBurstingPustules:Play("aesoon")
			elseif eventType == "fist" then
				if self:IsTanking("player", "boss1", nil, true) then
					specWarnPutridFist:Show()
					specWarnPutridFist:Play("defensive")
				elseif self:IsTank() then
					local targetName = UnitName("boss1target")
					specWarnPutridFistTaunt:SecretShow(targetName)
					specWarnPutridFistTaunt:Play("tauntboss")
				end
			elseif eventType == "vines" then
				specWarnFesteringVines:Show(eventCount, "poolyou")
			end
		elseif eventState == 3 then
			self:TLCountCancel(eventID)
		end
	end
end
