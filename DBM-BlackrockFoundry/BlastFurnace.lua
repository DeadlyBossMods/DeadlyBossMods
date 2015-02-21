local mod	= DBM:NewMod(1154, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76809, 76806)--76809 foreman feldspar, 76806 heart of the mountain, 76809 Security Guard, 76810 Furnace Engineer, 76811 Bellows Operator, 76815 Primal Elementalist, 78463 Slag Elemental, 76821 Firecaller
mod:SetEncounterID(1690)
mod:SetZone()
--mod:SetUsedIcons(7)
mod:SetHotfixNoticeRev(12973)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 160379 155186 156937 177756",
	"SPELL_CAST_SUCCESS 155179 174726",
	"SPELL_AURA_APPLIED 155192 174716 155196 158345 155242 155181 176121 155225 156934 155173",
	"SPELL_AURA_APPLIED_DOSE 155242",
	"SPELL_AURA_REMOVED 155192 174716 176121",
	"SPELL_PERIODIC_DAMAGE 156932 155223 155743",
	"SPELL_ABSORBED 156932 155223 155743",
	"UNIT_DIED",
	"UNIT_POWER_FREQUENT boss1"
)

--TODO, figure out how to detect OTHER add spawns besides operator and get timers for them too. It's likely the'll require ugly scheduling and /yell logging. 
local warnRegulators			= mod:NewAnnounce("warnRegulators", 2, 156918)
local warnBlastFrequency		= mod:NewAnnounce("warnBlastFrequency", 1, 155209, "Healer")
local warnBomb					= mod:NewTargetAnnounce(155192, 4)
local warnDropBombs				= mod:NewSpellAnnounce("OptionVersion2", 174726, 1, nil, "-Tank")
local warnEngineer				= mod:NewSpellAnnounce("ej9649", 2, 155179)
local warnRupture				= mod:NewTargetAnnounce(156932, 3)
--Phase 2
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnElementalists			= mod:NewAddsLeftAnnounce("ej9655", 2, 91751)
local warnFixate				= mod:NewTargetAnnounce(155196, 4)
local warnVolatileFire			= mod:NewTargetAnnounce("OptionVersion2", 176121, 4, nil, false)--Spam. disable by default.
local warnFireCaller			= mod:NewSpellAnnounce("ej9659", 3, 156937, "Tank")
local warnSecurityGuard			= mod:NewSpellAnnounce("ej9648", 2, 160379, "Tank")
--Phase 3
local warnPhase3				= mod:NewPhaseAnnounce(3)
local warnMelt					= mod:NewTargetAnnounce("OptionVersion2", 155225, 4, nil, false)--Every 10 sec.
local warnHeat					= mod:NewStackAnnounce(155242, 2, nil, "Tank")

local specWarnBomb				= mod:NewSpecialWarningMoveTo(155192, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(155192), nil, 3, nil, 2)
local specWarnBellowsOperator	= mod:NewSpecialWarningSwitch("OptionVersion2", "ej9650", "-Healer", nil, nil, nil, nil, 2)
local specWarnDeafeningRoar		= mod:NewSpecialWarningDodge("OptionVersion2", 177756, "Tank", nil, nil, 3)
--local specWarnDefense			= mod:NewSpecialWarningMove("OptionVersion2", 160379, false, nil, nil, nil, nil, true)--Doesn't work until 6.1. The CAST event doesn't exixst in 6.0
local specWarnRepair			= mod:NewSpecialWarningInterrupt(155179, "-Healer", nil, nil, nil, nil, 2)
local specWarnRuptureOn			= mod:NewSpecialWarningYou(156932)
local specWarnRupture			= mod:NewSpecialWarningMove(156932, nil, nil, nil, nil, nil, 2)
local yellRupture				= mod:NewYell(156932)
--Phase 2
local specWarnFixate			= mod:NewSpecialWarningYou(155196)
local specWarnMeltYou			= mod:NewSpecialWarningYou(155225)
local specWarnMeltNear			= mod:NewSpecialWarningClose(155225, false)
local specWarnMelt				= mod:NewSpecialWarningMove(155223, nil, nil, nil, nil, nil, 2)
local yellMelt					= mod:NewYell(155223)
local specWarnCauterizeWounds	= mod:NewSpecialWarningInterrupt(155186, "-Healer")--if spammy, will switch to target/focus type only
local specWarnPyroclasm			= mod:NewSpecialWarningInterrupt(156937, false)
local specVolatileFire			= mod:NewSpecialWarningMoveAway(176121)
local yellVolatileFire			= mod:NewYell(176121)
local specWarnShieldsDown		= mod:NewSpecialWarningSwitch("ej9655", "Dps")
local specWarnEarthShield		= mod:NewSpecialWarningDispel(155173, "MagicDispeller")
local specWarnSlagPool			= mod:NewSpecialWarningMove(155743)
--Phase 3
local specWarnHeartoftheMountain= mod:NewSpecialWarningSwitch("ej10808", "Tank")
local specWarnHeat				= mod:NewSpecialWarningStack(155242, nil, 3, nil, nil, nil, nil, 2)
local specWarnHeatOther			= mod:NewSpecialWarningTaunt(155242, nil, nil, nil, nil, nil, 2)
--All
local specWarnBlast				= mod:NewSpecialWarningSoon(155209, nil, nil, nil, 2)

mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerBomb					= mod:NewBuffFadesTimer(15, 155192)
local timerBlastCD				= mod:NewCDTimer(25, 155209)--25 seconds base. shorter when loading is being channeled by operators.
local timerRuptureCD			= mod:NewCDTimer(26, 156934)
local timerEngineer				= mod:NewNextTimer(41, "ej9649", nil, nil, nil, 155179)
local timerBellowsOperator		= mod:NewCDTimer(60, "ej9650", nil, nil, nil, 155181)--60-65second variation for sure
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerVolatileFire			= mod:NewBuffFadesTimer(8, 176121)
local timerShieldsDown			= mod:NewBuffActiveTimer(30, 158345, nil, "Dps")
local timerSlagElemental		= mod:NewNextCountTimer(55, "ej9657", nil, "-Tank", nil, 155196)--Definitely 55 seconds, although current detection method may make it appear 1-2 seconds if slag has to run across room before casting first fixate
local timerFireCaller			= mod:NewCDTimer(45, "ej9659", nil, "Tank", nil, 156937)--CD bars until accuracy verified
local timerSecurityGuard		= mod:NewCDTimer(40, "ej9648", nil, "Tank", nil, 160379)--CD bars until accuracy verified

local berserkTimer				= mod:NewBerserkTimer(780)

local countdownBlast			= mod:NewCountdown(30, 155209, "Healer")
local countdownBellowsOperator	= mod:NewCountdown("OptionVersion2", "Alt64", "ej9650", "-Healer")
local countdownEngineer			= mod:NewCountdown("OptionVersion2", "AltTwo41", "ej9649", "Tank")
--Phase 2 countdowns, no conflict with phase 1 countdowns
local countdownFireCaller		= mod:NewCountdown("Alt64", "ej9659", "Tank")
local countdownSecurityGuard	= mod:NewCountdown("AltTwo41", "ej9648", "Tank")

local voicePhaseChange			= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceRepair				= mod:NewVoice(155179, "-Healer") --int
local voiceBomb 				= mod:NewVoice(155192) --bombyou.ogg, bomb on you
--local voiceDefense 				= mod:NewVoice("OptionVersion2", 160379, false) --taunt mobout
local voiceBellowsOperator 		= mod:NewVoice("ej9650", "-Healer")
local voiceRupture				= mod:NewVoice(156932) --runaway
local voiceMelt					= mod:NewVoice(155223) --runaway
local voiceSlagPool				= mod:NewVoice(155743) --runaway
local voiceHeat					= mod:NewVoice(155242) --changemt
local voiceVolatileFire			= mod:NewVoice(176121) --runout
local voiceSlagElemental		= mod:NewVoice("ej9657", "-Tank")
local voiceFireCaller			= mod:NewVoice("ej9659", "Tank")
local voiceSecurityGuard		= mod:NewVoice("ej9648", "Tank")

mod:AddRangeFrameOption(8)

mod.vb.machinesDead = 0
mod.vb.elementalistsRemaining = 4
mod.vb.blastWarned = false
mod.vb.lastTotal = 30
mod.vb.phase = 1
mod.vb.slagCount = 0
local activeSlagGUIDS = {}
local activePrimalGUIDS = {}
local activePrimal = 0 -- health report variable. no sync

local Bomb = GetSpellInfo(155192)
local VolatileFire = GetSpellInfo(176121)

local BombFilter
do
	BombFilter = function(uId)
		return UnitDebuff(uId, BombFilter)
	end
end

local VolatileFilter
do
	VolatileFilter = function(uId)
		return UnitDebuff(uId, VolatileFire)
	end
end

local function resetRangeFrame()
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

local UnitHealth, UnitHealthMax, GetTime = UnitHealth, UnitHealthMax, GetTime
--Still needs double checking in LFR, normal, and mythic. Mythic data given via 3rd party and unverified by me
local function Engineers(self)
	warnEngineer:Show()
	timerEngineer:Start()
	countdownEngineer:Start()
	if self:IsMythic() then
		self:Schedule(31, Engineers, self)
	else
		self:Schedule(41, Engineers, self)
	end
end

local function SecurityGuard(self)
	warnSecurityGuard:Show()
	timerSecurityGuard:Start()
	voiceSecurityGuard:Play("ej9648")
	if self:IsMythic() then
		self:Schedule(40, SecurityGuard, self)
	else
		self:Schedule(55, SecurityGuard, self)
	end
end

local function FireCaller(self)
	warnFireCaller:Show()
	timerFireCaller:Start()
	voiceFireCaller:Play("ej9659")
	if self:IsMythic() then
		self:Schedule(45, FireCaller, self)
	else
		self:Schedule(55, FireCaller, self)
	end
end

function mod:CustomHealthUpdate()
	local health
	local total = 0
	local maxh = 0
	if self.vb.phase == 1 then
		for i = 1, 5 do
			local uid = "boss"..i
			local cid = self:GetUnitCreatureId(uid)
			if cid == 76808 then
				total = total + UnitHealth(uid)
				maxh = UnitHealthMax(uid)
			end
		end
		if maxh > 0 then
			health = (total / (maxh * 2) * 100)
		else
			health = 100
		end
		return ("%d%%"):format(health)
	elseif self.vb.phase == 2 then
		for i = 1, 5 do
			local uid = "boss"..i
			local cid = self:GetUnitCreatureId(uid)
			if cid == 76815 then
				total = total + UnitHealth(uid)
				maxh = UnitHealthMax(uid)
			end
		end
		if activePrimal > 0 then
			health = (total / (maxh * activePrimal) * 100)
		else
			health = 100
		end
		return ("%d%%"):format(health)
	elseif self.vb.phase == 3 then
		health = (UnitHealth("boss1") / UnitHealthMax("boss1") * 100)
		return ("%d%%"):format(health)
	end
	return DBM_CORE_UNKNOWN
end

function mod:OnCombatStart(delay)
	table.wipe(activeSlagGUIDS)
	table.wipe(activePrimalGUIDS)
	self.vb.machinesDead = 0
	self.vb.elementalistsRemaining = 4
	self.vb.blastWarned = false
	self.vb.lastTotal = 30
	self.vb.phase = 1
	self.vb.slagCount = 0
	if self:IsMythic() then
		self:Schedule(40, Engineers, self)
		timerEngineer:Start(40)
		countdownEngineer:Start(40)
	else
		self:Schedule(55, Engineers, self)
		timerEngineer:Start(55)
		countdownEngineer:Start(55)
	end
	if self:AntiSpam(10, 0) then--Need to ignore loading on the pull
		if self:IsMythic() then
			timerBellowsOperator:Start(40)--40-65 variation on mythic? fuck mythic
			countdownBellowsOperator:Start(40)
		else
			timerBellowsOperator:Start(55)--55-60 variation for first ones from pull
			countdownBellowsOperator:Start(55)
		end
	end
	timerBlastCD:Start(30-delay)
	countdownBlast:Start(30-delay)
	if not self:IsLFR() then
		berserkTimer:Start(-delay)
	end
	if DBM.BossHealth:IsShown() then
		DBM.BossHealth:Clear()
		self:Schedule(1, function()
			for i = 1, 5 do
				local uid = "boss"..i
				local guid = UnitGUID(uid)
				local cid = self:GetCIDFromGUID(guid)
				if cid == 76808 then
					DBM.BossHealth:AddBoss(guid)
				end
			end
		end)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 155186 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnCauterizeWounds:Show(args.sourceName)
	elseif spellId == 156937 and self:CheckInterruptFilter(args.sourceGUID) then
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
	if spellId == 155179 and self:CheckTankDistance(args.sourceGUID, 30) then--Blizz seems to updated encounter code so they now run to nearest regulator instead of lowest health one.
		specWarnRepair:Show(args.sourceName)
		voiceRepair:Play("kickcast")
	elseif spellId == 174726 and self:CheckTankDistance(args.sourceGUID, 30) and self:AntiSpam(2, 4) and self.vb.phase == 1 then
		warnDropBombs:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if args:IsSpellID(155192, 174716) then
		local uId = DBM:GetRaidUnitId(args.destName)
		local _, _, _, _, _, duration, expires, _, _ = UnitDebuff(uId, args.spellName)
		local debuffTime = expires - GetTime()
		if self:CheckTankDistance(args.sourceGUID, 30) and self.vb.phase == 1 then
			warnBomb:CombinedShow(1, args.destName)
		end
		if args:IsPlayer() then
			specWarnBomb:Show(L.heatRegulator)
			timerBomb:Start(debuffTime)
			voiceBomb:Play("bombrun")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
		if self.Options.RangeFrame and not DBM.RangeCheck:IsShown() then
			DBM.RangeCheck:Show(8, BombFilter)
		end
		self:Unschedule(resetRangeFrame)
		self:Schedule(debuffTime + 0.5, resetRangeFrame)
	elseif spellId == 155196 then
		if not activeSlagGUIDS[args.sourceGUID] then
			activeSlagGUIDS[args.sourceGUID] = true
			self.vb.slagCount = self.vb.slagCount + 1
			if self:IsMythic() and self.vb.slagCount == 1 then--Unable to verify, 3rd party report. On heroic/normal. 2nd one is 55, like rest of them.
				timerSlagElemental:Start(35, self.vb.slagCount+1)
			else
				timerSlagElemental:Start(nil, self.vb.slagCount+1)
			end
			voiceSlagElemental:Play("ej9657")
		end
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
		warnVolatileFire:CombinedShow(1, args.destName)
		local uId = DBM:GetRaidUnitId(args.destName)
		local _, _, _, _, _, duration, expires, _, _ = UnitDebuff(uId, args.spellName)
		local debuffTime = expires - GetTime()
		if args:IsPlayer() then
			timerVolatileFire:Start(debuffTime)
			specVolatileFire:Show()
			if not self:IsLFR() then
				yellVolatileFire:Yell()
			end
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
			voiceVolatileFire:Schedule(debuffTime - 4, "runout")
		end
		if self.Options.RangeFrame and not DBM.RangeCheck:IsShown() then
			DBM.RangeCheck:Show(8, VolatileFilter)
		end
		self:Unschedule(resetRangeFrame)
		self:Schedule(debuffTime + 0.5, resetRangeFrame)
	elseif spellId == 155225 then
		warnMelt:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnMeltYou:Show()
			yellMelt:Schedule(5)--yell after 5 sec to warn nearby player (aoe actually after 6 sec). like expel magic: fel
		elseif self:CheckNearby(8, args.destName) then
			specWarnMeltNear:Show()
		end
	elseif spellId == 156934 then
		warnRupture:CombinedShow(0.5, args.destName)
		timerRuptureCD:Start()
		if args:IsPlayer() then
			specWarnRuptureOn:Show()
			yellRupture:Schedule(4)--yell after 4 sec to warn nearby player (aoe actually after 5 sec).  like expel magic: fel
		end
	elseif spellId == 155173 and not args:IsDestTypePlayer() then
		specWarnEarthShield:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if args:IsSpellID(155192, 174716) and args:IsPlayer() then
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
	elseif spellId == 155743 and destGUID == UnitGUID("player") and self:AntiSpam(2, 5) then
		specWarnSlagPool:Show()
		voiceSlagPool:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 76815 then--Elementalist
		self.vb.elementalistsRemaining = self.vb.elementalistsRemaining - 1
		warnElementalists:Show(self.vb.elementalistsRemaining)
		if self.vb.elementalistsRemaining == 0 then
			timerFireCaller:Cancel()
			timerSecurityGuard:Cancel()
			timerSlagElemental:Cancel()
			self:Unschedule(SecurityGuard)
			self:Unschedule(FireCaller)
			self.vb.phase = 3
			self:UnregisterShortTermEvents()
			warnPhase3:Show()
			specWarnHeartoftheMountain:Show()
			voicePhaseChange:Play("pthree")
			if DBM.BossHealth:IsShown() then
				DBM.BossHealth:Clear()
				DBM.BossHealth:AddBoss(76806)
			end
		end
	elseif cid == 76808 then--Regulators
		self.vb.machinesDead = self.vb.machinesDead + 1
		warnRegulators:Show(2 - self.vb.machinesDead)
		if self.vb.machinesDead == 2 then
			self.vb.phase = 2
			activePrimal = 0
			warnPhase2:Show()
			self:Unschedule(Engineers)
			timerEngineer:Cancel()
			countdownEngineer:Cancel()
			timerBellowsOperator:Cancel()
			countdownBellowsOperator:Cancel()
			voicePhaseChange:Play("ptwo")
			--Start adds timers. Seem same in all modes.
			if not self:IsLFR() then-- LFR do not have Slag Elemental.
				timerSlagElemental:Start(15, 1)
			end
			self:Schedule(71, SecurityGuard, self)
			timerSecurityGuard:Start(71)
			self:Schedule(78, FireCaller, self)
			timerFireCaller:Start(78)
			if DBM.BossHealth:IsShown() then
				DBM.BossHealth:Clear()
			end
			self:RegisterShortTermEvents(
				"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
			)
		end
	elseif cid == 76809 then
		timerRuptureCD:Cancel()
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if not DBM.BossHealth:IsShown() then return end
	for i = 1, 5 do
		local unitID = "boss"..i
		local unitGUID = UnitGUID(unitID)
		local cid = self:GetCIDFromGUID(unitGUID)
		if self.vb.phase == 2 and cid == 76815 and UnitExists(unitID) and not activePrimalGUIDS[unitGUID] then
			activePrimal = activePrimal + 1
			activePrimalGUIDS[unitGUID] = true
			DBM.BossHealth:AddBoss(unitGUID)
		end
	end
end

do
	local totalTime = 30
	local UnitPower = UnitPower
	function mod:UNIT_POWER_FREQUENT(uId, type)
		if type == "ALTERNATE" then
			totalTime = 30
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
			if self.vb.lastTotal ~= totalTime then--CD changed
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
