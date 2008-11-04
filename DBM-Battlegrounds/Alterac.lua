local Alterac = DBM:NewMod("Alterac", "DBM-Battlegrounds")

Alterac:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_BG_SYSTEM_ALLIANCE",
	"CHAT_MSG_BG_SYSTEM_HORDE",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL",
	"GOSSIP_SHOW",
	"QUEST_PROGRESS",
	"QUEST_COMPLETE"
)

Alterac:AddBoolOption("ShowInviteTimer", true, "general")
Alterac:AddBoolOption("ColorByClass", true, "general")
Alterac:AddBoolOption("AutoSpirit", false, "general")
Alterac:AddBoolOption("AutoTurnIn", true, "general")
--Alterac:AddBoolOption("Flash", false, "general") -- need blue flash effect

local allyColor = {
	r = 0,
	g = 0,
	b = 1,
}

local hordeColor = {
	r = 1,
	g = 0,
	b = 0,
}

local startTimer = mod:NewTimer(62, "TimerStart")
local towerTimer = mod:NewTimer(243, "TimerTower")
local gyTimer = mod:NewTimer(243, "TimerGY")


function Alterac:GetNumItems(id)
	local counter = 0
	for bag = 0,  4 do
		for slot = 1,  GetContainerNumSlots(bag) do
			local itemLink = GetContainerItemLink(bag, slot)
			local _, _, itemID = string.find(itemLink or "", "(%d+)") -- first number is the item's ID
			if tonumber(itemID) == tonumber(id) then
				local _, itemCount = GetContainerItemInfo(bag, slot)
				counter = counter + (itemCount or 1)
			end
		end
	end
	return counter
end

function Alterac:GOSSIP_SHOW(arg1)
	if GetRealZoneText() == DBM_ALTERAC and self.Options.AutoTurnIn then
		local target = UnitName("target")
		if target == DBM_BGMOD_LANG.AV_NPC.SMITHREGZAR or target == DBM_BGMOD_LANG.AV_NPC.MURGOTDEEPFORGE then -- todo: use npc creature and unit id
			local Upgrade = GetGossipOptions()
			if string.find(string.lower(Upgrade or ""), DBM_BGMOD_LANG.UPGRADETROOPS) then
				SelectGossipOption(1)
			elseif self:GetNumItems(17422) >= 20 then -- Armor Scraps
				SelectGossipAvailableQuest(1)
			end
		elseif target == DBM_BGMOD_LANG.AV_NPC.PRIMALISTTHURLOGA then
			local numItems = self:GetNumItems(17306) -- Stormpike Soldier's Blood
			if numItems >= 5 then
				SelectGossipAvailableQuest(2)
			elseif numItems > 0 then
				SelectGossipAvailableQuest(1)
			end
		elseif target == DBM_BGMOD_LANG.AV_NPC.ARCHDRUIDRENFERAL then
			local numItems = self:GetNumItems(17423) -- Storm Crystal
			if numItems >= 5 then
				SelectGossipAvailableQuest(2)
			elseif numItems > 0 then
				SelectGossipAvailableQuest(1)
			end
		elseif target == DBM_BGMOD_LANG.AV_NPC.STORMPIKERAMRIDERCOMMANDER then
			if self:GetNumItems(17643) > 0 then -- Frostwolf Hide
				SelectGossipAvailableQuest(1)
			end
		elseif target == DBM_BGMOD_LANG.AV_NPC.FROSTWOLFWOLFRIDERCOMMANDER then
			if self:GetNumItems(17642) > 0 then -- Alterac Ram Hide
				SelectGossipAvailableQuest(1)
			end
		end
	end
end

function Alterac:QUEST_PROGRESS(arg1)
	if GetRealZoneText() == DBM_ALTERAC and self.Options.AutoTurnIn then
		local target = UnitName("target")
		if target == DBM_BGMOD_LANG.AV_NPC.WINGCOMMANDERJEZTOR and self:GetNumItems(17327) == 0 then -- Stormpike Lieutenant's Flesh
			return
		elseif target == DBM_BGMOD_LANG.AV_NPC.WINGCOMMANDERGUSE and self:GetNumItems(17326) == 0 then -- Stormpike Soldier's Flesh
			return
		elseif target == DBM_BGMOD_LANG.AV_NPC.WINGCOMMANDERMULVERICK and self:GetNumItems(17328) == 0 then -- Stormpike Commander's Flesh
			return
		elseif target == DBM_BGMOD_LANG.AV_NPC.WINGCOMMANDERVIPORE and self:GetNumItems(17503) == 0 then -- Frostwolf Lieutenant's Medal
			return
		elseif target == DBM_BGMOD_LANG.AV_NPC.WINDCOMMANDERSLIDORE and self:GetNumItems(17502) == 0 then -- Frostwolf Soldier's Medal
			return
		elseif target == DBM_BGMOD_LANG.AV_NPC.WINGCOMMANDERICHMAN and self:GetNumItems(17504) == 0 then -- Frostwolf Commander's Medal
			return
		else			
			CompleteQuest()
		end
	end
end
		
function Alterac:QUEST_COMPLETE(arg1)
	if GetRealZoneText() == DBM_ALTERAC and self.Options.AutoTurnIn then
		local target = UnitName("target")
		for index, value in pairs(DBM_BGMOD_LANG.AV_NPC) do
			if (target == value) then
				GetQuestReward(0)
			end
		end
	end
end
	
	
function Alterac:CHAT_MSG_BG_SYSTEM_NEUTRAL(arg1)
	if arg1 == DBM_BGMOD_LANG.AV_START60SEC then
		self:SendSync("Start60")
	elseif arg1 == DBM_BGMOD_LANG.AV_START30SEC then		
		self:SendSync("Start30")
	end
end
		
function Alterac:CHAT_MSG_BG_SYSTEM_ALLIANCE(arg1)
	if string.find(string.lower(arg1), string.lower(DBM_BGMOD_LANG.AV_TARGETS[8])) then -- first Snowfall capture (Alliance)
		self:SendSync("AG", 8)
	end
end
		
function Alterac:CHAT_MSG_BG_SYSTEM_HORDE(arg1)
	if string.find(string.lower(arg1), string.lower(DBM_BGMOD_LANG.AV_TARGETS[8])) then -- first Snowfall capture (Horde)
		self:SendSync("HG", 8)
	end
end
		
function Alterac:CHAT_MSG_MONSTER_YELL(arg1)
	--zhCN translations...WTF
	if string.find(arg1, "西霜狼哨塔被部落占领了") then
		self:SendSync("DEF", 13)
--		DBM.Announce(string.format(DBM_BGMOD_LANG.HORDE_TAKE_ANNOUNCE, "西侧霜狼哨塔"))
	elseif string.find(arg1, "东霜狼哨塔被部落占领了") then
		self:SendSync("DEF", 14)
--		DBM.Announce(string.format(DBM_BGMOD_LANG.HORDE_TAKE_ANNOUNCE, "东侧霜狼哨塔"))
	elseif string.find(arg1, "西侧防御塔点被部落占领了") then
		self:SendSync("DEF", 11)
--		DBM.Announce(string.format(DBM_BGMOD_LANG.HORDE_TAKE_ANNOUNCE, "哨塔高地"))
	elseif string.find(arg1, "石炉墓地受到攻击！如果我们不尽快采取措施的话，部落会([^%s]+)它的！") then
		self:SendSync("HG", 6)
	elseif string.find(arg1, "石炉墓地受到攻击！如果我们不尽快采取措施的话，联盟会([^%s]+)它的！") then
		self:SendSync("AG", 6)
	elseif string.find(arg1, "冰翼工事被联盟占领了！") then
		self:SendSync("DEF", 5)
--		DBM.Announce(string.format(DBM_BGMOD_LANG.ALLI_TAKE_ANNOUNCE, "冰翼碉堡"))
	end

	for index, value in ipairs(DBM_BGMOD_LANG.AV_TARGETS) do
		if string.find(string.lower(arg1), string.lower(value)) then
			if string.find(arg1, DBM_BGMOD_LANG.AV_UNDERATTACK) then
				local icon
				if DBM_BGMOD_LANG.AV_TARGET_TYPE and DBM_BGMOD_LANG.AV_TARGET_TYPE[index] then
					if DBM_BGMOD_LANG.AV_TARGET_TYPE[index] == "tower" then
						if string.find(arg1, DBM_BGMOD_LANG.HORDE) then
							icon = "Interface\\AddOns\\DBM-Battlegrounds\\Textures\\GuardTower"
						elseif string.find(arg1, DBM_BGMOD_LANG.ALLIANCE) then
							icon = "Interface\\AddOns\\DBM-Battlegrounds\\Textures\\OrcTower" --orc tower, because the alliance captures horde towers, so the bar is for a horde tower if the alliance captured a tower!
						end
					elseif DBM_BGMOD_LANG.AV_TARGET_TYPE[index] == "graveyard" then								
						icon = "Interface\\Icons\\Spell_Shadow_AnimateDead"
					end
				end
				if string.find(arg1, DBM_BGMOD_LANG.HORDE) then 
					if icon == "Interface\\AddOns\\DBM-Battlegrounds\\Textures\\GuardTower" then
						self:SendSync("HT", index)
					elseif icon == "Interface\\Icons\\Spell_Shadow_AnimateDead" then
						self:SendSync("HG", index)
					end
				elseif string.find(arg1, DBM_BGMOD_LANG.ALLIANCE) then
					if icon == "Interface\\AddOns\\DBM-Battlegrounds\\Textures\\OrcTower" then
						self:SendSync("AT", index)
					elseif icon == "Interface\\Icons\\Spell_Shadow_AnimateDead" then
						self:SendSync("AG", index)
					end
				end
			elseif string.find(arg1, DBM_BGMOD_LANG.AV_WASDESTROYED) or string.find(arg1, DBM_BGMOD_LANG.AV_WASTAKENBY) then
				self:SendSync("DEF", index)
			end
		end
	end
end

function Alterac:OnSync(msg, args)
	if msg == "Start60" then
		startTimer:Start()
	elseif msg == "Start30" then
		if startTimer:GetTime() == 0 then
			startTimer:Start()
		end
		startTimer:Update(31, 62)
	elseif msg == "AG" then
		msg = args or 0
		msg = tonumber(msg)
		if msg and DBM_BGMOD_LANG["AV_TARGETS"][msg] then
			local t = DBM_BGMOD_AV_BARS[msg] or DBM_BGMOD_LANG["AV_TARGETS"][msg]
			gyTimer:Stop(t)
			gyTimer:Start(243, t)
			gyTimer:UpdateIcon("Interface\\Icons\\Spell_Shadow_AnimateDead", t)
			gyTimer:SetColor(allyColor, t)
		end
	elseif msg == "AT" then
		msg = args or 0
		msg = tonumber(msg)
		if msg and DBM_BGMOD_LANG["AV_TARGETS"][msg] then
			local t = DBM_BGMOD_AV_BARS[msg] or DBM_BGMOD_LANG["AV_TARGETS"][msg]
			towerTimer:Stop(t)
			towerTimer:Start(243, t)
			towerTimer:UpdateIcon("Interface\\AddOns\\DBM-Battlegrounds\\Textures\\OrcTower", t)
			towerTimer:SetColor(allyColor, t)
		end
	elseif msg == "HG" then
		msg = args or 0
		msg = tonumber(msg)
		if msg and DBM_BGMOD_LANG["AV_TARGETS"][msg] then
			local t = DBM_BGMOD_AV_BARS[msg] or DBM_BGMOD_LANG["AV_TARGETS"][msg]
			gyTimer:Stop(t)
			gyTimer:Start(243, t)
			gyTimer:UpdateIcon("Interface\\Icons\\Spell_Shadow_AnimateDead", t)
			gyTimer:SetColor(hordeColor, t)
		end
	elseif msg == "HT" then
		msg = args or 0
		msg = tonumber(msg)
		if msg and DBM_BGMOD_LANG["AV_TARGETS"][msg] then
			local t = DBM_BGMOD_AV_BARS[msg] or DBM_BGMOD_LANG["AV_TARGETS"][msg]
			towerTimer:Stop(t)
			towerTimer:Start(243, t)
			towerTimer:UpdateIcon("Interface\\AddOns\\DBM-Battlegrounds\\Textures\\GuardTower", t)
			towerTimer:SetColor(allyColor, t)
		end
	elseif msg == "DEF" then
		msg = args or 0
		msg = tonumber(msg)
		if msg and DBM_BGMOD_LANG["AV_TARGETS"][msg] then
			local t = DBM_BGMOD_AV_BARS[msg] or DBM_BGMOD_LANG["AV_TARGETS"][msg]
			towerTimer:Stop(t)
			gyTimer:Stop(t)
		end
	end
end
