---@class DBMCoreNamespace
local private = select(2, ...)

local L = DBM_CORE_L

---@class DBM
local DBM = private:GetPrototype("DBM")
local difficulties = private:GetPrototype("Difficulties")


local statOrder = {
	"follower", "story", "lfr", "normal", "normal25", "heroic", "heroic25", "mythic", "challenge", "timewalker"
}

local function addStats(tooltip, mod)
	local curDifficultyStatType = difficulties.statVarTable[DBM:GetCurrentInstanceDifficulty()]
	-- this is copy & paste from DBM-GUI.lua, should probably be unified somewhere
	local statSplit, statCount = {}, 0
	for stat in (mod.statTypes or mod.addon.statTypes):gmatch("%s?([^%s,]+)%s?,?") do
		statSplit[stat] = true
		statCount = statCount + 1
	end
	local statTypes = {
		follower	= DBM_CORE_L.FOLLOWER,
		story		= DBM_CORE_L.STORY,
		lfr25		= PLAYER_DIFFICULTY3,
		normal		= mod.addon.minExpansion < 5 and not DBM:IsSeasonal("SeasonOfDiscovery") and RAID_DIFFICULTY1 or PLAYER_DIFFICULTY1,
		normal25	= RAID_DIFFICULTY2,
		heroic		= mod.addon.minExpansion < 5 and not DBM:IsSeasonal("SeasonOfDiscovery") and RAID_DIFFICULTY3 or PLAYER_DIFFICULTY2,
		heroic25	= RAID_DIFFICULTY4,
		mythic		= PLAYER_DIFFICULTY6,
		challenge	= (mod.addon.minExpansion < 6 and not mod.upgradedMPlus) and CHALLENGE_MODE or PLAYER_DIFFICULTY6 .. "+",
		timewalker	= PLAYER_DIFFICULTY_TIMEWALKER
	}
	if (mod.addon.type == "PARTY" or mod.addon.type == "SCENARIO") or -- Fixes dungeons being labled incorrectly
		(mod.addon.type == "RAID" and statSplit["timewalker"]) or -- Fixes raids with timewalker being labled incorrectly
		(mod.instanceId == 369) then -- Fixes SoO being labled incorrectly
		statTypes.normal = PLAYER_DIFFICULTY1
		statTypes.heroic = PLAYER_DIFFICULTY2
	end
	local showAll = IsModifierKeyDown()
	for _, statType in ipairs(statOrder) do
		if statSplit[statType] then
			if statType == "lfr" then
				statType = "lfr25" -- Because Myst stores stats weird
			end
			local kills, pulls, bestRank, bestTime = mod.stats[statType .. "Kills"] or 0, mod.stats[statType .. "Pulls"] or 0, mod.stats[statType .. "BestRank"] or 0, mod.stats[statType .. "BestTime"]
			-- curDifficultyStatType
			if curDifficultyStatType == statType or showAll then
				tooltip:AddDoubleLine(L.TOOLTIP_KILLS:format(statTypes[statType]), kills)
				tooltip:AddDoubleLine(L.TOOLTIP_WIPES:format(statTypes[statType]), pulls - kills)
				if bestTime and bestTime > 0 then
					if bestRank and bestRank > 0 then
						tooltip:AddDoubleLine(L.TOOLTIP_FASTEST:format(statTypes[statType]), ("%d:%02d (%d)"):format(math.floor(bestTime / 60), bestTime % 60, bestRank))
					else
						tooltip:AddDoubleLine(L.TOOLTIP_FASTEST:format(statTypes[statType]), ("%d:%02d"):format(math.floor(bestTime / 60), bestTime % 60))
					end
				end
			end

		end
	end
end

local newTooltipApi = TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall

local function hook(self)
	if self:IsForbidden() or self ~= GameTooltip then
		return
	end
	if not DBM.Options.EnableTooltip then return end
	if not DBM.Options.EnableTooltipInCombat and (InCombatLockdown() or IsEncounterInProgress() or DBM:InCombat()) then
		return
	end
	local guid
	if newTooltipApi then
		local data = self:GetTooltipData()
		guid = data and data.guid
	else
		local _, unit = self:GetUnit()
		guid = unit and UnitGUID(unit)
	end
	if not guid then return end
	local mod = DBM:GetModByCreatureId(DBM:GetCIDFromGUID(guid))
	if not mod then return end
	if DBM.Options.EnableTooltipHeader then
		self:AddLine(L.TOOLTIP_DBM)
	end
	if mod.enrageTimer then
		self:AddDoubleLine(L.TOOLTIP_ENRAGE_TIMER, ("%d:%02d"):format(math.floor(mod.enrageTimer / 60), mod.enrageTimer % 60))
	end
	addStats(self, mod)
end

if newTooltipApi then
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, hook)
else
	GameTooltip:HookScript("OnTooltipSetUnit", hook)
end

if not newTooltipApi then
	local f = CreateFrame("Frame")
	f:RegisterEvent("MODIFIER_STATE_CHANGED")
	f:SetScript("OnEvent", function()
		local _, unit = GameTooltip:GetUnit()
		if unit then
			GameTooltip:SetUnit(unit)
		end
	end)
end
