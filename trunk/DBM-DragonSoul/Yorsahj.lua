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
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnOozes			= mod:NewTargetAnnounce("ej3978", 4)
local warnVoidBolt		= mod:NewStackAnnounce(108383, 3, nil, mod:IsTank() or mod:IsHealer())--Makes fight require 2 tanks? When properly tuned anyways.
local warnManaVoid		= mod:NewSpellAnnounce(105530, 3)

local specWarnOozes		= mod:NewSpecialWarningSpell("ej3978")
local specWarnVoidBolt	= mod:NewSpecialWarningStack(108383, mod:IsTank(), 3)
local specWarnManaVoid	= mod:NewSpecialWarningSpell(105530, mod:IsDps() or mod:IsManaUser())

local timerOozesCD		= mod:NewCDTimer(90, "ej3978")
local timerOozesActive	= mod:NewTimer(7, "timerOozesActive", 16372) -- variables (7.0~8.5)
--local timerVoidBoltCD	= mod:NewCDTimer(10.5, 108383, nil, mod:IsTank())--Needs more work, need to check for the ability that halfs his CDs and such.
local timerVoidBolt		= mod:NewTargetTimer(20, 108383, nil, mod:IsTank() or mod:IsHealer())--Tooltip says 30 but combat logs clearly show it fading at 20.

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddBoolOption("RangeFrame", true)

--[[
Confirmed in transcriptor log for normal mode.
--104894,"Black Blood of Shu'ma"
--104896,"Purple Blood of Shu'ma"
--104897,"Red Blood of Shu'ma"
--104898,"Green Blood of Shu'ma"
--104900,"Blue Blood of Shu'ma"
--104901,"Yellow Blood of Shu'ma"

Seem to be alternate versions of Yellow and Blue on ptr.wowhead.com. heroic stronger versions maybe?
--105027,"Blue Blood of Shu'ma"
--108221,"Yellow Blood of Shu'ma"
--]]

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
--	timerVoidBoltCD:Start(-delay)
	timerOozesCD:Start(22-delay)
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(104849, 108383, 108384, 108385) then--104849, 108383 confirmed 10 and 25 man normal, other 2 drycoded from wowhead.
--		timerVoidBoltCD:Start()--Start CD off this not applied, that way we still get CD if a tank AMS's the debuff application.
	elseif args:IsSpellID(105530) then--105530 confirmed 10 man normal.
		warnManaVoid:Show()
		specWarnManaVoid:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(104849, 108383, 108384, 108385) then--104849, 108383 confirmed 10 and 25 man normal, other 2 drycoded from wowhead.
		warnVoidBolt:Show(args.destName, args.amount or 1)
		timerVoidBolt:Start(args.destName)
		if (args.amount or 0) >= 3 and args:IsPlayer() then
			specWarnVoidBolt:Show(args.amount)
		end
	elseif args:IsSpellID(104898) and not self:IsDifficulty("lfr25") and self.Options.RangeFrame then
		DBM.RangeCheck:Show(4)
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(104849, 108383, 108384, 108385) then--104849, 108383 confirmed 10 and 25 man normal, other 2 drycoded from wowhead.
		timerVoidBolt:Cancel(args.destName)
	elseif args:IsSpellID(104898) and self.Options.RangeFrame then--110743 exists but i don't see it in 10 man or 25 man normal logs.
		DBM.RangeCheck:Hide()
	end
end		

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellID)
	if uId ~= "boss1" then return end
	if self:IsDifficulty("heroic10", "heroic25") then
		if oozeColorsHeroic[spellID] then
			warnOozes:Show(table.concat(oozeColorsHeroic[spellID], ", "))
			specWarnOozes:Show()
			timerOozesActive:Start()
--			timerVoidBoltCD:Start(40)
			if self:IsDifficulty("heroic10", "heroic25") then
				timerOozesCD:Start(75)
			else
				timerOozesCD:Start()--it's still 90 on normal
			end
		end
	else
		if oozeColors[spellID] then
			warnOozes:Show(table.concat(oozeColors[spellID], ", "))
			specWarnOozes:Show()
			timerOozesActive:Start()
--			timerVoidBoltCD:Start(40)
			timerOozesCD:Start()
		end
	end
end
