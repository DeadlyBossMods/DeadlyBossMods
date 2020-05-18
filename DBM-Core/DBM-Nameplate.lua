---------------
--  Globals  --
---------------
DBM.Nameplate = {}

--------------
--  Locals  --
--------------
local units, num_units = {}, 0
local GetSpellTexture, UnitGUID, GetNamePlateForUnit, GetNamePlates = GetSpellTexture, UnitGUID, C_NamePlate.GetNamePlateForUnit, C_NamePlate.GetNamePlates
local playerName, playerGUID = UnitName("player"), UnitGUID("player")
local tonumber, pairs, ipairs, tinsert, tremove, twipe = tonumber, pairs, ipairs, table.insert, table.remove, table.wipe

--------------------
--  Create Frame  --
--------------------
local DBMNameplateFrame = CreateFrame("Frame", "DBMNameplate", UIParent)
DBMNameplateFrame:SetFrameStrata("BACKGROUND")
DBMNameplateFrame:Hide()

--------------------------
-- Aura frame functions --
--------------------------
local CreateAuraFrame
do
	local AuraFramePrototype = {}

	function AuraFramePrototype:CreateIcon(frame)
		local icon = DBMNameplateFrame:CreateTexture(nil, "BACKGROUND")
		icon:SetSize(40, 40)
		icon:Hide()
		tinsert(frame.icons, icon)
		return icon
	end

	function AuraFramePrototype:GetIcon(frame, texture)
		if not frame.icons or #frame.icons == 0 then
			return frame:CreateIcon()
		end
		if frame.texture_index[texture] then
			return frame.texture_index[texture]
		end
		for _, icon in ipairs(frame.icons) do
			if not icon:IsShown() then
				return icon
			end
		end
		return frame:CreateIcon()
	end

	function AuraFramePrototype:ArrangeIcons(frame)
		if not frame.icons or #frame.icons == 0 then
			return
		end
		local prev, total_width, first_icon
		for _, icon in ipairs(frame.icons) do
			if icon:IsShown() then
				icon:ClearAllPoints()
				if not prev then
					total_width = 0
					first_icon = icon
					icon:SetPoint("BOTTOM", frame.parent, "TOP")
				else
					total_width = total_width + icon:GetWidth()
					icon:SetPoint("LEFT", prev, "RIGHT")
				end
				prev = icon
			end
		end
		if first_icon and total_width and total_width > 0 then
			first_icon:SetPoint("BOTTOM", frame.parent, "TOP", -math.floor(total_width / 2), 0)
		end
	end

	function AuraFramePrototype:CreateLine(frame)
		local line = UIParent:CreateLine(nil, "OVERLAY")
		line.GetPoint = function()
			return
		end
		line:SetThickness(4)
		line:Hide()
		frame.line = line
		return line
	end

	function AuraFramePrototype:ShowLine(frame, parent_icon, color)
		local line = frame.line or frame:CreateLine()
		line.parent_icon = parent_icon
		line:SetColorTexture(unpack(color))
		line:SetStartPoint("CENTER", UIParent)
		line:SetEndPoint("BOTTOM", frame.parent)
		line:Show()
	end

	function AuraFramePrototype:AddAura(frame, aura_tbl)
		if not frame.icons then
			frame.icons = {}
		end
		if not frame.texture_index then
			frame.texture_index = {}
		end
		local icon = frame:GetIcon(aura_tbl.texture)
		icon:SetTexture(aura_tbl.texture)
		icon:Show()
		if aura_tbl.line then
			frame:ShowLine(icon, aura_tbl.lineColor or {1, 0, 0, 1})
		end
		frame.texture_index[aura_tbl.texture] = icon
		frame:ArrangeIcons()
	end

	function AuraFramePrototype:RemoveAura(frame, texture, batch)
		if not texture or frame.texture_index or frame.texture_index[texture] then
			return
		end
		local icon = frame.texture_index[texture]
		icon:Hide()
		if frame.line and frame.line.parent_icon == icon then
			frame.line.parent_icon = nil
			frame.line:Hide()
		end
		frame.texture_index[texture] = nil
		if not batch then
			frame:ArrangeIcons()
		end
	end

	function AuraFramePrototype:RemoveAll(frame)
		if not frame.icons or not frame.texture_index then
			return
		end
		for texture, _ in pairs(frame.texture_index) do
			frame:RemoveAura(texture, true)
		end
		twipe(frame.texture_index)
	end

	function CreateAuraFrame(frame)
		if not frame then
			return
		end
		return setmetatable({
			parent = frame
		}, {
			__index = AuraFramePrototype
		})
	end
end

-------------------------
-- Nameplate functions --
-------------------------
local function Nameplate_AutoHide(self, isGUID, unit, spellId, texture)
	self:Hide(isGUID, unit, spellId, texture)
end

local function Nameplate_UnitAdded(frame, unit)
	if not frame or not unit then
		return
	end
	if not frame.DBMAuraFrame then
		frame.DBMAuraFrame = CreateAuraFrame(frame)
		frame:HookScript("OnHide", function(self)
			self.DBMAuraFrame:RemoveAll()
		end)
	end
	local guid, unitName = UnitGUID(unit), DBM:GetUnitFullName(unit)
	local unit_tbl
	if guid and units[guid] then
		unit_tbl = units[guid]
	elseif unitName and units[unitName] then
		unit_tbl = units[unitName]
	end
	if unit_tbl then
		for _, aura_tbl in ipairs(unit_tbl) do
			frame.DBMAuraFrame:AddAura(aura_tbl)
		end
	end
end

----------------
--  On Event  --
----------------
DBMNameplateFrame:SetScript("OnEvent", function(_, event, unit)
	if event == "NAME_PLATE_UNIT_ADDED" then
		if not unit then
			return
		end
		local f = GetNamePlateForUnit(unit)
		if not f then
			return
		end
		Nameplate_UnitAdded(f, unit)
	end
end)

-----------------
--  Functions  --
-----------------
local nameplateFrame = DBM.Nameplate

function nameplateFrame:SupportedNPMod()
	if KuiNameplates or TidyPlatesThreatDBM or Plater then
		return true
	end
	return false
end

function nameplateFrame:Show(isGUID, unit, spellId, texture, duration, desaturate, addLine, lineColor)
	if DBM.Options.DontShowNameplateIcons or playerGUID == unit or playerName == unit then
		return
	end
	if DBM.Options.DontShowNameplateLines then
		addLine, lineColor = nil, nil
	end
	local currentTexture = tonumber(texture) or texture or GetSpellTexture(spellId)
	if self:SupportedNPMod() then
		DBM:FireEvent("BossMod_ShowNameplateAura", isGUID, unit, currentTexture, duration, desaturate, addLine, lineColor)
		DBM:Debug("DBM.Nameplate Found supported NP mod, only sending Show callbacks", 3)
		return
	end
	if not self:IsShown() then
		DBMNameplateFrame:Show()
		DBMNameplateFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
		DBM:Debug("DBM.Nameplate Enabling", 2)
	end
	if not units[unit] then
		units[unit] = {}
		num_units = num_units + 1
	end
	tinsert(units[unit], {
		texture		= currentTexture,
		line		= addLine,
		lineColor	= lineColor
	})
	if not isGUID then
		local frame = GetNamePlateForUnit(unit)
		if frame then
			Nameplate_UnitAdded(frame, unit)
			if duration then
				DBM:Schedule(duration, Nameplate_AutoHide, self, isGUID, unit, spellId, texture)
			end
		end
	else
		for _, frame in pairs(GetNamePlates()) do
			local foundUnit = frame.namePlateUnitToken or (frame.UnitFrame and frame.UnitFrame.unit)
			if foundUnit and UnitGUID(foundUnit) == unit then
				Nameplate_UnitAdded(frame, foundUnit)
				if duration then
					DBM:Schedule(duration, Nameplate_AutoHide, self, isGUID, unit, spellId, texture)
				end
				return
			end
		end
	end
end

function nameplateFrame:Hide(isGUID, unit, spellId, texture, force, isHostile, isFriendly)
	local currentTexture = tonumber(texture) or texture or GetSpellTexture(spellId)
	if self:SupportedNPMod() then
		DBM:Debug("DBM.Nameplate Found supported NP mod, only sending Hide callbacks", 3)
		if force then
			if isFriendly then
				DBM:FireEvent("BossMod_DisableFriendlyNameplates")
			end
			if isHostile then
				DBM:FireEvent("BossMod_DisableHostileNameplates")
			end
		elseif unit then
			DBM:FireEvent("BossMod_HideNameplateAura", isGUID, unit, currentTexture)
		end
		return
	end
	if unit and units[unit] then
		if currentTexture then
			for i, aura_tbl in ipairs(units[unit]) do
				if aura_tbl.texture == currentTexture then
					tremove(units[unit], i)
					break
				end
			end
		end
		if not currentTexture or #units[unit] == 0 then
			units[unit] = nil
			num_units = num_units - 1
		end
	end
	if not isGUID and not force then
		local frame = GetNamePlateForUnit(unit)
		if frame and frame.DBMAuraFrame then
			if not currentTexture then
				frame.DBMAuraFrame:RemoveAll()
			else
				frame.DBMAuraFrame:RemoveAura(currentTexture)
			end
		end
	else
		for _, frame in pairs(GetNamePlates()) do
			if frame.DBMAuraFrame then
				if force then
					frame.DBMAuraFrame:RemoveAll()
				elseif isGUID then
					local foundUnit = frame.namePlateUnitToken or (frame.UnitFrame and frame.UnitFrame.unit)
					if foundUnit and UnitGUID(foundUnit) == unit then
						if not currentTexture then
							frame.DBMAuraFrame:RemoveAll()
						else
							frame.DBMAuraFrame:RemoveAura(currentTexture)
						end
					end
				end
			end
		end
	end
	if force or num_units <= 0 then
		twipe(units)
		num_units = 0
		DBMNameplateFrame:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
		DBMNameplateFrame:Hide()
		DBM:Debug("DBM.Nameplate Disabling", 2)
	end
end

function nameplateFrame:IsShown()
	return DBMNameplateFrame and DBMNameplateFrame:IsShown()
end
