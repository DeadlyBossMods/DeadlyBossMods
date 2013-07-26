local mod	= DBM:NewMod(846, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71454)
--mod:SetQuestID(32744)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Endless Rage
local warnBloodRage						= mod:NewSpellAnnounce(142879, 3)
local warnDisplacedEnergy				= mod:NewTargetAnnounce(142913, 3)
--Might of the Kor'kron
local warnArcingSmash					= mod:NewCountAnnounce(142815, 4)--Target scanning doesn't work, no boss1target or boss1targettarget
local warnSeismicSlam					= mod:NewCountAnnounce(142851, 3)
local warnBreathofYShaarj				= mod:NewCountAnnounce(142842, 4)
local warnFatalStrike					= mod:NewStackAnnounce(142990, 2, nil, mod:IsTank())

--Endless Rage
local specWarnBloodRage					= mod:NewSpecialWarningSpell(142879, nil, nil, nil, 2)
local specWarnBloodRageEnded			= mod:NewSpecialWarningFades(142879)
local specWarnDisplacedEnergy			= mod:NewSpecialWarningRun(142913)
local yellDisplacedEnergy				= mod:NewYell(142913)
--Might of the Kor'kron
local specWarnArcingSmash				= mod:NewSpecialWarningCount(142815, nil, nil, nil, 2)
local specWarnImplodingEnergySoon		= mod:NewSpecialWarningPreWarn(142986, nil, 5)
local specWarnBreathofYShaarj			= mod:NewSpecialWarningCount(142842, nil, nil, nil, 3)
local specWarnFatalStrike				= mod:NewSpecialWarningStack(142990, mod:IsTank(), 12)--stack guessed, based on CD
local specWarnFatalStrikeOther			= mod:NewSpecialWarningTarget(142990, mod:IsTank())

local timerBloodRage					= mod:NewBuffActiveTimer(22.5, 142879)--2.5sec cast plus 20 second duration
local timerDisplacedEnergyCD			= mod:NewNextTimer(11, 142913)
local timerBloodRageCD					= mod:NewNextTimer(124.7, 142879)
--Might of the Kor'kron
local timerArcingSmashCD				= mod:NewNextCountTimer(17.5, 142815)--17-18 variation (the 23 second ones are delayed by Breath of Yshaarj)
local timerImplodingEnergy				= mod:NewCastTimer(10, 142986)--Always 10 seconds after arcing
local timerSeismicSlamCD				= mod:NewNextCountTimer(17.5, 142851)--Works exactly same as arcingsmash 18 sec unless delayed by breath. two sets of 3
local timerBreathofYShaarjCD			= mod:NewNextCountTimer(59, 142842)
local timerFatalStrike					= mod:NewTargetTimer(30, 142990, nil, mod:IsTank())

local berserkTimer						= mod:NewBerserkTimer(360)

local countdownImplodingEnergy			= mod:NewCountdown(10, 142986)

local soundDisplacedEnergy				= mod:NewSound(142913)

mod:AddBoolOption("RangeFrame", true)--Various things
mod:AddBoolOption("SetIconOnDisplacedEnergy", false)

local displacedEnergyTargets	= {}
local displacedEnergyTargetsIcons = {}
local displacedEnergyDebuff = GetSpellInfo(142913)
local playerDebuffs = 0
local breathCast = 0
local arcingSmashCount = 0
local seismicSlamCount = 0
local displacedCast = false
local UnitDebuff = UnitDebuff
local UnitIsDeadOrGhost = UnitIsDeadOrGhost

local debuffFilter
do
	debuffFilter = function(uId)
		return UnitDebuff(uId, displacedEnergyDebuff)
	end
end

local function warnDisplacedEnergyTargets()
	if mod.Options.RangeFrame then
		if UnitDebuff("player", displacedEnergyDebuff) then--You have debuff, show everyone
			DBM.RangeCheck:Show(8, nil)
		else--You do not have debuff, only show players who do
			DBM.RangeCheck:Show(8, debuffFilter)
		end
	end
	warnDisplacedEnergy:Show(table.concat(displacedEnergyTargets, "<, >"))
	if not displacedCast then--Only cast twice, so we only start cd bar once here
		timerDisplacedEnergyCD:Start()
		displacedCast = true
	end
	table.wipe(displacedEnergyTargets)
end

local function ClearIconTargets()
	table.wipe(displacedEnergyTargetsIcons)
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetIcons()
		table.sort(displacedEnergyTargetsIcons, sort_by_group)
		local Icon = 1
		for i, v in ipairs(displacedEnergyTargetsIcons) do
			self:SetIcon(v, Icon)
			Icon = Icon + 1
		end
		self:Schedule(1.5, ClearIconTargets)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
	end
end

function mod:OnCombatStart(delay)
	table.wipe(displacedEnergyTargets)
	table.wipe(displacedEnergyTargetsIcons)
	playerDebuffs = 0
	breathCast = 0
	arcingSmashCount = 0
	seismicSlamCount = 0
	timerSeismicSlamCD:Start(5-delay, 1)
	timerArcingSmashCD:Start(11-delay, 1)
	timerBreathofYShaarjCD:Start(-delay, 1)
	timerBloodRageCD:Start(122-delay)
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 142879 then
		displacedCast = false
		warnBloodRage:Show()
		specWarnBloodRage:Show()
		timerBloodRage:Start()
		timerDisplacedEnergyCD:Start(3.5)
	elseif args.spellId == 142842 then
		breathCast = breathCast + 1
		warnBreathofYShaarj:Show(breathCast)
		specWarnBreathofYShaarj:Show(breathCast)
		if breathCast == 1 then
			arcingSmashCount = 0
			seismicSlamCount = 0
			timerSeismicSlamCD:Start(5, 1)
			timerArcingSmashCD:Start(11, 1)
			timerBreathofYShaarjCD:Start(nil, 2)
		end
	elseif args.spellId == 143199 then
		breathCast = 0
		arcingSmashCount = 0
		seismicSlamCount = 0
		specWarnBloodRageEnded:Show()
		timerSeismicSlamCD:Start(5, 1)
		timerArcingSmashCD:Start(11, 1)
		timerBreathofYShaarjCD:Start()
		timerBloodRageCD:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 142851 then
		seismicSlamCount = seismicSlamCount + 1
		warnSeismicSlam:Show(seismicSlamCount)
		if seismicSlamCount < 3 then
			timerSeismicSlamCD:Start(nil, seismicSlamCount+1)
		end
	elseif args.spellId == 143913 then--May not be right spell event
		--5 rage gained from Essence of Y'Shaarj would progress timer about 2.5 seconds
		--May choose a more accurate UNIT_POWER monitoring method if this doesn't feel accurate enough
		if self:AntiSpam() then
			local elapsed, total = timerBloodRageCD:GetTime()
			timerBloodRageCD:Update(elapsed+2.5, total)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 142913 then
		displacedEnergyTargets[#displacedEnergyTargets + 1] = args.destName
		playerDebuffs = playerDebuffs + 1
		if args:IsPlayer() then
			specWarnDisplacedEnergy:Show()
			soundDisplacedEnergy:Play()
			yellDisplacedEnergy:Yell()
		end
		if self.Options.SetIconOnDisplacedEnergy and args:IsDestTypePlayer() then--Filter further on icons because we don't want to set icons on grounding totems
			table.insert(displacedEnergyTargetsIcons, DBM:GetRaidUnitId(DBM:GetFullPlayerNameByGUID(args.destGUID)))
			self:UnscheduleMethod("SetIcons")
			if self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
				self:ScheduleMethod(0.5, "SetIcons")
			end
		end
		self:Unschedule(warnDisplacedEnergyTargets)
		self:Schedule(0.3, warnDisplacedEnergyTargets)
	elseif args.spellId == 142990 then
		local amount = args.amount or 1
		if amount % 3 == 0 or amount >= 12 then
			warnFatalStrike:Show(args.destName, amount)
		end
		timerFatalStrike:Start(args.destName)
		if amount >= 12 then
			if args:IsPlayer() then--At this point the other tank SHOULD be clear.
				specWarnFatalStrike:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(142990)) and not UnitIsDeadOrGhost("player") then
					specWarnFatalStrikeOther:Show(args.destName)
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 142913 then
		playerDebuffs = playerDebuffs - 1
		if args:IsPlayer() and self.Options.RangeFrame and playerDebuffs >= 1 then
			DBM.RangeCheck:Show(10, debuffFilter)--Change to debuff filter based check since theirs is gone but there are still others in raid.
		end
		if self.Options.RangeFrame and playerDebuffs == 0 then--All of them are gone. We do it this way since some may cloak/bubble/iceblock early and we don't want to just cancel range finder if 1 of 3 end early.
			DBM.RangeCheck:Hide()
		end
		if self.Options.SetIconOnDisplacedEnergy then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 142898 then--Faster than combat log
		arcingSmashCount = arcingSmashCount + 1
		warnArcingSmash:Show(arcingSmashCount)
		specWarnArcingSmash:Show(arcingSmashCount)
		timerImplodingEnergy:Start()
		countdownImplodingEnergy:Start()
		specWarnImplodingEnergySoon:Schedule(5)
		if arcingSmashCount < 3 then
			timerArcingSmashCD:Start(nil, arcingSmashCount+1)
		end
	end
end
