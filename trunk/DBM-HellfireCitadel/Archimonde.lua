local mod	= DBM:NewMod(1438, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91331)--Doomfire Spirit (92208), Hellfire Deathcaller (92740), Felborne Overfiend (93615), Dreadstalker (93616), Infernal doombringer (94412)
mod:SetEncounterID(1799)
mod:SetMinSyncRevision(13964)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(14087)
--mod.respawnTime = 20

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 183254 189897 183817 183828 185590 184265 183864 190506 184931 187180 182225 190050 187050 190394 190686 190821",
	"SPELL_CAST_SUCCESS 183865 184931 187180",
	"SPELL_AURA_APPLIED 182879 183634 183865 184964 186574 186961 189895 186123 186662 186952 190703 187255 185014 187050",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 186123 185014 186961 186952 184964 187050 183634",
	"SPELL_SUMMON 187108",
	"SPELL_PERIODIC_DAMAGE 187255",
	"SPELL_ABSORBED 187255",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--(ability.id = 183254 or ability.id = 189897 or ability.id = 183817 or ability.id = 183828 or ability.id = 185590 or ability.id = 184265 or ability.id = 183864 or ability.id = 190506 or ability.id = 184931 or ability.id = 187180) and type = "begincast" or (ability.id = 183865) and type = "cast" or (ability.id = 186662 or ability.id = 186961) and (type = "applydebuff" or type = "applybuff")
--TODO, failsafes are at work for transitions i still don't have enough data for. for example, something seems to always cause the 2nd or 3rd fel burst to delay by a HUGE amount (20-30 seconds sometimes) but don't know what it is. Probalby phase transitions but it's not as simple as resetting timer. probably something more zon ozz
--TODO, figure out what to do with touch of the legion (190400)
--Phase 1: The Defiler
local warnDoomfireFixate			= mod:NewTargetAnnounce(182879, 3)
local warnAllureofFlamesSoon		= mod:NewSoonAnnounce(183254, 2)
local warnFelBurstSoon				= mod:NewSoonAnnounce(183817, 3)
local warnFelBurst					= mod:NewTargetAnnounce(183817, 3)
local warnDemonicHavoc				= mod:NewTargetAnnounce(183865, 3)--Mythic
--Phase 2: Hand of the Legion
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnShackledTorment			= mod:NewTargetAnnounce(184964, 3)
local warnUnleashedTorment			= mod:NewAddsLeftAnnounce(185008, 2)--NewAddsLeftAnnounce perfect for this!
local warnWroughtChaos				= mod:NewTargetCountAnnounce(184265, 4)--Combined both targets into one warning under primary spell name
local warnDreadFixate				= mod:NewTargetAnnounce(186574, 2, nil, false)--In case it matters on mythic, it was spammy on heroic and unimportant
--Phase 3
local warnPhase3					= mod:NewPhaseAnnounce(3, 2)
----The Nether
local warnVoidStarFixate			= mod:NewTargetAnnounce(189895, 2)
--Mythic
local warnMarkOfLegion				= mod:NewTargetAnnounce(187050, 4)

--Phase 1: The Defiler
local specWarnDoomfire				= mod:NewSpecialWarningSwitch(189897, "Dps", nil, nil, 1, 5)
local specWarnDoomfireFixate		= mod:NewSpecialWarningYou(182879, nil, nil, nil, 4)
local yellDoomfireFixate			= mod:NewYell(182826)--Use short name for yell
local specWarnAllureofFlames		= mod:NewSpecialWarningSpell(183254, nil, nil, nil, 2, 2)
local specWarnDeathCaller			= mod:NewSpecialWarningSwitchCount("ej11582", "Dps", nil, nil, 1, 2)--Tanks don't need switch, they have death brand special warning 2 seconds earlier
local specWarnFelBurst				= mod:NewSpecialWarningYou(183817)
local yellFelBurst					= mod:NewYell(183817)--Change yell to countdown mayeb when better understood
local specWarnFelBurstNear			= mod:NewSpecialWarningMoveTo(183817, nil, nil, nil, 1, 2)--Anyone near by should run in to help soak, should be mostly ranged but if it's close to melee, melee soaking too doesn't hurt
local specWarnDesecrate				= mod:NewSpecialWarningDodge(185590, "Melee", nil, nil, 1, 2)
local specWarnDeathBrand			= mod:NewSpecialWarningCount(183828, "Tank", nil, nil, 1, 2)
--Phase 2: Hand of the Legion
local specWarnBreakShackle			= mod:NewSpecialWarning("specWarnBreakShackle", nil, nil, nil, 1, 5)
local yellShackledTorment			= mod:NewPosYell(184964)
local specWarnWroughtChaos			= mod:NewSpecialWarningMoveAway(186123, nil, nil, nil, 3, 5)
local yellWroughtChaos				= mod:NewYell(186123)
local specWarnFocusedChaos			= mod:NewSpecialWarningMoveAway(185014, nil, nil, nil, 3, 5)
local yellFocusedChaos				= mod:NewFadesYell(185014)
local specWarnDreadFixate			= mod:NewSpecialWarningYou(186574, false)--In case it matters on mythic, it was spammy on heroic and unimportant
--Phase 3: The Twisting Nether
local specWarnDemonicFeedbackSoon	= mod:NewSpecialWarningSoon(187180, nil, nil, nil, 1)
local specWarnDemonicFeedback		= mod:NewSpecialWarningCount(187180, nil, nil, nil, 3)
local specWarnNetherBanish			= mod:NewSpecialWarningYou(186961)
local specWarnNetherBanishOther		= mod:NewSpecialWarningTargetCount(186961)
local yellNetherBanish				= mod:NewFadesYell(186961)
----The Nether
local specWarnTouchofShadows		= mod:NewSpecialWarningInterruptCount(190050)
local specWarnVoidStarFixate		= mod:NewSpecialWarningYou(189895)--Maybe move away? depends how often it changes fixate targets
local yellVoidStarFixate			= mod:NewYell(189895, nil, false)
local specWarnNetherStorm			= mod:NewSpecialWarningMove(187255)
--Phase 3.5
local specWarnRainofChaos			= mod:NewSpecialWarningCount(189953, nil, nil, nil, 2)
--Mythic
local specWarnDarkConduit			= mod:NewSpecialWarningCount(190394)--Not sure how to classify yet. or who to exclude
local specWarnSeethingCorruption	= mod:NewSpecialWarningCount(190506, nil, nil, nil, 2)
local specWarnMarkOfLegion			= mod:NewSpecialWarningYou(187050)--Somehow i suspect this replaces fel burst. It's basically same mechanic, but on multiple people and slightly larger
local yellMarkOfLegion				= mod:NewFadesYell(187050)
local yellMarkOfLegionPoS			= mod:NewPosYell(187050)
local specWarnSourceofChaosYou		= mod:NewSpecialWarningYou(190703)
local yellSourceofChaos				= mod:NewYell(190703)
local specWarnSourceofChaos			= mod:NewSpecialWarningSwitchCount(190703, "Dps")--Maybe exclude ranged or healers. Not sure if just dps is enough to soak it, at very least dps have to kill it
local specWarnInfernals				= mod:NewSpecialWarningSwitchCount(187111, "-Healer")--Tanks should probably help pick these up and spread them
local specWarnTwistedDarkness		= mod:NewSpecialWarningSwitchCount(190821, "RangedDps")

--Phase 1: The Defiler
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerDoomfireCD				= mod:NewCDTimer(42.1, 182826, nil, nil, nil, 1)--182826 cast, 182879 fixate. Doomfire only fixates ranged, but ALL dps switch to it.
local timerAllureofFlamesCD			= mod:NewCDTimer(47.5, 183254, nil, nil, nil, 2)
local timerFelBurstCD				= mod:NewCDTimer(52, 183817, nil, "Ranged", nil, 3)--Only targets ranged (52-70 variation)
local timerDeathbrandCD				= mod:NewCDCountTimer(42.5, 183828, nil, nil, nil, 1)--Everyone, for tanks/healers to know when debuff/big hit, for dps to know add coming
local timerDesecrateCD				= mod:NewCDTimer(27, 185590, nil, "Melee", nil, 2)--Only targets melee
----Hellfire Deathcaller
local timerShadowBlastCD			= mod:NewCDTimer(9.7, 183864, nil, "Tank", nil, 5)
local timerDemonicHavocCD			= mod:NewAITimer(107, 183865, nil, nil, nil, 3)--Mythic, timer unknown, AI timer used until known. I'm not sure this ability still exists
--Phase 2: Hand of the Legion
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerShackledTormentCD		= mod:NewCDTimer(31.5, 184931, nil, nil, nil, 3)
local timerWroughtChaosCD			= mod:NewCDTimer(51.7, 184265, nil, nil, nil, 3)
--Phase 2.5
local timerFelborneOverfiendCD		= mod:NewNextTimer(44.3, "ej11603", nil, nil, nil, 1, 186662)
--Phase 3: The Twisting Nether
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerDemonicFeedbackCD		= mod:NewCDTimer(35, 187180, nil, nil, nil, 2)
local timerNetherBanishCD			= mod:NewCDCountTimer(61.9, 186961, nil, nil, nil, 5)
--Phase 3.5:
local timerRainofChaosCD			= mod:NewCDCountTimer(62, 182225, nil, nil, nil, 2)
----The Nether
--Mythic
local timerDarkConduitCD			= mod:NewCDCountTimer(107, 190394, nil, nil, nil, 3)
local timerMarkOfLegionCD			= mod:NewCDCountTimer(107, 187050, nil, nil, nil, 3)
local timerInfernalsCD				= mod:NewCDCountTimer(107, 187111, nil, nil, nil, 1, 1122)
local timerSourceofChaosCD			= mod:NewCDCountTimer(107, 190703, nil, nil, 2, 1)
local timerTwistedDarknessCD		= mod:NewCDCountTimer(107, 190821, nil, nil, nil, 1)
local timerSeethingCorruptionCD		= mod:NewCDCountTimer(107, 190506, nil, nil, nil, 2)

--local berserkTimer				= mod:NewBerserkTimer(360)

--countdowns kind of blow with this fights timer variations.
--Everything but overfiend is a CD
--I don't want to use a countdown on something thats 47-56 like allure or 52-70 like felburst
local countdownWroughtChaos			= mod:NewCountdownFades("AltTwo5", 184265)
local countdownNetherBanish			= mod:NewCountdown(61.9, 186961)
local countdownDemonicFeedback		= mod:NewCountdown("Alt35", 186961)
local countdownDeathBrand			= mod:NewCountdown("AltTwo42", 183828)

local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceDeathBrand				= mod:NewVoice(183828, "Tank")--defensive/tauntboss
local voiceFelBurst					= mod:NewVoice(183817)--Gathershare
local voiceShackledTorment			= mod:NewVoice(184964)--new voice: break torment first, etc
local voiceDoomfire					= mod:NewVoice(189897, "Dps")--189897.ogg
local voiceDeathCaller				= mod:NewVoice("ej11582", "Dps")--ej11582.ogg
local voiceWroughtChaos				= mod:NewVoice(186123) --new voice
local voiceFocusedChaos				= mod:NewVoice(185014) --new voice
local voiceAllureofFlamesCD			= mod:NewVoice(183254) --just run

mod:AddRangeFrameOption("6/8/10")
mod:AddSetIconOption("SetIconOnShackledTorment2", 184964, false)
mod:AddSetIconOption("SetIconOnMarkOfLegion", 187050, true)
mod:AddSetIconOption("SetIconOnInfernals", "ej11618", true, true)
mod:AddHudMapOption("HudMapOnFelBurst", 183634)
mod:AddHudMapOption("HudMapOnShackledTorment", 184964, false)--off by default, may be much for most. Also a mythic only option
mod:AddHudMapOption("HudMapOnWrought", 184265)--Yellow on caster (wrought chaos), red on target (focused chaos)
mod:AddBoolOption("FilterOtherPhase", true)
mod:AddInfoFrameOption(184964)

mod.vb.phase = 1
mod.vb.demonicCount = 0
mod.vb.demonicFeedback = false
mod.vb.netherPortals = 0
mod.vb.unleashedCountRemaining = 0
mod.vb.markOfLegionCast = 0
mod.vb.markOfLegionRemaining = 0
mod.vb.netherBanish = 0
mod.vb.rainOfChaos = 0
mod.vb.TouchOfShadows = 0
mod.vb.InfernalsActive = 0
mod.vb.wroughtWarned = 0
--Mythic sync variables
mod.vb.deathBrandCount = 0
mod.vb.darkConduitCast = 0
mod.vb.InfernalsCast = 0
mod.vb.sourceOfChaosCast = 0
mod.vb.twistedDarknessCast = 0
mod.vb.seethingCorruptionCount = 0
--Mythic sequence timers for phase 3 (Made by video, subject to inaccuracies until logs available)
local legionTimers = {22, 63, 60, 60, 50, 45}
local darkConduitTimers = {10, 123, 95, 55, 50}
local infernalTimers = {37, 63, 63, 55, 68, 40}--Seems off. that 68 is oddball.
local sourceofChaosTimers = {50, 58, 76, 78}--Seens off as well, but who knows, maybe.
local twistedDarknessTimers = {79, 76, 42, 40, 72}--Also seems off, could be missing one
local seethingCorruptionTimers = {120, 52, 70, 30, 40}--Really just need logs to verify this nonsense
-- for Phanx' Class Colors
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
--Range frame/filter shit
local shacklesTargets = {}
local legionTargets = {}
local playerName = UnitName("player")
local playerBanished = false
local UnitDebuff, UnitDetailedThreatSituation, UnitClass, UnitIsUnit = UnitDebuff, UnitDetailedThreatSituation, UnitClass, UnitIsUnit
local NetherBanish = GetSpellInfo(186961)
local shackledDebuff = GetSpellInfo(184964)
local markOfLegionDebuff = GetSpellInfo(187050)
local netherFilter, markOfLegionFilter
do
	netherFilter = function(uId)
		if UnitDebuff(uId, NetherBanish) then
			return true
		end
	end
	markOfLegionFilter = function(uId)
		if UnitDebuff(uId, markOfLegionDebuff) then
			return true
		end
	end
end

local lines = {}
local function sortInfoFrame(a, b) 
	local a = lines[a]
	local b = lines[b]
	if not tonumber(a) then a = -1 end
	if not tonumber(b) then b = -1 end
	if a < b then return true else return false end
end

local function updateInfoFrame()
	table.wipe(lines)
	local total = 0
	for i = 1, #shacklesTargets do
		local name = shacklesTargets[i]
		local uId = DBM:GetRaidUnitId(name)
		if UnitDebuff(uId, shackledDebuff) then
			total = total + 1
			lines[name] = i
		end
	end
	if total == 0 then--None found, hide infoframe because all broke
		DBM.InfoFrame:Hide()
	end
	return lines
end

local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self.vb.demonicFeedback then
		DBM.RangeCheck:Show(6)
	elseif self.vb.markOfLegionRemaining > 0 then
		if UnitDebuff("player", markOfLegionDebuff) then
			DBM.RangeCheck:Show(10)
		else
			DBM.RangeCheck:Show(10, markOfLegionFilter)
		end
	elseif self.vb.netherPortal then
		--Blue post says 8, but pretty sure it's 10. The visual was bigger than 8
		if UnitDebuff("player", NetherBanish) then
			DBM.RangeCheck:Show(10)
		else
			DBM.RangeCheck:Show(10, netherFilter)
		end
	elseif self.vb.phase < 2 and self:IsRanged() then--Fel burst in phase 1
		DBM.RangeCheck:Show(8)
	else
		DBM.RangeCheck:Hide()
	end
end

local function setDemonicFeedback(self)
	self.vb.demonicFeedback = true
	updateRangeFrame(self)
	if not playerBanished or not self.Options.FilterOtherPhase then
		specWarnDemonicFeedbackSoon:Show()
	end
end

local function showMarkOfLegion(self)
	table.sort(legionTargets)
	warnMarkOfLegion:Show(table.concat(legionTargets, "<, >"))
	for i = 1, #legionTargets do
		local name = legionTargets[i]
		if name == playerName then
			yellMarkOfLegionPoS:Yell(i)
		end
		if self.Options.SetIconOnMarkOfLegion then
			self:SetIcon(name, i)
		end
	end
end

local function breakShackles(self)
--	I thought about using auto scheduling and doing "break shackle now" with few seconds in between each
--	then i realized that'd do more harm that good, if raid is low and dbm says break shackle, you wipe.
--	So now it just gives order, but you break at pace needed by your healers
	table.sort(shacklesTargets)
	if not playerBanished or not self.Options.FilterOtherPhase then
		warnShackledTorment:Show(table.concat(shacklesTargets, "<, >"))
	end
	if self:IsLFR() then return end
	for i = 1, #shacklesTargets do
		local name = shacklesTargets[i]
		if name == playerName then
			yellShackledTorment:Yell(i)
			if i == 1 then
				specWarnBreakShackle:Show(L.First)
				voiceShackledTorment:Play("184964a")
			elseif i == 2 then
				specWarnBreakShackle:Show(L.Second)
				voiceShackledTorment:Play("184964b")
			elseif i == 3 then
				specWarnBreakShackle:Show(L.Third)
				voiceShackledTorment:Play("184964c")
			end
		end
		if self.Options.SetIconOnShackledTorment2 then
			self:SetIcon(name, i)
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(shackledDebuff)
			DBM.InfoFrame:Show(5, "function", updateInfoFrame, sortInfoFrame)
		end
	end
end

--/run DBM:GetModByName("1438"):OnCombatStart(0)
function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.demonicCount = 0
	self.vb.demonicFeedback = false
	self.vb.netherPortal = false
	self.vb.unleashedCountRemaining = 0
	self.vb.markOfLegionRemaining = 0
	self.vb.netherBanish = 0
	self.vb.rainOfChaos = 0
	self.vb.TouchOfShadows = 0
	self.vb.InfernalsActive = 0
	self.vb.deathBrandCount = 0
	playerBanished = false
	timerDoomfireCD:Start(6-delay)
	timerDeathbrandCD:Start(15.5-delay, 1)
	countdownDeathBrand:Start(15.5-delay)
	timerAllureofFlamesCD:Start(30-delay)
	warnAllureofFlamesSoon:Schedule(25-delay)
	warnFelBurstSoon:Schedule(35-delay)
	timerFelBurstCD:Start(40-delay)
	if self:IsMythic() then
		self.vb.markOfLegionCast = 0
		self.vb.darkConduitCast = 0
		self.vb.InfernalsCast = 0
		self.vb.sourceOfChaosCast = 0
		self.vb.twistedDarknessCast = 0
		self.vb.seethingCorruptionCount = 0
	end
	updateRangeFrame(self)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnWrought or self.Options.HudMapOnFelBurst or self.Options.HudMapOnShackledTorment then
		DBMHudMap:Disable()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 183254 then
		if not playerBanished or not self.Options.FilterOtherPhase then
			specWarnAllureofFlames:Show()
			voiceAllureofFlamesCD:Play("justrun")
		end
		warnAllureofFlamesSoon:Schedule(42)
		timerAllureofFlamesCD:Start()
	elseif spellId == 189897 then
		specWarnDoomfire:Show()
		timerDoomfireCD:Start()
		voiceDoomfire:Play("189897")
	elseif spellId == 183817 then
		warnFelBurstSoon:Schedule(47)
		timerFelBurstCD:Start()
	elseif spellId == 183828 then
		self.vb.deathBrandCount = self.vb.deathBrandCount + 1
		specWarnDeathBrand:Show(self.vb.deathBrandCount)
		timerDeathbrandCD:Start(nil, self.vb.deathBrandCount+1)
		countdownDeathBrand:Start()
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		if tanking or (status == 3) then
			voiceDeathBrand:Play("defensive")
		else
			voiceDeathBrand:Play("tauntboss")
		end
	elseif spellId == 185590 then
		specWarnDesecrate:Show()
		timerDesecrateCD:Start()
		if self.vb.phase < 1.5 then
			DBM:Debug("Phase 1 begin CLEU")
			self.vb.phase = 1.5--85%
		end
	elseif spellId == 184265 then
		self.vb.wroughtWarned = 0--Reset Counter
		timerWroughtChaosCD:Start()
	elseif spellId == 183864 then
		timerShadowBlastCD:Start(args.sourceGUID)
	elseif spellId == 190506 then
		self.vb.seethingCorruptionCount = self.vb.seethingCorruptionCount + 1
		specWarnSeethingCorruption:Show(self.vb.seethingCorruptionCount)
		local cooldown = seethingCorruptionTimers[self.vb.seethingCorruptionCount+1]
		if cooldown then
			timerSeethingCorruptionCD:Start(cooldown, self.vb.seethingCorruptionCount+1)
		end
	elseif spellId == 184931 then
		table.wipe(shacklesTargets)
	elseif spellId == 187180 then
		self.vb.demonicCount = self.vb.demonicCount + 1
		if not playerBanished or not self.Options.FilterOtherPhase then
			specWarnDemonicFeedback:Show(self.vb.demonicCount)
		end
		timerDemonicFeedbackCD:Start(nil, self.vb.demonicCount+1)
		countdownDemonicFeedback:Start()
	elseif spellId == 182225 then
		self.vb.rainOfChaos = self.vb.rainOfChaos + 1
		if not playerBanished or not self.Options.FilterOtherPhase then
			specWarnRainofChaos:Show(self.vb.rainOfChaos)
		end
		timerRainofChaosCD:Start(nil, self.vb.rainOfChaos+1)
		if self.vb.phase < 3.5 then
			self.vb.phase = 3.5
		end
		if self.Options.SetIconOnInfernals then
			if self.vb.InfernalsActive > 0 then--Last set isn't dead yet, use alternate icons
				self:ScanForMobs(94412, 0, 5, 3, 0.4, 25, "SetIconOnInfernals")
			else
				self:ScanForMobs(94412, 0, 8, 3, 0.4, 25, "SetIconOnInfernals")
			end
		end
	elseif spellId == 190050 then
		--To ensure propper syncing and everyones mod has same count, the count isn't in the filter
		if self.vb.TouchOfShadows == 2 then self.vb.TouchOfShadows = 0 end
		self.vb.TouchOfShadows = self.vb.TouchOfShadows + 1
		--Actual interrupt is filtered of course.
		if self:CheckInterruptFilter(args.sourceGUID) and playerBanished then
			specWarnTouchofShadows:Show(args.sourceName, self.vb.TouchOfShadows)
		end
	elseif spellId == 187050 then
		self.vb.markOfLegionCast = self.vb.markOfLegionCast + 1
		table.wipe(legionTargets)
		local cooldown = legionTimers[self.vb.markOfLegionCast+1]
		if cooldown then
			timerMarkOfLegionCD:Start(cooldown, self.vb.markOfLegionCast+1)
		end
	elseif spellId == 190394 then
		self.vb.darkConduitCast = self.vb.darkConduitCast + 1
		specWarnDarkConduit:Show(self.vb.darkConduitCast)
		local cooldown = darkConduitTimers[self.vb.darkConduitCast+1]
		if cooldown then
			timerDarkConduitCD:Start(cooldown, self.vb.darkConduitCast+1)
		end
	elseif spellId == 190686 then--Summon source of chaos
		self.vb.sourceOfChaosCast = self.vb.sourceOfChaosCast + 1
		specWarnSourceofChaos:Show(self.vb.sourceOfChaosCast)
		local cooldown = sourceofChaosTimers[self.vb.sourceOfChaosCast+1]
		if cooldown then
			timerSourceofChaosCD:Start(cooldown, self.vb.sourceOfChaosCast+1)
		end
	elseif spellId == 190821 then--Stars
		self.vb.twistedDarknessCast = self.vb.twistedDarknessCast + 1
		specWarnTwistedDarkness:Show(self.vb.twistedDarknessCast)
		local cooldown = twistedDarknessTimers[self.vb.twistedDarknessCast+1]
		if cooldown then
			timerTwistedDarknessCD:Start(cooldown, self.vb.twistedDarknessCast+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 183865 then
		timerDemonicHavocCD:Start(nil, args.sourceGUID)
	elseif spellId == 184931 then
		timerShackledTormentCD:Start()
	elseif spellId == 187180 then
		self.vb.demonicFeedback = false
		self:Schedule(28, setDemonicFeedback, self)
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
			if self:CheckNearby(30, args.destName) and not UnitDebuff("player", args.spellName) and not self:IsTank() then--Range subject to adjustment
				specWarnFelBurstNear:CombinedShow(0.3, args.destName)--Combined show to prevent spam in a spread, if a spread happens targets are all together and requires even MORE people to soak.
				voiceFelBurst:Cancel()--Avoid spam
				voiceFelBurst:Schedule(0.3, "gathershare")
			end
		end
		if self.Options.HudMapOnFelBurst then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 8, 5, 0, 1, 0, 0.5):Appear()
		end
	elseif spellId == 183865 then
		warnDemonicHavoc:CombinedShow(0.3, args.destName)
	elseif spellId == 184964 then
		shacklesTargets[#shacklesTargets+1] = args.destName
		self.vb.unleashedCountRemaining = self.vb.unleashedCountRemaining + 1
		self:Unschedule(breakShackles)
		if #shacklesTargets == 3 then
			breakShackles(self)
		else
			self:Schedule(0.5, breakShackles, self)
		end
		if self.Options.HudMapOnShackledTorment and self:IsMythic() then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "timer", args.destName, 25, nil, 0, 1, 0, 0.3):Appear():RegisterForAlerts():Rotate(360, 9.5)
		end
	elseif spellId == 186123 then--Wrought Chaos
		if args:IsPlayer() then
			specWarnWroughtChaos:Show()
			yellWroughtChaos:Yell()
			countdownWroughtChaos:Start()
			voiceWroughtChaos:Play("186123") --new voice
		end
		if not playerBanished or not self.Options.FilterOtherPhase then
			if not self:IsMythic() then
				self.vb.wroughtWarned = self.vb.wroughtWarned + 1
				warnWroughtChaos:CombinedShow(0.3, self.vb.wroughtWarned, args.destName)
			else
				if self:AntiSpam(3, 3) then
					self.vb.wroughtWarned = self.vb.wroughtWarned + 1
					warnWroughtChaos:Show(self.vb.wroughtWarned, FRIENDS_FRIENDS_CHOICE_EVERYONE)--"Everyone"
				end
			end
		end
	elseif spellId == 185014 then--Focused Chaos
		if args:IsPlayer() then
			specWarnFocusedChaos:Show()
			yellFocusedChaos:Yell()
			countdownWroughtChaos:Start()
			voiceFocusedChaos:Play("185014")
			yellFocusedChaos:Yell(5)
			yellFocusedChaos:Schedule(4, 1)
			yellFocusedChaos:Schedule(3, 2)
			yellFocusedChaos:Schedule(2, 3)
			yellFocusedChaos:Schedule(1, 4)
		end
		if not playerBanished or not self.Options.FilterOtherPhase then
			if not self:IsMythic() then
				warnWroughtChaos:CombinedShow(0.3, self.vb.wroughtWarned, args.destName)
			end
			if self.Options.HudMapOnWrought then
				local sourceUId, destUId = DBM:GetRaidUnitId(args.sourceName), DBM:GetRaidUnitId(args.destName)
				if not sourceUId or not destUId then return end--They left raid? prevent nil error. this will probably only happen in LFR
				local _, sourceClass = UnitClass(sourceUId)
				local _, destClass = UnitClass(destUId)
				local sourceColor, destColor = RAID_CLASS_COLORS[sourceClass], RAID_CLASS_COLORS[destClass]
				if UnitIsUnit("player", sourceUId) or UnitIsUnit("player", destUId) then--Player is in connection, green line
					--create points for your own line
					if UnitIsUnit("player", sourceUId) then
						DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.sourceName, 1.5, 5, sourceColor.r, sourceColor.g, sourceColor.b, 1, nil, false):Pulse(0.5, 0.5)--Players own dot bigger
						DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 1, 5, destColor.r, destColor.g, destColor.b, 0.5, nil, false):Pulse(0.5, 0.5)
					else
						DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.sourceName, 1, 5, sourceColor.r, sourceColor.g, sourceColor.b, 0.5, nil, false):Pulse(0.5, 0.5)
						DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 1.5, 5, destColor.r, destColor.g, destColor.b, 1, nil, false):Pulse(0.5, 0.5)--Players own dot bigger
					end
					--create line
					DBMHudMap:AddEdge(0, 1, 0, 0.5, 5, args.sourceName, args.destName, nil, nil, nil, nil)
				else--red lines for non player lines
					--Create Points
					DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.sourceName, 1, 5, sourceColor.r, sourceColor.g, sourceColor.b, 0.5, nil, false):Pulse(0.5, 0.5)--Players own dot bigger
					DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 1, 5, destColor.r, destColor.g, destColor.b, 0.5, nil, false):Pulse(0.5, 0.5)
					--Create Line
					DBMHudMap:AddEdge(1, 0, 0, 0.5, 5, args.sourceName, args.destName, nil, nil, nil, nil)
				end
			end
		end
	elseif spellId == 186574 then--Dreadstalker fixate
		warnDreadFixate:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDreadFixate:Show()
		end
	elseif spellId == 186961 then
		self.vb.netherPortal = true
		self.vb.netherBanish = self.vb.netherBanish + 1
		self.vb.TouchOfShadows = 0
		timerNetherBanishCD:Start(nil, self.vb.netherBanish+1)
		countdownNetherBanish:Start()
		if args:IsPlayer() then
			specWarnNetherBanish:Show()
			yellNetherBanish:Schedule(6, 1)
			yellNetherBanish:Schedule(5, 2)
			yellNetherBanish:Schedule(4, 3)
			yellNetherBanish:Schedule(3, 4)
			yellNetherBanish:Schedule(2, 5)
		else
			specWarnNetherBanishOther:Show(self.vb.netherBanish, args.destName)
		end
		updateRangeFrame(self)
	elseif spellId == 189895 and (playerBanished or not self.Options.FilterOtherPhase) then
		warnVoidStarFixate:CombinedShow(0.3, args.destName)--5 on mythic
		if args:IsPlayer() then
			specWarnVoidStarFixate:Show()
			yellVoidStarFixate:Yell()
		end
	elseif spellId == 186662 then--Felborne Overfiend Spawn
		timerFelborneOverfiendCD:Start()
		if self.vb.phase < 2.5 then--First spawn is about 4 seconds after phase 2.5 trigger yell
			DBM:Debug("Phase 2.5 begin CLEU")
			self.vb.phase = 2.5
			local elapsed, total = timerShackledTormentCD:GetTime()
			if elapsed > 0 and total > 0 then
				DBM:Debug("timerShackledTormentCD updated", 2)
				timerShackledTormentCD:Update(elapsed, total+5)--5 seconds is added to timer on 2.5 transition (give or take, need to know exact addition but need to see more data, since timer is variable as is)
			end
		end
	elseif spellId == 186952 and args:IsPlayer() then
		playerBanished = true
	elseif spellId == 187050 then
		self.vb.markOfLegionRemaining = self.vb.markOfLegionRemaining + 1
		legionTargets[#legionTargets+1] = args.destName
		self:Unschedule(showMarkOfLegion)
		if #legionTargets == 4 then
			showMarkOfLegion(self)
		else
			self:Schedule(0.5, showMarkOfLegion, self)
		end
		local uId = DBM:GetRaidUnitId(args.destName)
		local _, _, _, _, _, duration, expires, _, _ = UnitDebuff(uId, args.spellName)--Find out what our specific seed timer is
		if expires then
			if args:IsPlayer() then
				local remaining = expires-GetTime()
				specWarnMarkOfLegion:Show()
				yellMarkOfLegion:Schedule(remaining-1, 1)
				yellMarkOfLegion:Schedule(remaining-2, 2)
				yellMarkOfLegion:Schedule(remaining-3, 3)
				yellMarkOfLegion:Schedule(remaining-4, 4)
				yellMarkOfLegion:Schedule(remaining-5, 5)
			end
		end
		updateRangeFrame(self)
	elseif spellId == 190703 then
		if args:IsPlayer() then
			specWarnSourceofChaosYou:Show()
			yellSourceofChaos:Yell()
		end
	elseif spellId == 187255 and args:IsPlayer() and self:AntiSpam(2, 2) then
		specWarnNetherStorm:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 186123 or spellId == 185014 then--Wrought Chaos/Focused Chaos
		if self.Options.HudMapOnWrought then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	elseif spellId == 183634 then
		if self.Options.HudMapOnFelBurst then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	elseif spellId == 186961 then
		self.vb.netherPortal = false
		updateRangeFrame(self)
	elseif spellId == 186952 and args:IsPlayer() then
		playerBanished = false
	elseif spellId == 184964 then
		self.vb.unleashedCountRemaining = self.vb.unleashedCountRemaining - 1
		if (not playerBanished or not self.Options.FilterOtherPhase) and not self:IsLFR() then
			warnUnleashedTorment:Show(self.vb.unleashedCountRemaining)
		end
		if self.Options.SetIconOnShackledTorment2 then
			self:SetIcon(args.destName, 0)
		end
		if self.Options.HudMapOnShackledTorment and self:IsMythic() then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	elseif spellId == 187050 then
		self.vb.markOfLegionRemaining = self.vb.markOfLegionRemaining - 1
		if args:IsPlayer() then
			yellMarkOfLegion:Cancel()
		end
		updateRangeFrame(self)
		if self.Options.SetIconOnMarkOfLegion then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 187108 then--Infernal Doombringer Spawn
		self.vb.InfernalsActive = self.vb.InfernalsActive + 1
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 92740 then--Hellfire Deathcaller
		timerShadowBlastCD:Cancel(args.destGUID)
		timerDemonicHavocCD:Cancel(args.destGUID)
	elseif cid == 94412 then--Infernal Doombringer
		self.vb.InfernalsActive = self.vb.InfernalsActive - 1
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	--"<263.67 18:01:33> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Look upon the endless forces of the Burning Legion and know the folly of your resistance.#Archimonde
	--"<266.42 18:01:36> [CLEU] SPELL_AURA_APPLIED#Creature-0-2012-1448-150-93615-0000566CBD#Felborne Overfiend#Creature-0-2012-1448-150-93615-0000566CBD#Felborne Overfiend#186662#Heart of Argus#BUFF#nil", -- [12225]	
	if msg == L.phase2point5 and self.vb.phase < 2.5 then
		self:SendSync("phase25")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 187621 then
		local unitGUID = UnitGUID(uId)
		--timerShadowBlastCD ommited because it's used near instantly on spawn.
		specWarnDeathCaller:Show(self.vb.deathBrandCount)
		voiceDeathCaller:Play("ej11582")
		timerDemonicHavocCD:Start(1, unitGUID)
--	"<143.60 23:47:14> [UNIT_SPELLCAST_SUCCEEDED] Archimonde(Stellar) [[boss1:Allow Phase 2 Spells::0:190117]]", -- [4158]
--	"<143.64 23:47:14> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#The light will not fail!#Exarch Yrel###Archimonde##0#0##0#2601#nil#0#false#false#false", 
--	"<148.61 23:47:19> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#I grow tired of this pointless game. You face the immortal Legion, scourge of a thousand worlds.#Archimond
--	"<149.68 23:47:20> [CLEU] SPELL_CAST_START#Creature-0-3023-1448-20662-91331-000010BEEC#Archimonde##nil#184265#Wrought Chaos#nil#nil", -- [4314]
	elseif spellId == 190117 then--Phase 2 trigger
		self.vb.phase = 2
		--Cancel stuff only used in phase 1
		warnFelBurstSoon:Cancel()
		timerFelBurstCD:Cancel()
		timerDesecrateCD:Cancel()
		timerDoomfireCD:Cancel()
		--Cancel stuff that resets in phase 2
		timerAllureofFlamesCD:Cancel()
		warnAllureofFlamesSoon:Cancel()
		timerDeathbrandCD:Cancel()
		countdownDeathBrand:Cancel()
		--Begin phase 2
		warnPhase2:Show()
		voicePhaseChange:Play("ptwo")
		timerWroughtChaosCD:Start(6)
		timerDeathbrandCD:Start(35, self.vb.deathBrandCount+1)--35-39
		countdownDeathBrand:Start(35)
		warnAllureofFlamesSoon:Schedule(35.5)
		timerAllureofFlamesCD:Start(40.5)--40-45
		timerShackledTormentCD:Start(17)--17-25 (almost always 25, but sometimes it comes earlier, unsure why)
		updateRangeFrame(self)
--	"<301.70 23:49:52> [UNIT_SPELLCAST_SUCCEEDED] Archimonde(Omegal) [[boss1:Allow Phase 3 Spells::0:190118]]", -- [8737]
--	"<301.70 23:49:52> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Lok'tar ogar! They are pushed back! To the portal! Gul'dan is mine!#Grommash Hellscream###Grommash H
	elseif spellId == 190118 then--Phase 3 trigger
		self.vb.phase = 3
		warnAllureofFlamesSoon:Cancel()
		timerAllureofFlamesCD:Cancel()--Done for rest of fight
		timerDeathbrandCD:Cancel()--Done for rest of fight
		timerShackledTormentCD:Cancel()--Resets to 55 on non mythic, no longer cast on mythic
		countdownDeathBrand:Cancel()
		warnPhase3:Show()
		voicePhaseChange:Play("pthree")
		if not self:IsMythic() then
			timerNetherBanishCD:Start(11, 1)
			countdownNetherBanish:Start(11)
			timerDemonicFeedbackCD:Start(29)--29-33
			self:Schedule(23.5, setDemonicFeedback, self)
			specWarnDemonicFeedbackSoon:Schedule(23)
			countdownDemonicFeedback:Start(29)
			timerShackledTormentCD:Start(55)
		else
			--All need work, actual logs would be nice
			timerWroughtChaosCD:Cancel()
			timerDarkConduitCD:Start(10, 1)
			timerMarkOfLegionCD:Start(22, 1)
			timerInfernalsCD:Start(37, 1)
			timerSourceofChaosCD:Start(50, 1)
			timerTwistedDarknessCD:Start(79, 1)
			timerSeethingCorruptionCD:Start(nil, 1)
		end
	elseif spellId == 187111 then--Infernal Doombringer Spawn
		self.vb.InfernalsActive = self.vb.InfernalsActive + 1
		specWarnInfernals:Show(self.vb.InfernalsActive)
		local cooldown = infernalTimers[self.vb.InfernalsActive+1]
		if cooldown then
			timerInfernalsCD:Start(cooldown, self.vb.InfernalsActive+1)
		end
	end
end

function mod:OnSync(msg)
	if msg == "phase25" and self.vb.phase < 2.5 then
		DBM:Debug("Phase 2.5 begin yell")
		self.vb.phase = 2.5
		local elapsed, total = timerShackledTormentCD:GetTime()
		if elapsed > 0 and total > 0 then
			DBM:Debug("timerShackledTormentCD updated", 2)
			timerShackledTormentCD:Update(elapsed, total+5)--5 seconds is added to timer on 2.5 transition (give or take, need to know exact addition but need to see more data, since timer is variable as is)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 187255 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnNetherStorm:Show()
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

