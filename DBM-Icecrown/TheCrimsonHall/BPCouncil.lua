local mod	= DBM:NewMod("BPCouncil", "DBM-Icecrown", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(37970, 37972, 37973)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_SUMMON"
)

local notTank	= UnitHealth("player") < 40000			-- check if player is a tank based on HP

local warnTargetSwitch		= mod:NewAnnounce("WarnTargetSwitch", 3)
local warnTargetSwitchSoon	= mod:NewAnnounce("WarnTargetSwitchSoon", 2)
local warnConjureFlames		= mod:NewSpellAnnounce(72040)
local warnKineticBomb		= mod:NewSpellAnnounce(72053)
local warnDarkNucleus		= mod:NewSpellAnnounce(71943)			-- instant cast
local warnShockVortex		= mod:NewCastAnnounce(72037)			-- 1,5sec cast

local specWarnShadResonance	= mod:NewSpecialWarningMove(71822, notTank, "ShadowResonance")

local timerTargetSwitch		= mod:NewTimer(35, "TimerTargetSwitch")
local timerDarkNucleus		= mod:NewNextTimer(15, 71943)			-- Seen a range from 14,9 - 16,8
local timerShockVortex		= mod:NewNextTimer(16.5, 72037)			-- Seen a range from 16,8 - 21,6 

--[[
70982 Taldaram		71582 = 10man ??
70952 Valanar		70934 = 10man ??
70981 Keleseth		71596 = 10man ??
]]--

function mod:OnCombatStart(delay)
	warnTargetSwitchSoon:Schedule(30-delay)
	timerTargetSwitch:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(72037) then			-- Shock Vortex
		warnShockVortex:Show()
		timerShockVortex:Start()
	elseif args:IsSpellID(71718, 72040) then	-- Conjure (Inferno) Flames
		warnConjureFlames:Show()
	elseif args:IsSpellID(72053) then
		warnKineticBomb:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70952) then
		warnTargetSwitch:Show(L.Valanar)
		warnTargetSwitchSoon:Schedule(30)
		timerTargetSwitch:Start()
	elseif args:IsSpellID(70981) then
		warnTargetSwitch:Show(L.Keleseth)
		warnTargetSwitchSoon:Schedule(30)
		timerTargetSwitch:Start()
	elseif args:IsSpellID(70982) then
		warnTargetSwitch:Show(L.Taldaram)
		warnTargetSwitchSoon:Schedule(30)
		timerTargetSwitch:Start()
	elseif args:IsSpellID(71822) and args:IsPlayer() then		-- Shadow Resonance
		specWarnShadResonance:Show()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(71943) then
		warnDarkNucleus:Show()
		timerDarkNucleus:Start()
	end
end
