local mod	= DBM:NewMod(1438, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91331)--Doomfire Spirit (92208), Hellfire Deathcaller (92740), Felborne Overfiend (93615), Dreadstalker (93616), Infernal doombringer (94412)
mod:SetEncounterID(1799)
mod:SetMinSyncRevision(13964)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(14687)
--mod.respawnTime = 29--roughly, needs verifying

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 183254 189897 183817 183828 185590 184265 183864 190506 184931 187180 182225 190050 190394 190686 190821 186663 188514 186961 190313",
	"SPELL_CAST_SUCCESS 187180 188514 183254 185590",
	"SPELL_AURA_APPLIED 182879 183634 184964 186574 186961 189895 186123 186662 186952 190703 187255 185014 187050 183963 183586",
	"SPELL_AURA_APPLIED_DOSE 183586",
	"SPELL_AURA_REMOVED 186123 185014 186961 186952 184964 187050 183634 183963 183586",
	"SPELL_SUMMON 187108",
	"SPELL_PERIODIC_DAMAGE 187255",
	"SPELL_ABSORBED 187255",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--(ability.id = 183254 or ability.id = 182225 or ability.id = 189897 or ability.id = 183817 or ability.id = 183828 or ability.id = 185590 or ability.id = 184265 or ability.id = 190506 or ability.id = 184931 or ability.id = 187180) and type = "begincast" or (ability.id = 183865) and type = "cast" or (ability.id = 186662 or ability.id = 186961) and (type = "applydebuff" or type = "applybuff")
--(ability.id = 190394 or ability.id = 190686 or ability.id = 190821 or ability.id = 190506 or ability.id = 187108) and type = "begincast" or (ability.id = 188514) and type = "cast" or ability.id = 187108
--TODO, failsafes are at work for transitions i still don't have enough data for. for example, something seems to always cause the 2nd or 3rd fel burst to delay by a HUGE amount (20-30 seconds sometimes) but don't know what it is. Probalby phase transitions but it's not as simple as resetting timer. probably something more zon ozz
--TODO, figure out what to do with touch of the legion (190400)
--Phase 1: The Defiler
local warnDoomfireFixate			= mod:NewTargetAnnounce(182879, 3)
local warnAllureofFlames			= mod:NewCastAnnounce(183254, 2)
local warnFelBurstSoon				= mod:NewSoonAnnounce(183817, 3)
local warnFelBurstCast				= mod:NewCastAnnounce(183817, 3)
local warnFelBurst					= mod:NewTargetAnnounce(183817, 3, nil, true, 2)
local warnLight						= mod:NewYouAnnounce(183963, 1)
--Phase 2: Hand of the Legion
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnShackledTorment			= mod:NewTargetCountAnnounce(184964, 3)
local warnUnleashedTorment			= mod:NewAddsLeftAnnounce(185008, 2)--NewAddsLeftAnnounce perfect for this!
local warnWroughtChaos				= mod:NewTargetCountAnnounce(184265, 4)--Combined both targets into one warning under primary spell name
local warnDreadFixate				= mod:NewTargetAnnounce(186574, 2, nil, false)--In case it matters on mythic, it was spammy on heroic and unimportant
local warnOverfiend					= mod:NewCountAnnounce("ej11603", 3, 186662)
--Phase 3
local warnPhase3					= mod:NewPhaseAnnounce(3, 2)
----The Nether
local warnVoidStarFixate			= mod:NewTargetAnnounce(189895, 2)
--Mythic
local warnDoomFireStack				= mod:NewStackAnnounce(183586, 3)
local warnMarkOfLegion				= mod:NewTargetCountAnnounce(187050, 4)
local warnDarkConduit				= mod:NewCountAnnounce(190394, 2, nil, "Ranged")

--Phase 1: The Defiler
local specWarnDoomfire				= mod:NewSpecialWarningSwitch(189897, "Dps", nil, nil, 1, 5)
local specWarnDoomfireFixate		= mod:NewSpecialWarningYou(182879, nil, nil, nil, 4)
local yellDoomfireFixate			= mod:NewYell(182826)--Use short name for yell
local specWarnAllureofFlames		= mod:NewSpecialWarningDodge(183254, nil, nil, nil, 2, 2)
local specWarnDeathCaller			= mod:NewSpecialWarningSwitchCount("ej11582", "Dps", nil, nil, 1, 2)--Tanks don't need switch, they have death brand special warning 2 seconds earlier
local specWarnFelBurst				= mod:NewSpecialWarningYou(183817)
local yellFelBurst					= mod:NewPosYell(183817)--Change yell to countdown mayeb when better understood
local specWarnFelBurstNear			= mod:NewSpecialWarningMoveTo(183817, nil, nil, nil, 1, 2)--Anyone near by should run in to help soak, should be mostly ranged but if it's close to melee, melee soaking too doesn't hurt
local specWarnDesecrate				= mod:NewSpecialWarningDodge(185590, "Melee", nil, nil, 1, 2)
local specWarnDeathBrand			= mod:NewSpecialWarningCount(183828, "Tank", nil, nil, 1, 2)
--Phase 2: Hand of the Legion
local specWarnBreakShackle			= mod:NewSpecialWarning("specWarnBreakShackle", nil, nil, nil, 1, 5)
local yellShackledTorment			= mod:NewPosYell(184964)
local specWarnWroughtChaos			= mod:NewSpecialWarningYou(186123, nil, nil, nil, 3, 5)
local yellWroughtChaos				= mod:NewYell(186123)
local specWarnFocusedChaos			= mod:NewSpecialWarningYou(185014, nil, nil, nil, 3, 5)
local yellFocusedChaos				= mod:NewFadesYell(185014)
local specWarnDreadFixate			= mod:NewSpecialWarningYou(186574, false)--In case it matters on mythic, it was spammy on heroic and unimportant
local specWarnFlamesOfArgus			= mod:NewSpecialWarningInterrupt(186663, "-Healer", nil, nil, 1, 2)
--Phase 3: The Twisting Nether
local specWarnDemonicFeedbackSoon	= mod:NewSpecialWarningSoon(187180, nil, nil, nil, 1, 2)
local specWarnDemonicFeedback		= mod:NewSpecialWarningCount(187180, nil, nil, nil, 3, 2)
local specWarnNetherBanish			= mod:NewSpecialWarningYou(186961, nil, nil, nil, 1, 5)
local specWarnNetherBanishOther		= mod:NewSpecialWarningTargetCount(186961, nil, nil, nil, 1, 5)
local yellNetherBanish				= mod:NewFadesYell(186961)
----The Nether
local specWarnTouchofShadows		= mod:NewSpecialWarningInterruptCount(190050, nil, nil, nil, 1, 5)
local specWarnVoidStarFixate		= mod:NewSpecialWarningYou(189895, nil, nil, nil, 1, 5)
local yellVoidStarFixate			= mod:NewYell(189895, nil, false)
local specWarnNetherStorm			= mod:NewSpecialWarningMove(187255)
--Phase 3.5
local specWarnRainofChaos			= mod:NewSpecialWarningCount(189953, nil, nil, nil, 2)
--Mythic
local specWarnDarkConduitSoon		= mod:NewSpecialWarningSoon(190394, "Ranged", nil, nil, 1, 2)
local specWarnSeethingCorruption	= mod:NewSpecialWarningCount(190506, nil, nil, nil, 2, 2)
local specWarnMarkOfLegion			= mod:NewSpecialWarningYouPos(187050, nil, nil, 2, 3, 5)
local yellDoomFireFades				= mod:NewFadesYell(183586, nil, false)
local yellMarkOfLegion				= mod:NewFadesYell(187050, 28836)
local yellMarkOfLegionPoS			= mod:NewPosYell(187050, 28836)
local specWarnSourceofChaosYou		= mod:NewSpecialWarningYou(190703)
local yellSourceofChaos				= mod:NewYell(190703)
local specWarnSourceofChaos			= mod:NewSpecialWarningSwitchCount(190703, "Dps")--Maybe exclude ranged or healers. Not sure if just dps is enough to soak it, at very least dps have to kill it
local specWarnInfernals				= mod:NewSpecialWarningSwitchCount(187111, "-Healer")--Tanks should probably help pick these up and spread them
local specWarnTwistedDarkness		= mod:NewSpecialWarningSwitchCount(190821, "RangedDps")

--Phase 1: The Defiler
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerDoomfireCD				= mod:NewCDTimer(41.5, 182826, nil, nil, nil, 1)--182826 cast, 182879 fixate. Doomfire only fixates ranged, but ALL dps switch to it.
local timerAllureofFlamesCD			= mod:NewCDTimer(47.5, 183254, nil, nil, nil, 2)
local timerFelBurstCD				= mod:NewCDTimer(52, 183817, nil, nil, 2, 3, nil, DBM_CORE_DEADLY_ICON)
local timerDeathbrandCD				= mod:NewCDCountTimer(42.5, 183828, nil, nil, nil, 1)--Everyone, for tanks/healers to know when debuff/big hit, for dps to know add coming
local timerDesecrateCD				= mod:NewCDTimer(26.3, 185590, nil, nil, 2, 2)
local timerLightCD					= mod:NewNextTimer(10, 183963, nil, nil, nil, 5)
----Hellfire Deathcaller
local timerShadowBlastCD			= mod:NewCDTimer(7.3, 183864, nil, "Tank", nil, 5)
--Phase 2: Hand of the Legion
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerShackledTormentCD		= mod:NewCDCountTimer(31.5, 184931, nil, nil, nil, 3)
local timerWroughtChaosCD			= mod:NewCDTimer(51.7, 184265, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
--Phase 2.5
local timerFelborneOverfiendCD		= mod:NewNextCountTimer(44.3, "ej11603", nil, nil, nil, 1, 186662)
--Phase 3: The Twisting Nether
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerDemonicFeedbackCD		= mod:NewCDCountTimer(35, 187180, nil, nil, nil, 2)
local timerNetherBanishCD			= mod:NewCDCountTimer(61.9, 186961, nil, nil, nil, 5)
--Phase 3.5:
local timerRainofChaosCD			= mod:NewCDCountTimer(62, 182225, nil, nil, nil, 2)
----The Nether
--Mythic
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerDarkConduitCD			= mod:NewCDCountTimer(107, 190394, nil, "-Melee", 2, 3)
local timerMarkOfLegionCD			= mod:NewCDCountTimer(107, 187050, nil, nil, nil, 3)
local timerInfernalsCD				= mod:NewCDCountTimer(107, 187111, nil, nil, nil, 1, 1122)
local timerSourceofChaosCD			= mod:NewCDCountTimer(107, 190703, nil, nil, 2, 1)
local timerTwistedDarknessCD		= mod:NewCDCountTimer(107, 190821, nil, nil, nil, 1)
local timerSeethingCorruptionCD		= mod:NewCDCountTimer(107, 190506, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)

--local berserkTimer				= mod:NewBerserkTimer(360)

--countdowns kind of blow with this fights timer variations.
--Everything but overfiend is a CD
--I don't want to use a countdown on something thats 47-56 like allure or 52-70 like felburst
local countdownWroughtChaos			= mod:NewCountdownFades("Alt5", 184265, nil, nil, 3)
local countdownNetherBanish			= mod:NewCountdown(61.9, 186961, nil, nil, 3)
local countdownDemonicFeedback		= mod:NewCountdown("Alt35", 186961, nil, nil, 3)
local countdownDeathBrand			= mod:NewCountdown(42, 183828, "Tank", 2, 3)
local countdownShackledTorment		= mod:NewCountdown("AltTwo42", 184931, "-Tank", nil, 3)
local countdownSeethingCorruption	= mod:NewCountdown(61.9, 190506)
local countdownSourceofChaos		= mod:NewCountdown("Alt35", 190703, "Tank")

local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceDeathBrand				= mod:NewVoice(183828, "Tank")--defensive/tauntboss
local voiceFelBurst					= mod:NewVoice(183817)--Gathershare
local voiceShackledTorment			= mod:NewVoice(184964)--new voice: break torment first, etc
local voiceDoomfire					= mod:NewVoice(189897, "Dps")--189897
local voiceDeathCaller				= mod:NewVoice("ej11582", "Dps")--ej11582
local voiceWroughtChaos				= mod:NewVoice(186123) --new voice
local voiceFocusedChaos				= mod:NewVoice(185014) --new voice
local voiceFlamesofArgus			= mod:NewVoice(186663, "-Healer") --kickcast
local voiceDemonicFeedback			= mod:NewVoice(186961) --spread/scatter
local voiceAllureofFlames			= mod:NewVoice(183254) --watch step
local voiceDesecrate				= mod:NewVoice(185590) --watch step
local voiceNetherBanish				= mod:NewVoice(186961) --teleyou
local voiceTouchofShadows			= mod:NewVoice(190050) --kick1r/kick2r
local voiceDarkConduit				= mod:NewVoice(190394, "Ranged") --spread/scatter
local voiceSeethingCorruption		= mod:NewVoice(190506) --watch step
local voiceMarkOfLegion				= mod:NewVoice(187050) --mmX
local voiceVoidStarFixate			= mod:NewVoice(189895) --orbrun

mod:AddRangeFrameOption("6/8/10")
mod:AddSetIconOption("SetIconOnFelBurst", 183634, true)
mod:AddSetIconOption("SetIconOnShackledTorment2", 184964, false)
mod:AddSetIconOption("SetIconOnMarkOfLegion2", 187050, true)
mod:AddSetIconOption("SetIconOnInfernals2", "ej11618", false, true)
mod:AddHudMapOption("HudMapOnFelBurst2", 183634, "Ranged")
mod:AddHudMapOption("HudMapOnShackledTorment2", 184964, true)
mod:AddHudMapOption("HudMapOnWrought", 184265)
mod:AddHudMapOption("HudMapMarkofLegion", 187050, false)
mod:AddBoolOption("ExtendWroughtHud3", true)
--mod:AddBoolOption("AlternateHudLine", false)
mod:AddBoolOption("NamesWroughtHud", true)
mod:AddBoolOption("FilterOtherPhase", true)
mod:AddInfoFrameOption(184964)
mod:AddDropdownOption("MarkBehavior", {"Numbered", "LocSmallFront", "LocSmallBack", "NoAssignment"}, "Numbered", "misc")

mod.vb.phase = 1
mod.vb.demonicCount = 0
mod.vb.demonicFeedback = false
mod.vb.netherPortals = 0
mod.vb.unleashedCountRemaining = 0
mod.vb.markOfLegionCast = 0
mod.vb.markOfLegionRemaining = 0
mod.vb.netherBanish2 = 0
mod.vb.rainOfChaos = 0
mod.vb.TouchOfShadows = 0
mod.vb.wroughtWarned = 0
mod.vb.tormentCast = 0
mod.vb.overfiendCount = 0
--Mythic sync variables
mod.vb.deathBrandCount = 0
mod.vb.darkConduitCast = 0
mod.vb.darkConduitSpawn = 0
mod.vb.InfernalsCast = 0
mod.vb.sourceOfChaosCast = 0
mod.vb.twistedDarknessCast = 0
mod.vb.seethingCorruptionCount = 0
mod.vb.darkConduit = false
mod.vb.MarkBehavior = "Numbered"
--Mythic sequence timers for phase 3 (Made by video, subject to inaccuracies until logs available)
local legionTimers = {20, 63, 60, 60, 48, 46, 47}--All verified by log
local darkConduitTimers = {8, 123, 95, 56, 52}-- All verified by log
local infernalTimers = {35, 62.5, 63, 55, 68, 41}--All verified by log
local sourceofChaosTimers = {49, 58, 76, 78}--All verified by log
local twistedDarknessTimers = {75, 78, 42, 40, 72}--All verified by log
local seethingCorruptionTimers = {61, 58, 52, 70, 30, 41}--All verified by log
--Range frame/filter shit
local shacklesTargets = {}
local legionTargets = {}
local felburstTargets = {}
local playerName = UnitName("player")
local playerBanished = false
local UnitDebuff, UnitDetailedThreatSituation, UnitClass, UnitIsUnit = UnitDebuff, UnitDetailedThreatSituation, UnitClass, UnitIsUnit
local NetherBanish = GetSpellInfo(186961)
local shackledDebuff = GetSpellInfo(184964)
local felburstDebuff = GetSpellInfo(183634)
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

local updateInfoFrame, sortInfoFrame
do
	local lines = {}
	sortInfoFrame = function(a, b)
		local a = lines[a]
		local b = lines[b]
		if not tonumber(a) then a = -1 end
		if not tonumber(b) then b = -1 end
		if a < b then return true else return false end
	end
	updateInfoFrame = function()
		table.wipe(lines)
		local total = 0
		for i = 1, #felburstTargets do
			if i == 9 then break end--It's a wipe, plus can't do more than 8 of these with icons
			local name = felburstTargets[i]
			local uId = DBM:GetRaidUnitId(name)
			if uId and UnitDebuff(uId, felburstDebuff) then
				total = total + 1
				lines[name] = i
			end
		end
		for i = 1, #shacklesTargets do
			local name = shacklesTargets[i]
			local uId = DBM:GetRaidUnitId(name)
			if uId and UnitDebuff(uId, shackledDebuff) then
				total = total + 1
				lines[name] = i
			end
		end
		if total == 0 then--None found, hide infoframe because all broke
			DBM.InfoFrame:Hide()
		end
		return lines
	end
end

local function updateRangeFrame(self)
	if not self.Options.RangeFrame or not self:IsInCombat() then return end
	if playerBanished and not self:IsMythic() then
		DBM.RangeCheck:Hide()
	elseif self.vb.demonicFeedback then
		DBM.RangeCheck:Show(6)
	elseif self.vb.netherPortal then
		--Blue post says 8, but pretty sure it's 10. The visual was bigger than 8
		if UnitDebuff("player", NetherBanish) then
			DBM.RangeCheck:Show(10)
		else
			DBM.RangeCheck:Show(10, netherFilter)
		end
	elseif (self.vb.darkConduit or self.vb.phase < 2) and self:IsRanged() then--Fel burst in phase 1, dark conduit in phase 3 mythic
		DBM.RangeCheck:Show(8)
	elseif self.vb.markOfLegionRemaining > 0 then
		if UnitDebuff("player", markOfLegionDebuff) then
			DBM.RangeCheck:Show(10, nil, nil, 4, true)
		else
			DBM.RangeCheck:Show(10, markOfLegionFilter)
		end
	else
		DBM.RangeCheck:Hide()
	end
end

local function setDarkConduit(self, clear)
	if clear then
		self.vb.darkConduit = false
	else
		self.vb.darkConduit = true
		specWarnDarkConduitSoon:Show()
		voiceDarkConduit:Play("scatter")
	end
	updateRangeFrame(self)
end

local function setDemonicFeedback(self)
	self.vb.demonicFeedback = true
	updateRangeFrame(self)
	if not playerBanished or not self.Options.FilterOtherPhase then
		specWarnDemonicFeedbackSoon:Show()
		voiceDemonicFeedback:Play("scattersoon")
	end
end

local iconedAssignments = {RAID_TARGET_1, RAID_TARGET_2, RAID_TARGET_3, RAID_TARGET_4}
local function showMarkOfLegion(self, spellName)
	--5,7,9,11 seconds. Sorted lowest to highest
	--5, 7 on melee, 9, 11 on ranged (if enough alive anyways)
	--DBM auto sorts icons to 1-5, 2-7, 3-9, 4-11
	--Yell format is "Mark (location) on <icon><playername><icon>" .
	--MELEE, RANGED, DBM_CORE_LEFT, DBM_CORE_RIGHT (http://puu.sh/jsyr5/7014c50cb3.jpg)
	--Melee/ranged left/right is now the default since too many users felt weak aura's were required because running to icons by icon assignments was hard.
	warnMarkOfLegion:Show(self.vb.markOfLegionCast, table.concat(legionTargets, "<, >"))
	if self.vb.MarkBehavior == "NoAssignment" then return end
	for i = 1, #legionTargets do
		local name = legionTargets[i]
		if not name then break end
		local uId = DBM:GetRaidUnitId(name)
		if not uId then break end
		if i == 1 then
			local number, position = i, MELEE
			if self.vb.MarkBehavior == "LocSmallBack" then
				number, position = 3, RANGED
			end
			local message = position.."-"..DBM_CORE_LEFT
			if self.vb.MarkBehavior == "Numbered" then
				message = iconedAssignments[number]
			end
			if self.Options.SetIconOnMarkOfLegion2 then
				self:SetIcon(name, number)
			end
			if self.Options.HudMapMarkofLegion then
				if number == 3 then
					DBMHudMap:RegisterRangeMarkerOnPartyMember(187050, "highlight", name, 10, 12, 1, 0, 1, 0.5):Appear():SetLabel(name)--Purple to match Diamond
				else
					DBMHudMap:RegisterRangeMarkerOnPartyMember(187050, "highlight", name, 10, 12, 1, 1, 0, 0.5):Appear():SetLabel(name)--Yellow to match Star
				end
			end
			if name == playerName then
				specWarnMarkOfLegion:Show(message)
				yellMarkOfLegionPoS:Yell(message, number, number)
				voiceMarkOfLegion:Play("mm"..number)
			end
		elseif i == 2 then
			local number, position = i, MELEE
			if self.vb.MarkBehavior == "LocSmallBack" then
				number, position = 4, RANGED
			end
			local message = position.."-"..DBM_CORE_RIGHT
			if self.vb.MarkBehavior == "Numbered" then
				message = iconedAssignments[number]
			end
			if self.Options.SetIconOnMarkOfLegion2 then
				self:SetIcon(name, number)
			end
			if self.Options.HudMapMarkofLegion then
				if number == 4 then
					DBMHudMap:RegisterRangeMarkerOnPartyMember(187050, "highlight", name, 10, 12, 0, 1, 0, 0.5):Appear():SetLabel(name)--Green to match Triangle
				else
					DBMHudMap:RegisterRangeMarkerOnPartyMember(187050, "highlight", name, 10, 12, 1, 0.5, 0, 0.5):Appear():SetLabel(name)--Orange to match Circle
				end
			end
			if name == playerName then
				specWarnMarkOfLegion:Show(message)
				yellMarkOfLegionPoS:Yell(message, number, number)
				voiceMarkOfLegion:Play("mm"..number)
			end
		elseif i == 3 then
			local number, position = i, RANGED
			if self.vb.MarkBehavior == "LocSmallBack" then
				number, position = 1, MELEE
			end
			local message = position.."-"..DBM_CORE_LEFT
			if self.vb.MarkBehavior == "Numbered" then
				message = iconedAssignments[number]
			end
			if self.Options.SetIconOnMarkOfLegion2 then
				self:SetIcon(name, number)
			end
			if self.Options.HudMapMarkofLegion then
				if number == 1 then
					DBMHudMap:RegisterRangeMarkerOnPartyMember(187050, "highlight", name, 10, 12, 1, 1, 0, 0.5):Appear():SetLabel(name)--Yellow to match Star
				else
					DBMHudMap:RegisterRangeMarkerOnPartyMember(187050, "highlight", name, 10, 12, 1, 0, 1, 0.5):Appear():SetLabel(name)--Purple to match Diamond
				end
			end
			if name == playerName then
				specWarnMarkOfLegion:Show(message)
				yellMarkOfLegionPoS:Yell(message, number, number)
				voiceMarkOfLegion:Play("mm"..number)
			end
		else
			local number, position = i, RANGED
			if self.vb.MarkBehavior == "LocSmallBack" then
				number, position = 2, MELEE
			end
			local message = position.."-"..DBM_CORE_RIGHT
			if self.vb.MarkBehavior == "Numbered" then
				message = iconedAssignments[number]
			end
			if self.Options.SetIconOnMarkOfLegion2 then
				self:SetIcon(name, number)
			end
			if self.Options.HudMapMarkofLegion then
				if number == 2 then
					DBMHudMap:RegisterRangeMarkerOnPartyMember(187050, "highlight", name, 10, 12, 1, 0.5, 0, 0.5):Appear():SetLabel(name)--Orange to match Circle
				else
					DBMHudMap:RegisterRangeMarkerOnPartyMember(187050, "highlight", name, 10, 12, 0, 1, 0, 0.5):Appear():SetLabel(name)--Green to match Triangle
				end
			end
			if name == playerName then
				specWarnMarkOfLegion:Show(message)
				yellMarkOfLegionPoS:Yell(message, number, number)
				voiceMarkOfLegion:Play("mm"..number)
			end
		end
	end
end

local function showFelburstTargets(self)
	table.sort(felburstTargets)
	warnFelBurst:Show(table.concat(felburstTargets, "<, >"))
	for i = 1, #felburstTargets do
		if i == 9 then break end--It's a wipe, plus can't do more than 8 of these with icons
		local name = felburstTargets[i]
		if name == playerName then
			yellFelBurst:Yell(i, i, i)
		end
		if self.Options.SetIconOnFelBurst then
			self:SetIcon(name, i)
		end
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(felburstDebuff)
		DBM.InfoFrame:Show(5, "function", updateInfoFrame, sortInfoFrame, true)
	end
end

local function breakShackles(self, spellName)
--	I thought about using auto scheduling and doing "break shackle now" with few seconds in between each
--	then i realized that'd do more harm that good, if raid is low and dbm says break shackle, you wipe.
--	So now it just gives order, but you break at pace needed by your healers
	table.sort(shacklesTargets)
	if not playerBanished or not self.Options.FilterOtherPhase then
		warnShackledTorment:Show(self.vb.tormentCast, table.concat(shacklesTargets, "<, >"))
	end
	if self:IsLFR() then return end
	local playerHasShackle = false
	for i = 1, #shacklesTargets do
		local name = shacklesTargets[i]
		if not name then break end
		if not DBM:GetRaidUnitId(name) then break end
		if name == playerName then
			playerHasShackle = true
			yellShackledTorment:Yell(i, i, i)
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
			DBM.InfoFrame:Show(5, "function", updateInfoFrame, sortInfoFrame, true)
		end
	end
	if self.Options.HudMapOnShackledTorment2 and self:IsMythic() then
		DBMHudMap:RegisterRangeMarkerOnPartyMember(1849642, "party", playerName, 0.9, 30, nil, nil, nil, 1, nil, false):Appear()
		for i = 1, #shacklesTargets do
			local name = shacklesTargets[i]
			if not name then break end
			if not DBM:GetRaidUnitId(name) then break end
			if playerHasShackle then
				DBMHudMap:RegisterStaticMarkerOnPartyMember(184964, "highlight", name, 25, nil, 0, 1, 0, 0.3):Appear():RegisterForAlerts(spellName, name)
			else
				DBMHudMap:RegisterStaticMarkerOnPartyMember(184964, "highlight", name, 25, nil, 0, 1, 0, 0.3):Appear():RegisterForAlerts(nil, name)
			end
		end
	end
end

--Source of Chaos can be skipped, so we need to runa backup check to see if it was missed, and start timer for next one
local function sourceOfChaosCheck(self)
	self.vb.sourceOfChaosCast = self.vb.sourceOfChaosCast + 1
	local cooldown = sourceofChaosTimers[self.vb.sourceOfChaosCast+1]
	if cooldown then
		--Subtrack 5 from next cd, since this check is running 5 seconds late
		timerSourceofChaosCD:Start(cooldown-5, self.vb.sourceOfChaosCast+1)
		countdownSourceofChaos:Start(cooldown-5)
		--Schedule Late check for 5 seconds AFTER cast
		self:Schedule(cooldown, sourceOfChaosCheck, self)
	end
end

--Ugly as shit, but it vastly improves timer accuracy by accounting for archimonds ICD code
--Shackled torment, wrought chaos, allure of flames, felburst, and doomfire all trigger 7 second ICD
--Death brand triggers a 6 second ICD, not 7
--Demonic Feedback triggers 3.5 second ICD
--Rain of chaos doesn't trigger ICD nor is affected by it
--Nether banish IS affected by ICD but inconclusive on whether it CAUSES one
--Allure and desecreate do not trigger ICD for eachother but trigger them for everythinge else in phase 1.5
--Allure and shackles don't trigger ICDs fore achother but do for everything else in phase 2
local function updateAllTimers(self, ICD, AllureSpecial)
--	if not DBM.Options.DebugMode then return end
	DBM:Debug("updateAllTimers running", 3)
	local phase = self.vb.phase
	if phase < 2 then
		if timerDoomfireCD:GetRemaining() < ICD then
			local elapsed, total = timerDoomfireCD:GetTime()
			local extend = ICD - (total-elapsed)
			DBM:Debug("timerDoomfireCD extended by: "..extend, 2)
			timerDoomfireCD:Cancel()
			timerDoomfireCD:Update(elapsed, total+extend)
		end
		if not AllureSpecial and timerAllureofFlamesCD:GetRemaining() < ICD then
			local elapsed, total = timerAllureofFlamesCD:GetTime()
			local extend = ICD - (total-elapsed)
			DBM:Debug("timerAllureofFlamesCD extended by: "..extend, 2)
			timerAllureofFlamesCD:Cancel()
			timerAllureofFlamesCD:Update(elapsed, total+extend)
		end
		if timerFelBurstCD:GetRemaining() < ICD then
			local elapsed, total = timerFelBurstCD:GetTime()
			local extend = ICD - (total-elapsed)
			DBM:Debug("timerFelBurstCD extended by: "..extend, 2)
			warnFelBurstSoon:Cancel()
			timerFelBurstCD:Cancel()
			timerFelBurstCD:Update(elapsed, total+extend)
		end
		if timerDeathbrandCD:GetRemaining(self.vb.deathBrandCount+1) < ICD then
			local elapsed, total = timerDeathbrandCD:GetTime(self.vb.deathBrandCount+1)
			local extend = ICD - (total-elapsed)
			DBM:Debug("timerDeathbrandCD extended by: "..extend, 2)
			timerDeathbrandCD:Cancel()
			timerDeathbrandCD:Update(elapsed, total+extend, self.vb.deathBrandCount+1)
			countdownDeathBrand:Cancel()
			countdownDeathBrand:Start(ICD)
		end
		if phase == 1.5 then
			if not AllureSpecial and timerDesecrateCD:GetRemaining() < ICD then
				local elapsed, total = timerDesecrateCD:GetTime()
				local extend = ICD - (total-elapsed)
				DBM:Debug("timerDesecrateCD extended by: "..extend, 2)
				timerDesecrateCD:Cancel()
				timerDesecrateCD:Update(elapsed, total+extend)
			end
		end
	elseif phase < 3 then
		if not AllureSpecial and timerAllureofFlamesCD:GetRemaining() < ICD then
			local elapsed, total = timerAllureofFlamesCD:GetTime()
			local extend = ICD - (total-elapsed)
			DBM:Debug("timerAllureofFlamesCD extended by: "..extend, 2)
			timerAllureofFlamesCD:Cancel()
			timerAllureofFlamesCD:Update(elapsed, total+extend)
		end
		if not AllureSpecial and timerShackledTormentCD:GetRemaining(self.vb.tormentCast+1) < ICD then
			local elapsed, total = timerShackledTormentCD:GetTime(self.vb.tormentCast+1)
			local extend = ICD - (total-elapsed)
			DBM:Debug("timerShackledTormentCD extended by: "..extend, 2)
			timerShackledTormentCD:Cancel()
			timerShackledTormentCD:Update(elapsed, total+extend, self.vb.tormentCast+1)
			countdownShackledTorment:Cancel()
			countdownShackledTorment:Start(ICD)
		end
		if not self:IsFaceroll() and timerWroughtChaosCD:GetRemaining() < ICD then
			local elapsed, total = timerWroughtChaosCD:GetTime()
			local extend = ICD - (total-elapsed)
			DBM:Debug("timerWroughtChaosCD extended by: "..extend, 2)
			timerWroughtChaosCD:Cancel()
			timerWroughtChaosCD:Update(elapsed, total+extend)
		end
		if timerDeathbrandCD:GetRemaining(self.vb.deathBrandCount+1) < ICD then
			local elapsed, total = timerDeathbrandCD:GetTime(self.vb.deathBrandCount+1)
			local extend = ICD - (total-elapsed)
			DBM:Debug("timerDeathbrandCD extended by: "..extend, 2)
			timerDeathbrandCD:Cancel()
			timerDeathbrandCD:Update(elapsed, total+extend, self.vb.deathBrandCount+1)
			countdownDeathBrand:Cancel()
			countdownDeathBrand:Start(ICD)
		end
	else
		if timerShackledTormentCD:GetRemaining(self.vb.tormentCast+1) < ICD then
			local elapsed, total = timerShackledTormentCD:GetTime(self.vb.tormentCast+1)
			local extend = ICD - (total-elapsed)
			DBM:Debug("timerShackledTormentCD extended by: "..extend, 2)
			timerShackledTormentCD:Cancel()
			timerShackledTormentCD:Update(elapsed, total+extend, self.vb.tormentCast+1)
			countdownShackledTorment:Cancel()
			countdownShackledTorment:Start(ICD)
		end
		if not self:IsFaceroll() and timerWroughtChaosCD:GetRemaining() < ICD then
			local elapsed, total = timerWroughtChaosCD:GetTime()
			local extend = ICD - (total-elapsed)
			DBM:Debug("timerWroughtChaosCD extended by: "..extend, 2)
			timerWroughtChaosCD:Cancel()
			timerWroughtChaosCD:Update(elapsed, total+extend)
		end
		if timerDemonicFeedbackCD:GetRemaining(self.vb.demonicCount+1) < ICD then
			local elapsed, total = timerDemonicFeedbackCD:GetTime(self.vb.demonicCount+1)
			local extend = ICD - (total-elapsed)
			DBM:Debug("timerDemonicFeedbackCD extended by: "..extend, 2)
			specWarnDemonicFeedbackSoon:Cancel()
			timerDemonicFeedbackCD:Cancel()
			timerDemonicFeedbackCD:Update(elapsed, total+extend, self.vb.demonicCount+1)
			countdownDemonicFeedback:Cancel()
			countdownDemonicFeedback:Start(ICD)
		end
		if timerNetherBanishCD:GetRemaining(self.vb.netherBanish2+1) < ICD then
			local elapsed, total = timerNetherBanishCD:GetTime(self.vb.netherBanish2+1)
			local extend = ICD - (total-elapsed)
			DBM:Debug("timerNetherBanishCD extended by: "..extend, 2)
			timerNetherBanishCD:Cancel()
			timerNetherBanishCD:Update(elapsed, total+extend, self.vb.netherBanish2+1)
			countdownNetherBanish:Cancel()
			countdownNetherBanish:Start(ICD)
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
	self.vb.netherBanish2 = 0
	self.vb.rainOfChaos = 0
	self.vb.TouchOfShadows = 0
	self.vb.deathBrandCount = 0
	self.vb.tormentCast = 0
	self.vb.overfiendCount = 0
	playerBanished = false
	timerDoomfireCD:Start(5.1-delay)
	timerDeathbrandCD:Start(15-delay, 1)
	countdownDeathBrand:Start(15-delay)
	timerAllureofFlamesCD:Start(30-delay)
	warnFelBurstSoon:Schedule(35-delay)
	timerFelBurstCD:Start(40-delay)
	if self:IsMythic() then
		self.vb.MarkBehavior = "Numbered"
		self.vb.markOfLegionCast = 0
		self.vb.darkConduitCast = 0
		self.vb.darkConduitSpawn = 0
		self.vb.InfernalsCast = 0
		self.vb.sourceOfChaosCast = 0
		self.vb.twistedDarknessCast = 0
		self.vb.seethingCorruptionCount = 0
		self.vb.darkConduit = false
	end
	updateRangeFrame(self)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnWrought or self.Options.HudMapOnFelBurst or self.Options.HudMapOnShackledTorment2 then
		DBMHudMap:Disable()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 183254 then
		warnAllureofFlames:Show()
		timerAllureofFlamesCD:Start()
		updateAllTimers(self, 6, true)
	elseif spellId == 189897 then
		specWarnDoomfire:Show()
		timerDoomfireCD:Start()
		voiceDoomfire:Play("189897")
		updateAllTimers(self, 7)
	elseif spellId == 183817 then
		table.wipe(felburstTargets)
		warnFelBurstCast:Show()
		warnFelBurstSoon:Schedule(47)
		timerFelBurstCD:Start()
		updateAllTimers(self, 7)
	elseif spellId == 183828 then
		if self:AntiSpam(10, 8) then
			self.vb.deathBrandCount = self.vb.deathBrandCount + 1
		end
		specWarnDeathBrand:Show(self.vb.deathBrandCount)
		timerDeathbrandCD:Cancel()
		timerDeathbrandCD:Start(nil, self.vb.deathBrandCount+1)
		countdownDeathBrand:Cancel()
		countdownDeathBrand:Start()
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		if tanking or (status == 3) then
			voiceDeathBrand:Play("defensive")
		else
			voiceDeathBrand:Play("tauntboss")
		end
		updateAllTimers(self, 5)
	elseif spellId == 185590 then
		specWarnDesecrate:Show()
		voiceDesecrate:Play("watchstep")
		timerDesecrateCD:Start()
		if self.vb.phase < 1.5 then
			DBM:Debug("Phase 1.5 begin CLEU", 2)
			self.vb.phase = 1.5--85%
		end
		updateAllTimers(self, 7, true)
	elseif spellId == 184265 then
		self.vb.wroughtWarned = 0--Reset Counter
		timerWroughtChaosCD:Start()
		updateAllTimers(self, 7)
	elseif spellId == 183864 then
		timerShadowBlastCD:Start(args.sourceGUID)
	elseif spellId == 190506 then
		self.vb.seethingCorruptionCount = self.vb.seethingCorruptionCount + 1
		specWarnSeethingCorruption:Show(self.vb.seethingCorruptionCount)
		local cooldown = seethingCorruptionTimers[self.vb.seethingCorruptionCount+1]
		if cooldown then
			timerSeethingCorruptionCD:Start(cooldown, self.vb.seethingCorruptionCount+1)
			countdownSeethingCorruption:Start(cooldown)
		end
		voiceSeethingCorruption:Play("watchstep")
	elseif spellId == 184931 then
		table.wipe(shacklesTargets)
		self.vb.tormentCast = self.vb.tormentCast + 1
		if self.vb.phase < 3 then
			timerShackledTormentCD:Start(36.5, self.vb.tormentCast+1)
			countdownShackledTorment:Start(36.5)
		else
			timerShackledTormentCD:Start(31, self.vb.tormentCast+1)
			countdownShackledTorment:Start(31)
		end
		updateAllTimers(self, 7, true)
	elseif spellId == 187180 then
		self.vb.demonicCount = self.vb.demonicCount + 1
		if not playerBanished or not self.Options.FilterOtherPhase then
			specWarnDemonicFeedback:Show(self.vb.demonicCount)
			voiceDemonicFeedback:Play("scatter")
		end
		timerDemonicFeedbackCD:Start(nil, self.vb.demonicCount+1)
		countdownDemonicFeedback:Start()
		updateAllTimers(self, 3.5)
	elseif spellId == 182225 then
		self.vb.rainOfChaos = self.vb.rainOfChaos + 1
		if not playerBanished or not self.Options.FilterOtherPhase then
			specWarnRainofChaos:Show(self.vb.rainOfChaos)
		end
		timerRainofChaosCD:Start(nil, self.vb.rainOfChaos+1)
		if self.vb.phase < 3.5 then
			self.vb.phase = 3.5
		end
	elseif spellId == 190050 then
		--To ensure propper syncing and everyones mod has same count, the count isn't in the filter
		if self.vb.TouchOfShadows == 2 then self.vb.TouchOfShadows = 0 end
		self.vb.TouchOfShadows = self.vb.TouchOfShadows + 1
		--Actual interrupt is filtered of course.
		if self:CheckInterruptFilter(args.sourceGUID) and playerBanished then
			local count = self.vb.TouchOfShadows
			specWarnTouchofShadows:Show(args.sourceName, count)
			if count == 1 then
				voiceTouchofShadows:Play("kick1r")
			else
				voiceTouchofShadows:Play("kick2r")
			end
		end
	elseif spellId == 190394 then
		if self:AntiSpam(15, 4) then
			self.vb.darkConduitSpawn = 0
			self.vb.darkConduitCast = self.vb.darkConduitCast + 1
			self:Schedule(8, setDarkConduit, self, true)--Clear current dark conduit radar after 8 seconds (it take 5 seconds for all 3 to spawn)
			voiceDarkConduit:Play("watchstep")
			local cooldown = darkConduitTimers[self.vb.darkConduitCast+1]
			if cooldown then
				timerDarkConduitCD:Start(cooldown, self.vb.darkConduitCast+1)
				self:Schedule(cooldown-8, setDarkConduit, self)--Show radar 8 seconds before next dark conduit
			end
		end
		self.vb.darkConduitSpawn = self.vb.darkConduitSpawn + 1
		warnDarkConduit:Show(self.vb.darkConduitSpawn)
	elseif spellId == 190686 then--Summon source of chaos
		--Cancel sourceOfChaosCheck, spell cast on time
		self:Unschedule(sourceOfChaosCheck)
		self.vb.sourceOfChaosCast = self.vb.sourceOfChaosCast + 1
		specWarnSourceofChaos:Show(self.vb.sourceOfChaosCast)
		local cooldown = sourceofChaosTimers[self.vb.sourceOfChaosCast+1]
		if cooldown then
			timerSourceofChaosCD:Start(cooldown, self.vb.sourceOfChaosCast+1)
			countdownSourceofChaos:Start(cooldown)
			--Schedule Late check for 5 seconds AFTER cast
			self:Schedule(cooldown+5, sourceOfChaosCheck, self)
		end
	elseif spellId == 190821 then--Stars
		self.vb.twistedDarknessCast = self.vb.twistedDarknessCast + 1
		specWarnTwistedDarkness:Show(self.vb.twistedDarknessCast)
		local cooldown = twistedDarknessTimers[self.vb.twistedDarknessCast+1]
		if cooldown then
			timerTwistedDarknessCD:Start(cooldown, self.vb.twistedDarknessCast+1)
		end
	elseif spellId == 186663 and self:AntiSpam(2, 9) then
		specWarnFlamesOfArgus:Show(args.sourceName)
		voiceFlamesofArgus:Play("kickcast")
	elseif spellId == 188514 then
		table.wipe(legionTargets)
	elseif spellId == 186961 then
		self.vb.netherBanish2 = self.vb.netherBanish2 + 1
		timerNetherBanishCD:Start(nil, self.vb.netherBanish2+1)
--		updateAllTimers(self, 7)--Inconclusive logs. Could not find any data supporting this extention
	elseif spellId == 190313 then
		playerBanished = true
		timerAllureofFlamesCD:Cancel()--Done for rest of fight
		timerDeathbrandCD:Cancel()--Done for rest of fight
		timerShackledTormentCD:Cancel()--Resets to 55 on non mythic, no longer cast on mythic
		countdownShackledTorment:Cancel()
		countdownDeathBrand:Cancel()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 187180 then
		self.vb.demonicFeedback = false
		self:Schedule(28, setDemonicFeedback, self)
	elseif spellId == 188514 then
		self.vb.markOfLegionCast = self.vb.markOfLegionCast + 1
		table.wipe(legionTargets)
		local cooldown = legionTimers[self.vb.markOfLegionCast+1]
		if cooldown then
			timerMarkOfLegionCD:Start(cooldown, self.vb.markOfLegionCast+1)
		end
	elseif spellId == 183254 then
		specWarnAllureofFlames:Show()
		voiceAllureofFlames:Play("watchstep")
	elseif spellId == 185590 then
		timerLightCD:Start()
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
		felburstTargets[#felburstTargets+1] = args.destName
		self:Unschedule(showFelburstTargets)
		self:Schedule(0.3, showFelburstTargets, self)--Change to 0.5 for laggy users?
		if args:IsPlayer() then
			specWarnFelBurst:Show()
		else
			if self:CheckNearby(30, args.destName) and not UnitDebuff("player", args.spellName) and not self:IsTank() then--Range subject to adjustment
				specWarnFelBurstNear:CombinedShow(0.3, args.destName)--Combined show to prevent spam in a spread, if a spread happens targets are all together and requires even MORE people to soak.
				voiceFelBurst:Cancel()--Avoid spam
				voiceFelBurst:Schedule(0.3, "gathershare")
			end
		end
		if self.Options.HudMapOnFelBurst2 then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 8, 5, nil, nil, nil, 0.5):Appear():SetLabel(args.destName)
		end
	elseif spellId == 184964 then
		shacklesTargets[#shacklesTargets+1] = args.destName
		self.vb.unleashedCountRemaining = self.vb.unleashedCountRemaining + 1
		self:Unschedule(breakShackles)
		if #shacklesTargets == 3 then
			breakShackles(self, args.spellName)
		else
			self:Schedule(0.5, breakShackles, self, args.spellName)
		end
	elseif spellId == 186123 then--Wrought Chaos
		if self:AntiSpam(3, 3) then
			self.vb.wroughtWarned = self.vb.wroughtWarned + 1
			if self:IsMythic() and self:AntiSpam(20, 7) and self:IsAlive() then
				--Only warn once on mythic instead of spamming it, since you always get all of them
				specWarnWroughtChaos:Show()
				voiceWroughtChaos:Play("186123")
			end
		end
		if args:IsPlayer() then
			if not self:IsMythic() then
				specWarnWroughtChaos:Show()
				voiceWroughtChaos:Play("186123")
				yellWroughtChaos:Yell()
				countdownWroughtChaos:Start()
			else
				countdownWroughtChaos:Start(6)
			end
		end
		if not playerBanished or not self.Options.FilterOtherPhase then
			if not self:IsMythic() then
				warnWroughtChaos:CombinedShow(0.3, self.vb.wroughtWarned, args.destName)
			end
		end
	elseif spellId == 185014 then--Focused Chaos
		if args:IsPlayer() then
			if not self:IsMythic() then
				specWarnFocusedChaos:Show()
				voiceFocusedChaos:Play("185014")
				yellFocusedChaos:Yell(5)
				yellFocusedChaos:Schedule(3, 2)
				yellFocusedChaos:Schedule(2, 3)
				yellFocusedChaos:Schedule(1, 4)
				countdownWroughtChaos:Start()
			else
				countdownWroughtChaos:Start(6)
			end
		end
		if not playerBanished or not self.Options.FilterOtherPhase then
			local time = 5
			if not self:IsMythic() then
				warnWroughtChaos:CombinedShow(0.3, self.vb.wroughtWarned, args.destName)
			else
				time = 6
			end
			if self.Options.HudMapOnWrought then
				local sourceUId, destUId = DBM:GetRaidUnitId(args.sourceName), DBM:GetRaidUnitId(args.destName)
				if not sourceUId or not destUId then return end--They left raid? prevent nil error. this will probably only happen in LFR
				if UnitIsUnit("player", sourceUId) or UnitIsUnit("player", destUId) then--Player is in connection, green line
					--create points for your own line
					warnWroughtChaos:CombinedShow(0.1, self.vb.wroughtWarned, args.sourceName)
					warnWroughtChaos:CombinedShow(0.1, self.vb.wroughtWarned, args.destName)
					if UnitIsUnit("player", sourceUId) then
						if self.Options.NamesWroughtHud then
							DBMHudMap:RegisterRangeMarkerOnPartyMember(186123, "party", args.sourceName, 0.9, time, nil, nil, nil, 1, nil, false):Appear()--Players own dot bigger (no label on player dot)
							DBMHudMap:RegisterRangeMarkerOnPartyMember(185014, "party", args.destName, 0.5, time, nil, nil, nil, 0.5, nil, false):Appear():SetLabel(args.destName, nil, nil, nil, nil, nil, 0.8, nil, -13, 10, nil)
						else
							DBMHudMap:RegisterRangeMarkerOnPartyMember(186123, "party", args.sourceName, 0.9, time, nil, nil, nil, 1, nil, false):Appear()--Players own dot bigger
							DBMHudMap:RegisterRangeMarkerOnPartyMember(185014, "party", args.destName, 0.5, time, nil, nil, nil, 0.5, nil, false):Appear()
						end
					else
						if self.Options.NamesWroughtHud then
							DBMHudMap:RegisterRangeMarkerOnPartyMember(186123, "party", args.sourceName, 0.5, time, nil, nil, nil, 0.5, nil, false):Appear():SetLabel(args.sourceName, nil, nil, nil, nil, nil, 0.8, nil, -13, 10, nil)
							DBMHudMap:RegisterRangeMarkerOnPartyMember(185014, "party", args.destName, 0.9, time, nil, nil, nil, 1, nil, false):Appear()--Players own dot bigger (no label on player dot)
						else
							DBMHudMap:RegisterRangeMarkerOnPartyMember(186123, "party", args.sourceName, 0.5, time, nil, nil, nil, 0.5, nil, false):Appear()
							DBMHudMap:RegisterRangeMarkerOnPartyMember(185014, "party", args.destName, 0.9, time, nil, nil, nil, 1, nil, false):Appear()--Players own dot bigger
						end
					end
					--create line
					if self.Options.ExtendWroughtHud3 then
					--	if self.Options.AlternateHudLine then
					--		DBMHudMap:AddEdge(0, 1, 0, 0.5, time, args.sourceName, args.destName, nil, nil, nil, nil, 25, "beam1", true)
					--	else
							DBMHudMap:AddEdge(0, 1, 0, 0.5, time, args.sourceName, args.destName, nil, nil, nil, nil, 150, nil, true)
					--	end
					else
					--	if self.Options.AlternateHudLine then
					--		DBMHudMap:AddEdge(0, 1, 0, 0.5, time, args.sourceName, args.destName, nil, nil, nil, nil, 25, "beam1")
					--	else
							DBMHudMap:AddEdge(0, 1, 0, 0.5, time, args.sourceName, args.destName, nil, nil, nil, nil, 150)
					--	end
					end
				else--red lines for non player lines
					--Create Points
					if self.Options.NamesWroughtHud then
						DBMHudMap:RegisterRangeMarkerOnPartyMember(186123, "party", args.sourceName, 0.5, time, nil, nil, nil, 0.5, nil, false):Appear():SetLabel(args.sourceName, nil, nil, nil, nil, nil, 0.8, nil, -13, 10, nil)
						DBMHudMap:RegisterRangeMarkerOnPartyMember(185014, "party", args.destName, 0.5, time, nil, nil, nil, 0.5, nil, false):Appear():SetLabel(args.destName, nil, nil, nil, nil, nil, 0.8, nil, -13, 10, nil)
					else
						DBMHudMap:RegisterRangeMarkerOnPartyMember(186123, "party", args.sourceName, 0.5, time, nil, nil, nil, 0.5, nil, false):Appear()
						DBMHudMap:RegisterRangeMarkerOnPartyMember(185014, "party", args.destName, 0.5, time, nil, nil, nil, 0.5, nil, false):Appear()
					end
					--Create Line
					if self.Options.ExtendWroughtHud3 then
					--	if self.Options.AlternateHudLine then
					--		DBMHudMap:AddEdge(1, 0, 0, 0.5, time, args.sourceName, args.destName, nil, nil, nil, nil, 25, "beam1", true)
					--	else
							DBMHudMap:AddEdge(1, 0, 0, 0.5, time, args.sourceName, args.destName, nil, nil, nil, nil, 150, nil, true)
					--	end
					else
						DBMHudMap:AddEdge(1, 0, 0, 0.5, time, args.sourceName, args.destName, nil, nil, nil, nil, 150)
					end
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
		self.vb.TouchOfShadows = 0
		countdownNetherBanish:Start()
		if args:IsPlayer() then
			specWarnNetherBanish:Show()
			voiceNetherBanish:Play("teleyou")
			yellNetherBanish:Schedule(6, 1)
			yellNetherBanish:Schedule(5, 2)
			yellNetherBanish:Schedule(4, 3)
			yellNetherBanish:Schedule(3, 4)
			yellNetherBanish:Schedule(2, 5)
		else
			voiceNetherBanish:Play("telesoon")
			specWarnNetherBanishOther:Show(self.vb.netherBanish2, args.destName)
		end
		updateRangeFrame(self)
	elseif spellId == 189895 then
		if (playerBanished or not self.Options.FilterOtherPhase) then
			warnVoidStarFixate:CombinedShow(0.3, args.destName)--5 on mythic
		end
		if args:IsPlayer() then
			specWarnVoidStarFixate:Show()
			yellVoidStarFixate:Yell()
			voiceVoidStarFixate:Play("orbrun")
		end
	elseif spellId == 186662 then--Felborne Overfiend Spawn
		self.vb.overfiendCount = self.vb.overfiendCount + 1
		warnOverfiend:Show(self.vb.overfiendCount)
		timerFelborneOverfiendCD:Start(nil, self.vb.overfiendCount+1)
		if self.vb.phase < 2.5 then--First spawn is about 4 seconds after phase 2.5 trigger yell
			DBM:Debug("Phase 2.5 begin CLEU", 2)
			self.vb.phase = 2.5
		end
	elseif spellId == 186952 and args:IsPlayer() then
		playerBanished = true
		updateRangeFrame(self)
	elseif spellId == 187050 then
		self.vb.markOfLegionRemaining = self.vb.markOfLegionRemaining + 1
		legionTargets[#legionTargets+1] = args.destName
		self:Unschedule(showMarkOfLegion)
		if #legionTargets == 4 then
			showMarkOfLegion(self, args.spellName)
		else
			self:Schedule(0.5, showMarkOfLegion, self, args.spellName)
		end
		local uId = DBM:GetRaidUnitId(args.destName)
		local _, _, _, _, _, duration, expires, _, _ = UnitDebuff(uId, args.spellName)
		if expires then
			if args:IsPlayer() then
				local remaining = expires-GetTime()
				yellMarkOfLegion:Schedule(remaining-1, 1)
				yellMarkOfLegion:Schedule(remaining-2, 2)
				yellMarkOfLegion:Schedule(remaining-3, 3)
				yellMarkOfLegion:Schedule(remaining-4, 4)
				yellMarkOfLegion:Schedule(remaining-5, 5)
			end
		end
		updateRangeFrame(self)
		if self.Options.InfoFrame and self.vb.markOfLegionRemaining == 1 then--coming from 0, open infoframe
			DBM:Debug("Mark of Legion InfoFrame should be opening")
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(4, "playerdebuffremaining", args.spellName)
		end
	elseif spellId == 190703 then
		if args:IsPlayer() then
			specWarnSourceofChaosYou:Show()
			yellSourceofChaos:Yell()
		end
	elseif spellId == 187255 and args:IsPlayer() and self:AntiSpam(2, 2) then
		specWarnNetherStorm:Show()
	elseif spellId == 183963 and args:IsPlayer() and self:AntiSpam(5, 6) then
		warnLight:Show()
	elseif spellId == 183586 and args:IsPlayer() then
		local amount = args.amount or 1
		warnDoomFireStack:Cancel()--Just a little anti spam
		warnDoomFireStack:Schedule(2, args.destName, amount)
		yellDoomFireFades:Cancel()
		local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
		if expires then
			if args:IsPlayer() then
				local remaining = expires-GetTime()
				yellDoomFireFades:Schedule(remaining-1, 1)
				yellDoomFireFades:Schedule(remaining-2, 2)
				yellDoomFireFades:Schedule(remaining-3, 3)
			end
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
	elseif spellId == 183634 then
		if self.Options.HudMapOnFelBurst2 then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
		if self.Options.SetIconOnFelBurst then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 186961 then
		self.vb.netherPortal = false
		updateRangeFrame(self)
	elseif spellId == 186952 and args:IsPlayer() then
		playerBanished = false
		updateRangeFrame(self)
	elseif spellId == 184964 then
		self.vb.unleashedCountRemaining = self.vb.unleashedCountRemaining - 1
		if (not playerBanished or not self.Options.FilterOtherPhase) and not self:IsLFR() then
			warnUnleashedTorment:Show(self.vb.unleashedCountRemaining)
		end
		if self.Options.SetIconOnShackledTorment2 then
			self:SetIcon(args.destName, 0)
		end
		if self.Options.HudMapOnShackledTorment2 and self:IsMythic() then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
			if self.vb.unleashedCountRemaining == 0 then--none remaining, remove players shackle
				DBMHudMap:FreeEncounterMarkerByTarget(1849642, playerName)
			end
		end
	elseif spellId == 187050 then
		self.vb.markOfLegionRemaining = self.vb.markOfLegionRemaining - 1
		if args:IsPlayer() then
			yellMarkOfLegion:Cancel()
		end
		updateRangeFrame(self)
		if self.Options.SetIconOnMarkOfLegion2 then
			self:SetIcon(args.destName, 0)
		end
		if self.Options.HudMapMarkofLegion then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
		if self.Options.InfoFrame and self.vb.markOfLegionRemaining == 0 then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 183586 and args:IsPlayer() then
		warnDoomFireStack:Cancel()
		yellDoomFireFades:Cancel()
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 187108 then--Infernal Doombringer Spawn
		if self:AntiSpam(15, 5) and self:IsMythic() then
			self.vb.InfernalsCast = self.vb.InfernalsCast + 1
			specWarnInfernals:Show(self.vb.InfernalsCast)
			local cooldown = infernalTimers[self.vb.InfernalsCast+1]
			if cooldown then
				timerInfernalsCD:Start(cooldown, self.vb.InfernalsCast+1)
			end
		end
		if self.Options.SetIconOnInfernals2 then
			if self.vb.InfernalsCast < 3 or not self:IsMythic() then--Only 3 infernals expected
				self:ScanForMobs(args.destGUID, 1, 1, 3, 0.2, 20, "SetIconOnInfernals2")
			elseif self.vb.InfernalsCast < 6 then--4 infernals expected
				self:ScanForMobs(args.destGUID, 1, 1, 4, 0.2, 20, "SetIconOnInfernals2")
			else--5 expected
				self:ScanForMobs(args.destGUID, 1, 1, 5, 0.2, 20, "SetIconOnInfernals2")
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 92740 then--Hellfire Deathcaller
		timerShadowBlastCD:Cancel(args.destGUID)
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
--	"<143.60 23:47:14> [UNIT_SPELLCAST_SUCCEEDED] Archimonde(Stellar) [[boss1:Allow Phase 2 Spells::0:190117]]", -- [4158]
--	"<143.64 23:47:14> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#The light will not fail!#Exarch Yrel###Archimonde##0#0##0#2601#nil#0#false#false#false", 
--	"<148.61 23:47:19> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#I grow tired of this pointless game. You face the immortal Legion, scourge of a thousand worlds.#Archimond
--	"<149.68 23:47:20> [CLEU] SPELL_CAST_START#Creature-0-3023-1448-20662-91331-000010BEEC#Archimonde##nil#184265#Wrought Chaos#nil#nil", -- [4314]
	elseif spellId == 190117 then--Phase 2 trigger
		self.vb.phase = 2
		table.wipe(felburstTargets)--Just to reduce infoframe overhead
		--Cancel stuff only used in phase 1
		warnFelBurstSoon:Cancel()
		timerFelBurstCD:Cancel()
		timerDesecrateCD:Cancel()
		timerDoomfireCD:Cancel()
		--Cancel stuff that resets in phase 2
		timerAllureofFlamesCD:Cancel()
		timerDeathbrandCD:Cancel()
		countdownDeathBrand:Cancel()
		--Begin phase 2
		warnPhase2:Show()
		voicePhaseChange:Play("ptwo")
		if not self:IsFaceroll() then
			timerWroughtChaosCD:Start(5)
		end
		timerDeathbrandCD:Start(35, self.vb.deathBrandCount+1)--35-39
		countdownDeathBrand:Start(35)
		timerAllureofFlamesCD:Start(40)--40-45
		timerShackledTormentCD:Start(25, self.vb.tormentCast+1)--17-25 (almost always 25, but sometimes it comes earlier, unsure why)
		countdownShackledTorment:Start(25)
		updateRangeFrame(self)
--	"<301.70 23:49:52> [UNIT_SPELLCAST_SUCCEEDED] Archimonde(Omegal) [[boss1:Allow Phase 3 Spells::0:190118]]", -- [8737]
--	"<301.70 23:49:52> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Lok'tar ogar! They are pushed back! To the portal! Gul'dan is mine!#Grommash Hellscream###Grommash H
	elseif spellId == 190118 or spellId == 190310 then--Phase 3 trigger
		self.vb.phase = 3
		timerFelborneOverfiendCD:Cancel()
		warnPhase3:Show()
		voicePhaseChange:Play("pthree")
		if not self:IsMythic() then
			timerAllureofFlamesCD:Cancel()--Done for rest of fight
			timerDeathbrandCD:Cancel()--Done for rest of fight
			timerShackledTormentCD:Cancel()--Resets to 55 on non mythic, no longer cast on mythic
			countdownShackledTorment:Cancel()
			countdownDeathBrand:Cancel()
			timerNetherBanishCD:Start(10.9, 1)
			countdownNetherBanish:Start(10.9)
			timerDemonicFeedbackCD:Start(29, 1)--29-33
			self:Schedule(23.5, setDemonicFeedback, self)
			countdownDemonicFeedback:Start(29)
			timerShackledTormentCD:Start(55, self.vb.tormentCast+1)
			countdownShackledTorment:Start(55)
		else
			table.wipe(shacklesTargets)--Just to reduce infoframe overhead
			timerWroughtChaosCD:Cancel()
			timerDarkConduitCD:Start(8, 1)
			setDarkConduit(self)
			timerMarkOfLegionCD:Start(20, 1)
			timerInfernalsCD:Start(35, 1)
			countdownSourceofChaos:Start(49)
			timerSourceofChaosCD:Start(49, 1)
			timerSeethingCorruptionCD:Start(61, 1)
			countdownSeethingCorruption:Start(61)
			timerTwistedDarknessCD:Start(75, 1)
			if UnitIsGroupLeader("player") then
				if self.Options.MarkBehavior == "Numbered" then
					self:SendSync("Numbered")
				elseif self.Options.MarkBehavior == "LocSmallFront" then
					self:SendSync("LocSmallFront")
				elseif self.Options.MarkBehavior == "LocSmallBack" then
					self:SendSync("LocSmallBack")
				elseif self.Options.MarkBehavior == "NoAssignment" then
					self:SendSync("NoAssignment")
				end
			end
		end
	end
end

function mod:OnSync(msg)
	if msg == "phase25" and self.vb.phase < 2.5 then
		DBM:Debug("Phase 2.5 begin yell", 2)
		self.vb.phase = 2.5
	elseif msg == "Numbered" then
		self.vb.MarkBehavior = "Numbered"
	elseif msg == "LocSmallFront" then
		self.vb.MarkBehavior = "LocSmallFront"
	elseif msg == "LocSmallBack" then
		self.vb.MarkBehavior = "LocSmallBack"
	elseif msg == "NoAssignment" then
		self.vb.MarkBehavior = "NoAssignment"
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 187255 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnNetherStorm:Show()
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
