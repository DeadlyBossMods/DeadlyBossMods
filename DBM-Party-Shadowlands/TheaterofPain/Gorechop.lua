local mod	= DBM:NewMod(2401, "DBM-Party-Shadowlands", 6, 1187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162317)
mod:SetEncounterID(2365)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START 323515 318406",
	"SPELL_CAST_SUCCESS 323107",
	"SPELL_PERIODIC_DAMAGE 323130",
	"SPELL_PERIODIC_MISSED 323130"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, https://shadowlands.wowhead.com/spell=322795/meat-hooks spawns? seems like a peristent effect not one to warn
--TODO, more stuff with add, maybe add spawn detection, etc
--https://shadowlands.wowhead.com/npc=165260/unraveling-horror
local warnLeapingThrash				= mod:NewSpellAnnounce(323107, 2)

local specWarnHatefulStrike			= mod:NewSpecialWarningDefensive(323515, "Tank", nil, nil, 1, 2)
local specWarnTenderizingSmash		= mod:NewSpecialWarningRun(318406, nil, nil, nil, 4, 2)
--local yellBlackPowder				= mod:NewYell(257314)
--local specWarnHealingBalm			= mod:NewSpecialWarningInterrupt(257397, "HasInterrupt", nil, nil, 1, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(323130, nil, nil, nil, 1, 8)

local timerHatefulStrikeCD			= mod:NewAITimer(13, 323515, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerTenderizingSmashCD		= mod:NewAITimer(15.8, 318406, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)

function mod:OnCombatStart(delay)
	timerHatefulStrikeCD:Start(1-delay)
	timerTenderizingSmashCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 323515 then
		specWarnHatefulStrike:Show()
		specWarnHatefulStrike:Play("defensive")
		timerHatefulStrikeCD:Start()
	elseif spellId == 318406 then
		specWarnTenderizingSmash:Show()
		specWarnTenderizingSmash:Play("justrun")
		timerTenderizingSmashCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 323107 then
		warnLeapingThrash:Show()
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 194966 then

	end
end
--]]

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 323130 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
