local mod	= DBM:NewMod("Rhyolith", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52558)
mod:SetModelID(38629) -- Temporary till real modelID is known
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_REMOVED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_CAST_SUMMON"
)

local warnRockElementals	= mod:NewSpellAnnounce(98146, 3)
local warnFireElementals	= mod:NewSpellAnnounce(98552, 3)
local warnHeatedVolcano		= mod:NewSpellAnnounce(98493, 3)
local warnFlameStomp		= mod:NewSpellAnnounce(97282, 3)
local warnObsidianArmor		= mod:NewStackAnnounce(98632, 4)
local warnDrinkMagma		= mod:NewSpellAnnounce(98034, 2)	-- if you "kite" him to close to magma

local timerRockElementals	= mod:NewNextTimer(22.5, 98146)
local timerFireElementals	= mod:NewNextTimer(70, 98552)
local timerHeatedVolcano	= mod:NewNextTimer(40, 98493)
local timerFlameStomp		= mod:NewNextTimer(30, 97282)
local timerMoltenSpew		= mod:NewNextTimer(6, 98034)	-- 6secs after Drinking Magma

function mod:OnCombatStart(delay)
	timerRockElementals:Start(21.5-delay)
	timerFireElementals:Start(45-delay)
	timerHeatedVolcano:Start(55-delay)
	timerFlameStomp:Start(28-delay)
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	if args:IsSpellID(98632) and self:GetCIDFromGUID(args.destGUID) == 52558 then	-- only announce stacks on the boss (not his feet)
		warnObsidianArmor:Show(args.destName, args.amount)			-- 0 obsidian armor = P2 ?
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(98034) then
		warnDrinkMagma:Show()
		timerMoltenSpew:Start()
	elseif args:IsSpellID(97282) then
		warnFlameStomp:Show()
		timerFlameStomp:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(98146) then
		warnRockElementals:Show()
		timerRockElementals:Start()
	elseif args:IsSpellID(98493) then
		warnHeatedVolcano:Show()
		timerHeatedVolcano:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(98552) then
		warnFireElementals:Show()
		timerFireElementals:Start()
	end
end