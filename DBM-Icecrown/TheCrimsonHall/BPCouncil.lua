local mod	= DBM:NewMod("BPCouncil", "DBM-Icecrown", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(37970, 37972, 37973)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_SUMMON",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnTargetSwitch			= mod:NewAnnounce("WarnTargetSwitch", 3)
local warnTargetSwitchSoon		= mod:NewAnnounce("WarnTargetSwitchSoon", 2)
local warnConjureFlames			= mod:NewCastAnnounce(71718)
local warnEmpoweredFlamesCast	= mod:NewCastAnnounce(72040)
local warnEmpoweredFlames		= mod:NewTargetAnnounce(72040)
local warnShockVortex			= mod:NewCastAnnounce(72037)			-- 1,5sec cast
local warnEmpoweredShockVortex	= mod:NewCastAnnounce(72039)			-- 4,5sec cast
local warnKineticBomb			= mod:NewSpellAnnounce(72053)
local warnDarkNucleus			= mod:NewSpellAnnounce(71943)			-- instant cast

local specWarnEmpoweredFlames	= mod:NewSpecialWarningRun(72040)

local timerTargetSwitch			= mod:NewTimer(47, "TimerTargetSwitch")--every 46-47seconds
local timerDarkNucleusCD		= mod:NewCDTimer(10, 71943)--usually every 10 seconds but sometimes more
local timerConjureFlamesCD		= mod:NewCDTimer(20, 71718)--every 20-30 seconds but never more often than every 20sec
local timerShockVortex			= mod:NewCDTimer(16.5, 72037)			-- Seen a range from 16,8 - 21,6

local soundEmpoweredFlames		= mod:NewSound(72040)
mod:AddBoolOption("EmpoweredFlameIcon", true)

function mod:OnCombatStart(delay)
	warnTargetSwitchSoon:Schedule(42-delay)
	timerTargetSwitch:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(72037) then		-- Shock Vortex
		warnShockVortex:Show()
		timerShockVortex:Start()
	elseif args:IsSpellID(72039, 73037, 73038, 73039) then	-- Empowered Shock Vortex(73037, 73038, 73039 drycoded from wowhead)
		warnEmpoweredShockVortex:Show()
		timerShockVortex:Start()
	elseif args:IsSpellID(71718) then	-- Conjure (Inferno) Flames
		warnConjureFlames:Show()
		timerConjureFlamesCD:Start()
	elseif args:IsSpellID(72040) then	-- Conjure Empowered Flames
		warnEmpoweredFlamesCast:Show()
		timerConjureFlamesCD:Start()
	elseif args:IsSpellID(72053, 72080) then
		warnKineticBomb:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70952) then
		warnTargetSwitch:Show(L.Valanar)
		warnTargetSwitchSoon:Schedule(42)
		timerTargetSwitch:Start()
	elseif args:IsSpellID(70981) then
		warnTargetSwitch:Show(L.Keleseth)
		warnTargetSwitchSoon:Schedule(42)
		timerTargetSwitch:Start()
	elseif args:IsSpellID(70982) then
		warnTargetSwitch:Show(L.Taldaram)
		warnTargetSwitchSoon:Schedule(42)
		timerTargetSwitch:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(71943) then
		warnDarkNucleus:Show()
		timerDarkNucleusCD:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	local target = msg and msg:match(L.EmpoweredFlames)
	if target then
		self:SendSync("EmpoweredFlame", target)
	end
end

function mod:OnSync(msg, target)
	if msg == "EmpoweredFlame" then
		warnEmpoweredFlames:Show(target)
		if target == UnitName("player") then
			specWarnEmpoweredFlames:Show()
			soundEmpoweredFlames:Play()
		end
		if self.Options.EmpoweredFlameIcon then
			self:SetIcon(target, 8, 10)
		end
	end
end