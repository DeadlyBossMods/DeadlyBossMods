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
	only_from_raid = true,
	active_in_pvp = true,
	own_bargroup = false,
	show_portal = true,
	spells = {
		{ spell = 6346, bartext = default_bartext, cooldown = 180 },	-- Priest: Fear Ward
		{ spell = 1161, bartext = default_bartext, cooldown = 180 },	-- Warrior: Challenging Shout (AE Taunt)
		{ spell = 871, bartext = default_bartext, cooldown = 12 },	-- Warrior: Shieldwall Duration (for Healers to see how long SW runs)
		{ spell = 34477, bartext = default_bartext, cooldown = 30 },	-- Hunter: Missdirect
		{ spell = 20484, bartext = default_bartext, cooldown = 300 },	-- Druid: Rebirth
		{ spell = 29166, bartext = default_bartext, cooldown = 360 },	-- Druid: Innervate
		{ spell = 5209, bartext = default_bartext, cooldown = 180 }, 	-- Druid: Challenging Roar (AE Taunt)
		{ spell = 32182, bartext = default_bartext, cooldown = 600 },	-- Shaman: Heroism (alliance)
		{ spell = 2825, bartext = default_bartext, cooldown = 600 },	-- Shaman: Bloodlust (horde)
		{ spell = 22700, bartext = default_bartext, cooldown = 600 }, 	-- Field Repair Bot 74A
		{ spell = 44389, bartext = default_bartext, cooldown = 600 }, 	-- Field Repair Bot 110G
	},
	portal_alliance = {
		{ spell = 53142, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Dalaran
		{ spell = 33691, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Shattrath (Alliance)
		{ spell = 11416, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Ironforge
		{ spell = 10059, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Stormwind
		{ spell = 49360, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Theramore
		{ spell = 11419, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Darnassus
		{ spell = 32266, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Exodar
	},
	portal_horde = {
		{ spell = 53142, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Dalaran
		{ spell = 35717, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Shattrath (Horde)
		{ spell = 11417, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Orgrimmar
		{ spell = 11418, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Undercity
		{ spell = 11420, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Thunder Bluff
		{ spell = 32667, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Silvermoon
		{ spell = 49361, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Stonard
	}
}
DBM_SpellsUsed_Settings = {}
local settings = default_settings

local L = DBM_SpellsUsed_Translations

local SpellBars

L.TabCategory_SpellsUsed 	= "Spell/Skill Cooldowns"
L.AreaGeneral 			= "General Settings for Spell and Skill use Cooldowns"
L.Enable 			= "Enable Cooldownbars"
L.Show_LocalMessage 		= "Show local message on cast"
L.Enable_inRaid			= "Show Cooldowns only from RaidMembers"
L.Enable_inBattleground		= "Show Cooldowns in Battlegrounds"
L.Enable_Portals		= "Show Portal Durations"
L.Reset				= "reset to defaults"
L.Local_CastMessage 		= "Detected Cast: %s"
L.AreaAuras 			= "Setup the Spell/Skills"
L.SpellID 			= "Spell ID"
L.BarText 			= "Bar Text (default: %spell: %player)"
L.Cooldown 			= "Cooldown"
L.Error_FillUp			= "Please fillup all fields before adding an additional one"

-- functions
local addDefaultOptions
do 
	local function creategui()
		local createnewentry
		local CurCount = 0
		local panel = DBM_RaidLeadPanel:CreateNewPanel(L.TabCategory_SpellsUsed, "option")
		local generalarea = panel:CreateArea(L.AreaGeneral, nil, 150, true)
		local auraarea = panel:CreateArea(L.AreaAuras, nil, 20, true)

		local function regenerate()
			-- FIXME here we can reuse the frames to save some memory (if the player deletes entrys)
			for i=select("#", auraarea.frame:GetChildren()), 1, -1 do
				local v = select(i, auraarea.frame:GetChildren())
				v:Hide()
				v:SetParent(UIParent)
				v:ClearAllPoints()
			end
			auraarea.frame:SetHeight(20)
			CurCount = 0

			if #settings.spells == 0 then
				createnewentry()
			else
				for i=1, #settings.spells, 1 do
					createnewentry()
				end
			end				
		end

		
		do
			local area = generalarea
			local enabled = area:CreateCheckButton(L.Enable, true)
			enabled:SetScript("OnShow", function(self) self:SetChecked(settings.enabled) end)
			enabled:SetScript("OnClick", function(self) settings.enabled = not not self:GetChecked() end)

			local showlocal = area:CreateCheckButton(L.Show_LocalMessage, true)
			showlocal:SetScript("OnShow", function(self) self:SetChecked(settings.showlocal) end)
			showlocal:SetScript("OnClick", function(self) settings.showlocal = not not self:GetChecked() end)

			local showinraid = area:CreateCheckButton(L.Enable_inRaid, true)
			showinraid:SetScript("OnShow", function(self) self:SetChecked(settings.only_from_raid) end)
			showinraid:SetScript("OnClick", function(self) settings.only_from_raid = not not self:GetChecked() end)

			local showinpvp = area:CreateCheckButton(L.Enable_inBattleground, true)
			showinpvp:SetScript("OnShow", function(self) self:SetChecked(settings.active_in_pvp) end)
			showinpvp:SetScript("OnClick", function(self) settings.active_in_pvp = not not self:GetChecked() end)

			local show_portal = area:CreateCheckButton(L.Enable_Portals, true)
			show_portal:SetScript("OnShow", function(self) self:SetChecked(settings.show_portal) end)
			show_portal:SetScript("OnClick", function(self) settings.show_portal = not not self:GetChecked() end)

			local resetbttn = area:CreateButton(L.Reset, 140, 20)
			resetbttn:SetPoint("TOPRIGHT", area.frame, "TOPRIGHT", -15, -15)
			resetbttn:SetScript("OnClick", function(self)
				table.wipe(DBM_SpellsUsed_Settings)
				addDefaultOptions(settings, default_settings)
				regenerate()
				DBM_GUI_OptionsFrame:DisplayFrame(panel.frame)
			end)
		end
		do
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
					if field == "bartext" and settings.spells[self.guikey].spell and settings.spells[self.guikey].spell > 0 then
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
				local spellid = area:CreateEditBox(L.SpellID, "", 65)
				spellid.guikey = CurCount
				spellid:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 40, 15-(CurCount*35))
				spellid:SetScript("OnTextChanged", onchange_spell("spell"))
				spellid:SetScript("OnShow", onshow_spell("spell"))
				spellid:SetNumeric(true)
	
				local bartext = area:CreateEditBox(L.BarText, "", 190)
				bartext.guikey = CurCount
				bartext:SetPoint('TOPLEFT', spellid, "TOPRIGHT", 20, 0)
				bartext:SetScript("OnTextChanged", onchange_spell("bartext"))
				bartext:SetScript("OnShow", onshow_spell("bartext"))

				local cooldown = area:CreateEditBox(L.Cooldown, "", 65)
				cooldown.guikey = CurCount
				cooldown:SetPoint("TOPLEFT", bartext, "TOPRIGHT", 20, 0)
				cooldown:SetScript("OnTextChanged", onchange_spell("cooldown"))
				cooldown:SetScript("OnShow", onshow_spell("cooldown"))
				cooldown:SetNumeric(true)

				getadditionalid:ClearAllPoints()
				getadditionalid:SetPoint("RIGHT", spellid, "LEFT", -15, 0)
				area.frame:SetHeight( area.frame:GetHeight() + 35 )
				area.frame:GetParent():SetHeight( area.frame:GetParent():GetHeight() + 35 )
			
				panel:SetMyOwnHeight()
				if DBM_GUI_OptionsFramePanelContainer.displayedFrame and CurCount > 1 then
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

	myportals = {}
	local mainframe = CreateFrame("frame", "DBM_SpellTimers", UIParent)
	mainframe:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" and select(1, ...) == "DBM-RaidLeadTools" then
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

			-- Update settings of this Addon
			settings = DBM_SpellsUsed_Settings
			addDefaultOptions(settings, default_settings)

			-- CreateBarObject
			--[[ hmm, damm mass options. this sucks!
			if settings.own_bargroup then
				SpellBars = DBT:New()
				print_t(SpellBars.options)
				addDefaultOptions(SpellBars.options, DBM.Bars.options)
			else
				SpellBars = DBM.Bars
			end --]]
			SpellBars = DBM.Bars


			if UnitFactionGroup("player") == "Alliance" then
				myportals = settings.portal_alliance
			else
				myportals = settings.portal_horde
			end

		elseif event == "COMBAT_LOG_EVENT_UNFILTERED" and select(2, ...) == "SPELL_CAST_SUCCESS" and (
		     (settings.only_from_raid and DBM:IsInRaid()) 
		     or (settings.active_in_pvp and (select(2, IsInInstance()) == "pvp" or select(2, IsInInstance()) == "arena")) ) then

			local fromplayer = select(4, ...)
			local spellid = select(9, ...)
			if settings.only_from_raid and DBM:GetRaidUnitId(name) == "none" then return end	-- filter if cast is from outside raidgrp (we don't want to see mass spam in Dalaran/...)
			for k,v in pairs(settings.spells) do
				if v.spell == spellid then
					local spellinfo, _, icon = GetSpellInfo(spellid)
					local bartext = v.bartext:gsub("%%spell", spellinfo)
					bartext = bartext:gsub("%%player", fromplayer)
					SpellBars:CreateBar(v.cooldown, bartext, icon, nil, true)

					if settings.showlocal then
						DBM:AddMsg( L.Local_CastMessage:format(bartext) )
					end
				end
			end

		elseif event == "COMBAT_LOG_EVENT_UNFILTERED" and settings.show_portal and select(2, ...) == "SPELL_CREATE" then
			if not (settings.only_from_raid and DBM:IsInRaid() and DBM:GetRaidUnitId(name) ~= "none") then
				return -- cast from outside the raid (and only from raid is wished
			end

			local fromplayer = select(4, ...)
			local spellid = select(9, ...)

			for k,v in pairs(myportals) do
				if v.spell == spellid then
					local spellinfo, _, icon = GetSpellInfo(spellid)
					local bartext = v.bartext:gsub("%%spell", spellinfo)
					bartext = bartext:gsub("%%player", fromplayer)
					SpellBars:CreateBar(v.cooldown, bartext, icon, nil, true)

					if settings.showlocal then
						DBM:AddMsg( L.Local_CastMessage:format(bartext) )
					end
				end
			end
		end
	end)
	mainframe:RegisterEvent("ADDON_LOADED")
end

