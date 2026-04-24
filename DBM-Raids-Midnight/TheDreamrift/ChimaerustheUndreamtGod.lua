local mod	= DBM:NewMod(2795, "DBM-Raids-Midnight", 2, 1314)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(256116)
mod:SetEncounterID(3306)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2939)

mod:RegisterCombat("combat")

--NOTE, https://www.wowhead.com/spell=1245771/corrupted-feathers has event ID ono boss but isn't in journal, possibly pre boss trash mechanic
--NOTE, https://www.wowhead.com/spell=1262616/retched-acid not in journal (208)
--NOTE, https://www.wowhead.com/spell=1280127/stage-two also exists, but based on most recent testing blizzard uses consume for p2 and not this bar anymore
local warnAlndustUpheaval				= mod:NewBlizzTargetAnnounce(1262289, 2)

local specWarnRavenousDive				= mod:NewSpecialWarningCount(1245404, nil, 218027, nil, 2, 2)
local specWarnRiftEmergence				= mod:NewSpecialWarningCount(1251021, nil, nil, DBM_COMMON_L.ADDS, 2, 2)
local specWarnCausticPhlegm				= mod:NewSpecialWarningCount(1246621, nil, nil, DBM_COMMON_L.AOEDAMAGE, 2, 2)
local specWarnRendingTear				= mod:NewSpecialWarningDodgeCount(1272726, nil, nil, DBM_COMMON_L.FRONTAL, 2, 2)
local specWarnCorruptedDevastation		= mod:NewSpecialWarningDodgeCount(1245452, nil, 17088, nil, 2, 2)
local specWarnFearsomecry				= mod:NewSpecialWarningInterrupt(1249017, "HasInterrupt", nil, nil, 1, 2)--Add alert
local specWarnDiscordantRoar			= mod:NewSpecialWarningCount(1245451, false, nil, nil, 2, 2)--Add alert (evalulate default by cast frequency)
local specWarnAlndustUpheaval			= mod:NewSpecialWarningSoakCount(1262289, nil, nil, DBM_COMMON_L.GROUPSOAK, 2, 2)
local specWarnConsume					= mod:NewSpecialWarningCount(1245396, nil, nil, nil, 2, 2)
local specWarnCannibalized				= mod:NewSpecialWarningSpell(1245844, nil, nil, nil, 1, 2)--Basically screwing up the add killing
mod:GroupSpells(1245396, 1245844)--Group Cannibalized with Consume

local timerRavenousDiveCD				= mod:NewCDCountTimer(20.5, 1245404, 218027, nil, nil, 6)--Stage 1 bar, shortname "Dive"
local timerRiftEmergenceCD				= mod:NewCDCountTimer(20.5, 1251021, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1)
local timerCausticPhlegmCD				= mod:NewCDCountTimer(20.5, 1246621, DBM_COMMON_L.AOEDAMAGE.." (%s)", nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerRendingTearCD				= mod:NewCDCountTimer(20.5, 1272726, DBM_COMMON_L.FRONTAL.." (%s)", nil, nil, 3, nil, DBM_COMMON_L.BLEED_ICON)
local timerCorruptedDevastationCD		= mod:NewCDCountTimer(20.5, 1245452, 17088, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--Shortname Breath
--local timerFearsomecryCD				= mod:NewCDCountTimer(20.5, 1249017, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerConsumingMiasmaCD			= mod:NewCDCountTimer(20.5, 1257087, DBM_COMMON_L.DISPELS.." (%s)", nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)--Heroic+Mythic only
local timerAlndustUpheavalCD			= mod:NewCDCountTimer(20.5, 1262289, DBM_COMMON_L.GROUPSOAK.." (%s)", nil, nil, 5, nil, DBM_COMMON_L.IMPORTANT_ICON)
local timerRiftMadnessCD				= mod:NewNextTimer(20.5, 1264780, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)--Mythic Only
local timerConsumeCD					= mod:NewCDCountTimer(20.5, 1245396, nil, nil, 2, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerStage2CD						= mod:NewCDTimer(20.5, 1280127, nil, nil, nil, 6)--Hardcoded stage 2 timer for when blizz doesn't provide consume timers in stage 2, or provides them with wrong timers. Will be removed if blizz provides accurate consume timers in stage 2
local timerBerserkCD					= mod:NewBerserkTimer(600)

mod:AddPrivateAuraSoundOption(1272726, true, 1272726, 1, 1, "bleedyou", 19)--Rending Tear
mod:AddPrivateAuraSoundOption(1257087, true, 1257087, 1, 1, "movetopool", 15)--Consuming Miasma
mod:AddPrivateAuraSoundOption(1245698, true, 1262289, 1, 2, "riftyou", 19)--Alnsight (can also use https://www.wowhead.com/spell=1253744/rift-vulnerability)
mod:AddPrivateAuraSoundOption(1264756, true, 1264780, 1, 1, "debuffyou", 17)--Rift Madness (initial target)
--mod:AddPrivateAuraSoundOption(1264780, true, 1264780, 1, 1)--Rift Madness (standing in the soak?)
--https://www.wowhead.com/beta/spell=1264757/rift-madness another rift madness, not sure what to include yet beyond initial
mod:AddPrivateAuraSoundOption(1258192, false, 1258192, 1, 1, "dotyou", 19)--Lingering Miasma
mod:AddPrivateAuraSoundOption(1265940, true, 1249017, 1, 1, "fearyou", 19)--Fearsome Cry
mod:AddPrivateAuraSoundOption(1250953, false, 1250953, 1, 1, "absorbyou", 19)--Rift Sickness

mod.vb.diveCount = 0
mod.vb.riftCount = 0
mod.vb.phlegmCount = 0
mod.vb.tearCount = 0
mod.vb.devastationCount = 0
mod.vb.miasmaCount = 0
mod.vb.upheavalCount = 0
mod.vb.riftMadnessCount = 0
mod.vb.consumeCount = 0
local badStateDetected = false
local sawPhlegm53 = false
local next12IsDevastation = false
local diveEventID = 0
local diveEventCount = 0
local diveExpireAt = 0
local diveFallbackToken = 0
local showOnNextWarning = 0
local timer73Count = 0
local timer75Count = 0

---@param self DBMMod
	---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		specWarnRavenousDive:SetAlert(48, "phasechange", 2, 3, 0)
		specWarnRiftEmergence:SetAlert(49, "mobsoon", 2, 2)
		specWarnCausticPhlegm:SetAlert(50, "aesoon", 2, 2)
		specWarnRendingTear:SetAlert(51, "frontal", 15, 2)
		specWarnCorruptedDevastation:SetAlert({53,458}, "breathsoon", 2, 2, 0)
		specWarnFearsomecry:SetAlert(117, "kickcast", 1, 2, 0)--Needs vetting, it's an add ability but has event Id, so it might fire an ECOUNTER_WARNING based on blizz set conditionals
		specWarnDiscordantRoar:SetAlert(118, "aesoon", 2, 2, 0)--^
		specWarnAlndustUpheaval:SetAlert({149,431}, "soakincoming", 19, 2)--Can't count casts with blizz API, but hardcode will be able to use group1 and group 2 soak sounds
		specWarnConsume:SetAlert(307, "aesoon", 2, 3)
		specWarnCannibalized:SetAlert(555, "stilldanger", 1, 2, 0)
	end
	timerRavenousDiveCD:SetTimeline(48)
	timerRiftEmergenceCD:SetTimeline(49)
	timerCausticPhlegmCD:SetTimeline(50)
	timerRendingTearCD:SetTimeline(51)
	timerCorruptedDevastationCD:SetTimeline({53,458})
	timerConsumingMiasmaCD:SetTimeline(119)
	timerAlndustUpheavalCD:SetTimeline({149,431})
	timerBerserkCD:SetTimeline(170)
	timerRiftMadnessCD:SetTimeline(217)
	timerConsumeCD:SetTimeline(307)
	timerStage2CD:SetTimeline(353)
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
	self.vb.diveCount = 1
	self.vb.riftCount = 1
	self.vb.phlegmCount = 1
	self.vb.tearCount = 1
	self.vb.devastationCount = 1
	self.vb.miasmaCount = 1
	self.vb.upheavalCount = 1
	self.vb.riftMadnessCount = 1
	self.vb.consumeCount = 1
	sawPhlegm53 = false
	next12IsDevastation = false
	diveEventID = 0
	diveEventCount = 0
	diveExpireAt = 0
	diveFallbackToken = diveFallbackToken + 1
	showOnNextWarning = 0
	timer73Count = 0
	timer75Count = 0
	--Hardcode features first
	if DBM.Options.HardcodedTimer and (self:IsEasy() or self:IsHeroic() or self:IsMythic()) and not badStateDetected then
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED",
			"ENCOUNTER_WARNING"
		)
		if DBM.Options.HideDBMBars then
			setFallback(self, true)
		end
	else
		setFallback(self)
	end
--	self:EnablePrivateAuraSound(1264780, "debuffyou", 17)
end

function mod:OnCombatEnd()
	self:TLCountReset()
	diveEventID = 0
	diveEventCount = 0
	diveExpireAt = 0
	diveFallbackToken = diveFallbackToken + 1
	self:UnregisterShortTermEvents()
end

do
	local function phaseReset(self)
		self:TLCountReset()
--		self.vb.diveCount = 1--NOT reset, because dive is phase change ending
		self.vb.riftCount = 1
		self.vb.phlegmCount = 1
		self.vb.tearCount = 1
		self.vb.devastationCount = 1
		self.vb.upheavalCount = 1
		self.vb.consumeCount = 1
		self.vb.riftMadnessCount = 1--Unused on Normal/LFR
		self.vb.miasmaCount = 1--Used on Heroic+
		sawPhlegm53 = false
		next12IsDevastation = false
		diveEventID = 0
		diveEventCount = 0
		diveExpireAt = 0
		diveFallbackToken = diveFallbackToken + 1
		timer73Count = 0
		timer75Count = 0
	end
	---@param self DBMMod
	---@param eventCount number
	local function handleDiveTransition(self, eventCount)
		specWarnRavenousDive:Show(eventCount)
		specWarnRavenousDive:Play("phasechange")
		phaseReset(self)--Phase transition ends, reset all timers
		DBM:Debug("Phase reset applied by Ravenous Dive", nil, nil, nil, true)
	end
	---@param self DBMMod
	---@param token number
	---@param eventCount number
	local function finishPendingDive(self, token, eventCount)
		if token ~= diveFallbackToken then return end
		handleDiveTransition(self, eventCount)
	end
	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function startDiveTimer(self, timer, timerExact, eventID)
		--Blizzard can end add phase in two ways: let the base dive bar expire naturally (30 non-Mythic/20 Mythic)
		--or cancel it early and replace it with a 1s dive. In some logs the active dive only reaches state 3 very
		--near expiry, so we track whichever dive event is currently active and let STATE_CHANGED apply a tiny fallback.
		local eventCount = self:TLCountStart(eventID, "dive", "diveCount") or self.vb.diveCount
		timerRavenousDiveCD:Stop()
		timerRavenousDiveCD:TLStart(timerExact, eventID, eventCount)
		diveEventID = eventID
		diveEventCount = eventCount
		diveExpireAt = GetTime() + timerExact
		diveFallbackToken = diveFallbackToken + 1
	end
	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersEasy(self, timer, timerExact, eventID)
		--Logic confirmed against normal and LFR
		if timer == 720 then--Rift Cataclysm
			timerBerserkCD:Start(timer)
		elseif timer == 72 then--Consume (unambiguous)
			sawPhlegm53 = false
			timerConsumeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "consume", "consumeCount"))
		elseif timer == 80 then--Can be Rending Tear or Consume, disambiguate by observed sequence anchor (53s Phlegm)
			if sawPhlegm53 then
				timerConsumeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "consume", "consumeCount"))
				sawPhlegm53 = false
			else
				timerRendingTearCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "tear", "tearCount"))
			end
		elseif timer == 7 or timer == 82 then--Rift Emergence
			timerRiftEmergenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rift", "riftCount"))
		elseif timer == 3 or timer == 18 or timer == 24 or timer == 26 or timer == 29 or timer == 53 then--Caustic Phlegm
			if timer == 18 then--Bugged air phase timer, ignore
				DBM:Debug("Encounter timeline has a known incorrect timer for Caustic Phlegm at 18 seconds, ignoring this timer", nil, nil, nil, true)
			else
				timerCausticPhlegmCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "phlegm", "phlegmCount"))
				if timer == 53 then
					sawPhlegm53 = true
				end
			end
		elseif timer == 40 then--Rending Tear
			timerRendingTearCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "tear", "tearCount"))
		elseif timer == 16 or timer == 81 then--Alndust Upheaval
			timerAlndustUpheavalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "upheaval", "upheavalCount"))
		elseif timer == 8 then--Corrupted Devastation opener before mixed 12s
			timerCorruptedDevastationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "devastation", "devastationCount"))
			next12IsDevastation = true
		elseif timer == 12 then--Can be Corrupted Devastation or Caustic Phlegm
			if next12IsDevastation then
				timerCorruptedDevastationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "devastation", "devastationCount"))
				next12IsDevastation = false
			else
				timerCausticPhlegmCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "phlegm", "phlegmCount"))
				next12IsDevastation = true
			end
		elseif timer == 2 then
			timerCorruptedDevastationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "devastation", "devastationCount"))
			next12IsDevastation = false
		elseif timer == 30 or timer == 1 then--Ravenous Dive
			--30 is max time, but when all adds die, 30 is canceled and replaced with 1 second timer
			startDiveTimer(self, timer, timerExact, eventID)
		elseif timer == 165 or timer == 10 then--Stage Two markers
			--Used by blizzard as phase markers
			timerStage2CD:Stop()
			timerStage2CD:TLStart(timerExact, eventID)
		else--Reached end of chain without finding a valid timer, this means hardcode mod has failed, so we need to disable hardcoded features and fall back to blizz API
			if not DBM.Options.DebugMode then
				badStateDetected = true
				self:ResumeBlizzardAPI()
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			else
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
			end
		end
	end
	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersHeroic(self, timer, timerExact, eventID)
		--Logic confirmed against Heroic Week 2
		--Timers seem to basically be same as normal +10% haste
		--With the exception of some static that remained same
		if timer == 720 then--Rift Cataclysm
			timerBerserkCD:Start(timer)
		elseif timer == 65 then--Consume (unambiguous opener)
			timerConsumeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "consume", "consumeCount"))
		elseif timer == 36 then--Rending Tear (unambiguous opener)
			timerRendingTearCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "tear", "tearCount"))
		elseif timer == 151 then--Stage Two (phase 1)
			timerStage2CD:Stop()
			timerStage2CD:TLStart(timerExact, eventID)
		elseif timer == 14 then--Alndust Upheaval (unambiguous opener)
			timerAlndustUpheavalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "upheaval", "upheavalCount"))
		elseif timer == 6 then--Rift Emergence (unambiguous opener)
			timerRiftEmergenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rift", "riftCount"))
		elseif timer == 32 then--Consuming Miasma (phase 1 opener)
			timerConsumingMiasmaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "miasma", "miasmaCount"))
		elseif timer == 75 then--Can be Rift Emergence reload (odd) or Consume reload (even) per phase
			timer75Count = timer75Count + 1
			if timer75Count % 2 == 1 then--Odd: Rift Emergence
				timerRiftEmergenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rift", "riftCount"))
			else--Even: Consume
				timerConsumeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "consume", "consumeCount"))
			end
		elseif timer == 73 then--Can be Alndust Upheaval reload (odd) or Rending Tear reload (even) per phase
			timer73Count = timer73Count + 1
			if timer73Count % 2 == 1 then--Odd: Alndust Upheaval
				timerAlndustUpheavalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "upheaval", "upheavalCount"))
			else--Even: Rending Tear
				timerRendingTearCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "tear", "tearCount"))
			end
		elseif timer == 24 or timer == 26 or timer == 48 or timer == 22 or timer == 3 then--Caustic Phlegm (unambiguous)
			timerCausticPhlegmCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "phlegm", "phlegmCount"))
		elseif timer == 18 then--Bugged air phase timer, ignore
			DBM:Debug("Encounter timeline has a known incorrect timer for Caustic Phlegm at 18 seconds, ignoring this timer", nil, nil, nil, true)
		elseif timer == 50 or timer == 35 or timer == 29 or timer == 23 then--Consuming Miasma (phase 1 reloads and phase 2)
			timerConsumingMiasmaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "miasma", "miasmaCount"))
		elseif timer == 8 then--Corrupted Devastation opener before mixed 12s
			timerCorruptedDevastationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "devastation", "devastationCount"))
			next12IsDevastation = true
		elseif timer == 12 then--Can be Corrupted Devastation or Caustic Phlegm (same alternating pattern as Normal)
			if next12IsDevastation then
				timerCorruptedDevastationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "devastation", "devastationCount"))
				next12IsDevastation = false
			else
				timerCausticPhlegmCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "phlegm", "phlegmCount"))
				next12IsDevastation = true
			end
		elseif timer == 2 then
			timerCorruptedDevastationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "devastation", "devastationCount"))
			next12IsDevastation = false
		elseif timer == 30 or timer == 1 then--Ravenous Dive (30s max, 1s early-kill replacement when adds die early)
			startDiveTimer(self, timer, timerExact, eventID)
		elseif timer == 10 then--Stage Two (phase 2 transition marker)
			timerStage2CD:Stop()
			timerStage2CD:TLStart(timerExact, eventID)
		else--Reached end of chain without finding a valid timer
			if not DBM.Options.DebugMode then
				badStateDetected = true
								self:ResumeBlizzardAPI()
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			else
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
			end
		end
	end
	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersMythic(self, timer, timerExact, eventID)
		--Logic confirmed against Mythic Week 3
		if timer == 510 then--Rift Cataclysm
			timerBerserkCD:Start(timer)
		elseif timer == 65 then--Consume opener
			timerConsumeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "consume", "consumeCount"))
		elseif timer == 36 then--Rending Tear opener
			timerRendingTearCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "tear", "tearCount"))
		elseif timer == 148 then--Stage Two marker
			timerStage2CD:Stop()
			timerStage2CD:TLStart(timerExact, eventID)
		elseif timer == 14 then--Alndust Upheaval opener, later reused by Corrupted Devastation
			if self.vb.upheavalCount == 1 then
				timerAlndustUpheavalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "upheaval", "upheavalCount"))
			else
				timerCorruptedDevastationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "devastation", "devastationCount"))
				next12IsDevastation = true
			end
		elseif timer == 6 then--Rift Emergence opener
			timerRiftEmergenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rift", "riftCount"))
		elseif timer == 32 or timer == 51 or timer == 37 or timer == 29 or timer == 23 then--Consuming Miasma
			timerConsumingMiasmaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "miasma", "miasmaCount"))
		elseif timer == 39 then--Rift Madness opener
			timerRiftMadnessCD:TLStart(timerExact, eventID)
			self:TLCountStart(eventID, "riftMadness", "riftMadnessCount")
		elseif timer == 75 then--Rift Emergence reload
			timerRiftEmergenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rift", "riftCount"))
		elseif timer == 73 then--Alndust Upheaval, Rending Tear, Rift Madness (in order)
			timer73Count = timer73Count + 1
			if timer73Count % 3 == 1 then
				timerAlndustUpheavalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "upheaval", "upheavalCount"))
			elseif timer73Count % 3 == 2 then
				timerRendingTearCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "tear", "tearCount"))
			else
				timerRiftMadnessCD:TLStart(timerExact, eventID)
				self:TLCountStart(eventID, "riftMadness", "riftMadnessCount")
			end
		elseif timer == 24 or timer == 26 or timer == 48 or timer == 18 or timer == 9 then--Caustic Phlegm
			if timer ~= 9 then--Invalid timer blizzard sends that we need to outright ignore
				timerCausticPhlegmCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "phlegm", "phlegmCount"))
			end
		elseif timer == 72 then--Consume reload
			timerConsumeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "consume", "consumeCount"))
		elseif timer == 10 then--Alndust Upheaval phase 2
			timerAlndustUpheavalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "upheaval", "upheavalCount"))
		elseif timer == 12 then--Corrupted Devastation/Caustic Phlegm alternating pair
			if next12IsDevastation then
				timerCorruptedDevastationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "devastation", "devastationCount"))
				next12IsDevastation = false
			else
				timerCausticPhlegmCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "phlegm", "phlegmCount"))
				next12IsDevastation = true
			end
		elseif timer == 2 then
			timerCorruptedDevastationCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "devastation", "devastationCount"))
			next12IsDevastation = false
		elseif timer == 20 or timer == 1 then--Ravenous Dive (20s base on Mythic, 1s when adds die early)
			startDiveTimer(self, timer, timerExact, eventID)
		else--Reached end of chain without finding a valid timer
			if not DBM.Options.DebugMode then
				badStateDetected = true
								self:ResumeBlizzardAPI()
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			else
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
			end
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
			elseif self:IsHeroic() then
				timersHeroic(self, timer, timerExact, eventID)
			elseif self:IsMythic() then
				timersMythic(self, timer, timerExact, eventID)
			end
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		if eventState == 2 then
			local eventType, eventCount = self:TLCountFinish(eventID)
			if eventType and eventCount then
				if eventType == "consume" then
					specWarnConsume:Show(eventCount)
					specWarnConsume:Play("aesoon")
				elseif eventType == "tear" then
					specWarnRendingTear:Show(eventCount)
					specWarnRendingTear:Play("frontal")
				elseif eventType == "rift" then
					specWarnRiftEmergence:Show(eventCount)
					specWarnRiftEmergence:Play("mobsoon")
				elseif eventType == "phlegm" then
					specWarnCausticPhlegm:Show(eventCount)
					specWarnCausticPhlegm:Play("aesoon")
				elseif eventType == "upheaval" then
					specWarnAlndustUpheaval:Show(eventCount)
					if self:IsLFR() then
						--LFR has no soak
						specWarnAlndustUpheaval:Play("raidsplit")
					else
						showOnNextWarning = eventCount
						specWarnAlndustUpheaval:Play("soakincoming")
					end
					--We timestamp this then let local ENCOUNTER_WARNING event handle it
				elseif eventType == "devastation" then
					specWarnCorruptedDevastation:Show(eventCount)
					specWarnCorruptedDevastation:Play("breathsoon")
				elseif eventType == "dive" then
					diveEventID = 0
					diveEventCount = 0
					diveExpireAt = 0
					diveFallbackToken = diveFallbackToken + 1
					handleDiveTransition(self, eventCount)
				end
			end
		elseif eventState == 3 then
			if eventID == diveEventID and diveEventCount > 0 and diveExpireAt > 0 and GetTime() >= (diveExpireAt - 0.3) then
				local eventType = self:TLCountCancel(eventID)
				if eventType == "dive" then
					diveEventID = 0
					diveExpireAt = 0
					diveFallbackToken = diveFallbackToken + 1
					self:Schedule(0.2, finishPendingDive, self, diveFallbackToken, diveEventCount)
					return
				end
			end
			if eventID == diveEventID then
				diveEventID = 0
				diveEventCount = 0
				diveExpireAt = 0
				diveFallbackToken = diveFallbackToken + 1
			end
			self:TLCountCancel(eventID)
		end
	end
end

function mod:ENCOUNTER_WARNING(encounterWarningInfo)
	if showOnNextWarning > 0 then
		--Secrets
		local targetName = encounterWarningInfo.targetName
		local targetGUID = encounterWarningInfo.targetGUID
		local formattedTargetName = targetName or UNKNOWN
		if targetGUID then
			local _, className = GetPlayerInfoByGUID(targetGUID)
			if className then
				local classColor = C_ClassColor.GetClassColor(className)
				if classColor then
				    formattedTargetName = classColor:WrapTextInColorCode(formattedTargetName);
				end
			end
		end
		warnAlndustUpheaval:Show(showOnNextWarning, formattedTargetName)
		showOnNextWarning = 0
	end
end
