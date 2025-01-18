local filter = DBM.Test.CreateSharedModule("Data.Transcriptor-Filter")

local function set(tbl)
	local r = {}
	for _, v in ipairs(tbl) do
		r[v] = true
	end
	return r
end

-- Very incomplete list of spammy events we don't care about.
-- Quick way to find potential IDs to add here:
-- lua ParseTranscriptor.lua --transcriptor log.lua --show-ignore-candidates
-- lua ParseTranscriptor.lua --transcriptor log.lua | grep "SPELL_CAST" | cut -d, -f 4-6 | sort | uniq -c | sort -k1 -g -r
-- lua ParseTranscriptor.lua --transcriptor log.lua | grep "SPELL_AURA" | cut -d, -f 12-14 | sort | uniq -c | sort -k1 -g -r
-- lua ParseTranscriptor.lua --transcriptor log.lua | grep "UNIT_DESTROYED" | cut -d, -f 6-7 | sort | uniq -c | sort -k1 -g -r

filter.ignoredSpellIds = set{
	448995, -- Rune Scrying, barriers in SoD Sunken Temple
	401962, -- SW: D
	458016, -- Oversized Totems
}

filter.ignoredCreatureIds = set{
	2523, 3904, 7400, 7402, -- Searing Totem
	7465, 7466, -- Magma Totem
	7844, 7466, 7845, -- Fire Nova Totem
	7468, -- Nature Resistance Totem
	7425, -- Fire Resistance Totem
	5913, -- Tremor Totem
	7483, -- Windfury Totem
	11101, -- Mana Tide Totem
	5922, 7403, -- Strength of Earth Totem
	7486, 7487, -- Grace of Air Totem
	5924, -- Disease Cleansing Totem
	11100, -- Mana Tide Totem
	3908, -- Healing Stream Totem
	59764, -- Healing Tide Totem
	7415, -- Mana Spring Totem
	2630, -- Earthbind Totem
	225409, 225409, -- Surging Totem
	202079, 19668, -- Shadowfiend
	202390, 202391, 202392, -- Homunculus
	224466, -- Voidwraith
	217429, -- Overfiend
	202387, -- Eye of the void
	164874, -- Immolation Trap
	164879, -- Explosive Trap
	164639, -- Frost Trap
	164876, -- Freezing Trap
	69792, -- Earth Spirit
	95072, -- Greater Earth Elemental
	31216, -- Mirror Image
	98035, -- Dreadstalker
	100820, -- Spirit Wolf
	224764, -- Brightstone
	224756, -- Boulderbane
	165374, -- Yu'lon
	17252, -- Felguard
	89, -- Infernal
	103673, -- Darkglare
	63508, -- Xuen
	228108, -- Beast
	226269, -- Charhound
	103822, -- Treant
	69791, -- Fire Spirit
	416, -- Imp
	55659, 143622, -- Wild Imp
	135002, -- Demonic Tyrant
	192337, -- Void Tendril
	17252, -- Felguard
	1863, -- Succubus
	198489, -- Denizen of the Dream
	228224, -- Fenryr
	228226, -- Hati
	26125, -- Risen Ghoul
	77942, -- Primal Storm Elemental
	149555, -- Abomination
	163366, -- Magus of the Dead
	24207, -- Army of the Dead
	221632, -- Highlord Darion Mograine
	221633, -- High Inquisitor Whitemane
	221634, -- Nazgrim
	221635, -- King Thoras Trollbane
	217228, -- Blood Beast
	54983, -- Treant
	212489, 219986, -- Spirit Wolf
	61029, -- Primal Fire Elemental
	61056, -- Primal Earth Elemental
	226268, -- Gloomhound
	229799, -- Lesser Primal Fire Elemental
	62982, -- Mindbender
	73967, -- Niuzao
	95061, -- Greater Fire Elemental
	180743, -- Niuzao
	229800, -- Lesser Fire Elemental
	225493, -- Doomguard
	204346, -- Treant
	16506, -- Naxxramas Worshipper
	110063, -- Beast
	219161, -- Diabolic Imp
	233039, -- Spirit Wolf
	234018, -- Bear
	62005, -- Beast
	237409, -- Army of the Dead
}

-- SoD Naxx hard mode ignores to keep these logs reasonably sized

-- Friendly spiders that spawn from the Spider affix
filter.ignoredCreatureIds[237969] = true
-- Buff that spawns these spiders
filter.ignoredSpellIds[1218216] = true

return filter
