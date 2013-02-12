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

local warnRockfall					= mod:NewSpellAnnounce(134476, 2)
local warnCallofTortos				= mod:NewSpellAnnounce(136294, 3)
local warnQuakeStomp				= mod:NewSpellAnnounce(134920, 3)
local warnStoneBreath				= mod:NewCastAnnounce(133939, 4)
--maybe look for 140701 in combat log as well (Crystal Shell: Full Capacity!)

local specWarnCallofTortos			= mod:NewSpecialWarningSpell(136294)
local specWarnQuakeStomp			= mod:NewSpecialWarningSpell(134920, nil, nil, nil, true)
local specWarnStoneBreath			= mod:NewSpecialWarningInterrupt(133939)
local specWarnCrystalShell			= mod:NewSpecialWarning("specWarnCrystalShell", not mod:IsTank())--Tanks need it too, but they don't just blindly grab it any time it's gone like dps do, they must be at full health whent hey do or it REALLY messes up bats, so a tank needs to often ignore this warning until timing is right

local timerRockfallCD				= mod:NewCDTimer(10, 134476)
local timerCallTortosCD				= mod:NewCDTimer(60.5, 136294)
local timerStompCD					= mod:NewCDTimer(49, 134920)
local timerBreathCD					= mod:NewCDTimer(49, 133939)
local timerStompActive				= mod:NewBuffActiveTimer(10.8, 134920)--Duration of the rapid caveins

mod:AddBoolOption("InfoFrame")

local stompActive = false
local firstRockfall = false--First rockfall after a stomp
local shelldName = GetSpellInfo(137633)
local rockRemaining = 0

local function clearStomp()
	stompActive = false
	firstRockfall = false--First rockfall after a stomp
	timerRockfallCD:Start(5)--Resume normal CDs, first should be 5 seconds after stomp spammed ones
end

function mod:OnCombatStart(delay)
	stompActive = false
	firstRockfall = false--First rockfall after a stomp
	timerRockfallCD:Start(15-delay)
	timerCallTortosCD:Start(21-delay)
	timerStompCD:Start(30-delay)
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
	elseif args:IsSpellID(134920) then
		stompActive = true
		warnQuakeStomp:Show()
		specWarnQuakeStomp:Show()
		timerStompActive:Show()
		timerStompCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(137633) then
		warnCrystalShellVictom:Show(args.destName)
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
			if not firstRockfall then--But not until last cd finishes out.
				warnRockfall:Show()
				timerRockfallCD:Start()
				firstRockfall = true
				self:Schedule(9, clearStomp)
			end
		else
			warnRockfall:Show()
			timerRockfallCD:Start()
		end
	end
end

