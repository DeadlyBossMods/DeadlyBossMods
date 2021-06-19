local mod	= DBM:NewMod(2437, "DBM-Party-Shadowlands", 9, 1194)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175616)
mod:SetEncounterID(2425)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 348350 346204",
	"SPELL_CAST_SUCCESS 345770",
	"SPELL_AURA_APPLIED 345989 348128"
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, fix event for interrogation targetting, it's likely wrong, maybe https://ptr.wowhead.com/spell=345990/containment-cell instead?
--Improve/add timers for armed/disarmed phases because it'll probably alternate a buffactive timer instead of CD
--TODO, what do with https://ptr.wowhead.com/spell=347964/rotary-body-armor ?
local warnArmedSecurity				= mod:NewSpellAnnounce(346204, 2)
local warnFullyArmed				= mod:NewSpellAnnounce(348128, 3, nil, "Tank|Healer")
local warnInpoundContraband			= mod:NewTargetNoFilterAnnounce(345770, 2)--Not filtered, because if it's on a tank or healer its kinda important

local specWarnInterrogation			= mod:NewSpecialWarningYou(345989, nil, nil, nil, 1, 2)
local yellInterrogation				= mod:NewYell(345989)
local specWarnInterrogationOther	= mod:NewSpecialWarningSwitch(345989, "Dps", nil, nil, 1, 2)
local specWarnInpoundContraband		= mod:NewSpecialWarningYou(345770, nil, nil, nil, 1, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(320366, nil, nil, nil, 1, 8)

local timerInterrogationCD			= mod:NewAITimer(11, 345989, nil, nil, nil, 3)
local timerArmedSecurityCD			= mod:NewAITimer(11, 346204, nil, nil, nil, 6)
local timerImpoundContrabandCD		= mod:NewAITimer(11, 345770, nil, nil, nil, 3)
--local timerStichNeedleCD			= mod:NewAITimer(15.8, 320200, nil, nil, nil, 5, nil, DBM_CORE_L.HEALER_ICON)--Basically spammed

function mod:OnCombatStart(delay)
	timerInterrogationCD:Start(1-delay)
	timerArmedSecurityCD:Start(1-delay)
	timerImpoundContrabandCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 348350 then
		timerInterrogationCD:Start()
	elseif spellId == 346204 then
		warnArmedSecurity:Show()
		timerArmedSecurityCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 345770 then
		timerImpoundContrabandCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 345989 and args:IsDestTypePlayer() then
		if args:IsPlayer() then
			specWarnInterrogation:Show()
			specWarnInterrogation:Play("targetyou")
			yellInterrogation:Yell()
		else
			specWarnInterrogationOther:Show()
			specWarnInterrogationOther:Play("targetchange")
		end
	elseif spellId == 348128 then
		warnFullyArmed:Show()
	elseif spellId == 345770 then
		warnInpoundContraband:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnInpoundContraband:Show()
			specWarnInpoundContraband:Play("targetyou")
		end
	end
end

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 322681 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 320366 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 164578 then

	end
end


function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
