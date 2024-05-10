local filter = {}

local function set(tbl)
	local r = {}
	for _, v in ipairs(tbl) do
		r[v] = true
	end
	return r
end

-- Very incomplete list of spammy events we don't care about.
-- Quick way to find IDs to add here:
-- lua ParseTranscriptor.lua --transcriptor log.lua | grep "SPELL_CAST" | cut -d, -f 6-8 | sort | uniq -c | sort -k1 -g -r
-- lua ParseTranscriptor.lua --transcriptor log.lua | grep "SPELL_AURA" | cut -d, -f 14-16 | sort | uniq -c | sort -k1 -g -r

filter.ignoredSpellIds = set{
	448995, -- Rune Scrying, barriers in SoD Sunken Temple
	401962, -- SW: D
}

filter.ignoredCreatureIds = set{
	7400, -- Searing Totem
	7465, -- Magma Totem
	7844, -- Fire Nova Totem
	202079, -- Shadowfiend
	202390, 202391, 202392, -- Homunculus
	202387, -- Eye of the void
	3908, -- Healing Stream Totem
	7415, -- Mana Spring Totem
	164874, -- Immolation Trap
	164639, -- Frost Trap
}




return filter
