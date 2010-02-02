local mod	= DBM:NewMod("Valithria", "DBM-Icecrown", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36789)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnCorrosion		= mod:NewAnnounce("warnCorrosion", 2, nil, false)
local warnGutSpray		= mod:NewTargetAnnounce(71283)
local warnLayWaste		= mod:NewSpellAnnounce(69325)
local warnManaVoid		= mod:NewSpellAnnounce(71179)
local warnColumnofFrost	= mod:NewSpellAnnounce(70702)
local warnSupression	= mod:NewSpellAnnounce(70588)
local warnPortal		= mod:NewSpellAnnounce(71987)

--local timerLayWaste		= mod:NewBuffActiveTimer(12, 69325)--don't know spell mechanic yet (interuptable?)
--local timerNextPortal		= mod:NewNextTimer(30, 71987)--unknown value at this time
local timerGutSpray		= mod:NewTargetTimer(12, 71283)
local timerCorrosion	= mod:NewTargetTimer(6, 70751)

local spamPortals = 0

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69325, 71730) then--Lay Waste (spellids drycoded, will confirm later)
		warnLayWaste:Show()
--		timerLayWaste:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(71085) then--Mana Void (spellids drycoded, will confirm later)
		warnManaVoid:Show()
	elseif args:IsSpellID(70715) then--Column of Frost (spellids drycoded, will confirm later)
		warnColumnofFrost:Show()
	elseif args:IsSpellID(70588) then--Supression (spellids drycoded, will confirm later)
		warnSupression:Show()
	elseif args:IsSpellID(71987) and GetTime() - spamPortals > 5 then--Summon Nightmare Portal (spellids drycoded, will confirm later)
		warnPortal:Show()
--		timerNextPortal:Start()
		spamPortals = GetTime()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70633, 71283, 72025, 72026) then--Gut Spray (spellids drycoded, will confirm later)
		warnGutSpray:Show(args.destName)
		timerGutSpray:Start(args.destName)
	elseif args:IsSpellID(70751) then--Corrosion (spellids drycoded, will confirm later)
		warnCorrosion:Show(args.spellName, args.destName, args.amount or 1)
		timerCorrosion:Start(args.destName)
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(70633, 71283, 72025, 72026) then
		timerGutSpray:Cancel(args.destName)
	end
end