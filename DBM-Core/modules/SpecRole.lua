local _, private = ...
DBMExtraGlobal = {}

local _, _, _, wowTOC = GetBuildInfo()
local isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)
local isCata = (wowTOC >= 40400) and (wowTOC < 50000)

--[[local specFlags ={
	["Tank"] = true,
	["Dps"] = true,
	["Healer"] = true,
	["Melee"] = true,--ANY melee, including tanks or healers that are 100% excempt from healer/ranged mechanics (like mistweaver monks)
	["MeleeDps"] = true,
	["Physical"] = true,
	["Ranged"] = true,--ANY ranged, healer and dps included
	["RangedDps"] = true,--Only ranged dps
	["ManaUser"] = true,--Affected by things like mana drains, or mana detonation, etc
	["SpellCaster"] = true,--Has channeled casts, can be interrupted/spell locked by roars, etc, include healers. Use CasterDps if dealing with reflect
	["CasterDps"] = true,--Ranged dps that uses spells, relevant for spell reflect type abilities that only reflect spells but not ranged physical such as hunters
	["RaidCooldown"] = true,
	["RemovePoison"] = true,--from ally
	["RemoveDisease"] = true,--from ally
	["RemoveCurse"] = true,--from ally
	["RemoveMagic"] = true,--from ally
	["RemoveEnrage"] = true,--Can remove enemy enrage. returned in 8.x+!
	["MagicDispeller"] = true,--from ENEMY, not debuffs on players. use "Healer" or "RemoveMagic" for ally magic dispels. ALL healers can do that on retail, and warlock Imps
	["ImmunityDispeller"] = true,--Priest mass dispel or Warrior Shattering Throw (shadowlands)
	["HasInterrupt"] = true,--Has an interrupt that is 24 seconds or less CD that is BASELINE (not a talent)
	["HasImmunity"] = true,--Has an immunity that can prevent or remove a spell effect (not just one that reduces damage like turtle or dispursion)
}]]

local specRoleTable

function DBMExtraGlobal:rebuildSpecTable()
	-- Retail
	if isRetail then
		specRoleTable = {
			[62] = {	--Arcane Mage
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,
				["MagicDispeller"] = true,
				["HasInterrupt"] = true,
				["HasImmunity"] = true,
				["RemoveCurse"] = true,
			},
			[1449] = {	--Initial Mage (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,
			},
			[65] = {	--Holy Paladin
				["Healer"] = true,
				["Ranged"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["RaidCooldown"] = true,--Devotion Aura
				["RemovePoison"] = true,
				["RemoveDisease"] = true,
				["RemoveMagic"] = true,
				["HasImmunity"] = true,
			},
			[66] = {	--Protection Paladin
				["Tank"] = true,
				["Melee"] = true,
				["ManaUser"] = true,
				["Physical"] = true,
				["RemovePoison"] = true,
				["RemoveDisease"] = true,
				["HasInterrupt"] = true,
				["HasImmunity"] = true,
			},
			[70] = {	--Retribution Paladin
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["ManaUser"] = true,
				["Physical"] = true,
				["RemovePoison"] = true,
				["RemoveDisease"] = true,
				["HasInterrupt"] = true,
				["HasImmunity"] = true,
			},
			[1451] = {	--Initial Paladin (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
				["Healer"] = true,
				["Tank"] = true,
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["ManaUser"] = true,
				["Physical"] = true,
				["SpellCaster"] = true,
			},
			[71] = {	--Arms Warrior
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["RaidCooldown"] = true,--Rallying Cry
				["Physical"] = true,
				["HasInterrupt"] = true,
				["ImmunityDispeller"] = IsSpellKnown(64382),
			},
			[73] = {	--Protection Warrior
				["Tank"] = true,
				["Melee"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
				["RaidCooldown"] = true,--Rallying Cry
				["ImmunityDispeller"] = IsSpellKnown(64382),
			},
			[1446] = {	--Initial Warrior (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
				["Tank"] = true,
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
			},
			[102] = {	--Balance Druid
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,
				["RemoveCurse"] = true,
				["RemovePoison"] = true,
				["RemoveEnrage"] = true,
			},
			[103] = {	--Feral Druid
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["RemoveCurse"] = true,
				["RemovePoison"] = true,
				["HasInterrupt"] = true,
				["RemoveEnrage"] = true,
			},
			[104] = {	--Guardian Druid
				["Tank"] = true,
				["Melee"] = true,
				["Physical"] = true,
				["RemoveCurse"] = true,
				["RemovePoison"] = true,
				["HasInterrupt"] = true,
				["RemoveEnrage"] = true,
			},
			[105] = {	-- Restoration Druid
				["Healer"] = true,
				["Ranged"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["RaidCooldown"] = true,--Tranquility
				["RemoveCurse"] = true,
				["RemovePoison"] = true,
				["RemoveEnrage"] = true,
				["RemoveMagic"] = true,
			},
			[1447] = {	-- Initial Druid (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
				["Tank"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["Healer"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
			},
			[250] = {	--Blood DK
				["Tank"] = true,
				["Melee"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
			},
			[251] = {	--Frost DK
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
			},
			[1455] = {	--Initial DK (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
				["Tank"] = true,
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
			},
			[253] = {	--Beastmaster Hunter
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
				["MagicDispeller"] = true,
				["RemoveEnrage"] = true,
			},
			[254] = {	--Markmanship Hunter Hunter
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
				["MagicDispeller"] = true,
				["RemoveEnrage"] = true,
			},
			[255] = {	--Survival Hunter (Legion+)
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
				["MagicDispeller"] = true,
				["RemoveEnrage"] = true,
			},
			[1448] = {	--Initial Hunter (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["Physical"] = true,
			},
			[256] = {	--Discipline Priest
				["Healer"] = true,
				["Ranged"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,--Iffy. Technically yes, but this can't be used to determine eligable target for dps only debuffs
				["RaidCooldown"] = true,--Power Word: Barrier(Discipline) / Divine Hymn (Holy)
				["RemoveDisease"] = true,
				["RemoveMagic"] = true,
				["MagicDispeller"] = true,
				["ImmunityDispeller"] = true,
			},
			[258] = {	--Shadow Priest
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,
				["MagicDispeller"] = true,
				["ImmunityDispeller"] = true,
				["HasInterrupt"] = true,
				["RemoveDisease"] = true,
			},
			[1452] = {	--Initial Priest (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
				["Dps"] = true,
				["Healer"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,
			},
			[259] = {	--Assassination Rogue
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
				["HasImmunity"] = true,
			},
			[1453] = {	--Initial Rogue (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
			},
			[262] = {	--Elemental Shaman
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,
				["RemoveCurse"] = true,
				["MagicDispeller"] = true,
				["HasInterrupt"] = true,
			},
			[263] = {	--Enhancement Shaman
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["Physical"] = true,
				["RemoveCurse"] = true,
				["MagicDispeller"] = true,
				["HasInterrupt"] = true,
			},
			[264] = {	--Restoration Shaman
				["Healer"] = true,
				["Ranged"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["RaidCooldown"] = true,--Spirit Link Totem
				["RemoveCurse"] = true,
				["RemoveMagic"] = true,
				["MagicDispeller"] = true,
				["HasInterrupt"] = true,
			},
			[1444] = {	--Initial Shaman (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
				["Healer"] = true,
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["Physical"] = true,
			},
			[265] = {	--Affliction Warlock
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
	--			["RemoveMagic"] = true,--Singe Magic (Imp)
				["CasterDps"] = true,
			},
			[1454] = {	--Initial Warlock (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,
			},
			[268] = {	--Brewmaster Monk
				["Tank"] = true,
				["Melee"] = true,
				["Physical"] = true,
				["RemovePoison"] = true,
				["RemoveDisease"] = true,
				["HasInterrupt"] = IsSpellKnown(116705),
			},
			[269] = {	--Windwalker Monk
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["RemovePoison"] = true,
				["RemoveDisease"] = true,
				["HasInterrupt"] = IsSpellKnown(116705),
			},
			[270] = {	--Mistweaver Monk
				["Healer"] = true,
				["Melee"] = true,
				["Ranged"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["RaidCooldown"] = true,--Revival
				["RemovePoison"] = true,
				["RemoveDisease"] = true,
				["RemoveMagic"] = true,
				["HasInterrupt"] = IsSpellKnown(116705),
			},
			[1450] = {	--Initial Monk (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
				["Tank"] = true,
				["Healer"] = true,
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["Ranged"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
			},
			[577] = {	--Havok Demon Hunter
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
				["MagicDispeller"] = true,
			},
			[581] = {	--Vengeance Demon Hunter
				["Tank"] = true,
				["Melee"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
				["MagicDispeller"] = true,
			},
			[1456] = {	--Initial Demon Hunter (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
				["Tank"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
			},
			[1467] = {	--Evoker Devastation
				["Dps"] = true,
				["CasterDps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["HasInterrupt"] = IsSpellKnown(351338),--Quell
				["RemovePoison"] = IsSpellKnown(365585),--Expunge. Must be specced
				["RemoveCurse"] = IsSpellKnown(374251),--Cauterizing Flame
				["RemoveDisease"] = IsSpellKnown(374251),--Cauterizing Flame
				["RemoveEnrage"] = IsSpellKnown(374346),--Overawe
			},
			[1468] = {	--Evoker Preservation
				["Healer"] = true,
				["Ranged"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["RemoveMagic"] = true,
				["RemovePoison"] = true,--Auto known
				["HasInterrupt"] = IsSpellKnown(351338),--Quell
				["RemoveCurse"] = IsSpellKnown(374251),--Cauterizing Flame
				["RemoveDisease"] = IsSpellKnown(374251),--Cauterizing Flame
				["RemoveEnrage"] = IsSpellKnown(374346),--Overawe
				["RaidCooldown"] = IsSpellKnown(363534),--Rewind
			},
			[1465] = {	--Evoker Initial (treated as both healer and dps for basic leveling purposes)
				["Dps"] = true,
				["CasterDps"] = true,
				["Healer"] = true,
				["Ranged"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
			},
		}
		specRoleTable[63] = specRoleTable[62]--Frost Mage same as arcane
		specRoleTable[64] = specRoleTable[62]--Fire Mage same as arcane
		specRoleTable[72] = specRoleTable[71]--Fury Warrior same as Arms
		specRoleTable[252] = specRoleTable[251]--Unholy DK same as frost
		specRoleTable[257] = specRoleTable[256]--Holy Priest same as disc
		specRoleTable[260] = specRoleTable[259]--Combat Rogue same as Assassination
		specRoleTable[261] = specRoleTable[259]--Subtlety Rogue same as Assassination
		specRoleTable[266] = specRoleTable[265]--Demonology Warlock same as Affliction
		specRoleTable[267] = specRoleTable[265]--Destruction Warlock same as Affliction
		specRoleTable[1473] = specRoleTable[1467]--Just map augmentation to devastation for now
	else
		local IsSpellKnown = IsSpellKnown

		specRoleTable = {
			["MAGE1"] = {	--Arcane Mage
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,
				["HasInterrupt"] = true,
				["HasImmunity"] = true,
				["RemoveCurse"] = true,
				["MagicDispeller"] = IsSpellKnown(30449),--Spellsteal in TBC+
			},
			["PALADIN1"] = {	--Holy Paladin
				["Healer"] = true,
				["Melee"] = true,--They melee when oom?
				["Ranged"] = true,
				["CasterDps"] = true,--Judgements, exorcism, etc
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["RaidCooldown"] = true,--Devotion Aura
				["RemovePoison"] = true,
				["RemoveDisease"] = true,
				["RemoveMagic"] = true,
				["HasImmunity"] = true,
			},
			["PALADIN2"] = {	--Protection Paladin
				["Tank"] = true,
				["Melee"] = true,
				["ManaUser"] = true,
				["Physical"] = true,
				["CasterDps"] = true,--Judgements, exorcism, etc
				["RemovePoison"] = true,
				["RemoveDisease"] = true,
				["RemoveMagic"] = true,
				["HasImmunity"] = true,
			},
			["PALADIN3"] = {	--Retribution Paladin
				["Tank"] = true,
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["CasterDps"] = true,--Judgements, exorcism, etc
				["ManaUser"] = true,
				["Physical"] = true,
				["RemovePoison"] = true,
				["RemoveDisease"] = true,
				["RemoveMagic"] = true,
				["HasImmunity"] = true,
			},
			["WARRIOR1"] = {	--Arms Warrior
				["Dps"] = true,
				["Tank"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
			},
			["WARRIOR3"] = {	--Protection Warrior
				["Tank"] = true,
				["Melee"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
				["MagicDispeller"] = (IsSpellKnown(23922) or IsSpellKnown(23923) or IsSpellKnown(23924) or IsSpellKnown(23925) or IsSpellKnown(25258) or IsSpellKnown(30356)),--Shield Slam
			},
			["DRUID1"] = {	--Balance Druid
				["Healer"] = true,
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,
				["RemoveCurse"] = true,
			},
			["DRUID2"] = { --Feral Druid
				["Healer"] = true,
				["Dps"] = true,
				["Tank"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["RemoveCurse"] = true,
			},
			["DRUID3"] = { -- Restoration Druid
				["Healer"] = true,
				["Ranged"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["RaidCooldown"] = true,--Tranquility
				["RemoveCurse"] = true,
			},
			["HUNTER1"] = {	--Beastmaster Hunter
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["Physical"] = true,
				["RemoveEnrage"] = true,
				["ManaUser"] = true,
			},
			["HUNTER2"] = {	--Markmanship Hunter Hunter
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["Physical"] = true,
				["RemoveEnrage"] = true,
				["ManaUser"] = true,
			},
			["HUNTER3"] = {	--Survival Hunter
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["Physical"] = true,
				["RemoveEnrage"] = true,
				["ManaUser"] = true,
			},
			["PRIEST1"] = {	--Discipline Priest
				["Healer"] = true,
				["Ranged"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,--Iffy. Technically yes, but this can't be used to determine eligable target for dps only debuffs
				["RaidCooldown"] = true,--Power Word: Barrier(Discipline) / Divine Hymn (Holy)
				["MagicDispeller"] = true,
				["RemoveMagic"] = true,
			},
			["PRIEST3"] = {	--Shadow Priest
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,
				["MagicDispeller"] = true,
				["RemoveMagic"] = true,
				["HasInterrupt"] = IsSpellKnown(15487),--Silence is a talent tree talent
			},
			["ROGUE1"] = { --Assassination Rogue
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
			},
			["SHAMAN1"] = {	--Elemental Shaman
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,
			},
			["SHAMAN2"] = {	--Enhancement Shaman
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				--["CasterDps"] = true,??
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["Physical"] = true,
			},
			["SHAMAN3"] = {	--Restoration Shaman
				["Healer"] = true,
				["Ranged"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
			},
			["WARLOCK1"] = { --Affliction Warlock
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,
			},
			["DEATHKNIGHT1"] = {--Just treat all DKs as all roles in wrath, they are hybrid as hell in wrath and any spec can be any role
				["Tank"] = true,
				["Melee"] = true,
				["Dps"] = isCata and false or true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
			},
			["DEATHKNIGHT2"] = {--Just treat all DKs as all roles in wrath, they are hybrid as hell in wrath and any spec can be any role
				["Tank"] = isCata and false or true,
				["Melee"] = true,
				["Dps"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
			},
			["DEATHKNIGHT3"] = {--Just treat all DKs as all roles in wrath, they are hybrid as hell in wrath and any spec can be any role
				["Tank"] = isCata and false or true,
				["Melee"] = true,
				["Dps"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
			},
		}
		specRoleTable["MAGE3"] = specRoleTable["MAGE1"]--Frost Mage same as arcane
		specRoleTable["MAGE2"] = specRoleTable["MAGE1"]--Fire Mage same as arcane
		specRoleTable["WARRIOR2"] = specRoleTable["WARRIOR1"]--Fury Warrior same as Arms
		specRoleTable["PRIEST2"] = specRoleTable["PRIEST1"]--Holy Priest same as disc
		specRoleTable["ROGUE2"] = specRoleTable["ROGUE1"]--Combat Rogue same as Assassination
		specRoleTable["ROGUE3"] = specRoleTable["ROGUE1"]--Subtlety Rogue same as Assassination
		specRoleTable["WARLOCK2"] = specRoleTable["WARLOCK1"]--Demonology Warlock same as Affliction
		specRoleTable["WARLOCK3"] = specRoleTable["WARLOCK1"]--Destruction Warlock same as Affliction
	end
	private.specRoleTable = specRoleTable
end
DBMExtraGlobal:rebuildSpecTable()--Initial build
