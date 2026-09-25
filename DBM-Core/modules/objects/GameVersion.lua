---@class DBMCoreNamespace
local private = select(2, ...)

private.wowTOC = (select(4, GetBuildInfo()))
private.testBuild = IsTestBuild() or IsBetaBuild()
private.isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1) and private.wowTOC >= 120000
private.isClassic = (WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2)) and private.wowTOC < 20000
private.isHardcoreServer = C_GameRules and C_GameRules.IsHardcoreActive and C_GameRules.IsHardcoreActive()
private.currentSeason = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2) and C_Seasons and C_Seasons.HasActiveSeason() and C_Seasons.GetActiveSeason()
private.isBCC = (WOW_PROJECT_ID == (WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5)) or (private.wowTOC >= 20000 and private.wowTOC < 30000)
private.isWrath = WOW_PROJECT_ID == (WOW_PROJECT_WRATH_CLASSIC or 11)
private.isCata = WOW_PROJECT_ID == (WOW_PROJECT_CATACLYSM_CLASSIC or 14)
private.isMop = WOW_PROJECT_ID == (WOW_PROJECT_MISTS_CLASSIC or 19)
private.isForever = private.wowTOC == 16001

-- Keep the game API selection here so all core files use the same player identity.
function private:ReadPlayerName()
	return self.isForever and GetUnitName("player") or UnitName("player")
end

private.playerName = private:ReadPlayerName()
local playerNameCallbacks = {}

function private:RegisterPlayerNameCallback(callback)
	-- Files loaded after ADDON_LOADED already read the reconciled cached name.
	if not playerNameCallbacks then return end
	playerNameCallbacks[#playerNameCallbacks + 1] = callback
	if DBM and DBM.RegisterCallback then
		DBM:RegisterCallback("DBM_PlayerNameChanged", callback)
	end
end

function private:ActivatePlayerNameCallbacks()
	for _, callback in ipairs(playerNameCallbacks) do
		DBM:RegisterCallback("DBM_PlayerNameChanged", callback)
	end
end

function private:ClearPlayerNameCallbacks()
	for _, callback in ipairs(playerNameCallbacks) do
		DBM:UnregisterCallback("DBM_PlayerNameChanged", callback)
	end
	playerNameCallbacks = nil
end

function private:UpdatePlayerName(name)
	if not name or name == self.playerName then return end
	self.playerName = name
	DBM:FireEvent("DBM_PlayerNameChanged", name)
end

--TODO, see if https://wago.tools/db2/GameMode?build=1.60.1.69893 useful
