---@diagnostic disable: cast-local-type
---@class DBMCoreNamespace
local private = select(2, ...)

local L = DBM_CORE_L

local test = private:GetPrototype("DBMTest")

if not _G["BigWigs"] then
	--Register pull and break slash commands for BW converts, if BW isn't loaded
	--This shouldn't raise an issue since BW SHOULD load before DBM in any case they are both present.
	SLASH_DEADLYBOSSMODSPULL1 = "/pull"
	SlashCmdList["DEADLYBOSSMODSPULL"] = function(msg)
		DBM:CreatePullTimer(tonumber(msg) or 10)
	end
	SLASH_DEADLYBOSSMODSBREAK1 = "/break"
	SlashCmdList["DEADLYBOSSMODSBREAK"] = function(msg)
		DBM:CreateBreakTimer(tonumber(msg) or 10)
	end
end

SLASH_DEADLYBOSSMODSRPULL1 = "/rpull"
SlashCmdList["DEADLYBOSSMODSRPULL"] = function()
	DBM:CreatePullTimer(30)
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
		DBM:CreateBreakTimer(tonumber(cmd:sub(6)) or 5)
	elseif cmd:sub(1, 4) == "pull" then
		DBM:CreatePullTimer(tonumber(cmd:sub(5)) or 10)
	elseif cmd:sub(1, 5) == "rpull" then
		DBM:CreatePullTimer(30)
	elseif cmd:sub(1, 3) == "lag" then
		DBM.Latency:Show()
	elseif cmd:sub(1, 10) == "durability" or cmd:sub(1, 3) == "dur" then
		DBM.Durability:Show()
	elseif DBM.Keystones and (cmd:sub(1, 3) == "key" or cmd:sub(1, 4) == "keys") then
		DBM.Keystones:Show()
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
