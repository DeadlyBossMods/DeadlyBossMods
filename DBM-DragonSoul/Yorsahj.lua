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

local warnOozes			= mod:NewAnnounce("warnOozes", 4, 16372)
local warnVoidBolt		= mod:NewStackAnnounce(108383, 3, nil, mod:IsTank() or mod:IsHealer())--Makes fight require 2 tanks? When properly tuned anyways.
local warnManaVoid		= mod:NewSpellAnnounce(105530, 3)

local specWarnOozes		= mod:NewSpecialWarning("specWarnOozes", mod:IsDps())
local specWarnVoidBolt	= mod:NewSpecialWarningStack(108383, mod:IsTank(), 3)--with 20 second debuffs and 11 second CDs, can probably trade at 2, but it may still be 30 on 25 man not sure yet so i'll leave 3 for now.
local specWarnManaVoid	= mod:NewSpecialWarningSpell(105530, mod:IsDps() or mod:IsManaUser())

local timerOozesCD		= mod:NewTimer(90, "timerOozesCD", 16372)
local timerOozesActive	= mod:NewTimer(7, "timerOozesActive", 16372) -- variables (7.0~8.5)
--local timerVoidBoltCD	= mod:NewCDTimer(10.5, 108383, nil, mod:IsTank())--i can't quite see what makes him stop casting it yet throughout fight yet though to perfectly cancel/start it so it's semi inaccurate for now.
local timerVoidBolt		= mod:NewTargetTimer(20, 108383, nil, mod:IsTank() or mod:IsHealer())--Tooltip says 30 but combat logs clearly show it fading at 20.

local berserkTimer				= mod:NewBerserkTimer(600)

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

local oozeColors = {
	[105420] = { L.Purple, L.Green, L.Blue },
	[105435] = { L.Green, L.Red, L.Black },
	[105436] = { L.Green, L.Yellow, L.Red },
	[105437] = { L.Blue, L.Purple, L.Yellow },
	[105439] = { L.Blue, L.Black, L.Yellow },
	[105440] = { L.Purple, L.Red, L.Black },
}

function mod:OnCombatStart(delay)
--	timerVoidBoltCD:Start(-delay)
	timerOozesCD:Start(22-delay)
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(104849, 108383, 108384, 108385) then--104849, 108383 confirmed 10 and 25 man normal, other 2 drycoded from wowhead.
--		timerVoidBoltCD:Start()--Start CD off this not applied, that way we still get CD if a tank AMS's the debuff application.
	elseif args:IsSpellID(105530) then--105530 confirmed 10 man normal, other drycoded from wowhead.
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
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(104849, 108383, 108384, 108385) then--104849, 108383 confirmed 10 and 25 man normal, other 2 drycoded from wowhead.
		timerVoidBolt:Cancel(args.destName)
	end
end		

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellID)
	if uId ~= "boss1" then return end--Anti spam to ignore all other args (like target/focus/mouseover)
	if oozeColors[spellID] then
		warnOozes:Show(table.concat(oozeColors[spellID], ", "))
		specWarnOozes:Show()
		timerOozesActive:Start()
--		timerVoidBoltCD:Start(40)
		timerOozesCD:Start()
	end
end
