local mod	= DBM:NewMod(2404, "DBM-Party-Shadowlands", 2, 1183)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(163958)--Or 164267
mod:SetEncounterID(2386)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START 322236 322475",
	"SPELL_CAST_SUCCESS 322304",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, https://shadowlands.wowhead.com/spell=322490/plague-rot is passive, does it need an infoframe?
--TODO, add https://shadowlands.wowhead.com/spell=322232/infectious-rain ?
--TODO, Fix Plague Crash to be less spammy, when trigger event for phase start/end is known and can be cleaned up to use special warning for begin, then general announce for each cast within
--TODO, timer correction on plague crash phase end
--TODO, even more timer correction on mythic phase
--[[
(ability.id = 322236 or ability.id = 322475) and type = "begincast"
 or ability.id = 322304 and type = "cast"
--]]
local specWarnSpawn					= mod:NewSpecialWarningSwitch(322304, "-Healer", nil, nil, 1, 7)
local specWarnTouchofSlime			= mod:NewSpecialWarningSoak(257314, "Tank", nil, nil, 1, 7)
local specWarnPlagueCrash			= mod:NewSpecialWarningDodgeCount(322477, nil, nil, nil, 2, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerSpawnCD					= mod:NewCDTimer(20.6, 322304, nil, nil, nil, 1, nil, DBM_CORE_L.TANK_ICON .. DBM_CORE_L.DAMAGE_ICON)
local timerTouchofSlimeCD			= mod:NewCDTimer(6, 322236, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)

mod.vb.crashCount = 0

function mod:OnCombatStart(delay)
	self.vb.crashCount = 0
	timerSpawnCD:Start(5.8-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 322236 then
		specWarnTouchofSlime:Show()
		specWarnTouchofSlime:Play("helpsoak")
		timerTouchofSlimeCD:Start(6, args.sourceGUID)
	elseif spellId == 322475 and self:AntiSpam(4, 1) then
		self.vb.crashCount = self.vb.crashCount + 1
		specWarnPlagueCrash:Show(self.vb.crashCount)
		specWarnPlagueCrash:Play("watchstep")
--		timerSpawnCD:Stop()--On mythic this will need code changes this should only actually be stopped at health triggers
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 322304 then
		specWarnSpawn:Show()
		specWarnSpawn:Play("killmob")
		timerSpawnCD:Start()
		timerTouchofSlimeCD:Start(6)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 165430 then--Malignant Spawn
		timerTouchofSlimeCD:Stop(args.destGUID)
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 194966 then

	end
end

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
