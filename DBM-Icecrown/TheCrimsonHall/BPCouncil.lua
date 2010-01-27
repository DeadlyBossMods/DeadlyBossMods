local mod	= DBM:NewMod("BPCouncil", "DBM-Icecrown", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(37970, 37972, 37973)
mod:SetUsedIcons(7, 8)

mod:SetBossHealthInfo(
	37972, L.Keleseth,
	37970, L.Valanar,
	37973, L.Taldaram
)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_SUMMON",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_TARGET"
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
local specWarnEmpoweredShockV	= mod:NewSpecialWarningRun(72039)

local timerTargetSwitch			= mod:NewTimer(47, "TimerTargetSwitch")	-- every 46-47seconds
local timerDarkNucleusCD		= mod:NewCDTimer(10, 71943)				-- usually every 10 seconds but sometimes more
local timerConjureFlamesCD		= mod:NewCDTimer(20, 71718)				-- every 20-30 seconds but never more often than every 20sec
local timerShockVortex			= mod:NewCDTimer(16.5, 72037)			-- Seen a range from 16,8 - 21,6

local berserkTimer				= mod:NewBerserkTimer(600)

local soundEmpoweredFlames		= mod:NewSound(72040)
mod:AddBoolOption("EmpoweredFlameIcon", true)
mod:AddBoolOption("ActivePrinceIcon", false)

local activePrince
function mod:OnCombatStart(delay)
	warnTargetSwitchSoon:Schedule(42-delay)
	timerTargetSwitch:Start(-delay)
	activePrince = nil
end

function mod:TrySetTarget()
	if DBM:GetRaidRank() >= 1 then
		for i = 1, GetNumRaidMembers() do
			if UnitGUID("raid"..i.."target") == activePrince then
				activePrince = nil
				SetRaidTarget("raid"..i.."target", 8)
			end
			if not (activePrince) then
				break
			end
		end
	end
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(72037) then		-- Shock Vortex
		warnShockVortex:Show()
		timerShockVortex:Start()
	elseif args:IsSpellID(72039, 73037, 73038, 73039) then	-- Empowered Shock Vortex(73037, 73038, 73039 drycoded from wowhead)
		warnEmpoweredShockVortex:Show()
		specWarnEmpoweredShockV:Show()
		timerShockVortex:Start()
	elseif args:IsSpellID(71718) then	-- Conjure Flames
		warnConjureFlames:Show()
		timerConjureFlamesCD:Start()
	elseif args:IsSpellID(72040) then	-- Conjure Empowered Flames
		warnEmpoweredFlamesCast:Show()
		timerConjureFlamesCD:Start()
--	elseif args:IsSpellID(72053, 72080) then--Currently not working. The casts aren't shown i the combat log. This fight is really buggy for combat logs
--		warnKineticBomb:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(72052, 72800, 72801, 72802) then--This does show in combat log (explosion when kinetic bomb hits the ground)
		warnKineticBomb:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70952) and self:IsInCombat() then
		warnTargetSwitch:Show(L.Valanar)
		warnTargetSwitchSoon:Schedule(42)
		timerTargetSwitch:Start()
		activePrince = args.destGUID
	elseif args:IsSpellID(70981) and self:IsInCombat() then
		warnTargetSwitch:Show(L.Keleseth)
		warnTargetSwitchSoon:Schedule(42)
		timerTargetSwitch:Start()
		activePrince = args.destGUID
	elseif args:IsSpellID(70982) and self:IsInCombat() then
		warnTargetSwitch:Show(L.Taldaram)
		warnTargetSwitchSoon:Schedule(42)
		timerTargetSwitch:Start()
		activePrince = args.destGUID
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(71943) then
		warnDarkNucleus:Show()
		timerDarkNucleusCD:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:match(L.EmpoweredFlames) then
		self:SendSync("EmpoweredFlame", target)
	end
end

function mod:UNIT_TARGET()
	if activePrince then
		self:TrySetTarget()
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
			self:SetIcon(target, 7, 10)
		end
	end
end
