---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")
---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")

-- Automatic turn-ins for quests that only take items collected in one place (battleground quest items, for example).
-- Uses the same APIs as Questie's auto turn-in. Quests are matched by ID, not by NPC: NPC GUIDs can be secret
-- (e.g. in PvP matches), quest IDs are not.

---@class QuestTurnIn
local questTurnInPrototype = private:GetPrototype("QuestTurnIn")
local mt = {__index = questTurnInPrototype}

local ipairs, pairs, next, select = ipairs, pairs, next, select
local GetItemCount = C_Item and C_Item.GetItemCount or GetItemCount
local GetActiveQuests, GetAvailableQuests = C_GossipInfo.GetActiveQuests, C_GossipInfo.GetAvailableQuests
local SelectGossipActiveQuest, SelectGossipAvailableQuest = C_GossipInfo.SelectActiveQuest, C_GossipInfo.SelectAvailableQuest
-- The quest greeting selectors take the list position; the annotations (vscode-wow-api 0.22.3) are missing it
---@type fun(index: number)
local SelectActiveQuest = SelectActiveQuest
---@type fun(index: number)
local SelectAvailableQuest = SelectAvailableQuest

local EVENTS = {"GOSSIP_SHOW", "QUEST_GREETING", "QUEST_DETAIL", "QUEST_PROGRESS", "QUEST_COMPLETE"}
local eventFrame -- created on first activation, its events are only registered while a turn-in is active
local active = {} ---@type table<QuestTurnIn, true>

---@param questID number?
function questTurnInPrototype:IsTurnIn(questID)
	return questID ~= nil and not DBM:issecretvalue(questID) and self.quests[questID] ~= nil
end

---@param questID number?
function questTurnInPrototype:HasItems(questID)
	if not self:IsTurnIn(questID) then return false end
	---@cast questID number
	local quest = self.quests[questID]
	return GetItemCount(quest[1]) >= quest[2]
end

-- Of several quests we have the items for, prefer the one that takes the most (5 crystals over 1)
---@param count number
---@param getQuestID fun(i: number): number?
function questTurnInPrototype:BestAvailable(count, getQuestID)
	local best, bestCount
	for i = 1, count do
		local questID = getQuestID(i)
		if self:HasItems(questID) and (not bestCount or self.quests[questID][2] > bestCount) then
			best, bestCount = i, self.quests[questID][2]
		end
	end
	return best
end

function questTurnInPrototype:GOSSIP_SHOW()
	for _, quest in ipairs(GetActiveQuests()) do
		if quest.isComplete and self:IsTurnIn(quest.questID) then
			SelectGossipActiveQuest(quest.questID)
			return true
		end
	end
	local available = GetAvailableQuests()
	local index = self:BestAvailable(#available, function(i) return available[i].questID end)
	if index then
		SelectGossipAvailableQuest(available[index].questID)
		return true
	end
end

-- NPCs without gossip open the quest greeting instead
function questTurnInPrototype:QUEST_GREETING()
	for i = 1, GetNumActiveQuests() do
		local _, isComplete = GetActiveTitle(i)
		if isComplete and self:IsTurnIn(GetActiveQuestID(i)) then
			SelectActiveQuest(i)
			return true
		end
	end
	-- Forever has the quest ID in position 5 (see Questie's QuestieCompat.GetQuestGreetingQuestID)
	local index = self:BestAvailable(GetNumAvailableQuests(), function(i) return (select(5, GetAvailableQuestInfo(i))) end)
	if index then
		SelectAvailableQuest(index)
		return true
	end
end

function questTurnInPrototype:QUEST_DETAIL()
	if self:HasItems(GetQuestID()) then
		AcceptQuest()
		return true
	end
end

function questTurnInPrototype:QUEST_PROGRESS()
	if self:IsTurnIn(GetQuestID()) and IsQuestCompletable() then
		CompleteQuest()
		return true
	end
end

function questTurnInPrototype:QUEST_COMPLETE()
	if self:IsTurnIn(GetQuestID()) and GetNumQuestChoices() <= 1 then
		GetQuestReward(1)
		return true
	end
end

local function onEvent(_, event)
	-- Shift (like Questie's default modifier) or DBM's global auto gossip opt-out keep the dialog manual
	if DBM.Options.DontAutoGossip or IsShiftKeyDown() then return end
	for turnIn in pairs(active) do
		if turnIn[event](turnIn) then return end
	end
end

-- Handles dialogs while enabled by the mod and the option is on; registers events only while that is the case.
function questTurnInPrototype:Update()
	local wasActive = next(active) ~= nil
	active[self] = (self.enabled and self.mod.Options[self.option]) and true or nil
	local isActive = next(active) ~= nil
	if isActive == wasActive then return end
	if isActive then
		eventFrame = eventFrame or CreateFrame("Frame")
		eventFrame:SetScript("OnEvent", onEvent)
		for _, event in ipairs(EVENTS) do
			eventFrame:RegisterEvent(event)
		end
	else
		eventFrame:UnregisterAllEvents()
	end
end

--- Start handling dialogs, e.g. when entering the zone the quests belong to.
function questTurnInPrototype:Enable()
	self.enabled = true
	self:Update()
end

--- Stop handling dialogs, e.g. when leaving the zone.
function questTurnInPrototype:Disable()
	self.enabled = false
	self:Update()
end

--- Automatic turn-ins for item quests, controlled by an "AutoGossipQuest" option. Call Enable/Disable around the
--- time the quests can be turned in, e.g. on zone changes.
---@param quests table<number, {[1]: number, [2]: number}> [questID] = {itemID, required count}
---@param optionDefault boolean?
---@param optionVersion number?
---@return QuestTurnIn
function bossModPrototype:NewQuestTurnIn(quests, optionDefault, optionVersion)
	---@class QuestTurnIn
	local obj = setmetatable({
		objClass = "QuestTurnIn",
		mod = self,
		quests = quests,
		option = "AutoGossipQuest" .. (optionVersion and tostring(optionVersion) or ""),
		enabled = false,
	}, mt)
	self:AddGossipOption(optionDefault, "Quest", optionVersion, function() obj:Update() end)
	return obj
end
