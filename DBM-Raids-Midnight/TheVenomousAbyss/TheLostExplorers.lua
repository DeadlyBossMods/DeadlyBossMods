local mod	= DBM:NewMod(2894, "DBM-Raids-Midnight", 1, 1320)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

local UnitIsFriend = UnitIsFriend

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(261835, 261843, 261848)--261584 is Mor'zahi
mod:SetEncounterID(3497)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(3004)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")
mod:RegisterSafeEventsInCombat("UNIT_FLAGS boss1 boss3 boss4")

--TODO: Toss targets for toss mechanics?
--TODO, Frostfire Volley patches need GTFOs, when it's possible (aura api?)
--TODO, all of Mor'zahi mechanics are missing EncounterEvents (or assigned to invalid encounterIds)
--NOTE: Blink Nova has two spellids and two encounter event IDs. TODO, identify if maybe diff IDs are diff teleport locations and further refine voice pack
--NOTE: These 3 spells are not timeline based but activated on deaths that we cant detect so we'll use non hardcoded objects for them only. Cataclysmic Invocation, Relentless Escalation, and Smashing Shovel
--TODO, maybe add a troll BOING sound to https://www.wowhead.com/ptr/spell=1299854/bounce ?
DBM:RegisterAltSpellName(1295854, DBM_COMMON_L.TANKDEBUFF)--Shredding Shards --> Tank Debuff
mod:AddCustomAlertSoundOption(1291390, true, 2)--Cataclysmic Invocation
--mod:AddCustomAlertSoundOption(0, true, 2)--Relentless Escalation (no event ID?)
--mod:AddCustomAlertSoundOption(0, true, 2)--Smashing Shovel (no event ID?)
mod:AddCustomAlertSoundOption(1292779, true, 2, nil)--Empowered Ascension
local warnFlingFish						= mod:NewCountAnnounce(1295817, 3)--hardcode only?
local warnExplosiveSurprise				= mod:NewBlizzTargetAnnounce(1296249, 3)--hardcode only

local specWarnIceboundFlames			= mod:NewSpecialWarningCount(1286921, nil, nil, nil, 1, 2, nil, nil, "kickcast")--Fix audio if targetting doable
local specWarnBlinkNova					= mod:NewSpecialWarningRunCount(1290711, nil, nil, nil, 4, 2, nil, nil, "justrun")
local specWarnMightyThud				= mod:NewSpecialWarningSoakCount(1296092, nil, nil, nil, 2, 17, nil, nil, "soakincoming")
local specWarnShellSpin					= mod:NewSpecialWarningDodgeCount(1291759, nil, nil, nil, 2, 2, nil, nil, "farfromline")
local specWarnThrowJunk					= mod:NewSpecialWarningDodgeCount(1291933, nil, nil, nil, 2, 2, nil, nil, "watchstep")
local specWarnMushroomToss				= mod:NewSpecialWarningDodgeCount(1292104, nil, nil, nil, 2, 2, nil, nil, "watchstep")
local specWarnShreddingShards			= mod:NewSpecialWarningDefensive(1295854, nil, nil, nil, 1, 2, nil, nil, "defensive")
local specWarnFrostfireVolley			= mod:NewSpecialWarningDodgeCount(1295935, nil, nil, nil, 2, 2, nil, nil, "watchstep")

local timerIceboundFlamesCD				= mod:NewCDCountTimer(20.5, 1286921, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerBlinkNovaCD					= mod:NewCDCountTimer(20.5, 1290711, nil, nil, nil, 2)
local timerMightyThudCD					= mod:NewCDCountTimer(20.5, 1296092, nil, nil, nil, 5)
local timerShellSpinCD					= mod:NewCDCountTimer(20.5, 1291759, nil, nil, nil, 3)
local timerThrowJunkCD					= mod:NewCDCountTimer(20.5, 1291933, nil, nil, nil, 3)
local timerFlingFishCD					= mod:NewCDCountTimer(20.5, 1295817, nil, nil, nil, 5)
local timerMushroomTossCD				= mod:NewCDCountTimer(20.5, 1292104, nil, nil, nil, 3)
local timerShreddingShardsCD			= mod:NewCDCountTimer(20.5, 1295854, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerFrostfireVolleyCD			= mod:NewCDCountTimer(20.5, 1295935, nil, nil, nil, 3)
local timerExplosiveSurpriseCD			= mod:NewCDCountTimer(20.5, 1296249, nil, nil, nil, 3)
--local timerBerserkCD					= mod:NewBerserkTimer(600)--Unending Tides

--evidence Log https://www.warcraftlogs.com/reports/MyHmVwLj8ncbpxvW?fight=15&type=auras&spells=debuffs
mod:AddAuraSoundOption(1308853, false, 1291933, 1, 3, "stackhigh", 6, 1)--Splinters (could be spammy, could be annoying, off by default)
mod:AddAuraSoundOption(1295954, true, 1295935, 3, 1, "movetofire", 20, 0)--Piercing Frost
mod:AddAuraSoundOption(1295928, true, 1295935, 3, 1, "movetofrost", 20, 0)--Buring Flames
mod:AddAuraSoundOption(1297648, false, 1295935, 1, 2, "watchfeet", 8, 0)--Frost Patch (off by default since on this fight you stand in on purpose to remove with opposite debuff)
mod:AddAuraSoundOption(1297649, false, 1295935, 1, 2, "watchfeet", 8, 0)--Fire Patch (off by default since on this fight you stand in on purpose to remove with opposite debuff)
mod:AddAuraSoundOption(1291918, true, 1291918, 1, 3, "stunyou", 19, 0)--Piercing Frost
mod:AddAuraSoundOption(1297625, true, 1297625, 1, 1, "bombyou", 12, 0)--Explosive Surprise
mod:AddAuraSoundOption(1286922, true, 1286922, 1, 3, mod:IsHealer() and "helpdispel" or "defensive", 2, 0)--Icebound Flames DoT (hits REALLY hard, if you don't die from initial hit)
mod:AddAuraSoundOption(1297650, true, 1296249, 1, 2, "watchfeet", 8, 0)--Spreading Flames
--Debuffs that do not appear in combat log but MIGHT still work with aura sounds?
mod:AddAuraSoundOption(1295886, true, 1295935, 1, 1, "flameyou", 15, 0)--Frostfire Volley (targeted by fire)
mod:AddAuraSoundOption(1295935, true, 1295935, 1, 1, "frostyou", 20, 0)--Frostfire Volley (targeted by frost)
mod:AddAuraSoundOption(1296025, true, 1290711, 1, 1, "teleyou", 5, 0)--Blink Nova
mod:AddAuraSoundOption(1296092, true, 1296092, 1, 1, "leapyou", 19, 0)--Mighty Thud

local badStateDetected = false--Used to track if hardcode features have failed and we need to fall back to blizz API
local delayedStarts = {}
local pendingNormalStage = nil
local normalStage2Special32Count = 0
local normalStage4Special27Count = 0
local normalNext31IsIce = true
local normalHardcodeActive = false

mod.vb.IceboundFlamesCount = 0
mod.vb.BlinkNovaCount = 0
mod.vb.MightyThudCount = 0
mod.vb.ShellSpinCount = 0
mod.vb.ThrowJunkCount = 0
mod.vb.FlingFishCount = 0
mod.vb.MushroomTossCount = 0
mod.vb.ShreddingShardsCount = 0
mod.vb.FrostfireVolleyCount = 0
mod.vb.ExplosiveSurpriseCount = 0

---@param self DBMMod
---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		if self:IsTank() then
			specWarnShreddingShards:SetAlert(768, "defensive", 2, 2)
		end
		specWarnIceboundFlames:SetAlert(722, "kickcast", 2, 2)
		specWarnBlinkNova:SetAlert({723, 724, 737, 738}, "justrun", 2, 3)--1290711, 1290742, 1290740, 1290743
		specWarnMightyThud:SetAlert(725, "soakincoming", 17, 2)
		specWarnShellSpin:SetAlert(726, "farfromline", 2, 2)
		specWarnThrowJunk:SetAlert(727, "watchstep", 2, 2)
		specWarnMushroomToss:SetAlert(729, "watchstep", 2, 2)
		specWarnFrostfireVolley:SetAlert({776, 777}, "watchstep", 2, 2)--1295886, 1295935
	end
	--If user has DBM bars enabled, we only want to register colors to the blizz api so that the blizz bars are also colorized.
	--If user has bars disabled, or we are in a bad state, onlyColor is false and we register countdowns as well.
	local onlyColor = not DBM.Options.HideDBMBars and not badStateDetected
	timerIceboundFlamesCD:SetTimeline(722, onlyColor)
	timerBlinkNovaCD:SetTimeline({723, 724, 737, 738}, onlyColor)
	timerMightyThudCD:SetTimeline(725, onlyColor)
	timerShellSpinCD:SetTimeline(726, onlyColor)
	timerThrowJunkCD:SetTimeline(727, onlyColor)
	timerFlingFishCD:SetTimeline(728, onlyColor)
	timerMushroomTossCD:SetTimeline(729, onlyColor)
	timerShreddingShardsCD:SetTimeline(768, onlyColor)
	timerFrostfireVolleyCD:SetTimeline({776, 777}, onlyColor)
	timerExplosiveSurpriseCD:SetTimeline(781, onlyColor)
end

function mod:OnLimitedCombatStart()
	self:EnableAlertOptions(1291390, 721, "stilldanger", 2)
	self:EnableAlertOptions(1292779, 783, "stilldanger", 4)
	badStateDetected = false
	self:TLCountReset()
	self:TLActiveEventReset()
	delayedStarts = {}
	pendingNormalStage = nil
	normalStage2Special32Count = 0
	normalStage4Special27Count = 0
	normalNext31IsIce = true
	self.vb.IceboundFlamesCount = 1
	self.vb.BlinkNovaCount = 1
	self.vb.MightyThudCount = 1
	self.vb.ShellSpinCount = 1
	self.vb.ThrowJunkCount = 1
	self.vb.FlingFishCount = 1
	self.vb.MushroomTossCount = 1
	self.vb.ShreddingShardsCount = 1
	self.vb.FrostfireVolleyCount = 1
	self.vb.ExplosiveSurpriseCount = 1
	--Normal is the only difficulty with a complete, fresh UNIT_FLAGS log. Heroic and Mythic use Blizzard fallback until equivalent logs are available.
	if DBM.Options.HardcodedTimer and self:IsNormal() and not badStateDetected then
		normalHardcodeActive = true
		self:SetStage(1)
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		)
		setFallback(self, true)
	else
		normalHardcodeActive = false
		setFallback(self)
	end
end


function mod:OnCombatEnd()
	self:TLCountReset()
	self:TLActiveEventReset()
	self:Unschedule()
	delayedStarts = {}
	pendingNormalStage = nil
	normalStage2Special32Count = 0
	normalStage4Special27Count = 0
	normalNext31IsIce = true
	normalHardcodeActive = false
	self:UnregisterShortTermEvents()
end

do
	---@param self DBMMod
	---@param eventID number
	local function startQueued(self, eventID)
		if badStateDetected then return end
		local entry = delayedStarts[eventID]
		if not entry then return end
		delayedStarts[eventID] = nil
		entry.timerObj:TLStart(entry.timerExact, eventID, self:TLCountStart(eventID, entry.eventType, entry.countKey))
	end

	---@param self DBMMod
	---@param timerObj any
	---@param timerExact number
	---@param eventID number
	---@param eventType string
	---@param countKey string
	local function queueStart(self, timerObj, timerExact, eventID, eventType, countKey)
		delayedStarts[eventID] = {
			timerObj = timerObj,
			timerExact = timerExact,
			eventType = eventType,
			countKey = countKey,
		}
		self:Schedule(1, startQueued, self, eventID)
	end

	---@param self DBMMod
	---@param reason string
	local function fallbackToBlizzard(self, reason)
		badStateDetected = true
		normalHardcodeActive = false
		self:ResumeBlizzardAPI()
		self:Unschedule()
		delayedStarts = {}
		self:UnregisterShortTermEvents()
		setFallback(self)
		DBM:Debug(reason, nil, nil, nil, true, true)
	end

	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersNormal(self, timer, timerExact, eventID)
		local handled = false
		local stage = self:GetStage()

		if pendingNormalStage == 4 and (timer == 7 or timer == 16) then
			self:SetStage(4)
			pendingNormalStage = nil
			normalStage4Special27Count = 0
			stage = 4
		elseif pendingNormalStage == 2 and (timer == 7 or timer == 3) then
			self:SetStage(2)
			pendingNormalStage = nil
			normalStage2Special32Count = 0
			stage = 2
		elseif pendingNormalStage == 3 and timer == 3 then
			self:SetStage(3)
			pendingNormalStage = nil
			stage = 3
		--The stage 1 Shell Spin opener can arrive before Final Ascension's later reset marker when returning from stage 4.
		elseif (stage == 4 and (timer == 18 or timer == 20 or timer == 60)) or (stage == 2 and (timer == 20 or timer == 60)) or stage == 3 and timer == 60 then
			self:SetStage(1)
			pendingNormalStage = nil
			normalNext31IsIce = true
			stage = 1
		end

		if stage == 1 then
			if timer == 30 then
				handled = true
				queueStart(self, timerShreddingShardsCD, timerExact, eventID, "shredding", "ShreddingShardsCount")
			elseif timer == 10 then
				handled = true
				queueStart(self, timerBlinkNovaCD, timerExact, eventID, "blink", "BlinkNovaCount")
			elseif timer == 18 or timer == 16 or timer == 15 then
				handled = true
				queueStart(self, timerShellSpinCD, timerExact, eventID, "shell", "ShellSpinCount")
			elseif timer == 60 then
				handled = true
			elseif timer == 20 or timer == 4 or timer == 23 then
				handled = true
				queueStart(self, timerThrowJunkCD, timerExact, eventID, "throwjunk", "ThrowJunkCount")
			elseif timer == 5 then
				handled = true
				normalNext31IsIce = true
				queueStart(self, timerIceboundFlamesCD, timerExact, eventID, "icebound", "IceboundFlamesCount")
			elseif timer == 31 then
				handled = true
				if normalNext31IsIce then
					normalNext31IsIce = false
					queueStart(self, timerIceboundFlamesCD, timerExact, eventID, "icebound", "IceboundFlamesCount")
				else
					normalNext31IsIce = true
					queueStart(self, timerBlinkNovaCD, timerExact, eventID, "blink", "BlinkNovaCount")
				end
			end
		elseif stage == 2 then
			if timer == 3 then
				handled = true
				queueStart(self, timerMushroomTossCD, timerExact, eventID, "mushroom", "MushroomTossCount")
			elseif timer == 27 or timer == 4 then
				handled = true
				queueStart(self, timerThrowJunkCD, timerExact, eventID, "throwjunk", "ThrowJunkCount")
			elseif timer == 13 then
				handled = true
				queueStart(self, timerExplosiveSurpriseCD, timerExact, eventID, "explosive", "ExplosiveSurpriseCount")
			elseif timer == 7 then
				handled = true
				queueStart(self, timerShellSpinCD, timerExact, eventID, "shell", "ShellSpinCount")
			elseif timer == 30 then
				handled = true
				queueStart(self, timerShreddingShardsCD, timerExact, eventID, "shredding", "ShreddingShardsCount")
			elseif timer == 2 or timer == 16 then
				handled = true
				queueStart(self, timerIceboundFlamesCD, timerExact, eventID, "icebound", "IceboundFlamesCount")
			elseif timer == 32 then
				handled = true
				normalStage2Special32Count = normalStage2Special32Count + 1
				if normalStage2Special32Count == 1 then
					queueStart(self, timerMushroomTossCD, timerExact, eventID, "mushroom", "MushroomTossCount")
				elseif normalStage2Special32Count == 2 then
					queueStart(self, timerShellSpinCD, timerExact, eventID, "shell", "ShellSpinCount")
				elseif normalStage2Special32Count == 3 then
					queueStart(self, timerExplosiveSurpriseCD, timerExact, eventID, "explosive", "ExplosiveSurpriseCount")
				elseif normalStage2Special32Count == 4 then
					queueStart(self, timerIceboundFlamesCD, timerExact, eventID, "icebound", "IceboundFlamesCount")
				else
					handled = false
				end
			end
		elseif stage == 3 then
			if timer == 3 or timer == 32 then
				handled = true
				queueStart(self, timerMightyThudCD, timerExact, eventID, "mighty", "MightyThudCount")
			elseif timer == 30 then
				handled = true
				queueStart(self, timerShreddingShardsCD, timerExact, eventID, "shredding", "ShreddingShardsCount")
			elseif timer == 11 or timer == 5 or timer == 22 then
				handled = true
				queueStart(self, timerIceboundFlamesCD, timerExact, eventID, "icebound", "IceboundFlamesCount")
			elseif timer == 20 or timer == 4 or timer == 27 then
				handled = true
				queueStart(self, timerThrowJunkCD, timerExact, eventID, "throwjunk", "ThrowJunkCount")
			end
		elseif stage == 4 then
			if timer == 16 then
				handled = true
				queueStart(self, timerShellSpinCD, timerExact, eventID, "shell", "ShellSpinCount")
			elseif timer == 7 then
				handled = true
				queueStart(self, timerThrowJunkCD, timerExact, eventID, "throwjunk", "ThrowJunkCount")
			elseif timer == 30 then
				handled = true
				queueStart(self, timerShreddingShardsCD, timerExact, eventID, "shredding", "ShreddingShardsCount")
			elseif timer == 21 then
				handled = true
				queueStart(self, timerBlinkNovaCD, timerExact, eventID, "blink", "BlinkNovaCount")
			elseif timer == 8 then
				handled = true
				queueStart(self, timerFrostfireVolleyCD, timerExact, eventID, "frostfire", "FrostfireVolleyCount")
			elseif timer == 2 or timer == 13 then
				handled = true
				queueStart(self, timerIceboundFlamesCD, timerExact, eventID, "icebound", "IceboundFlamesCount")
			elseif timer == 4 or timer == 23 then
				handled = true
				queueStart(self, timerThrowJunkCD, timerExact, eventID, "throwjunk", "ThrowJunkCount")
			elseif timer == 27 then
				handled = true
				normalStage4Special27Count = normalStage4Special27Count + 1
				if normalStage4Special27Count == 1 then
					queueStart(self, timerFrostfireVolleyCD, timerExact, eventID, "frostfire", "FrostfireVolleyCount")
				elseif normalStage4Special27Count == 2 then
					queueStart(self, timerIceboundFlamesCD, timerExact, eventID, "icebound", "IceboundFlamesCount")
				elseif normalStage4Special27Count == 3 then
					queueStart(self, timerShellSpinCD, timerExact, eventID, "shell", "ShellSpinCount")
				else
					handled = false
				end
			end
		end

		if not handled then
			fallbackToBlizzard(self, "|cffff0000Failed to match Normal encounter timeline events to expected timers, falling back to Blizzard API|r")
		end
	end

	function mod:UNIT_FLAGS(unit)
		if not normalHardcodeActive or not UnitIsFriend("player", unit) then return end
		if unit == "boss1" then
			pendingNormalStage = 2 -- Gebbo
		elseif unit == "boss3" then
			pendingNormalStage = 3 -- Nama
		elseif unit == "boss4" then
			pendingNormalStage = 4 -- Iku
		end
	end

	--Note, bar state changing and canceling is handled by core

	function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
		if eventInfo.source ~= 0 or not self:IsNormal() or badStateDetected then return end
		local eventID = eventInfo.id
		if C_EncounterTimeline.GetEventState(eventID) ~= 0 or not self:TLTrackActiveEvent(eventID) then return end
		local timerExact = eventInfo.duration
		timersNormal(self, math.floor(timerExact + 0.5), timerExact, eventID)
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		if not eventID then return end
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventState then return end
		if eventState >= 2 then
			self:TLReleaseActiveEvent(eventID)
		end
		local queued = delayedStarts[eventID]
		if eventState == 3 and queued then
			delayedStarts[eventID] = nil
			return
		end
		if eventState == 2 then
			local eventType, eventCount = self:TLCountFinish(eventID)
			if not eventType or not eventCount then return end
			if eventType == "icebound" then
				specWarnIceboundFlames:Show(eventCount)
				specWarnIceboundFlames:Play("kickcast")
			elseif eventType == "blink" then
				specWarnBlinkNova:Show(eventCount)
				specWarnBlinkNova:Play("justrun")
			elseif eventType == "mighty" then
				specWarnMightyThud:Show(eventCount)
				specWarnMightyThud:Play("soakincoming")
			elseif eventType == "shell" then
				specWarnShellSpin:Show(eventCount)
				specWarnShellSpin:Play("farfromline")
			elseif eventType == "throwjunk" then
				specWarnThrowJunk:Show(eventCount)
				specWarnThrowJunk:Play("watchstep")
			elseif eventType == "fling" then
				warnFlingFish:Show(eventCount)
			elseif eventType == "mushroom" then
				specWarnMushroomToss:Show(eventCount)
				specWarnMushroomToss:Play("watchstep")
			elseif eventType == "shredding" then
				if self:IsTank() then
					specWarnShreddingShards:Show()
					specWarnShreddingShards:Play("defensive")
				end
			elseif eventType == "frostfire" then
				specWarnFrostfireVolley:Show(eventCount)
				specWarnFrostfireVolley:Play("watchstep")
			elseif eventType == "explosive" then
				warnExplosiveSurprise:Show(eventCount)
			end
		elseif eventState == 3 then
			delayedStarts[eventID] = nil
			self:TLCountCancel(eventID)
		end
	end
end
