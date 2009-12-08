local mod	= DBM:NewMod("GunshipBattle", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
mod:RegisterCombat("combat")		-- change to yell once I know them

if UnitFactionGroup("player") == "Alliance" then
--	mod:RegisterCombat("yell", L.AlliancePullYell)
	mod:SetCreatureID(37215)	-- Orgrim's Hammer
else
--	mod:RegisterCombat("yell", L.HordePullYell)
	mod:SetCreatureID(37540)	-- The Skybreaker
end

--mod:SetUsedIcons(3, 4, 5, 6, 7, 8)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED"
)

local warnBelowZero		= mod:NewSpellAnnounce(69705, 3)
local warnExperienced		= mod:NewTargetAnnounce(71188, 1, nil, false)		-- might be spammy
local warnVeteran		= mod:NewTargetAnnounce(71193, 2, nil, false)		-- might be spammy
local warnElite			= mod:NewTargetAnnounce(71195, 3, nil, false)		-- might be spammy
local warnBattleFury		= mod:NewAnnounce("WarnBattleFury", 3, nil, false)	-- might be spammy
local warnBladestorm		= mod:NewSpellAnnounce(69652, 2, nil, false)		-- might be spammy
local warnWoundingStrike	= mod:NewTargetAnnounce(69651, 3)

local timerBelowZeroCD		= mod:NewCDTimer(35, 69705)
local timerBattleFuryActive	= mod:NewBuffActiveTimer(20, 69638)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(71195) then
		warnElite:Show(args.destName)
	elseif args:IsSpellID(71193) then
		warnVeteran:Show(args.destName)
	elseif args:IsSpellID(71188) then
		warnExperienced:Show(args.destName)
	elseif args:IsSpellID(69652) then
		warnBladestorm:Show()			
	elseif args:IsSpellID(69651) then
		warnWoundingStrike:Show(args.destName)

-- if opposite leader gets BattleFury then
	elseif args:IsSpellID(69638) and ((UnitFactionGroup("player") == "Alliance" and mod:GetCIDFromGUID(args.destGUID) == 37187) or (UnitFactionGroup("player") == "Horde" and mod:GetCIDFromGUID(args.destGUID) == 37200)) then
		warnBattleFury:Show(GetSpellInfo(69638), args.amount)
		timerBattleFuryActive:Start()
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(69705) then
		timerBelowZeroCD:Start()
	end
end