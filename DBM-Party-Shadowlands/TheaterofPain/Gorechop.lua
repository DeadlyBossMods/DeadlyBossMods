local mod	= DBM:NewMod(2401, "DBM-Party-Shadowlands", 6, 1187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162317)
mod:SetEncounterID(2365)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 323515 318406",
--	"SPELL_CAST_SUCCESS 323107",
--	"SPELL_AURA_APPLIED",
	"SPELL_PERIODIC_DAMAGE 323130",
	"SPELL_PERIODIC_MISSED 323130",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--https://shadowlands.wowhead.com/npc=165260/unraveling-horror
--[[
(ability.id = 323515 or ability.id = 318406) and type = "begincast"
--]]
local warnMeatHooks					= mod:NewSpellAnnounce(322795, 2)

local specWarnTenderizingSmash		= mod:NewSpecialWarningRun(318406, nil, nil, nil, 4, 2)
local specWarnHatefulStrike			= mod:NewSpecialWarningDefensive(323515, "Tank", nil, nil, 1, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(323130, nil, nil, nil, 1, 8)

local timerMeatHooksCD				= mod:NewNextTimer(20.6, 322795, nil, nil, nil, 1)
local timerTenderizingSmashCD		= mod:NewCDTimer(19.4, 318406, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerHatefulStrikeCD			= mod:NewCDTimer(14.6, 323515, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerHatefulStrikeCD:Start(9.7-delay)
	timerMeatHooksCD:Start(5.8-delay)
	timerTenderizingSmashCD:Start(14.5-delay)
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 322795 then--Meat Hooks
		warnMeatHooks:Show()
		timerMeatHooksCD:Start()
	end
end
