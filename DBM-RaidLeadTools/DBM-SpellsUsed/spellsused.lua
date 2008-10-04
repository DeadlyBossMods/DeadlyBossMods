-- **********************************************************
-- **             Deadly Boss Mods - SpellsUsed            **
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

local default_bartext = "%spell: %player"
local default_settings = {
	enabled = true,
	showlocal = true,
	spells = {
		{ spell = 6346, bartext = default_bartext, cooldown = 180 },	-- Priest: Fear Ward
		{ spell = 1161, bartext = default_bartext, cooldown = 180 },	-- Warrior: AE Taunt
		{ spell = 34477, bartext = default_bartext, cooldown = 120 },	-- Hunter: Missdirect
		{ spell = 20484, bartext = default_bartext, cooldown = 300 },	-- Druid: Rebirth
		{ spell = 29166, bartext = default_bartext, cooldown = 360 },	-- Druid: Innervate
		{ spell = 32182, bartext = default_bartext, cooldown = 600 },	-- Shaman: Heroism (alliance)
		{ spell = 2825, bartext = default_bartext, cooldown = 600 },	-- Shaman: Bloodlust (horde)
	}
}
DBM_SpellsUsed_Settings = {}
local settings = default_settings

local L = DBM_SpellsUsed_Translations

L.TabCategory_SpellsUsed = "Spell/Skill Cooldowns"
L.AreaGeneral = "General Settings for Spell and Skill use Cooldowns"
L.Enable = "Enable Cooldownbars"
L.Show_LocalMessage = "Show local message on cast"
L.Reset	= "reset to defaults"
L.Local_CastMessage = "Detected Cast: %s"

L.AreaAuras = "Setup the Spell/Skills"
L.SpellID = "Spell ID"
L.Error_FillUp	= "Please fillup all fields before adding an additional one"

-- functions
local addDefaultOptions
do 
	local function creategui()
		local panel = DBM_RaidLeadPanel:CreateNewPanel(L.TabCategory_SpellsUsed, "option")
		local generalarea = panel:CreateArea(L.AreaGeneral, nil, 75, true)
		local auraarea = panel:CreateArea(L.AreaAuras, nil, 20, true)

		local function regenerate()
			-- FIXME here we can reuse the frames to save some memory (if the player deltes entrys)
			for i=1, select("#", auraarea.frame:GetChildren()) do
				local v = select(i, auraarea.frame:GetChildren())
				v:Hide()
				v:SetParent(nil)
				v:ClearAllPoints()
				auraarea.frame:SetHeight(20)
			end
			if #settings.spells == 0 then
				createnewentry()
			else
				for i=1, #settings.spells, 1 do
					createnewentry()
				end
			end				
		end

		local createnewentry
		do
			local area = generalarea
			local enabled = area:CreateCheckButton(L.Enable, true)
			enabled:SetScript("OnShow", function(self) self:SetChecked(settings.enabled) end)
			enabled:SetScript("OnClick", function(self) settings.enabled = not not self:GetChecked() end)

			local showlocal = area:CreateCheckButton(L.Show_LocalMessage, true)
			showlocal:SetScript("OnShow", function(self) self:SetChecked(settings.showlocal) end)
			showlocal:SetScript("OnClick", function(self) settings.showlocal = not not self:GetChecked() end)

			local resetbttn = area:CreateButton(L.Reset, 140, 20)
			resetbttn:SetPoint("TOPRIGHT", area.frame, "TOPRIGHT", -15, -15)
			resetbttn:SetScript("OnClick", function(self)
				DBM:AddMsg("RESET")
				table.wipe(DBM_SpellsUsed_Settings)
				addDefaultOptions(settings, default_settings)
				regenerate()
			end)
		end
		do
			local CurCount = 0
			local function onchange_spell(field)
				return function(self)
					settings.spells[self.guikey] = settings.spells[self.guikey] or {}
					if field == "spell" or field == "cooldown" then
						settings.spells[self.guikey][field] = self:GetNumber()
					else
						settings.spells[self.guikey][field] = self:GetText()
					end
				end
			end
			local function onshow_spell(field)
				return function(self)
					settings.spells[self.guikey] = settings.spells[self.guikey] or {}
					if field == "bartext" then
						local text = settings.spells[self.guikey][field] or ""
						local spellinfo = GetSpellInfo(settings.spells[self.guikey].spell)
						self:SetText( text:gsub("%%spell", spellinfo) )
					else
						self:SetText( settings.spells[self.guikey][field] or "" )
					end
				end
			end	

			local area = auraarea

			local getadditionalid = CreateFrame("Button", "GetAdditionalID_Pull", area.frame)
			getadditionalid:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP");
			getadditionalid:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-DOWN");
			getadditionalid:SetWidth(15)
			getadditionalid:SetHeight(15)		

			function createnewentry()
				CurCount = CurCount + 1
				local spellid = area:CreateEditBox("Spell ID", "", 65)
				spellid.guikey = CurCount
				spellid:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 40, 15-(CurCount*35))
				spellid:SetScript("OnTextChanged", onchange_spell("spell"))
				spellid:SetScript("OnShow", onshow_spell("spell"))
	
				local bartext = area:CreateEditBox("Bar Text", "", 190)
				bartext.guikey = CurCount
				bartext:SetPoint('TOPLEFT', spellid, "TOPRIGHT", 20, 0)
				bartext:SetScript("OnTextChanged", onchange_spell("bartext"))
				bartext:SetScript("OnShow", onshow_spell("bartext"))

				local cooldown = area:CreateEditBox("Cooldown", "", 65)
				cooldown.guikey = CurCount
				cooldown:SetPoint("TOPLEFT", bartext, "TOPRIGHT", 20, 0)
				cooldown:SetScript("OnTextChanged", onchange_spell("cooldown"))
				cooldown:SetScript("OnShow", onshow_spell("cooldown"))

				getadditionalid:ClearAllPoints()
				getadditionalid:SetPoint("RIGHT", spellid, "LEFT", -15, 0)
				area.frame:SetHeight( area.frame:GetHeight() + 35 )
				area.frame:GetParent():SetHeight( area.frame:GetParent():GetHeight() + 35 )
			
				panel:SetMyOwnHeight()
				if CurCount > 1 then
					DBM_GUI_OptionsFrame:DisplayFrame(panel.frame)
				end

				getadditionalid:SetScript("OnClick", function()
					if spellid:GetNumber() > 0 and bartext:GetText():len() > 0 and cooldown:GetNumber() > 0 then
						createnewentry()
					else
						DBM:AddMsg(L.Error_FillUp)
					end
				end)
			end
			
			if #settings.spells == 0 then
				createnewentry()
			else
				for i=1, #settings.spells, 1 do
					createnewentry()
				end
			end
		end
		panel:SetMyOwnHeight()
	end
	DBM:RegisterOnGuiLoadCallback(creategui, 15)
end


do
	function addDefaultOptions(t1, t2)
		for i, v in pairs(t2) do
			if t1[i] == nil then
				t1[i] = v
			elseif type(v) == "table" then
				addDefaultOptions(v, t2[i])
			end
		end
	end

	local mainframe = CreateFrame("frame", "DBM_SpellTimers", UIParent)
	mainframe:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" and select(1, ...) == "DBM-RaidLeadTools" then
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

			-- Update settings of this Addon
			settings = DBM_SpellsUsed_Settings
			addDefaultOptions(settings, default_settings)

		elseif event == "COMBAT_LOG_EVENT_UNFILTERED" and select(2, ...) == "SPELL_CAST_SUCCESS" then
			local fromplayer = select(4, ...)
			local spellid = select(9, ...)
			for k,v in pairs(settings.spells) do
				if v.spell == spellid then
					local spellinfo = GetSpellInfo(spellid)
					local bartext = v.bartext:gsub("%%spell", spellinfo)
					bartext = bartext:gsub("%%player", fromplayer)
					DBM.Bars:CreateBar(v.cooldown, bartext, nil, nil, true)

					if settings.showlocal then
						DBM:AddMsg( L.Local_CastMessage:format(bartext) )
					end
				end
			end
		end
	end)
	mainframe:RegisterEvent("ADDON_LOADED")
end

