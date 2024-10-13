---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")

---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")

local function handleEvent(self, event, ...)
	local handlers = self.directEvents[event]
	if handlers then
		for _, handler in ipairs(handlers) do
			handler(self, ...)
		end
	end
end

---@alias DBMModEventHandler fun(mod: DBMMod, args: DBMCombatLogArgs)

-- Register a single event to a directly attached handler as an in-combat event.
---@overload fun(self: DBMMod, event: DBMEvent, handler: string|DBMModEventHandler)
---@param event DBMEvent
---@param eventArg string|number
---@param handler string|DBMModEventHandler
function bossModPrototype:RegisterEvent(event, eventArg, handler)
	if type(eventArg) == "function" then
		return self:RegisterEvent(event, nil, eventArg)
	end
	if type(handler) == "string" then
		handler = self[handler]
		if not handler then
			error("FIXME: lazy loading of string-typed event handlers is NYI", 2)
		end
	end
	if event:find(" ") then -- TODO: decide if we should support this for consistency, but feels hacky for a single-event string
		error("FIXME: event args must go into second parameter", 2)
	end
	self.directEvents = self.directEvents or {}
	local handlers = self.directEvents[event] or {}
	self.directEvents[event] = handlers
	handlers[#handlers + 1] = handler
	self.OnEvent = handleEvent
	self:RegisterEventsInCombat(event)
end
