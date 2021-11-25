local mod	= DBM:NewMod(2433, "DBM-Shadowlands", nil, 1192)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(167526)
mod:SetEncounterID(2408)
mod:SetReCombatTime(20)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 338858 338863 338864 338867 338868"
--	"SPELL_CAST_SUCCESS"
)

--TODO, maybe do somsething with https://shadowlands.wowhead.com/spell=338872/hardened-muck
--https://shadowlands.wowhead.com/spell=338868/deep-slumber What do with this?
local warnStoneFist							= mod:NewSpellAnnounce(338858, 3, nil, "Tank")
local warnStoneStomp						= mod:NewSpellAnnounce(338863, 3)
local warnDeepSlumber						= mod:NewCastAnnounce(338868, 2)

local specWarnEarthenBlast					= mod:NewSpecialWarningDodge(338864, nil, nil, nil, 2, 2)
local specWarnHailofStones					= mod:NewSpecialWarningMoveTo(338867, nil, nil, nil, 3, 2)
--local specWarnSummonSwarmguard			= mod:NewSpecialWarningSwitch(314307, "-Healer", nil, nil, 1, 2)

local timerStoneFistCD						= mod:NewAITimer(82.0, 338858, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerStoneStompCD						= mod:NewAITimer(82.0, 338863, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerEarthenBlastCD					= mod:NewAITimer(82.0, 338864, nil, nil, nil, 3)
local timerHailofStonesCD					= mod:NewAITimer(82.0, 338867, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON, nil, 1, 5)
local timerDeepSlumberCD					= mod:NewAITimer(82.0, 338868, nil, nil, nil, 6)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerStoneFistCD:Start(1)
		--timerStoneStompCD:Start(1)
		--timerEarthenBlastCD:Start(1)
		--timerHailofStonesCD:Start(1)
		--timerDeepSlumberCD:Start(1)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 338858 then
		warnStoneFist:Show()
		timerStoneFistCD:Start()
	elseif spellId == 338863 then
		warnStoneStomp:Show()
		timerStoneStompCD:Start()
	elseif spellId == 338864 then
		specWarnEarthenBlast:Show()
		specWarnEarthenBlast:Play("watchstep")
		timerEarthenBlastCD:Start()
	elseif spellId == 338867 then
		specWarnHailofStones:Show(DBM_COMMON_L.BOSS)
		specWarnHailofStones:Play("movecenter")
		timerHailofStonesCD:Start()
	elseif spellId == 338868 then
		warnDeepSlumber:Show()
		timerDeepSlumberCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 314307 then

	end
end
--]]
