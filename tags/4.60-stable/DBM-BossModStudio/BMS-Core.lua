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
--    * to Share  to copy, distribute, display, and perform the work
--    * to Remix  to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.



DBM_BMS = {
--[[
--CurrentBossSetup = {
	BossName = "",
	BossIDs = {},
	CombatFromYell = false,
	BossPullYell = {},
	CombatAutoDetect = true,
	Enrage = false,
	EnrageBar = false,
	EnrageAnnounce = false,
	EnrageTime = 0,
	trigger = {
		...
	}

	-- GUI Parts (not saved on logout)
	gui_panel   - the MainPanel
	gui_trigger - the TriggerPanel
 } --]]
}

---------------
--  Globals  --
---------------
DBM.CustomMods = {}


--------------
--  Locals  --
--------------
--local modList = setmetatable({}, {__mode = "kv"})
local modList = {}


----------------------------
--  Custom Mod Prototype  --
----------------------------
do
	local function onCombatStart(self, delay)
		if self.customMod.enrage then
			mod.enrage:Start(self.customMod.enrage)
		end
	end
	
	local function onCombatEnd(self, wipe)
	end
	
	

	function DBM:LoadCustomMod(customMod)
		local mod = DBM:NewMod(customMod.BossName, "DBM-BossModStudio")
		mod.customMod = customMod
		mod.isCustomMod = true
		mod:SetRevision(customMod.revision)
		mod.timer = mod:NewTimer(10, "%s", nil, nil, false)
		mod.warning1 = mod:NewAnnounce("%s", 1, nil, nil, false)
		mod.warning2 = mod:NewAnnounce("%s", 2, nil, nil, false)
		mod.warning3 = mod:NewAnnounce("%s", 3, nil, nil, false)
		mod.warning4 = mod:NewAnnounce("%s", 4, nil, nil, false)
		mod.specWarning = mod:NewSpecialWarning("%s", nil, false)
		mod.enrage = mod:NewBerserkTimer(600)
		DBM:GetModLocalization(customMod.BossName):SetGeneralLocalization({
			name = customMod.BossName
		})
		mod.OnCombatStart = onCombatStart
		mod.OnCombatEnd = onCombatEnd
		DBM:AddMsg("Loaded mod "..tostring(customMod.BossName))
		return mod
	end
	
	function DBM:UnloadCustomMod(mod)
		mod:Unschedule()
		mod.timer:Cancel()
		mod:UnregisterAllEvents()
		DBM:ForceUpdate()
		for i, v in ipairs(DBM.Mods) do
			if v == mod then
				table.remove(DBM.Mods, i)
			end
		end
		if DBM_GUI then
			DBM_GUI:UpdateModList()
		end
		DBM:AddMsg("Unloaded mod "..tostring(mod))
	end
end







