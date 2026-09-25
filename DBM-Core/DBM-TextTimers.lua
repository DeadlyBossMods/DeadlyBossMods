---@class DBMCoreNamespace
local private = select(2, ...)
---@class DBM
---@field TextTimers DBMTextTimers?
local DBM, DBT = DBM, DBT
---@class DBMTextTimers
local TextTimers = {}
DBM.TextTimers = TextTimers

-- Text Timers is an opt-in display, independent of the global DBM bar visibility
-- option. When HideDBMBars prevents bar creation, eligible module timers need
-- their own deadlines here; otherwise DBT's live bar remains the clock.
-- Individual timer and category disables still apply to both displays.
local tracked = {}
local rows = {}
---@type Frame?
local frame
local active, preview, previewMovable, elapsed = false, false, false, 0
local updateInterval = 0.1
local refresh, renderPreview
local previewTimers

local function fontPath()
	local font = DBM.Options.TextTimersFont
	if font == "standardFont" then return private.standardFont end
	if DBM:IsFontValid(font, private.standardFont, DBM.Options.TextTimersFontSize, "OUTLINE") then return font end
	return private.standardFont
end

local function cleanName(text)
	-- Strip formatting before shortening; never split a multibyte character or a WoW texture tag.
	text = (text or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
	text = text:gsub("|[TA].-|[ta]", ""):gsub("|H.-|h(.-)|h", "%1")
	local limit = DBM.Options.TextTimersMaxNameLength
	if limit <= 0 then return text end
	local parts = {}
	for character in text:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
		parts[#parts + 1] = character
		if #parts > limit then
			parts[#parts] = nil
			return table.concat(parts) .. "..."
		end
	end
	return text
end

local function position()
	if not frame then return end
	frame:ClearAllPoints()
	if DBM.Options.TextTimersGrowDirection == "UP" then
		frame:SetPoint("BOTTOM", UIParent, "CENTER", DBM.Options.TextTimersX, DBM.Options.TextTimersY - DBM.Options.TextTimersFontSize - 10)
	else
		frame:SetPoint("TOP", UIParent, "CENTER", DBM.Options.TextTimersX, DBM.Options.TextTimersY)
	end
end

local function positionRow(row, index, size)
	row:SetHeight(size + 10)
	row:ClearAllPoints()
	if DBM.Options.TextTimersGrowDirection == "UP" then
		row:SetPoint("BOTTOM", frame, "BOTTOM", 0, (index - 1) * (size + 10))
	else
		row:SetPoint("TOP", frame, "TOP", 0, -(index - 1) * (size + 10))
	end
end

local function ensureFrame()
	if frame then return end
	frame = CreateFrame("Frame", nil, UIParent)
	frame:SetSize(320, 40)
	frame:SetClampedToScreen(true)
	frame:SetFrameStrata("HIGH")
	frame:SetMovable(true)
	frame:RegisterForDrag("LeftButton")
	frame:EnableMouse(false)
	frame:SetScript("OnDragStart", function(self)
		if preview and previewMovable then self:StartMoving() end
	end)
	frame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		local x, y = self:GetCenter()
		if x and y then
			DBM.Options.TextTimersX = x - UIParent:GetCenter()
			local firstRowTop = DBM.Options.TextTimersGrowDirection == "UP" and y - self:GetHeight() / 2 + DBM.Options.TextTimersFontSize + 10 or y + self:GetHeight() / 2
			DBM.Options.TextTimersY = firstRowTop - select(2, UIParent:GetCenter())
		end
		position()
	end)
	position()
	frame:Hide()
end

local function acquireRow(index)
	if rows[index] then return rows[index] end
	local row = CreateFrame("Frame", nil, frame)
	row:SetSize(320, 30)
	row.text = row:CreateFontString(nil, "OVERLAY")
	row.text:SetJustifyH("LEFT")
	row.text:SetShadowOffset(1, -1)
	row.time = row:CreateFontString(nil, "OVERLAY")
	row.time:SetJustifyH("RIGHT")
	row.time:SetShadowOffset(1, -1)
	row.icon = row:CreateTexture(nil, "ARTWORK")
	row.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	row.iconRight = row:CreateTexture(nil, "ARTWORK")
	row.iconRight:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	rows[index] = row
	local size = DBM.Options.TextTimersFontSize
	positionRow(row, index, size)
	local font = fontPath()
	row.text:SetFont(font, size, "OUTLINE")
	row.time:SetFont(font, size, "OUTLINE")
	row.time:SetWidth(size * 4) -- Fixed-width field; the digits never move the label or icons.
	row.icon:SetSize(size + 4, size + 4)
	row.icon:SetPoint("RIGHT", row.text, "LEFT", -4, 0)
	row.iconRight:SetSize(size + 4, size + 4)
	row.iconRight:SetPoint("LEFT", row.time, "RIGHT", 4, 0)
	return row
end

local function styleIcons(row, size)
	row.icon:SetSize(size + 4, size + 4)
	row.iconRight:SetSize(size + 4, size + 4)
end

local function setRowText(row, key, name, time)
	-- A recycled DBT FontString can retain protected text even after the bar's
	-- current metadata no longer identifies it as secret. Never compare or reuse
	-- a protected cached value from an earlier refresh.
	if DBM:issecretvalue(row.key) or DBM:issecretvalue(row.name) then
		row.key, row.name = nil, nil
	end
	if DBM:issecretvalue(key) or DBM:issecretvalue(name) then return end
	if row.key ~= key or row.name ~= name then
		row.key, row.name = key, name
		row.text:SetText(cleanName(name))
		row.text:ClearAllPoints()
		row.text:SetPoint("LEFT", row, "CENTER", -(row.text:GetStringWidth() + 4 + row.time:GetWidth()) / 2, 0)
		row.time:ClearAllPoints()
		row.time:SetPoint("LEFT", row.text, "RIGHT", 4, 0)
	end
	local number = ("%.1f"):format(time)
	if row.number ~= number then
		row.number = number
		row.time:SetText(number)
	end
end

local function showIcons(row, texture)
	local show = DBM.Options.TextTimersIcon and texture ~= nil
	if texture then
		row.icon:SetTexture(texture)
		row.iconRight:SetTexture(texture)
	end
	row.icon:SetShown(show and DBM.Options.TextTimersIconPosition ~= "RIGHT")
	row.iconRight:SetShown(show and DBM.Options.TextTimersIconPosition ~= "LEFT")
end

local function setRowColor(row, time, colorType)
	local urgent = DBM.Options.TextTimersUrgentThreshold > 0 and time <= DBM.Options.TextTimersUrgentThreshold
	local r, g, b
	if DBM.Options.TextTimersInheritBarColor and type(colorType) == "number" and colorType >= 0 and colorType <= 8 and colorType % 1 == 0 then
		r, g, b = DBT:GetColorForType(colorType, urgent)
	end
	if not r then
		if urgent then
			r, g, b = DBM.Options.TextTimersUrgentR, DBM.Options.TextTimersUrgentG, DBM.Options.TextTimersUrgentB
		else
			r, g, b = DBM.Options.TextTimersFontR, DBM.Options.TextTimersFontG, DBM.Options.TextTimersFontB
		end
	end
	row.text:SetTextColor(r, g, b)
	row.time:SetTextColor(r, g, b)
end

function TextTimers:RefreshStyle()
	if not frame then
		if active then refresh() end
		return
	end
	position()
	frame:EnableMouse(preview and previewMovable)
	local size = DBM.Options.TextTimersFontSize
	for i, row in ipairs(rows) do
		positionRow(row, i, size)
		row.text:SetFont(fontPath(), size, "OUTLINE")
		row.time:SetFont(fontPath(), size, "OUTLINE")
		row.time:SetWidth(size * 4)
		row.key = nil -- Font/size changes require a fresh label width and center.
		styleIcons(row, size)
	end
	if preview then
		renderPreview()
	elseif active then
		refresh()
	end
end

local function remaining(bar)
	local time = bar.timer
	if bar.hasVariance and DBT.Options.VarianceEnabled2 and DBT.Options.VarianceBehavior == "ZeroAtMinTimerAndNeg" then
		time = time - (bar.varianceDuration or 0)
	end
	return time
end

-- Only the producer-marked, barless path owns a deadline. Bar-backed timers
-- always use DBT's clock instead, and are never promoted to barless on loss.
function TextTimers:GetBarlessRemaining(id)
	local data = active and tracked[id]
	if not data or not data.textOnly then return end
	local bar = DBT:GetBar(id)
	if bar then
		if bar.isSecret then tracked[id] = nil end
		return
	end
	return data.paused or (data.expires - GetTime()), data.paused ~= nil, data.keep
end

local function hideRows()
	for _, row in ipairs(rows) do row:Hide() end
	if frame then frame:Hide() end
end

local function wake()
	refresh()
end

local function setUpdateInterval(count)
	local interval = count > 1 and 0.02 or 0.1
	if updateInterval ~= interval then
		updateInterval = interval
		elapsed = 0
	end
end

local function onUpdate(_, delta)
	elapsed = elapsed + delta
	if elapsed >= updateInterval then
		elapsed = 0
		refresh()
	end
end

refresh = function()
	DBM:Unschedule(wake)
	if not active or preview then return end
	local candidates, nextWake = {}, nil
	local threshold = DBM.Options.TextTimersThreshold
	for id, data in pairs(tracked) do
		local bar = DBT:GetBar(id)
		if bar and (bar.isSecret or bar.dead or bar.dummy) or not bar and not data.textOnly then
			tracked[id] = nil
		elseif not bar and data.textOnly or bar and not bar.paused then
			local time = bar and remaining(bar) or (data.paused or data.expires - GetTime()) - (data.offset or 0)
			if data.textOnly and (bar or not data.paused and data.expires <= GetTime()) then
				tracked[id] = nil
			elseif not data.paused or bar then
				if time > 0 and time <= threshold then
					local label = bar and _G[bar.frame:GetName() .. "BarName"]
					local name = label and label:GetText() or data.name or id
					-- DBT metadata normally marks timeline bars as secret, but the
					-- FontString value is authoritative when a bar frame is reused.
					if DBM:issecretvalue(name) then
						tracked[id] = nil
					else
						candidates[#candidates + 1] = {id = id, bar = bar, data = data, name = name, time = time}
					end
				elseif time > threshold then
					local delay = time - threshold
					if not nextWake or delay < nextWake then nextWake = delay end
				elseif data.textOnly then
					-- Variance may reach its display zero before the underlying
					-- (peak) timer expires. Revisit only once to discard it.
					local delay = data.expires - GetTime()
					if not nextWake or delay < nextWake then nextWake = delay end
				end
			end
		end
	end
	if #candidates > 0 then
		ensureFrame()
		assert(frame)
		table.sort(candidates, function(a, b)
			if a.time == b.time then return tostring(a.id) < tostring(b.id) end
			return a.time < b.time
		end)
		local count = math.min(#candidates, DBM.Options.TextTimersMaxLines)
		setUpdateInterval(count)
		local size = DBM.Options.TextTimersFontSize
		frame:SetHeight(count * (size + 10))
		for i = 1, count do
			local candidate = candidates[i]
			local row = acquireRow(i)
			setRowText(row, candidate.id, candidate.name, candidate.time)
			setRowColor(row, candidate.time, candidate.data.colorType or candidate.bar and candidate.bar.colorType)
			local icon = candidate.data.icon
			if not icon and candidate.bar then
				local texture = _G[candidate.bar.frame:GetName() .. "BarIcon1"]
				icon = texture and texture:GetTexture()
			end
			showIcons(row, icon)
			row:Show()
		end
		for i = count + 1, #rows do rows[i]:Hide() end
		frame:Show()
		frame:SetScript("OnUpdate", onUpdate)
	else
		if frame then frame:SetScript("OnUpdate", nil) end
		if not preview then hideRows() end
		if nextWake then DBM:Schedule(math.max(nextWake, 0.05), wake) end
	end
end

local function changed()
	-- Timer callbacks can precede DBT's mutation; coalesce until the bar is updated.
	if preview then return end
	DBM:Unschedule(wake)
	DBM:Schedule(0, wake)
end

local function began(_, id, name, duration, icon, _, _, colorType, _, keep, _, _, _, _, _, _, hasVariance, peak, enabled, textOnly)
	local bar = DBT:GetBar(id)
	-- Encounter-timeline bars can contain protected text/icons. Check only DBT's
	-- non-secret metadata before retaining callback data or reading bar fields.
	if bar and bar.isSecret then
		if tracked[id] then tracked[id] = nil; changed() end
	elseif enabled and bar and not bar.dead and not bar.dummy then
		tracked[id] = {name = name, icon = icon, colorType = colorType}
		changed()
	elseif textOnly == true and not enabled and not bar and type(duration) == "number" and duration > 0 then
		-- In variance mode DBT counts down from the peak; its 'zero at minimum'
		-- option shifts the visible time back to the callback's minimum.
		local time = hasVariance and DBT.Options.VarianceEnabled2 and type(peak) == "number" and peak or duration
		local offset = hasVariance and DBT.Options.VarianceEnabled2 and DBT.Options.VarianceBehavior == "ZeroAtMinTimerAndNeg" and (time - duration) or 0
		tracked[id] = {name = name, icon = icon, colorType = colorType, textOnly = true, expires = GetTime() + time, offset = offset, keep = keep}
		changed()
	elseif tracked[id] then
		tracked[id] = nil
		changed()
	end
end

local function stopped(_, id)
	if tracked[id] then
		tracked[id] = nil
		changed()
	end
end

local function updatedIcon(_, id, icon)
	local data = tracked[id]
	if not data then return end
	local bar = DBT:GetBar(id)
	if bar and bar.isSecret or not bar and not data.textOnly then
		tracked[id] = nil
	else
		data.icon = icon
	end
	changed()
end

local function modified(event, id, elapsed, total)
	local data = tracked[id]
	if not data then return end
	if data.textOnly then
		local bar = DBT:GetBar(id)
		if bar then
			tracked[id] = nil
		elseif event == "DBM_TimerPause" and not data.paused then
			data.paused = math.max(0, data.expires - GetTime())
		elseif event == "DBM_TimerResume" and data.paused then
			data.expires = GetTime() + data.paused
			data.paused = nil
		elseif event == "DBM_TimerUpdate" and type(total) == "number" then
			local newTime = total - (elapsed or 0)
			data.offset = 0
			if newTime <= 0 then
				tracked[id] = nil
			elseif data.paused then
				data.paused = newTime
			else
				data.expires = GetTime() + newTime
			end
		end
	end
	changed()
end

local function updatedName(_, id, name)
	local data = tracked[id]
	if data and data.textOnly then
		local bar = DBT:GetBar(id)
		if bar then tracked[id] = nil else data.name = name end
		changed()
	end
end

local callbacks = {
	DBM_TimerBegin = began,
	DBM_TimerStop = stopped,
	DBM_TimerUpdate = modified,
	DBM_TimerPause = modified,
	DBM_TimerResume = modified,
	DBM_TimerUpdateIcon = updatedIcon,
	DBM_TimerUpdateName = updatedName,
}

function TextTimers:SetEnabled(enabled)
	DBM.Options.TextTimersEnabled = not not enabled
	self:SyncOptions()
end

function TextTimers:SyncOptions()
	local enabled = DBM.Options.TextTimersEnabled
	if enabled ~= active then
		active = enabled
		if enabled then
			-- Do not track barless timers or handle timer callbacks while this display is off.
			for event, handler in pairs(callbacks) do DBM:RegisterCallback(event, handler) end
			-- Include bars already running when enabled mid-encounter.
			for bar in DBT:GetBarIterator() do
				if not bar.isSecret and not bar.dummy and not bar.dead then tracked[bar.id] = tracked[bar.id] or {} end
			end
		else
			for event, handler in pairs(callbacks) do DBM:UnregisterCallback(event, handler) end
			wipe(tracked)
			DBM:Unschedule(wake)
			if frame and not preview then frame:SetScript("OnUpdate", nil) end
			if not preview then hideRows() end
		end
	end
	self:RefreshStyle()
end

function TextTimers:ResetPosition()
	DBM.Options.TextTimersX = DBM.DefaultOptions.TextTimersX
	DBM.Options.TextTimersY = DBM.DefaultOptions.TextTimersY
	position()
end

renderPreview = function()
	if not preview or not frame or not previewTimers then return end
	local now = GetTime()
	local count = 0
	local size = DBM.Options.TextTimersFontSize
	-- Preview data is deliberately separate from DBT: dummy bars do not tick and
	-- ordinary test bars would appear in the player's actual timer bar stack.
	for _, sample in ipairs(previewTimers) do
		local time = sample.expires - now
		if time > 0 and (previewMovable or time <= DBM.Options.TextTimersThreshold) and count < DBM.Options.TextTimersMaxLines then
			count = count + 1
			local row = acquireRow(count)
			setRowText(row, sample, sample.name, time)
			setRowColor(row, time, sample.colorType)
			showIcons(row, sample.icon)
			row:Show()
		end
	end
	for i = count + 1, #rows do rows[i]:Hide() end
	setUpdateInterval(count)
	if count == 0 then
		TextTimers:TogglePreview()
	else
		frame:SetHeight(count * (size + 10))
		frame:Show()
	end
end

local function previewOnUpdate(_, delta)
	elapsed = elapsed + delta
	if elapsed >= updateInterval then
		elapsed = 0
		renderPreview()
	end
end

function TextTimers:TogglePreview(movable)
	preview = not preview
	if preview then
		previewMovable = not not movable
		ensureFrame()
		assert(frame)
		DBM:Unschedule(wake)
		frame:SetScript("OnUpdate", nil)
		frame:EnableMouse(previewMovable)
		local now = GetTime()
		local threshold = DBM.Options.TextTimersThreshold
		local duration = previewMovable and 20 or math.min(10, threshold)
		previewTimers = {
			{name = "Evil Spell", expires = now + math.min(7, threshold * 0.6), icon = 135826, colorType = 3},
			{name = "Boom", expires = now + duration, icon = 135826, colorType = 2},
		}
		self:RefreshStyle()
		if preview then frame:SetScript("OnUpdate", previewOnUpdate) end
		if preview then return duration end
	else
		previewMovable = false
		previewTimers = nil
		if frame then frame:SetScript("OnUpdate", nil) end
		hideRows()
		self:RefreshStyle()
		if active then changed() end
	end
end

function TextTimers:HidePreview()
	if preview then self:TogglePreview() end
end
