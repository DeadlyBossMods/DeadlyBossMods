local _, private = ...

local isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)

local tinsert, twipe = table.insert, table.wipe

---------------
-- Prototype --
---------------
local modulePrototype = {}

function modulePrototype:RegisterEvents(...)
	local function HandleEvent(_, event, ...)
		local handler = self[event]
		if handler then
			handler(self, ...)
		end
	end

	for _, event in ipairs({...}) do
		if event:sub(0, 5) == "UNIT_" then
			local eventData = {strsplit(" ", event)}
			if eventData[1]:sub(-11) == "_UNFILTERED" then
				self.frame:RegisterEvent(eventData[1]:sub(0, -12))
			else
				if #eventData < 2 then
					eventData = {eventData[1], "boss1", "boss2", "boss3", "boss4", "boss5", "target"}
					if isRetail then
						tinsert(eventData, "focus")
					end
				end
				for i = 2, #eventData do
					local unitId = eventData[i]
					local frame = self.unitFrames[unitId]
					if not frame then
						frame = CreateFrame("Frame")
						if unitId == "mouseover" then
							frame:SetScript("OnEvent", function(_, event, _, ...)
								HandleEvent(nil, event, "mouseover", ...)
							end)
						else
							frame:SetScript("OnEvent", HandleEvent)
						end
						self.unitFrames[unitId] = frame
					end
					frame:RegisterUnitEvent(eventData[1], unitId)
				end
			end
		else
			self.frame:RegisterEvent(event)
		end
	end
end

function modulePrototype:RegisterShortTermEvents(...)
	self:RegisterEvents(...)
	for _, event in ipairs({...}) do
		tinsert(self.shortTermEvents, event)
	end
end

function modulePrototype:UnregisterShortTermEvents()
	for _, event in ipairs(self.shortTermEvents) do
		if event:sub(0, 5) == "UNIT_" and event:sub(-11) ~= "_UNFILTERED" then
			local eventData = {strsplit(" ", event)}
			if #eventData < 2 then
				eventData = {eventData[1], "boss1", "boss2", "boss3", "boss4", "boss5", "target"}
				if isRetail then
					tinsert(eventData, "focus")
				end
			end
			local eventName = eventData[1]
			for i = 2, #eventData do
				if self.unitFrames[eventData[i]] then
					self.unitFrames[eventData[i]]:UnregisterEvent(eventName)
				end
			end
		elseif event:sub(-11) == "_UNFILTERED" then
			self.frame:UnregisterEvent(event:sub(0, -12))
		else
			self.frame:UnregisterEvent(event)
		end
	end
	twipe(self.shortTermEvents)
end

-------------
-- Modules --
-------------
local modules = {}

function private:NewModule(name)
	if modules[name] then
		error("DBM:NewModule(): Module names must be unique", 2)
	end
	local frame = CreateFrame("Frame", "DBM" .. name)
	local obj = setmetatable({
		frame = frame,
		unitFrames = {},
		shortTermEvents = {}
	}, {
		__index = modulePrototype
	})
	frame:SetScript("OnEvent", function(_, event, ...)
		if event:sub(0, 5) == "UNIT_" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED" then
			-- UNIT_* events that come from mainFrame are _UNFILTERED variants and need their suffix
			event = event .. "_UNFILTERED"
		end
		local handler = obj[event]
		if handler then
			handler(obj, ...)
		end
	end)
	modules[name] = obj
	return obj
end

function private:GetModule(name)
	return modules[name]
end

--Needed in certain cases where we need to initialize module stuff after DBM Core loads
function private:OnModuleLoad()
	for _, mod in pairs(modules) do
		if mod.OnModuleLoad then
			mod:OnModuleLoad()
		end
	end
end

--As more and more of DBM core gets modulized, it'd be a large waste of memory to store each and every modules tables in private.
--Therefor, modules tables should be localized and use this method (which is called in EndCombat in DBM Core)
--This will wipe module tables that can't wipe themselves when their functions get terminated early
function private:ClearModuleTasks()
	for _, mod in pairs(modules) do
		if mod.OnModuleEnd then
			mod:OnModuleEnd()
		end
	end
end
