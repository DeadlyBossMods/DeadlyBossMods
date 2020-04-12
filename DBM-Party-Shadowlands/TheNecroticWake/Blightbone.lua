local mod	= DBM:NewMod(2395, "DBM-Party-Shadowlands", 1, 1182)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(166880)
mod:SetEncounterID(2387)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 320596 320655",
	"SPELL_PERIODIC_DAMAGE 320646",
	"SPELL_PERIODIC_MISSED 320646"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, https://shadowlands.wowhead.com/spell=320614/blood-gorge stuff?
--TODO, improve target warnings if target scanning is successful
local warnFetidGas					= mod:NewSpellAnnounce(320637, 2)

local specWarnHeavingRetch			= mod:NewSpecialWarningDodge(320596, nil, nil, nil, 2, 2)
local yellHeavingRetch				= mod:NewYell(320596)
local specWarnCrunch				= mod:NewSpecialWarningDefensive(320655, "Tank", nil, nil, 1, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(320646, nil, nil, nil, 1, 8)

local timerHeavingRetchCD			= mod:NewAITimer(15.8, 320596, nil, nil, nil, 3)
local timerFetidGasCD				= mod:NewAITimer(15.8, 320637, nil, nil, nil, 3)
local timerCrunchCD					= mod:NewAITimer(13, 320655, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_TANK_ICON)

function mod:RetchTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		yellHeavingRetch:Yell()
	end
end

function mod:OnCombatStart(delay)
	timerHeavingRetchCD:Start(1-delay)
	timerFetidGasCD:Start(1-delay)
	timerCrunchCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 320596 then
		specWarnHeavingRetch:Show()
		specWarnHeavingRetch:Play("shockwave")
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "RetchTarget", 0.1, 4)
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

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
