if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
local mod	= DBM:NewMod(825, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(67977)
mod:SetModelID(46559)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnBite						= mod:NewSpellAnnounce(135251, 3, nil, mod:IsTank())
local warnRockfall					= mod:NewSpellAnnounce(134476, 2)
local warnCallofTortos				= mod:NewSpellAnnounce(136294, 3)
local warnQuakeStomp				= mod:NewSpellAnnounce(134920, 3)
local warnKickShell					= mod:NewAnnounce("warnKickShell", 2, 134031)
local warnStoneBreath				= mod:NewCastAnnounce(133939, 4)

local specWarnCallofTortos			= mod:NewSpecialWarningSpell(136294)
local specWarnQuakeStomp			= mod:NewSpecialWarningSpell(134920, nil, nil, nil, 2)
local specWarnRockfall				= mod:NewSpecialWarningSpell(134476, false, nil, nil, 2)
local specWarnStoneBreath			= mod:NewSpecialWarningInterrupt(133939)
local specWarnCrystalShell			= mod:NewSpecialWarning("specWarnCrystalShell", not mod:IsTank())--Tanks need it too, but they don't just blindly grab it any time it's gone like dps do, they must be at full health whent hey do or it REALLY messes up bats, so a tank needs to often ignore this warning until timing is right

local timerBiteCD					= mod:NewCDTimer(8, 135251, nil, mod:IsTank())
local timerRockfallCD				= mod:NewCDTimer(10, 134476)
local timerCallTortosCD				= mod:NewCDTimer(60.5, 136294)
local timerStompCD					= mod:NewCDTimer(49, 134920)
local timerBreathCD					= mod:NewCDTimer(49, 133939)
local timerStompActive				= mod:NewBuffActiveTimer(10.8, 134920)--Duration of the rapid caveins

mod:AddBoolOption("InfoFrame")

local stompActive = false
local firstRockfall = false--First rockfall after a stomp
local shelldName = GetSpellInfo(137633)
local shellsRemaining = 0

local function clearStomp()
	stompActive = false
	firstRockfall = false--First rockfall after a stomp
	warnRockfall:Show()
	timerRockfallCD:Start()--Resume normal CDs, first should be 5 seconds after stomp spammed ones
end

function mod:OnCombatStart(delay)
	stompActive = false
	firstRockfall = false--First rockfall after a stomp
	shellsRemaining = 0
	timerRockfallCD:Start(15-delay)
	timerCallTortosCD:Start(21-delay)
	timerStompCD:Start(29-delay)
	timerBreathCD:Start(-delay)
	if self.Options.InfoFrame and self:IsDifficulty("heroic10", "heroic25") then
		DBM.InfoFrame:SetHeader(L.WrongDebuff:format(shelldName))
		DBM.InfoFrame:Show(5, "playergooddebuff", 137633)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
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
	elseif args:IsSpellID(135251) then
		warnBite:Show()
		timerBiteCD:Start()
	elseif args:IsSpellID(134920) then
		stompActive = true
		warnQuakeStomp:Show()
		specWarnQuakeStomp:Show()
		timerStompActive:Show()
		timerRockfallCD:Start(7.4)--When the spam of rockfalls start
		timerStompCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(133971) then--Shell Block (turtles dying and becoming kickable)
		shellsRemaining = shellsRemaining + 1
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(137633) and args:IsPlayer() then
		specWarnCrystalShell:Show(shelldName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(134476) then
		if stompActive then--10 second cd normally, but cd is disabled when stomp active
			if not firstRockfall then--Announce first one only and ignore the next ones spammed for about 9-10 seconds
				firstRockfall = true
				warnRockfall:Show()
				specWarnRockfall:Show()--To warn of massive incoming for the 9 back to back rockfalls that are incoming
				self:Schedule(10, clearStomp)
			end
		else
			if self:AntiSpam(9, 1) then--sometimes clearstomp doesn't work? i can't find reason cause all logs match this system exactly.
				warnRockfall:Show()
				timerRockfallCD:Start()
			end
		end
	elseif args:IsSpellID(134031) then--Kick Shell
		shellsRemaining = shellsRemaining - 1
		warnKickShell:Show(args.spellName, args.sourceName, shellsRemaining)
	end
end

