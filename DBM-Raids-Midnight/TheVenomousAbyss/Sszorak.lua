local mod	= DBM:NewMod(2871, "DBM-Raids-Midnight", 1, 1320)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(257347)
mod:SetEncounterID(3420)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(3004)

mod:RegisterCombat("combat")

DBM:RegisterAltSpellName(1277025, DBM_COMMON_L.TANKCOMBO)--Apex Predator --> Tank Combo
DBM:RegisterAltSpellName(1305959, DBM_COMMON_L.CIRCLES)--Venomous Surge --> Circles
DBM:RegisterAltSpellName(1285425, DBM_COMMON_L.KNOCK.. " " .. DBM_COMMON_L.DEBUFFS)--Raging Crosswinds --> Knock Debuffs
local warnVenomousSurge					= mod:NewCountAnnounce(1305959, 2)

local specWarnRagingCrosswinds			= mod:NewSpecialWarningBlizzYou(1285425, nil, nil, nil, 1, 17, nil, nil, "debuffyou")
local specWarnApexPedator				= mod:NewSpecialWarningCount(1277025, nil, nil, nil, 1, 19, nil, nil, "tankcombo")
local specWarnHowlingMaelstrom			= mod:NewSpecialWarningCount(1285732, nil, nil, nil, 2, 13, nil, nil, "pushbackincoming")
local specWarnCausticClaws				= mod:NewSpecialWarningCount(1285733, nil, nil, nil, 2, 2, nil, nil, "scatter")--Sub mechanic of Venomous Surge

local timerRagingCrosswindsCD			= mod:NewCDCountTimer(20.5, 1285425, nil, nil, nil, 3)
local timerVenomousSurgeCD				= mod:NewCDCountTimer(20.5, 1305959, nil, nil, nil, 3)
local timerApexPedatorCD				= mod:NewCDCountTimer(20.5, 1277025, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerHowlingMaelstromCD			= mod:NewCDCountTimer(20.5, 1285732, nil, nil, nil, 2, nil, DBM_COMMON_L.IMPORTANT_ICON)
local timerBerserkCD					= mod:NewBerserkTimer(600)

--Evidenced by https://www.warcraftlogs.com/reports/nFX9MYTV26tpmCrk?fight=16&type=auras&spells=debuffs
--and
--https://www.warcraftlogs.com/reports/nFX9MYTV26tpmCrk?fight=16&pins=2%24Off%24%23244F4B%24expression%24ability.name+%3D+%22Raging+Crosswinds%22+and+not+type+%3D+%22damage%22&view=replay&position=8576
mod:AddAuraSoundOption(1277051, false, 1277025, 1, 3, "debuffyou", 17, 0)--Infected Gash from soaking
mod:AddAuraSoundOption(1287083, true, 1277025, 1, 3, "slowyou", 20, 0)--Tempest
mod:AddAuraSoundOption(1305963, true, 1305959, 1, 1, "runout", 2, 0)--Venomous Surge
mod:AddAuraSoundOption(1285425, true, 1285425, 1, 1, "south", 2, 0)--Raging Crosswinds knocks North (Right now it announces where to go, NOT knock direction)
mod:AddAuraSoundOption(1285453, true, 1285425, 1, 1, "north", 2, 0)--Raging Crosswinds knocks South ^
mod:AddAuraSoundOption(1297111, true, 1285425, 1, 1, "east", 2, 0)--Raging Crosswinds knocks West ^
mod:AddAuraSoundOption(1297096, true, 1285425, 1, 1, "west", 2, 0)--Raging Crosswinds knocks East ^
mod:AddAuraSoundOption(1296667, true, 1305959, 1, 2, "watchfeet", 8, 0)--Caustic Residue
mod:AddAuraSoundOption(1297707, true, 1305959, 1, 2, "watchstep", 8, 0)--Caustic Claws
mod:AddAuraSoundOption(1305621, true, 1305621, 1, 1, "targetyou", 2, 0)--Serpent's Fury
mod:AddAuraSoundOption({1297707, 1299899}, true, 1305621, 1, 1, "scatter", 2, 0)--Virulence (since it has two spellids, we can abuse that to split the raid in 2 to automate scatter a little)
--mod:AddAuraSoundOption(1299899, true, 1305621, 1, 1, "scatterright", 20, 0)--But I'll hold off on that for now cause they'll probably fix it if that's abused

local badStateDetected = false--Used to track if hardcode features have failed and we need to fall back to blizz API
local nextVariableEvent = "apex"

mod.vb.RagingCrosswindsCount = 0
mod.vb.VenomousSurgeCount = 0
mod.vb.ApexPedatorCount = 0
mod.vb.HowlingMaelstromCount = 0

---@param self DBMMod
---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		if self:IsTank() then
			specWarnApexPedator:SetAlert(664, "tankcombo", 19, 2)
		end
		specWarnRagingCrosswinds:SetAlert(652, "debuffyou", 17, 2, 0)
		specWarnHowlingMaelstrom:SetAlert(665, "pushbackincoming", 13, 2)
		specWarnCausticClaws:SetAlert(851, "scatter", 2, 2)
	end
	--If user has DBM bars enabled, we only want to register colors to the blizz api so that the blizz bars are also colorized.
	--If user has bars disabled, or we are in a bad state, onlyColor is false and we register countdowns as well.
	local onlyColor = not DBM.Options.HideDBMBars and not badStateDetected
	timerRagingCrosswindsCD:SetTimeline(652, onlyColor)
	timerVenomousSurgeCD:SetTimeline(653, onlyColor)
	timerApexPedatorCD:SetTimeline(664, onlyColor)
	timerHowlingMaelstromCD:SetTimeline(665, onlyColor)
	timerBerserkCD:SetTimeline(863, onlyColor)
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
	self.vb.RagingCrosswindsCount = 1
	self.vb.VenomousSurgeCount = 1
	self.vb.ApexPedatorCount = 1
	self.vb.HowlingMaelstromCount = 1
	nextVariableEvent = "apex"
	if DBM.Options.HardcodedTimer and (self:IsHeroic() or self:IsNormal() or self:IsMythic()) and not badStateDetected then
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
	nextVariableEvent = "apex"
	self:UnregisterShortTermEvents()
end

do
	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersAll(self, timer, timerExact, eventID)
		local handled
		--Normal and Heroic are confirmed by logs; Mythic tempo and sequence are extrapolated by 1, 8/9, and 4/5 rule evidenced by logs and fangs encounter
		if timer == 125 or timer == 111 or timer == 100 then
			handled = true
			timerHowlingMaelstromCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "maelstrom", "HowlingMaelstromCount"))
		elseif timer == 6 or timer == 5 then
			handled = true
			timerApexPedatorCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "apex", "ApexPedatorCount"))
		elseif timer == 49 or timer == 43 or timer == 39 then
			handled = true
			timerRagingCrosswindsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "crosswinds", "RagingCrosswindsCount"))
		elseif timer == 36 or timer == 32 or timer == 29 then
			handled = true
			timerVenomousSurgeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "venom", "VenomousSurgeCount"))
		elseif timer == 59 or timer == 52 or timer == 47 then
			handled = true
			if nextVariableEvent == "apex" then
				timerApexPedatorCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "apex", "ApexPedatorCount"))
				nextVariableEvent = "venom"
			elseif nextVariableEvent == "venom" then
				timerVenomousSurgeCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "venom", "VenomousSurgeCount"))
				nextVariableEvent = "crosswinds"
			else
				timerRagingCrosswindsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "crosswinds", "RagingCrosswindsCount"))
				nextVariableEvent = "apex"
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
			if eventType and eventCount then
				if eventType == "maelstrom" then
					specWarnHowlingMaelstrom:Show(eventCount)
					specWarnHowlingMaelstrom:Play("pushbackincoming")
				elseif eventType == "apex" then
					specWarnApexPedator:Show(eventCount)
					specWarnApexPedator:Play("tankcombo")
				elseif eventType == "venom" then
					warnVenomousSurge:Show(eventCount)
				elseif eventType == "crosswinds" then
					specWarnRagingCrosswinds:Show(eventCount, "debuffyou")
				end
			end
		elseif eventState == 3 then
			self:TLCountCancel(eventID)
		end
	end
end
