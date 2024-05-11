local mod	= DBM:NewMod(2635, "DBM-KhazAlgar", nil, 1278)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(220999)
mod:SetEncounterID(2988)
--mod:SetReCombatTime(30)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetHotfixNoticeRev(20240119000000)
--mod:SetMinSyncRevision(20240119000000)

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Win)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 452205 453271 452980 453294 455188"
--	"SPELL_CAST_SUCCESS",
--	"SPELL_AURA_APPLIED"
)

--TODO, Skardyn adds?
--TODO, verify bursting cast event and warning type it should use
--TODO, does https://www.wowhead.com/beta/spell=453298/retribution-pain stack? if so add stack and taunt warnings
local warnBurstingRetribution			= mod:NewSpellAnnounce(452210, 2)
local warnEntropy     		        	= mod:NewSpellAnnounce(453271, 4)--Tooltip bugged? why does boss have two "not in melee range of boss" mechanics?
local warnRetributionPunch  			= mod:NewSpellAnnounce(453294, 3)
local warnThrowDarkrock       			= mod:NewSpellAnnounce(455198, 3)--why does boss have two "not in melee range of boss" mechanics?

local specWarnFuryHorrors				= mod:NewSpecialWarningDodge(452980, nil, nil, nil, 2, 2)

local timerBurstingRetributionCD		= mod:NewAITimer(32.7, 452210, nil, nil, nil, 1)
local timerFuryHorrorsCD	        	= mod:NewAITimer(32.7, 452980, nil, nil, nil, 3)
local timerRetributionPunchCD	       	= mod:NewAITimer(32.7, 453294, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 452205 then
        warnBurstingRetribution:Show()
        timerBurstingRetributionCD:Start()
    elseif spellId == 453271 then
        warnEntropy:Show()
    elseif spellId == 452980 then
        specWarnFuryHorrors:Show()
        specWarnFuryHorrors:Play("shockwave")
        timerFuryHorrorsCD:Start()
    elseif spellId == 453294 then
        timerRetributionPunchCD:Start()
        if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
            warnRetributionPunch:Show()
        end
    elseif spellId == 455188 then
        warnThrowDarkrock:Show()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 421006 then

	end
end
--]]

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 421260 then

	end
end
--]]
