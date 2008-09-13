-- **********************************************************
-- **           Deadly Boss Mods - GUI DropDown's          **
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

do 
	local MAX_BUTTONS = 10
	local TabFrame1 = CreateFrame("Frame", "DBM_GUI_DropDown", UIParent)
	TabFrame1:SetBackdrop({
		bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", 
		edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", 
		tile=1, tileSize=32, edgeSize=32, 
		insets={left=11, right=12, top=12, bottom=11}
	});
	TabFrame1:SetFrameStrata("FULLSCREEN_DIALOG")
	TabFrame1:EnableMouseWheel(1)
	TabFrame1:SetScript("OnMouseWheel", function(self, arg1) 
		if arg1 > 0 then  -- scroll up
			self.offset = self.offset - 1
			if self.offset < 0 then
				self.offset = 0
			end
		else		  -- scroll down
			self.offset = self.offset + 1
		end	
		self:Refresh()
	end)
	TabFrame1:Hide()

	TabFrame1.offset = 0

	local function ButtonDefaultFunction(self)
		self:GetParent():HideMenu()
		if self.entry.func then
			self.entry.func(self.entry.value)
		end
		if self:GetParent().dropdown.callfunc then
			self:GetParent().dropdown.callfunc(self.entry.value)
		end
		getglobal(self:GetParent().dropdown:GetName().."Text"):SetText(self.entry.text)
	end

	TabFrame1.buttons = {}
	for i=1, MAX_BUTTONS, 1 do
		TabFrame1.buttons[i] = CreateFrame("Button", TabFrame1:GetName().."Button"..i, TabFrame1, "DBM_GUI_DropDownMenuButtonTemplate")
		TabFrame1.buttons[i]:SetScript("OnClick", ButtonDefaultFunction)
		if i == 1 then
			TabFrame1.buttons[i]:SetPoint("TOPLEFT", TabFrame1, "TOPLEFT", 11, -13)
		else
			TabFrame1.buttons[i]:SetPoint("TOPLEFT", TabFrame1.buttons[i-1], "BOTTOMLEFT", 0,0)
		end
	end
	TabFrame1:SetWidth(TabFrame1.buttons[1]:GetWidth()+22)
	TabFrame1:SetHeight(MAX_BUTTONS*TabFrame1.buttons[1]:GetHeight()+24)

	TabFrame1.text = TabFrame1:CreateFontString(TabFrame1:GetName().."Text", 'BACKGROUND')
	TabFrame1.text:SetPoint('CENTER', TabFrame1, 'BOTTOM', 0, 0)
	TabFrame1.text:SetFontObject('GameFontNormalSmall')
	TabFrame1.text:SetText("scroll with mouse")
	TabFrame1.text:Hide()

	local BackDropTable = { bgFile = "" }
	function TabFrame1:ShowMenu(values)
		self:Show()
		if self.offset > #values-MAX_BUTTONS then self.offset = #values-MAX_BUTTONS end
		if self.offset < 0 then self.offset = 0 end

		if #values > MAX_BUTTONS then
			self.text:Show()
		elseif #values < MAX_BUTTONS then
			self:SetHeight( #values * self.buttons[1]:GetHeight() + 24 )
			self.text:Hide()
		end

		for i=1, MAX_BUTTONS, 1 do
			if i + self.offset <= #values then
				self.buttons[i]:SetText(values[i+self.offset].text)
				self.buttons[i].entry = values[i+self.offset]
				BackDropTable.bgFile = values[i+self.offset].value
				self.buttons[i]:SetBackdrop(BackDropTable)
				self.buttons[i]:Show()
			else
				self.buttons[i]:Hide()
			end
		end
	end

	function TabFrame1:HideMenu()
		for i=1, MAX_BUTTONS, 1 do
			self.buttons[i]:Hide()
			self.buttons[i]:SetBackdrop(nil)
		end
		self:Hide()
		self.text:Hide()
	end

	function TabFrame1:Refresh()
		self:ShowMenu(self.dropdown.values)
	end

	local FrameTitle = "DBM_GUI_DropDown"
	function DBM_GUI:CreateDropdown(title, values, selected, callfunc)
		-- Check Values
		self:CheckValues(values)
	
		-- Create the Dropdown Frame
		local dropdown = CreateFrame("Frame", FrameTitle..self:GetNewID(), self.frame, "DBM_GUI_DropDownMenuTemplate")
		dropdown.values = values
		dropdown.callfunc = callfunc
		getglobal(dropdown:GetName().."Button"):SetScript("OnClick", function(self)
			PlaySound("igMainMenuOptionCheckBoxOn")
			if TabFrame1:IsShown() then
				TabFrame1:HideMenu()
				TabFrame1.dropdown = nil
			else
				TabFrame1.dropdown = self:GetParent()
				TabFrame1:ShowMenu(self:GetParent().values)
				TabFrame1:ClearAllPoints()
				TabFrame1:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 0, -3)
				TabFrame1:SetParent(self:GetParent())
			end
		end)

		for k,v in next, dropdown.values do
			if v.value ~= nil and v.value == selected or v.text == selected then
				getglobal(dropdown:GetName().."Text"):SetText(v.text)
			end
		end

		local text = dropdown:CreateFontString(FrameTitle..self:GetCurrentID().."Text", 'BACKGROUND')
		text:SetPoint('BOTTOMLEFT', dropdown, 'TOPLEFT', 21, 0)
		text:SetFontObject('GameFontNormalSmall')
		text:SetText(title)

		return dropdown
	end
end

function DBM_GUI:CheckValues(values)
	if type(values) == "table" then
		for _,entry in next,values do
			entry.text = entry.text or "Missing entry.text"
			entry.value = entry.value or entry.text
		end
	end
	return false
end




