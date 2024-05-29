---@class DBMCoreNamespace
local private = select(2, ...)
DBMExtraGlobal = {}

---@alias SpecFlag
---|"Tank"
---|"Dps"
---|"Healer"
---|"Melee" ANY melee, including tanks or healers that are 100% excempt from healer/ranged mechanics (like mistweaver monks)
---|"MeleeDps"
---|"Physical"
---|"Ranged" ANY ranged, healer and DPS included
---|"RangedDps" Only ranged DPS
---|"ManaUser" Affected by things like mana drains, or mana detonation, etc
---|"SpellCaster" Has channeled casts, can be interrupted/spell locked by roars, etc, include healers. Use CasterDps if dealing with reflect
---|"CasterDps" Ranged DPS that uses spells, relevant for spell reflect type abilities that only reflect spells but not ranged physical such as hunters
---|"RaidCooldown"
---|"RemovePoison" From ally
---|"RemoveDisease" From ally
---|"RemoveCurse" From ally
---|"RemoveMagic" From ally
---|"RemoveEnrage" Can remove enemy enrage. returned in 8.x+!
---|"MagicDispeller" From ENEMY, not debuffs on players. use "Healer" or "RemoveMagic" for ally magic dispels. ALL healers can do that on retail, and warlock Imps
---|"ImmunityDispeller" Priest mass dispel or Warrior Shattering Throw (shadowlands)
---|"HasInterrupt" Has an interrupt that is 24 seconds or less CD that is BASELINE (not a talent)
---|"HasImmunity" Has an immunity that can prevent or remove a spell effect (not just one that reduces damage like turtle or dispursion)

-- Format: SpecFlag or SpecFlag|SpecFlag|...
---@alias SpecFlags SpecFlag|string

---@type table<string|number, table<SpecFlag, boolean>>
local specRoleTable
-- Caution: the keys used below are not validated by LuaLS at the moment due to https://github.com/LuaLS/lua-language-server/issues/2610

--Upvalued because it's called frequently each time rebuildSpecTable is called
local IsSpellKnown = IsSpellKnown

function DBMExtraGlobal:rebuildSpecTable()
	-- Retail
	if private.isRetail then
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
	elseif private.isCata then--Cata and later needs custom section since it also now supports specIDs which we want to use instead of Era compat code, for libspec compatability
		specRoleTable = {
			[799] = {	--Arcane Mage
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
			[831] = {	--Holy Paladin
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
			[839] = {	--Protection Paladin
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
			[855] = {	--Retribution Paladin
				["Tank"] = private.isClassic and true or false,
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
			[746] = {	--Arms Warrior
				["Dps"] = true,
				["Tank"] = false,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
			},
			[845] = {	--Protection Warrior
				["Tank"] = true,
				["Melee"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
				["MagicDispeller"] = (IsSpellKnown(23922) or IsSpellKnown(23923) or IsSpellKnown(23924) or IsSpellKnown(23925) or IsSpellKnown(25258) or IsSpellKnown(30356)),--Shield Slam
			},
			[752] = {	--Balance Druid
				["Healer"] = false,
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,
				["RemoveCurse"] = true,
			},
			[750] = { --Feral Druid
				["Healer"] = false,
				["Dps"] = true,
				["Tank"] = IsPlayerSpell(23922) and true or false,--Only sets true if Nuturing Instinct is learned for non vanilla
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["RemoveCurse"] = true,
			},
			[748] = { -- Restoration Druid
				["Healer"] = true,
				["Ranged"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["RaidCooldown"] = true,--Tranquility
				["RemoveCurse"] = true,
			},
			[811] = {	--Beastmaster Hunter
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["Physical"] = true,
				["RemoveEnrage"] = true,
				["ManaUser"] = true,
			},
			[807] = {	--Markmanship Hunter Hunter
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["Physical"] = true,
				["RemoveEnrage"] = true,
				["ManaUser"] = true,
			},
			[809] = {	--Survival Hunter
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["Physical"] = true,
				["RemoveEnrage"] = true,
				["ManaUser"] = true,
			},
			[760] = {	--Discipline Priest
				["Healer"] = true,
				["Ranged"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,--Iffy. Technically yes, but this can't be used to determine eligable target for dps only debuffs
				["RaidCooldown"] = true,--Power Word: Barrier(Discipline) / Divine Hymn (Holy)
				["MagicDispeller"] = true,
				["RemoveMagic"] = true,
			},
			[795] = {	--Shadow Priest
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,
				["MagicDispeller"] = true,
				["RemoveMagic"] = true,
			},
			[182] = { --Assassination Rogue
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
			},
			[261] = {	--Elemental Shaman
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,
				["HasInterrupt"] = true,
				["MagicDispeller"] = true,
			},
			[263] = {	--Enhancement Shaman
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				--["CasterDps"] = true,??
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
				["MagicDispeller"] = true,
			},
			[262] = {	--Restoration Shaman
				["Healer"] = true,
				["Ranged"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["HasInterrupt"] = true,
				["MagicDispeller"] = true,
			},
			[871] = { --Affliction Warlock
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,
			},
			[398] = {--Blood DK
				["Tank"] = true,
				["Melee"] = true,
				["Dps"] = false,
				["MeleeDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
			},
			[399] = {--Frost DK
				["Tank"] = false,
				["Melee"] = true,
				["Dps"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
			},
			[400] = {--Unholy DK
				["Tank"] = false,
				["Melee"] = true,
				["Dps"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
			},
		}
		specRoleTable[823] = specRoleTable[799]--Frost Mage same as arcane
		specRoleTable[851] = specRoleTable[799]--Fire Mage same as arcane
		specRoleTable[815] = specRoleTable[746]--Fury Warrior same as Arms
		specRoleTable[813] = specRoleTable[760]--Holy Priest same as disc
		specRoleTable[181] = specRoleTable[182]--Combat Rogue same as Assassination
		specRoleTable[183] = specRoleTable[182]--Subtlety Rogue same as Assassination
		specRoleTable[867] = specRoleTable[871]--Demonology Warlock same as Affliction
		specRoleTable[865] = specRoleTable[871]--Destruction Warlock same as Affliction
	else--Vanilla and Wrath
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
				["Tank"] = private.isClassic and true or false,
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
				["Tank"] = private.isClassic and true or false,
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
				["Healer"] = private.isClassic and true or false,
				["Dps"] = true,
				["Ranged"] = true,
				["RangedDps"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["CasterDps"] = true,
				["RemoveCurse"] = true,
			},
			["DRUID2"] = { --Feral Druid
				["Healer"] = private.isClassic and true or false,
				["Dps"] = true,
				["Tank"] = IsPlayerSpell(23922) and true or private.isClassic and true or false,--Only sets true if Nuturing Instinct is learned for non vanilla
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
				["HasInterrupt"] = true,
				["MagicDispeller"] = true,
			},
			["SHAMAN2"] = {	--Enhancement Shaman
				["Dps"] = true,
				["Melee"] = true,
				["MeleeDps"] = true,
				--["CasterDps"] = true,??
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
				["MagicDispeller"] = true,
			},
			["SHAMAN3"] = {	--Restoration Shaman
				["Healer"] = true,
				["Ranged"] = true,
				["ManaUser"] = true,
				["SpellCaster"] = true,
				["HasInterrupt"] = true,
				["MagicDispeller"] = true,
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
				["Dps"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
			},
			["DEATHKNIGHT2"] = {--Just treat all DKs as all roles in wrath, they are hybrid as hell in wrath and any spec can be any role
				["Tank"] = true,
				["Melee"] = true,
				["Dps"] = true,
				["MeleeDps"] = true,
				["Physical"] = true,
				["HasInterrupt"] = true,
			},
			["DEATHKNIGHT3"] = {--Just treat all DKs as all roles in wrath, they are hybrid as hell in wrath and any spec can be any role
				["Tank"] = true,
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
