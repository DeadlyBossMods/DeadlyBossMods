local mod	= DBM:NewMod(2404, "DBM-Party-Shadowlands", 2, 1183)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(126983)
mod:SetEncounterID(2386)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START 322236 322475"
--	"SPELL_CAST_SUCCESS",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, https://shadowlands.wowhead.com/spell=322490/plague-rot is passive, does it need an infoframe?
--TODO, Fix Plague Crash ID/event
--local warnBlackPowder				= mod:NewTargetAnnounce(257314, 4)

local specWarnTouchofSlime			= mod:NewSpecialWarningSoak(257314, "Tank", nil, nil, 1, 7)
local specWarnPlagueCrash			= mod:NewSpecialWarningDodge(322477, nil, nil, nil, 3, 2)--Maybe run away sound instead depending on effect
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerTouchofSlimeCD				= mod:NewCDTimer(13, 322236, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)

function mod:OnCombatStart(delay)
	timerTouchofSlimeCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 322236 then
		specWarnTouchofSlime:Show()
		specWarnTouchofSlime:Play("helpsoak")
		timerTouchofSlimeCD:Start()
	elseif spellId == 322475 then
		specWarnPlagueCrash:Show()
		specWarnPlagueCrash:Play("watchstep")
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 257316 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 194966 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 309991 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
