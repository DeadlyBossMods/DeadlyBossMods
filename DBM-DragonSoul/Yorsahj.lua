local mod	= DBM:NewMod(325, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(55312)
mod:SetModelID(39101)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_DIED"
)

local warnOozes			= mod:NewTargetAnnounce("ej3978", 4)
local warnOozesHit		= mod:NewAnnounce("warnOozesHit", 3, 16372)
local warnVoidBolt		= mod:NewStackAnnounce(108383, 3, nil, mod:IsTank() or mod:IsHealer())
local warnManaVoid		= mod:NewSpellAnnounce(105530, 3)

local specWarnOozes		= mod:NewSpecialWarningSpell("ej3978")
local specWarnVoidBolt	= mod:NewSpecialWarningStack(108383, mod:IsTank(), 3)
local specWarnManaVoid	= mod:NewSpecialWarningSpell(105530, mod:IsManaUser())
local specWarnPurple	= mod:NewSpecialWarningSpell(110748, mod:IsTank() or mod:IsHealer())

local timerOozesCD		= mod:NewNextTimer(90, "ej3978")
local timerOozesActive	= mod:NewTimer(7, "timerOozesActive", 16372) -- varies (7.0~8.5)
local timerAcidCD		= mod:NewNextTimer(8.3, 108352)--Green ooze aoe
local timerSearingCD	= mod:NewNextTimer(6, 108358)--Red ooze aoe
local timerVoidBoltCD	= mod:NewNextTimer(6, 108383, nil, mod:IsTank())
local timerVoidBolt		= mod:NewTargetTimer(21, 108383, nil, mod:IsTank() or mod:IsHealer())--Tooltip says 30 but combat logs clearly show it fading at 20-22 (varies)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddBoolOption("RangeFrame", true)

local oozesHitTable = {}
local expectedOozes = 0
local yellowActive = false
local bossName = EJ_GetEncounterInfo(325)

local oozeColorsHeroic = {
	[105420] = { L.Purple, L.Green, L.Black, L.Blue },
	[105435] = { L.Green, L.Red, L.Blue, L.Black },
	[105436] = { L.Green, L.Yellow, L.Black, L.Red },
	[105437] = { L.Blue, L.Purple, L.Green, L.Yellow },
	[105439] = { L.Blue, L.Black, L.Purple, L.Yellow },
	[105440] = { L.Purple, L.Red, L.Yellow, L.Black },
}

local oozeColors = {
	[105420] = { L.Purple, L.Green, L.Blue },
	[105435] = { L.Green, L.Red, L.Black },
	[105436] = { L.Green, L.Yellow, L.Red },
	[105437] = { L.Purple, L.Blue, L.Yellow },
	[105439] = { L.Blue, L.Black, L.Yellow },
	[105440] = { L.Purple, L.Red, L.Black },
}

function mod:OnCombatStart(delay)
	table.wipe(oozesHitTable)
	timerVoidBoltCD:Start(-delay)
	timerOozesCD:Start(22-delay)
	berserkTimer:Start(-delay)
	yellowActive = false
	if self:IsDifficulty("heroic10", "heroic25") then
		expectedOozes = 4
	else
		expectedOozes = 3
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(104849, 108383, 108384, 108385) then--Do not add any other ID, these are tank IDs. Raid aoe IDs coul be added as an alternate timer somewhere else maybe.
		timerVoidBoltCD:Start()--Start CD off this not applied, that way we still get CD if a tank AMS's the debuff application.
	elseif args:IsSpellID(105530) then
		warnManaVoid:Show()
		specWarnManaVoid:Show()
	elseif args:IsSpellID(105573, 108350, 108351, 108352) and self:IsInCombat() then
		if yellowActive then
			timerAcidCD:Start(3.5)--Strangely, ths is 3.5 even though base CD is 8.3-8.5
		else
			timerAcidCD:Start()
		end
	elseif args:IsSpellID(105033, 108356, 108357, 108358) and args:GetSrcCreatureID() == 55312 then
		if yellowActive then
			timerSearingCD:Start(3.5)
		else
			timerSearingCD:Start()
		end
	end
end

--[[
Ooze Absorption and deaths WoL Expression
(spellid = 104896 or spellid = 104894 or spellid = 105027 or spellid = 104897 or spellid = 104901 or spellid = 104898) and targetMobId = 55312 or fulltype = UNIT_DIED and (targetMobId = 55862 or targetMobId = 55866 or targetMobId = 55865 or targetMobId = 55867 or targetMobId = 55864 or targetMobId = 55863)

Ooze Absorption and granted abilities expression (black adds only fire UNIT_SPELLCAST_SUCCEEDED Spawning Pool::0:105600 so we can't reg expression it)
(spellid = 104896 or spellid = 104894 or spellid = 105027 or spellid = 104897 or spellid = 104901 or spellid = 104898) and targetMobId = 55312 or fulltype = SPELL_CAST_SUCCESS and (spell = "Digestive Acid" or spell = "Mana Void" or spell = "Searing Blood" or spell = "Deep Corruption")
--]]
function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(104849, 108383, 108384, 108385) then
		warnVoidBolt:Show(args.destName, args.amount or 1)
		local _, _, _, _, _, duration, expires, _, _ = UnitDebuff(args.destName, args.spellName)--Try to fix some stupidness in this timer having a 20-22second variation.
		timerVoidBolt:Start(duration, args.destName)
		if (args.amount or 1) >= 3 and args:IsPlayer() then
			specWarnVoidBolt:Show(args.amount)
		end
	elseif args:IsSpellID(104901) and args:GetDestCreatureID() == 55312 then--Yellow
		table.insert(oozesHitTable, L.Yellow)
		warnOozesHit:Cancel()
		if #oozesHitTable == expectedOozes then--All of em absorbed
			warnOozesHit:Show(bossName, table.concat(oozesHitTable, ", "))
		end
		yellowActive = true
	elseif args:IsSpellID(104896) and args:GetDestCreatureID() == 55312 then--Purple
		table.insert(oozesHitTable, L.Purple)
		warnOozesHit:Cancel()
		if #oozesHitTable == expectedOozes then--All of em absorbed
			warnOozesHit:Show(bossName, table.concat(oozesHitTable, ", "))
		end
		specWarnPurple:Show()
	elseif args:IsSpellID(105027) and args:GetDestCreatureID() == 55312 then--Blue
		table.insert(oozesHitTable, L.Blue)
		warnOozesHit:Cancel()
		if #oozesHitTable == expectedOozes then--All of em absorbed
			warnOozesHit:Show(bossName, table.concat(oozesHitTable, ", "))
		end
	elseif args:IsSpellID(104897) and args:GetDestCreatureID() == 55312 then--Red
		table.insert(oozesHitTable, L.Red)
		warnOozesHit:Cancel()
		if #oozesHitTable == expectedOozes then--All of em absorbed
			warnOozesHit:Show(bossName, table.concat(oozesHitTable, ", "))
		end
	elseif args:IsSpellID(104894) and args:GetDestCreatureID() == 55312 then--Black
		table.insert(oozesHitTable, L.Black)
		warnOozesHit:Cancel()
		if #oozesHitTable == expectedOozes then--All of em absorbed
			warnOozesHit:Show(bossName, table.concat(oozesHitTable, ", "))
		end
	elseif args:IsSpellID(104898) then--Green
		if args:GetSrcCreatureID() == 55312 then--Only trigger the actual acid spits off the boss getting buff, not the oozes spawning.
			table.insert(oozesHitTable, L.Green)
			warnOozesHit:Cancel()
			if #oozesHitTable == expectedOozes then--All of em absorbed
				warnOozesHit:Show(bossName, table.concat(oozesHitTable, ", "))
			end
		end
		if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then--Range finder outside boss check so we can open and close when green ooze spawns to pre spread.
			DBM.RangeCheck:Show(4)
		end
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(104849, 108383, 108384, 108385) then--104849, 108383 confirmed 10 and 25 man normal, other 2 drycoded from wowhead.
		timerVoidBolt:Cancel(args.destName)
	elseif args:IsSpellID(104901) and args:GetDestCreatureID() == 55312 then--Yellow Removed
		yellowActive = false
	elseif args:IsSpellID(104897) and args:GetDestCreatureID() == 55312 then--Red Removed
		timerSearingCD:Cancel()
	elseif args:IsSpellID(104898) then--Green Removed
		if args:GetDestCreatureID() == 55312 then
			timerAcidCD:Cancel()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end		

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellID)
	if not uId:find("boss") then return end--yor can apparently be boss 1 2 3 or 4. even though he's only boss, :o
	if oozeColors[spellID] then--It doesn't really matter which table/ID we check for, spellids are same, only matters in warning.
		table.wipe(oozesHitTable)
		specWarnOozes:Show()
		timerVoidBoltCD:Start(42)
		timerOozesActive:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			warnOozes:Show(table.concat(oozeColorsHeroic[spellID], ", "))
			timerOozesCD:Start(75)
			expectedOozes = 4
		else
			warnOozes:Show(table.concat(oozeColors[spellID], ", "))
			timerOozesCD:Start()
			expectedOozes = 3
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 55862 or cid == 55866 or cid == 55865 or cid == 55867 or cid == 55864 or cid == 55863 then--Oozes
		expectedOozes = expectedOozes - 1
	end
end