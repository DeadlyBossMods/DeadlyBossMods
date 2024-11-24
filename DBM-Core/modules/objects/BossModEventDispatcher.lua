---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")

---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")

local type = type

local function handleEvent(self, event, ...)
	local handlers = self.directEvents[event]
	if handlers then
		-- TODO: support UNIT_ events with some kind of reasonable filtering (by creature IDs?)
		local arg1, _, _, _, _, _, _, _, arg9 = ...
		local spellId = type(arg1) == "table" and arg1.spellId or arg9
		for _, handler in ipairs(handlers) do
			if handler.unfiltered or handler[spellId] then
				handler.func(self, ...)
			end
		end
	end
end

---@alias DBMModEventHandler fun(mod: DBMMod, args: DBMCombatLogArgs)

-- Register a single event to a directly attached handler as an in-combat event.
---@param event DBMEvent
---@param eventArg string|number?
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
	local eventArgHandler = {func = handler}
	if eventArg then
		local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = string.split(" ", tostring(eventArg), 8)
		if arg8 and arg8:find(" ") then
			for _, v in ipairs{string.split(" ", tostring(eventArg))} do
				eventArgHandler[tonumber(v) or v] = true
			end
		else
			if arg1 then eventArgHandler[tonumber(arg1) or arg1] = true end
			if arg2 then eventArgHandler[tonumber(arg2) or arg2] = true end
			if arg3 then eventArgHandler[tonumber(arg3) or arg3] = true end
			if arg4 then eventArgHandler[tonumber(arg4) or arg4] = true end
			if arg5 then eventArgHandler[tonumber(arg5) or arg5] = true end
			if arg6 then eventArgHandler[tonumber(arg6) or arg6] = true end
			if arg7 then eventArgHandler[tonumber(arg7) or arg7] = true end
			if arg8 then eventArgHandler[tonumber(arg8) or arg8] = true end
		end
	else
		eventArgHandler.unfiltered = true
	end
	handlers[#handlers + 1] = eventArgHandler
	self.OnEvent = handleEvent
	self:RegisterEventsInCombat(event .. (eventArg and (" " .. eventArg) or ""))
end

-- Register a single raw event to a directly attached handler as an in-combat event.
---@type fun(self: DBMMod, event: DBMEvent, eventArg: string|number?, handler: fun(mod: DBMMod, ...))
bossModPrototype.RegisterRawEvent = bossModPrototype.RegisterEvent

-- These two only differ in the type signature, if these end up being used more we should support this a bit better via a LuaLS plugin
