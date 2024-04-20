---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = DBM

local L = DBM_CORE_L

if not LibStub or not LibStub("LibDataBroker-1.1", true) or not LibStub("LibDBIcon-1.0") then
	function DBM:ToggleMinimapButton() end -- NOOP
	function DBM:ToggleCompartmentButton() end -- NOOP
	return
end

---@diagnostic disable-next-line:missing-fields
local dataBroker = LibStub and LibStub("LibDataBroker-1.1"):NewDataObject("DBM", {
	type	= "launcher",
	label	= "DBM",
	icon	= "Interface\\AddOns\\DBM-Core\\textures\\dbm_airhorn"
})
if dataBroker then
	private.dataBroker = dataBroker

	function dataBroker.OnClick(self) -- self, button
		if IsShiftKeyDown() then return end
		--[[
			if IsAltKeyDown() and button == "RightButton" then
				DBM.Options.SilentMode = DBM.Options.SilentMode == false and true or false
				DBM:AddMsg(L.SILENTMODE_IS .. (DBM.Options.SilentMode and "ON" or "OFF"))
			else
		--]]
			DBM:LoadGUI()
		--end
	end

	function dataBroker.OnTooltipShow(GameTooltip)
		---@cast GameTooltip GameTooltip
		GameTooltip:SetText(L.MINIMAP_TOOLTIP_HEADER, 1, 1, 1)
		GameTooltip:AddLine(("%s (%s)"):format(DBM.DisplayVersion, DBM:ShowRealDate(DBM.Revision)), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(L.MINIMAP_TOOLTIP_FOOTER, RAID_CLASS_COLORS.MAGE.r, RAID_CLASS_COLORS.MAGE.g, RAID_CLASS_COLORS.MAGE.b, 1)
		GameTooltip:AddLine(L.LDB_TOOLTIP_HELP1, RAID_CLASS_COLORS.MAGE.r, RAID_CLASS_COLORS.MAGE.g, RAID_CLASS_COLORS.MAGE.b)
		--GameTooltip:AddLine(L.LDB_TOOLTIP_HELP2, RAID_CLASS_COLORS.MAGE.r, RAID_CLASS_COLORS.MAGE.g, RAID_CLASS_COLORS.MAGE.b)
	end
end

do
	local LibDBIcon = LibStub("LibDBIcon-1.0")

	function DBM:ToggleMinimapButton()
		DBM_MinimapIcon.hide = not DBM_MinimapIcon.hide
		if DBM_MinimapIcon.hide then
			LibDBIcon:Hide("DBM")
		else
			LibDBIcon:Show("DBM")
		end
	end

	function DBM:ToggleCompartmentButton()
		DBM_MinimapIcon.showInCompartment = not DBM_MinimapIcon.showInCompartment
		if DBM_MinimapIcon.showInCompartment then
			LibDBIcon:AddButtonToCompartment("DBM")
		else
			LibDBIcon:RemoveButtonFromCompartment("DBM")
		end
	end
end
