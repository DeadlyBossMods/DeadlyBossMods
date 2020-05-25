local mod	= DBM:NewMod(2419, "DBM-Party-Shadowlands", 2, 1183)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164255)
mod:SetEncounterID(2382)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 324652",
	"SPELL_CAST_START 324527 327608 327597 327584 327581 327232 327062 324667"
--	"SPELL_CAST_SUCCESS",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, MANY Beckon SLime spellIds, which is right?
local warnPlaguestomp				= mod:NewCastAnnounce(324527, 2)
local warnSlimeWave					= mod:NewCastAnnounce(324667, 2)

local specWarnDebilitatingPlague	= mod:NewSpecialWarningDispel(324652, "RemoveDisease", nil, nil, 1, 2)
local specWarnSummonSlime			= mod:NewSpecialWarningSwitch(327608, "-Healer", nil, nil, 1, 2)
--local yellBlackPowder				= mod:NewYell(257314)
--local specWarnHealingBalm			= mod:NewSpecialWarningInterrupt(257397, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerPlaguestompCD			= mod:NewAITimer(15.8, 324527, nil, nil, nil, 3)
local timerSummonSlimeCD			= mod:NewCDTimer(13, 327608, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)
local timerSlimeWaveCD				= mod:NewCDTimer(13, 324667, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerPlaguestompCD:Start(1-delay)
	timerSummonSlimeCD:Start(1-delay)
	timerSlimeWaveCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 324527 then
		warnPlaguestomp:Show()
		timerPlaguestompCD:Start()
	elseif spellId == 327608 or spellId == 327597 or spellId == 327584 or spellId == 327581 or spellId == 327232 or spellId == 327062 then
		specWarnSummonSlime:Show()
		if self:IsTank() then
			specWarnSummonSlime:Play("moveboss")
		else
			specWarnSummonSlime:Play("killmob")
		end
		timerSummonSlimeCD:Start()
	elseif spellId == 324667 then
		warnSlimeWave:Show()
		timerSlimeWaveCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 257316 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 324652 and self:CheckDispelFilter() then
		specWarnDebilitatingPlague:CombinedShow(0.3, args.destName)
		specWarnDebilitatingPlague:ScheduleVoice(0.3, args.destName)
	end
end

--[[
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
