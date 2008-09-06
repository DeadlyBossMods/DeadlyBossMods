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

L.TabCategory_BossModStudio = "BossMod Studio"
L.AreaHead_CreateBossMod = "Main Informations of this new BossMod"
L.BossName = "Name of the BossMod - like 'Hogger'"
L.BossID = "Creature ID"
L.BossLookup = "Take ID from Target"

L.AreaHead_Pull = "Pull / Combat Detection"
L.CombatFromYell = "Combat starts with a Yell"
L.CombatAutoDetect = "Automatic Combat Detection"

L.Min = "Min"
L.Sec = "Sec"

CurrentBossSetup = {
	BossName = "",
	CombatFromYell = false,
	CombatAutoDetect = true,

}

BMS_Panel = DBM_GUI:CreateNewPanel(L.TabCategory_BossModStudio, "option")

do
	-------------------------------------------------
	--         Create a new BossMod                --
	-------------------------------------------------
	local BMS_Create = BMS_Panel:CreateArea(L.AreaHead_CreateBossMod, nil, 130, true)

	local BossName = BMS_Create:CreateEditBox(L.BossName, "", 230)
	BossName:SetPoint('TOPLEFT', 40, -25)
	
	local BossID = BMS_Create:CreateEditBox(L.BossID, "0", 75)
	BossID:SetPoint('TOPLEFT', BossName, "BOTTOMLEFT", 0, -20)

	local BossLookup = BMS_Create:CreateButton(L.BossLookup, 160, nil, function()
		local guid = UnitGUID("target")
		local cId = tonumber(guid:sub(9, 12), 16)
		CurrentBossSetup.BossName = cId
		BossID:SetText(cId)
	end);
	BossLookup:SetPoint('TOPLEFT', BossID, "TOPRIGHT", 5, 0)



	local BMS_Pull = BMS_Panel:CreateArea(L.AreaHead_Pull, nil, 130, true)
	
	local CombatFromYell = BMS_Pull:CreateCheckButton(L.CombatFromYell, true, nil, CurrentBossSetup.CombatFromYell)
	
	local CombatAutoDetect = BMS_Pull:CreateCheckButton(L.CombatAutoDetect, true, nil, CurrentBossSetup.CombatAutoDetect)

	local EnrageMin = BMS_Pull:CreateEditBox(L.Min, "", 30)
	EnrageMin:SetPoint('TOPLEFT', CombatAutoDetect, "BOTTOMLEFT", 15, -20)

	local EnrageSec = BMS_Pull:CreateEditBox(L.Sec, "", 30)
	EnrageSec:SetPoint('TOPLEFT', EnrageMin, "TOPRIGHT", 20, 0)

end








