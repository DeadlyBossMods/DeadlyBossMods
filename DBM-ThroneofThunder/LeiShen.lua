local mod	= DBM:NewMod(832, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68397)--Diffusion Chain Conduit 68696, Static Shock Conduit 68398, Bouncing Bolt conduit 68698, Overcharge conduit 68697
mod:SetEncounterID(1579)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)--All icons can be used, because if a pillar is level 3, it puts out 4 debuffs on 25 man (if both are level 3, then you will have 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 135095 136850 136478",
	"SPELL_AURA_APPLIED 135000 134912 135695 136295 135680 135681 139011 136914",
	"SPELL_AURA_APPLIED_DOSE 136914",
	"SPELL_CAST_SUCCESS 135991 136543 108199 114028",
	"SPELL_AURA_REMOVED 135680 135681 135682 135683 135695 136295",
	"SPELL_PERIODIC_DAMAGE 135153 137176",
	"SPELL_PERIODIC_MISSED 135153 137176",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--Conduits (All phases)
local warnStaticShock					= mod:NewTargetAnnounce(135695, 4)
local warnDiffusionChain				= mod:NewTargetAnnounce(135991, 3)--More informative than actually preventative. (you need to just spread out, and that's it. can't control who it targets only that it doesn't spread)
local warnDiffusionChainSpread			= mod:NewAnnounce("warnDiffusionChainSpread", 4, 135991)
local warnOvercharged					= mod:NewTargetAnnounce(136295, 3)
local warnBouncingBolt					= mod:NewSpellAnnounce(136361, 3)
--Phase 1
local warnDecapitate					= mod:NewTargetAnnounce(134912, 4, nil, mod:IsTank() or mod:IsHealer())
local warnThunderstruck					= mod:NewCountAnnounce(135095, 3)--Target scanning seems to not work
--Phase 2
local warnPhase2						= mod:NewPhaseAnnounce(2)
local warnFusionSlash					= mod:NewSpellAnnounce(136478, 4, nil, mod:IsTank() or mod:IsHealer())
local warnLightningWhip					= mod:NewCountAnnounce(136850, 3)
local warnSummonBallLightning			= mod:NewCountAnnounce(136543, 3)--This seems to be VERY important to spread for. It spawns an orb for every person who takes damage. MUST range 6 this.
local warnGorefiendsGrasp				= mod:NewCountAnnounce(108199, 1)
local warnMassSpellReflect				= mod:NewCountAnnounce(114028, 1)
--Phase 3
local warnPhase3						= mod:NewPhaseAnnounce(3)
local warnViolentGaleWinds				= mod:NewSpellAnnounce(136889, 3)
--Heroic
local warnHelmOfCommand					= mod:NewTargetAnnounce(139011, 3)

--Conduits (All phases)
local specWarnStaticShock				= mod:NewSpecialWarningYou(135695)
local yellStaticShock					= mod:NewYell(135695, L.StaticYell)
local specWarnStaticShockNear			= mod:NewSpecialWarningClose(135695)
local specWarnDiffusionChainSoon		= mod:NewSpecialWarningPreWarn(135991, nil, 4)
local specWarnOvercharged				= mod:NewSpecialWarningYou(136295)
local yellOvercharged					= mod:NewYell(136295)
local specWarnOverchargedNear			= mod:NewSpecialWarningClose(136295)
local specWarnBouncingBoltSoon			= mod:NewSpecialWarningPreWarn(136361, nil, 4)
local specWarnBouncingBolt				= mod:NewSpecialWarningSpell(136361)
--Phase 1
local specWarnDecapitate				= mod:NewSpecialWarningRun(134912, mod:IsTank(), nil, nil, 3)
local specWarnDecapitateOther			= mod:NewSpecialWarningTarget(134912, mod:IsTank())
local specWarnThunderstruck				= mod:NewSpecialWarningCount(135095, nil, nil, nil, 2)
local specWarnCrashingThunder			= mod:NewSpecialWarningMove(135150)
local specWarnIntermissionSoon			= mod:NewSpecialWarning("specWarnIntermissionSoon")
--Phase 2
local specWarnFusionSlash				= mod:NewSpecialWarningSpell(136478, mod:IsTank(), nil, nil, 3)--Cast (394514 is debuff. We warn for cast though because it knocks you off platform if not careful)
local specWarnLightningWhip				= mod:NewSpecialWarningCount(136850, nil, nil, nil, 2)
local specWarnSummonBallLightning		= mod:NewSpecialWarningCount(136543)
local specWarnOverloadedCircuits		= mod:NewSpecialWarningMove(137176)
local specWarnGorefiendsGrasp			= mod:NewSpecialWarningCount(108199, false)--For heroic, gorefiends+stun timing is paramount to success
local specWarnMassSpellReflect			= mod:NewSpecialWarningCount(114028, false)--For heroic, diffusion strat.
--Phase 3
local specWarnElectricalShock			= mod:NewSpecialWarningStack(136914, mod:IsTank(), 12)
local specWarnElectricalShockOther		= mod:NewSpecialWarningTarget(136914, mod:IsTank())
--Herioc
local specWarnHelmOfCommand				= mod:NewSpecialWarningYou(139011, nil, nil, nil, 3)

--Conduits (All phases)
local timerConduitCD					= mod:NewTimer(40, "timerConduitCD", 135695)
local timerStaticShock					= mod:NewBuffFadesTimer(8, 135695)
local timerStaticShockCD				= mod:NewCDTimer(40, 135695)
local timerDiffusionChainCD				= mod:NewCDTimer(40, 135991)
local timerOvercharge					= mod:NewCastTimer(6, 136295)
local timerOverchargeCD					= mod:NewCDTimer(40, 136295)
local timerBouncingBoltCD				= mod:NewCDTimer(40, 136361)
local timerSuperChargedConduits			= mod:NewBuffActiveTimer(47, 137045)--Actually intermission only, but it fits best with conduits
--Phase 1
local timerDecapitateCD					= mod:NewCDTimer(50, 134912, nil, mod:IsTank())--Cooldown with some variation. 50-57ish or so.
local timerThunderstruck				= mod:NewCastTimer(4.8, 135095)--4 sec cast. + landing 0.8~1.3 sec.
local timerThunderstruckCD				= mod:NewNextCountTimer(46, 135095)--Seems like an exact bar
--Phase 2
local timerFussionSlashCD				= mod:NewCDTimer(42.5, 136478, nil, mod:IsTank())
local timerLightningWhip				= mod:NewCastTimer(4, 136850)
local timerLightningWhipCD				= mod:NewNextCountTimer(45.5, 136850)--Also an exact bar
local timerSummonBallLightningCD		= mod:NewNextCountTimer(45.5, 136543)--Seems exact on live, versus the variable it was on PTR
--Phase 3
local timerViolentGaleWinds				= mod:NewBuffActiveTimer(18, 136889)
local timerViolentGaleWindsCD			= mod:NewNextTimer(30.5, 136889)
--Heroic
local timerHelmOfCommand				= mod:NewCDTimer(14, 139011)
local timerMassSpellReflect				= mod:NewBuffActiveTimer(5, 114028)

local berserkTimer						= mod:NewBerserkTimer(900)--Confirmed in LFR, probably the same in all modes though?

local countdownThunderstruck			= mod:NewCountdown(46, 135095)
local countdownBouncingBolt				= mod:NewCountdown(40, 136361, nil, nil, nil, nil, true)--Pretty big deal on heroic, it's the one perminent ability you see in all strats. Should now play nice with thunderstruck with alternate voice code in ;)
local countdownDiffusionChain			= mod:NewCountdown(40, 135991, nil, nil, nil, nil, true)
local countdownStaticShockFades			= mod:NewCountdownFades(7, 135695, false)--May confuse with thundershock option default so off as default.

local soundDecapitate					= mod:NewSound(134912)

mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("OverchargeArrow")--On by default because the overcharge target is always pinned and unable to run away. You must always run to them, so everyone will want this arrow on
mod:AddBoolOption("StaticShockArrow", false)--Off by default as most static shock stack points are pre defined and not based on running to player, but rathor running to a raid flare on ground
mod:AddBoolOption("SetIconOnOvercharge", true)
mod:AddBoolOption("SetIconOnStaticShock", true)

mod.vb.phase = 1
mod.vb.warnedCount = 0
mod.vb.intermissionActive = false--Not in use yet, but will be. This will be used (once we have CD bars for regular phases mapped out) to prevent those cd bars from starting during intermissions and messing up the custom intermission bars
mod.vb.northDestroyed = false
mod.vb.eastDestroyed = false
mod.vb.southDestroyed = false
mod.vb.westDestroyed = false
mod.vb.ballsCount = 0
mod.vb.whipCount = 0
mod.vb.thunderCount = 0
mod.vb.goreCount = 0
mod.vb.reflectCount = 0
mod.vb.diffusionCastTarget = nil
local staticshockTargets = {}
local diffusionTargets = {}
local staticIcon = 8--Start high and count down
local overchargeTarget = {}
local overchargeIcon = 1--Start low and count up
local helmOfCommandTarget = {}
local playerName = UnitName("player")

local function warnStaticShockTargets()
	warnStaticShock:Show(table.concat(staticshockTargets, "<, >"))
	table.wipe(staticshockTargets)
	staticIcon = 8
end

local function warnDiffusionSpreadTargets(spellName)
	warnDiffusionChainSpread:Show(spellName, table.concat(diffusionTargets, "<, >"))
	table.wipe(diffusionTargets)
end

local function warnOverchargeTargets()
	warnOvercharged:Show(table.concat(overchargeTarget, "<, >"))
	table.wipe(overchargeTarget)
	overchargeIcon = 1
end

local function warnHelmOfCommandTargets()
	warnHelmOfCommand:Show(table.concat(helmOfCommandTarget, "<, >"))
	table.wipe(helmOfCommandTarget)
end

function mod:OnCombatStart(delay)
	table.wipe(staticshockTargets)
	table.wipe(overchargeTarget)
	staticIcon = 8
	overchargeIcon = 1
	self.vb.phase = 1
	self.vb.warnedCount = 0
	self.vb.intermissionActive = false
	self.vb.northDestroyed = false
	self.vb.eastDestroyed = false
	self.vb.southDestroyed = false
	self.vb.westDestroyed = false
	self.vb.ballsCount = 0
	self.vb.whipCount = 0
	self.vb.thunderCount = 0
	self.vb.goreCount = 0
	self.vb.reflectCount = 0
	timerThunderstruckCD:Start(25-delay, 1)
	countdownThunderstruck:Start(25-delay)
	timerDecapitateCD:Start(40-delay)--First seems to be 45, rest 50. it's a CD though, not a "next"
	timerConduitCD:Start(11-delay)--First always 11 seconds after engage, unless not in range of a pillar within 11 seconds, then cast instantly after 11 sec mark the moment he is in range of pillar
	berserkTimer:Start(-delay)
	self:RegisterShortTermEvents(
		"UNIT_HEALTH_FREQUENT boss1",
		"SPELL_DAMAGE 135150 135991",
		"SPELL_MISSED 135150 135991"
	)-- Do not use on phase 3.
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.OverchargeArrow or self.Options.StaticShockArrow then
		DBM.Arrow:Hide()
	end
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 135095 then
		self.vb.thunderCount = self.vb.thunderCount + 1
		warnThunderstruck:Show(self.vb.thunderCount)
		specWarnThunderstruck:Show(self.vb.thunderCount)
		timerThunderstruck:Start()
		if self.vb.phase < 3 then
			timerThunderstruckCD:Start(nil, self.vb.thunderCount+1)
			countdownThunderstruck:Start()
		else
			timerThunderstruckCD:Start(30, self.vb.thunderCount+1)
			countdownThunderstruck:Start(30)
		end
	--"<206.2 20:38:58> [UNIT_SPELLCAST_SUCCEEDED] Lei Shen [[boss1:Lightning Whip::0:136845]]", -- [13762] --This event comes about .5 seconds earlier than SPELL_CAST_START. Maybe worth using?
	elseif spellId == 136850 then
		self.vb.whipCount = self.vb.whipCount + 1
		warnLightningWhip:Show(self.vb.whipCount)
		specWarnLightningWhip:Show(self.vb.whipCount)
		timerLightningWhip:Start()
		if self.vb.phase < 3 then
			timerLightningWhipCD:Start(nil, self.vb.whipCount+1)
		else
			timerLightningWhipCD:Start(30, self.vb.whipCount+1)
		end
	elseif spellId == 136478 then
		warnFusionSlash:Show()
		timerFussionSlashCD:Start()
		if self:IsDifficulty("lfr25") then return end
		specWarnFusionSlash:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if args:IsSpellID(135000, 134912) then--Is 135000 still used on 10 man?
		warnDecapitate:Show(args.destName)
		timerDecapitateCD:Start()
		if self:IsDifficulty("lfr25") then return end
		if args:IsPlayer() then
			specWarnDecapitate:Show()
			soundDecapitate:Play()
		else
			specWarnDecapitateOther:Show(args.destName)
		end
	--Conduit activations
	elseif spellId == 135695 then
		staticshockTargets[#staticshockTargets + 1] = args.destName
		if self.Options.SetIconOnStaticShock then
			self:SetIcon(args.destName, staticIcon)
			staticIcon = staticIcon - 1
		end
		if not self.vb.intermissionActive then
			timerStaticShockCD:Start()
		end
		self:Unschedule(warnStaticShockTargets)
		self:Schedule(0.3, warnStaticShockTargets)
		if args:IsPlayer() then
			specWarnStaticShock:Show()
			if not self:IsDifficulty("lfr25") then
				yellStaticShock:Schedule(7, playerName, 1)
				yellStaticShock:Schedule(6, playerName, 2)
				yellStaticShock:Schedule(5, playerName, 3)
				yellStaticShock:Schedule(4, playerName, 4)
			end
			yellStaticShock:Schedule(3, playerName, 5)
			timerStaticShock:Start()
			countdownStaticShockFades:Start()
		else
			if not self.vb.intermissionActive and self:IsMelee() then return end--Melee do not help soak these during normal phases, only during intermissions
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				local inRange = DBM.RangeCheck:GetDistance("player", x, y)
				if inRange and inRange < 31 then
					specWarnStaticShockNear:Show(args.destName)
					if self.Options.StaticShockArrow then
						DBM.Arrow:ShowRunTo(args.destName, 3, 3, 8)
					end
				end
			end
		end
	elseif spellId == 136295 then
		overchargeTarget[#overchargeTarget + 1] = args.destName
		timerOvercharge:Start()
		if self.Options.SetIconOnOvercharge then
			self:SetIcon(args.destName, overchargeIcon)
			overchargeIcon = overchargeIcon + 1
		end
		if not self.vb.intermissionActive then
			timerOverchargeCD:Start()
		end
		self:Unschedule(warnOverchargeTargets)
		self:Schedule(0.3, warnOverchargeTargets)
		if args:IsPlayer() then
			specWarnOvercharged:Show()
			yellOvercharged:Yell()
		else
			if not self.vb.intermissionActive and self:IsMelee() then return end--Melee do not help soak these during normal phases, only during intermissions
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				local inRange = DBM.RangeCheck:GetDistance("player", x, y)
				if inRange and inRange < 31 then
					specWarnOverchargedNear:Show(args.destName)
					if self.Options.OverchargeArrow then
						DBM.Arrow:ShowRunTo(args.destName, 3, 3, 6)
					end
				end
			end
		end
	elseif spellId == 135680 and args:GetDestCreatureID() == 68397 then--North (Static Shock)
		--start timers here when we have em
	elseif spellId == 135681 and args:GetDestCreatureID() == 68397 then--East (Diffusion Chain)
		if self.Options.RangeFrame and self:IsRanged() then--Shouldn't target melee during a normal pillar, only during intermission when all melee are with ranged and out of melee range of boss
			DBM.RangeCheck:Show(8)--Assume 8 since spell tooltip has no info
		end
	elseif spellId == 139011 then
		helmOfCommandTarget[#helmOfCommandTarget + 1] = args.destName
		if args:IsPlayer() then
			specWarnHelmOfCommand:Show()
		end
		self:Unschedule(warnHelmOfCommandTargets)
		self:Schedule(0.3, warnHelmOfCommandTargets)
	elseif spellId == 136914 then
		local amount = args.amount or 1
		if amount >= 12 and self:AntiSpam(2.5, 6) then
			if args:IsPlayer() then
				specWarnElectricalShock:Show(args.amount)
			else
				specWarnElectricalShockOther:Show(args.destName)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 135991 then
		self.vb.diffusionCastTarget = args.destName
		warnDiffusionChain:Show(self.vb.diffusionCastTarget)
		if not self.vb.intermissionActive then
			timerDiffusionChainCD:Start()
			if not (self.vb.phase == 2 and self.vb.westDestroyed) or not self:IsDifficulty("heroic10", "heroic25") then--Disable this countdown in phase 2 if using bouncing bolt strat. so they don't overlap. this is mainly for the diffusion chain strat (ie overloading DC and static shock on heroic vs bouncing and static)
				countdownDiffusionChain:Start()
			end
			specWarnDiffusionChainSoon:Schedule(36)
		end
	elseif spellId == 136543 and self:AntiSpam(2, 1) then
		self.vb.ballsCount = self.vb.ballsCount + 1
		warnSummonBallLightning:Show(self.vb.ballsCount)
		specWarnSummonBallLightning:Show(self.vb.ballsCount)
		if self.vb.phase < 3 then
			timerSummonBallLightningCD:Start(nil, self.vb.ballsCount+1)
		else
			timerSummonBallLightningCD:Start(30, self.vb.ballsCount+1)
		end
	elseif spellId == 108199 and self:IsInCombat() then
		if self.vb.goreCount == 2 then self.vb.goreCount = 0 end
		self.vb.goreCount = self.vb.goreCount + 1
		warnGorefiendsGrasp:Show(self.vb.goreCount)
		specWarnGorefiendsGrasp:Show(self.vb.goreCount)
	elseif spellId == 114028 and self:IsInCombat() then
		if self.vb.reflectCount == 2 then self.vb.reflectCount = 0 end
		self.vb.reflectCount = self.vb.reflectCount + 1
		warnMassSpellReflect:Show(self.vb.reflectCount)
		specWarnMassSpellReflect:Show(self.vb.reflectCount)
		timerMassSpellReflect:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	--Conduit deactivations
	if spellId == 135680 and args:GetDestCreatureID() == 68397 and not self.vb.intermissionActive then--North (Static Shock)
		timerStaticShockCD:Cancel()
	elseif spellId == 135681 and args:GetDestCreatureID() == 68397 and not self.vb.intermissionActive then--East (Diffusion Chain)
		timerDiffusionChainCD:Cancel()
		countdownDiffusionChain:Cancel()
		specWarnDiffusionChainSoon:Cancel()
		if self.Options.RangeFrame and self:IsRanged() then--Shouldn't target melee during a normal pillar, only during intermission when all melee are with ranged and out of melee range of boss
			if self.vb.phase == 1 then
				DBM.RangeCheck:Hide()
			else
				DBM.RangeCheck:Show(6)--Switch back to Summon Lightning Orb spell range
			end
		end
	elseif spellId == 135682 and args:GetDestCreatureID() == 68397 and not self.vb.intermissionActive then--South (Overcharge)
		timerOverchargeCD:Cancel()
	elseif spellId == 135683 and args:GetDestCreatureID() == 68397 and not self.vb.intermissionActive then--West (Bouncing Bolt)
		timerBouncingBoltCD:Cancel()
		countdownBouncingBolt:Cancel()
		specWarnBouncingBoltSoon:Cancel()
	--Conduit deactivations
	elseif spellId == 135695 and self.Options.SetIconOnStaticShock then
		self:SetIcon(args.destName, 0)
	elseif spellId == 136295 and self.Options.SetIconOnOvercharge then
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId, spellName)
	if spellId == 135150 and destGUID == UnitGUID("player") and self:AntiSpam(1.5, 4) then
		specWarnCrashingThunder:Show()
	elseif spellId == 135991 and destName ~= self.vb.diffusionCastTarget then--Filter actual target, so we only announce SPREADS
		diffusionTargets[#diffusionTargets + 1] = destName
		self:Unschedule(warnDiffusionSpreadTargets)
		if #diffusionTargets >= 1 then
			self:Schedule(0.3, warnDiffusionSpreadTargets, spellName)
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 135153 and destGUID == UnitGUID("player") and self:AntiSpam(1.5, 4) then
		specWarnCrashingThunder:Show()
	elseif spellId == 137176 and destGUID == UnitGUID("player") and self:AntiSpam(3, 5) then
		specWarnOverloadedCircuits:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:137176") then--Overloaded Circuits (Intermission ending and next phase beginning)
		self.vb.intermissionActive = false
		self.vb.phase = self.vb.phase + 1
		self.vb.goreCount = 0
		self.vb.reflectCount = 0
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		--"<174.8 20:38:26> [CHAT_MSG_RAID_BOSS_EMOTE] CHAT_MSG_RAID_BOSS_EMOTE#|TInterface\\Icons\\spell_nature_unrelentingstorm.blp:20|t The |cFFFF0000|Hspell:135683|h[West Conduit]|h|r has burned out and caused |cFFFF0000|Hspell:137176|h[Overloaded Circuits]|h|r!#Bouncing Bolt Conduit
		if msg:find("spell:135680") then--North (Static Shock)
			self.vb.northDestroyed = true
		elseif msg:find("spell:135681") then--East (Diffusion Chain)
			self.vb.eastDestroyed = true
		elseif msg:find("spell:135682") then--South (Overcharge)
			self.vb.southDestroyed = true
		elseif msg:find("spell:135683") then--West (Bouncing Bolt)
			self.vb.westDestroyed = true
		end
		if self.vb.phase == 2 then--Start Phase 2 timers
			warnPhase2:Show()
			timerConduitCD:Start(14)--min time, will cast right away unless delayed by heroic special getting cast first or because he's not in range of a conduit yet
			timerSummonBallLightningCD:Start(15, 1)
			timerLightningWhipCD:Start(30, 1)
			timerFussionSlashCD:Start(44)
			if self.Options.RangeFrame and self:IsRanged() then--Only ranged need it in phase 2 and 3
				DBM.RangeCheck:Show(6)--Needed for phase 2 AND phase 3
			end
			if self:IsDifficulty("heroic10", "heroic25") then
				--Basically a CD, may come later if delayed by other crap
				--15-19 variation. but you need this timing to hit spell reflect at 15 (it lasts 5 seconds so covers the variation)
				if self.vb.northDestroyed then
					timerStaticShockCD:Start(14)
				end
				if self.vb.eastDestroyed then
					timerDiffusionChainCD:Start(14)
					countdownDiffusionChain:Start(14)
					if self.Options.RangeFrame and self:IsRanged() then
						DBM.RangeCheck:Show(8)
					end
				end
				if self.vb.southDestroyed then
					timerOverchargeCD:Start(14)
				end
				if self.vb.westDestroyed then
					timerBouncingBoltCD:Start(14)
					if not self.vb.eastDestroyed or not self:IsDifficulty("heroic10", "heroic25") then--Why in the hell would you do that? Diffusion chaim & bouncing bolts? you must be nuts
						countdownBouncingBolt:Start(14)--Of the two, diffusion chains more important so we disable bouncing count
					end
				end
			end
		elseif self.vb.phase == 3 then--Start Phase 3 timers
			self:UnregisterShortTermEvents()
			self.vb.ballsCount = 0
			self.vb.whipCount = 0
			self.vb.thunderCount = 0
			warnPhase3:Show()
			timerViolentGaleWindsCD:Start(20)
			timerLightningWhipCD:Start(21.5, 1)
			timerThunderstruckCD:Start(36, 1)
			countdownThunderstruck:Start(36)
			timerSummonBallLightningCD:Start(41.5, 1)
			if self:IsDifficulty("heroic10", "heroic25") then
				--Basically a CD, may come later if delayed by other crap
				--28-32 variation. but you need this timing to hit spell reflect at 15 (it lasts 5 seconds so covers the variation)
				if self.vb.northDestroyed then
					timerStaticShockCD:Start(28)
				end
				if self.vb.eastDestroyed then
					timerDiffusionChainCD:Start(28)
					if not self.vb.westDestroyed or not self:IsDifficulty("heroic10", "heroic25") then--Why in the fuck would you do that? Diffusion chaim & bouncing bolts? you must be nuts
						countdownDiffusionChain:Start(28)
					end
				end
				if self.vb.southDestroyed then
					timerOverchargeCD:Start(28)
				end
				if self.vb.westDestroyed then--Technically also 28, however
					timerBouncingBoltCD:Start(32)--Always goes second, over any of other 3 abilities, and that delays it by 4 seconds
					countdownBouncingBolt:Start(32)
				end
			end
		end
	end
end

local function LoopIntermission()
	if not mod.vb.southDestroyed or mod:IsDifficulty("heroic10", "heroic25") then
		if mod:IsDifficulty("lfr25") then
			timerOverchargeCD:Start(17.5)
		else
			timerOverchargeCD:Start(6.5)
		end
	end
	if not mod.vb.eastDestroyed or mod:IsDifficulty("heroic10", "heroic25") then
		if mod:IsDifficulty("lfr25") then
			timerDiffusionChainCD:Start(17.5)
		else
			timerDiffusionChainCD:Start(8)
		end
	end
	if not mod.vb.westDestroyed or mod:IsDifficulty("heroic10", "heroic25") then
		if mod:IsDifficulty("lfr25") then
			warnBouncingBolt:Schedule(8.5)
			specWarnBouncingBolt:Schedule(8.5)
			timerBouncingBoltCD:Start(8.5)
		elseif mod:IsDifficulty("heroic10", "heroic25") then
			warnBouncingBolt:Schedule(15.5)--Delayed by second helm of command i believe
			specWarnBouncingBolt:Schedule(15.5)
			timerBouncingBoltCD:Start(15.5)
		else
			warnBouncingBolt:Schedule(14)
			specWarnBouncingBolt:Schedule(14)
			timerBouncingBoltCD:Start(14)
		end
	end
	if (not mod:IsDifficulty("lfr25") and not mod.vb.northDestroyed) or mod:IsDifficulty("heroic10", "heroic25") then--Doesn't cast a 2nd one in LFR
		timerStaticShockCD:Start(16)
	end
	if mod:IsDifficulty("heroic10", "heroic25") then
		timerHelmOfCommand:Start(15)
	end
end

function mod:UNIT_HEALTH_FREQUENT(uId)
	local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
	if hp > 65 and hp < 67.5 and self.vb.warnedCount == 0 then
		self.vb.warnedCount = 1
		specWarnIntermissionSoon:Show()
	elseif hp > 30 and hp < 32.5 and self.vb.warnedCount == 1 then
		self.vb.warnedCount = 2
		specWarnIntermissionSoon:Show()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 137146 and self:AntiSpam(2, 2) then--Supercharge Conduits (comes earlier than other events so we use this one)
		self.vb.intermissionActive = true
		specWarnDiffusionChainSoon:Cancel()
		specWarnBouncingBoltSoon:Cancel()
		timerThunderstruckCD:Cancel()
		countdownThunderstruck:Cancel()
		timerDecapitateCD:Cancel()
		timerFussionSlashCD:Cancel()
		timerLightningWhipCD:Cancel()
		timerSummonBallLightningCD:Cancel()
		timerSuperChargedConduits:Start()
		timerStaticShockCD:Cancel()
		timerDiffusionChainCD:Cancel()
		countdownDiffusionChain:Cancel()
		timerOverchargeCD:Cancel()
		timerBouncingBoltCD:Cancel()
		countdownBouncingBolt:Cancel()
		if not self.vb.eastDestroyed or self:IsDifficulty("heroic10", "heroic25") then
			if self:IsDifficulty("lfr25") then
				timerDiffusionChainCD:Start(10)
			else
				timerDiffusionChainCD:Start(6)
			end
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
		if not self.vb.southDestroyed or self:IsDifficulty("heroic10", "heroic25") then
			if self:IsDifficulty("lfr25") then
				timerOverchargeCD:Start(10)
			else
				timerOverchargeCD:Start(6)
			end
		end
		if (not self.vb.westDestroyed and not self:IsDifficulty("lfr25")) or self:IsDifficulty("heroic10", "heroic25") then--Doesn't get cast in first wave in LFR, only second
			warnBouncingBolt:Schedule(14)
			specWarnBouncingBolt:Schedule(14)
			timerBouncingBoltCD:Start(14)
		end
		if not self.vb.northDestroyed or self:IsDifficulty("heroic10", "heroic25") then
			if self:IsDifficulty("lfr25") then
				timerStaticShockCD:Start(21)
			else
				timerStaticShockCD:Start(19)
			end
		end
		self:Schedule(23, LoopIntermission)--Fire function to start second wave of specials timers
		if self:IsDifficulty("heroic10", "heroic25") then
			timerHelmOfCommand:Start(14)
		end
	elseif spellId == 136395 and self:AntiSpam(2, 3) and not self.vb.intermissionActive then--Bouncing Bolt (During intermission phases, it fires randomly, use scheduler and filter this :\)
		warnBouncingBolt:Show()
		specWarnBouncingBolt:Show()
		timerBouncingBoltCD:Start(40)
		if not (self.vb.phase == 2 and self.vb.eastDestroyed) or not self:IsDifficulty("heroic10", "heroic25") then--Disable this countdown in phase 2 if using diffusion strat
			countdownBouncingBolt:Start(40)
		end
		specWarnBouncingBoltSoon:Schedule(36)
	elseif spellId == 136869 and self:AntiSpam(2, 4) then--Violent Gale Winds
		warnViolentGaleWinds:Show()
		timerViolentGaleWinds:Start()
		timerViolentGaleWindsCD:Start()
	end
end
