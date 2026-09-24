-- Run from DBM-Retail: lua DBM-Test/Tools/CLI/TextTimersSmoke.lua
---@diagnostic disable: redundant-parameter
-- Keep test-only WoW API replacements out of LuaLS's shared global namespace.
local mockGlobals = setmetatable({}, {__index = _G})
mockGlobals._G = mockGlobals
local function loadMock(path)
	local chunk = assert(loadfile(path, "t", mockGlobals))
	if setfenv then setfenv(chunk, mockGlobals) end -- Lua 5.1 / LuaJIT
	return chunk
end
local created, callbacks, scheduled, bars, frames = 0, {}, {}, {}, {}
local fontUsed
local function widget()
	local object = {scripts = {}}
	local methods = {"SetSize", "SetHeight", "SetClampedToScreen", "SetFrameStrata", "SetMovable", "RegisterForDrag", "ClearAllPoints", "SetPoint", "Hide", "Show", "EnableMouse", "SetJustifyH", "SetShadowOffset", "SetTexCoord", "SetFont", "SetText", "SetTextColor", "SetShown", "SetTexture", "StartMoving", "StopMovingOrSizing"}
	for _, method in ipairs(methods) do rawset(object, method, function() end) end
	function object:SetFont(path) fontUsed = path end
	function object:SetText(text) self.text = text end
	function object:Show() self.shown = true end
	function object:Hide() self.shown = false end
	function object:SetScript(event, handler) self.scripts[event] = handler end
	function object:CreateFontString() return widget() end
	function object:CreateTexture() return widget() end
	function object:GetCenter() return 500, 400 end
	function object:GetHeight() return 60 end
	return object
end
mockGlobals.UIParent = widget()
local function CreateFrame()
	created = created + 1
	local frame = widget()
	frames[#frames + 1] = frame
	return frame
end
mockGlobals.CreateFrame = CreateFrame
mockGlobals.wipe = function(t) for key in pairs(t) do t[key] = nil end end
mockGlobals.LibStub = function() return {Fetch = function() return "Fonts\\FRIZQT__.TTF" end} end
local now = 0
mockGlobals.GetTime = function() return now end

local DBM = {Options = {TextTimersEnabled = false, TextTimersThreshold = 5, TextTimersMaxLines = 5,
	TextTimersMaxNameLength = 20, TextTimersFont = "standardFont", TextTimersFontSize = 18,
	TextTimersUrgentThreshold = 2, TextTimersUrgentR = 1, TextTimersUrgentG = 0,
	TextTimersUrgentB = 0, TextTimersIcon = true, TextTimersIconPosition = "LEFT",
	TextTimersLocked = true, TextTimersX = 0, TextTimersY = 150}, DefaultOptions = {TextTimersX = 0, TextTimersY = 150}}
mockGlobals.DBM = DBM
function DBM:IsFontValid(path) return path == "Fonts\\CUSTOM.TTF" end
function DBM:RegisterCallback(event, handler)
	assert(not callbacks[event], "duplicate callback")
	callbacks[event] = handler
end
function DBM:UnregisterCallback(event, handler)
	assert(callbacks[event] == handler)
	callbacks[event] = nil
end
function DBM:Schedule(delay, handler) scheduled[handler] = delay end
function DBM:Unschedule(handler) scheduled[handler] = nil end
local DBT = {Options = {VarianceEnabled2 = false}}
mockGlobals.DBT = DBT
function DBT:GetBar(id) return bars[id] end
function DBT:GetBarIterator()
	local activeBars = {}
	for _, bar in pairs(bars) do activeBars[bar] = true end
	return next, activeBars, nil
end

loadMock("DBM-Core/DBM-TextTimers.lua")("DBM-Core", {standardFont = "Fonts\\FRIZQT__.TTF"})
assert(created == 0 and not next(callbacks) and not next(scheduled), "disabled load did work")
DBM.TextTimers:SyncOptions()
assert(created == 0 and not next(callbacks) and not next(scheduled), "disabled sync did work")
DBM.TextTimers:SetEnabled(true)
assert(callbacks.DBM_TimerBegin and created == 0, "enable created a frame prematurely")

local secretBar = setmetatable({id = "secret", isSecret = true}, {
	__index = function(_, key) error("secret bar field read: " .. key) end,
})
bars.secret = secretBar
callbacks.DBM_TimerBegin(nil, "secret", "Protected", 4, 123, "cd", 12, 1, 1, nil, nil, nil, nil, nil, false, "cd", nil, nil, true)
assert(created == 0 and not next(scheduled), "secret begin was tracked or scheduled")
callbacks.DBM_TimerStop(nil, "secret")
assert(not next(scheduled), "untracked secret stop scheduled a refresh")
bars.secret = nil

-- The last Begin argument indicates whether the DBM bar option is enabled.
local bar = {id = "timer1", timer = 20, frame = {GetName = function() return "test" end}}
bars.timer1 = bar
callbacks.DBM_TimerBegin(nil, "timer1", "Meteor", 4, 123, "cd", 12, 1, 1, nil, nil, nil, nil, nil, false, "cd", nil, nil, false)
assert(created == 0, "disabled bar leaked into display")
callbacks.DBM_TimerBegin(nil, "timer1", "Meteor", 4, 123, "cd", 12, 1, 1, nil, nil, nil, nil, nil, false, "cd", nil, nil, true)
for handler, delay in pairs(scheduled) do
	if delay == 0 then scheduled[handler] = nil; handler() end
end
assert(created == 0 and next(scheduled), "distant timer did not defer display")
bar.timer = 4
for handler in pairs(scheduled) do scheduled[handler] = nil; handler() end
assert(created > 0, "enabled timer did not create display")
assert(frames[2].text.text == "Meteor  4.0", "display did not use live bar time and label")
DBM.Options.TextTimersFont = "Fonts\\CUSTOM.TTF"
DBM.TextTimers:RefreshStyle()
assert(fontUsed == "Fonts\\CUSTOM.TTF", "shared-media font path was not applied")
DBM.Options.TextTimersFont = "missing font"
DBM.TextTimers:RefreshStyle()
assert(fontUsed == "Fonts\\FRIZQT__.TTF", "invalid font did not fall back")
DBM.Options.TextTimersFont = "standardFont"
bar.timer = 1.5
frames[1].scripts.OnUpdate(frames[1], 0.11)
assert(frames[2].text.text == "Meteor  1.5", "display kept a separate countdown")
-- Numeric timeline IDs and string module IDs must sort safely at equal time.
bars[42] = {id = 42, timer = 1.5, frame = {GetName = function() return "numeric" end}}
callbacks.DBM_TimerBegin(nil, 42, "Numeric", 1.5, 123, "cd", 12, 1, 1, nil, nil, nil, nil, nil, false, "cd", nil, nil, true)
for handler, delay in pairs(scheduled) do
	if delay == 0 then scheduled[handler] = nil; handler() end
end
assert(frames[2].text.text == "Numeric  1.5" and frames[3].text.text == "Meteor  1.5", "mixed-type timer IDs failed tie sorting")
callbacks.DBM_TimerStop(nil, 42)
bars[42] = nil
for handler, delay in pairs(scheduled) do
	if delay == 0 then scheduled[handler] = nil; handler() end
end
bar.isSecret = true
bar.timer = nil
bar.frame = nil
frames[1].scripts.OnUpdate(frames[1], 0.11)
assert(not frames[1].shown and not frames[1].scripts.OnUpdate, "refresh read or rendered a newly secret bar")
bar.timer = 1.5
bar.frame = {GetName = function() return "test" end}
bar.isSecret = nil
callbacks.DBM_TimerBegin(nil, "timer1", "Meteor", 4, 123, "cd", 12, 1, 1, nil, nil, nil, nil, nil, false, "cd", nil, nil, true)
for handler, delay in pairs(scheduled) do
	if delay == 0 then scheduled[handler] = nil; handler() end
end
assert(frames[1].shown, "ordinary bar did not recover after secret refresh")
bar.isSecret = true
callbacks.DBM_TimerUpdateIcon(nil, "timer1", 456)
for handler, delay in pairs(scheduled) do
	if delay == 0 then scheduled[handler] = nil; handler() end
end
assert(not frames[1].shown, "secret icon update retained or rendered a tracked bar")
bar.isSecret = nil
callbacks.DBM_TimerBegin(nil, "timer1", "Meteor", 4, 123, "cd", 12, 1, 1, nil, nil, nil, nil, nil, false, "cd", nil, nil, true)
for handler, delay in pairs(scheduled) do
	if delay == 0 then scheduled[handler] = nil; handler() end
end
assert(frames[1].shown, "ordinary bar did not recover after secret icon update")
bar.isSecret = true
callbacks.DBM_TimerBegin(nil, "timer1", "Protected", 4, 123, "cd", 12, 1, 1, nil, nil, nil, nil, nil, false, "cd", nil, nil, true)
for handler, delay in pairs(scheduled) do
	if delay == 0 then scheduled[handler] = nil; handler() end
end
assert(not frames[1].shown and not frames[1].scripts.OnUpdate, "secret replacement remained visible")
bar.isSecret = nil
callbacks.DBM_TimerBegin(nil, "timer1", "Meteor", 4, 123, "cd", 12, 1, 1, nil, nil, nil, nil, nil, false, "cd", nil, nil, true)
for handler, delay in pairs(scheduled) do
	if delay == 0 then scheduled[handler] = nil; handler() end
end
assert(frames[1].shown, "ordinary bar was not restored")
callbacks.DBM_TimerPause(nil, "timer1")
bar.paused = true
for handler, delay in pairs(scheduled) do
	if delay == 0 then scheduled[handler] = nil; handler() end
end
callbacks.DBM_TimerStop(nil, "timer1")
bars.timer1 = nil
DBM.TextTimers:SetEnabled(false)
assert(not next(callbacks) and not next(scheduled), "disable leaked callbacks or wakeups")
bars.secret = secretBar
bars.timer2 = {id = "timer2", timer = 3, frame = {GetName = function() return "test2" end}}
DBM.TextTimers:SetEnabled(true)
for handler, delay in pairs(scheduled) do
	if delay == 0 then scheduled[handler] = nil; handler() end
end
assert(frames[1].shown and frames[2].text.text == "timer2  3.0", "mid-encounter scan included secret bar or missed ordinary bar")
DBM.TextTimers:SetEnabled(false)
assert(not next(callbacks) and not next(scheduled), "second disable leaked callbacks")
assert(DBM.TextTimers:TogglePreview() == 5, "preview did not return its GUI collapse duration")
assert(not next(callbacks) and not next(scheduled), "disabled preview subscribed to timers")
assert(frames[2].text.text == "Evil Spell  3.0" and frames[3].text.text == "Boom  5.0", "preview did not start ordered sample timers")
now = 1
frames[1].scripts.OnUpdate(frames[1], 0.11)
assert(frames[2].text.text == "Evil Spell  2.0" and frames[3].text.text == "Boom  4.0", "preview did not count down")
now = 3.5
frames[1].scripts.OnUpdate(frames[1], 0.11)
assert(frames[2].text.text == "Boom  1.5" and not frames[3].shown, "preview did not remove the earlier sample")
DBM.TextTimers:HidePreview()
assert(not frames[1].shown and not frames[1].scripts.OnUpdate and not next(callbacks) and not next(scheduled), "preview teardown leaked work")
DBM.TextTimers:TogglePreview()
now = 9
frames[1].scripts.OnUpdate(frames[1], 0.11)
assert(not frames[1].shown and not frames[1].scripts.OnUpdate and not next(callbacks) and not next(scheduled), "expired preview did not stop cleanly")
DBM.Options.TextTimersThreshold = 0
assert(DBM.TextTimers:TogglePreview() == nil, "empty preview requested a GUI collapse")
assert(not frames[1].shown and not frames[1].scripts.OnUpdate, "empty preview left an update script")
DBM.Options.TextTimersThreshold = 5
DBM.TextTimers:TogglePreview()
DBM.TextTimers:SetEnabled(true)
assert(callbacks.DBM_TimerBegin and not next(scheduled) and frames[1].scripts.OnUpdate, "enabled preview consumed live bar or stopped animating")
now = 10
frames[1].scripts.OnUpdate(frames[1], 0.11)
assert(frames[2].text.text == "Evil Spell  2.0", "enabled preview did not count down")
DBM.TextTimers:SetEnabled(false)
assert(not next(callbacks) and not next(scheduled) and frames[1].scripts.OnUpdate, "disabling live timers stopped preview or leaked work")
DBM.TextTimers:SetEnabled(true)
DBM.TextTimers:HidePreview()
assert(frames[2].text.text == "timer2  3.0" and next(scheduled), "closing enabled preview did not resume live timers")
for handler, delay in pairs(scheduled) do
	if delay == 0 then scheduled[handler] = nil; handler() end
end
assert(frames[1].shown and frames[2].text.text == "timer2  3.0", "live view did not resume after preview")
DBM.TextTimers:SetEnabled(false)
DBM.Options = setmetatable({TextTimersEnabled = true}, {__index = DBM.Options})
DBM.TextTimers:SyncOptions()
assert(callbacks.DBM_TimerBegin, "profile switch did not enable callbacks")
DBM.Options.TextTimersEnabled = false
DBM.TextTimers:SyncOptions()
assert(not next(callbacks) and not next(scheduled), "profile switch did not disable callbacks")

-- Only a producer-marked start may own a clock without a DBT bar.
bars.timer2 = nil
now = 20
DBM.TextTimers:SetEnabled(true)
local function beginBarless(id, name, duration)
	callbacks.DBM_TimerBegin(nil, id, name, duration, 123, "cd", 12, 1, 1, nil, nil, nil, nil, nil, false, "cd", nil, nil, false, true)
end
callbacks.DBM_TimerBegin(nil, "unchecked", "Off", 3, 123, "cd", 12, 1, 1, nil, nil, nil, nil, nil, false, "cd", nil, nil, false)
assert(not DBM.TextTimers:GetBarlessRemaining("unchecked"), "unmarked disabled bar gained a clock")
beginBarless("text", "Barless", 12)
assert(DBM.TextTimers:GetBarlessRemaining("text") == 12, "marked barless timer was not retained")
for handler, delay in pairs(scheduled) do
	if delay == 0 then scheduled[handler] = nil; handler() end
end
assert(not frames[1].shown and next(scheduled), "long barless timer was not deferred")
now = 28
for handler in pairs(scheduled) do scheduled[handler] = nil; handler() end
assert(frames[1].shown and frames[2].text.text == "Barless  4.0", "barless timer did not appear at threshold")
bars.live = {id = "live", timer = 2, frame = {GetName = function() return "live" end}}
callbacks.DBM_TimerBegin(nil, "live", "Live", 2, 123, "cd", 12, 1, 1, nil, nil, nil, nil, nil, false, "cd", nil, nil, true)
for handler, delay in pairs(scheduled) do
	if delay == 0 then scheduled[handler] = nil; handler() end
end
assert(frames[2].text.text == "Live  2.0" and frames[3].text.text == "Barless  4.0", "mixed clocks were not sorted")
bars.live = nil
callbacks.DBM_TimerStop(nil, "live")
callbacks.DBM_TimerPause("DBM_TimerPause", "text")
now = 31
for handler, delay in pairs(scheduled) do
	if delay == 0 then scheduled[handler] = nil; handler() end
end
assert(DBM.TextTimers:GetBarlessRemaining("text") == 4 and not frames[1].shown, "pause did not freeze and hide barless clock")
callbacks.DBM_TimerUpdate("DBM_TimerUpdate", "text", 1, 7)
assert(DBM.TextTimers:GetBarlessRemaining("text") == 6, "retiming paused barless clock failed")
callbacks.DBM_TimerResume("DBM_TimerResume", "text")
callbacks.DBM_TimerUpdateName(nil, "text", "Renamed")
callbacks.DBM_TimerUpdateIcon(nil, "text", 456)
now = 32
for handler, delay in pairs(scheduled) do
	if delay == 0 then scheduled[handler] = nil; handler() end
end
assert(frames[2].text.text == "Renamed  5.0", "resume or name update failed")
beginBarless("text", "Restarted", 3)
for handler, delay in pairs(scheduled) do
	if delay == 0 then scheduled[handler] = nil; handler() end
end
assert(frames[2].text.text == "Restarted  3.0", "same-ID barless start did not replace clock")
bars.text = secretBar
frames[1].scripts.OnUpdate(frames[1], 0.11)
assert(not DBM.TextTimers:GetBarlessRemaining("text") and not frames[1].shown, "secret bar collision retained barless row")
bars.text = nil
beginBarless("expires", "Expiry", 1)
for handler, delay in pairs(scheduled) do
	if delay == 0 then scheduled[handler] = nil; handler() end
end
now = 34
frames[1].scripts.OnUpdate(frames[1], 0.11)
assert(not frames[1].shown and not frames[1].scripts.OnUpdate and not DBM.TextTimers:GetBarlessRemaining("expires"), "natural barless expiry leaked work")
DBM.TextTimers:SetEnabled(false)
assert(not next(callbacks) and not next(scheduled), "barless disable leaked callbacks or scheduler")

-- The GUI hides the panel while collapsing; that must not cancel its preview.
local guiFrame, panelFrame = widget(), widget()
mockGlobals.DBM_GUI_OptionsFrame = guiFrame
function guiFrame:HookScript(event, handler) self.scripts[event] = handler end
local function control()
	local result = widget()
	function result:HookScript(event, handler) self.scripts[event] = handler end
	return result
end
local general = {frame = widget(), SetLastObj = function() end}
function general:CreateCheckButton() return control() end
function general:CreateSlider() return control() end
function general:CreateColorSelect() return control() end
function general:CreateDropdown() return control() end
local previewClick
function general:CreateButton(_, _, _, onClick)
	if not previewClick then previewClick = onClick end
	return control()
end
function general.frame:HookScript(event, handler) self.scripts[event] = handler end
local panel = {frame = panelFrame, CreateArea = function() return general end}
function panelFrame:HookScript(event, handler) self.scripts[event] = handler end
mockGlobals.DBM_GUI_L = setmetatable({}, {__index = function(_, key) return key end})
mockGlobals.DEFAULT = "Default"
local collapseDuration
local DBM_GUI = {
	Cat_Timers = {CreateNewPanel = function() return panel end},
	MixinSharedMedia3 = function(_, _, fonts) return fonts end,
	CollapseForPreview = function(_, duration)
		if not duration or duration <= 0 then return end
		collapseDuration = duration
		guiFrame.collapsed = true
		panelFrame.scripts.OnHide()
	end,
}
mockGlobals.DBM_GUI = DBM_GUI
loadMock("DBM-GUI/modules/options/timers/TextTimers.lua")()
previewClick()
assert(collapseDuration == 5 and guiFrame.collapsed and frames[1].shown and frames[1].scripts.OnUpdate, "collapsing GUI canceled the preview")
now = 35
frames[1].scripts.OnUpdate(frames[1], 0.11)
assert(frames[2].text.text == "Evil Spell  2.0", "collapsed GUI preview did not keep counting down")
guiFrame.scripts.OnHide()
assert(not frames[1].shown and not frames[1].scripts.OnUpdate, "closing collapsed GUI left preview running")
guiFrame.collapsed = false
previewClick()
guiFrame.collapsed = false
panelFrame.scripts.OnHide()
assert(not frames[1].shown and not frames[1].scripts.OnUpdate, "leaving the panel left preview running")
print("TextTimersSmoke: OK")
