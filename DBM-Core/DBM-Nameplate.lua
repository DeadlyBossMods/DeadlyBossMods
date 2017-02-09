--Known issues (because blizzards nameplate code is such utter shite)
--*It obviously won't work if nameplates aren't enabled. So it can be a clusterfuck in raids unless you run custom nameplate mod that can shrink/invisible player nameplates (without hiding them)

-- globals
DBM.Nameplate = {}
-- locals
local nameplateFrame = DBM.Nameplate
local units = {}

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

    local guid = UnitGUID(unit)
    if guid and units[guid] then
        frame.DBMTexture:SetTexture(units[guid])
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
        local f = C_NamePlate.GetNamePlateForUnit(unit)
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

function nameplateFrame:Show(unitGUID, spellId, texture, duration)
    -- nameplate icons are disabled;
    if DBM.Options.DontShowNameplateIcons then return end

    -- ignore player nameplate;
    if UnitGUID("player") == unitGUID then return end

    local currentTexture = texture or GetSpellTexture(spellId)

    -- Supported by nameplate mod, passing to their handler;
    if self:SupportedNPMod() then
        DBM:FireEvent("BossMod_ShowNameplateAura", unitGUID, currentTexture, duration)
        DBM:Debug("DBM.Nameplate Found supported NP mod, only sending Show callbacks", 2)

        return
    end

    --Not running supported NP Mod, internal handling
    if not self:IsShown() then
        DBMNameplateFrame:Show()
        DBMNameplateFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
        DBM:Debug("DBM.Nameplate Enabling", 3)
    end

    units[unitGUID] = currentTexture

    -- find frame for this GUID;
    for _, frame in pairs(C_NamePlate.GetNamePlates()) do
        local foundUnit = frame.namePlateUnitToken
        if foundUnit then
            local foundGUID = UnitGUID(foundUnit)
            if foundGUID == unitGUID then
                Nameplate_UnitAdded(frame, foundUnit)
                break
            end
        end
    end
end

function nameplateFrame:Hide(GUID, force)
    if self:SupportedNPMod() then
        if GUID then
            DBM:FireEvent("BossMod_HideNameplateAura", GUID)
        end

        DBM:Debug("DBM.Nameplate Found supported NP mod, only sending Hide callbacks", 2)

        if force then
            DBM:FireEvent("BossMod_DisableFriendlyNameplates")
        end

        return
    end

    --Not running supported NP Mod, internal handling
    if GUID then
        units[GUID] = nil
    end

    -- find frame for this GUID
    -- (or hide all visible textures if force ~= nil)
    for _, frame in pairs(C_NamePlate.GetNamePlates()) do
        if frame.DBMTexture and force then
            frame.DBMTexture:Hide()
        elseif GUID then
            local foundUnit = frame.namePlateUnitToken
            if foundUnit then
                local foundGUID = UnitGUID(foundUnit)
                if frame.DBMTexture and foundGUID == GUID then
                    frame.DBMTexture:Hide()
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