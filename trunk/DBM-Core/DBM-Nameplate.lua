--Known issues (because blizzards nameplate code is such utter shite)
--*This probably leaks memory and/or cpu without any wiping of created icons/garbage collection
--*It obviously won't work if nameplates aren't enabled. So it can be a clusterfuck in raids unless you run custom nameplate mod that can shrink/invisible player nameplates (without hiding them)
--*Users Report Hiding on combat end breaks if nameplatemods like tidyplates/kui disable nameplates before dbm can do it's cleanup, resulting in textures getting stuck in place.

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
	elseif event == "CVAR_UPDATE" then
		local name = ...
		if name == "UNIT_NAMEPLATES_SHOW_ENEMIES" or name == "UNIT_NAMEPLATES_SHOW_FRIENDS" or name == "UNIT_NAMEPLATES" then
			nameplateFrame:UpdateAll()--Update all nameplates on show/hide to see if it resolves getting stuck graphics
		end
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
	if DBM.Options.DontShowNameplateIcons then return end
	if UnitGUID("player") == unitGUID then return end--player has no nameplate
	local currentTexture = texture or GetSpellTexture(spellId)
	if self:SupportedNPMod() then--Supported by nameplate mod, passing to their handler
		DBM:FireEvent("BossMod_ShowNameplateAura", unitGUID, currentTexture, duration)
		DBM:Debug("DBM.Nameplate Found supported NP mod, only sending Show callbacks", 2)
		return
	end
	--Not running supported NP Mod, internal handling
	if not self:IsShown() then
		DBMNameplateFrame:Show()
		DBMNameplateFrame:RegisterEvent("NAME_PLATE_CREATED")
		DBMNameplateFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
		DBMNameplateFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
		DBMNameplateFrame:RegisterEvent("CVAR_UPDATE")
		DBM:Debug("DBM.Nameplate Enabling", 2)
	end
	--Support custom texture, or just pull it from spellid
	units[unitGUID] = currentTexture
	unitspells[unitGUID] = GetSpellInfo(spellId)
	for _, frame in pairs(C_NamePlate.GetNamePlates()) do
		local foundUnit = frame.namePlateUnitToken
		if foundUnit then
			local foundGUID = UnitGUID(foundUnit)
			if foundGUID == unitGUID then
				nameplateFrame:UpdateUnit(frame, foundUnit)
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
	GUID = GUID or UnitGUID("player")--If guid isn't passed (such as on a force) shove player GUID in there to prevent errors
	units[GUID] = nil
	unitspells[GUID] = nil
	for _, frame in pairs(C_NamePlate.GetNamePlates()) do
		local foundUnit = frame.namePlateUnitToken
		if foundUnit then
			local foundGUID = UnitGUID(foundUnit)
			if frame.DBMTexture and (force or foundGUID == GUID) then
				frame.DBMTexture:Hide()
			end
		end
	end
	if force or #units == 0 then
		table.wipe(units)
		table.wipe(unitspells)
		DBMNameplateFrame:UnregisterEvent("NAME_PLATE_CREATED")
		DBMNameplateFrame:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
		DBMNameplateFrame:UnregisterEvent("NAME_PLATE_UNIT_REMOVED")
		DBMNameplateFrame:UnregisterEvent("CVAR_UPDATE")
		DBMNameplateFrame:Hide()
		DBM:Debug("DBM.Nameplate Disabling", 2)
	end
end

function nameplateFrame:IsShown()
	return DBMNameplateFrame and DBMNameplateFrame:IsShown()
end

-----------------------------------
--  Internal Handling Functions  --
-----------------------------------

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
end

function nameplateFrame:UpdateAll()
	if self:SupportedNPMod() then return end--This shouldn't happen, but in case someone calls this directly
	if not self:IsShown() then
		DBMNameplateFrame:Show()
		DBMNameplateFrame:RegisterEvent("NAME_PLATE_CREATED")
		DBMNameplateFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
		DBMNameplateFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
		DBMNameplateFrame:RegisterEvent("CVAR_UPDATE")
		DBM:Debug("DBM.Nameplate Enabling", 2)
	end
	if #units == 0 then--This is a cleanup request, redo hide
		self:Hide(nil, true)
	else--User might have togglednameplates mid fight, so lets get their textures working
		for _, frame in pairs(C_NamePlate.GetNamePlates()) do
			local unit = frame.namePlateUnitToken
			if unit then
				self:UpdateUnit(frame, unit)
			end
		end
	end
end

function nameplateFrame:UpdateUnit(frame, unit)
	local GUID = UnitGUID(unit)
	if units[GUID] then
		DBM:Debug("DBM.Nameplate updating for unit: "..unit, 3)
		if not frame.DBMTexture then
			self:CreateTexture(frame, unit)
		end
		frame.DBMTexture:SetTexture(units[GUID])--Always force reset it, more cpu but avoids invalid texture apparently
		if UnitDebuff(unit, unitspells[GUID]) or UnitBuff(unit, unitspells[GUID]) then--Debuff/Buff still present
			frame.DBMTexture:Show()
		else
			frame.DBMTexture:Hide()
			self:Hide(GUID)
		end
	else
		--Fix any left over textures in an UpdateAll call
		if frame.DBMTexture then
			frame.DBMTexture:Hide()
		end
	end	
end
