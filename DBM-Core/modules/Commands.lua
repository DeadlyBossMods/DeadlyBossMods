---@diagnostic disable: cast-local-type
---@class DBMCoreNamespace
local private = select(2, ...)

local L = DBM_CORE_L

local test = private:GetPrototype("DBMTest")

local LibStub = _G["LibStub"]
local LibLatency, LibDurability
if LibStub then
	LibLatency, LibDurability = LibStub("LibLatency", true), LibStub("LibDurability", true)
end

local function Pull(timer)
	--Apparently BW wants to accept all pull timers regardless of length, and not support break timers that can be used by all users
	--Sadly, this means DBM has to also be as limiting because if boss mods are not on same page it creates conflicts within multi mod groups
	local LFGTankException = IsPartyLFG and IsPartyLFG() and UnitGroupRolesAssigned("player") == "TANK"--Tanks in LFG need to be able to send pull timer even if someone refuses to pass lead. LFG locks roles so no one can abuse this.
	if (DBM:GetRaidRank() == 0 and IsInGroup() and not LFGTankException) or select(2, IsInInstance()) == "pvp" then
		return DBM:AddMsg(L.ERROR_NO_PERMISSION)
	end
	if IsEncounterInProgress() then
		return DBM:AddMsg(L.ERROR_NO_PERMISSION_COMBAT)
	end
	if timer > 0 and timer < 3 then
		return DBM:AddMsg(L.PULL_TIME_TOO_SHORT)
	end
	--if timer > 60 then
	--	return DBM:AddMsg(L.PULL_TIME_TOO_LONG)
	--end
	if not private.isWrath then
		--Send blizzard countdown timer that all users see (including modless)
		C_PartyInfo.DoCountdown(timer)
		DBM:Debug("Sending Blizzard Countdown Timer")
	else
		private.sendSync(private.DBMSyncProtocol, "PT", timer .. "\t" .. DBM:GetCurrentArea(), "ALERT")
		DBM:Debug("Sending DBM Pull Timer")
	end
end

local function Break(timer)
	--Apparently BW wants to accept all pull timers regardless of length, and not support break timers that can be used by all users
	--Sadly, this means DBM has to also be as limiting because if boss mods are not on same page it creates conflicts within multi mod groups
	local LFGTankException = IsPartyLFG and IsPartyLFG() and UnitGroupRolesAssigned("player") == "TANK"--Tanks in LFG need to be able to send pull timer even if someone refuses to pass lead. LFG locks roles so no one can abuse this.
	if (DBM:GetRaidRank() == 0 and IsInGroup() and not LFGTankException) or select(2, IsInInstance()) == "pvp" then
		return DBM:AddMsg(L.ERROR_NO_PERMISSION)
	end
	if IsEncounterInProgress() then
		return DBM:AddMsg(L.ERROR_NO_PERMISSION_COMBAT)
	end
	if timer > 60 then
		return DBM:AddMsg(L.BREAK_USAGE)
	end
	timer = timer * 60
	--Make sure 1 minute break timer is sent as a break timer and not a pull timer
	--if timer == 60 then
	--	timer = 61
	--end
	--if not private.isWrath then
	--	--Send blizzard countdown timer that all users see (including modless)
	--	C_PartyInfo.DoCountdown(timer)
	--	DBM:Debug("Sending Blizzard Countdown Timer")
	--else
		private.sendSync(private.DBMSyncProtocol, "BT", timer, "ALERT")
		DBM:Debug("Sending DBM Break Timer")
	--end
end

local ShowLag, ShowDurability
do
	local tconcat, tinsert, tsort = table.concat, table.insert, table.sort

	local function SortLag(v1, v2)
		return (v1.worldlag or 0) < (v2.worldlag or 0)
	end

	function ShowLag()
		local sortLag, noLagResponse = {}, {}
		for _, v in pairs(DBM:GetRaidRoster()) do
			tinsert(sortLag, v)
		end
		tsort(sortLag, SortLag)
		DBM:AddMsg(L.LAG_HEADER)
		for _, v in ipairs(sortLag) do
			local name = v.name
			local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
			if playerColor then
				name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
			end
			if v.worldlag then
				DBM:AddMsg(L.LAG_ENTRY:format(name, v.worldlag, v.homelag), false)
			else
				tinsert(noLagResponse, v.name)
			end
		end
		if #noLagResponse > 0 then
			DBM:AddMsg(L.LAG_FOOTER:format(tconcat(noLagResponse, ", ")), false)
		end
	end

	if LibLatency then
		LibLatency:Register("DBM", function(homelag, worldlag, sender)
			if not sender then
				return
			end
			local player = DBM:GetRaidRoster()[sender]
			if player then
				player.homelag = homelag
				player.worldlag = worldlag
			end
		end)
	end

	local function SortDurability(v1, v2)
		return (v1.durpercent or 0) < (v2.durpercent or 0)
	end

	function ShowDurability()
		local sortDur, noDurResponse = {}, {}
		for _, v in pairs(DBM:GetRaidRoster()) do
			tinsert(sortDur, v)
		end
		tsort(sortDur, SortDurability)
		DBM:AddMsg(L.DUR_HEADER)
		for _, v in ipairs(sortDur) do
			local name = v.name
			local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
			if playerColor then
				name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
			end
			if v.durpercent then
				DBM:AddMsg(L.DUR_ENTRY:format(name, v.durpercent, v.durbroken), false)
			else
				tinsert(noDurResponse, v.name)
			end
		end
		if #noDurResponse > 0 then
			DBM:AddMsg(L.LAG_FOOTER:format(tconcat(noDurResponse, ", ")), false)
		end
	end

	if LibDurability then
		LibDurability:Register("DBM", function(percent, broken, sender)
			if not sender then
				return
			end
			local player = DBM:GetRaidRoster()[sender]
			if player then
				player.durpercent = percent
				player.durbroken = broken
			end
		end)
	end
end

if not _G["BigWigs"] then
	--Register pull and break slash commands for BW converts, if BW isn't loaded
	--This shouldn't raise an issue since BW SHOULD load before DBM in any case they are both present.
	SLASH_DEADLYBOSSMODSPULL1 = "/pull"
	SlashCmdList["DEADLYBOSSMODSPULL"] = function(msg)
		Pull(tonumber(msg) or 10)
	end
	SLASH_DEADLYBOSSMODSBREAK1 = "/break"
	SlashCmdList["DEADLYBOSSMODSBREAK"] = function(msg)
		Break(tonumber(msg) or 10)
	end
end

SLASH_DEADLYBOSSMODSRPULL1 = "/rpull"
SlashCmdList["DEADLYBOSSMODSRPULL"] = function()
	Pull(30)
end

local trackedHudMarkers = {}
SLASH_DEADLYBOSSMODS1 = "/dbm"
SlashCmdList["DEADLYBOSSMODS"] = function(msg)
	if not DBM:IsEnabled() then
		DBM:ForceDisableSpam()
		return
	end
	local cmd = msg:lower()
	if cmd == "ver" or cmd == "version" then
		DBM:ShowVersions(false)
	elseif cmd == "ver2" or cmd == "version2" then
		DBM:ShowVersions(true)
	elseif cmd == "unlock" or cmd == "move" then
		DBT:ShowMovableBar()
	elseif cmd == "help2" then
		for _, v in ipairs(L.SLASHCMD_HELP2) do
			DBM:AddMsg(v)
		end
	elseif cmd == "help" then
		for _, v in ipairs(L.SLASHCMD_HELP) do
			DBM:AddMsg(v)
		end
	elseif cmd:sub(1, 13) == "timer endloop" then
		DBM:CreatePizzaTimer(0, "", nil, nil, nil, true)
	elseif cmd:sub(1, 5) == "timer" then
		local time, text = msg:match("^%w+ ([%d:]+) (.+)$")
		if not time and not text then
			for _, v in ipairs(L.TIMER_USAGE) do
				DBM:AddMsg(v)
			end
			return
		end
		local min, sec = string.split(":", time)
		min = tonumber(min or "") or 0
		sec = tonumber(sec or "")
		if min and not sec then
			sec = min
			min = 0
		end
		DBM:CreatePizzaTimer(min * 60 + sec, text)
	elseif cmd:sub(1, 6) == "ltimer" then
		local time, text = msg:match("^%w+ ([%d:]+) (.+)$")
		if not time and not text then
			DBM:AddMsg(L.PIZZA_ERROR_USAGE)
			return
		end
		local min, sec = string.split(":", time)
		min = tonumber(min or "") or 0
		sec = tonumber(sec or "")
		if min and not sec then
			sec = min
			min = 0
		end
		DBM:CreatePizzaTimer(min * 60 + sec, text, nil, nil, true)
	elseif cmd:sub(1, 15) == "broadcast timer" then--Standard Timer
		local difficultyIndex = DBM:GetCurrentDifficulty()
		local permission = true
		if DBM:GetRaidRank() == 0 or difficultyIndex == 7 or difficultyIndex == 17 or IsTrialAccount() then
			DBM:AddMsg(L.ERROR_NO_PERMISSION)
			permission = false
		end
		local time, text = msg:match("^%w+ %w+ ([%d:]+) (.+)$")
		if not time and not text then
			DBM:AddMsg(L.PIZZA_ERROR_USAGE)
			return
		end
		local min, sec = string.split(":", time)
		min = tonumber(min or "") or 0
		sec = tonumber(sec or "")
		if min and not sec then
			sec = min
			min = 0
		end
		DBM:CreatePizzaTimer(min * 60 + sec, text, permission)
	elseif cmd:sub(1, 16) == "broadcast ltimer" then
		local difficultyIndex = DBM:GetCurrentDifficulty()
		local permission = true
		if DBM:GetRaidRank() == 0 or difficultyIndex == 7 or difficultyIndex == 17 or IsTrialAccount() then
			DBM:AddMsg(L.ERROR_NO_PERMISSION)
			permission = false
		end
		local time, text = msg:match("^%w+ %w+ ([%d:]+) (.+)$")
		if not time and not text then
			DBM:AddMsg(L.PIZZA_ERROR_USAGE)
			return
		end
		local min, sec = string.split(":", time)
		min = tonumber(min or "") or 0
		sec = tonumber(sec or "")
		if min and not sec then
			sec = min
			min = 0
		end
		DBM:CreatePizzaTimer(min * 60 + sec, text, permission, nil, true)
	elseif cmd:sub(0,5) == "break" then
		Break(tonumber(cmd:sub(6)) or 5)
	elseif cmd:sub(1, 4) == "pull" then
		Pull(tonumber(cmd:sub(5)) or 10)
	elseif cmd:sub(1, 5) == "rpull" then
		Pull(30)
	elseif cmd:sub(1, 3) == "lag" then
		if not LibLatency then
			DBM:AddMsg(L.UPDATE_REQUIRES_RELAUNCH)
			return
		end
		LibLatency:RequestLatency()
		DBM:AddMsg(L.LAG_CHECKING)
		C_Timer.After(5, ShowLag)
	elseif cmd:sub(1, 10) == "durability" then
		if not LibDurability then
			DBM:AddMsg(L.UPDATE_REQUIRES_RELAUNCH)
			return
		end
		LibDurability:RequestDurability()
		DBM:AddMsg(L.DUR_CHECKING)
		C_Timer.After(5, ShowDurability)
	elseif cmd:sub(1, 3) == "hud" then
		DBM:UpdateMapRestrictions()
		if DBM:HasMapRestrictions() then
			DBM:AddMsg(L.NO_HUD)
			return
		end
		local hudType, target, duration = string.split(" ", cmd:sub(4):trim())
		local _, targetOG, _ = string.split(" ", msg:sub(4):trim())
		if hudType == "" then
			for _, v in ipairs(L.HUD_USAGE) do
				DBM:AddMsg(v)
			end
			return
		end
		local hudDuration = tonumber(duration) or 1200 -- If no duration defined. 20 minutes to cover even longest of fights
		if type(hudType) == "string" and hudType:trim() ~= "" then
			if hudType == "hide" then
				for _, name in ipairs(trackedHudMarkers) do
					DBM.HudMap:FreeEncounterMarkerByTarget(12345, name)
				end
				table.wipe(trackedHudMarkers)
				return
			end
			if not target then
				DBM:AddMsg(L.HUD_INVALID_TARGET)
				return
			end
			local uId
			if target == "target" and UnitExists("target") then
				uId = "target"
			elseif private.isRetail and target == "focus" and UnitExists("focus") then
				uId = "focus"
			else -- Try to use it as player name
				uId = DBM:GetRaidUnitId(targetOG)
			end
			if not uId then
				DBM:AddMsg(L.HUD_INVALID_TARGET)
				return
			end
			if UnitIsUnit("player", uId) and not DBM.Options.DebugMode then -- Don't allow hud to self, except if debug mode is enabled, then hud to self useful for testing
				DBM:AddMsg(L.HUD_INVALID_SELF)
				return
			end
			local targetName = UnitName(uId)
			if hudType == "arrow" then
				local playerName = UnitName("player")
				local _, targetClass = UnitClass(uId)
				local color2 = RAID_CLASS_COLORS[targetClass]
				local m1 = DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "party", playerName, 0.1, hudDuration, 0, 1, 0, 1, nil):Appear()
				local m2 = DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "party", targetName, 0.75, hudDuration, color2.r, color2.g, color2.b, 1, nil):Appear()
				tinsert(trackedHudMarkers, playerName)
				tinsert(trackedHudMarkers, targetName)
				m2:EdgeTo(m1, nil, hudDuration, 0, 1, 0, 1)
				DBM:AddMsg(L.HUD_SUCCESS:format(DBM:strFromTime(hudDuration)))
			elseif hudType == "dot" then
				local _, targetClass = UnitClass(uId)
				local color2 = RAID_CLASS_COLORS[targetClass]
				DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "party", targetName, 0.75, hudDuration, color2.r, color2.g, color2.b, 1, nil):Appear()
				tinsert(trackedHudMarkers, targetName)
				DBM:AddMsg(L.HUD_SUCCESS:format(DBM:strFromTime(hudDuration)))
			elseif hudType == "green" then
				DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "highlight", targetName, 3.5, hudDuration, 0, 1, 0, 0.5, nil):Pulse(0.5, 0.5)
				tinsert(trackedHudMarkers, targetName)
				DBM:AddMsg(L.HUD_SUCCESS:format(DBM:strFromTime(hudDuration)))
			elseif hudType == "red" then
				DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "highlight", targetName, 3.5, hudDuration, 1, 0, 0, 0.5, nil):Pulse(0.5, 0.5)
				tinsert(trackedHudMarkers, targetName)
				DBM:AddMsg(L.HUD_SUCCESS:format(DBM:strFromTime(hudDuration)))
			elseif hudType == "yellow" then
				DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "highlight", targetName, 3.5, hudDuration, 1, 1, 0, 0.5, nil):Pulse(0.5, 0.5)
				tinsert(trackedHudMarkers, targetName)
				DBM:AddMsg(L.HUD_SUCCESS:format(DBM:strFromTime(hudDuration)))
			elseif hudType == "blue" then
				DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "highlight", targetName, 3.5, hudDuration, 0, 0, 1, 0.5, nil):Pulse(0.5, 0.5)
				tinsert(trackedHudMarkers, targetName)
				DBM:AddMsg(L.HUD_SUCCESS:format(DBM:strFromTime(hudDuration)))
			elseif hudType == "icon" then
				local icon = GetRaidTargetIndex(uId)
				if not icon then
					DBM:AddMsg(L.HUD_INVALID_ICON)
					return
				end
				DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, DBM:IconNumToString(icon):lower(), targetName, 3.5, hudDuration, 1, 1, 1, 0.5, nil):Pulse(0.5, 0.5)
				tinsert(trackedHudMarkers, targetName)
				DBM:AddMsg(L.HUD_SUCCESS:format(DBM:strFromTime(hudDuration)))
			else
				DBM:AddMsg(L.HUD_INVALID_TYPE)
			end
		end
	elseif cmd:sub(1, 5) == "arrow" then
		DBM:UpdateMapRestrictions()
		if DBM:HasMapRestrictions() then
			DBM:AddMsg(L.NO_ARROW)
			return
		end
		local x, y, z = string.split(" ", cmd:sub(6):trim())
		local xOG, _, _ = string.split(" ", msg:sub(6):trim())
		local xNum, yNum, zNum = tonumber(x or ""), tonumber(y or ""), tonumber(z or "")
		if xNum and yNum then
			DBM.Arrow:ShowRunTo(xNum, yNum, 0)
			return
		elseif type(x) == "string" and x:trim() ~= "" then
			local subCmd = x:trim()
			if subCmd== "hide" then
				DBM.Arrow:Hide()
				return
			elseif subCmd == "move" then
				DBM.Arrow:Move()
				return
			elseif subCmd == "target" then
				DBM.Arrow:ShowRunTo("target")
				return
			elseif private.isRetail and subCmd == "focus" then
				DBM.Arrow:ShowRunTo("focus")
				return
			elseif subCmd == "map" then
				DBM.Arrow:ShowRunTo(yNum, zNum, 0, nil, true)
				return
			elseif DBM:GetRaidUnitId(xOG:trim()) then
				DBM.Arrow:ShowRunTo(xOG:trim())
				return
			end
		end
		for _, v in ipairs(L.ARROW_ERROR_USAGE) do
			DBM:AddMsg(v)
		end
	elseif cmd:sub(1, 10) == "debuglevel" then
		local level = tonumber(cmd:sub(11)) or 1
		if level < 1 or level > 3 then
			DBM:AddMsg("Invalid Value. Debug Level must be between 1 and 3.")
			return
		end
		DBM.Options.DebugLevel = level
		DBM:AddMsg("Debug Level is " .. level)
	elseif cmd:sub(1, 10) == "debugsound" then
		DBM.Options.DebugSound = not DBM.Options.DebugSound
		DBM:AddMsg("Debug Sound is " .. (DBM.Options.DebugSound and "ON" or "OFF"))
	elseif cmd:sub(1, 5) == "debug" then
		DBM.Options.DebugMode = not DBM.Options.DebugMode
		DBM:AddMsg("Debug Message is " .. (DBM.Options.DebugMode and "ON" or "OFF"))
		private:GetModule("DevToolsModule"):OnDebugToggle()
	elseif cmd:sub(1, 4) == "test" then
		local args = msg:sub(5):trim()
		if args == "" then
			DBM:DemoMode()
		else
			test:HandleCommand(string.split(" ", args))
		end
	elseif cmd:sub(1, 8) == "whereiam" or cmd:sub(1, 8) == "whereami" then
		local x, y, _, map = UnitPosition("player")
		local mapID = C_Map.GetBestMapForUnit("player") or -1
		DBM:UpdateMapRestrictions()
		if DBM:HasMapRestrictions() then
			DBM:AddMsg(("Location Information\nYou are at zone %u (%s).\nLocal Map ID %u (%s)"):format(map, GetRealZoneText(map), mapID, GetZoneText()))
		else
			local pos = C_Map.GetPlayerMapPosition(mapID, "player")
			DBM:AddMsg(("Location Information\nYou are at zone %u (%s): x=%f, y=%f.\nLocal Map ID %u (%s): x=%f, y=%f"):format(map, GetRealZoneText(map), x, y, mapID, GetZoneText(), pos and pos.x or 0, pos and pos.y or 0))
		end
	elseif cmd:sub(1, 7) == "request" then
		DBM:Unschedule(DBM.RequestTimers)
		DBM:RequestTimers(1)
		DBM:RequestTimers(2)
		DBM:RequestTimers(3)
	elseif cmd:sub(1, 6) == "silent" then
		DBM.Options.SilentMode = not DBM.Options.SilentMode
		DBM:AddMsg(L.SILENTMODE_IS .. (DBM.Options.SilentMode and "ON" or "OFF"))
	elseif cmd:sub(1, 10) == "musicstart" then
		DBM:TransitionToDungeonBGM(true)
	elseif cmd:sub(1, 9) == "musicstop" then
		DBM:TransitionToDungeonBGM(false, true)
	elseif cmd:sub(1, 9) == "infoframe" then
		if DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:Hide()
		else
			DBM.InfoFrame:Show(5, "test")
		end
	elseif cmd:sub(1, 10) == "aggroframe" then
		if DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:Hide()
		else
			DBM.InfoFrame:SetHeader(L.INFOFRAME_AGGRO)
			DBM.InfoFrame:Show(7, "playeraggro", 1)
		end
	else
		DBM:LoadGUI()
	end
end
