-- **********************************************************
-- **           Deadly Boss Mods - Boss Mod Studio         **
-- **             http://www.deadlybossmods.com            **
-- **********************************************************
--
-- This addon is written and copyrighted by:
--    * Martin Verges (Nitram @ EU-Azshara) (DBM-GUI)
--    * Paul Emmerich (Tandanu @ EU-Aegwynn) (DBM-Core)
-- 
-- The localizations are written by:
--    * enGB/enUS: Nitram
--    * deDE: Nitram
--    * zhTW: Hman						herman_c1@hotmail.com
--	  * koKR: BlueNyx (bluenyx@gmail.com)
--    * (add your names here!)
--
-- The code of this addon is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
-- All included textures and sounds are copyrighted by their respective owners.
--
--
--  You are free:
--    * to Share — to copy, distribute, display, and perform the work
--    * to Remix — to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.


local BossMods

local L = DBM_BMS_Translations

local default_config = {
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

local gui_panels = {}
local DeletedTriggerFrames = {}

local mods_loaded = {}
local mainframe = CreateFrame("frame", "DBM_BossModStudio", UIParent)
mainframe:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" and select(1, ...) == "DBM-SpellTimers" then
		for k,mod in pairs(DBM_BMS) do
			mods_loaded[mod.BossName] = DBM:LoadCustomMod(mod)
		end
	end
end)
mainframe:RegisterEvent("ADDON_LOADED")


local function unique_bossname(name)
	for k,mod in pairs(DBM_BMS) do
		if mod.BossName == name then
			return false
		end
	end
	return true
end

local function copytable(t1, t2)
	for i, v in pairs(t2) do
		if t1[i] == nil and type(v) ~= "table" then
			t1[i] = v
		elseif type(v) == "table" then
			if t1[i] == nil then t1[i] = {} end
			copytable(v, t2[i])
		end
	end
end

local function toboolean(var) 
	if var then return true else return false end
end

local function getIDfromTarget(textbox, mod) 
	return function(self)
		local guid = UnitGUID("target")
		if not guid then return end
		local cId = tonumber(guid:sub(7, 10), 16)
		mod.BossIDs[textbox.id] = cId
		textbox:SetText(cId)
	end
end

local function create_BossMainPanel(mod, k)
	if not mods_loaded[mod.BossName] then
		mods_loaded[mod.BossName] = DBM:LoadCustomMod(mod) 
	end
	gui_panels[k] = BMS_Panel:CreateNewPanel(mod.BossName, "option")

	local BMS_Panel = gui_panels[k]
	local CurrentBossSetup = mod

	------------------------------------------------
	--         Change this BossMod                --
	------------------------------------------------
	do 
		local BMS_Create = BMS_Panel:CreateArea(L.AreaHead_CreateBossMod, nil, 110, true)

		local BossName = BMS_Create:CreateEditBox(L.BossName, "", 230)
		BossName:SetPoint('TOPLEFT', 40, -25)
		BossName:SetScript("OnTextChanged", function(self) 
			CurrentBossSetup.BossName = self:GetText()
			BMS_Panel:Rename(CurrentBossSetup.BossName)
		end)
		BossName:SetScript("OnShow", function(self) self:SetText(CurrentBossSetup.BossName) end)
		
		local CurCount = 1
		local BossID = BMS_Create:CreateEditBox(L.BossID, "0", 75)
		BossID.id = CurCount
		BossID:SetNumeric(true)
		BossID:SetPoint('TOPLEFT', BossName, "BOTTOMLEFT", 0, -20)
		BossID:SetScript("OnTextChanged", function(self) if self:GetNumber() <= 0 then CurrentBossSetup.BossIDs[self.id] = nil 
											  else CurrentBossSetup.BossIDs[self.id] = self:GetNumber() 
											  end 
		end)
		BossID:SetScript("OnShow", function(self) 
			if CurrentBossSetup.BossIDs[self.id] then
				self:SetText(CurrentBossSetup.BossIDs[self.id]) 
			end
		end)

		local BossLookup = BMS_Create:CreateButton(L.BossLookup, 160, nil, getIDfromTarget(BossID, CurrentBossSetup))
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
			BossID:SetNumeric(true)
			BossID:SetScript("OnTextChanged", function(self) if self:GetNumber() <= 0 then CurrentBossSetup.BossIDs[self.id] = nil 
												  else CurrentBossSetup.BossIDs[self.id] = self:GetNumber() 
												  end 
			end)
			BossID:SetScript("OnShow", function(self) 
				if CurrentBossSetup.BossIDs[self.id] then
					self:SetText(CurrentBossSetup.BossIDs[self.id]) 
				end
			end)
			
	
			local BossLookup = BMS_Create:CreateButton(L.BossLookup, 160, nil, getIDfromTarget(BossID, CurrentBossSetup))
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
		do
			if #CurrentBossSetup.BossIDs > 1 then
				local script = getadditionalid:GetScript("OnClick")
				for i=2, #CurrentBossSetup.BossIDs, 1 do
					script(getadditionalid)
				end
			end
		end

	end
	do
		local BMS_Pull = BMS_Panel:CreateArea(L.AreaHead_Pull, nil, 165, true)
	
		local CombatFromYell = BMS_Pull:CreateCheckButton(L.CombatFromYell, true) --
		CombatFromYell:SetScript("OnClick", function(self) CurrentBossSetup.CombatFromYell = toboolean(self:GetChecked()) end)
		CombatFromYell:SetScript("OnShow", function(self) self:SetChecked(CurrentBossSetup.CombatFromYell) end)
	
		local CombatAutoDetect = BMS_Pull:CreateCheckButton(L.CombatAutoDetect)
		CombatAutoDetect:SetPoint("TOPLEFT", BMS_Pull.frame, "TOPLEFT", 220, -10)
		CombatAutoDetect:SetScript("OnClick", function(self) CurrentBossSetup.CombatAutoDetect = toboolean(self:GetChecked()) end)
		CombatAutoDetect:SetScript("OnShow", function(self) self:SetChecked(CurrentBossSetup.CombatAutoDetect)  end)

		local CurCount = 1
		local BossPullYell = BMS_Pull:CreateEditBox(L.BossPullYell, "", 230)
		BossPullYell.id = CurCount
		BossPullYell:SetPoint('TOPLEFT', CombatFromYell, "BOTTOMLEFT", 30, -15)
		BossPullYell:SetScript("OnTextChanged", function(self) CurrentBossSetup.BossPullYell[self.id] = self:GetText() end)
		BossPullYell:SetScript("OnShow", function(self) self:SetText(CurrentBossSetup.BossPullYell[self.id] or "") end)
	
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
			BossPullYell:SetScript("OnShow", function(self) self:SetText(CurrentBossSetup.BossPullYell[self.id] or "") end)
	
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
		do
			if #CurrentBossSetup.BossPullYell > 1 then
				local script = getadditionalid:GetScript("OnClick")
				for i=2, #CurrentBossSetup.BossPullYell, 1 do
					script(getadditionalid)
				end
			end
		end

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

		--combined onshow!
		EnrageMin:SetScript("OnShow", function(self)
			EnrageMin:SetText( math.floor(CurrentBossSetup.EnrageTime/60) )
			EnrageSec:SetText( CurrentBossSetup.EnrageTime - (math.floor(CurrentBossSetup.EnrageTime/60)*60) )
		end)

		local EnableEnrageAnnounce = BMS_Pull:CreateCheckButton(L.BossEnrageBar, nil, nil)
		EnableEnrageAnnounce:SetPoint("TOPLEFT", EnableEnrage, "BOTTOMLEFT", 0, 0)
		EnableEnrageAnnounce:SetScript("OnShow", function(self) self:SetChecked( CurrentBossSetup.EnrageAnnounce ) end)
		EnableEnrageAnnounce:SetScript("OnClick", function(self) CurrentBossSetup.EnrageAnnounce = toboolean(self:GetChecked()) end)

		local EnableEnrageBar = BMS_Pull:CreateCheckButton(L.BossEnrageAnnounce, nil, nil)
		EnableEnrageBar:SetPoint("TOPLEFT", EnableEnrage, "BOTTOMLEFT", 150, 0)
		EnableEnrageBar:SetScript("OnShow", function(self) self:SetChecked( CurrentBossSetup.EnrageBar ) end)
		EnableEnrageBar:SetScript("OnClick", function(self) CurrentBossSetup.EnrageBar = toboolean(self:GetChecked()) end)
	end

	do 
		local BMS_CreateTrigger = BMS_Panel:CreateArea(L.AreaHead_TriggerCreate, nil, 165, true)

		local TriggerName = BMS_CreateTrigger:CreateEditBox(L.Trigger_Name, "", 200)
		TriggerName:SetPoint('TOPLEFT', 40, -60)
	
		local TriggerCreateBttn = BMS_CreateTrigger:CreateButton(L.Trigger_Create_Bttn, 160, nil)
		TriggerCreateBttn:SetPoint('TOPLEFT', 200, -20)
	
		-- at last because of the dropdown problem with layer level
		local TriggerTyps = { 
			{	text	= L.Trigger_Typ_Spell,	value = "spell" },
			{	text	= L.Trigger_Typ_Buff,	value = "buff" },
			{	text	= L.Trigger_Typ_Yell,	value = "yell" },
			{	text	= L.Trigger_Typ_Time,	value = "time" },
			{	text	= L.Trigger_Typ_Hp,	value = "bosshp" },
		}
		local TriggerDropDown = BMS_CreateTrigger:CreateDropdown(L.Trigger_Typ, TriggerTyps);
		TriggerDropDown:SetPoint("TOPLEFT", BMS_CreateTrigger.frame, "TOPLEFT", 10, -20)
	
		local infotext = BMS_CreateTrigger:CreateText(L.Describe_TriggerCreate, 380, false)
		infotext:SetPoint('BOTTOMLEFT', BMS_CreateTrigger.frame, "BOTTOMLEFT", 10, 10)
		infotext:SetJustifyH("LEFT")
		infotext:SetFontObject(GameFontNormalSmall)
	
		local trigger_id = 0
	
		local function settriggeroption(id, option) 
			return function(self)
				if type(CurrentBossSetup.triggers[id][option]) == "string" then
					CurrentBossSetup.triggers[id][option] = self:GetText()
				elseif type(CurrentBossSetup.triggers[id][option]) == "boolean" then
					CurrentBossSetup.triggers[id][option] = toboolean(self:GetChecked())
				elseif type(CurrentBossSetup.triggers[id][option]) == "number" then
					CurrentBossSetup.triggers[id][option] = self:GetNumber()
				else
					DBM:AddMsg("DEBUG: SetTriggerTyp ("..type(CurrentBossSetup.triggers[id][option])..") not found")
				end
			end
		end
		local function showtriggeroption(id, option) 
			return function(self)
				if type(CurrentBossSetup.triggers[id][option]) == "string" then
					self:SetText(CurrentBossSetup.triggers[id][option])
				elseif type(CurrentBossSetup.triggers[id][option]) == "boolean" then
					self:SetChecked(CurrentBossSetup.triggers[id][option])
				elseif type(CurrentBossSetup.triggers[id][option]) == "number" then
					self:SetText(CurrentBossSetup.triggers[id][option])
				else
					DBM:AddMsg("DEBUG: ShowTriggerTyp ("..type(CurrentBossSetup.triggers[id][option])..") not found")
				end
			end
		end
		
		local function ChangeFrameAppearance(self) 
			if self.triggertype == "yell" then
				self.obj.EventYellText:Show()
				self.obj.EventSpellID:Hide()
				self.obj.EventSpellText:Hide()
				self.obj.EventSpellIcon:Hide()
				self.obj.EventSpecialWarningOnlyMe:Show()
				self.obj.EventSetIcon:Show()
				self.obj.EventTime:Hide()
				self.obj.EventHp:Hide()
			elseif self.triggertype == "spell" or self.triggertype == "buff" then
				self.obj.EventYellText:Hide()
				self.obj.EventSpellID:Show()
				self.obj.EventSpellText:Show()
				self.obj.EventSpellIcon:Show()
				self.obj.EventSpecialWarningOnlyMe:Show()
				self.obj.EventSetIcon:Show()
				self.obj.EventTime:Hide()
				self.obj.EventHp:Hide()
			elseif self.triggertype == "time" then
				self.obj.EventYellText:Hide()
				self.obj.EventSpellID:Hide()
				self.obj.EventSpellText:Hide()
				self.obj.EventSpellIcon:Hide()
				self.obj.EventSpecialWarningOnlyMe:Hide()
				self.obj.EventSetIcon:Hide()
				self.obj.EventTime:Show()
				self.obj.EventHp:Hide()
			elseif self.triggertype == "bosshp" then
				self.obj.EventYellText:Hide()
				self.obj.EventSpellID:Hide()
				self.obj.EventSpellText:Hide()
				self.obj.EventSpellIcon:Hide()
				self.obj.EventSpecialWarningOnlyMe:Hide()
				self.obj.EventSetIcon:Hide()
				self.obj.EventTime:Hide()
				self.obj.EventHp:Show()
			end
		end		

		local trigger_defaults = {
			isactive = true,
			triggeryell = "",	-- type == yell (can be emote/yell/..: "boss raises his shild") 
			triggerskill = 0,	-- type == spell (can be spell/skill/..: "boss begins to cast ID" or "player got hittet by skillID")
						-- type == buff (can be buff or debuff on boss or player)
			triggertime = 0,	-- type == time (do stuff after X sec)
			triggerhp = 0,		-- type == bosshp (do stuff when boss is on 25% or stuff like this)
			announce = false,	-- show announce (Shildwall is UP)
			announcetext = "",
			specialwarn = false,	-- flash screen "wtf move or die"
			seticon = false,	-- mark target with skull
			showbar = false,	-- show a bar when this happen again (eg. Shildwall in 30min)
			bartime = 0,
			barendwarn = false,	-- announce end of timer (eg. Shildwall in 5 sec)
			barwarntime = 0,
			barwarnmsg = ""
		}

		local function createtriggerframe(self)
			local description = TriggerName:GetText()
			local triggertype = TriggerDropDown.value
			if self and (not description or description == "" or not triggertype or triggertype == "") then return end
		
			-- We try to recover old ("deleted") Frames because of the missing command to delete a Frame
			if self and DeletedTriggerFrames[1] ~= nil then
				recover = table.remove(DeletedTriggerFrames)
				if recover then
					-- refreh frame settings / text / stuff		(values will be used in the onshow scripts)
					copytable(CurrentBossSetup.triggers[trigger_id], trigger_defaults)
					CurrentBossSetup.triggers[recover.id].name = description
					CurrentBossSetup.triggers[recover.id].typ = triggertype
					_G[recover.frame:GetName()..'Title']:SetText(recover.id..". "..description.." ("..triggertype..")")
		
					for i=1, select("#", recover.frame:GetChildren()), 1 do
						select(i, recover.frame:GetChildren()):Show()
					end
					recover.frame:SetParent(BMS_Panel.frame)
					recover.frame:ClearAllPoints()
					recover.frame:SetPoint('TOPLEFT', select(-2, BMS_Panel.frame:GetChildren()), "BOTTOMLEFT", 0, -17)
					recover.frame:Show()
			
					BMS_Panel:SetMyOwnHeight()
					DBM_GUI_OptionsFrame:DisplayFrame(BMS_Panel.frame)
					
				else
					DBM:AddMsg("Unable to recover frame")
				end
				return
			else
				trigger_id = trigger_id + 1
			end
				
			if not CurrentBossSetup.triggers[trigger_id] then
				CurrentBossSetup.triggers[trigger_id] = {}
				CurrentBossSetup.triggers[trigger_id].name = description
				CurrentBossSetup.triggers[trigger_id].typ = triggertype
			end
			copytable(CurrentBossSetup.triggers[trigger_id], trigger_defaults)

			------------------------------------------------
			--   Create the Frames for the Trigger Area   --
			------------------------------------------------
			local TriggerArea = BMS_Panel:CreateArea(trigger_id..". "..CurrentBossSetup.triggers[trigger_id].name.." ("..CurrentBossSetup.triggers[trigger_id].typ..")", nil, 215, true)
			TriggerArea.id = trigger_id
			TriggerArea.frame.description = CurrentBossSetup.triggers[trigger_id].name
			TriggerArea.frame.triggertype = CurrentBossSetup.triggers[trigger_id].typ
			TriggerArea.frame.obj = TriggerArea
			TriggerArea.frame:SetScript("OnShow", ChangeFrameAppearance) 
		
			-- Create all frame elements
			TriggerArea.EventYellText 		= TriggerArea:CreateEditBox(L.EventYellText, "", 230)
			TriggerArea.EventSpellID 		= TriggerArea:CreateEditBox(L.EventSpellID, "", 75)
			TriggerArea.EventSpellText 		= TriggerArea:CreateText("", 200, false)
			TriggerArea.EventSpellIcon 		= CreateFrame("Frame", "DBM_GUI_Icon_"..TriggerArea.id, TriggerArea.frame)
			TriggerArea.EventTime	 		= TriggerArea:CreateEditBox(L.EventTimeBased, "", 50)
			TriggerArea.EventHp	 		= TriggerArea:CreateEditBox(L.EventHpBased, "", 50)
			TriggerArea.EventAnnounceText 		= TriggerArea:CreateEditBox(L.EventAnnounceText, "", 130)
			TriggerArea.EventAnnounce 		= TriggerArea:CreateCheckButton(L.EventAnnounce)
			TriggerArea.EventSpecialWarning 	= TriggerArea:CreateCheckButton(L.EventSpecialWarn, true)
			TriggerArea.EventSetIcon 		= TriggerArea:CreateCheckButton(L.EventSetIcon, true)
			TriggerArea.EventStartTimer	 	= TriggerArea:CreateCheckButton(L.EventStartBar, true)
			TriggerArea.EventSpecialWarningOnlyMe	= TriggerArea:CreateCheckButton(L.EventSpecialWarn_OnlyMe)
			TriggerArea.EventBarMin 		= TriggerArea:CreateEditBox(L.Min, "", 30)
			TriggerArea.EventBarSec 		= TriggerArea:CreateEditBox(L.Sec, "", 30)
			TriggerArea.EventWarnEnd 		= TriggerArea:CreateCheckButton(L.EventWarnEnd)
			TriggerArea.EventWarnEndSec 		= TriggerArea:CreateEditBox(L.Sec, "", 30)
			TriggerArea.EventWarnMsg 		= TriggerArea:CreateEditBox(L.EventWarnMsg, "", 130)
			TriggerArea.beletemebutton 		= TriggerArea:CreateButton(L.Trigger_Delete_Bttn, 100, 16)
		
			-- some functions required within the elements
			local function settime()
				CurrentBossSetup.triggers[TriggerArea.id].bartime = TriggerArea.EventBarMin:GetNumber()*60 + TriggerArea.EventBarSec:GetNumber()
				if CurrentBossSetup.triggers[TriggerArea.id].bartime < 0 then
					CurrentBossSetup.triggers[TriggerArea.id].bartime = 0
				end
			end
			local function showtime()
				TriggerArea.EventBarMin:SetText( math.floor(CurrentBossSetup.triggers[TriggerArea.id].bartime/60) )
				TriggerArea.EventBarSec:SetText( CurrentBossSetup.triggers[TriggerArea.id].bartime - TriggerArea.EventBarMin:GetNumber()*60 )
			end
			-- set positions and script to frame elements
			TriggerArea.EventSpellID:SetPoint("TOPLEFT", 60, -20)
			TriggerArea.EventSpellID:SetScript("OnTextChanged", function(self) 
				settriggeroption(TriggerArea.id, "triggerskill")(self)
				TriggerArea.EventSpellIcon.texture:SetTexture(select(3, GetSpellInfo(self:GetNumber())) or "Interface\\Icons\\Spell_Frost_Stun")
				TriggerArea.EventSpellText:SetText(select(1, GetSpellInfo(self:GetNumber())))
			end)
			TriggerArea.EventSpellID:SetScript("OnShow", function(self)
				showtriggeroption(TriggerArea.id, "triggerskill")(self)
				TriggerArea.EventSpellIcon.texture:SetTexture(select(3, GetSpellInfo(CurrentBossSetup.triggers[TriggerArea.id].triggerskill)) or "Interface\\Icons\\Spell_Frost_Stun")
				TriggerArea.EventSpellText:SetText(select(1, GetSpellInfo(CurrentBossSetup.triggers[TriggerArea.id].triggerskill)))
			end)
			TriggerArea.EventSpellIcon:SetWidth(20)
			TriggerArea.EventSpellIcon:SetHeight(20)
			TriggerArea.EventSpellIcon:SetPoint("TOPLEFT", 20, -20)
			TriggerArea.EventSpellIcon.texture = TriggerArea.EventSpellIcon:CreateTexture()
			TriggerArea.EventSpellIcon.texture:SetAllPoints(TriggerArea.EventSpellIcon)
			TriggerArea.EventSpellIcon.texture:SetTexture("Interface\\Icons\\Spell_Frost_Stun") -- select(3, GetSpellInfo(id)) 
			TriggerArea.EventSpellText:SetPoint('TOPLEFT', 140, -25)
			TriggerArea.EventSpellText:SetJustifyH("LEFT")
			TriggerArea.EventSpellText:SetFontObject(GameFontNormalSmall)
			TriggerArea.EventYellText:SetPoint("TOPLEFT", 30, -20)
			TriggerArea.EventYellText:SetScript("OnTextChanged", settriggeroption(trigger_id, "triggeryell"))
			TriggerArea.EventYellText:SetScript("OnShow", showtriggeroption(trigger_id, "triggeryell"))
			TriggerArea.EventTime:SetPoint("TOPLEFT", 30, -20)
			TriggerArea.EventTime:SetScript("OnTextChanged", settriggeroption(trigger_id, "triggertime"))
			TriggerArea.EventTime:SetScript("OnShow", showtriggeroption(trigger_id, "triggertime"))
			TriggerArea.EventHp:SetPoint("TOPLEFT", 30, -20)
			TriggerArea.EventHp:SetScript("OnTextChanged", settriggeroption(trigger_id, "triggerhp"))
			TriggerArea.EventHp:SetScript("OnShow", showtriggeroption(trigger_id, "triggerhp"))
			TriggerArea.EventAnnounceText:SetPoint("TOPLEFT", 130, -60)
			TriggerArea.EventAnnounceText:SetScript("OnTextChanged", settriggeroption(trigger_id, "announcetext"))
			TriggerArea.EventAnnounceText:SetScript("OnShow", showtriggeroption(trigger_id, "announcetext"))
			TriggerArea.EventAnnounce:SetPoint("TOPLEFT", 10, -55)
			TriggerArea.EventAnnounce:SetScript("OnClick", settriggeroption(trigger_id, "announce"))
			TriggerArea.EventAnnounce:SetScript("OnShow", showtriggeroption(trigger_id, "announce"))
			TriggerArea.EventSpecialWarning:SetScript("OnClick", settriggeroption(trigger_id, "specialwarn"))
			TriggerArea.EventSpecialWarning:SetScript("OnShow", showtriggeroption(trigger_id, "specialwarn"))
			TriggerArea.EventSetIcon:SetScript("OnClick", settriggeroption(trigger_id, "seticon"))
			TriggerArea.EventSetIcon:SetScript("OnShow", showtriggeroption(trigger_id, "seticon"))
			TriggerArea.EventStartTimer:SetScript("OnClick", function(self)
				settriggeroption(TriggerArea.id, "showbar")(self)
				if self:GetChecked() then
					TriggerArea.EventWarnEnd:Show()
					TriggerArea.EventWarnEndSec:Show()
					TriggerArea.EventWarnMsg:Show()
				else
					TriggerArea.EventWarnEnd:Hide()
					TriggerArea.EventWarnEndSec:Hide()
					TriggerArea.EventWarnMsg:Hide()
				end
			end)
			TriggerArea.EventStartTimer:SetScript("OnShow", function(self)
				showtriggeroption(TriggerArea.id, "showbar")(self)
				if self:GetChecked() then
					TriggerArea.EventWarnEnd:Show()
					TriggerArea.EventWarnEndSec:Show()
					TriggerArea.EventWarnMsg:Show()
				else
					TriggerArea.EventWarnEnd:Hide()
					TriggerArea.EventWarnEndSec:Hide()
					TriggerArea.EventWarnMsg:Hide()
				end
			end)
			TriggerArea.EventSpecialWarningOnlyMe:SetPoint("TOPLEFT", TriggerArea.EventSpecialWarning, "TOPRIGHT", 150, 0)
			TriggerArea.EventSpecialWarningOnlyMe:SetScript("OnClick", settriggeroption(trigger_id, "specialwarn"))
			TriggerArea.EventSpecialWarningOnlyMe:SetScript("OnShow", showtriggeroption(trigger_id, "specialwarn"))
			TriggerArea.EventBarMin:SetPoint('TOPLEFT', 30, -175)
			TriggerArea.EventBarSec:SetPoint('TOPLEFT', TriggerArea.EventBarMin, "TOPRIGHT", 20, 0)
			TriggerArea.EventBarMin:SetScript("OnTextChanged", settime)
			TriggerArea.EventBarSec:SetScript("OnTextChanged", settime)
			TriggerArea.EventBarMin:SetScript("OnShow", showtime)
			TriggerArea.EventBarSec:SetScript("OnShow", showtime)
			TriggerArea.EventWarnEnd:SetPoint("TOPLEFT", TriggerArea.EventSpecialWarningOnlyMe, "BOTTOMLEFT", 0, -20)
			TriggerArea.EventWarnEnd:SetScript("OnClick", settriggeroption(trigger_id, "barendwarn"))
			TriggerArea.EventWarnEnd:SetScript("OnShow", showtriggeroption(trigger_id, "barendwarn"))
			TriggerArea.EventWarnEndSec:SetPoint('TOPLEFT', 210, -175)
			TriggerArea.EventWarnEndSec:SetScript("OnTextChanged", settriggeroption(trigger_id, "barwarntime"))
			TriggerArea.EventWarnEndSec:SetScript("OnShow", showtriggeroption(trigger_id, "barwarntime"))
			TriggerArea.EventWarnMsg:SetPoint('TOPLEFT', TriggerArea.EventWarnEndSec, "TOPRIGHT", 20, 0)
			TriggerArea.EventWarnMsg:SetScript("OnTextChanged", settriggeroption(trigger_id, "barwarnmsg"))
			TriggerArea.EventWarnMsg:SetScript("OnShow", showtriggeroption(trigger_id, "barwarnmsg"))
			TriggerArea.beletemebutton:SetPoint('BOTTOMRIGHT', TriggerArea.frame, "TOPRIGHT", 0, -1)
			TriggerArea.beletemebutton:SetNormalFontObject(GameFontNormalSmall)
			TriggerArea.beletemebutton:SetHighlightFontObject(GameFontNormalSmall)
			TriggerArea.beletemebutton:SetScript("OnClick", function(self) 
				-- CleanUp values
				CurrentBossSetup.triggers[TriggerArea.id].name = ""
				CurrentBossSetup.triggers[TriggerArea.id].typ = ""
				CurrentBossSetup.triggers[TriggerArea.id].isactive = true
				CurrentBossSetup.triggers[TriggerArea.id].triggeryell = ""
				CurrentBossSetup.triggers[TriggerArea.id].triggerskill = 0
				CurrentBossSetup.triggers[TriggerArea.id].triggertime = 0
				CurrentBossSetup.triggers[TriggerArea.id].triggerhp = 0
				CurrentBossSetup.triggers[TriggerArea.id].announce = false
				CurrentBossSetup.triggers[TriggerArea.id].announcetext = ""
				CurrentBossSetup.triggers[TriggerArea.id].specialwarn = false
				CurrentBossSetup.triggers[TriggerArea.id].seticon = false
				CurrentBossSetup.triggers[TriggerArea.id].showbar = false
				CurrentBossSetup.triggers[TriggerArea.id].bartime = 0
				CurrentBossSetup.triggers[TriggerArea.id].barendwarn = false
				CurrentBossSetup.triggers[TriggerArea.id].barwarntime = 0
				CurrentBossSetup.triggers[TriggerArea.id].barwarnmsg = ""
				-- disable this trigger
				CurrentBossSetup.triggers[TriggerArea.id].isactive = false

				table.insert(DeletedTriggerFrames, TriggerArea)
				for i=1, select("#", TriggerArea.frame:GetChildren()), 1 do
					select(i, TriggerArea.frame:GetChildren()):Hide()
				end
		
				for i=1, select("#", BMS_Panel.frame:GetChildren()), 1 do	-- select all Areas
					if select(i, BMS_Panel.frame:GetChildren()) == TriggerArea.frame then
						if select("#", BMS_Panel.frame:GetChildren()) > i then
							select(i+1, BMS_Panel.frame:GetChildren()):ClearAllPoints()
							select(i+1, BMS_Panel.frame:GetChildren()):SetPoint('TOPLEFT', select(i-1, BMS_Panel.frame:GetChildren()), "BOTTOMLEFT", 0, -17)
						end
					end
					select(i, BMS_Panel.frame:GetChildren())
				end
				TriggerArea.frame:Hide()
				TriggerArea.frame:SetParent(UIParent)
		
				BMS_Panel:SetMyOwnHeight()
				DBM_GUI_OptionsFrame:DisplayFrame(BMS_Panel.frame)
			end)
			
			if not CurrentBossSetup.triggers[trigger_id].isactive then
				TriggerArea.beletemebutton:GetScript("OnClick")(TriggerArea.beletemebutton)
			end

			BMS_Panel:SetMyOwnHeight()
			DBM_GUI_OptionsFrame:DisplayFrame(BMS_Panel.frame)
		end		
		CurrentBossSetup.triggers = CurrentBossSetup.triggers or {}
		for k,v in ipairs(CurrentBossSetup.triggers) do
			if not CurrentBossSetup.triggers[k].isactive then
				table.remove(CurrentBossSetup.triggers, k)
			end
		end

		for i=1, #CurrentBossSetup.triggers, 1 do
			createtriggerframe(nil)
		end
		TriggerCreateBttn:SetScript("OnClick", createtriggerframe)
	end
	BMS_Panel:SetMyOwnHeight()
end
	
local function rebuild_modlist()
	for k,v in pairs(BossMods) do
		if not gui_panels[k] then
			create_BossMainPanel(v, k)
		end
	end
end

local function createbmsgui()
	BossMods = DBM_BMS

	BMS_Panel = DBM_GUI:CreateNewPanel(L.TabCategory_BossModStudio, "option")
--	BMS_Panel:Rename("lol porn")
--	BMS_Panel:Destroy()
	
	rebuild_modlist()

	local CurrentBossSetup = {}
	copytable(CurrentBossSetup, default_config)

	-------------------------------------------------
	--         Create a new BossMod                --
	-------------------------------------------------
	do 
		local BMS_Create = BMS_Panel:CreateArea(L.AreaHead_CreateBossMod, nil, 110, true)

		local BossName = BMS_Create:CreateEditBox(L.BossName, "", 230)
		BossName:SetPoint('TOPLEFT', 40, -25)
		BossName:SetScript("OnShow", function(self) self:SetText(CurrentBossSetup.BossName) end)
		BossName:SetScript("OnTextChanged", function(self) CurrentBossSetup.BossName = self:GetText() end)
		
		local CurCount = 1
		local BossID = BMS_Create:CreateEditBox(L.BossID, "0", 75)
		BossID.id = CurCount
		BossID:SetNumeric(true)
		BossID:SetPoint('TOPLEFT', BossName, "BOTTOMLEFT", 0, -20)
		BossID:SetScript("OnTextChanged", function(self) 
			if self:GetNumber() <= 0 then 
				CurrentBossSetup.BossIDs[self.id] = nil 
			else 
				CurrentBossSetup.BossIDs[self.id] = self:GetNumber()
			end 
		end)
		BossID:SetScript("OnShow", function(self) 
			if CurrentBossSetup.BossIDs[self.id] then
				self:SetText(CurrentBossSetup.BossIDs[self.id]) 
			else
				self:SetText("0")			
			end
		end)

		local BossLookup = BMS_Create:CreateButton(L.BossLookup, 160, nil, getIDfromTarget(BossID, CurrentBossSetup))
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
			BossID:SetNumeric(true)
			BossID:SetScript("OnTextChanged", function(self) 
				if self:GetNumber() <= 0 then 
					CurrentBossSetup.BossIDs[self.id] = nil 
				else 
					CurrentBossSetup.BossIDs[self.id] = self:GetNumber()
				end 
			end)
			BossID:SetScript("OnShow", function(self) 
				if CurrentBossSetup.BossIDs[self.id] then
					self:SetText(CurrentBossSetup.BossIDs[self.id]) 
				else
					self:SetText("0")
				end
			end)
			
	
			local BossLookup = BMS_Create:CreateButton(L.BossLookup, 160, nil, getIDfromTarget(BossID, CurrentBossSetup))
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

		local CreateMe = BMS_Create:CreateButton("CREATE", 75, 30)
		CreateMe:SetPoint('TOPRIGHT', BMS_Create.frame, "TOPRIGHT", -10, -10)	
		CreateMe:SetScript("OnClick", function(self)
			local BossName = BossName:GetText()
			if BossName and BossName:len() <= 3 or not unique_bossname(BossName) then
				DBM:AddMsg("Sorry, please specify a unique BossName")
				return false
			end
			
			table.insert(BossMods, CurrentBossSetup)
			-- create a new bosstable
			CurrentBossSetup = {}
			copytable(CurrentBossSetup, default_config)

			rebuild_modlist()
			DBM:AddMsg("Your BossMod has been created")

			-- refresh window
			DBM_GUI_OptionsFrame:Hide()
			DBM_GUI_OptionsFrame:Show()
		end)

	end
	do
		local BMS_Pull = BMS_Panel:CreateArea(L.AreaHead_Pull, nil, 165, true)
	
		local CombatFromYell = BMS_Pull:CreateCheckButton(L.CombatFromYell, true) --
		CombatFromYell:SetScript("OnClick", function(self) CurrentBossSetup.CombatFromYell = toboolean(self:GetChecked()) end)
		CombatFromYell:SetScript("OnShow", function(self) self:SetChecked(CurrentBossSetup.CombatFromYell) end)
	
		local CombatAutoDetect = BMS_Pull:CreateCheckButton(L.CombatAutoDetect)
		CombatAutoDetect:SetPoint("TOPLEFT", BMS_Pull.frame, "TOPLEFT", 220, -10)
		CombatAutoDetect:SetScript("OnClick", function(self) CurrentBossSetup.CombatAutoDetect = toboolean(self:GetChecked()) end)
		CombatAutoDetect:SetScript("OnShow", function(self) self:SetChecked(CurrentBossSetup.CombatAutoDetect)  end)

		local CurCount = 1
		local BossPullYell = BMS_Pull:CreateEditBox(L.BossPullYell, "", 230)
		BossPullYell.id = CurCount
		BossPullYell:SetPoint('TOPLEFT', CombatFromYell, "BOTTOMLEFT", 30, -15)
		BossPullYell:SetScript("OnTextChanged", function(self) CurrentBossSetup.BossPullYell[self.id] = self:GetText() end)
		BossPullYell:SetScript("OnShow", function(self) self:SetText(CurrentBossSetup.BossPullYell[self.id] or "") end)
	
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
			BossPullYell:SetScript("OnShow", function(self) self:SetText(CurrentBossSetup.BossPullYell[self.id] or "") end)
	
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

		--combined onshow!
		EnrageMin:SetScript("OnShow", function(self)
			EnrageMin:SetText( math.floor(CurrentBossSetup.EnrageTime/60) )
			EnrageSec:SetText( CurrentBossSetup.EnrageTime - (math.floor(CurrentBossSetup.EnrageTime/60)*60) )
		end)

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

DBM:RegisterOnGuiLoadCallback(createbmsgui, 5)



