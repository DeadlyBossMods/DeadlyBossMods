local mod	= DBM:NewMod(1154, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76809, 76806)--76809 foreman feldspar, 76806 heart of the mountain, 76809 Security Guard, 76810 Furnace Engineer, 76811 Bellows Operator, 76815 Primal Elementalist, 78463 Slag Elemental, 76821 Firecaller
mod:SetEncounterID(1690)
mod:SetZone()
--mod:SetUsedIcons(7)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 160379 155186 156937 177756",
	"SPELL_CAST_SUCCESS 155179 174726",
	"SPELL_AURA_APPLIED 155192 155196 158345 155242 155181 176121 155225 156934 155173",
	"SPELL_AURA_APPLIED_DOSE 155242",
	"SPELL_AURA_REMOVED 155192 176121",
	"SPELL_PERIODIC_DAMAGE 156932 155223",
	"SPELL_PERIODIC_MISSED 156932 155223",
	"UNIT_DIED",
	"UNIT_POWER_FREQUENT boss1"
)

--TODO, figure out how to detect OTHER add spawns besides operator and get timers for them too. It's likely the'll require ugly scheduling and /yell logging. 
local warnBlastFrequency		= mod:NewAnnounce("warnBlastFrequency", 1, 155209, "Healer")
local warnBomb					= mod:NewTargetAnnounce(155192, 4)
local warnDropBombs				= mod:NewSpellAnnounce("OptionVersion2", 174726, 1, nil, "-Tank")
local warnEngineer				= mod:NewSpellAnnounce("ej9649", 2, 155179)
local warnRupture				= mod:NewTargetAnnounce(156932, 3)
--Phase 2
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnElementalists			= mod:NewAddsLeftAnnounce("ej9655", 2)
local warnFixate				= mod:NewTargetAnnounce(155196, 4)
local warnVolatileFire			= mod:NewTargetAnnounce(176121, 4)
--Phase 3
local warnMelt					= mod:NewTargetAnnounce("OptionVersion2", 155225, 4, nil, false)--VERY spammy, off by default
local warnHeat					= mod:NewStackAnnounce(155242, 2, nil, "Tank")

local specWarnBomb				= mod:NewSpecialWarningYou(155192, nil, nil, nil, 3, nil, 2)
local specWarnBellowsOperator	= mod:NewSpecialWarningSwitch("OptionVersion2", "ej9650", "-Healer", nil, nil, nil, nil, 2)
local specWarnDeafeningRoar		= mod:NewSpecialWarningDodge("OptionVersion2", 177756, "Tank", nil, nil, 3)
--local specWarnDefense			= mod:NewSpecialWarningMove("OptionVersion2", 160379, false, nil, nil, nil, nil, true)--Doesn't work until 6.1. The CAST event doesn't exixst in 6.0
local specWarnRepair			= mod:NewSpecialWarningInterrupt(155179, "-Healer", nil, nil, nil, nil, 2)
local specWarnRuptureOn			= mod:NewSpecialWarningYou(156932)
local specWarnRupture			= mod:NewSpecialWarningMove(156932, nil, nil, nil, nil, nil, 2)
--Phase 2
local specWarnFixate			= mod:NewSpecialWarningYou(155196)
local specWarnMeltYou			= mod:NewSpecialWarningYou(155225)
local specWarnMeltNear			= mod:NewSpecialWarningClose(155225, false)
local specWarnMelt				= mod:NewSpecialWarningMove(155223, nil, nil, nil, nil, nil, 2)
local specWarnCauterizeWounds	= mod:NewSpecialWarningInterrupt(155186, "-Healer")--if spammy, will switch to target/focus type only
local specWarnPyroclasm			= mod:NewSpecialWarningInterrupt(156937, false)
local specVolatileFire			= mod:NewSpecialWarningMoveAway(176121)
local yellVolatileFire			= mod:NewYell(176121)
local specWarnShieldsDown		= mod:NewSpecialWarningSwitch("ej9655", "Dps")
local specWarnEarthShield		= mod:NewSpecialWarningDispel(155173, "MagicDispeller")
--Phase 3
local specWarnHeartoftheMountain= mod:NewSpecialWarningSwitch("ej10808", "Tank")
local specWarnHeat				= mod:NewSpecialWarningStack(155242, nil, 3, nil, nil, nil, nil, 2)
local specWarnHeatOther			= mod:NewSpecialWarningTaunt(155242, nil, nil, nil, nil, nil, 2)
--All
local specWarnBlast				= mod:NewSpecialWarningSoon(155209, nil, nil, nil, 2)

local timerBomb					= mod:NewBuffFadesTimer(15, 155192)
local timerBlastCD				= mod:NewCDTimer(25, 155209)--25 seconds base. shorter when loading is being channeled by operators.
local timerRuptureCD			= mod:NewCDTimer(26, 156934)
local timerEngineer				= mod:NewNextTimer(41, "ej9649", nil, nil, nil, 155179)
local timerBellowsOperator		= mod:NewNextTimer(64, "ej9650", nil, nil, nil, 155181)
--Phase 2
local timerShieldsDown			= mod:NewBuffActiveTimer(30, 158345, nil, "Dps")--Anyone else need?

local countdownBlast			= mod:NewCountdown(30, 155209, "Healer")
local countdownBellowsOperator	= mod:NewCountdown("OptionVersion2", "Alt64", "ej9650", "-Healer")
local countdownEngineer			= mod:NewCountdown("OptionVersion2", "AltTwo41", "ej9649", "Tank")

local voicePhaseChange			= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceRepair				= mod:NewVoice(155179, "-Healer") --int
local voiceBomb 				= mod:NewVoice(155192) --bombyou.ogg, bomb on you
--local voiceDefense 				= mod:NewVoice("OptionVersion2", 160379, false) --taunt mobout
local voiceBellowsOperator 		= mod:NewVoice("ej9650", "-Healer")
local voiceRupture				= mod:NewVoice(156932) --runaway
local voiceMelt					= mod:NewVoice(155223) --runaway
local voiceHeat					= mod:NewVoice(155242) --changemt

mod:AddRangeFrameOption(8, 176121)

mod.vb.machinesDead = 0
mod.vb.elementalistsRemaining = 4
mod.vb.blastWarned = false
mod.vb.lastTotal = 30

--With some videos, this looks pretty good now. Just need phase 2 add stuff now.
local function Engineers(self)
	warnEngineer:Show()
	timerEngineer:Start()
	countdownEngineer:Start()
	self:Schedule(41, Engineers, self)
end

function mod:OnCombatStart(delay)
	self.vb.machinesDead = 0
	self.vb.elementalistsRemaining = 4
	self.vb.blastWarned = false
	self.vb.lastTotal = 30
	self:Schedule(55, Engineers, self)
	timerEngineer:Start(55)
	countdownEngineer:Start(55)
	timerBlastCD:Start(30-delay)
	countdownBlast:Start(30-delay)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 155186 then
		specWarnCauterizeWounds:Show(args.sourceName)
	elseif spellId == 156937 then
		specWarnPyroclasm:Show(args.sourceName)
	elseif spellId == 177756 and self:CheckTankDistance(args.sourceGUID, 30) then
		specWarnDeafeningRoar:Show()
--	elseif spellId == 160379 and self:CheckTankDistance(args.sourceGUID, 30) then--Requires 6.1. The events on live don't work for this
--		specWarnDefense:Show()
--		voiceDefense:Play("mobout")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155179 then--Repair should NOT check tank distance, because these mobs run to lowest health regulator, even if it's on OTHER side of where their tank is.
		specWarnRepair:Show(args.sourceName)
		voiceRepair:Play("kickcast")
	elseif spellId == 174726 and self:CheckTankDistance(args.sourceGUID, 30) and self:AntiSpam(2, 4) then
		warnDropBombs:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155192 then
		if self:CheckTankDistance(args.sourceGUID, 30) then
			warnBomb:CombinedShow(0.5, args.destName)
		end
		if args:IsPlayer() then
			specWarnBomb:Show()
			timerBomb:Start()
			voiceBomb:Play("bombrun")
		end
	elseif spellId == 155196 then
		warnFixate:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
		end
	elseif spellId == 158345 and self:AntiSpam(10, 3) then--Might be SPELL_CAST_SUCCESS instead.
		specWarnShieldsDown:Show()
		if self:IsDifficulty("normal", "lfr") then--40 seconds on normal. at least that much on LFR too, probably even longer in LFR.
			timerShieldsDown:Start(40)
		elseif self:IsHeroic() then
			timerShieldsDown:Start()--30 in heroic
		else
			timerShieldsDown:Start(25)--20 on mythic? or 25?
		end
	elseif spellId == 155242 then
		local amount = args.amount or 1
		warnHeat:Show(args.destName, amount)
		if amount >= 3 then
			voiceHeat:Play("changemt")
			if args:IsPlayer() then
				specWarnHeat:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(155242)) and not UnitIsDeadOrGhost("player") then
					specWarnHeatOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 155181 and self:AntiSpam(10, 0) then--Loading (The two that come can be upwards of 5 seconds apart so at least 10 second antispam)
		specWarnBellowsOperator:Show()
		timerBellowsOperator:Start()
		countdownBellowsOperator:Start()
		voiceBellowsOperator:Play("killmob")
	elseif spellId == 176121 then
		warnVolatileFire:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specVolatileFire:Show()
			if not self:IsLFR() then
				yellVolatileFire:Yell()
			end
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 155225 then
		warnMelt:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnMeltYou:Show()
		elseif self:CheckNearby(8, args.destName) then
			specWarnMeltNear:Show()
		end
	elseif spellId == 156934 then
		warnRupture:CombinedShow(0.5, args.destName)
		timerRuptureCD:Start()
		if args:IsPlayer() then
			specWarnRuptureOn:Show()
		end
	elseif spellId == 155173 and not args:IsDestTypePlayer() then
		specWarnEarthShield:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 155192 and args:IsPlayer() then
		timerBomb:Cancel()
	elseif spellId == 176121 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 156932 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnRupture:Show()
		voiceRupture:Play("runaway")
	elseif spellId == 155223 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnMelt:Show()
		voiceMelt:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 76815 then--Elementalist
		self.vb.elementalistsRemaining = self.vb.elementalistsRemaining - 1
		warnElementalists:Show(self.vb.elementalistsRemaining)
		if self.vb.elementalistsRemaining == 0 then
			specWarnHeartoftheMountain:Show()
			voicePhaseChange:Play("pthree")
		end
	elseif cid == 76808 then--Regulators
		self.vb.machinesDead = self.vb.machinesDead + 1
		if self.vb.machinesDead == 2 then
			warnPhase2:Show()
			self:Unschedule(Engineers)
			timerEngineer:Cancel()
			countdownEngineer:Cancel()
			timerBellowsOperator:Cancel()
			countdownBellowsOperator:Cancel()
			voicePhaseChange:Play("ptwo")
		end
	elseif cid == 76809 then
		timerRuptureCD:Cancel()
	end
end

do
	local UnitPower = UnitPower
	function mod:UNIT_POWER_FREQUENT(uId, type)
		local totalTime = 30
		if type == "ALTERNATE" then
			local altPower = UnitPower(uId, 10)
			local powerRate = 5
			--Each time boss breaks interval of 25%. CD is reduced
			if altPower == 100 then
				totalTime = 5.5--5-6
				powerRate = 18.18
			elseif altPower > 74 then
				totalTime = 9--9-10
				powerRate = 11.11
			elseif altPower > 49 then
				totalTime = 15--15-16
				powerRate = 6.66
			elseif altPower > 24 then
				totalTime = 20
				powerRate = 5
			end
			if self.vb.lastTotal > totalTime then--CD changed
				self.vb.lastTotal = totalTime
				warnBlastFrequency:Show(totalTime)
				local bossPower = UnitPower("boss1") --Get Boss Power
				local elapsed = bossPower / powerRate
				timerBlastCD:Update(elapsed, totalTime)
				countdownBlast:Cancel()
				countdownBlast:Start(totalTime-elapsed)
			end
		else
			local bossPower = UnitPower("boss1") --Get Boss Power
			if bossPower >= 85 and not self.vb.blastWarned then
				self.vb.blastWarned = true
				specWarnBlast:Show()
			elseif bossPower < 5 and self.vb.blastWarned then--Should catch 0, if not, at least 1-4 will fire it but then timer may be a second or so off
				self.vb.blastWarned = false
				timerBlastCD:Start(totalTime)
				countdownBlast:Start(totalTime)
			end
		end
	end
end
