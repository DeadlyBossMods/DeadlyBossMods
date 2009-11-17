local mod	= DBM:NewMod("BPCouncil", "DBM-Icecrown", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
mod:SetCreatureID(37970, 37972, 37973)
--mod:SetUsedIcons(3, 4, 5, 6, 7, 8)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

local warnTargetSwitch		= mod:NewAnnounce("WarnTargetSwitch", 3)
local warnTargetSwitchSoon	= mod:NewAnnounce("WarnTargetSwitchSoon", 2)

local timerTargetSwitch		= mod:NewTimer(31, "TimerTargetSwitch")



--[[
70982 Taldaram		71582 = 10man ??
70952 Valanar		70934 = 10man ??
70981 Keleseth		71596 = 10man ??

11/13 20:07:05.539  SPELL_CAST_SUCCESS,0xF13094780000307C,"Blood Orb Controller",0xa48,0x0000000000000000,nil,0x80000000,71079,"Invocation of Blood (K) Move",0x1
11/13 20:20:46.015  SPELL_CAST_SUCCESS,0xF130947800006063,"Blood Orb Controller",0xa48,0x0000000000000000,nil,0x80000000,71082,"Invocation of Blood (T) Move",0x1
11/13 20:21:53.459  SPELL_CAST_SUCCESS,0xF130947800006063,"Blood Orb Controller",0xa48,0x0000000000000000,nil,0x80000000,71075,"Invocation of Blood (V) Move",0x1
]]--


local currentTarget = "none"

function mod:OnCombatStart(delay)
	warnTargetSwitchSoon:Schedule(26-delay)
	currentTarget = "none"
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellId(71075) and not currentTarget = "V" then
		warnTargetSwitch:Show(L.Valanar)
		warnTargetSwitchSoon:Schedule(26)
		currentTarget = "V"
	elseif args:IsSpellId(71079) and not currentTarget = "K" then
		warnTargetSwitch:Show(L.Keleseth)
		warnTargetSwitchSoon:Schedule(26)
		currentTarget = "K"
	elseif args:IsSpellId(71082) and not currentTarget = "T" then
		warnTargetSwitch:Show(L.Taldaram)
		warnTargetSwitchSoon:Schedule(26)
		currentTarget = "T"
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellId(70952) and not currentTarget = "V" then
		warnTargetSwitch:Show(L.Valanar)
		warnTargetSwitchSoon:Schedule(26)
		currentTarget = "V"
	elseif args:IsSpellId(70981) and not currentTarget = "K" then
		warnTargetSwitch:Show(L.Keleseth)
		warnTargetSwitchSoon:Schedule(26)
		currentTarget = "K"
	elseif args:IsSpellId(70982) and not currentTarget = "T" then
		warnTargetSwitch:Show(L.Taldaram)
		warnTargetSwitchSoon:Schedule(26)
		currentTarget = "T"
	end
end