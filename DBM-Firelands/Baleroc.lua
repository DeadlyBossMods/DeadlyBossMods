local mod	= DBM:NewMod(196, "DBM-Firelands", nil, 78)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(53494)
mod:SetModelID(38621)
mod:SetZone()
mod:SetUsedIcons(8, 6)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warnDecimationBlade	= mod:NewSpellAnnounce(99352, 3)
local warnInfernoBlade		= mod:NewSpellAnnounce(99350, 3)
local warnShardsTorment		= mod:NewSpellAnnounce(99259, 3)
local warnCountdown			= mod:NewTargetAnnounce(99516, 4)
local yellCountdown			= mod:NewYell(99516)

local timerBladeActive		= mod:NewTimer(15, "TimerBladeActive")
local timerBladeNext		= mod:NewTimer(30, "TimerBladeNext")	-- either Decimation Blade or Inferno Blade
local timerShardsTorment	= mod:NewNextTimer(34, 99259)
local timerCountdown		= mod:NewBuffActiveTimer(8, 99516)

local specWarnShardsTorment	= mod:NewSpecialWarningSpell(99259, nil, nil, nil, true)
local specWarnCountdown		= mod:NewSpecialWarningYou(99516)

local berserkTimer		= mod:NewBerserkTimer(360)

mod:AddBoolOption("InfoFrame", false)
mod:AddBoolOption("SetIconOnCountdown")
mod:AddBoolOption("ArrowOnCountdown")

local countdownIcon = 8
local countdownTargets = {}

local function showCountdownWarning()
	warnCountdown:Show(table.concat(countdownTargets, "<, >"))

	table.wipe(countdownTargets)
	countdownIcon = 8
end

function mod:OnCombatStart(delay)
	timerBladeNext:Start(-delay)
	timerShardsTorment:Start(-delay)
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
		countdownTargets[#countdownTargets + 1] = args.destName
		if self.Options.SetIconOnCountdown then
			self:SetIcon(args.destName, countdownIcon, 8)
			countdownIcon = countdownIcon - 2   -- avoid "7" (cross)
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
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(99352, 99405) or args:IsSpellID(99350) then
		timerBladeNext:Start()--30 seconds after last blades FADED
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(99352, 99405) then	--99352 confirmed
		warnDecimationBlade:Show()
		timerBladeActive:Start(args.spellName)
	elseif args:IsSpellID(99350) then
		warnInfernoBlade:Show()
		timerBladeActive:Start(args.spellName)
	elseif args:IsSpellID(99259) then
		warnShardsTorment:Show()
		specWarnShardsTorment:Show()
		timerShardsTorment:Start()
	end
end