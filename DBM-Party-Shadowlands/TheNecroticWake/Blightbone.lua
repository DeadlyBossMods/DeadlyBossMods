local mod	= DBM:NewMod(2395, "DBM-Party-Shadowlands", 1, 1182)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162691)
mod:SetEncounterID(2387)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 320596 320655",
	"SPELL_PERIODIC_DAMAGE 320646",
	"SPELL_PERIODIC_MISSED 320646",
	"UNIT_SPELLCAST_START boss1"
)

--TODO, https://shadowlands.wowhead.com/spell=320614/blood-gorge stuff?
--[[
(ability.id = 320596 or ability.id = 320637 or ability.id = 320655) and type = "begincast"
--]]
local warnFetidGas					= mod:NewSpellAnnounce(320637, 2)

local specWarnHeavingRetchYou		= mod:NewSpecialWarningMoveAway(320596, nil, nil, nil, 1, 2)
local specWarnHeavingRetch			= mod:NewSpecialWarningDodgeLoc(320596, nil, nil, nil, 2, 2)
local yellHeavingRetch				= mod:NewYell(320596)
local specWarnCrunch				= mod:NewSpecialWarningDefensive(320655, "Tank", nil, nil, 1, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(320646, nil, nil, nil, 1, 8)

local timerHeavingRetchCD			= mod:NewCDTimer(32.7, 320596, nil, nil, nil, 3)--32.7-42
local timerFetidGasCD				= mod:NewCDTimer(24.6, 320637, nil, nil, nil, 3)
local timerCrunchCD					= mod:NewCDTimer(11.7, 320655, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--11-20, spell queues behind other 2 casts

function mod:RetchTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnHeavingRetchYou:Show()
		specWarnHeavingRetchYou:Play("runout")
		yellHeavingRetch:Yell()
	else
		specWarnHeavingRetch:Show(targetname)
		specWarnHeavingRetch:Play("shockwave")
	end
end

function mod:OnCombatStart(delay)
	timerCrunchCD:Start(5-delay)
	timerHeavingRetchCD:Start(10.6-delay)
	timerFetidGasCD:Start(22-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 320596 then
--		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "RetchTarget", 0.1, 4)
		timerHeavingRetchCD:Start()
	elseif spellId == 320637 then
		warnFetidGas:Show()
		timerFetidGasCD:Start()
	elseif spellId == 320655 then
		specWarnCrunch:Show()
		specWarnCrunch:Play("defensive")
		timerCrunchCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 320646 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--"<250.42 21:13:50> [UNIT_SPELLCAST_START] Blightbone(Suijro) - Heaving Retch - 2.5s [[boss1:Cast-3-2085-2286-7772-320596-000026E3DF:320596]]", -- [2791]
--"<250.42 21:13:50> [CLEU] SPELL_CAST_START#Creature-0-2085-2286-7772-162691-000026E310#Blightbone##nil#320596#Heaving Retch#nil#nil", -- [2794]
--"<250.42 21:13:50> [UNIT_TARGET] boss1#Blightbone - Hupe#Blightbone", -- [2795]
--"<250.60 21:13:50> [CHAT_MSG_MONSTER_YELL] Something... coming... up...#Blightbone###Hupe##0#0##0#30#nil#0#false#false#false#false", -- [2796]
function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 320596 then
		self:BossUnitTargetScanner(uId, "RetchTarget", 1)
	end
end
