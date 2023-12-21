local mod	= DBM:NewMod(2562, "DBM-DragonIsles", nil, 1205)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(209574)
mod:SetEncounterID(2828)
mod:SetReCombatTime(20)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
mod:SetHotfixNoticeRev(20231129000000)
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")
--mod:RegisterCombat("combat_yell", L.Pull)
mod:RegisterKill("yell", L.Win)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 420895 420925 421260",
	"SPELL_AURA_APPLIED 421260 181089"
)

local specWarnGroggyBash				= mod:NewSpecialWarningYou(420895, nil, nil, nil, 1, 2)
local specWarnPulverizingOutburst		= mod:NewSpecialWarningDodge(420925, nil, nil, nil, 1, 2)
local specWarnRoarDebuff				= mod:NewSpecialWarningJump(421260, nil, nil, nil, 1, 6)

local timerGroggyBashCD					= mod:NewCDTimer(33, 420895, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local timerPulverizingOutburstCD		= mod:NewAITimer(15.9, 420925, nil, nil, nil, 3)--Health based? 15-59 is too much variation for a CD timer
local timerSlumberingRoarCD				= mod:NewCDTimer(70.9, 421260, nil, nil, nil, 2)--Small sample

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 420895 then
		timerGroggyBashCD:Start()
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnGroggyBash:Show()
			specWarnGroggyBash:Play("carefly")
		end
	elseif spellId == 420925 then
		specWarnPulverizingOutburst:Show()
		specWarnPulverizingOutburst:Play("chargemove")
--		timerPulverizingOutburstCD:Start()
	elseif spellId == 421260 then
		timerSlumberingRoarCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 421260 and args:IsPlayer() then
		specWarnRoarDebuff:Show()
		specWarnRoarDebuff:Play("keepjump")
	elseif spellId == 181089 then--Encounter Event
		DBM:EndCombat(self)
	end
end
