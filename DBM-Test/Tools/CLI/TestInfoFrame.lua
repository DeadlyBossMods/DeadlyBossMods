-- Run from DBM-Retail: lua DBM-Test/Tools/CLI/TestInfoFrame.lua
-- Opaque payloads exercise forwarding; only WoW can enforce actual secret restrictions.
---@diagnostic disable: undefined-field, inject-field, param-type-mismatch, undefined-global
local function forbidden()
	error("Secret payload inspected or transformed", 2)
end
local secretMeta = {__tostring = forbidden, __concat = forbidden, __eq = forbidden, __lt = forbidden, __le = forbidden, __add = forbidden}
local secretLeft, secretRight = setmetatable({}, secretMeta), setmetatable({}, secretMeta)
local function isSecret(value)
	return rawequal(value, secretLeft) or rawequal(value, secretRight)
end
local function noop() end
local widgets = {}
local methods = {}
local env = setmetatable({}, {__index = _G})
local function widget(parent, name, direct)
	local result = setmetatable({mockWidget = true, parent = parent, name = name, direct = direct, shown = true, scripts = {}, regions = {}}, {__index = methods})
	widgets[#widgets + 1] = result
	return result
end
function methods:IsShown() return self.shown end
function methods:IsVisible() return self.shown and (not self.parent or self.parent:IsVisible()) end
function methods:Show() self.shown = true end
function methods:Hide()
	local wasVisible = self:IsVisible()
	self.shown = false
	if wasVisible and self.scripts.OnHide then self.scripts.OnHide(self) end
	-- Model ancestor OnHide delivery without changing the child's shown state.
	if wasVisible then
		for _, child in ipairs(widgets) do
			if child.parent == self and child.shown and child.scripts.OnHide then child.scripts.OnHide(child) end
		end
	end
end
function methods:SetScript(name, callback) self.scripts[name] = callback end
function methods:CreateFontString(name)
	local region = widget(self, name, name == nil and #self.regions > 0)
	self.regions[#self.regions + 1] = region
	return region
end
function methods:SetText(text)
	-- Never retain a sentinel, including in the mocked visible widget.
	if isSecret(text) then
		assert(self:IsVisible(), "Secret sent to a hidden region")
		assert(self.direct, "Secret sent to a legacy region")
		self.payload = rawequal(text, secretLeft) and "secret-left" or "secret-right"
	else
		self.payload = text
	end
end
function methods:GetText()
	assert(not self.direct, "Direct text queried")
	return self.payload
end
function methods:GetStringWidth()
	assert(not self.direct, "Direct text measured")
	return #(tostring(self.payload or "")) * 6
end
function methods:SetSize(width, height) self.width, self.height = width, height end
function methods:SetWidth(width) self.width = width end
function methods:SetFont(font, size, style) self.font, self.fontSize, self.fontStyle = font, size, style end
function methods:SetPoint(point, relative, relativePoint, x, y) self.point, self.x, self.y = point, x, y end
function methods:ClearAllPoints() self.point = nil end
function methods:SetTextColor(r, g, b) self.r, self.g, self.b = r, g, b end
methods.SetJustifyH, methods.SetWordWrap = noop, noop
methods.SetFrameStrata, methods.ApplyBackdrop, methods.SetClampedToScreen = noop, noop, noop
methods.EnableMouse, methods.SetToplevel, methods.SetMovable, methods.RegisterForDrag = noop, noop, noop, noop
local scheduled, ticker
local DBM = {
	Options = {InfoFrameStrata = "HIGH", InfoFrameFont = "standardFont", InfoFrameFontSize = 12, InfoFrameFontStyle = "", InfoFramePoint = "CENTER", InfoFrameX = 0, InfoFrameY = 0, InfoFrameLines = 0, InfoFrameCols = 0},
	DefaultOptions = {InfoFrameStrata = "HIGH"}
}
function DBM:IsRetail() return true end
function DBM:IsWrath() return false end
function DBM:IsRestricted() return false end
function DBM:IsFontValid() return true end
function DBM:IsNoneValue(value) return value == "" end
function DBM:issecretvalue(value) return isSecret(value) end
function DBM:hasanysecretvalues(...)
	for i = 1, select("#", ...) do if isSecret((select(i, ...))) then return true end end
	return false
end
function DBM:Schedule(_, callback, ...) scheduled = {callback = callback, args = {...}} end
function DBM:Unschedule() scheduled = nil end
function DBM:GetUnitFullName(value) return value end
function DBM:GetRaidUnitId() return nil end
function DBM:GetGroupMembers() return function() return nil end end
env.DBM = DBM
env.DBM_CORE_L = {INFOFRAME_TITLE = "InfoFrame"}
env.NORMAL_FONT_COLOR = {r = 1, g = 1, b = 1}
env.RAID_CLASS_COLORS = {}
env.UIParent = widget()
env.CreateFrame = function(_, name, parent)
	local result = widget(parent, name)
	env[name] = result
	return result
end
env.UnitPosition = function() return 0, 0, 0, 1 end
env.GetRaidTargetIndex = function() return nil end
env.C_Timer = {NewTicker = function(_, callback)
	ticker = {callback = callback, Cancel = function(self) self.canceled = true end}
	return ticker
end}
env.table = setmetatable({wipe = function(target) for key in pairs(target) do target[key] = nil end end}, {__index = table})
env.string = setmetatable({split = function(_, text) return text end}, {__index = string})
local chunk
if setfenv then
	chunk = assert(loadfile("DBM-Core/DBM-InfoFrame.lua"))
	setfenv(chunk, env)
else
	chunk = assert(loadfile("DBM-Core/DBM-InfoFrame.lua", "t", env))
end
chunk("DBM-Core", {playerName = "Player", RegisterPlayerNameCallback = noop})
local info = DBM.InfoFrame
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end
local function directCell(row, right, rowsPerColumn, leftWidth, rightWidth)
	-- Pools are private: inspect only mock-visible geometry for assertions.
	local size = DBM.Options.InfoFrameFontSize
	rowsPerColumn = rowsPerColumn or (DBM.Options.InfoFrameLines ~= 0 and DBM.Options.InfoFrameLines or 3)
	leftWidth, rightWidth = leftWidth or size * 12, rightWidth or size * 8
	local column = math.floor((row - 1) / rowsPerColumn)
	local expectedY = -size / 2 - ((row - 1) % rowsPerColumn) * size
	local expectedX = (right and size + leftWidth or size / 2) + column * (leftWidth + rightWidth + size * 1.5)
	for _, region in ipairs(env.DBMInfoFrame.regions) do
		if region.direct and region.point == "TOPLEFT" and region:IsShown() then
			if region.y == expectedY and region.x == expectedX then return region end
		end
	end
end
local function checkEmpty(defaultHeader)
	for _, region in ipairs(env.DBMInfoFrame.regions) do
		if region.direct then
			if defaultHeader and region.point == "BOTTOMLEFT" then
				check(region.payload == env.DBM_CORE_L.INFOFRAME_TITLE, "Default header missing")
			else
				check(region.payload == nil or region.payload == "", "Stale direct text retained")
			end
		end
	end
end
check(not info:SetDirectLine(1, secretLeft, secretRight), "Uninitialized update accepted")
check(env.DBMInfoFrame == nil, "Uninitialized update created frame")
DBM.Options.DontShowInfoFrame = true
check(not info:ShowDirect(3), "Disabled display opened")
DBM.Options.DontShowInfoFrame = false
check(info:ShowDirect(3), "Direct show failed")
local outer = env.DBMInfoFrame
local callbacks = 0
info:RegisterCallback(function() callbacks = callbacks + 1 end)
check(info:SetDirectLine(1, secretLeft, secretRight), "Secret row rejected")
check(directCell(1).payload == "secret-left" and directCell(1, true).payload == "secret-right", "Cells not forwarded")
check(info:SetDirectHeader(secretLeft), "Secret header rejected")
check(not info:SetDirectLine(4, secretLeft, secretRight), "Overflow accepted")
check(not pcall(info.SetDirectLine, info, secretLeft, "x", 1), "Secret index accepted")
check(not pcall(info.SetDirectLine, info, 1, "x", 1, secretLeft), "Secret color accepted")
check(not pcall(info.ShowDirect, info, 3, secretLeft), "Secret width accepted")
check(not pcall(info.ShowDirect, info, -1), "Invalid count accepted")
check(info:UpdateDirect(secretRight, secretLeft, nil, 0, "third"), "Bulk rejected")
check(directCell(1).payload == "secret-right" and directCell(1, true).payload == "secret-left", "Bulk order changed")
check(directCell(2).payload == nil and directCell(2, true).payload == 0, "Nil/zero changed")
check(directCell(3).payload == "third" and directCell(3, true).payload == nil, "Odd pair failed")
check(info:UpdateDirect("one", 1, "two", 2, "three", 3, secretLeft, secretRight), "Overflow bulk rejected")
check(outer.height == 48, "Overflow changed height")
info:UpdateDirect()
check(outer.height == 12, "Empty bulk height wrong")
info:SetDirectLine(3, secretLeft, secretRight)
check(outer.height == 48, "Sparse row height wrong")
info:UpdateDirect("short", nil)
check(outer.height == 24, "Short replacement retained height")
check(callbacks == 0, "Direct mode invoked sort callback")
info:Update(1)
info:UpdateTable({Alpha = 1}, 1)
check(scheduled == nil, "Legacy refresh scheduled in direct mode")
check(not info:SetLine(1, secretLeft, secretRight), "Legacy setter accepted direct payload")
check(not info:SetHeader(secretLeft), "Legacy header accepted direct payload")
DBM.Options.InfoFrameFontSize = 20
info:UpdateStyle()
check(outer.width == 430, "Default widths did not scale")
DBM.Options.InfoFrameFontSize = 12
info:SetColumns(2)
info:SetDirectLine(6, secretLeft, secretRight)
check(outer.width == 516, "Second column geometry wrong")
check(directCell(6).payload == "secret-left" and directCell(6, true).payload == "secret-right", "Second column payload wrong")
DBM.Options.InfoFrameCols = 1
info:UpdateStyle()
DBM.Options.InfoFrameCols = 2
info:UpdateStyle()
for _, region in ipairs(outer.regions) do
	if region.direct and region.x and region.x > 258 then check(region.payload == "", "Overflow restored after expanding") end
end
DBM.Options.InfoFrameCols = 0
info:ShowDirect(3, 100, 80)
info:SetDirectLine(1, secretLeft, secretRight)
DBM.Options.InfoFrameFontSize = 20
info:UpdateStyle()
check(outer.width == 210, "Explicit pixel widths changed with font size")
DBM.Options.InfoFrameFontSize = 12
info:SetDirectHeader(secretRight)
env.UIParent:Hide()
checkEmpty()
check(not info:UpdateDirect(secretLeft, secretRight), "Ancestor-hidden update accepted")
env.UIParent:Show()
checkEmpty()
check(info:SetDirectLine(1, secretLeft, secretRight), "Fresh update after ancestor show failed")
outer:Hide()
checkEmpty()
check(not info:SetDirectHeader(secretLeft), "Hidden header update accepted")
check(not info:SetDirectLine(1, secretLeft, secretRight), "Hidden row update accepted")
check(info:ShowDirect(3), "Reopen failed")
checkEmpty(true)
info:SetDirectLine(1, secretLeft, secretRight)
info:Hide()
checkEmpty()
info:Show(3, "test")
check(callbacks == 0, "Hide failed to remove callbacks")
check(ticker ~= nil, "Legacy ticker missing")
info:Update(1)
local stale = scheduled.callback
check(info:ShowDirect(3), "Legacy -> direct failed")
check(ticker.canceled and scheduled == nil, "Legacy work not canceled")
info:SetDirectLine(1, secretLeft, secretRight)
stale(outer)
check(directCell(1).payload == "secret-left", "Stale update replaced direct display")
info:Show(3, "table", {Alpha = 1, Beta = 2})
checkEmpty()
check(not info:UpdateDirect(secretLeft, secretRight), "Wrong-mode update accepted")
-- Detach module-owned function data on direct-mode entry, do not wipe it.
local moduleData = {Alpha = 1}
info:Show(3, "function", function() return moduleData end)
info:ShowDirect(3)
check(moduleData.Alpha == 1, "Module function data wiped")
-- Callbacks can open another mode in either the initial Show update or onUpdate.
info:Hide()
info:RegisterCallback(function()
	info:ShowDirect(3)
	info:SetDirectLine(1, secretLeft, secretRight)
end)
info:Show(3, "test")
check(directCell(1).payload == "secret-left", "Initial callback mode switch lost payload")
check(outer.ticker == nil, "Initial callback mode switch restarted ticker")
info:Hide()
local callbackRuns = 0
info:RegisterCallback(function()
	callbackRuns = callbackRuns + 1
	if callbackRuns == 2 then
		info:ShowDirect(3)
		info:SetDirectLine(1, secretLeft, secretRight)
	end
end)
info:Show(3, "test")
check(directCell(1).payload == "secret-left", "OnUpdate callback mode switch lost payload")
check(outer.ticker == nil and outer.width == 258, "OnUpdate callback mode switch changed layout/ticker")
DBM.Options.InfoFrameLines, DBM.Options.InfoFrameCols = "5", -1
check(info:ShowDirect(3), "Corrupt preferences prevented show")
check(DBM.Options.InfoFrameLines == 0 and DBM.Options.InfoFrameCols == 0, "Corrupt preferences not reset")
info:SetDirectLine(1, secretLeft, secretRight)
DBM.Options.InfoFrameLines = 1
info:UpdateStyle()
check(not info:SetDirectLine(2, secretLeft, secretRight), "User line limit ignored")
DBM.Options.InfoFrameLines = 0
info:SetLines(2)
check(info:SetDirectLine(2, secretLeft, secretRight), "Module line limit ignored")
info:ClearLines()
check(outer.height == 12, "ClearLines did not reset direct layout")
info:SetDirectHeader(nil)
checkEmpty()
info:ShowDirect(3)
info:SetDirectHeader(secretRight)
info:SetDirectLine(1, secretLeft, secretRight)
DBM.Options.DontShowInfoFrame = true
check(not info:UpdateDirect(secretLeft), "Disabled update accepted")
check(not outer:IsShown(), "Disabled frame remained shown")
checkEmpty()
DBM.Options.DontShowInfoFrame = false
info:ShowDirect(3)
info:SetDirectLine(1, secretLeft, secretRight)
-- Audit module-owned state recursively; mocked widgets are sinks and keep only public labels.
local seen = {}
local function audit(value)
	check(not isSecret(value), "Secret payload retained in module state")
	if type(value) == "table" and not value.mockWidget and not seen[value] then
		seen[value] = true
		for key, item in pairs(value) do audit(key) audit(item) end
	end
end
for _, callback in pairs(info) do
	if type(callback) == "function" then
		local i = 1
		while true do
			local name, value = debug.getupvalue(callback, i)
			if not name then break end
			if name ~= "_ENV" and name ~= "DBM" then audit(value) end
			i = i + 1
		end
	end
end
info:Hide()
print("InfoFrame direct-mode tests passed (" .. checks .. " assertions)")
