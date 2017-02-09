--Known issues (because blizzards nameplate code is such utter shite)
--*It obviously won't work if nameplates aren't enabled. So it can be a clusterfuck in raids unless you run custom nameplate mod that can shrink/invisible player nameplates (without hiding them)

-- globals
DBM.Nameplate = {}
-- locals
local nameplateFrame = DBM.Nameplate
local units = {}
local playerName, playerGUID = UnitName("player"), UnitGUID("player")--Cache these, they never change
local GetNamePlateForUnit = C_NamePlate.GetNamePlateForUnit

--------------------
--  Create Frame  --
--------------------
local DBMNameplateFrame = CreateFrame("Frame", "DBMNameplate", UIParent)
DBMNameplateFrame:Hide()

-------------------------
-- Nameplate functions --
-------------------------
local function Nameplate_OnHide(frame)
    if not frame then return end
    if not frame.DBMTexture then return end

    frame.DBMTexture:Hide()
end
local function HookNameplate(frame)
    if not frame then return end
    if frame.DBMTexture then return end

    local tex = frame:CreateTexture()
    tex:SetPoint('BOTTOM',frame,'TOP')
    tex:SetSize(48,48)
    tex:Hide()

    -- correct scale & ignore plate alpha;
    tex:SetParent(UIParent)

    frame.DBMTexture = tex

    frame:HookScript('OnHide',Nameplate_OnHide)
end

local function Nameplate_UnitAdded(frame,unit)
    if not frame or not unit then return end

    if not frame.DBMTexture then
        -- hook as required;
        HookNameplate(frame)
    end
	
	local unitName = DBM:GetUnitFullName(unit)
    local guid = UnitGUID(unit)
    if guid and units[guid] then
        frame.DBMTexture:SetTexture(units[guid])
        frame.DBMTexture:Show()
    elseif unitName and units[unitName] then
        frame.DBMTexture:SetTexture(units[unitName])
        frame.DBMTexture:Show()
    end
end
----------------
--  On Event  --
----------------
DBMNameplateFrame:SetScript("OnEvent", function(self, event, ...)
    if event == 'NAME_PLATE_UNIT_ADDED' then
        local unit = ...
        if not unit then return end
        local f = GetNamePlateForUnit(unit)
        if not f then return end

        Nameplate_UnitAdded(f,unit)
    end
end)

-----------------
--  Functions  --
-----------------
--/run DBM.Nameplate:Show(UnitGUID("target"), 227723)--Mana tracking, easy to find in Dalaran
--/run DBM.Nameplate:Hide(nil, true)
--/run DBM.Nameplate:Hide(UnitGUID("target"))

--Add more nameplate mods as they gain support
function nameplateFrame:SupportedNPMod()
    if KuiNameplates then return true end
    return false
end

--unitType: guid or name
function nameplateFrame:Show(unitType, unit, spellId, texture, duration, desaturate)
    -- nameplate icons are disabled;
    if DBM.Options.DontShowNameplateIcons then return end

    -- ignore player nameplate;
    if playerGUID == unit or playerName == unit then return end

    local currentTexture = texture or GetSpellTexture(spellId)

    -- Supported by nameplate mod, passing to their handler;
    if self:SupportedNPMod() then
        DBM:FireEvent("BossMod_ShowNameplateAura", unitType, unit, currentTexture, duration, desaturate)
        DBM:Debug("DBM.Nameplate Found supported NP mod, only sending Show callbacks", 2)
        return
    end

    --Not running supported NP Mod, internal handling
    if not self:IsShown() then
        DBMNameplateFrame:Show()
        DBMNameplateFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
        DBM:Debug("DBM.Nameplate Enabling", 3)
    end

    units[unit] = currentTexture

    -- find frame for this unit;
    if unitType == "name" then
    	local frame = GetNamePlateForUnit(unit)
    	if frame then
    		local foundUnit = frame.namePlateUnitToken
    		if foundUnit then
    			Nameplate_UnitAdded(frame, foundUnit)
    		end
    	end
    else--GUID, less efficient because it must scan all plates to find, but supports npcs/enemies
    	for _, frame in pairs(C_NamePlate.GetNamePlates()) do
        	local foundUnit = frame.namePlateUnitToken
        	if foundUnit then
            	local foundGUID = UnitGUID(foundUnit)
            	if foundGUID == unit then
                	Nameplate_UnitAdded(frame, foundUnit)
                	break
            	end
        	end
    	end
    end
end

function nameplateFrame:Hide(unitType, unit, force)
    if self:SupportedNPMod() then
        if unit then
            DBM:FireEvent("BossMod_HideNameplateAura", unitType, unit)
        end

        DBM:Debug("DBM.Nameplate Found supported NP mod, only sending Hide callbacks", 2)

        if force then
            DBM:FireEvent("BossMod_DisableFriendlyNameplates")
        end

        return
    end

    --Not running supported NP Mod, internal handling
    if unit then
        units[unit] = nil
    end

    -- find frame for this unit
    -- (or hide all visible textures if force ~= nil)
    if unitType == "name" and not force then--Only need to find one unit
    	local frame = GetNamePlateForUnit(unit)
    	if frame and frame.DBMTexture then
            frame.DBMTexture:Hide()
    	end
    else--We either passed force, or GUID, either way requires scanning all nameplates
    	for _, frame in pairs(C_NamePlate.GetNamePlates()) do
        	if frame.DBMTexture and force then
            	frame.DBMTexture:Hide()
        	elseif unitType == "guid" then
            	local foundUnit = frame.namePlateUnitToken
            	if foundUnit then
                	if frame.DBMTexture then
                    	frame.DBMTexture:Hide()
                	end
            	end
        	end
    	end
    end

    -- disable nameplate hooking;
    if force or #units == 0 then
        table.wipe(units)
        DBMNameplateFrame:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
        DBMNameplateFrame:Hide()
        DBM:Debug("DBM.Nameplate Disabling", 3)
    end
end

function nameplateFrame:IsShown()
    return DBMNameplateFrame and DBMNameplateFrame:IsShown()
end