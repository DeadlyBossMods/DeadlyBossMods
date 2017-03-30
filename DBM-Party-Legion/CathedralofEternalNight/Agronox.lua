local mod	= DBM:NewMod(1905, "DBM-Party-Legion", 12, 900)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(117193)
mod:SetEncounterID(2055)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 235751",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, figure out how to warn choking Vines
--TODO, other GTFOs?
--lasher fixate for tree boss
--SucculentLashers 
local warnFulminatingLashers		= mod:NewSpellAnnounce(236527, 2)
local warnSucculentLashers			= mod:NewSpellAnnounce(236639, 2)

local specWarnTimberSmash			= mod:NewSpecialWarningDefensive(235751, "Tank", nil, nil, 1, 2)

local timerTimberSmashCD			= mod:NewCDTimer(21.7, 235751, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerFulminatingLashersCD		= mod:NewCDTimer(40, 236527, nil, nil, nil, 1)
local timerSucculentLashersCD		= mod:NewAITimer(16.5, 236639, nil, nil, nil, 1)

--local countdownMagmaWave			= mod:NewCountdown(60, 200404)

local voiceTimberSmash				= mod:NewVoice(235751, "Tank")--carefly

function mod:OnCombatStart(delay)
	timerTimberSmashCD:Start(6-delay)
	timerFulminatingLashersCD:Start(17.5-delay)
	if self:IsHard() then
		timerSucculentLashersCD:Start(1-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 235751 then
		specWarnTimberSmash:Show()
		voiceTimberSmash:Play("carefly")
		timerTimberSmashCD:Start()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 212736 and destGUID == playerGUID and self:AntiSpam(2, 1) then
		specWarnPoolOfFrost:Show()
		voicePoolOfFrost:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 236527 and self:AntiSpam(2, 1) then--Fulminating Lashers
		warnFulminatingLashers:Show()
		timerFulminatingLashersCD:Start()
	elseif spellId == 236639 and self:AntiSpam(2, 2) then--Succulent Lashers
		warnSucculentLashers:Show()
		timerSucculentLashersCD:Start()
	end
end
