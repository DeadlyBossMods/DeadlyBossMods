---@class DBM
local DBM = DBM

-- For any new sorting functions: They should define a total order, i.e., no two different elements can be considered the same order
-- In other words, if a ~= b then either sort(a, b) or sort(b, a) must return true (but not both)
-- This is necessary because table.sort is not a stable sorting algorithm, so elements that are considered equal may be swapped randomly which doesn't look good
-- The easiest way to achieve this is to just fall back to alphabetical ordering, raid index ordering (while technically not a total order) is also good enough

function DBM.SortByGroup(v1, v2)
	return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
end

function DBM.SortByTankAlpha(v1, v2)
	--Tank > Melee > Ranged prio, and if two of any of types, alphabetical names are preferred
	if DBM:IsTanking(v1) and not DBM:IsTanking(v2) then
		return true
	elseif DBM:IsTanking(v2) and not DBM:IsTanking(v1) then
		return false
	elseif DBM:IsMelee(v1) and not DBM:IsMelee(v2) then
		return true
	elseif DBM:IsMelee(v2) and not DBM:IsMelee(v1) then
		return false
	else
		return DBM:GetUnitFullName(v1) < DBM:GetUnitFullName(v2)
	end
end

function DBM.SortByTankRoster(v1, v2)
	--Tank > Melee > Ranged prio, and if two of any of types, roster index as secondary
	if DBM:IsTanking(v1) and not DBM:IsTanking(v2) then
		return true
	elseif DBM:IsTanking(v2) and not DBM:IsTanking(v1) then
		return false
	elseif DBM:IsMelee(v1) and not DBM:IsMelee(v2) then
		return true
	elseif DBM:IsMelee(v2) and not DBM:IsMelee(v1) then
		return false
	else
		return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
	end
end

function DBM.SortByMeleeAlpha(v1, v2)
	--Pro melee over non melee, and if two of any of types, alphabetical names are preferred
	if DBM:IsMelee(v1) and not DBM:IsMelee(v2) then
		return true
	elseif DBM:IsMelee(v2) and not DBM:IsMelee(v1) then
		return false
	else
		return DBM:GetUnitFullName(v1) < DBM:GetUnitFullName(v2)
	end
end

function DBM.SortByMeleeRoster(v1, v2)
	--Prio melee over ranged, and if two of any of types, roster index as secondary
	if DBM:IsMelee(v1) and not DBM:IsMelee(v2) then
		return true
	elseif DBM:IsMelee(v2) and not DBM:IsMelee(v1) then
		return false
	else
		return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
	end
end

function DBM.SortByRangedAlpha(v1, v2)
	--Prio ranged over melee, and if two of any of types, alphabetical names are preferred
	if DBM:IsRanged(v1) and not DBM:IsRanged(v2) then
		return true
	elseif DBM:IsRanged(v2) and not DBM:IsRanged(v1) then
		return false
	else
		return DBM:GetUnitFullName(v1) < DBM:GetUnitFullName(v2)
	end
end

function DBM.SortByRangedRoster(v1, v2)
	-- Ranged first, then everything else
	if DBM:IsRanged(v1) and not DBM:IsRanged(v2) then
		return true
	elseif DBM:IsRanged(v2) and not DBM:IsRanged(v1) then
		return false
	else
		return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
	end
end

function DBM.SortByMeleeRangedHealer(v1, v2)
	--melee non healer > ranged non healer > melee healer, ranged healer and if two of any of types, roster index as secondary
	--Healer vs non healer prio the NON healer (inverse the usual checks)
	if DBM:IsHealer(v1) and not DBM:IsHealer(v2) then
		return false
	elseif DBM:IsHealer(v2) and not DBM:IsHealer(v1) then
		return true
	--melee vs non melee prio the melee
	elseif DBM:IsMelee(v1) and not DBM:IsMelee(v2) then
		return true
	elseif DBM:IsMelee(v2) and not DBM:IsMelee(v1) then
		return false
	--If check got this far, it's not a healers vs non healer or melee vs non melee, so at this point we're at
	--melee vs melee, ranged vs ranged, or healer vs healer. In this case, we just use roster index
	else
		return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
	end
end

function DBM.SortByTankDpsHealerRoster(v1, v2)
	--Tank > DPS > Healer prio, and if two of any of types, roster index as secondary
	if DBM:IsTanking(v1) and not DBM:IsTanking(v2) then
		return true
	elseif DBM:IsTanking(v2) and not DBM:IsTanking(v1) then
		return false
	elseif DBM:IsHealer(v1) and not DBM:IsHealer(v2) then
		return false
	elseif DBM:IsHealer(v2) and not DBM:IsHealer(v1) then
		return true
	else
		return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
	end
end

function DBM.SortByTankHealerDpsRoster(v1, v2)
	--Tank > Healer > DPS prio, and if two of any of types, roster index as secondary
	if DBM:IsTanking(v1) and not DBM:IsTanking(v2) then
		return true
	elseif DBM:IsTanking(v2) and not DBM:IsTanking(v1) then
		return false
	elseif DBM:IsHealer(v1) and not DBM:IsHealer(v2) then
		return true
	elseif DBM:IsHealer(v2) and not DBM:IsHealer(v1) then
		return false
	else
		return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
	end
end

function DBM.SortByTankHealerSplitDpsRoster(v1, v2)
	--Tank > Healer > Melee DPS, Ranged DPS, and if two of any of types, roster index as secondary
	if DBM:IsTanking(v1) and not DBM:IsTanking(v2) then
		return true
	elseif DBM:IsTanking(v2) and not DBM:IsTanking(v1) then
		return false
	elseif DBM:IsHealer(v1) and not DBM:IsHealer(v2) then
		return true
	elseif DBM:IsHealer(v2) and not DBM:IsHealer(v1) then
		return false
	--melee vs non melee prio the melee
	elseif DBM:IsMelee(v1) and not DBM:IsMelee(v2) then
		return true
	elseif DBM:IsMelee(v2) and not DBM:IsMelee(v1) then
		return false
	else
		return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
	end
end
