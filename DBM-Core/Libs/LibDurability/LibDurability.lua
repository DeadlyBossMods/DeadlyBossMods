
local LD = LibStub:NewLibrary("LibDurability", 1)
if not LD then return end -- No upgrade needed

-- Throttle times for separate channels
LD.throttleTable = LD.throttleTable or {
	["RAID"] = 0,
	["PARTY"] = 0,
	["INSTANCE_CHAT"] = 0,
}
LD.throttleSendTable = LD.throttleSendTable or {
	["RAID"] = 0,
	["PARTY"] = 0,
	["INSTANCE_CHAT"] = 0,
}
LD.callbackMap = LD.callbackMap or {}
LD.frame = LD.frame or CreateFrame("Frame")

local throttleTable = LD.throttleTable
local throttleSendTable = LD.throttleSendTable
local callbackMap = LD.callbackMap
local frame = LD.frame

local next, type, error, tonumber, format, match = next, type, error, tonumber, string.format, string.match
local Ambiguate, GetTime, GetInventoryItemDurability, IsInGroup, IsInRaid = Ambiguate, GetTime, GetInventoryItemDurability, IsInGroup, IsInRaid
local SendAddonMessage = C_ChatInfo.SendAddonMessage
local pName = UnitName("player")

local function GetDurability()
	local curTotal, maxTotal, broken = 0, 0, 0
	for i = 1, 18 do
		local curItemDurability, maxItemDurability = GetInventoryItemDurability(i)
		if curItemDurability and maxItemDurability then
			curTotal = curTotal + curItemDurability
			maxTotal = maxTotal + maxItemDurability
			if maxItemDurability > 0 and curItemDurability == 0 then
				broken = broken + 1
			end
		end
	end
	local percent = curTotal / maxTotal * 100
	return percent, broken
end
LD.GetDurability = GetDurability

C_ChatInfo.RegisterAddonMessagePrefix("Durability")
frame:SetScript("OnEvent", function(_, _, prefix, msg, channel, sender)
	if prefix == "Durability" and throttleTable[channel] then
		if msg == "R" then
			local t = GetTime()
			if t - throttleTable[channel] > 4 then
				throttleTable[channel] = t
				local percent, broken = GetDurability()
				SendAddonMessage("Durability", format("%d,%d", percent, broken), channel)
			end
			return
		end

		local percent, broken = match(msg, "^(%d+),(%d+)$")
		percent = tonumber(percent)
		broken = tonumber(broken)
		if percent and broken then
			for _,func in next, callbackMap do
				func(percent, broken, Ambiguate(sender, "none"), channel)
			end
		end
	end
end)
frame:RegisterEvent("CHAT_MSG_ADDON")

-- For automatic group handling, don't pass a channel. The order is INSTANCE_CHAT > RAID > GROUP.
function LD:RequestDurability(channel)
	if channel and not throttleSendTable[channel] then
		error("LibDurability: Incorrect channel type for :RequestDurability.")
	else
		if not channel and IsInGroup() then
			channel = IsInGroup(2) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY"
		end

		local percent, broken = GetDurability()
		for _,func in next, callbackMap do
			func(percent, broken, pName, channel) -- This allows us to show our own durability when not grouped
		end

		if channel then
			local t = GetTime()
			if t - throttleSendTable[channel] > 4 then
				throttleSendTable[channel] = t
				SendAddonMessage("Durability", "R", channel)
			end
		end
	end
end

function LD:Register(addon, func)
	if not addon or addon == LD then
		error("LibDurability: You must pass your own addon name or object to :Register.")
	end

	local t = type(func)
	if t == "string" then
		callbackMap[addon] = function(...) addon[func](addon, ...) end
	elseif t == "function" then
		callbackMap[addon] = func
	else
		error("LibDurability: Incorrect function type for :Register.")
	end
end

function LD:Unregister(addon)
	if not addon or addon == LD then
		error("LibDurability: You must pass your own addon name or object to :Unregister.")
	end
	callbackMap[addon] = nil
end

