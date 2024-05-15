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
local warnCrystallinebarrage			= mod:NewSpellAnnounce(452210, 2)
local warnDarkAwakening                 = mod:NewSpellAnnounce(453271, 4)--Tooltip bugged? why does boss have two "not in melee range of boss" mechanics?
local warnCrystalStrike  		    	= mod:NewSpellAnnounce(453294, 3)
local warnAnnihilationBarrage       	= mod:NewSpellAnnounce(455198, 3)--why does boss have two "not in melee range of boss" mechanics?

local specWarnVoidquake				    = mod:NewSpecialWarningDodge(452980, nil, nil, nil, 2, 2)

local timerCrystallinebarrageCD		    = mod:NewAITimer(32.7, 452210, nil, nil, nil, 1)
local timerVoidquakeCD	        	    = mod:NewAITimer(32.7, 452980, nil, nil, nil, 3)
local timerCrystalStrikeCD	          	= mod:NewAITimer(32.7, 453294, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 452205 then
        warnCrystallinebarrage:Show()
        timerCrystallinebarrageCD:Start()
    elseif spellId == 453271 then
        warnDarkAwakening:Show()
    elseif spellId == 452980 then
        specWarnVoidquake:Show()
        specWarnVoidquake:Play("shockwave")
        timerVoidquakeCD:Start()
    elseif spellId == 453294 then
        timerCrystalStrikeCD:Start()
        if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
            warnCrystalStrike:Show()
        end
    elseif spellId == 455188 then
        warnAnnihilationBarrage:Show()
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
