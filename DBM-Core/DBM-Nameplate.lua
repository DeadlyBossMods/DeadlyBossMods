--VERY WIP and probably not functional yet.
--The idea here though is a nameplate function that can show large visuals above players with certain buffs/debuffs
--With support for unique textures/spell tracking per unit so it's not limited to one debuff/texture at a time.

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
--DBMNameplateFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",})
--DBMNameplateFrame:SetAllPoints(UIParent)
--DBMNameplateFrame:SetFrameStrata("BACKGROUND")

function nameplateFrame:Show(unit, spellId, texture)
	if not DBMNameplateFrame:IsShown() then
		DBMNameplateFrame:Show()
		DBMNameplateFrame:RegisterEvent("NAME_PLATE_CREATED")
		DBMNameplateFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
		DBMNameplateFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
		DBM:Debug("DBM.Nameplate Enabling", 2)
	end
	--Support custom texture, or just pull it from spellid
	units[unit] = texture or GetSpellTexture(spellId)
	unitspells[unit] = GetSpellInfo(spellId)
	for _, frame in pairs(C_NamePlate.GetNamePlates()) do
		local foundUnit = frame.namePlateUnitToken
		if UnitIsUnit(foundUnit, Unit) then
			nameplateFrame:UpdateUnit(frame, unit)
		end
	end
end

function nameplateFrame:Hide(unit, force)
	units[unit] = nil
	unitspells[unit] = nil
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
	dbmtexture:SetTexture(units[unit])
	dbmtexture:SetPoint("BOTTOM", frame, "TOP")
	dbmtexture:SetHeight(64)
	dbmtexture:SetWidth(64)
	dbmtexture:SetVertexColor(1, 0, 0)
	dbmtexture:SetParent(UIParent)
	dbmtexture:Hide()
	frame.DBM.texture = dbmtexture
	DBM:Debug("DBM.Nameplate making textures great again", 2)
end

function nameplateFrame:UpdateAll()
	for _, frame in pairs(C_NamePlate.GetNamePlates()) do
		local unit = frame.namePlateUnitToken
		nameplateFrame:UpdateUnit(frame, unit)
	end
end

function nameplateFrame:UpdateUnit(frame, unit)
	if units[unit] then
		DBM:Debug("DBM.Nameplate updating for unit: "..unit, 3)
		if not frame.DBM.texture then
			nameplateFrame:CreateTexture(frame, unit)
		end
		if UnitDebuff(unit, unitspells[unit]) or UnitBuff(unit, unitspells[unit]) then--Debuff/Buff still present
			frame.DBM.texture:Show()
		else
			frame.DBM.texture:Hide()
			nameplateFrame:Hide(unit)
		end
	end	
end

function NAME_PLATE_CREATED(frame, ...)
	local unit = frame.namePlateUnitToken
	nameplateFrame:UpdateUnit(frame, unit)
end

function NAME_PLATE_UNIT_ADDED(unit)
	local frame = C_NamePlate.GetNamePlateForUnit(unit)
	nameplateFrame:UpdateUnit(frame, unit)
end

function NAME_PLATE_UNIT_REMOVED(unit)
	local frame = C_NamePlate.GetNamePlateForUnit(unit)
	nameplateFrame:UpdateUnit(frame, unit)
end
