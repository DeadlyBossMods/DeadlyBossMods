--Known issues (because blizzards nameplate code is such utter shite)
--*It obviously won't work if nameplates aren't enabled. So it can be a clusterfuck in raids unless you run custom nameplate mod that can shrink/invisible player nameplates (without hiding them)
--DBMs internal code needs to handle multiple textures, which will require a bit more work. Will probably put off for now, but at very least when using KUI multiple will be supported via callback

-- globals
DBM.Nameplate = {}
-- locals
local nameplateFrame = DBM.Nameplate
local units = {}
local num_units = 0
local playerName, playerGUID = UnitName("player"), UnitGUID("player")--Cache these, they never change
local GetNamePlateForUnit = C_NamePlate.GetNamePlateForUnit

--------------------
--  Create Frame  --
--------------------
local DBMNameplateFrame = CreateFrame("Frame", "DBMNameplate", UIParent)
DBMNameplateFrame:Hide()

--------------------------
-- Aura frame functions --
--------------------------
local CreateAuraFrame
do
    local function AuraFrame_CreateIcon(frame)
        local icon = frame.parent:CreateTexture()
        icon:SetParent(UIParent)
        icon:SetSize(48,48)
        icon:Hide()

        tinsert(frame.icons,icon)

        return icon
    end
    local function AuraFrame_GetIcon(frame,texture)
        -- find unused icon or create new icon
        if not frame.icons or #frame.icons == 0 then
            return frame:CreateIcon()
        else
            if frame.texture_index[texture] then
                -- return icon already used for this texture
                return frame.texture_index[texture]
            else
                -- find unused icon:
                for i,icon in ipairs(frame.icons) do
                    if not icon:IsShown() then
                        return icon
                    end
                end

                -- create new icon
                return frame:CreateIcon()
            end
        end
    end
    local function AuraFrame_ArrangeIcons(frame)
        if not frame.icons or #frame.icons == 0 then return end

        local prev,total_width,first_icon
        for i,icon in ipairs(frame.icons) do
            if icon:IsShown() then
                icon:ClearAllPoints()

                if not prev then
                    total_width = 0
                    first_icon = icon
                    icon:SetPoint('BOTTOM',frame.parent,'TOP')
                else
                    total_width = total_width + icon:GetWidth()
                    icon:SetPoint('LEFT',prev,'RIGHT')
                end

                prev = icon
            end
        end

        if first_icon and total_width and total_width > 0 then
            -- shift first icon back to centre visible row
            first_icon:SetPoint('BOTTOM',frame.parent,'TOP',
                -floor(total_width/2),0)
        end
    end
    local function AuraFrame_AddAura(frame,texture)
        if not frame.icons then
            frame.icons = {}
        end
        if not frame.texture_index then
            frame.texture_index = {}
        end

        local icon = frame:GetIcon(texture)
        icon:SetTexture(texture)
        icon:Show()

        frame.texture_index[texture] = icon

        frame:ArrangeIcons()
    end
    local function AuraFrame_RemoveAura(frame,texture)
        if not texture then return end
        if not frame.texture_index then return end
        if not frame.texture_index[texture] then return end

        frame.texture_index[texture]:Hide()
        frame.texture_index[texture] = nil

        frame:ArrangeIcons()
    end
    local function AuraFrame_RemoveAll(frame)
        if not frame.icons or not frame.texture_index then return end

        for i,icon in ipairs(frame.icons) do
            icon:Hide()
        end

        if type(frame.texture_index) == 'table' then
            wipe(frame.texture_index)
        end
    end

    local auraframe_proto = {
        CreateIcon = AuraFrame_CreateIcon,
        GetIcon = AuraFrame_GetIcon,
        ArrangeIcons = AuraFrame_ArrangeIcons,

        AddAura = AuraFrame_AddAura,
        RemoveAura = AuraFrame_RemoveAura,
        RemoveAll = AuraFrame_RemoveAll,
    }
    auraframe_proto.__index = auraframe_proto

    function CreateAuraFrame(frame)
        if not frame then return end

        local new_frame = {}
        setmetatable(new_frame, auraframe_proto)
        new_frame.parent = frame

        return new_frame
    end
end
-------------------------
-- Nameplate functions --
-------------------------
local function Nameplate_OnHide(frame)
    if not frame then return end
    frame.DBMAuraFrame:RemoveAll()
end
local function HookNameplate(frame)
    if not frame then return end
    frame.DBMAuraFrame = CreateAuraFrame(frame)
    frame:HookScript('OnHide',Nameplate_OnHide)
end

local function Nameplate_UnitAdded(frame,unit)
    if not frame or not unit then return end

    if not frame.DBMAuraFrame then
        -- hook as required;
        HookNameplate(frame)
    end

    local unitName = DBM:GetUnitFullName(unit)
    local guid = UnitGUID(unit)
    local unit_tbl

    if guid and units[guid] then
        unit_tbl = units[guid]
    elseif unitName and units[unitName] then
        unit_tbl = units[unitName]
    end

    if unit_tbl and #unit_tbl > 0 then
        for k,v in ipairs(unit_tbl) do
            frame.DBMAuraFrame:AddAura(v)
        end
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
--/run DBM.Nameplate:Show(true, UnitGUID("target"), 227723)--Mana tracking, easy to find in Dalaran
--/run DBM.Nameplate:Show(true, UnitGUID("target"), 186406)--Sign of the Critter
--/run DBM.Nameplate:Show(false, GetUnitName("target", true), 227723)--Mana tracking, easy to find in Dalaran
--/run DBM.Nameplate:Hide(true, nil, nil, nil, true)
--/run DBM.Nameplate:Hide(true, UnitGUID("target"), 227723)
--/run DBM.Nameplate:Hide(false, GetUnitName("target", true), 227723)

--Add more nameplate mods as they gain support
function nameplateFrame:SupportedNPMod()
    if KuiNameplates then return true end
    return false
end

--isGUID: guid or name (bool)
function nameplateFrame:Show(isGUID, unit, spellId, texture, duration, desaturate)
    -- nameplate icons are disabled;
    if DBM.Options.DontShowNameplateIcons then return end

    -- ignore player nameplate;
    if playerGUID == unit or playerName == unit then return end

    local currentTexture = texture or GetSpellTexture(spellId)

    -- Supported by nameplate mod, passing to their handler;
    if self:SupportedNPMod() then
        DBM:FireEvent("BossMod_ShowNameplateAura", isGUID, unit, currentTexture, duration, desaturate)
        DBM:Debug("DBM.Nameplate Found supported NP mod, only sending Show callbacks", 2)
        return
    end

    --Not running supported NP Mod, internal handling
    if not self:IsShown() then
        DBMNameplateFrame:Show()
        DBMNameplateFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
        DBM:Debug("DBM.Nameplate Enabling", 2)
    end

    if not units[unit] then
        units[unit] = {}
        num_units = num_units + 1
    end

    tinsert(units[unit],currentTexture)

    -- find frame for this unit;
    if not isGUID then
        local frame = GetNamePlateForUnit(unit)
        if frame then
            local foundUnit = frame.namePlateUnitToken
            if foundUnit then
                Nameplate_UnitAdded(frame, foundUnit)
            end
        end
    else
        --GUID, less efficient because it must scan all plates to find
        --but supports npcs/enemies
        for _, frame in pairs(C_NamePlate.GetNamePlates()) do
            local foundUnit = frame.namePlateUnitToken
            if foundUnit and UnitGUID(foundUnit) == unit then
                Nameplate_UnitAdded(frame, foundUnit)
                break
            end
        end
    end
end

function nameplateFrame:Hide(isGUID, unit, spellId, texture, force)
    local currentTexture = texture or GetSpellTexture(spellId)

    if self:SupportedNPMod() then
        DBM:Debug("DBM.Nameplate Found supported NP mod, only sending Hide callbacks", 2)

        if force then
            DBM:FireEvent("BossMod_DisableFriendlyNameplates")
        elseif unit then
            DBM:FireEvent("BossMod_HideNameplateAura", isGUID, unit, currentTexture)
        end

        return
    end

    --Not running supported NP Mod, internal handling
    if unit and units[unit] then
        for i,this_texture in ipairs(units[unit]) do
            if this_texture == currentTexture then
                tremove(units[unit],i)
                break
            end
        end

        if #units[unit] == 0 then
            units[unit] = nil
            num_units = num_units - 1
        end
    end

    -- find frame for this unit
    -- (or hide all visible textures if force ~= nil)
    if not isGUID and not force then--Only need to find one unit
        local frame = GetNamePlateForUnit(unit)
        if frame and frame.DBMAuraFrame then
            frame.DBMAuraFrame:RemoveAura(currentTexture)
        end
    else
        --We either passed force, or GUID,
        --either way requires scanning all nameplates
        for _, frame in pairs(C_NamePlate.GetNamePlates()) do
            if frame.DBMAuraFrame then
                if force then
                    frame.DBMAuraFrame:RemoveAll()
                elseif isGUID then
                    local foundUnit = frame.namePlateUnitToken
                    if foundUnit and UnitGUID(foundUnit) == unit then
                        frame.DBMAuraFrame:RemoveAura(currentTexture)
                    end
                end
            end
        end
    end

    -- disable nameplate hooking;
    if force or num_units <= 0 then
        table.wipe(units)
        num_units = 0

        DBMNameplateFrame:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
        DBMNameplateFrame:Hide()
        DBM:Debug("DBM.Nameplate Disabling", 2)
    end
end

function nameplateFrame:IsShown()
    return DBMNameplateFrame and DBMNameplateFrame:IsShown()
end