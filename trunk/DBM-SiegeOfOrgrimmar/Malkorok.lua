local mod	= DBM:NewMod(846, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71454)
mod:SetEncounterID(1595)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 4, 3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 142879 142842 143199",
	"SPELL_CAST_SUCCESS 142851",
	"SPELL_AURA_APPLIED 142913 142990",
	"SPELL_AURA_APPLIED_DOSE 142990",
	"SPELL_AURA_REMOVED 142913",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[WoL Expression
spellid = 143913 or spellid =  143805 or spellid = 142851 or (spellid = 143199 or spellid = 142842 or spellid = 142879) and fulltype = SPELL_CAST_START
http://worldoflogs.com/reports/rt-092xfequ7ks2205b/xe/?s=7029&e=7304&x=spellid+%3D+143913+or+spellid+%3D++143805+or+spellid+%3D+142851+or+%28spellid+%3D+143199+or+spellid+%3D+142842+or+spellid+%3D+142879%29+and+fulltype+%3D+SPELL_CAST_START
--]]
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
local yellDisplacedEnergy				= mod:NewYell("OptionVersion2", 142913, nil, false)--Only matters on normal/heroic and most of those raiders know how to dispel it with roars and other things so yells are pointless to most except bad comp 10 mans (and 10 mans going away soon so ultimately false is better default)
--Might of the Kor'kron
local specWarnArcingSmash				= mod:NewSpecialWarningCount(142815, nil, nil, nil, 2)
local specWarnImplodingEnergySoon		= mod:NewSpecialWarningPreWarn(142986, nil, 4)
local specWarnBreathofYShaarj			= mod:NewSpecialWarningCount(142842, nil, nil, nil, 3)
local specWarnFatalStrike				= mod:NewSpecialWarningStack(142990, mod:IsTank(), 12)--stack guessed, based on CD
local specWarnFatalStrikeOther			= mod:NewSpecialWarningTaunt(142990, mod:IsTank())

local timerBloodRage					= mod:NewBuffActiveTimer(22.5, 142879)--2.5sec cast plus 20 second duration
local timerDisplacedEnergyCD			= mod:NewNextTimer(11, 142913)
--Might of the Kor'kron
local timerArcingSmashCD				= mod:NewCDCountTimer(19, 142815)
local timerImplodingEnergy				= mod:NewCastTimer(10, 142986)--Always 10 seconds after arcing
local timerSeismicSlamCD				= mod:NewNextCountTimer(19.5, 142851)--Works exactly same as arcingsmash 18 sec unless delayed by breath. two sets of 3
local timerBreathofYShaarjCD			= mod:NewNextCountTimer(70, 142842)
local timerFatalStrike					= mod:NewTargetTimer(30, 142990, nil, mod:IsTank())

local berserkTimer						= mod:NewBerserkTimer(360)

local countdownImplodingEnergy			= mod:NewCountdown(10, 142986, nil, nil, 5)

local countdownBreathofYShaarj			= mod:NewCountdown(10, 142842, nil, nil, 5, nil, true)

local soundDisplacedEnergy				= mod:NewSound(142913)

mod:AddRangeFrameOption("8/5")--Various things
mod:AddSetIconOption("SetIconOnDisplacedEnergy", 142913, false)
mod:AddSetIconOption("SetIconOnAdds", "ej7952", false, true)
mod:AddArrowOption("BloodrageArrow", 142879, true, true)

--Upvales, don't need variables
local displacedEnergyDebuff = GetSpellInfo(142913)
local UnitDebuff = UnitDebuff
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
--Not important, don't need to recover
local playerDebuffs = 0
--Important, needs recover
mod.vb.breathCast = 0
mod.vb.arcingSmashCount = 0
mod.vb.seismicSlamCount = 0
mod.vb.displacedCast = false
mod.vb.rageActive = false

local debuffFilter
do
	debuffFilter = function(uId)
		return UnitDebuff(uId, displacedEnergyDebuff)
	end
end

function mod:OnCombatStart(delay)
	playerDebuffs = 0
	self.vb.breathCast = 0
	self.vb.arcingSmashCount = 0
	self.vb.seismicSlamCount = 0
	self.vb.rageActive = false
	timerSeismicSlamCD:Start(5-delay, 1)
	timerArcingSmashCD:Start(11-delay, 1)
	timerBreathofYShaarjCD:Start(68-delay, 1)
	countdownBreathofYShaarj:Start(68-delay)
	if self:IsDifficulty("lfr25") then
		berserkTimer:Start(720-delay)
	else
		berserkTimer:Start(-delay)
	end
	if self.Options.RangeFrame and self:IsRanged() then
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.BloodrageArrow then
		DBM.Arrow:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 142879 then
		self.vb.displacedCast = false
		self.vb.rageActive = true
		warnBloodRage:Show()
		specWarnBloodRage:Show()
		timerBloodRage:Start()
		timerDisplacedEnergyCD:Start(3.5)
	elseif spellId == 142842 then
		self.vb.breathCast = self.vb.breathCast + 1
		warnBreathofYShaarj:Show(self.vb.breathCast)
		specWarnBreathofYShaarj:Show(self.vb.breathCast)
		if self.vb.breathCast == 1 then
			self.vb.arcingSmashCount = 0
			self.vb.seismicSlamCount = 0
			timerSeismicSlamCD:Start(7.5, 1)
			timerArcingSmashCD:Start(14, 1)
			timerBreathofYShaarjCD:Start(70, 2)
			countdownBreathofYShaarj:Start(70)
		else--Breath 2
			if self.Options.BloodrageArrow then
				for uId in DBM:GetGroupMembers() do
					local tanking, status = UnitDetailedThreatSituation(uId, "boss1")
					if status == 3 then
						if UnitIsUnit("player", uId) then return end
						local bosstank = UnitName(uId)
						DBM.Arrow:ShowRunTo(bosstank, 3, 3, 5)
						break
					end
				end
			end
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 143199 then
		self.vb.breathCast = 0
		self.vb.arcingSmashCount = 0
		self.vb.seismicSlamCount = 0
		self.vb.rageActive = false
		specWarnBloodRageEnded:Show()
		timerSeismicSlamCD:Start(7.5, 1)
		timerArcingSmashCD:Start(14, 1)
		timerBreathofYShaarjCD:Start(70, 1)
		countdownBreathofYShaarj:Start(70)
		if self.Options.RangeFrame and self:IsRanged() then
			DBM.RangeCheck:Show(5)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 142851 then
		self.vb.seismicSlamCount = self.vb.seismicSlamCount + 1
		warnSeismicSlam:Show(self.vb.seismicSlamCount)
		if self.vb.seismicSlamCount < 3 then
			timerSeismicSlamCD:Start(nil, self.vb.seismicSlamCount+1)
		end
		if self.Options.SetIconOnAdds and self:IsHeroic() then
			self:ScanForMobs(71644, 0, 8, nil, 0.2, 6)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 142913 then
		warnDisplacedEnergy:CombinedShow(0.5, args.destName)
		playerDebuffs = playerDebuffs + 1
		if args:IsPlayer() then
			specWarnDisplacedEnergy:Show()
			soundDisplacedEnergy:Play()
			yellDisplacedEnergy:Yell()
		end
		if not self.vb.displacedCast then--Only cast twice, so we only start cd bar once here
			self.vb.displacedCast = true
			timerDisplacedEnergyCD:DelayedStart(0.5)
		end
		if self.Options.SetIconOnDisplacedEnergy and args:IsDestTypePlayer() then--Filter further on icons because we don't want to set icons on grounding totems
			self:SetSortedIcon(0.5, args.destName, 1)
		end
		if self.Options.RangeFrame then
			if UnitDebuff("player", displacedEnergyDebuff) then--You have debuff, show everyone
				DBM.RangeCheck:Show(8, nil)
			else--You do not have debuff, only show players who do
				DBM.RangeCheck:Show(8, debuffFilter)
			end
		end
	elseif spellId == 142990 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnFatalStrike:Show(args.destName, amount)
		end
		timerFatalStrike:Start(args.destName)
		if amount % 3 == 0 and amount >= 12 then
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
	local spellId = args.spellId
	if spellId == 142913 then
		playerDebuffs = playerDebuffs - 1
		if args:IsPlayer() and self.Options.RangeFrame and playerDebuffs >= 1 then
			DBM.RangeCheck:Show(10, debuffFilter)--Change to debuff filter based check since theirs is gone but there are still others in raid.
		end
		if self.Options.RangeFrame and playerDebuffs == 0 and self.vb.rageActive then--All of them are gone. We do it this way since some may cloak/bubble/iceblock early and we don't want to just cancel range finder if 1 of 3 end early.
			DBM.RangeCheck:Hide()
		end
		if self.Options.SetIconOnDisplacedEnergy then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 142898 then--Faster than combat log
		self.vb.arcingSmashCount = self.vb.arcingSmashCount + 1
		warnArcingSmash:Show(self.vb.arcingSmashCount)
		specWarnArcingSmash:Show(self.vb.arcingSmashCount)
		timerImplodingEnergy:Start()
		countdownImplodingEnergy:Start()
		specWarnImplodingEnergySoon:Schedule(6)
		if self.vb.arcingSmashCount < 3 then
			timerArcingSmashCD:Start(nil, self.vb.arcingSmashCount+1)
		end
	end
end
