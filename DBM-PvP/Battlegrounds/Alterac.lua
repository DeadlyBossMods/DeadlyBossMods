-- Alterac mod v3.0
-- rewrite by Nitram and Tandanu

local Alterac	= DBM:NewMod("z30", "DBM-PvP", 2)
local L			= Alterac:GetLocalizedStrings()

Alterac:SetZone(DBM_DISABLE_ZONE_DETECTION)

Alterac:AddBoolOption("AutoTurnIn")
Alterac:RemoveOption("HealthFrame")
Alterac:RemoveOption("SpeedKillTimer")

Alterac:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA" 	-- Required for BG start
)

local towerTimer = Alterac:NewTimer(243, "TimerTower", "Interface\\Icons\\Spell_Shadow_HellifrePVPCombatMorale")
local gyTimer = Alterac:NewTimer(243, "TimerGY", "Interface\\Icons\\Spell_Shadow_AnimateDead")

local allyTowerIcon = "Interface\\AddOns\\DBM-PvP\\Textures\\GuardTower"
local allyColor = {
	r = 0,
	g = 0,
	b = 1,
}
local hordeTowerIcon = "Interface\\AddOns\\DBM-PvP\\Textures\\OrcTower"
local hordeColor = {
	r = 1,
	g = 0,
	b = 0,
}

local graveyards = {}
local function is_graveyard(id)
	return id == 15 or id == 4 or id == 13 or id == 14 or id == 8 
end
local function gy_state(id)
	if id == 8 then			return -1	-- Neutral
	elseif id == 15 then	return 1	-- Alliance controlled
	elseif id == 13 then 	return 2	-- Horde controlled
	elseif id == 4 then		return 3	-- Alliance assaulted
	elseif id == 14 then	return 4	-- Horde assaulted
	else return false
	end
end

local towers = {}
local function is_tower(id)
	return id == 10 or id == 12 or id == 11 or id == 9 or id == 6
end
local function tower_state(id)
	if id == 6 then			return -1	-- Neutral / Destroyed
	elseif id == 11 then	return 1	-- Alliance controlled
	elseif id == 10 then	return 2	-- Horde controlled
	elseif id == 9 then		return 3	-- Alliance assaulted
	elseif id == 12 then	return 4	-- Horde assaulted
	else return false
	end
end

local bgzone = false
do
	local function AV_Initialize()
		if DBM:GetCurrentArea() == 401 then
			Alterac:RegisterShortTermEvents(
				"CHAT_MSG_MONSTER_YELL",
				"CHAT_MSG_BG_SYSTEM_ALLIANCE",
				"CHAT_MSG_BG_SYSTEM_HORDE",
				"CHAT_MSG_BG_SYSTEM_NEUTRAL",
				"RAID_BOSS_EMOTE",
				"GOSSIP_SHOW",
				"QUEST_PROGRESS",
				"QUEST_COMPLETE"
			)
			bgzone = true
			for i=1, GetNumMapLandmarks(), 1 do
				local name, _, textureIndex = GetMapLandmarkInfo(i)
				if name and textureIndex then
					if is_graveyard(textureIndex) then
						graveyards[i] = textureIndex
					elseif is_tower(textureIndex) then
						towers[i] = textureIndex
					end
				end
			end
		elseif bgzone then
			bgzone = false
			Alterac:UnregisterShortTermEvents()
		end
	end
	Alterac.OnInitialize = Alterac:Schedule(3, AV_Initialize)
	Alterac.ZONE_CHANGED_NEW_AREA = Alterac:Schedule(3, AV_Initialize)--Core is also watching ZONE_CHANGED_NEW_AREA but we want core to do it's thing before we call DBM:GetCurrentArea()
end

do
	local function check_for_updates()
		if not bgzone then return end
		for k,v in pairs(graveyards) do
			local name, _, textureIndex = GetMapLandmarkInfo(k)
			if name and textureIndex then
				-- work-around for a bug in the german localization of WoW: the graveyard seems to change its name depending on the state
				if name == "Friedhof des Sturmlanzen" then
					name = "Friedhof der Sturmlanzen"
				end
				local curState = gy_state(textureIndex)
				if curState and gy_state(v) ~= curState then
					gyTimer:Stop(name)
					if curState > 2 then
						gyTimer:Start(nil, name)
						if curState == 3 then
							gyTimer:SetColor(allyColor, name)
						else
							gyTimer:SetColor(hordeColor, name)
						end
					end
				end
				graveyards[k] = textureIndex
			end		 
		end
		for k,v in pairs(towers) do
			local name, _, textureIndex = GetMapLandmarkInfo(k)
			if name and textureIndex then
				local curState = tower_state(textureIndex)
				if curState and tower_state(v) ~= curState then
					towerTimer:Stop(name)
					if curState > 2 then
						towerTimer:Start(nil, name)
						if curState == 3 then
							towerTimer:SetColor(allyColor, name)
							towerTimer:UpdateIcon(hordeTowerIcon, name)
						else
							towerTimer:SetColor(hordeColor, name)
							towerTimer:UpdateIcon(allyTowerIcon, name)
						end
					end
				end
				towers[k] = textureIndex
			end		 
		end
	end
	
	local function schedule_check(self)
		self:Schedule(1, check_for_updates)
	end

	Alterac.CHAT_MSG_MONSTER_YELL = schedule_check
	Alterac.CHAT_MSG_BG_SYSTEM_ALLIANCE = schedule_check
	Alterac.CHAT_MSG_BG_SYSTEM_HORDE = schedule_check
	Alterac.RAID_BOSS_EMOTE = schedule_check
	Alterac.CHAT_MSG_BG_SYSTEM_NEUTRAL = schedule_check
end

local quests
do
	local getQuestName
	do
		local tooltip = CreateFrame("GameTooltip", "DBM-PvP_Tooltip")
		tooltip:SetOwner(UIParent, "ANCHOR_NONE")
		tooltip:AddFontStrings(tooltip:CreateFontString("$parentText", nil, "GameTooltipText"), tooltip:CreateFontString("$parentTextRight", nil, "GameTooltipText"))

		function getQuestName(id)
			tooltip:ClearLines()
			tooltip:SetHyperlink("quest:"..id)
			return _G[tooltip:GetName().."Text"]:GetText()
		end
	end
	
	local function loadQuests()
		for i, v in pairs(quests) do
			if type(v[1]) == "table" then
				for i, v in ipairs(v) do
					v[1] = getQuestName(v[1]) or v[1]
				end
			else
				v[1] = getQuestName(v[1]) or v[1]
			end
		end
	end

	quests = {
		[13442] = {
			{7386, 17423, 5},
			{6881, 17423},
		},
		[13236] = {
			{7385, 17306, 5},
			{6801, 17306},
		},
		[13257] = {6781, 17422, 20},
		[13176] = {6741, 17422, 20},
		[13577] = {7026, 17643},
		[13179] = {6825, 17326},
		[13438] = {6942, 17502},
		[13180] = {6826, 17327},
		[13181] = {6827, 17328},
		[13439] = {6941, 17503},
		[13437] = {6943, 17504},	
		[13441] = {7002, 17642},	
	}	
	
	loadQuests() -- requests the quest information from the server
	Alterac:Schedule(5, loadQuests) -- information should be available now....load it
	Alterac:Schedule(15, loadQuests) -- sometimes this requires a lot more time, just to be sure!
end

local function isQuestAutoTurnInQuest(name)
	for i, v in pairs(quests) do
		if type(v[1]) == "table" then
			for i, v in ipairs(v) do
				if v[1] == name then return true end
			end
		else
			if v[1] == name then return true end
		end
	end
end

local function acceptQuestByName(name)
	for i = 1, select("#", GetGossipAvailableQuests()), 5 do
		if select(i, GetGossipAvailableQuests()) == name then
			SelectGossipAvailableQuest(math.ceil(i/5))
			break
		end
	end
end

local function checkItems(item, amount)
	local found = 0
	for bag = 0, NUM_BAG_SLOTS do
		for i = 1, GetContainerNumSlots(bag) do
			if tonumber((GetContainerItemLink(bag, i) or ""):match(":(%d+):") or 0) == item then
				found = found + select(2, GetContainerItemInfo(bag, i))
			end
		end
	end
	return found >= amount
end

function Alterac:GOSSIP_SHOW()
	if not bgzone or not self.Options.AutoTurnIn then return end
	local quest = quests[tonumber(self:GetCIDFromGUID(UnitGUID("target") or "")) or 0]
	if quest and type(quest[1]) == "table" then
		for i, v in ipairs(quest) do
			if checkItems(v[2], v[3] or 1) then
				acceptQuestByName(v[1])
				break
			end
		end
	elseif quest then
		if checkItems(quest[2], quest[3] or 1) then acceptQuestByName(quest[1]) end
	end
end

function Alterac:QUEST_PROGRESS()
	if bgzone and isQuestAutoTurnInQuest(GetTitleText()) then
		CompleteQuest()
	end
end

function Alterac:QUEST_COMPLETE()
	if bgzone and isQuestAutoTurnInQuest(GetTitleText()) then
		GetQuestReward(0)
	end
end
