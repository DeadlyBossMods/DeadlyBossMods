---@class DBMCoreNamespace
local private = select(2, ...)

local L = DBM_CORE_L
local CL = DBM_COMMON_L

---@class DBM
local DBM = private:GetPrototype("DBM")
---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")
local tableUtils = private:GetPrototype("TableUtils")
local removeEntry = tableUtils.removeEntry

-- Local tracking table for duplicate option detection
local checkDuplicateObjects = {}

---------------
--  Options  --
---------------
---@param name any Option name must be string, but language server gets confused if it's not set to any
---@param default SpecFlags|boolean?
---@param cat string? category type: ie "timer", "announce", "misc", "sound", etc
---@param func any? Custom function to call when option is changed
---@param extraOption string|number? Used for attached options such as timer color or special warning sound
---@param extraOptionTwo string|number? Used for attached options such as countdown voice or special warning note
---@param spellId any? spellId to group with other options for same spell
---@param optionSubType string? ie "gtfo", "adds", "achievement", "stage", etc
---@param waCustomName string? used to inject custom weak aura spellId key text
function bossModPrototype:AddBoolOption(name, default, cat, func, extraOption, extraOptionTwo, spellId, optionSubType, waCustomName)
	if checkDuplicateObjects[name] and name ~= "timer_berserk" then
		DBM:Debug("|cffff0000Option already exists for: |r" .. name)
	else
		checkDuplicateObjects[name] = true
	end
	cat = cat or "misc"
	self.DefaultOptions[name] = (default == nil) or default
	if cat == "timer" then
		self.DefaultOptions[name .. "TColor"] = extraOption or 0
		self.DefaultOptions[name .. "CVoice"] = extraOptionTwo or 0
	end
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	if cat == "timer" then
		self.Options[name .. "TColor"] = extraOption or 0
		self.Options[name .. "CVoice"] = extraOptionTwo or 0
	end
	if spellId then
		if waCustomName then--Do custom shit for options using invalid spellIds as weak auras keys
			self:GroupWASpells(waCustomName, spellId, name)
		else
			if optionSubType and optionSubType == "achievement" then
				spellId = "at" .. spellId--"at" for achievement timer
			end
			local optionTypeMatch = optionSubType or ""
			if not optionTypeMatch:find("stage") then
				self:GroupSpells(spellId, name)
			end
		end
	end
	self:SetOptionCategory(name, cat, optionSubType, waCustomName)
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

---@param name any
---@param default SpecFlags|boolean?
---@param defaultSound number|string? Can be number for built in spec warn sound 1-4 or string for custom sound path
---@param cat string? category type: ie "timer", "announce", "misc", "sound", etc
---@param spellId any? spellId to group with other options for same spell
---@param optionType string?
---@param waCustomName string? used to inject custom weak aura spellId key text
function bossModPrototype:AddSpecialWarningOption(name, default, defaultSound, cat, spellId, optionType, waCustomName)
	if checkDuplicateObjects[name] then
		DBM:Debug("|cffff0000Option already exists for: |r" .. name)
	else
		checkDuplicateObjects[name] = true
	end
	cat = cat or "misc"
	self.DefaultOptions[name] = (default == nil) or default
	self.DefaultOptions[name .. "SWSound"] = defaultSound or 1
	self.DefaultOptions[name .. "SWNote"] = true
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self.Options[name .. "SWSound"] = defaultSound or 1
	self.Options[name .. "SWNote"] = true
	if spellId then
		if waCustomName then--Do custom shit for options using invalid spellIds as weak auras keys
			self:GroupWASpells(waCustomName, spellId, name)
		else
			self:GroupSpells(spellId, name)
		end
	end
	self:SetOptionCategory(name, cat, optionType, waCustomName)
end

---@meta
---@alias paSubTypes
---|0: Generic subtype for generalized use
---|1: Custom subtype for when targetted by the private aura spell
---|2: Custom subtype for when standing in the private aura spell (GTFO)
---@param auraspellId number must match debuff ID so EnablePrivateAuraSound function can call right option key and right debuff ID
---@param default SpecFlags|boolean?
---@param groupSpellId number? is used if a diff option key is used in all other options with spell (will be quite common)
---@param defaultSound acceptedSASounds? is used to set default Special announce sound (1-4) just like regular special announce objects
---@param subType paSubTypes? 0/nil: default, 1: targetted, 2:gtfo
function bossModPrototype:AddPrivateAuraSoundOption(auraspellId, default, groupSpellId, defaultSound, subType)
	self.DefaultOptions["PrivateAuraSound" .. auraspellId] = (default == nil) or default
	self.DefaultOptions["PrivateAuraSound" .. auraspellId .. "SWSound"] = defaultSound or 1
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["PrivateAuraSound" .. auraspellId] = (default == nil) or default
	--LuaLS is just stupid here. There is no rule that says self.Options.Variable has to be a bool. Entire SWSound variable scope is always a number
	---@diagnostic disable-next-line: assign-type-mismatch
	self.Options["PrivateAuraSound" .. auraspellId .. "SWSound"] = defaultSound or 1
	subType = subType or 0
	if subType == 1 then
		self.localization.options["PrivateAuraSound" .. auraspellId] = L.AUTO_PRIVATEAURA_OPTION_TARGET_TEXT:format(auraspellId)
	elseif subType == 2 then
		self.localization.options["PrivateAuraSound" .. auraspellId] = L.AUTO_PRIVATEAURA_OPTION_GTFO_TEXT:format(auraspellId)
	else
		self.localization.options["PrivateAuraSound" .. auraspellId] = L.AUTO_PRIVATEAURA_OPTION_TEXT:format(auraspellId)
	end
--	if not DBM.Options.GroupOptionsExcludePA then
		self:GroupSpellsPA(groupSpellId or auraspellId, "PrivateAuraSound" .. auraspellId)
--	end
	self:SetOptionCategory("PrivateAuraSound" .. auraspellId, "paura", nil, nil, true)
end

---Object for customizing blizzard timeline object with colors and sounds
---@param spellId number SpellID used for option text and saved variables
---@param default SpecFlags|boolean?
---@param defaultColor timerColorType ColorId 1-6 for color bar by type
---@param defaultVoice number? VoiceId for countdown voice
---@param groupSpellId number? is used if a diff option key is used in all other options with spell (will be quite common)
function bossModPrototype:AddCustomTimerOptions(spellId, default, defaultColor, defaultVoice, groupSpellId)
	self.DefaultOptions["CustomTimerOption" .. spellId] = (default == nil) or default
	--Note:, TColor and CVoice are generated in AddBoolOption
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["CustomTimerOption" .. spellId] = (default == nil) or default

	self.localization.options["CustomTimerOption" .. spellId] = L.AUTO_CUSTOMTIMER_OPTION_TEXT:format(spellId)
	self:GroupSpellsPA(groupSpellId or spellId, "CustomTimerOption" .. spellId)
	self:AddBoolOption("CustomTimerOption" .. spellId, default, "timer", nil, defaultColor, defaultVoice, spellId)
end

---Object for customizing blizzard alerts to be shown or what sound plays for them
---@param auraspellId number SpellID used for option text and saved variables
---@param default SpecFlags|boolean?
---@param defaultSound acceptedSASounds is used to set default Special announce sound (1-4) just like regular special announce objects
---@param groupSpellId number? is used if a diff option key is used in all other options with spell (will be quite common)
function bossModPrototype:AddCustomAlertSoundOption(auraspellId, default, defaultSound, groupSpellId)
	self.DefaultOptions["CustomAlertOption" .. auraspellId] = (default == nil) or default
	self.DefaultOptions["CustomAlertOption" .. auraspellId .. "SWSound"] = defaultSound
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["CustomAlertOption" .. auraspellId] = (default == nil) or default
	--LuaLS is just stupid here. There is no rule that says self.Options.Variable has to be a bool. Entire SWSound variable scope is always a number
	---@diagnostic disable-next-line: assign-type-mismatch
	self.Options["CustomAlertOption" .. auraspellId .. "SWSound"] = defaultSound or 1
	self.localization.options["CustomAlertOption" .. auraspellId] = L.AUTO_CUSTOMALERT_OPTION_TEXT:format(auraspellId)
	self:GroupSpellsPA(groupSpellId or auraspellId, "CustomAlertOption" .. auraspellId)
	self:SetOptionCategory("CustomAlertOption" .. auraspellId, "announce")
end

---@meta
---@alias iconTypes
---|0: Player icon using no sorting. Most common in boss mods
---|1: Player icon using melee > ranged with alphabetical sorting on multiple melee
---|2: Player icon using melee > ranged with raid roster index sorting on multiple melee
---|3: Player icon using ranged > melee with alphabetical sorting on multiple ranged
---|4: Player icon using ranged > melee with raid roster index sorting on multiple ranged
---|5: NPC icon using feature that chooses ideal setter. Always use 5 for NPCS
---|6: Player icon using only alphabetical sorting
---|7: Player icon using only raid roster index sorting
---|8: Player icon using tank > non tank with alphabetical sorting on multiple melee
---|9: Player icon using tank > non tank with raid roster index sorting on multiple melee
---|10: Player icon using melee > ranged > healer
---|11: Player icon using tank > dps > healer
---@param default SpecFlags|boolean?
---@param iconType iconTypes?
---@param iconsUsed table? table defining used icons such as {1, 2, 3}
---@param conflictWarning boolean? set to true if this mod has 2 or more icon options that use the same icons
function bossModPrototype:AddSetIconOption(name, spellId, default, iconType, iconsUsed, conflictWarning, groupSpellId)
	self.DefaultOptions[name] = (default == nil) or default
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	if (groupSpellId or spellId) and not DBM.Options.GroupOptionsExcludeIcon then
		self:GroupSpells(groupSpellId or spellId, name)
	end
	self:SetOptionCategory(name, "icon")
	--Legacy notice about outdated bool and nil support
	--Will be removed before TWW
	iconType = iconType or 0
	if type(iconType) ~= "number" then
		error("DBM iconType must be a number. If you are seeing this error your content mods are probabably out of date")
	end
	if iconType == 1 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_MELEE_A:format(spellId) or self.localization.options[name]
	elseif iconType == 2 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_MELEE_R:format(spellId) or self.localization.options[name]
	elseif iconType == 3 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_RANGED_A:format(spellId) or self.localization.options[name]
	elseif iconType == 4 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_RANGED_R:format(spellId) or self.localization.options[name]
	elseif iconType == 5 then
		--NPC/Mob setting uses icon elect feature and needs to establish latency check table
		if not self.findFastestComputer then
			self.findFastestComputer = {}
		end
		self.findFastestComputer[#self.findFastestComputer + 1] = name
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_NPCS:format(spellId) or self.localization.options[name]
	elseif iconType == 6 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_ALPHA:format(spellId) or self.localization.options[name]
	elseif iconType == 7 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_ROSTER:format(spellId) or self.localization.options[name]
	elseif iconType == 8 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_TANK_A:format(spellId) or self.localization.options[name]
	elseif iconType == 9 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_TANK_R:format(spellId) or self.localization.options[name]
	elseif iconType == 10 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_MRH:format(spellId) or self.localization.options[name]
	elseif iconType == 11 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_TOH:format(spellId) or self.localization.options[name]
	else--Type 0 (Generic for targets)
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS:format(spellId) or self.localization.options[name]
	end
	--A table defining used icons by number, insert icon textures to end of option
	if iconsUsed then
		self.localization.options[name] = self.localization.options[name] .. " ("
		for i = 1, #iconsUsed do
			--Texture ID 137009 if direct calling RaidTargetingIcons stops working one day
			---
			if 		iconsUsed[i] == 1 then		self.localization.options[name] = self.localization.options[name] .. CL.STAR_ICON_SMALL
			elseif	iconsUsed[i] == 2 then		self.localization.options[name] = self.localization.options[name] .. CL.CIRCLE_ICON_SMALL
			elseif	iconsUsed[i] == 3 then		self.localization.options[name] = self.localization.options[name] .. CL.DIAMOND_ICON_SMALL
			elseif	iconsUsed[i] == 4 then		self.localization.options[name] = self.localization.options[name] .. CL.TRIANGLE_ICON_SMALL
			elseif	iconsUsed[i] == 5 then		self.localization.options[name] = self.localization.options[name] .. CL.MOON_ICON_SMALL
			elseif	iconsUsed[i] == 6 then		self.localization.options[name] = self.localization.options[name] .. CL.SQUARE_ICON_SMALL
			elseif	iconsUsed[i] == 7 then		self.localization.options[name] = self.localization.options[name] .. CL.CROSS_ICON_SMALL
			elseif	iconsUsed[i] == 8 then		self.localization.options[name] = self.localization.options[name] .. CL.SKULL_ICON_SMALL
			end
		end
		self.localization.options[name] = self.localization.options[name] .. ")"
		if conflictWarning then
			self.localization.options[name] = self.localization.options[name] .. L.AUTO_ICONS_OPTION_CONFLICT
		end
	end
end

---Still used for situations we may use static arrows to point for a specific way to move. Legacy arrows also supported toward/away from specific player units
---@meta
---@alias arrowTypes
---|1: Shows an arrow pointing toward player target
---|2: Shows an arrow pointing away from player target
---|3: Shows an arrow pointing toward specific location
---@param name string Option name
---@param spellId number if used, auto localizes using spell or journal id. if left blank uses generic description
---@param default SpecFlags|boolean?
---@param isRunTo arrowTypes|number
function bossModPrototype:AddArrowOption(name, spellId, default, isRunTo)
	if isRunTo == true then isRunTo = 2 end--Support legacy
	self.DefaultOptions[name] = (default == nil) or default
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:GroupSpells(spellId, name)
	self:SetOptionCategory(name, "misc")
	if isRunTo == 2 then
		self.localization.options[name] = L.AUTO_ARROW_OPTION_TEXT:format(spellId)
	elseif isRunTo == 3 then
		self.localization.options[name] = L.AUTO_ARROW_OPTION_TEXT3:format(spellId)
	else
		self.localization.options[name] = L.AUTO_ARROW_OPTION_TEXT2:format(spellId)
	end
end

---Legacy object at this point. Range checks aren't added to new modules due to no longer being usable inside raids. they should NOT be removed from old modules in event blizzard ever adds built in functionality we can automate
---@param range number|string Non optional, should be number if fixed ranged or string with custom string such as "various" or "10/6"
---@param spellId number? if used, auto localizes using spell or journal id. if left blank uses generic description
---@param default SpecFlags|boolean?
function bossModPrototype:AddRangeFrameOption(range, spellId, default)
	self.DefaultOptions["RangeFrame"] = (default == nil) or default
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["RangeFrame"] = (default == nil) or default
	if spellId then
		self:GroupSpells(spellId, "RangeFrame")
		self.localization.options["RangeFrame"] = L.AUTO_RANGE_OPTION_TEXT:format(range, spellId)
	else
		self.localization.options["RangeFrame"] = L.AUTO_RANGE_OPTION_TEXT_SHORT:format(range)
	end
	self:SetOptionCategory("RangeFrame", "misc")
end

---Legacy object at this point. HUD checks aren't added to new modules due to no longer being usable inside raids.
---@param name string Option name
---@param spellId number? if used, auto localizes using spell or journal id. if left blank uses generic description
---@param default SpecFlags|boolean?
function bossModPrototype:AddHudMapOption(name, spellId, default)
	self.DefaultOptions[name] = (default == nil) or default
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	if spellId then
		self:GroupSpells(spellId, name)
		self.localization.options[name] = L.AUTO_HUD_OPTION_TEXT:format(spellId)
	else
		self.localization.options[name] = L.AUTO_HUD_OPTION_TEXT_MULTI
	end
	self:SetOptionCategory(name, "misc")
end

---@param name string Option name
---@param spellId number if used, auto localizes using spell or journal id. if left blank uses generic description
---@param default SpecFlags|boolean?
---@param forceDBM boolean? Used in very rare cases we need to use nameplate feature without a clean place to use enable/disable callbacks for 3rd party NP addons
function bossModPrototype:AddNamePlateOption(name, spellId, default, forceDBM)
	if not spellId then
		error("AddNamePlateOption must provide valid spellId", 2)
	end
	self.DefaultOptions[name] = (default == nil) or default
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:GroupSpells(spellId, name)
	self:SetOptionCategory(name, "nameplate")
	self.localization.options[name] = forceDBM and L.AUTO_NAMEPLATE_OPTION_TEXT_FORCED:format(spellId) or L.AUTO_NAMEPLATE_OPTION_TEXT:format(spellId)
end

---@param spellId number? if used, auto localizes using spell or journal id. if left blank uses generic description
---@param default SpecFlags|boolean?
function bossModPrototype:AddInfoFrameOption(spellId, default, optionVersion, optionalThreshold)
	local oVersion = ""
	if optionVersion then
		oVersion = tostring(optionVersion)
	end
	self.DefaultOptions["InfoFrame" .. oVersion] = (default == nil) or default
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["InfoFrame" .. oVersion] = (default == nil) or default
	if spellId then
		self:GroupSpells(spellId, "InfoFrame" .. oVersion)
		if optionalThreshold then
			self.localization.options["InfoFrame" .. oVersion] = L.AUTO_INFO_FRAME_OPTION_TEXT3:format(spellId, optionalThreshold)
		else
			self.localization.options["InfoFrame" .. oVersion] = L.AUTO_INFO_FRAME_OPTION_TEXT:format(spellId)
		end
	else
		self.localization.options["InfoFrame" .. oVersion] = L.AUTO_INFO_FRAME_OPTION_TEXT2
	end
	self:SetOptionCategory("InfoFrame" .. oVersion, "misc")
end


---@meta
---@alias gossipTypes
---|"Action": Auto select gossip choice(s) to perform actions (such as using transports)
---|"Encounter": Auto select gossip choice to start encounter
---|"Buff": Auto select gossip choice(s) for npc or profession buffs
---@param default SpecFlags|boolean?
---@param gossipType gossipTypes|string
function bossModPrototype:AddGossipOption(default, gossipType, optionVersion)
	local oVersion = ""
	if optionVersion then
		oVersion = tostring(optionVersion)
	end
	self.DefaultOptions["AutoGossip" .. gossipType .. oVersion] = (default == nil) or default
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["AutoGossip" .. gossipType .. oVersion] = (default == nil) or default
	if gossipType == "Action" then
		self.localization.options["AutoGossip" .. gossipType .. oVersion] = L.AUTO_GOSSIP_PERFORM_ACTION
	elseif gossipType == "Encounter" then
		self.localization.options["AutoGossip" .. gossipType .. oVersion] = L.AUTO_GOSSIP_START_ENCOUNTER
	else--Buff
		self.localization.options["AutoGossip" .. gossipType .. oVersion] = L.AUTO_GOSSIP_BUFFS
	end
	self:SetOptionCategory("AutoGossip" .. gossipType .. oVersion, "misc")
end

---@param default SpecFlags|boolean?
---@param maxLevel number? set max level if you want to disable this readycheck from firing at a certain point
function bossModPrototype:AddReadyCheckOption(questId, default, maxLevel)
	self.readyCheckQuestId = questId
	self.readyCheckMaxLevel = maxLevel or 999
	self.DefaultOptions["ReadyCheck"] = (default == nil) or default
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["ReadyCheck"] = (default == nil) or default
	self.localization.options["ReadyCheck"] = L.AUTO_READY_CHECK_OPTION_TEXT
	self:SetOptionCategory("ReadyCheck", "misc")
end

---@param name string Option Name
---@param default SpecFlags|boolean?
function bossModPrototype:AddSpeedClearOption(name, default)
	self.DefaultOptions["SpeedClearTimer"] = (default == nil) or default
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["SpeedClearTimer"] = (default == nil) or default
	self:SetOptionCategory("SpeedClearTimer", "timer")
	self.localization.options["SpeedClearTimer"] = L.AUTO_SPEEDCLEAR_OPTION_TEXT:format(name)
end

-- FIXME: this function does not reset any settings to default if you remove an option in a later revision and a user has selected this option in an earlier revision were it still was available
-- this will be fixed as soon as it is necessary due to removed options ;-)
---@param name string Option Name
---@param options table Options table
---@param default any Which table entry is default
---@param cat string? Option Category. If left blank, defaults to "misc"
---@param func any?
---@param spellId number? spellId used for option category grouping
function bossModPrototype:AddDropdownOption(name, options, default, cat, func, spellId)
	cat = cat or "misc"
	self.DefaultOptions[name] = {type = "dropdown", value = default}
	self.Options[name] = default
	if spellId then
		self:GroupSpells(spellId, name)
	end
	self:SetOptionCategory(name, cat)
	self.dropdowns = self.dropdowns or {}
	self.dropdowns[name] = options
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddOptionSpacer(cat)
	cat = cat or "misc"
	if self.optionCategories[cat] then
		tinsert(self.optionCategories[cat], DBM_OPTION_SPACER)
	end
end

do
	local lineCount = 1

	function bossModPrototype:AddOptionLine(text, cat, forceIgnore)
		if self.addon and not forceIgnore then
			self.groupOptions["line" .. lineCount] = text
			lineCount = lineCount + 1
		else
			cat = cat or "misc"
			if not self.optionCategories[cat] then
				self.optionCategories[cat] = {}
			end
			if self.optionCategories[cat] then
				tinsert(self.optionCategories[cat], {line = true, text = text})
			end
		end
	end
end

function bossModPrototype:AddAnnounceSpacer()
	return self:AddOptionSpacer("announce")
end

function bossModPrototype:AddTimerSpacer()
	return self:AddOptionSpacer("timer")
end

function bossModPrototype:AddAnnounceLine(text)
	return self:AddOptionLine(text, "announce")
end

function bossModPrototype:AddTimerLine(text)
	return self:AddOptionLine(text, "timer")
end

function bossModPrototype:AddNamePlateLine(text)
	return self:AddOptionLine(text, "nameplate")
end

function bossModPrototype:AddIconLine(text)
	return self:AddOptionLine(text, "icon")
end

function bossModPrototype:AddMiscLine(text)
	return self:AddOptionLine(text, "misc", true)
end

function bossModPrototype:RemoveOption(name)
	self.Options[name] = nil
	for k, options in pairs(self.optionCategories) do
		removeEntry(options, name)
		if #options == 0 then
			self.optionCategories[k] = nil
		end
	end
	if self.optionFuncs then
		self.optionFuncs[name] = nil
	end
end

---This function, which will be called after all iterations of GroupWASpells/GroupSpells will just straight up say "ok now ignore keys these made and just use custom ones" for extremely niche cases
function bossModPrototype:JustSetCustomKeys(catSpell, customKeys)
	catSpell = tostring(catSpell)
	if not self.groupSpells[catSpell] then
		self.groupSpells[catSpell] = {}
	end
	if not self.groupOptions[catSpell] then
		self.groupOptions[catSpell] = {}
	end
	self.groupOptions[catSpell].customKeys = customKeys
end

---Custom function for handling group spells where we want to group by ID, but not use that IDs name (basically a fake Id for purpose of a unified WA key)
---This lets us group options up that aren't using valid IDs, and show the ID it is using for WA in the gui next to custom name
---@param customName string? Used to inject custom weak aura spellId key text
function bossModPrototype:GroupWASpells(customName, ...)
	local spells = {...}
	local catSpell = tostring(tremove(spells, 1))
	if not self.groupSpells[catSpell] then
		self.groupSpells[catSpell] = {}
	end
	for _, spell in ipairs(spells) do
		local sSpell = tostring(spell)
		self.groupSpells[sSpell] = catSpell
		if sSpell ~= catSpell and self.groupOptions[sSpell] then
			if not self.groupOptions[catSpell] then
				self.groupOptions[catSpell] = {}
				self.groupOptions[catSpell].title = customName
			end
			for _, spell2 in ipairs(self.groupOptions[sSpell]) do
				tinsert(self.groupOptions[catSpell], spell2)
			end
			self.groupOptions[sSpell] = nil
		end
	end
end

---Duplicate function just for private auras to do literally same thing as GroupSpells without ability to pass extra arg
function bossModPrototype:GroupSpellsPA(...)
	local spells = {...}
	local catSpell = tostring(tremove(spells, 1))
	if not self.groupSpells[catSpell] then
		self.groupSpells[catSpell] = {}
	end
	for _, spell in ipairs(spells) do
		local sSpell = tostring(spell)
		self.groupSpells[sSpell] = catSpell
		if sSpell ~= catSpell and self.groupOptions[sSpell] then
			if not self.groupOptions[catSpell] then
				self.groupOptions[catSpell] = {}
				self.groupOptions[catSpell].hasPrivate = true--This single line is basically why GroupSpellsPA had to duplicate GroupSpells
			end
			for _, spell2 in ipairs(self.groupOptions[sSpell]) do
				tinsert(self.groupOptions[catSpell], spell2)
			end
			self.groupOptions[sSpell] = nil
		end
	end
end

function bossModPrototype:GroupSpells(...)
	local spells = {...}
	local catSpell = tostring(tremove(spells, 1))
	if not self.groupSpells[catSpell] then
		self.groupSpells[catSpell] = {}
	end
	for _, spell in ipairs(spells) do
		local sSpell = tostring(spell)
		self.groupSpells[sSpell] = catSpell
		if sSpell ~= catSpell and self.groupOptions[sSpell] then
			if not self.groupOptions[catSpell] then
				self.groupOptions[catSpell] = {}
			end
			for _, spell2 in ipairs(self.groupOptions[sSpell]) do
				tinsert(self.groupOptions[catSpell], spell2)
			end
			self.groupOptions[sSpell] = nil
		end
	end
end

---@param name any
---@param cat string category type: ie "timer", "announce", "misc", "sound", etc
---@param optionSubType string? ie "gtfo", "adds", "achievement", "stage", etc
---@param waCustomName string? used to inject custom weak aura spellId key text
---@param hasPrivate boolean? used to mark option as private aura option so it displays PA icon in GUI
function bossModPrototype:SetOptionCategory(name, cat, optionSubType, waCustomName, hasPrivate)
	optionSubType = optionSubType or ""
	for _, options in pairs(self.optionCategories) do
		removeEntry(options, name)
	end
	if self.addon and self.groupSpells[name] and not (optionSubType == "gtfo" or optionSubType == "adds" or optionSubType == "addscount" or optionSubType == "addscustom" or optionSubType:find("stage") or cat == "icon" and DBM.Options.GroupOptionsExcludeIcon) then--or cat == "paura" and DBM.Options.GroupOptionsExcludePA
		local sSpell = self.groupSpells[name]
		if not self.groupOptions[sSpell] then
			self.groupOptions[sSpell] = {}
		end
		if waCustomName and not self.groupOptions[sSpell].title then
			self.groupOptions[sSpell].title = waCustomName
		end
		if hasPrivate and not self.groupOptions[sSpell].hasPrivate then
			self.groupOptions[sSpell].hasPrivate = true
		end
		tinsert(self.groupOptions[sSpell], name)
	else
		if not self.optionCategories[cat] then
			self.optionCategories[cat] = {}
		end
		tinsert(self.optionCategories[cat], name)
		tinsert(self.categorySort, cat)
	end
end
---Wipes the checkDuplicateObjects table used to track duplicate option registrations
---Called by DBM-Core after options have finished loading
function bossModPrototype:WipeDuplicateOptions()
	wipe(checkDuplicateObjects)
end
