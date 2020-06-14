local mod	= DBM:NewMod(2419, "DBM-Party-Shadowlands", 2, 1183)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164255)
mod:SetEncounterID(2382)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 324652",
	"SPELL_CAST_START 324527 324667",
	"SPELL_CAST_SUCCESS 324459 324490"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 324527 or ability.id = 324667) and type = "begincast"
 or (ability.id = 324459 or ability.id = 324490) and type = "cast"
--]]
local warnPlaguestomp				= mod:NewCastAnnounce(324527, 2)
local warnSlimeWave					= mod:NewCastAnnounce(324667, 2)
local warnBeckonSlime				= mod:NewCastAnnounce(324459, 2, 9)

--local specWarnPlaguestomp			= mod:NewSpecialWarningDodge(324527, nil, nil, nil, 2, 2)
local specWarnDebilitatingPlague	= mod:NewSpecialWarningDispel(324652, "RemoveDisease", nil, nil, 1, 2)
local specWarnBeckonSlime			= mod:NewSpecialWarningSwitch(327608, "-Healer", nil, nil, 1, 2)
--local yellBlackPowder				= mod:NewYell(257314)
--local specWarnHealingBalm			= mod:NewSpecialWarningInterrupt(257397, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerPlaguestompCD			= mod:NewCDTimer(15.8, 324527, nil, nil, nil, 3)
local timerBeckonSlimeCD			= mod:NewCDTimer(54.2, 327608, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)
local timerBeckonSlime				= mod:NewCastTimer(9, 327608, nil, nil, nil, 5, nil, DBM_CORE_L.DAMAGE_ICON)
local timerSlimeWaveCD				= mod:NewCDTimer(10.5, 324667, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerPlaguestompCD:Start(11-delay)
	timerSlimeWaveCD:Start(19-delay)
	timerBeckonSlimeCD:Start(25-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 324527 then
		warnPlaguestomp:Show()
--		specWarnPlaguestomp:Show()
--		specWarnPlaguestomp:Play("shockwave")
		timerPlaguestompCD:Start()
	elseif spellId == 324667 then
		warnSlimeWave:Show()
		timerSlimeWaveCD:Start()
	end
end

--25.595	Globgrog casts Beckon Slime
--25.595	Globgrog begins casting Beckon Slime
--30.601	Globgrog casts Beckon Slime
--34.612	Living Slime Stalker 1 summons Slimy Morsel 1 with Beckon Slime
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 324459 then--Precast event
		warnBeckonSlime:Show()
		timerBeckonSlime:Start(9)
		timerBeckonSlimeCD:Start()
		timerSlimeWaveCD:Stop()
		timerPlaguestompCD:Stop()
	elseif spellId == 324490 then--Summon finish event, which is still good 4 seconds before attackable
		specWarnBeckonSlime:Show()
		if self:IsTank() then
			specWarnBeckonSlime:Play("moveboss")
		else
			specWarnBeckonSlime:Play("killmob")
		end
		--Likely not right place to do this
		timerPlaguestompCD:Start(18)
		timerSlimeWaveCD:Start(25)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 324652 and self:CheckDispelFilter() then
		specWarnDebilitatingPlague:CombinedShow(0.3, args.destName)
		specWarnDebilitatingPlague:ScheduleVoice(0.3, args.destName)
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 168128 then--Slimy Morsel

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
