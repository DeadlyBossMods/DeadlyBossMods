local mod	= DBM:NewMod(1438, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91331)--Doomfire Spirit (92208), Hellfire Deathcaller (92740), Felborne Overfiend (93615), Dreadstalker (93616), Infernal doombringer (94412)
mod:SetEncounterID(1799)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
mod:SetHotfixNoticeRev(13939)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 183254 189897 183817 183828 185590 184265 183864 190506 184931",
	"SPELL_CAST_SUCCESS 183865 184931 187180",
	"SPELL_AURA_APPLIED 182879 183634 183865 184964 186574 187180 186961 189895 186123 186662 186952 190400 190703",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 186123 185014 187180 186961 186952 184964 190400",
	"CHAT_MSG_MONSTER_YELL",
	"RAID_BOSS_WHISPER",
	"CHAT_MSG_ADDON",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO< figure out rain of chaos (182225). periodic trigger of every 12 seconds. but how to detect? Logs show nothing, maybe have to schedule repeating loop. Need videos to verify timing before adding
--TODO, custom voice to "attack doomfire spirit" and "attack Death caller". Can't just use "attack mob" because if they spawn at same time there is a priority. If doomfire spirit is up I own't even play attack death caller sound until doomfire is dead.
--TODO< rest of regular voices when i'mnot so tired
--TODO, failsafes are at work for transitions i still don't have enough data for. for example, something seems to always cause the 2nd or 3rd fel burst to delay by a HUGE amount (20-30 seconds sometimes) but don't know what it is. Probalby phase transitions but it's not as simple as resetting timer. probably something more zon ozz
--Phase 1: The Defiler
local warnDoomfireFixate			= mod:NewTargetAnnounce(182879, 3)
local warnFelBurst					= mod:NewTargetAnnounce(183817, 4)--Target scanning impossible. Cannot pre warn target until knock up
local warnDemonicHavoc				= mod:NewTargetAnnounce(183865, 3)--Mythic
--Phase 2: Hand of the Legion
local warnShackledTorment			= mod:NewTargetAnnounce(184964, 3)
local warnUnleashedTorment			= mod:NewAddsLeftAnnounce(185008, 2)--NewAddsLeftAnnounce perfect for this!
local warnWroughtChaos				= mod:NewTargetAnnounce(184265, 4)--Combined both targets into one warning under primary spell name
local warnDreadFixate				= mod:NewTargetAnnounce(186574, 2, nil, false)--In case it matters on mythic, it was spammy on heroic and unimportant
--Phase 3: The Twisting Nether
local warnDemonicFeedback			= mod:NewTargetAnnounce(187180, 3)
local warnNetherBanish				= mod:NewTargetAnnounce(186961, 2)
----The Nether
local warnVoidStarFixate			= mod:NewTargetAnnounce(189895, 2)
--Mythic
local warnTouchofLegion				= mod:NewTargetAnnounce(190400, 4)

--Phase 1: The Defiler
local specWarnDoomfire				= mod:NewSpecialWarningSwitch(189897, "Dps", nil, nil, 1, 5)
local specWarnDoomfireFixate		= mod:NewSpecialWarningYou(182879, nil, nil, nil, 4)
local yellDoomfireFixate			= mod:NewYell(182826)--Use short name for yell
local specWarnAllureofFlames		= mod:NewSpecialWarningSpell(183254, nil, nil, nil, 2, 2)
local specWarnDeathCaller			= mod:NewSpecialWarningSwitch("ej11582", "Dps", nil, nil, 1, 2)--Tanks don't need switch, they have death brand special warning 2 seconds earlier
local specWarnFelBurst				= mod:NewSpecialWarningYou(183817)
local yellFelBurst					= mod:NewYell(183817)--Change yell to countdown mayeb when better understood
local specWarnFelBurstNear			= mod:NewSpecialWarningMoveTo(183817, nil, nil, nil, 1, 2)--Anyone near by should run in to help soak, should be mostly ranged but if it's close to melee, melee soaking too doesn't hurt
local specWarnDesecrate				= mod:NewSpecialWarningDodge(185590, "Melee", nil, nil, 1, 2)
local specWarnDeathBrand			= mod:NewSpecialWarningSpell(183828, "Tank")
--Phase 2: Hand of the Legion
local specWarnBreakShackle			= mod:NewSpecialWarning("specWarnBreakShackle", nil, nil, nil, 1, 5)
local yellShackledTorment			= mod:NewYell(184964, L.customShackledSay)
local specWarnWroughtChaos			= mod:NewSpecialWarningMoveAway(186123, nil, nil, nil, 3, 5)
local yellWroughtChaos				= mod:NewYell(186123)
local specWarnFocusedChaos			= mod:NewSpecialWarningMoveAway(185014, nil, nil, nil, 3, 5)
local yellFocusedChaos				= mod:NewYell(185014)
local specWarnDreadFixate			= mod:NewSpecialWarningYou(186574, false)--In case it matters on mythic, it was spammy on heroic and unimportant
--Phase 3: The Twisting Nether
local specWarnDemonicFeedback		= mod:NewSpecialWarningYou(187180)
local yellDemonicFeedback			= mod:NewYell(187180, nil, false)
local specWarnDemonicFeedbackOther	= mod:NewSpecialWarningTarget(187180, "Healer")
local specWarnNetherBanish			= mod:NewSpecialWarningYou(186961)
local specWarnNetherBanishOther		= mod:NewSpecialWarningTaunt(186961)
local yellNetherBanish				= mod:NewFadesYell(186961)
----The Nether
local specWarnVoidStarFixate		= mod:NewSpecialWarningYou(189895)--Maybe move away? depends how often it changes fixate targets
local yellVoidStarFixate			= mod:NewYell(189895, nil, false)
--Phase 3.5
local specWarnRainofChaos			= mod:NewSpecialWarningSpell(189953, nil, nil, nil, 2)
--Mythic
local specWarnSeethingCorruption	= mod:NewSpecialWarningSpell(190506, nil, nil, nil, 2)
local specWarnTouchofLegion			= mod:NewSpecialWarningYou(190400)--Somehow i suspect this replaces fel burst. It's basically same mechanic, but on multiple people and slightly larger
local yellTouchofLegion				= mod:NewFadesYell(190400)
local specWarnSourceofChaos			= mod:NewSpecialWarningYou(190703)
local yellSourceofChaos				= mod:NewYell(190703)
local specWarnSourceofChaosOthers	= mod:NewSpecialWarningSwitch(190703)--Maybe exclude ranged or healers. Not sure if just dps is enough to soak it, at very least dps have to kill it
--

--Phase 1: The Defiler
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerDoomfireCD				= mod:NewCDTimer(42.1, 182826)--182826 cast, 182879 fixate. Doomfire only fixates ranged, but ALL dps switch to it.
local timerAllureofFlamesCD			= mod:NewCDTimer(47.5, 183254)
local timerFelBurstCD				= mod:NewCDTimer(47.3, 183817, nil, "Ranged")--Only targets ranged
local timerDeathbrandCD				= mod:NewCDTimer(42.5, 183828)--Everyone, for tanks/healers to know when debuff/big hit, for dps to know add coming
local timerDesecrateCD				= mod:NewCDTimer(27, 185590, nil, "Melee")--Only targets melee
----Hellfire Deathcaller
local timerShadowBlastCD			= mod:NewCDTimer(9.7, 183864, nil, "Tank")
local timerDemonicHavocCD			= mod:NewAITimer(107, 183865)--Mythic, timer unknown, AI timer used until known
--Phase 2: Hand of the Legion
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerShackledTormentCD		= mod:NewCDTimer(31.5, 184931)
local timerWroughtChaosCD			= mod:NewCDTimer(51.7, 184265)
--Phase 2.5
local timerFelborneOverfiendCD		= mod:NewNextTimer(44.3, "ej11603", nil, nil, nil, 186662)
--Phase 3: The Twisting Nether
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerDemonicFeedbackCD		= mod:NewCDTimer(16.9, 187180)
local timerNetherBanishCD			= mod:NewCDTimer(61.9, 186961)
----The Nether
--Mythic
local timerSeethingCorruptionCD		= mod:NewAITimer(107, 190506)
local timerTouchOfLegionCD			= mod:NewAITimer(107, 190400)
local timerTouchOfLegion			= mod:NewTargetTimer(12, 190400, nil, false)
local timerSourceofChaosCD			= mod:NewAITimer(107, 190703)


--local berserkTimer				= mod:NewBerserkTimer(360)

--countdowns kind of blow with this fights timer variations.
--Everything but overfiend is a CD
--I don't want to use a countdown on something thats 47-56 like allure
local countdownWroughtChaos			= mod:NewCountdownFades(5, 184265)

local voiceFelBurst					= mod:NewVoice(183817)--Gathershare
local voiceShackledTorment			= mod:NewVoice(184964)--new voice: break torment first, etc
local voiceDoomfire					= mod:NewVoice(189897, "Dps")--189897.ogg
local voiceDeathCaller				= mod:NewVoice("ej11582", "Dps")--ej11582.ogg
local voiceWroughtChaos				= mod:NewVoice(186123) --new voice
local voiceFocusedChaos				= mod:NewVoice(185014) --new voice
local voiceAllureofFlamesCD			= mod:NewVoice(183254) --just run

mod:AddRangeFrameOption("8/10")
mod:AddSetIconOption("SetIconOnDemonicFeedback", 187180)
mod:AddHudMapOption("HudMapOnWrought", 184265)--Yellow on caster (wrought chaos), red on target (focused chaos)
mod:AddBoolOption("FilterOtherPhase", true)

--mod.vb.wroughtWarned = 0--Just in case it's spammy and there needs to be some kind of filter
mod.vb.phase = 1
mod.vb.demonicFeedbacks = 0
mod.vb.netherPortals = 0
mod.vb.unleashedCountRemaining = 0
mod.vb.touchOfLegionRemaining = 0
local shacklesTargets = {}
local playerName = UnitName("player")
local playerBanished = false
local AddsSeen = {}
local UnitDebuff = UnitDebuff
local DemonicFeedback = GetSpellInfo(187180)
local NetherBanish = GetSpellInfo(186961)
local shackledDebuff = GetSpellInfo(184964)
local touchOfLegionDebuff = GetSpellInfo(190400)
local demonicFilter, netherFilter, touchOfLegionFilter
do
	demonicFilter = function(uId)
		if UnitDebuff(uId, DemonicFeedback) then
			return true
		end
	end
	netherFilter = function(uId)
		if UnitDebuff(uId, NetherBanish) then
			return true
		end
	end
	touchOfLegionFilter = function(uId)
		if UnitDebuff(uId, touchOfLegionDebuff) then
			return true
		end
	end
end

local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self.vb.netherPortals > 0 then
		--Blue post says 8, but pretty sure it's 10. The visual was bigger than 8
		if UnitDebuff("player", NetherBanish) then
			DBM.RangeCheck:Show(10)
		else
			DBM.RangeCheck:Show(10, netherFilter)
		end
	elseif self.vb.touchOfLegionRemaining > 0 then
		if UnitDebuff("player", touchOfLegionDebuff) then
			DBM.RangeCheck:Show(10)
		else
			DBM.RangeCheck:Show(10, netherFilter)
		end
	elseif self.vb.demonicFeedbacks > 0 then
		if UnitDebuff("player", DemonicFeedback) then
			DBM.RangeCheck:Show(8)
		else
			DBM.RangeCheck:Show(8, demonicFilter)
		end
	elseif self.vb.phase < 2 and self:IsRanged() then--Fel burst in phase 1
		DBM.RangeCheck:Show(8)
	else
		DBM.RangeCheck:Hide()
	end
end

local function breakShackles(self)
--	I thought about using auto scheduling and doing "break shackle now" with few seconds in between each, then i realized that'd do more harm that good, if raid is low and dbm says break shackle, you wipe.
--	So now it just gives order, but you break at pace needed by your healers
	table.sort(shacklesTargets)
	for i = 1, #shacklesTargets do
		local name = UnitName(shacklesTargets[i])
		if name == playerName then
			if i == 1 then
				specWarnBreakShackle:Show(L.First)
				yellShackledTorment:Yell(L.First, playerName)
				voiceShackledTorment:Play("184964a")
			elseif i == 2 then
				specWarnBreakShackle:Show(L.Second)
				yellShackledTorment:Yell(L.Second, playerName)
				voiceShackledTorment:Play("184964b")
			elseif i == 3 then
				specWarnBreakShackle:Show(L.Third)
				yellShackledTorment:Yell(L.Third, playerName)
				voiceShackledTorment:Play("184964c")
			elseif i == 4 then
				specWarnBreakShackle:Show(L.Fourth)
				yellShackledTorment:Yell(L.Fourth, playerName)
				voiceShackledTorment:Play("184964d")
			elseif i == 5 then
				specWarnBreakShackle:Show(L.Fifth)
				yellShackledTorment:Yell(L.Fifth, playerName)
				voiceShackledTorment:Play("184964e")
			end
		end
	end
	if not playerBanished or not self.Options.FilterOtherPhase then
		--List in message is already in correct break order, since it's sorted first.
		local text = table.concat(shacklesTargets, "<, >")
		warnShackledTorment:Show(text)
	end
end

function mod:OnCombatStart(delay)
	table.wipe(shacklesTargets)
	self.vb.phase = 1
	self.vb.demonicFeedbacks = 0
	self.vb.netherPortals = 0
	self.vb.unleashedCountRemaining = 0
	self.vb.touchOfLegionRemaining = 0
	table.wipe(AddsSeen)
	playerBanished = false
	timerDoomfireCD:Start(6-delay)
	timerDeathbrandCD:Start(18-delay)
	timerAllureofFlamesCD:Start(30-delay)
	timerFelBurstCD:Start(41-delay)
	DBM:AddMsg(DBM_CORE_COMBAT_STARTED_AI_TIMER)--One ai timer remains, for mythic
	updateRangeFrame(self)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnWrought then
		DBMHudMap:Disable()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 183254 then
		if not playerBanished or not self.Options.FilterOtherPhase then
			specWarnAllureofFlames:Show()
			voiceAllureofFlamesCD:Play("justrun")
		end
		timerAllureofFlamesCD:Start()
	elseif spellId == 189897 then
		specWarnDoomfire:Show()
		timerDoomfireCD:Start()
		voiceDoomfire:Play("189897")
	elseif spellId == 183817 then
		timerFelBurstCD:Start()
	elseif spellId == 183828 then
		timerDeathbrandCD:Start()
		specWarnDeathBrand:Show()
	elseif spellId == 185590 then
		specWarnDesecrate:Show()
		timerDesecrateCD:Start()
		if self.vb.phase == 1 then
			self.vb.phase = 1.5--85%
		end
	elseif spellId == 184265 then
--		self.vb.wroughtWarned = 0--Reset Counter
		timerWroughtChaosCD:Start()
		if self.vb.phase < 2 then--0.2-1 second slower than yell, without requiring using yell. Because of variation, I still prefer yell as primary even though this isn't much slower
			self.vb.phase = 2
			--Cancel stuff only used in phase 1
			timerFelBurstCD:Cancel()
			timerDesecrateCD:Cancel()
			timerDoomfireCD:Cancel()
			timerAllureofFlamesCD:Cancel()--Reset to 35.5-1
			timerAllureofFlamesCD:Start(34.5)
			timerShackledTormentCD:Start(11)
		end
	elseif spellId == 183864 then
		timerShadowBlastCD:Start(args.sourceGUID)
	elseif spellId == 190506 then
		specWarnSeethingCorruption:Show()
		timerSeethingCorruptionCD:Start()
	elseif spellId == 184931 then
		table.wipe(shacklesTargets)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 183865 then
		timerDemonicHavocCD:Start(nil, args.sourceGUID)
	elseif spellId == 184931 then
		timerShackledTormentCD:Start()
	elseif spellId == 187180 then
		timerDemonicFeedbackCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 182879 then
		warnDoomfireFixate:Show(args.destName)
		if args:IsPlayer() then
			specWarnDoomfireFixate:Show()
			yellDoomfireFixate:Yell()
		end
	elseif spellId == 183634 then
		warnFelBurst:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFelBurst:Show()
			yellFelBurst:Yell()
		else
			if self:CheckNearby(30, args.destName) then--Range subject to adjustment
				specWarnFelBurstNear:CombinedShow(0.3, args.destName)--Combined show to prevent spam in a spread, if a spread happens targets are all together and requires even MORE people to soak.
				voiceFelBurst:Cancel()--Avoid spam
				voiceFelBurst:Schedule(0.3, "gathershare")
			end
		end
	elseif spellId == 183865 then
		warnDemonicHavoc:CombinedShow(0.3, args.destName)
	elseif spellId == 184964 then
		shacklesTargets[#shacklesTargets+1] = args.destName
		self.vb.unleashedCountRemaining = self.vb.unleashedCountRemaining + 1
		self:Unschedule(breakShackles)
		self:Schedule(0.3, breakShackles, self)
	elseif spellId == 186123 then--Wrought Chaos
		--self.vb.wroughtWarned = self.vb.wroughtWarned + 1
		if args:IsPlayer() then
			specWarnWroughtChaos:Show()
			yellWroughtChaos:Yell()
			countdownWroughtChaos:Start()
			voiceWroughtChaos:Play("186123") --new voice
		end
		if not playerBanished or not self.Options.FilterOtherPhase then
			warnWroughtChaos:CombinedShow(1, args.destName)
			if self.Options.HudMapOnWrought then
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 5, 1, 1, 0, 0.5, nil, true, 2):Pulse(0.5, 0.5)--Yellow
			end
		end
	elseif spellId == 185014 then--Focused Chaos
		print("If you see this message, it means blizzard made Focused Chaos visible in combat log, please report this to @mysticalos on twitter")
		--self.vb.wroughtWarned = self.vb.wroughtWarned + 1
--[[		warnWroughtChaos:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFocusedChaos:Show()
			yellFocusedChaos:Yell()
			countdownWroughtChaos:Start()
			voiceFocusedChaos:Play("185014")
		end
		if self.Options.HudMapOnWrought then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 5, 1, 1, 0, 0.5, nil, true, 2):Pulse(0.5, 0.5)--Red
		end--]]
	elseif spellId == 186574 then--Dreadstalker fixate
		warnDreadFixate:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDreadFixate:Show()
		end
	elseif spellId == 187180 then
		self.vb.demonicFeedbacks = self.vb.demonicFeedbacks + 1
		if not playerBanished or not self.Options.FilterOtherPhase then
			if self.Options.SpecWarn187180target then
				specWarnDemonicFeedbackOther:CombinedShow(0.3, args.destName)
			else
				warnDemonicFeedback:CombinedShow(0.3, args.destName)
			end
		end
		if args:IsPlayer() then
			specWarnDemonicFeedback:Show()
			yellDemonicFeedback:Yell()
		end
		if self.Options.SetIconOnDemonicFeedback and not self:IsLFR() then
			self:SetSortedIcon(0.7, args.destName, 1)
		end
		updateRangeFrame(self)
	elseif spellId == 186961 then
		self.vb.netherPortals = self.vb.netherPortals + 1
		timerNetherBanishCD:Start()
		if args:IsPlayer() then
			specWarnNetherBanish:Show()
			yellNetherBanish:Schedule(6, 1)
			yellNetherBanish:Schedule(5, 2)
			yellNetherBanish:Schedule(4, 3)
			yellNetherBanish:Schedule(3, 4)
			yellNetherBanish:Schedule(2, 5)
		else
			--Barring any logical error, if special warning will show, don't show other warning
			if self.Options.SpecWarn186961taunt and (not DBM.Options.FilterTankSpec or self:IsTank() and DBM.Options.FilterTankSpec) then
				specWarnNetherBanishOther:Show()
			else
				warnNetherBanish:Show(args.destName)
			end
		end
		updateRangeFrame(self)
		if self.vb.phase < 3 then--Secondary phase 3 trigger, if yell not localized
			self.vb.phase = 3
			timerAllureofFlamesCD:Cancel()--Done for rest of fight
			timerDeathbrandCD:Cancel()--Done for rest of fight
			timerShackledTormentCD:Cancel()--Resets to 51.4-6 here
			timerDemonicFeedbackCD:Start(11)
			timerShackledTormentCD:Start(45.4)
		end
	elseif spellId == 189895 and (playerBanished or not self.Options.FilterOtherPhase) then
		warnVoidStarFixate:CombinedShow(0.3, args.destName)--5 on mythic
		if args:IsPlayer() then
			specWarnVoidStarFixate:Show()
			yellVoidStarFixate:Yell()
		end
	elseif spellId == 186662 then--Felborne Overfiend Spawn
		timerFelborneOverfiendCD:Start()
		if self.vb.phase < 2.5 then--First spawn is about 3 seconds after phase 2.5 trigger yell
			self.vb.phase = 2.5
			timerShackledTormentCD:Cancel()--Resets to 40-3 here
			timerShackledTormentCD:Start(37)
		end
	elseif spellId == 186952 and args:IsPlayer() then
		playerBanished = true
	elseif spellId == 190400 then
		self.vb.touchOfLegionRemaining = self.vb.touchOfLegionRemaining + 1
		local uId = DBM:GetRaidUnitId(args.destName)
		local _, _, _, _, _, duration, expires, _, _ = UnitDebuff(uId, args.spellName)--Find out what our specific seed timer is
		warnTouchofLegion:CombinedShow(0.5, args.destName)
		if self:AntiSpam(3, 1) then
			timerTouchOfLegionCD:Start()
		end
		if expires then
			local remaining = expires-GetTime()
			timerTouchOfLegion:Start(remaining, args.destName)--Maybe info frame showing player names and expire order better than showing a bunch of timers?
			if args:IsPlayer() then
				specWarnTouchofLegion:Show()
				yellTouchofLegion:Schedule(remaining-1, 1)
				yellTouchofLegion:Schedule(remaining-2, 2)
				yellTouchofLegion:Schedule(remaining-3, 3)
				yellTouchofLegion:Schedule(remaining-4, 4)
				yellTouchofLegion:Schedule(remaining-5, 5)
			end
		end
		updateRangeFrame(self)
	elseif spellId == 190703 then
		timerSourceofChaosCD:Start()
		if args:IsPlayer() then
			specWarnSourceofChaos:Show()
			yellSourceofChaos:Yell()
		else
			specWarnSourceofChaosOthers:Show()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 186123 or spellId == 185014 then--Wrought Chaos/Focused Chaos
		if self.Options.HudMapOnWrought then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	elseif spellId == 187180 then
		self.vb.demonicFeedbacks = self.vb.demonicFeedbacks - 1
		if self.Options.SetIconOnDemonicFeedback and not self:IsLFR() then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 186961 then
		self.vb.netherPortals = self.vb.netherPortals - 1
		updateRangeFrame(self)
	elseif spellId == 186952 and args:IsPlayer() then
		playerBanished = false
	elseif spellId == 184964 then
		self.vb.unleashedCountRemaining = self.vb.unleashedCountRemaining - 1
		if (not playerBanished or not self.Options.FilterOtherPhase) and not self:IsLFR() then
			warnUnleashedTorment:Show(self.vb.unleashedCountRemaining)
		end
	elseif spellId == 190400 then
		self.vb.touchOfLegionRemaining = self.vb.touchOfLegionRemaining - 1
		timerTouchOfLegion:Cancel(args.destName)
		if args:IsPlayer() then
			yellTouchofLegion:Cancel()
		end
		updateRangeFrame(self)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 92740 then--Hellfire Deathcaller
		timerDemonicHavocCD:Cancel(args.destGUID)
		timerShadowBlastCD:Cancel(args.destGUID)
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitGUID = UnitGUID("boss"..i)
		if unitGUID and not AddsSeen[unitGUID] then
			AddsSeen[unitGUID] = true
			local cid = self:GetCIDFromGUID(unitGUID)
			if cid == 92740 then--Hellfire Deathcaller
				specWarnDeathCaller:Show()
				timerShadowBlastCD:Start(4.5, unitGUID)
				voiceDeathCaller:Play("ej11582")
				if self:IsMythic() then
					timerDemonicHavocCD:Start(1, unitGUID)
				end
			end
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	--"<183.63 18:00:13> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#I grow tired of this pointless game. You face the immortal Legion, scourge of a thousand worlds
	--"<184.30 18:00:14> [CLEU] SPELL_CAST_START#Creature-0-2012-1448-150-91331-0000566A43#Archimonde##nil#184265#Wrought Chaos#nil#nil", -- [8782]
	if msg == L.phase2 and self.vb.phase < 2 then
		self:SendSync("phase2")
	--"<263.67 18:01:33> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Look upon the endless forces of the Burning Legion and know the folly of your resistance.#Archimonde
	--"<266.42 18:01:36> [CLEU] SPELL_AURA_APPLIED#Creature-0-2012-1448-150-93615-0000566CBD#Felborne Overfiend#Creature-0-2012-1448-150-93615-0000566CBD#Felborne Overfiend#186662#Heart of Argus#BUFF#nil", -- [12225]	
	elseif msg == L.phase2point5 and self.vb.phase < 2.5 then
		self:SendSync("phase25")
	elseif msg == L.phase3 and self.vb.phase < 3 then
		self:SendSync("phase3")
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:185014") then
		specWarnFocusedChaos:Show()
		yellFocusedChaos:Yell()
		countdownWroughtChaos:Start()
	end
end

--per usual, use transcriptor message to get messages from both bigwigs and DBM, all without adding comms to this mod at all
function mod:CHAT_MSG_ADDON(prefix, msg, channel, targetName)
	if prefix ~= "Transcriptor" then return end
	if msg:find("spell:185014") then--
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(3, targetName) then--Antispam sync by target name, since this doesn't use dbms built in onsync handler.
			if not playerBanished or not self.Options.FilterOtherPhase then
				warnWroughtChaos:CombinedShow(1, targetName)
				if self.Options.HudMapOnWrought then
					DBMHudMap:RegisterRangeMarkerOnPartyMember(185014, "highlight", targetName, 5, 5, 1, 0, 0, 0.5, nil, true, 2):Pulse(0.5, 0.5)--Red
				end
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 189953 then--Rain of Chaos (25% version). Phase 3.5
		specWarnRainofChaos:Show()
		if self.vb.phase < 3.5 then
			self.vb.phase = 3.5
		end
	end
end

function mod:OnSync(msg)
	if msg == "phase2" and self.vb.phase < 2 then
		self.vb.phase = 2
		--Cancel stuff only used in phase 1
		timerFelBurstCD:Cancel()
		timerDesecrateCD:Cancel()
		timerDoomfireCD:Cancel()
		timerAllureofFlamesCD:Cancel()--Reset to 35.5
		timerAllureofFlamesCD:Start(35.5)
		timerShackledTormentCD:Start(12)
	elseif msg == "phase25" and self.vb.phase < 2.5 then
		self.vb.phase = 2.5
		timerShackledTormentCD:Cancel()--Resets to 40 here
		timerShackledTormentCD:Start(40)
	elseif msg == "phase3" and self.vb.phase < 3 then
		self.vb.phase = 3
		timerNetherBanishCD:Start(6)
		timerDemonicFeedbackCD:Start(17)
		timerAllureofFlamesCD:Cancel()--Done for rest of fight
		timerDeathbrandCD:Cancel()--Done for rest of fight
		timerShackledTormentCD:Cancel()--Resets to 51.4 here
		timerShackledTormentCD:Start(51.4)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
--]]
