local mod	= DBM:NewMod("Ozumat", "DBM-Party-Cataclysm", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(40807)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnPhase2	= mod:NewPhaseAnnounce(2)
local warnPhase3	= mod:NewPhaseAnnounce(3)
local warnBlightSpray	= mod:NewSpellAnnounce(83985, 2)

local timerBlightSpray	= mod:NewBuffActiveTimer(4, 83985)

local warnedPhase2
local warnedPhase3

-- Shadow Blast, no SPELL_CAST_START?
-- 7/29 13:16:34.727  SPELL_CAST_SUCCESS,0xF150AE6800001152,"Unyielding Behemoth",0xa48,0x0000000000000000,nil,0x80000000,83929,"Shadow Blast",0x1
-- 7/29 13:16:34.727  SPELL_SUMMON,0xF150AE6800001152,"Unyielding Behemoth",0xa48,0xF150AF950000118B,"Unyielding Behemoth (Leap Vehicle)",0xa28,83929,"Shadow Blast",0x1

-- Brain Spike, worth warning?
-- ~7k damage + 1k mana drain
-- 7/29 13:23:37.522  SPELL_CAST_START,0xF130AEAB000011BB,"Vicious Mindlasher",0xa48,0x0000000000000000,nil,0x80000000,83915,"Brain Spike",0x20
-- heroic ID:  91497

-- Blight of Ozumat, stack warning?  (spell ID 83561 .. 91495 heroic)
-- Aura of Dread, stack warning (spell ID 83971)

function mod:OnCombatStart(delay)
	warnedPhase2 = false
	warnedPhase3 = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(83463) and not warnedPhase2 then
		warnPhase2:Show(2)
		warnedPhase2 = true
	elseif args:IsSpellID(76133) and not warnedPhase3 then
		warnPhase3:Show(3)
		warnedPhase3 = true
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(83985) then
		warnBlightSpray:Show()
		timerBlightSpray:Start()
	end
end