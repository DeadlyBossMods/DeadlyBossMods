local Kil = DBM:GetMod("Kil")

function Kil:InitializeMenu()
	local self = Kil -- this function will be called by UIDropDownMenu_Initialize()
	local info = UIDropDownMenu_CreateInfo()
	info.text = DBM_KIL_NAME
	info.notClickable = 1
	info.isTitle = 1
	info.notCheckable = 1
	UIDropDownMenu_AddButton(info, 1)
	
	local info = UIDropDownMenu_CreateInfo()
	info.text = DBM_KIL_MENU_LOCK
	info.value = self.Options.FrameLocked
	info.func = function() self.Options.FrameLocked = not self.Options.FrameLocked end
	info.checked = self.Options.FrameLocked
	info.keepShownOnClick = 1
	UIDropDownMenu_AddButton(info, 1)
	
	local info = UIDropDownMenu_CreateInfo()
	info.text = DBM_KIL_FRAME_COLORS
	info.value = self.Options.FrameClassColor
	info.func = function() self.Options.FrameClassColor = not self.Options.FrameClassColor self:UpdateColors() end
	info.checked = self.Options.FrameClassColor
	info.keepShownOnClick = 1
	UIDropDownMenu_AddButton(info, 1)
	
	local info = UIDropDownMenu_CreateInfo()
	info.text = DBM_KIL_FRAME_UPWARDS2
	info.value = self.Options.FrameUpwards
	info.func = function() self.Options.FrameUpwards = not self.Options.FrameUpwards self:ChangeFrameOrientation() end
	info.checked = self.Options.FrameUpwards
	info.keepShownOnClick = 1
	UIDropDownMenu_AddButton(info, 1)

	local info = UIDropDownMenu_CreateInfo()
	info.text = DBM_KIL_FRAME_HIDE
	info.func = function() DBMKilFrameDrag:Hide() end
	info.notCheckable = 1
	UIDropDownMenu_AddButton(info, 1)
	
	local info = UIDropDownMenu_CreateInfo()
	info.text = DBM_CLOSE
	info.func = function() end
	info.notCheckable = 1
	UIDropDownMenu_AddButton(info, 1)
end

local firstEntry = nil
local lastEntry = nil
local frames = {}

local fCounter = 1
local function createBarFrame(name)
	local frame
	if frames[#frames] then
		frame = frames[#frames]
		frames[#frames] = nil
		frame:Show()
	else
		frame = CreateFrame("Frame", "DBMKilFrame"..fCounter, DBMKilFrameDrag, "DBMKilFrameTemplate")
		fCounter = fCounter + 1
	end
	getglobal(frame:GetName().."BarName"):SetText(name)
	return frame
end

local barMethods = {}
local function createBar(name)
	local newEntry = setmetatable({
		prev = lastEntry,
		next = nil,
		data = {
			frame = createBarFrame(name),
			name = name,
			timer = 20
		}
	}, 
	{
		__index = barMethods
	})
	if lastEntry then
		lastEntry.next = newEntry
	end
	lastEntry = newEntry
	firstEntry = firstEntry or newEntry	
	
	newEntry.data.frame.entry = newEntry
	newEntry:Update(0)
	
	return newEntry
end

function barMethods:Update(elapsed)
	local bar = getglobal(self.data.frame:GetName().."Bar")
	local cooldown = getglobal(self.data.frame:GetName().."BarCooldown")
	local spark = getglobal(self.data.frame:GetName().."BarSpark")
	self.data.timer = self.data.timer - elapsed
	if self.data.timer <= 0 then
		Kil:RemoveEntry(self.data.name)
	else
		cooldown:SetText(DBM.SecondsToTime(self.data.timer))
		bar:SetValue(self.data.timer)
		spark:ClearAllPoints()
		spark:SetPoint("CENTER", bar, "LEFT", ((bar:GetValue() / 20) * bar:GetWidth()), 0)
		spark:Show()
	end	
end

function barMethods:GetNext()
	return self.next
end

function barMethods:GetPrev()
	return self.prev
end

function barMethods:SetPosition()
	self.data.frame:ClearAllPoints()
	if self == firstEntry then
		if Kil.Options.FrameUpwards then
			self.data.frame:SetPoint("BOTTOM", DBMKilFrameDrag, "TOP", 0, -10)
		else
			self.data.frame:SetPoint("TOP", DBMKilFrameDrag, "BOTTOM", 0, 0)
		end
	else
		if Kil.Options.FrameUpwards then
			self.data.frame:SetPoint("BOTTOM", self:GetPrev().data.frame, "TOP", 0, -3)
		else
			self.data.frame:SetPoint("TOP", self:GetPrev().data.frame, "BOTTOM", 0, 3)
		end
	end
end

function barMethods:GetFrame()
	return self.data.frame
end

function barMethods:GetBar()
	return getglobal(self.data.frame:GetName().."Bar")
end

function barMethods:GetSpark()
	return getglobal(self.data.frame:GetName().."BarSpark")
end

function Kil:CreateFrame()
	if firstEntry then
		local entry = firstEntry
		while entry do
			table.insert(frames, entry.data.frame)
			entry.data.frame:Hide()
			entry.data = nil
			entry = entry:GetNext()
		end
		firstEntry = nil
		lastEntry = nil
	end
	DBMKilFrameDrag:Show()
end

function Kil:DestroyFrame()
	DBMKilFrameDrag:Hide()
end

function Kil:ChangeFrameOrientation()
	if firstEntry then
		local entry = firstEntry
		while entry do
			entry:SetPosition()
			entry = entry:GetNext()
		end
	end
end

function Kil:UpdateColors()
	if firstEntry then
		local entry = firstEntry
		while entry do
			if self.Options.FrameClassColor then
				local _, _, name = entry.data.name:find("(.+) %(%d%)")
				local class
				for i = 1, GetNumRaidMembers() do
					local name2, _, _, _, _, fileName = GetRaidRosterInfo(i)
					if name2 == name then
						class = fileName
						break
					end
				end
				local r, g, b = 1, 0.7, 0
				if self.Options.FrameClassColor then
					if RAID_CLASS_COLORS[class or ""] then
						r = RAID_CLASS_COLORS[class].r
						g = RAID_CLASS_COLORS[class].g
						b = RAID_CLASS_COLORS[class].b
					end
				end
				entry:GetBar():SetStatusBarColor(r, g, b)
				entry:GetSpark():SetVertexColor(r, g, b)
			else
				entry:GetBar():SetStatusBarColor(1, 0.7, 0)
				entry:GetSpark():SetVertexColor(1, 0.7, 0)
			end
			entry = entry:GetNext()
		end
	end
end

function Kil:AddEntry(name, class)
	local entry = createBar(name)
	local r, g, b = 1, 0.7, 0
	if self.Options.FrameClassColor then
		if RAID_CLASS_COLORS[class or ""] then
			r = RAID_CLASS_COLORS[class].r
			g = RAID_CLASS_COLORS[class].g
			b = RAID_CLASS_COLORS[class].b
		end
	end
	entry:GetBar():SetStatusBarColor(r, g, b)
	entry:GetSpark():SetVertexColor(r, g, b)
	entry:SetPosition()
end

function Kil:RemoveEntry(name)
	if firstEntry then
		local entry = firstEntry
		while entry do
			if entry.data.name == name then
				table.insert(frames, entry.data.frame)
				entry.data.frame:Hide()
				entry.data = nil
				if entry == firstEntry then
					local nextEntry = entry:GetNext()
					if nextEntry then
						nextEntry.prev = nil
						firstEntry = nextEntry
					else
						firstEntry = nil
						lastEntry = nil
					end
				elseif entry == lastEntry then
					local prevEntry = entry:GetPrev()
					if prevEntry then
						prevEntry.next = nil
						lastEntry = prevEntry
					else
						firstEntry = nil
						lastEntry = nil
					end
				else
					entry:GetPrev().next = entry:GetNext()
					entry:GetNext().prev = entry:GetPrev()
				end
				if entry:GetNext() then
					entry:GetNext():SetPosition()
				end
				break
			end
			entry = entry:GetNext()
		end
	end
end
