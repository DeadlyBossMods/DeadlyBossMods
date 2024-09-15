DBM = {}
require "Sorting"

local fakeUnits = {
}

local count = 1
local function defineUnit(name, def)
	if def.raidUnitId == nil then
		def.raidUnitId = count
		count = count + 1
	end
	fakeUnits[name] = def
end

function DBM:GetUnitFullName(uId)
	return "Name" .. uId
end

function DBM:GetGroupId(name, higher)
	assert(name:match("^Name"), "GetGroupId expects a name, not uId")
	local uId = name:sub(#"Name" + 1)
	return fakeUnits[uId].raidUnitId or higher and 99 or 0
end

function DBM:IsMelee(uId)
	return fakeUnits[uId].melee
end

function DBM:IsTanking(uId)
	return fakeUnits[uId].tanking
end

function DBM:IsRanged(uId)
	return fakeUnits[uId].ranged
end

function DBM:IsHealer(uId)
	return fakeUnits[uId].healer
end

local function checkOrder(funcName, ...)
	local func = DBM[funcName]
	local gotOrder = {}
	for k in pairs(fakeUnits) do
		gotOrder[#gotOrder + 1] = k
	end
	table.sort(gotOrder, func)
	for k, v in ipairs(gotOrder) do gotOrder[k] = ("%q"):format(v) end
	print(funcName .. ": " .. table.concat(gotOrder, ", "))
	for i1 = 1, select("#", ...) do
		local uId1 = select(i1, ...)
		for i2 = 1, select("#", ...) do
			local uId2 = select(i2, ...)
			if i1 ~= i2 then
				local got = not not func(uId1, uId2)
				local gotReverse = not not func(uId2, uId1)
				if got ~= (i1 < i2) then
					 -- table.sort() is not stable, so we require sorting functions to define a total order
					if not got and not gotReverse then
						error(("ordering between %q and %q is not fully defined, both %q < %q and %q < %q are false"):format(uId1, uId2, uId1, uId2, uId2, uId1), 2)
					else
						error(("unexpected order for %q < %q, got %s, expected %s"):format(uId1, uId2, tostring(got), tostring(i1 < i2)), 2)
					end
				end
				if got and gotReverse then -- can't have both orders return true, equal elements must both return false
					error(("both %q < %q and %q < %q are true"):format(uId1, uId2, uId2, uId1), 2)
				end
			end
		end
	end
end

defineUnit("Melee1",   {melee =  true, ranged = false, healer = false, tanking = false})
defineUnit("Melee2",   {melee =  true, ranged = false, healer = false, tanking = false})
defineUnit("Ranged1",  {melee = false, ranged =  true, healer = false, tanking = false})
defineUnit("Ranged2",  {melee = false, ranged =  true, healer = false, tanking = false})
defineUnit("MTank1",   {melee =  true, ranged = false, healer = false, tanking =  true})
defineUnit("MTank2",   {melee =  true, ranged = false, healer = false, tanking =  true})
defineUnit("RTank1",   {melee = false, ranged =  true, healer = false, tanking =  true})
defineUnit("RTank2",   {melee = false, ranged =  true, healer = false, tanking =  true})
defineUnit("Healer1",  {melee = false, ranged =  true, healer =  true, tanking = false})
defineUnit("Healer2",  {melee = false, ranged =  true, healer =  true, tanking = false})
defineUnit("MHealer1", {melee =  true, ranged = false, healer =  true, tanking = false})
defineUnit("MHealer2", {melee =  true, ranged = false, healer =  true, tanking = false})
-- Alphabetical order: Healer, MHealer, MTank, Melee, RTank, Ranged

-- TODO: many of these seem to consider melee healers as melee, is this right?
checkOrder("SortByGroup", "Melee1",  "Melee2", "Ranged1", "Ranged2", "MTank1", "MTank2")
checkOrder("SortByTankAlpha", "MTank1", "MTank2", "RTank1", "RTank2", "MHealer1", "MHealer2", "Melee1", "Melee2", "Healer1", "Healer2", "Ranged1", "Ranged2")
checkOrder("SortByTankRoster", "MTank1", "MTank2", "RTank1", "RTank2", "Melee1", "Melee2", "MHealer1", "MHealer2", "Ranged1", "Ranged2", "Healer1", "Healer2")
checkOrder("SortByMeleeAlpha", "MHealer1", "MHealer2", "MTank1", "MTank2", "Melee1", "Melee2", "Healer1", "Healer2", "RTank1", "RTank2", "Ranged1", "Ranged2")
checkOrder("SortByMeleeRoster", "Melee1", "Melee2", "MTank1", "MTank2", "MHealer1", "MHealer2", "Ranged1", "Ranged2", "RTank1", "RTank2", "Healer1", "Healer2")
checkOrder("SortByRangedAlpha", "Healer1", "Healer2", "RTank1", "RTank2", "Ranged1", "Ranged2", "MHealer1", "MHealer2", "MTank1", "MTank2", "Melee1", "Melee2")
checkOrder("SortByRangedRoster", "Ranged1", "Ranged2", "RTank1", "RTank2", "Healer1", "Healer2", "Melee1", "Melee2", "MTank1", "MTank2", "MHealer1", "MHealer2")
checkOrder("SortByMeleeRangedHealer", "Melee1", "Melee2", "MTank1", "MTank2", "Ranged1", "Ranged2", "RTank1", "RTank2", "MHealer1", "MHealer2", "Healer1", "Healer2")
