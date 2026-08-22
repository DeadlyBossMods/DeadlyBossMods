local mod	= DBM:NewMod(2887, "DBM-Raids-Midnight", 1, 1320)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(257368, 257361)
mod:SetEncounterID(3421)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(3004)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

--TODO, threat checks to warn appropriate tanks of tank mechanics
--TODO, inconsistencies on what Coiling Toxin does. Figure out good audio for it once clearer
--TODO, are progeny killed? how many swap if they are?
--TODO, does blood torrent go on current tank or random target?
--NOTE, https://www.wowhead.com/ptr/spell=1294921/flood has encounter event ID of 741 but doesn't exist in journal
DBM:RegisterAltSpellName(1294293, DBM_COMMON_L.FRONTAL)--Surge --> Frontal
DBM:RegisterAltSpellName(1289192, DBM_COMMON_L.TANK .. " " .. DBM_COMMON_L.LASER)--Caustic Deluge --> Tank Laser
DBM:RegisterAltSpellName(1288484, DBM_COMMON_L.TANK .. " " .. DBM_COMMON_L.GROUPSOAK)--Stone Breaker --> Tank Soak
DBM:RegisterAltSpellName(1290956, DBM_COMMON_L.WAVES)--Stir the Depths --> Waves
DBM:RegisterAltSpellName(1290516, DBM_COMMON_L.GROUPSOAK)--Ravenous Feast --> Group Soak
DBM:RegisterAltSpellName(1303230, DBM_COMMON_L.HEALABSORBS)--Blood Torrent --> Heal Absorbs
local specWarnCausticDeluge				= mod:NewSpecialWarningBlizzYou(1289192, nil, nil, nil, 1, 2, nil, nil, "defensive")
local specWarnStoneBreaker				= mod:NewSpecialWarningSoakCount(1288484, nil, nil, nil, 1, 2, nil, nil, "helpsoak")
local specWarnSurge						= mod:NewSpecialWarningDodgeCount(1294293, nil, nil, nil, 1, 15, nil, nil, "frontal")
--local specWarnFlood						= mod:NewSpecialWarningDodgeCount(1294921, nil, nil, nil, 1, 19, nil, nil, "beamincoming")--Likely unused
local specWarnStirtheDepths				= mod:NewSpecialWarningCount(1290956, nil, nil, nil, 1, 2, nil, nil, "watchwave")--Likely flood's replacement
local specWarnCoilingIchor				= mod:NewSpecialWarningDodgeCount(1290809, nil, nil, nil, 2, 2, nil, nil, "watchstep")
local specWarnBeckonProgeny				= mod:NewSpecialWarningCount(1291404, "-Healer", nil, nil, 1, 2, nil, nil, "mobsoon")
local specWarnRavenousFeast				= mod:NewSpecialWarningSoakCount(1290516, nil, nil, nil, 2, 2, nil, nil, "helpsoak")
local specWarnBloodTorrent				= mod:NewSpecialWarningCount(1303230, nil, nil, nil, 1, 2, 4, nil, "bigmob")--Mythic Only
local specWarnBarrage					= mod:NewSpecialWarningCount(1306872, nil, nil, nil, 2, 2, nil, nil, "watchstep")
local specWarnRousetheBrood				= mod:NewSpecialWarningCount(1308356, nil, nil, nil, 1, 2, 4, nil, "mobsoon")--Mythic Only
local specWarnCorrosiveSpit				= mod:NewSpecialWarningBlizzYou(1291478, nil, nil, nil, 1, 17, nil, nil, "lineyou")

local timerCausticDelugeCD				= mod:NewCDCountTimer(20.5, 1289192, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Also affects players near tanks
local timerStoneBreakerCD				= mod:NewCDCountTimer(20.5, 1288484, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Also affects players near tanks
local timerSurgeCD						= mod:NewCDCountTimer(20.5, 1294293, nil, nil, nil, 3)
--local timerFloodCD						= mod:NewCDCountTimer(20.5, 1294921, nil, nil, nil, 3)--Likely unused
local timerStirtheDepthsCD				= mod:NewCDCountTimer(20.5, 1290956, nil, nil, nil, 3)--Likely flood's replacement
local timerCoilingIchorCD				= mod:NewCDCountTimer(20.5, 1290809, nil, nil, nil, 3)
local timerBeckonProgenyCD				= mod:NewCDCountTimer(20.5, 1291404, nil, nil, nil, 1)
local timerRavenousFeastCD				= mod:NewCDCountTimer(20.5, 1290516, nil, nil, nil, 2)
local timerBloodTorrentCD				= mod:NewCDCountTimer(20.5, 1303230, nil, nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)--Mythic Only
local timerBarrageCD					= mod:NewCDCountTimer(20.5, 1306872, nil, nil, nil, 3)
local timerRousetheBroodCD				= mod:NewCDCountTimer(20.5, 1308356, nil, nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)--Mythic Only
local timerSubmergeCD					= mod:NewCDCountTimer(20.5, 1308556, nil, nil, nil, 6)
--local timerBerserkCD					= mod:NewBerserkTimer(600)--Unending Tides

--Evidence https://www.warcraftlogs.com/reports/8yDbgRFz9NnQktTx?fight=35&type=auras&spells=debuffs
mod:AddAuraSoundOption(1310102, true, 1290516, 1, 3, "absorbyou", 19, 0)--Tainted Blood
mod:AddAuraSoundOption(1310096, false, 1290516, 1, 3, "debuffyou", 2, 0)--Feasted
mod:AddAuraSoundOption(1290814, true, 1290809, 1, 1, "poolyou", 18, 0)--Coiling Ichor
mod:AddAuraSoundOption(1292552, true, 1290809, 1, 2, "watchfeet", 8, 0)--Congealed Gore
--mod:AddAuraSoundOption(1293979, true, 1291478, 1, 1, "lineyou", 17, 0)--Corrosive Spit (use if BlizzYou doesn't work right)
--mod:AddAuraSoundOption(1289192, true, 1289192, 1, 1, "defensive", 2, 0)--Caustic Deluge (use if BlizzYou doesn't work right)
mod:AddAuraSoundOption(1303230, true, 1303230, 1, 1, "targetyou", 2, 0)--Blood Torrent (terrible sound, i need more context to create better one)
mod:AddAuraSoundOption(1309471, true, 1308556, 1, 2, "watchfeet", 8, 0)--Noxious Slick
mod:AddAuraSoundOption(1294605, true, 1294921, 1, 2, "watchfeet", 8, 0)--Vile Flood

local badStateDetected = false--Used to track if hardcode features have failed and we need to fall back to blizz API
local next76Event = "caustic"
local next68Event = "caustic"
local next6Event = "surge"
local nextMythic8Event = "caustic"
local nextMythic33Event = "beckon"
local nextMythic61Event = "caustic"
local nextMythic6Event = "barrage"
local submergeEventIDs = {}

mod.vb.CausticDelugeCount = 0
mod.vb.StoneBreakerCount = 0
mod.vb.SurgeCount = 0
mod.vb.FloodCount = 0
mod.vb.StirtheDepthsCount = 0
mod.vb.CoilingIchorCount = 0
mod.vb.BeckonProgenyCount = 0
mod.vb.RavenousFeastCount = 0
mod.vb.BloodTorrentCount = 0
mod.vb.BarrageCount = 0
mod.vb.RousetheBroodCount = 0
mod.vb.SubmergeCount = 0

---@param self DBMMod
---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		if self:IsTank() then
			specWarnStoneBreaker:SetAlert(739, "helpsoak", 2, 2)
		end
		specWarnCausticDeluge:SetAlert(711, "defensive", 2, 2, 0)
		specWarnSurge:SetAlert(740, "frontal", 15, 2)
	--	specWarnFlood:SetAlert(741, "beamincoming", 19, 2)
		specWarnStirtheDepths:SetAlert(742, "watchwave", 2, 2)
		specWarnCoilingIchor:SetAlert(743, "watchstep", 2, 2)
		specWarnBeckonProgeny:SetAlert(744, "mobsoon", 2, 2)
		specWarnRavenousFeast:SetAlert(751, "helpsoak", 2, 2)
		specWarnBloodTorrent:SetAlert(896, "bigmob", 2, 2)
		specWarnBarrage:SetAlert(897, "watchstep", 2, 2)
		specWarnRousetheBrood:SetAlert(900, "mobsoon", 2, 2)
		specWarnCorrosiveSpit:SetAlert(753, "lineyou", 17, 2, 0)
	end
	--If user has DBM bars enabled, we only want to register colors to the blizz api so that the blizz bars are also colorized.
	--If user has bars disabled, or we are in a bad state, onlyColor is false and we register countdowns as well.
	local onlyColor = not DBM.Options.HideDBMBars and not badStateDetected
	timerCausticDelugeCD:SetTimeline(711, onlyColor)
	timerStoneBreakerCD:SetTimeline(739, onlyColor)
	timerSurgeCD:SetTimeline(740, onlyColor)
--	timerFloodCD:SetTimeline(741, onlyColor)
	timerStirtheDepthsCD:SetTimeline(742, onlyColor)
	timerCoilingIchorCD:SetTimeline(743, onlyColor)
	timerBeckonProgenyCD:SetTimeline(744, onlyColor)
	timerRavenousFeastCD:SetTimeline(751, onlyColor)
	timerBloodTorrentCD:SetTimeline(896, onlyColor)
	timerBarrageCD:SetTimeline(897, onlyColor)
	timerRousetheBroodCD:SetTimeline(900, onlyColor)
	timerSubmergeCD:SetTimeline(995, onlyColor)
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
	submergeEventIDs = {}
	next76Event = "caustic"
	next68Event = "caustic"
	next6Event = "surge"
	nextMythic8Event = "caustic"
	nextMythic33Event = "beckon"
	nextMythic61Event = "caustic"
	nextMythic6Event = "barrage"
	self.vb.CausticDelugeCount = 1
	self.vb.StoneBreakerCount = 1
	self.vb.SurgeCount = 1
	self.vb.FloodCount = 1
	self.vb.StirtheDepthsCount = 1
	self.vb.CoilingIchorCount = 1
	self.vb.BeckonProgenyCount = 1
	self.vb.RavenousFeastCount = 1
	self.vb.BloodTorrentCount = 1
	self.vb.BarrageCount = 1
	self.vb.RousetheBroodCount = 1
	self.vb.SubmergeCount = 1
	--Hardcode features first
	if DBM.Options.HardcodedTimer and (self:IsEasy() or self:IsHeroic() or self:IsMythic()) and not badStateDetected then
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		)
		setFallback(self, true)
	else
		setFallback(self)
	end
end


function mod:OnCombatEnd()
	self:TLCountReset()
	submergeEventIDs = {}
	next76Event = "caustic"
	next68Event = "caustic"
	next6Event = "surge"
	nextMythic8Event = "caustic"
	nextMythic33Event = "beckon"
	nextMythic61Event = "caustic"
	nextMythic6Event = "barrage"
	self:UnregisterShortTermEvents()
end

do
	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersEasy(self, timer, timerExact, eventID)
		local handled = false
		if timer == 10 then
			handled = true
			next76Event = "caustic"
			timerCausticDelugeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "caustic", "CausticDelugeCount"))
		elseif timer == 23 then
			handled = true
			timerStoneBreakerCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "stone", "StoneBreakerCount"))
		elseif timer == 41 then
			handled = true
			timerBeckonProgenyCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "beckon", "BeckonProgenyCount"))
		elseif timer == 50 then
			handled = true
			timerCoilingIchorCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "coiling", "CoilingIchorCount"))
		elseif timer == 59 then
			handled = true
			timerStirtheDepthsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "stir", "StirtheDepthsCount"))
		elseif timer == 71 then
			handled = true
			timerRavenousFeastCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "ravenous", "RavenousFeastCount"))
		elseif timer == 76 then
			handled = true
			if next76Event == "caustic" then
				timerCausticDelugeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "caustic", "CausticDelugeCount"))
				next76Event = "stone"
			elseif next76Event == "stone" then
				timerStoneBreakerCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "stone", "StoneBreakerCount"))
				next76Event = "beckon"
			elseif next76Event == "beckon" then
				timerBeckonProgenyCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "beckon", "BeckonProgenyCount"))
				next76Event = "coiling"
			elseif next76Event == "coiling" then
				timerCoilingIchorCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "coiling", "CoilingIchorCount"))
				next76Event = "stir"
			elseif next76Event == "stir" then
				timerStirtheDepthsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "stir", "StirtheDepthsCount"))
				next76Event = "ravenous"
			else
				timerRavenousFeastCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "ravenous", "RavenousFeastCount"))
				next76Event = "caustic"
			end
		elseif self:IsRoundedTimer(timerExact, 162.5, 3) then--Observed Normal variation: 162-163 seconds
			handled = true
			submergeEventIDs[eventID] = true
			timerSubmergeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "submerge", "SubmergeCount"))
		elseif timer == 6 then
			handled = true
			if next6Event == "surge" then
				timerSurgeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "surge", "SurgeCount"))
				next6Event = "barrage"
			else
				timerBarrageCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "barrage", "BarrageCount"))
				next6Event = "surge"
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

	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersHeroic(self, timer, timerExact, eventID)
		local handled = false
		if timer == 9 then
			handled = true
			next68Event = "caustic"
			timerCausticDelugeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "caustic", "CausticDelugeCount"))
		elseif timer == 20 then
			handled = true
			timerStoneBreakerCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "stone", "StoneBreakerCount"))
		elseif timer == 37 then
			handled = true
			timerBeckonProgenyCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "beckon", "BeckonProgenyCount"))
		elseif timer == 44 then
			handled = true
			timerCoilingIchorCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "coiling", "CoilingIchorCount"))
		elseif timer == 52 then
			handled = true
			timerStirtheDepthsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "stir", "StirtheDepthsCount"))
		elseif timer == 63 then
			handled = true
			timerRavenousFeastCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "ravenous", "RavenousFeastCount"))
		elseif timer == 68 then
			handled = true
			if next68Event == "caustic" then
				timerCausticDelugeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "caustic", "CausticDelugeCount"))
				next68Event = "stone"
			elseif next68Event == "stone" then
				timerStoneBreakerCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "stone", "StoneBreakerCount"))
				next68Event = "beckon"
			elseif next68Event == "beckon" then
				timerBeckonProgenyCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "beckon", "BeckonProgenyCount"))
				next68Event = "coiling"
			elseif next68Event == "coiling" then
				timerCoilingIchorCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "coiling", "CoilingIchorCount"))
				next68Event = "stir"
			elseif next68Event == "stir" then
				timerStirtheDepthsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "stir", "StirtheDepthsCount"))
				next68Event = "ravenous"
			else
				timerRavenousFeastCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "ravenous", "RavenousFeastCount"))
				next68Event = "caustic"
			end
		elseif self:IsRoundedTimer(timerExact, 144.444, 3) then--Normal 162.5s Submerge scaled by Heroic's 8/9 timer pace
			handled = true
			submergeEventIDs[eventID] = true
			timerSubmergeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "submerge", "SubmergeCount"))
		elseif timer == 6 then
			handled = true
			if next6Event == "surge" then
				timerSurgeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "surge", "SurgeCount"))
				next6Event = "barrage"
			else
				timerBarrageCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "barrage", "BarrageCount"))
				next6Event = "surge"
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

	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersMythic(self, timer, timerExact, eventID)
		local handled = false
		if timer == 8 then
			handled = true
			if nextMythic8Event == "caustic" then
				timerCausticDelugeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "caustic", "CausticDelugeCount"))
				nextMythic8Event = "blood"
			else
				timerBloodTorrentCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "blood", "BloodTorrentCount"))
				nextMythic8Event = "caustic"
			end
		elseif timer == 18 then
			handled = true
			timerStoneBreakerCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "stone", "StoneBreakerCount"))
		elseif timer == 33 then
			handled = true
			if nextMythic33Event == "beckon" then
				timerBeckonProgenyCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "beckon", "BeckonProgenyCount"))
				nextMythic33Event = "rouse"
			else
				timerRousetheBroodCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rouse", "RousetheBroodCount"))
				nextMythic33Event = "beckon"
			end
		elseif timer == 40 then
			handled = true
			timerCoilingIchorCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "coiling", "CoilingIchorCount"))
		elseif timer == 47 then
			handled = true
			timerStirtheDepthsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "stir", "StirtheDepthsCount"))
		elseif timer == 57 then
			handled = true
			timerRavenousFeastCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "ravenous", "RavenousFeastCount"))
		elseif timer == 61 then
			handled = true
			if nextMythic61Event == "caustic" then
				timerCausticDelugeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "caustic", "CausticDelugeCount"))
				nextMythic61Event = "blood"
			elseif nextMythic61Event == "blood" then
				timerBloodTorrentCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "blood", "BloodTorrentCount"))
				nextMythic61Event = "stone"
			elseif nextMythic61Event == "stone" then
				timerStoneBreakerCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "stone", "StoneBreakerCount"))
				nextMythic61Event = "beckon"
			elseif nextMythic61Event == "beckon" then
				timerBeckonProgenyCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "beckon", "BeckonProgenyCount"))
				nextMythic61Event = "rouse"
			elseif nextMythic61Event == "rouse" then
				timerRousetheBroodCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rouse", "RousetheBroodCount"))
				nextMythic61Event = "coiling"
			elseif nextMythic61Event == "coiling" then
				timerCoilingIchorCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "coiling", "CoilingIchorCount"))
				nextMythic61Event = "stir"
			elseif nextMythic61Event == "stir" then
				timerStirtheDepthsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "stir", "StirtheDepthsCount"))
				nextMythic61Event = "ravenous"
			else
				timerRavenousFeastCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "ravenous", "RavenousFeastCount"))
				nextMythic61Event = "caustic"
			end
		elseif self:IsRoundedTimer(timerExact, 130, 3) then--Normal 162.5s Submerge scaled by Mythic's 4/5 timer pace
			handled = true
			submergeEventIDs[eventID] = true
			timerSubmergeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "submerge", "SubmergeCount"))
		elseif timer == 6 then
			handled = true
			if nextMythic6Event == "barrage" then
				timerBarrageCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "barrage", "BarrageCount"))
				nextMythic6Event = "surge"
			else
				timerSurgeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "surge", "SurgeCount"))
				nextMythic6Event = "barrage"
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
			if self:IsMythic() then
				timersMythic(self, timer, timerExact, eventID)
			elseif self:IsHeroic() then
				timersHeroic(self, timer, timerExact, eventID)
			elseif self:IsEasy() then
				timersEasy(self, timer, timerExact, eventID)
			end
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		if eventState == 2 then
			local eventType, eventCount = self:TLCountFinish(eventID)
			if not eventType then return end
			if not eventCount then return end
			submergeEventIDs[eventID] = nil
			if eventType == "caustic" then
				specWarnCausticDeluge:Show(eventCount, "defensive")
			elseif eventType == "stone" then
				if self:IsTank() then--TODO: verify bosses stay at same UNITID and we can threat check right one
					specWarnStoneBreaker:Show(eventCount)
					specWarnStoneBreaker:Play("helpsoak")
				end
			elseif eventType == "surge" then
				specWarnSurge:Show(eventCount)
				specWarnSurge:Play("frontal")
			elseif eventType == "stir" then
				specWarnStirtheDepths:Show(eventCount)
				specWarnStirtheDepths:Play("watchwave")
			elseif eventType == "coiling" then
				specWarnCoilingIchor:Show(eventCount)
				specWarnCoilingIchor:Play("watchstep")
			elseif eventType == "beckon" then
				specWarnBeckonProgeny:Show(eventCount)
				specWarnBeckonProgeny:Play("mobsoon")
			elseif eventType == "ravenous" then
				specWarnRavenousFeast:Show(eventCount)
				specWarnRavenousFeast:Play("helpsoak")
			elseif eventType == "barrage" then
				specWarnBarrage:Show(eventCount)
				specWarnBarrage:Play("watchstep")
			elseif eventType == "blood" then
				specWarnBloodTorrent:Show(eventCount)
				specWarnBloodTorrent:Play("bigmob")
			elseif eventType == "rouse" then
				specWarnRousetheBrood:Show(eventCount)
				specWarnRousetheBrood:Play("mobsoon")
			end
		elseif eventState == 3 and submergeEventIDs[eventID] then--Normal evidence shows Submerge completes with state 3 on time
			submergeEventIDs[eventID] = nil
			self:TLCountFinish(eventID)
		elseif eventState == 3 then
			self:TLCountCancel(eventID)
		end
	end
end
