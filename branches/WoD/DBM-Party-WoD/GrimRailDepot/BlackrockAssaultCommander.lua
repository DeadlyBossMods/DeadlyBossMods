local mod	= DBM:NewMod(1163, "DBM-Party-WoD", 3, 536)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(79545)
mod:SetEncounterID(1732)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 160681",
	"SPELL_CAST_START 160680",
	"UNIT_DIED"
)

local warnReloading			= mod:NewSpellAnnounce(160680, 1, nil, false)--This is all boss does
local warnSupressiveFire	= mod:NewSpellAnnounce(160681, 3, nil, false)--In a repeating loop
local warnGrenadeDown		= mod:NewSpellAnnounce("ej9711", 1)--Boss is killed by looting using these positive items on him.
local warnMortarDown		= mod:NewSpellAnnounce("ej9712", 1)--So warn when adds that drop them die

local specWarnGrenade		= mod:NewSpecialWarningSpell("ej9711", false)--These are nice for just clearing adds, very little boss damage
local specWarnMortar		= mod:NewSpecialWarningSpell("ej9712", false)--These are absolutely the key to killing boss and most important thing in fight.

local timerReloading		= mod:NewCastTimer(4, 160680)
local timerSupressiveFire	= mod:NewBuffActiveTimer(10, 160681)

function mod:OnCombatStart(delay)

end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 160681 then
		warnSupressiveFire:Show()
		timerSupressiveFire:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 160680 then
		warnReloading:Show()
		timerReloading:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 79739 then--Blackrock Grenadier
		warnGrenadeDown:Show()
		specWarnGrenade:Show()
	elseif cid == 79720 then--Blackrock Artillery Engineer
		warnMortarDown:Show()
		specWarnMortar:Show()
	end
end
