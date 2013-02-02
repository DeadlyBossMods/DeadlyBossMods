if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
local mod	= DBM:NewMod(825, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(67977)
mod:SetModelID(46559)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnRockfall					= mod:NewSpellAnnounce(134476, 2)
local warnCallofTortos				= mod:NewSpellAnnounce(136294, 3)
local warnQuakeStomp				= mod:NewSpellAnnounce(134920, 3)
local warnStoneBreath				= mod:NewCastAnnounce(133939, 4)

local specWarnCallofTortos			= mod:NewSpecialWarningSpell(136294)
local specWarnQuakeStomp			= mod:NewSpecialWarningSpell(134920, nil, nil, nil, true)
local specWarnStoneBreath			= mod:NewSpecialWarningInterrupt(133939)

local timerRockfallCD				= mod:NewCDTimer(14, 134476)
local timerCallTortosCD				= mod:NewCDTimer(60.5, 136294)
local timerStompCD					= mod:NewCDTimer(49, 134920)
local timerBreathCD					= mod:NewCDTimer(49, 133939)
local timerStompActive				= mod:NewBuffActiveTimer(10.8, 134920)--Duration of the rapid caveins

local stompActive = false

local function clearStomp()
	stompActive = false
	timerRockfallCD:Start(5)--Resume normal CDs, first should be 5 seconds after stomp spammed ones
end

function mod:OnCombatStart(delay)
	stompActive = false
	timerRockfallCD:Start(20-delay)
	timerCallTortosCD:Start(21-delay)
	timerStompCD:Start(30-delay)
	timerBreathCD:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(133939) then
		warnStoneBreath:Show()
		specWarnStoneBreath:Show(args.sourceName)
		timerBreathCD:Start()
	elseif args:IsSpellID(136294) then
		warnCallofTortos:Show()
		specWarnCallofTortos:Show()
		timerCallTortosCD:Start()
	elseif args:IsSpellID(134920) then
		stompActive = true
		warnQuakeStomp:Show()
		specWarnQuakeStomp:Show()
		timerStompActive:Show()
		timerStompCD:Start()
		self:Schedule(10.8, clearStomp)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(134476) and not stompActive then--14 second cd normally, but for 9 seconds after stomp, cd is 1 second and it is cast about 8 times in that 9 seconds
		warnRockfall:Show()
		timerRockfallCD:Start()
	end
end

