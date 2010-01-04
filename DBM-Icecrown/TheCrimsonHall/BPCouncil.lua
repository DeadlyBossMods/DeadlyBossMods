local mod	= DBM:NewMod("BPCouncil", "DBM-Icecrown", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(37970, 37972, 37973)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

local isTank	= UnitHealth("player") > 40000			-- check if player is a tank based on HP

local warnTargetSwitch		= mod:NewAnnounce("WarnTargetSwitch", 3)
local warnTargetSwitchSoon	= mod:NewAnnounce("WarnTargetSwitchSoon", 2)
local warnConjureFlames		= mod:NewSpellAnnounce(72040)
local warnDarkNucleus		= mod:NewSpellAnnounce(71943)			-- instant cast
local warnShockVortex		= mod:NewCastAnnounce(72037)			-- 1,5sec cast

local specWarnResonance		= mod:NewSpecialWarning("SpecWarnResonance", isTank)

local timerTargetSwitch		= mod:NewTimer(31, "TimerTargetSwitch")
local timerDarkNucleus		= mod:NewNextTimer(15, 71943)			-- Seen a range from 14,9 - 16,8
local timerShockVortex		= mod:NewNextTimer(16.5, 72037)			-- Seen a range from 16,8 - 21,6 

--[[
70982 Taldaram		71582 = 10man ??
70952 Valanar		70934 = 10man ??
70981 Keleseth		71596 = 10man ??

11/13 20:07:05.539  SPELL_CAST_SUCCESS,0xF13094780000307C,"Blood Orb Controller",0xa48,0x0000000000000000,nil,0x80000000,71079,"Invocation of Blood (K) Move",0x1
11/13 20:20:46.015  SPELL_CAST_SUCCESS,0xF130947800006063,"Blood Orb Controller",0xa48,0x0000000000000000,nil,0x80000000,71082,"Invocation of Blood (T) Move",0x1
11/13 20:21:53.459  SPELL_CAST_SUCCESS,0xF130947800006063,"Blood Orb Controller",0xa48,0x0000000000000000,nil,0x80000000,71075,"Invocation of Blood (V) Move",0x1
]]--


local currentPrince = "none"

function mod:OnCombatStart(delay)
	warnTargetSwitchSoon:Schedule(26-delay)
	currentPrince = "none"
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(72037) then			-- Shock Vortex
		warnShockVortex:Show()
		timerShockVortex:Start()
	elseif args:IsSpellID(71943) then		-- Dark Nucleus
		warnDarkNucleus:Show()
		timerDarkNucleus:Start()
	elseif args:IsSpellID(71718, 72049) then	-- Conjure (Inferno) Flames
		warnConjureFlames:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(71075) and not currentPrince == "V" then
		warnTargetSwitch:Show(L.Valanar)
		warnTargetSwitchSoon:Schedule(26)
		currentPrince = "V"
	elseif args:IsSpellID(71079) and not currentPrince == "K" then
		warnTargetSwitch:Show(L.Keleseth)
		warnTargetSwitchSoon:Schedule(26)
		currentPrince = "K"
	elseif args:IsSpellID(71082) and not currentPrince == "T" then
		warnTargetSwitch:Show(L.Taldaram)
		warnTargetSwitchSoon:Schedule(26)
		currentPrince = "T"
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70952) and not currentPrince == "V" then
		warnTargetSwitch:Show(L.Valanar)
		warnTargetSwitchSoon:Schedule(26)
		currentPrince = "V"
	elseif args:IsSpellID(70981) and not currentPrince == "K" then
		warnTargetSwitch:Show(L.Keleseth)
		warnTargetSwitchSoon:Schedule(26)
		currentPrince = "K"
	elseif args:IsSpellID(70982) and not currentPrince == "T" then
		warnTargetSwitch:Show(L.Taldaram)
		warnTargetSwitchSoon:Schedule(26)
		currentPrince = "T"
	elseif args:IsSpellID(71822) and args:IsPlayer() then		-- Shadow Resonance
		specWarnResonance:Show()
	end
end