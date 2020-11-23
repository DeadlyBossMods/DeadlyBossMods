local mod	= DBM:NewMod(2419, "DBM-Party-Shadowlands", 2, 1183)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164255)
mod:SetEncounterID(2382)

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
 or ability.id = 335514
 --327598 is trash version of spell
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

local timerPlaguestompCD			= mod:NewNextTimer(15.8, 324527, nil, nil, nil, 3)--38.8, 19.4
local timerBeckonSlimeCD			= mod:NewCDTimer(49.8, 327608, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)--50-55
local timerBeckonSlime				= mod:NewCastTimer(7, 327608, nil, nil, nil, 5, nil, DBM_CORE_L.DAMAGE_ICON)
local timerSlimeWaveCD				= mod:NewNextTimer(10.5, 324667, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerSpecialCD				= mod:NewNextSpecialTimer(40)

mod.vb.specialCast = 0

function mod:OnCombatStart(delay)
	self.vb.specialCast = 0
	timerSpecialCD:Start(8.3)--First spell can be either Plaguestomp or slime wave
	timerBeckonSlimeCD:Start(25-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 324527 then
		self.vb.lastCast = self.vb.specialCast + 1
		warnPlaguestomp:Show()
--		specWarnPlaguestomp:Show()
--		specWarnPlaguestomp:Play("shockwave")
		if self.vb.specialCast == 1 or self.vb.specialCast == 2 then--First means opposite in 7 seconds
			timerSlimeWaveCD:Start(7)
		end
	elseif spellId == 324667 then
		self.vb.specialCast = self.vb.specialCast + 1
		warnSlimeWave:Show()
		if self.vb.specialCast == 1 or self.vb.specialCast == 3 then--First and third means opposite in 7 seconds
			timerPlaguestompCD:Start(7)
		elseif self.vb.specialCast == 2 then--Second being slime wave means next is another slime wave in 11
			timerSlimeWaveCD:Start(11)
		end
	end
end

--25.595	Globgrog casts Beckon Slime
--25.595	Globgrog begins casting Beckon Slime
--30.601	Globgrog casts Beckon Slime
--32.612	Living Slime Stalker 1 summons Slimy Morsel 1 with Beckon Slime
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 324459 then--Precast event
		warnBeckonSlime:Show()
		timerBeckonSlime:Start(7)
		timerBeckonSlimeCD:Start()
		timerSpecialCD:Stop()
		timerSlimeWaveCD:Stop()
		timerPlaguestompCD:Stop()
	elseif spellId == 324490 then--Summon finish event, which is still good 4 seconds before attackable
		specWarnBeckonSlime:Show()
		if self:IsTank() then
			specWarnBeckonSlime:Play("moveboss")
		else
			specWarnBeckonSlime:Play("killmob")
		end
		--Resets the sequence for slime wave/plaguestomp
		self.vb.specialCast = 0
		timerSpecialCD:Start(18)--Which means one is cast (slime or plague seems to be toss up)
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
