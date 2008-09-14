-- **********************************************************
-- **            Deadly Boss Mods - BossModStudio          **
-- **             http://www.deadlybossmods.com            **
-- **********************************************************
--
-- This addon is written and copyrighted by:
--    * Martin Verges (Nitram @ EU-Azshara)
--    * Paul Emmerich (Tandanu @ EU-Aegwynn)
-- 
-- The localizations are written by:
--    * deDE: Nitram/Tandanu
--    * enGB: Nitram/Tandanu
--    * (add your names here!)
--
-- 
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
--
--  You are free:
--    * to Share  to copy, distribute, display, and perform the work
--    * to Remix  to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--
--

local L = {}

L.TabCategory_BossModStudio = "Boss Mod Studio"
L.TabCategory_Triggers = "Triggers and Events"
L.AreaHead_CreateBossMod = "Main Informations of this new BossMod"
L.BossName = "Name of the BossMod - like 'Hogger'"
L.BossID = "Creature ID"
L.BossLookup = "Take ID from Target"

L.AreaHead_Pull = "Pull / Combat Detection"
L.CombatFromYell = "Combat starts with a Yell"
L.CombatAutoDetect = "Automatic Combat Detection"
L.BossPullYell = "what does the Boss yell on pull"
L.BossEnrages = "boss enrage"
L.BossEnrageBar = "Show Enrage Bar"
L.BossEnrageAnnounce = "Announce Enrage to Raid"

L.Min = "Min"
L.Sec = "Sec"

CurrentBossSetup = {
	BossName = "",
	BossIDs = {},
	CombatFromYell = false,
	BossPullYell = {},
	CombatAutoDetect = true,
	Enrage = false,
	EnrageBar = false,
	EnrageAnnounce = false,
	EnrageTime = 0,
}

BMS_Panel = DBM_GUI:CreateNewPanel(L.TabCategory_BossModStudio, "option")


local function toboolean(var) 
	if var then return true else return false end
end

do
	local function getIDfromTarget(textbox) 
		return function(self)
			local guid = UnitGUID("target")
			if not guid then return end
			local cId = tonumber(guid:sub(9, 12), 16)
			CurrentBossSetup.BossIDs[textbox.id] = cId
			textbox:SetText(cId)
		end
	end
	-------------------------------------------------
	--         Create a new BossMod                --
	-------------------------------------------------
	do 
		local BMS_Create = BMS_Panel:CreateArea(L.AreaHead_CreateBossMod, nil, 110, true)
		local BossName = BMS_Create:CreateEditBox(L.BossName, "", 230)
		BossName:SetPoint('TOPLEFT', 40, -25)
		BossName:SetScript("OnTextChanged", function(self) CurrentBossSetup.BossName = self:GetText() end)
		
		local CurCount = 1
		local BossID = BMS_Create:CreateEditBox(L.BossID, "0", 75)
		BossID.id = CurCount
		BossID:SetPoint('TOPLEFT', BossName, "BOTTOMLEFT", 0, -20)
		BossID:SetScript("OnTextChanged", function(self) if self:GetNumber() <= 0 then CurrentBossSetup.BossIDs[self.id] = nil 
											  else CurrentBossSetup.BossIDs[self.id] = self:GetNumber() 
											  end end)
	
		local BossLookup = BMS_Create:CreateButton(L.BossLookup, 160, nil, getIDfromTarget(BossID))
		BossLookup:SetPoint('TOPLEFT', BossID, "TOPRIGHT", 5, 0)
	
		local getadditionalid = CreateFrame("Button", "GetAdditionalID_CreatureID", BMS_Create.frame)
		getadditionalid:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP");
		getadditionalid:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-DOWN");
		getadditionalid:SetPoint("RIGHT", BossID, "LEFT", -15, 0)
		getadditionalid:SetWidth(15)
		getadditionalid:SetHeight(15)
		getadditionalid:SetScript("OnClick", function(self) 
			CurCount = CurCount + 1
		
			local BossID = BMS_Create:CreateEditBox(L.BossID, "0", 75)
			BossID:SetPoint('TOPLEFT', BossName, "BOTTOMLEFT", 0, 15-(CurCount*35))
			BossID.id = CurCount
	
			local BossLookup = BMS_Create:CreateButton(L.BossLookup, 160, nil, getIDfromTarget(BossID))
			BossLookup:SetPoint('TOPLEFT', BossID, "TOPRIGHT", 5, 0)	
		
			self:ClearAllPoints()
			self:SetPoint("RIGHT", BossID, "LEFT", -15, 0)
	
			self:GetParent():SetHeight( self:GetParent():GetHeight() + 35 )
	
			BMS_Panel:SetMyOwnHeight()
			DBM_GUI_OptionsFrame:DisplayFrame(self:GetParent():GetParent())
	
			if CurCount >= 5 then
				self:Hide()
				self:Disable()
			end
		end)
	end
	do
		local BMS_Pull = BMS_Panel:CreateArea(L.AreaHead_Pull, nil, 165, true)
	
		local CombatFromYell = BMS_Pull:CreateCheckButton(L.CombatFromYell, true) --
		CombatFromYell:SetScript("OnClick", function()  CurrentBossSetup.CombatFromYell = not CurrentBossSetup.CombatFromYell end)
	
		local CombatAutoDetect = BMS_Pull:CreateCheckButton(L.CombatAutoDetect)
		CombatAutoDetect:SetPoint("TOPLEFT", BMS_Pull.frame, "TOPLEFT", 220, -10)
		CombatFromYell:SetScript("OnClick", function()  CurrentBossSetup.CombatAutoDetect = not CurrentBossSetup.CombatAutoDetect end)
	
		local CurCount = 1
		local BossPullYell = BMS_Pull:CreateEditBox(L.BossPullYell, "", 230)
		BossPullYell.id = CurCount
		BossPullYell:SetPoint('TOPLEFT', CombatFromYell, "BOTTOMLEFT", 30, -15)
		BossPullYell:SetScript("OnTextChanged", function(self) CurrentBossSetup.BossPullYell[self.id] = self:GetText() end)
	
		local getadditionalid = CreateFrame("Button", "GetAdditionalID_Pull", BMS_Pull.frame)
		getadditionalid:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP");
		getadditionalid:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-DOWN");
		getadditionalid:SetPoint("RIGHT", BossPullYell, "LEFT", -15, 0)
		getadditionalid:SetWidth(15)
		getadditionalid:SetHeight(15)		
		getadditionalid:SetScript("OnClick", function(self) 
			CurCount = CurCount + 1
		
			local BossPullYell = BMS_Pull:CreateEditBox(L.BossPullYell, "", 230)
			BossPullYell.id = CurCount
			BossPullYell:SetPoint('TOPLEFT', CombatFromYell, "BOTTOMLEFT", 30, 18-(CurCount*35))
			BossPullYell:SetScript("OnTextChanged", function(self) CurrentBossSetup.BossPullYell[self.id] = self:GetText() end)
	
			self:ClearAllPoints()
			self:SetPoint("RIGHT", BossPullYell, "LEFT", -15, 0)
	
			self:GetParent():SetHeight( self:GetParent():GetHeight() + 35 )
	
			BMS_Panel:SetMyOwnHeight()
			DBM_GUI_OptionsFrame:DisplayFrame(self:GetParent():GetParent())
	
			if CurCount >= 5 then
				self:Hide()
				self:Disable()
			end
		end)

		local EnableEnrage = BMS_Pull:CreateCheckButton(L.BossEnrages, nil, nil)
		EnableEnrage:SetPoint("TOPLEFT", BMS_Pull.frame, "BOTTOMLEFT", 10, 70)
		EnableEnrage:SetScript("OnShow", function(self) self:SetChecked( CurrentBossSetup.Enrage ) end)
		EnableEnrage:SetScript("OnClick", function(self) CurrentBossSetup.Enrage = toboolean(self:GetChecked()) end)
	
		local EnrageMin = BMS_Pull:CreateEditBox(L.Min, "", 30)
		EnrageMin:SetPoint('TOPLEFT', EnableEnrage, "TOPRIGHT", 130, -5)
		local EnrageSec = BMS_Pull:CreateEditBox(L.Sec, "", 30)
		EnrageSec:SetPoint('TOPLEFT', EnrageMin, "TOPRIGHT", 20, 0)

		local function timechange()
			CurrentBossSetup.EnrageTime = EnrageMin:GetNumber()*60 + EnrageSec:GetNumber()
			if CurrentBossSetup.EnrageTime < 0 then CurrentBossSetup.EnrageTime = 0 end
		end
		EnrageMin:SetScript("OnTextChanged", timechange)
		EnrageSec:SetScript("OnTextChanged", timechange)

		local EnableEnrageAnnounce = BMS_Pull:CreateCheckButton(L.BossEnrageBar, nil, nil)
		EnableEnrageAnnounce:SetPoint("TOPLEFT", EnableEnrage, "BOTTOMLEFT", 0, 0)
		EnableEnrageAnnounce:SetScript("OnShow", function(self) self:SetChecked( CurrentBossSetup.EnrageAnnounce ) end)
		EnableEnrageAnnounce:SetScript("OnClick", function(self) CurrentBossSetup.EnrageAnnounce = toboolean(self:GetChecked()) end)

		local EnableEnrageBar = BMS_Pull:CreateCheckButton(L.BossEnrageAnnounce, nil, nil)
		EnableEnrageBar:SetPoint("TOPLEFT", EnableEnrage, "BOTTOMLEFT", 150, 0)
		EnableEnrageBar:SetScript("OnShow", function(self) self:SetChecked( CurrentBossSetup.EnrageBar ) end)
		EnableEnrageBar:SetScript("OnClick", function(self) CurrentBossSetup.EnrageBar = toboolean(self:GetChecked()) end)
	end
end


L.AreaHead_TriggerCreate = "Create an Boss Event Trigger"
L.Describe_TriggerCreate = [[Triggers can be created to handle events in bossfights. If the Boss yell some stuff or use one of his abilitys you need to catch and use them. As an example, the boss gains Shieldwall and you want to start a Bar when this occur, you simply have to choose BossBuffs or Debuffs and type in an Name for this event like "Shieldwall"]]
do
	BMS_Trigger = BMS_Panel:CreateNewPanel(L.TabCategory_Triggers, "option")
	local BMS_CreateTrigger = BMS_Trigger:CreateArea(L.AreaHead_TriggerCreate, nil, 165, true)

	--BMS_CreateTrigger

	--Describe_TriggerCreate
end






