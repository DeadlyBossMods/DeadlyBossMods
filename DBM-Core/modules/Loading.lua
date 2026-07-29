---@class DBMCoreNamespace
local private = select(2, ...)

local L = DBM_CORE_L
local CL = DBM_COMMON_L

---@class DBM
local DBM = private:GetPrototype("DBM")
-- Keep internal notices on the original function so replacing/hooking the public method cannot suppress them.
local AddMsg = DBM.AddMsg
local difficulties = private:GetPrototype("Difficulties")
local test = private:GetPrototype("DBMTest")
local tableUtils = private:GetPrototype("TableUtils")
local checkEntry = tableUtils.checkEntry
local loadcIds = private.loadcIds

local ipairs, pairs = ipairs, pairs
local type, tostring = type, tostring
local IsInGroup, IsInInstance = IsInGroup, IsInInstance
local UnitGUID, UnitIsDead, UnitIsFriend = UnitGUID, UnitIsDead, UnitIsFriend
local InCombatLockdown = InCombatLockdown
local C_TimerAfter = C_Timer.After

--------------------------------
--  Load Boss Mods on Demand  --
--------------------------------
do
	local pvpShown = false
	local dungeonShown = false
	local classicZones = {[509] = true, [531] = true, [469] = true, [409] = true, [2791] = true, [2792] = true, [2832] = true, [2856] = true,}
	local bcZones = {[534] = true, [532] = true, [544] = true, [548] = true, [550] = true, [564] = true, [565] = true, [580] = true}
	local wrathZones = {[615] = true, [724] = true, [649] = true, [616] = true, [631] = true, [533] = true, [249] = true, [603] = true, [624] = true}
	local cataZones = {[757] = true, [671] = true, [669] = true, [967] = true, [720] = true, [951] = true, [754] = true}
	local mopZones = {[1009] = true, [1008] = true, [1136] = true, [996] = true, [1098] = true}
	local wodZones = {[1205] = true, [1448] = true, [1228] = true}
	local legionZones = {[1712] = true, [1520] = true, [1530] = true, [1676] = true, [1648] = true}
	local bfaZones = {[1861] = true, [2070] = true, [2096] = true, [2164] = true, [2217] = true}
	local shadowlandsZones = {[2296] = true, [2450] = true, [2481] = true}
	local dragonflightZones = {[2522] = true, [2569] = true, [2549] = true}
	local importantChallenges = {2827, 2828}--TWW visions revsited
	local pvpZones = {[30] = true, [489] = true, [529] = true, [559] = true, [562] = true, [566] = true, [572] = true, [617] = true, [618] = true, [628] = true, [726] = true, [727] = true, [761] = true, [968] = true, [980] = true, [998] = true, [1105] = true, [1134] = true, [1170] = true, [1504] = true, [1505] = true, [1552] = true, [1681] = true, [1672] = true, [1803] = true, [1825] = true, [1911] = true, [2106] = true, [2107] = true, [2118] = true, [2167] = true, [2177] = true, [2197] = true, [2245] = true, [2373] = true, [2509] = true, [2511] = true, [2547] = true, [2563] = true}
	--This never wants to spam you to use mods for trivial content you don't need mods for.
	--It's intended to suggest mods for content that's relevant to your level (TW, leveling up in dungeons, or even older raids you can't just roll over)
	function DBM:CheckAvailableMods()
		--If they are running two boss mods at once, lets assume they are only using DBM for a specific feature (such as brawlers) and not nag
		--If they've disabled reminders, don't nag
		if _G["BigWigs"] or not self.Options.ShowReminders then return end
		local mapID = self:GetCurrentArea()
		if not self:IsTrivial() or difficulties:IsSeasonalDungeon(mapID) then
			local checkedDungeon = private.isRetail and "DBM-Party-WarWithin" or private.isMop and "DBM-Party-MoP" or private.isCata and "DBM-Party-Cataclysm" or private.isWrath and "DBM-Party-WotLK" or private.isBCC and "DBM-Party-BC" or "DBM-Party-Vanilla"
			--Dungeon Handling
			if (difficulties:InstanceType(mapID) == 2) or (difficulties:InstanceType(mapID) == 4) then--Dungeon or Delve
				--Show popup for season of discovery and hardcore, both of whic have higher difficulty (or higher risk in terms of hardcore) dungeons
				if self:IsSeasonal("SeasonOfDiscovery") or self:IsSeasonal("FreshHardcore") or self:IsSeasonal("Hardcore") then
					self:AnnoyingPopupCheckZone(mapID, "Vanilla")
				--Also show popup on retail seasonal dungeons since those are ones being run for M0 and M+
				elseif private.isRetail and difficulties:IsSeasonalDungeon(mapID) then--M+ Dungeons Only
					self:AnnoyingPopupCheckZone(mapID, "Retail")
				elseif private.isMop then--Mop dungeons only
					self:AnnoyingPopupCheckZone(mapID, "MoP")
				else--Show a general message not a popup (Basically tbc, wrath, cata dungeons
					if not C_AddOns.DoesAddOnExist(checkedDungeon) and not dungeonShown then
						AddMsg(self, L.MOD_AVAILABLE:format("DBM Dungeons, Delves, & Events mods"), nil, private.isRetail or private.isCata or private.isMop)
						dungeonShown = true
					end
				end
			--Classic raid Handling
			elseif classicZones[mapID] or ((mapID == 249 or mapID == 533) and private.isClassic) then
				if not C_AddOns.DoesAddOnExist("DBM-Raids-Vanilla") then
					AddMsg(self, L.MOD_AVAILABLE:format("DBM Vanilla/SoD mods"), nil, private.isClassic)--Play sound only in Vanilla
				end
				--Show extra annoying popup in current content that's non trivial in classic or BRD raild on retail
				if private.isClassic or mapID == 2792 then
					self:AnnoyingPopupCheckZone(mapID, "Vanilla")
				end
			--TBC raid Handling
			elseif bcZones[mapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-BC") then
				AddMsg(self, L.MOD_AVAILABLE:format("DBM Burning Crusade mods"), nil, private.isBCC)--Play sound only in TBC
				--Show extra annoying popup in current content that's non trivial in classic TBC or Black Temple raid on retail
				if private.isBCC or mapID == 564 then
					self:AnnoyingPopupCheckZone(mapID, "BCC") -- Show extra annoying popup in current content that's non trivial in classic or BRD raild on retail
				end
			--Wrath raid Handling
			elseif wrathZones[mapID] and not private.isClassic then
				if not C_AddOns.DoesAddOnExist("DBM-Raids-WoTLK") then
					AddMsg(self, L.MOD_AVAILABLE:format("DBM Wrath of the Lich King mods"), nil, private.isWrath)--Play sound only in wrath
				end
				--Show extra annoying popup in current content if it's classic
				if private.isWrath or mapID == 631 then
					self:AnnoyingPopupCheckZone(mapID, "WoTLK") -- Show extra annoying popup in current content if it's classic
				end
			--Cata raid Handling
			elseif cataZones[mapID] then
				if not C_AddOns.DoesAddOnExist("DBM-Raids-Cata") then
					AddMsg(self, L.MOD_AVAILABLE:format("DBM Cataclysm mods"), nil, private.isCata)--Play sound only in cata
				end
				--Show extra annoying popup in current content if it's classic
				if private.isCata or mapID == 720 then
					self:AnnoyingPopupCheckZone(mapID, "Cata") -- Show extra annoying popup in current content if it's classic
				end
			--MoP raid Handling
			elseif mopZones[mapID] then
				if not C_AddOns.DoesAddOnExist("DBM-Raids-MoP") then
					AddMsg(self, L.MOD_AVAILABLE:format("DBM Mists of Pandaria mods"), nil, private.isMop)
				end
				--Show extra annoying popup in current content if it's classic
				if private.isMop then--or LastInstanceMapID == 1098 (throne of thunder next timewalking raid?)
					self:AnnoyingPopupCheckZone(mapID, "MoP")
				end
			--WoD raid Handling
			elseif wodZones[mapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-WoD") then
				AddMsg(self, L.MOD_AVAILABLE:format("DBM Warlords of Draenor mods"))
			--Legion raid Handling
			elseif legionZones[mapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-Legion") then
				AddMsg(self, L.MOD_AVAILABLE:format("DBM Legion mods"), nil, mapID == 580)--Will play sound in tomb of sargeras since Kil Jaeden is still dangerous regardless of level
			--BFA raid Handling
			elseif bfaZones[mapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-BfA") then
				AddMsg(self, L.MOD_AVAILABLE:format("DBM Battle for Azeroth mods"))
			--Shadowlands raid Handling
			elseif shadowlandsZones[mapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-Shadowlands") then
				AddMsg(self, L.MOD_AVAILABLE:format("DBM Shadowlands mods"), nil, true)--Will use play sound for now, since it's not trivial enough to be silent yet
			--Dragonflight raid Handling
			elseif dragonflightZones[mapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-Dragonflight") then--Uncomment in War Within on mod split
				AddMsg(self, L.MOD_AVAILABLE:format("DBM Dragonflight mods"), nil, true)--Will use play sound for now, since it's not trivial enough to be silent yet
			end
		end
		if (difficulties:InstanceType(mapID) == 5) and not C_AddOns.DoesAddOnExist("DBM-Challenges") then--No trivial check on challenge scenarios
			if importantChallenges[mapID] then
				self:AnnoyingPopupCheckZone(mapID, "Retail")
			else
				AddMsg(self, L.MOD_AVAILABLE:format("DBM-Challenges"), nil, true)
			end
		end
		if pvpZones[mapID] and not C_AddOns.DoesAddOnExist("DBM-PvP") and not pvpShown then
			AddMsg(self, L.MOD_AVAILABLE:format("DBM-PvP"), nil, true)
			pvpShown = true
		end
	end

	local sodPvpZones = {
		[1440] = true, -- Ashenvale
		[1434] = true, -- Stranglethorn Vale
	}
	function DBM:CheckAvailableModsByMap()
		local mapId = C_Map.GetBestMapForUnit("player")
		if not mapId then return end
		if UnitOnTaxi("player") then return end -- Don't spam the player if they are just passing through
		if self:IsSeasonal("SeasonOfDiscovery") then
			if sodPvpZones[mapId] and not pvpShown and not C_AddOns.DoesAddOnExist("DBM-PvP") then
				AddMsg(self, L.MOD_AVAILABLE:format("DBM-PvP"))
				pvpShown = true
			end
		end
	end

	local sodLevelUpRaids = {[48] = true, [90] = true, [109] = true}

	---@return string?
	local function isDmfActiveClassic()
		if DBM:IsSeasonal("SeasonOfDiscovery") then
			-- GetServerTime() returns local time in classic and there doesn't seem to be a good way to get actual server date in classic. This is good enough.
			local dmfOffset = (GetServerTime() - 1713736800) / (60 * 60 * 24 * 28) % 1
			return dmfOffset <= 0.25 and "m1456" -- Thunderbluff
				or dmfOffset >= 0.5 and dmfOffset <= 0.75 and "m1429" -- Elwynn
				or nil -- Not active
		else
			return nil -- TODO: implement Classic era logic and whatever Cataclysm is doing. Slightly more annoying to calculate than SoD
		end
	end

	---@param checkTable string
	---@param checkValue any
	---@param delay number?
	function DBM:LoadModsOnDemand(checkTable, checkValue, delay)
		self:Debug("LoadModsOnDemand fired for table " .. checkTable .. " value " .. tostring(checkValue))
		local dmfMod
		local playerName = self:GetMyPlayerInfo()
		local mapID = self:GetCurrentArea()
		for _, v in ipairs(self.AddOns) do
			local modTable = v[checkTable]
			local enabled = C_AddOns.GetAddOnEnableState(v.modId, playerName)
			if v.modId == "DBM-WorldEvents" and enabled ~= 0 and not C_AddOns.IsAddOnLoaded(v.modId) then
				dmfMod = v
			end
			--self:Debug(v.modId .. " is " .. enabled, 2)
			if not C_AddOns.IsAddOnLoaded(v.modId) and modTable and checkEntry(modTable, checkValue) then
				if enabled ~= 0 then
					if self:IsSeasonal("SeasonOfDiscovery") and sodLevelUpRaids[mapID] and v.modId == "DBM-Party-Vanilla" then
						--Don't load dungeon mods in SoD Raids
						return
					end
					self:LoadMod(v)
				else
					AddMsg(self, L.LOAD_MOD_DISABLED:format(v.name))
				end
			end
		end
		if private.isRetail and delay then
			self:ScenarioCheck(delay)--Do not filter. Because ScenarioCheck function includes filter.
		end
		-- Hard-code loading logic for DMF classic which depends on time and map
		if dmfMod and checkTable == "mapId" and private.isClassic and isDmfActiveClassic() == checkValue then
			self:LoadMod(dmfMod, true)
		end
	end
end

function DBM:LoadMod(mod, force, enableTestSupport)
	enableTestSupport = enableTestSupport or DBM_ModsToLoadWithFullTestSupport.addonsWithTests[mod.modId]
	if type(mod) ~= "table" then
		self:Debug("LoadMod failed because mod table not valid")
		return false
	end
	local mapID = self:GetCurrentArea()
	--Block loading world boss mods by zoneID, except if it's a heroic warfront or darkmoon faire island
	if mod.isWorldBoss and not IsInInstance() and not force and (not private.isRetail or difficulties.difficultyIndex ~= 149) and mapID ~= 974 then
		return
	end
	if mod.minRevision > self.Revision then
		if self:AntiSpam(60, "VER_MISMATCH") then--Throttle message in case person keeps trying to load mod (or it's a world boss player keeps targeting
			AddMsg(self, L.LOAD_MOD_VER_MISMATCH:format(mod.name))
		end
		return
	end
	if mod.minExpansion > GetExpansionLevel() and not force then
		AddMsg(self, L.LOAD_MOD_EXP_MISMATCH:format(mod.name))
		return
	elseif not private.testBuild and mod.minToc > private.wowTOC then
		AddMsg(self, L.LOAD_MOD_TOC_MISMATCH:format(mod.name, mod.minToc))
		return
	end
	self:GetCurrentSpecInfo()
	difficulties:RefreshCache()
	if private.isRetail or private.isMop then
		EJ_SetDifficulty(difficulties.difficultyIndex)--Work around blizzard crash bug where other mods (like Boss) screw with Ej difficulty value, which makes EJ_GetSectionInfo crash the game when called with invalid difficulty index set.
	end
	self:Debug("LoadAddOn should have fired for " .. mod.name, 2)
	local loaded, reason
	if enableTestSupport and test:Load() then
		test:OnBeforeLoadAddOn()
		loaded, reason = C_AddOns.LoadAddOn(mod.modId)
		test:OnAfterLoadAddOn()
	else
		loaded, reason = C_AddOns.LoadAddOn(mod.modId)
	end
	if not loaded then
		if reason == "DISABLED" then
			AddMsg(self, L.LOAD_MOD_DISABLED:format(mod.name))
		elseif reason then
			AddMsg(self, L.LOAD_MOD_ERROR:format(tostring(mod.name), tostring(_G["ADDON_" .. reason] or CL.UNKNOWN)))
		else
			self:Debug("LoadAddOn failed and did not give reason")
		end
		return false
	else
		self:Debug("LoadAddOn should have succeeded for " .. mod.name, 2)
		AddMsg(self, L.LOAD_MOD_SUCCESS:format(tostring(mod.name)))
		if self.NewerVersion and private.showConstantReminder >= 1 then
			AddMsg(self, L.UPDATEREMINDER_HEADER:format(self.NewerVersion, self:ShowRealDate(self.HighestRelease)))
		end
		self:LoadModOptions(mod.modId, InCombatLockdown(), true) -- Show the test UI immediately to make it clear that the mod is loaded with test support
		if DBM_GUI then
			DBM_GUI:UpdateModList()
			DBM_GUI:CreateBossModTab(mod, mod.panel)
			if DBM_GUI.currentViewing == mod.panel.frame then
				_G["DBM_GUI_OptionsFrame"]:DisplayFrame(mod.panel.frame)
			end
		end
		if private.LastInstanceType ~= "pvp" and not self:InCombat() and IsInGroup() then--do timer recovery only mod load
			if not private.isTimerRequestInProgress() then
				private.setTimerRequestInProgress(true)
				if self:IsPostMidnight() then--TODO, see if needed, blizzard timeline might already resend added events
				--	--Request timeline timers from API
					self:RecoverBlizzardTimers()
				end
				-- Request timer to 3 person to prevent failure.
				self:Unschedule(self.RequestTimers)
				if not self:MidRestrictionsActive(false, false, true) then
					self:Schedule(7, self.RequestTimers, self, 1)
					self:Schedule(10, self.RequestTimers, self, 2)
					self:Schedule(13, self.RequestTimers, self, 3)
				end
				C_TimerAfter(15, function() private.setTimerRequestInProgress(false) end)
				self:GROUP_ROSTER_UPDATE(true)
			end
		end
--		if not InCombatLockdown() and not UnitAffectingCombat("player") and not IsFalling() then--We loaded in combat but still need to avoid garbage collect in combat
--			collectgarbage("collect")
--		end
		return true
	end
end

function DBM:LoadModByName(modName, force, enableTestSupport)
	for _, v in ipairs(self.AddOns) do
		if v.modId == modName then
			self:LoadMod(v, force, enableTestSupport)
		end
	end
end

do
	local function loadModByUnit(uId)
		if IsInInstance() or not UnitIsFriend("player", uId) and UnitIsDead("player") or UnitIsDead(uId) then return end--If you're in an instance no reason to waste cpu. If THE BOSS dead, no reason to load a mod for it. To prevent rare lua error, needed to filter on player dead.
		local guid = UnitGUID(uId)
		if guid and DBM:IsCreatureGUID(guid) then
			local cId = DBM:GetCIDFromGUID(guid)
			local playerName = DBM:GetMyPlayerInfo()
			for bosscId, addon in pairs(loadcIds) do
				local enabled = C_AddOns.GetAddOnEnableState(addon, playerName)
				if cId and bosscId and cId == bosscId and not C_AddOns.IsAddOnLoaded(addon) and enabled ~= 0 then
					for _, v in ipairs(DBM.AddOns) do
						if v.modId == addon then
							DBM:LoadMod(v, true)
							break
						end
					end
				end
			end
		end
	end

	--Loading routeens checks for world bosses based on target or mouseover or nameplate.
	function DBM:UPDATE_MOUSEOVER_UNIT()
		if self:IsPostMidnight() and IsInInstance() then return end
		loadModByUnit("mouseover")
	end

	function DBM:NAME_PLATE_UNIT_ADDED(uId)
		if self:IsPostMidnight() and IsInInstance() then return end
		loadModByUnit(uId)
	end

	function DBM:UNIT_TARGET(uId)
		if self:IsPostMidnight() and IsInInstance() then return end
		loadModByUnit(uId .. "target")
	end
end
