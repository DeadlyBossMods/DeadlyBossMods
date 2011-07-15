local mod	= DBM:NewMod(196, "DBM-Firelands", nil, 78)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(53494)
mod:SetModelID(38621)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod:SetModelSound("Sound\\Creature\\BALEROC\\VO_FL_BALEROC_AGGRO.wav", "Sound\\Creature\\BALEROC\\VO_FL_BALEROC_KILL_02.wav")
--Long: You are forbidden from entering my masters domain mortals.
--Short: You have been judged

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warnDecimationBlade	= mod:NewSpellAnnounce(99352, 4, nil, mod:IsTank() or mod:IsHealer())
local warnInfernoBlade		= mod:NewSpellAnnounce(99350, 3, nil, mod:IsTank())
local warnShardsTorment		= mod:NewCastAnnounce(99259, 3)
local warnCountdown			= mod:NewTargetAnnounce(99516, 4)
local yellCountdown			= mod:NewYell(99516)

local specWarnShardsTorment	= mod:NewSpecialWarningSpell(99259, nil, nil, nil, true)
local specWarnCountdown		= mod:NewSpecialWarningYou(99516)
local specWarnDecimation	= mod:NewSpecialWarningSpell(99352, mod:IsTank())

local timerBladeActive		= mod:NewTimer(15, "TimerBladeActive", 99352)
local timerBladeNext		= mod:NewTimer(30, "TimerBladeNext", 99350, mod:IsTank() or mod:IsHealer())	-- either Decimation Blade or Inferno Blade
local timerShardsTorment	= mod:NewNextTimer(34, 99259)
local timerCountdown		= mod:NewBuffActiveTimer(8, 99516)
local timerCountdownCD		= mod:NewCDTimer(45, 99516)

local ShardsCountown		= mod:NewCountdown(34, 99259, false)

local berserkTimer			= mod:NewBerserkTimer(360)

mod:AddBoolOption("InfoFrame", mod:IsHealer())
mod:AddBoolOption("SetIconOnCountdown")
mod:AddBoolOption("SetIconOnTorment")
mod:AddBoolOption("ArrowOnCountdown")

local tormentIcon = 8
local countdownIcon = 2
local countdownTargets = {}

local function showCountdownWarning()
	warnCountdown:Show(table.concat(countdownTargets, "<, >"))
	table.wipe(countdownTargets)
	countdownIcon = 2
end

function mod:OnCombatStart(delay)
	timerBladeNext:Start(-delay)
	timerCountdownCD:Start(-delay)
--	timerShardsTorment:Start(-delay)--This is cast nearly instantly on pull, so this timer on pull is useless or at most like 5 seconds commenting for now.
	table.wipe(countdownTargets)
	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(L.VitalSpark)
		DBM.InfoFrame:Show(5, "playerbuffstacks", 99262, 99263, 1)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(99516) then
		timerCountdown:Start()
		timerCountdownCD:Start()
		countdownTargets[#countdownTargets + 1] = args.destName
		if self.Options.SetIconOnCountdown then
			self:SetIcon(args.destName, countdownIcon, 8)
			countdownIcon = countdownIcon - 1
		end
		if args:IsPlayer() then
			specWarnCountdown:Show()
			yellCountdown:Yell()
		end
		if self.Options.ArrowOnCountdown and #countdownTargets == 2 then
			if countdownTargets[1] == UnitName("player") then
				DBM.Arrow:ShowRunAway(countdownTargets[2])
			elseif countdownTargets[2] == UnitName("player") then
				DBM.Arrow:ShowRunAway(countdownTargets[1])
			end
		end
		self:Unschedule(showCountdownWarning)
		self:Schedule(0.5, showCountdownWarning)
	elseif args:IsSpellID(99256, 100230, 100231, 100232) then--Torment
		if self.Options.SetIconOnTorment then
			self:SetIcon(args.destName, tormentIcon)
			tormentIcon = tormentIcon - 1
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(99352, 99405) or args:IsSpellID(99350) then
		timerBladeNext:Start()--30 seconds after last blades FADED
	elseif args:IsSpellID(99256, 100230, 100231, 100232) then--Torment
		if self.Options.SetIconOnTorment then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(99352, 99405) then	--99352 confirmed
		warnDecimationBlade:Show()
		specWarnDecimation:Show()
		timerBladeActive:Start(args.spellName)
	elseif args:IsSpellID(99350) then
		warnInfernoBlade:Show()
		timerBladeActive:Start(args.spellName)
	elseif args:IsSpellID(99259) then
		tormentIcon = 8
		warnShardsTorment:Show()
		specWarnShardsTorment:Schedule(1.5)
		timerShardsTorment:Start()
		ShardsCountown:Start(34)
	end
end