-- *********************************************************
-- **               Deadly Boss Mods - Core               **
-- **            http://www.deadlybossmods.com            **
-- *********************************************************
--
-- This addon is written and copyrighted by:
--    * Paul Emmerich (Tandanu @ EU-Aegwynn) (DBM-Core)
--    * Martin Verges (Nitram @ EU-Azshara) (DBM-GUI)
-- 
-- The localizations are written by:
--    * enGB/enUS: Tandanu
--    * deDE: Tandanu/Nitram
--    * (add your names here!)
--
-- Special thanks to:
--    * Arta (DBM-Party)
-- 
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
		local mod = DBM:NewMod(customMod.name, "DBM_CustomMods")
		mod.customMod = customMod
		mod.isCustomMod = true
		mod:SetRevision(customMod.revision)
		mod.timer = mod:NewTimer(10, "%s", nil, nil, false)
		mod.warning1 = mod:NewAnnounce("%s", 1, nil, nil, false)
		mod.warning2 = mod:NewAnnounce("%s", 2, nil, nil, false)
		mod.warning3 = mod:NewAnnounce("%s", 3, nil, nil, false)
		mod.warning4 = mod:NewAnnounce("%s", 4, nil, nil, false)
		mod.specWarning = mod:NewSpecialWarning("%s", nil, false)
		mod.enrage = mod:NewEnrageTimer(600)
		DBM:GetModLocalization(id):SetGeneralLocalization({
			name = name
		})
		mod.OnCombatStart = onCombatStart
		mod.OnCombatEnd = onCombatEnd
	end
end



