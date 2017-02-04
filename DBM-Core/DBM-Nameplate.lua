--Known issues (because blizzards nameplate code is such utter shite)
--This probably leaks memory and/or cpu without any wiping of created icons/garbage collection
--It obviously won't work if nameplates aren't enabled. So it can be a clusterfuck in raids unless you run custom nameplate mod that can shrink/invisible player nameplates (without hiding them)

-- globals
DBM.Nameplate = {}
-- locals
local nameplateFrame = DBM.Nameplate
local units = {}
local unitspells = {}

--------------------
--  Create Frame  --
--------------------
local DBMNameplateFrame = CreateFrame("Frame", "DBMNameplate", UIParent)
DBMNameplateFrame:Hide()

----------------
--  On Event  --
----------------
DBMNameplateFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "NAME_PLATE_UNIT_ADDED" then
		local unit = select(1, ...)
		local frame = C_NamePlate.GetNamePlateForUnit(unit)
		nameplateFrame:UpdateUnit(frame, unit)
	elseif event == "NAME_PLATE_UNIT_REMOVED" then
		local unit = select(1, ...)
		local frame = C_NamePlate.GetNamePlateForUnit(unit)
		if frame.DBMTexture then
			frame.DBMTexture:Hide()
		end
		--nameplateFrame:UpdateUnit(frame, unit)
	elseif event == "NAME_PLATE_CREATED" then
		local frame = select(1, ...)
		if not frame then return end--Shouldn't be needed but it is
		local unit = frame.namePlateUnitToken
		if not unit then return end--Shoudln't happen either, but it does
		nameplateFrame:UpdateUnit(frame, unit)
	end
end)

-----------------
--  Functions  --
-----------------
--/run DBM.Nameplate:Show(UnitGUID("target"), 227723)--Mana tracking, easy to find in Dalaran
--/run DBM.Nameplate:Hide(nil, true)
--/run DBM.Nameplate:Hide(UnitGUID("target"))
function nameplateFrame:Show(unitGUID, spellId, texture)
	if DBM.Options.DontShowNameplateIcons then return end
	if UnitGUID("player") == unitGUID then return end--player has no nameplate
	if not DBMNameplateFrame:IsShown() then
		DBMNameplateFrame:Show()
		DBMNameplateFrame:RegisterEvent("NAME_PLATE_CREATED")
		DBMNameplateFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
		DBMNameplateFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
		DBM:Debug("DBM.Nameplate Enabling", 2)
	end
	--Support custom texture, or just pull it from spellid
	local currentTexture = texture or GetSpellTexture(spellId)
	units[unitGUID] = currentTexture
	unitspells[unitGUID] = GetSpellInfo(spellId)
	for _, frame in pairs(C_NamePlate.GetNamePlates()) do
		local foundUnit = frame.namePlateUnitToken
		local foundGUID = UnitGUID(foundUnit)
		if foundGUID == unitGUID then
			nameplateFrame:UpdateUnit(frame, foundUnit)
		end
	end
end

function nameplateFrame:Hide(GUID, force)
	GUID = GUID or UnitGUID("player")--If guid isn't passed (such as on a force) shove player GUID in there to prevent errors
	units[GUID] = nil
	unitspells[GUID] = nil
	for _, frame in pairs(C_NamePlate.GetNamePlates()) do
		local foundUnit = frame.namePlateUnitToken
		local foundGUID = UnitGUID(foundUnit)
		if frame.DBMTexture and (force or foundGUID == GUID) then
			frame.DBMTexture:Hide()
		end
	end
	if force or #units == 0 then
		table.wipe(units)
		table.wipe(unitspells)
		DBMNameplateFrame:UnregisterAllEvents()
		DBMNameplateFrame:Hide()
		DBM:Debug("DBM.Nameplate Disabling", 2)
	end
end

function nameplateFrame:IsShown()
	return DBMNameplateFrame and DBMNameplateFrame:IsShown()
end

function nameplateFrame:CreateTexture(frame, unit)
	local dbmtexture = frame:CreateTexture()
	local GUID = UnitGUID(unit)
	dbmtexture:SetTexture(units[GUID])
	dbmtexture:SetPoint("BOTTOM", frame, "TOP")
	dbmtexture:SetHeight(48)
	dbmtexture:SetWidth(48)
	dbmtexture:SetVertexColor(1, 1, 1)
	dbmtexture:SetParent(UIParent)
	dbmtexture:Hide()
	frame.DBMTexture = dbmtexture
	DBM:Debug("DBM.Nameplate making textures great again", 2)
end

function nameplateFrame:UpdateAll()
	for _, frame in pairs(C_NamePlate.GetNamePlates()) do
		local unit = frame.namePlateUnitToken
		nameplateFrame:UpdateUnit(frame, unit)
	end
end

function nameplateFrame:UpdateUnit(frame, unit)
	local GUID = UnitGUID(unit)
	if units[GUID] then
		DBM:Debug("DBM.Nameplate updating for unit: "..unit, 3)
		if not frame.DBMTexture then
			nameplateFrame:CreateTexture(frame, unit)
		end
		frame.DBMTexture:SetTexture(units[GUID])--Always force reset it, more cpu but avoids invalid texture apparently
		if UnitDebuff(unit, unitspells[GUID]) or UnitBuff(unit, unitspells[GUID]) then--Debuff/Buff still present
			frame.DBMTexture:Show()
		else
			frame.DBMTexture:Hide()
			nameplateFrame:Hide(unit)
		end
	end	
end
