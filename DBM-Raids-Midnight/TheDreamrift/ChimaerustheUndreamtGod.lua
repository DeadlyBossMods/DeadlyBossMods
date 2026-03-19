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
local specWarnRavenousDive				= mod:NewSpecialWarningCount(1245404, nil, nil, nil, 2, 2)
local specWarnRiftEmergence				= mod:NewSpecialWarningCount(1251021, nil, nil, DBM_COMMON_L.ADDS, 2, 2)
local specWarnCausticPhlegm				= mod:NewSpecialWarningCount(1246621, nil, nil, nil, 2, 2)
local specWarnRendingTear				= mod:NewSpecialWarningDodgeCount(1272726, nil, nil, DBM_COMMON_L.FRONTAL, 2, 2)
local specWarnCorruptedDevastation		= mod:NewSpecialWarningDodgeCount(1245452, nil, 17088, nil, 2, 2)
local specWarnFearsomecry				= mod:NewSpecialWarningInterrupt(1249017, "HasInterrupt", nil, nil, 1, 2)--Add alert
local specWarnDiscordantRoar			= mod:NewSpecialWarningCount(1245451, false, nil, nil, 2, 2)--Add alert (evalulate default by cast frequency)
local specWarnAlndustUpheaval			= mod:NewSpecialWarningSoakCount(1262289, nil, nil, DBM_COMMON_L.GROUPSOAK, 2, 2)
local specWarnConsume					= mod:NewSpecialWarningCount(1245396, nil, nil, nil, 2, 2)
local specWarnCannibalized				= mod:NewSpecialWarningSpell(1245844, nil, nil, nil, 1, 2)--Basically screwing up the add killing
mod:GroupSpells(1245396, 1245844)--Group Cannibalized with Consume

local timerRavenousDiveCD				= mod:NewCDCountTimer(20.5, 1245404, nil, nil, nil, 6)--Stage 1 bar
local timerRiftEmergenceCD				= mod:NewCDCountTimer(20.5, 1251021, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1)
local timerCausticPhlegmCD				= mod:NewCDCountTimer(20.5, 1246621, DBM_COMMON_L.AOEDAMAGE.." (%s)", nil, nil, 2)
local timerRendingTearCD				= mod:NewCDCountTimer(20.5, 1272726, DBM_COMMON_L.FRONTAL.." (%s)", nil, nil, 3)
local timerCorruptedDevastationCD		= mod:NewCDCountTimer(20.5, 1245452, 17088, nil, nil, 3)--Shortname Breath
--local timerFearsomecryCD				= mod:NewCDCountTimer(20.5, 1249017, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerConsumingMiasmaCD			= mod:NewCDCountTimer(20.5, 1257087, DBM_COMMON_L.DISPELS.." (%s)", nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)--Heroic+Mythic only
local timerAlndustUpheavalCD			= mod:NewCDCountTimer(20.5, 1262289, DBM_COMMON_L.GROUPSOAK.." (%s)", nil, nil, 5)
local timerRiftCataclysmCD				= mod:NewCDCountTimer(20.5, 1260088, 47008, nil, nil, 6)--12min berserk
local timerRiftMadnessCD				= mod:NewNextTimer(20.5, 1264780, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)--Mythic Only
local timerConsumeCD					= mod:NewCDCountTimer(20.5, 1245396, nil, nil, nil, 6)--Stage 2 bar

mod:AddPrivateAuraSoundOption(1272726, true, 1272726, 1, 1)--Rending Tear
mod:AddPrivateAuraSoundOption(1257087, true, 1257087, 1, 1)--Consuming Miasma
mod:AddPrivateAuraSoundOption(1245698, true, 1262289, 1, 2)--Alnsight (can also use https://www.wowhead.com/spell=1253744/rift-vulnerability)
mod:AddPrivateAuraSoundOption(1264756, true, 1264780, 1, 1)--Rift Madness (initial target)
--mod:AddPrivateAuraSoundOption(1264780, true, 1264780, 1, 1)--Rift Madness (standing in the soak?)
--https://www.wowhead.com/beta/spell=1264757/rift-madness another rift madness, not sure what to include yet beyond initial
mod:AddPrivateAuraSoundOption(1258192, false, 1258192, 1, 1)--Lingering Miasma
mod:AddPrivateAuraSoundOption(1265940, true, 1249017, 1, 1)--Fearsome Cry
mod:AddPrivateAuraSoundOption(1250953, false, 1250953, 1, 1)--Rift Sickness

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
local cachedEventIDs = {}

function mod:OnLimitedCombatStart()
	table.wipe(cachedEventIDs)
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
	--Hardcode features first
	if self:IsEasy() and not badStateDetected then
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		)
	else
		--Blizz API fallbacks
		specWarnRavenousDive:SetAlert(48, "phasechange", 2, 3, 0)
		timerRavenousDiveCD:SetTimeline(48)
		specWarnRiftEmergence:SetAlert(49, "mobsoon", 2, 2)
		timerRiftEmergenceCD:SetTimeline(49)
		specWarnCausticPhlegm:SetAlert(50, "aesoon", 2, 2)
		timerCausticPhlegmCD:SetTimeline(50)
		specWarnRendingTear:SetAlert(51, "frontal", 15, 2)
		timerRendingTearCD:SetTimeline(51)
		specWarnCorruptedDevastation:SetAlert({53,458}, "breathsoon", 2, 2, 0)
		timerCorruptedDevastationCD:SetTimeline({53,458})
		specWarnFearsomecry:SetAlert(117, "kickcast", 1, 2, 0)--Needs vetting, it's an add ability but has event Id, so it might fire an ECOUNTER_WARNING based on blizz set conditionals
		specWarnDiscordantRoar:SetAlert(118, "aesoon", 2, 2, 0)--^
		timerConsumingMiasmaCD:SetTimeline(119)
		specWarnAlndustUpheaval:SetAlert({149,431}, "soakincoming", 19, 2)--Can't count casts with blizz API, but hardcode will be able to use group1 and group 2 soak sounds
		timerAlndustUpheavalCD:SetTimeline({149,431})
		timerRiftCataclysmCD:SetTimeline(170)
		timerRiftMadnessCD:SetTimeline(217)
		specWarnConsume:SetAlert(307, "phasechange", 2, 3)
		timerConsumeCD:SetTimeline(307)
		specWarnCannibalized:SetAlert(555, "stilldanger", 1, 2, 0)
	end
	self:EnablePrivateAuraSound(1272726, "bleedyou", 19)
	self:EnablePrivateAuraSound(1257087, "movetopool", 15)
	self:EnablePrivateAuraSound(1245698, "riftyou", 19)
	self:EnablePrivateAuraSound(1264756, "debuffyou", 17)--TODO, better custom voice?
--	self:EnablePrivateAuraSound(1264780, "debuffyou", 17)
	self:EnablePrivateAuraSound(1258192, "dotyou", 19)
	self:EnablePrivateAuraSound(1265940, "fearyou", 19)
	self:EnablePrivateAuraSound(1250953, "absorbyou", 19)
end

function mod:OnCombatEnd()
	table.wipe(cachedEventIDs)
	self:UnregisterShortTermEvents()
end

do
	local function timersEasy(self, timer, eventID)
		if timer == 720 then--Rift Cataclysm
			timerRiftCataclysmCD:TLStart(timer, eventID)
		elseif timer == 72 then--Consume (unambiguous)
			sawPhlegm53 = false
			timerConsumeCD:TLStart(timer, eventID, self.vb.consumeCount)
			cachedEventIDs[eventID] = "consume"
		elseif timer == 80 then--Can be Rending Tear or Consume, disambiguate by observed sequence anchor (53s Phlegm)
			if sawPhlegm53 then
				timerConsumeCD:TLStart(timer, eventID, self.vb.consumeCount)
				sawPhlegm53 = false
				cachedEventIDs[eventID] = "consume"
			else
				timerRendingTearCD:TLStart(timer, eventID, self.vb.tearCount)
				cachedEventIDs[eventID] = "tear"
			end
		elseif timer == 7 or timer == 82 then--Rift Emergence
			timerRiftEmergenceCD:TLStart(timer, eventID, self.vb.riftCount)
			cachedEventIDs[eventID] = "rift"
		elseif timer == 3 or timer == 18 or timer == 24 or timer == 26 or timer == 29 or timer == 53 then--Caustic Phlegm
			timerCausticPhlegmCD:TLStart(timer, eventID, self.vb.phlegmCount)
			if timer == 53 then
				sawPhlegm53 = true
			end
			cachedEventIDs[eventID] = "phlegm"
		elseif timer == 40 then--Rending Tear
			timerRendingTearCD:TLStart(timer, eventID, self.vb.tearCount)
			cachedEventIDs[eventID] = "tear"
		elseif timer == 16 or timer == 81 then--Alndust Upheaval
			timerAlndustUpheavalCD:TLStart(timer, eventID, self.vb.upheavalCount)
			cachedEventIDs[eventID] = "upheaval"
		elseif timer == 8 then--Corrupted Devastation opener before mixed 12s
			timerCorruptedDevastationCD:TLStart(timer, eventID, self.vb.devastationCount)
			next12IsDevastation = true
			cachedEventIDs[eventID] = "devastation"
		elseif timer == 12 then--Can be Corrupted Devastation or Caustic Phlegm
			if next12IsDevastation then
				timerCorruptedDevastationCD:TLStart(timer, eventID, self.vb.devastationCount)
				next12IsDevastation = false
				cachedEventIDs[eventID] = "devastation"
			else
				timerCausticPhlegmCD:TLStart(timer, eventID, self.vb.phlegmCount)
				next12IsDevastation = true
				cachedEventIDs[eventID] = "phlegm"
			end
		elseif timer == 30 or timer == 1 then--Ravenous Dive
			timerRavenousDiveCD:TLStart(timer, eventID, self.vb.diveCount)
			cachedEventIDs[eventID] = "dive"
		elseif timer == 165 or timer == 10 then--Stage Two markers
			--Used by blizzard as phase markers, but not represented as bars in DBM yet.
			if timer == 10 then--Hard reset marker for phase transition
				self.vb.diveCount = 1
				self.vb.riftCount = 1
				self.vb.phlegmCount = 1
				self.vb.tearCount = 1
				self.vb.devastationCount = 1
				self.vb.upheavalCount = 1
				self.vb.consumeCount = 1
				--self.vb.riftMadnessCount = 1--Unused on Normal/LFR
				--self.vb.miasmaCount = 1--Unused on Normal/LFR
				sawPhlegm53 = false
				next12IsDevastation = false
			end
			return
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
			if eventType then
				if eventType == "consume" then
					self.vb.consumeCount = self.vb.consumeCount + 1
					specWarnConsume:Show(self.vb.consumeCount)
					specWarnConsume:Play("phasechange")
				elseif eventType == "tear" then
					self.vb.tearCount = self.vb.tearCount + 1
					specWarnRendingTear:Show(self.vb.tearCount)
					specWarnRendingTear:Play("frontal")
				elseif eventType == "rift" then
					self.vb.riftCount = self.vb.riftCount + 1
					specWarnRiftEmergence:Show(self.vb.riftCount)
					specWarnRiftEmergence:Play("mobsoon")
				elseif eventType == "phlegm" then
					self.vb.phlegmCount = self.vb.phlegmCount + 1
					specWarnCausticPhlegm:Show(self.vb.phlegmCount)
					specWarnCausticPhlegm:Play("aesoon")
				elseif eventType == "upheaval" then
					self.vb.upheavalCount = self.vb.upheavalCount + 1
					specWarnAlndustUpheaval:Show(self.vb.upheavalCount)
					specWarnAlndustUpheaval:Play("soakincoming")
				elseif eventType == "devastation" then
					self.vb.devastationCount = self.vb.devastationCount + 1
					specWarnCorruptedDevastation:Show(self.vb.devastationCount)
					specWarnCorruptedDevastation:Play("breathsoon")
				elseif eventType == "dive" then
					self.vb.diveCount = self.vb.diveCount + 1
					specWarnRavenousDive:Show(self.vb.diveCount)
					specWarnRavenousDive:Play("phasechange")
				end
				cachedEventIDs[eventID] = nil
			end
		elseif eventState == 3 then
			cachedEventIDs[eventID] = nil
		end
	end
end
