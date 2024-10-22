local mod	= DBM:NewMod(2636, "DBM-KhazAlgar", nil, 1278)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(221224)
mod:SetEncounterID(2994)
--mod:SetReCombatTime(30)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetHotfixNoticeRev(20240119000000)
--mod:SetMinSyncRevision(20240119000000)

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Win)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 453607 453733 455275 453875",
	"SPELL_AURA_APPLIED 453618 453871"
--	"SPELL_AURA_REMOVED 455639"
)

--TODO, do timers restart on shroud break, or do they pause on shield apply and unpause on remove?
local warnBrinyVomit				= mod:NewSpellAnnounce(453733, 3)
local warnDarkTide					= mod:NewCastAnnounce(455275, 3)
local warnRegurgitateSouls			= mod:NewSpellAnnounce(453875, 3)

local specWarnAbyssalStrike			= mod:NewSpecialWarningDefensive(453607, nil, nil, nil, 1, 2)
local specWarnAbyssalStrikeTaunt	= mod:NewSpecialWarningTaunt(453607, nil, nil, nil, 1, 2)
local specWarnOceansReckoning		= mod:NewSpecialWarningDispel(453871, "Disease", nil, nil, 1, 2)

local timerTectonicRoarCD			= mod:NewAITimer(32.7, 453607, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerBrinyVomitCD				= mod:NewAITimer(32.7, 453733, nil, nil, nil, 3)
local timerDarkTideCD				= mod:NewAITimer(32.7, 455275, nil, nil, nil, 3)
--local timerRegurgitateSoulsCD		= mod:NewAITimer(32.7, 453875, nil, nil, nil, 6)

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 453607 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnAbyssalStrike:Show()
			specWarnAbyssalStrike:Play("defensive")
		end
		timerTectonicRoarCD:Start()
	elseif spellId == 453733 then
		warnBrinyVomit:Show()
		timerBrinyVomitCD:Start()
	elseif spellId == 455275 then
		warnDarkTide:Show()
		timerDarkTideCD:Start()
	elseif spellId == 453875 then
		warnRegurgitateSouls:Show()
--		timerRegurgitateSoulsCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 453618 and not args:IsPlayer() then
		specWarnAbyssalStrikeTaunt:Show(args.destName)
		specWarnAbyssalStrikeTaunt:Play("tauntboss")
	elseif spellId == 453871 and self:CheckDispelFilter("disease") then
		specWarnOceansReckoning:CombinedShow(1, args.destName)
		specWarnOceansReckoning:ScheduleVoice(1, "helpdispel")
	end
end

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 455639 then--Shroud of the Drowned
		timerRegurgitateSoulsCD:Start()
	end
end
--]]
