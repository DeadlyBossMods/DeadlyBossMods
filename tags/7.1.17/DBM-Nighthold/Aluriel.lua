local mod	= DBM:NewMod(1751, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(104881)
mod:SetEncounterID(1871)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(15984)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 213853 213567 213564 213852 212735 213390 213083 212492 230504",
	"SPELL_CAST_SUCCESS 230403 212492 213275",
	"SPELL_AURA_APPLIED 213864 216389 213867 213869 212531 213148 213569 212587 230951 213760 213808 212647",
	"SPELL_AURA_APPLIED_DOSE 212647",
	"SPELL_AURA_REMOVED 213569 212531 213148 230951 212587",
	"SPELL_PERIODIC_DAMAGE 212736 213278 213504 230414",
	"SPELL_PERIODIC_MISSED 212736 213278 213504 230414",
	"SPELL_DAMAGE 213520",
	"SPELL_MISSED 213520",
	"UNIT_AURA player",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, possibly dump UNIT_AURA unless that proves to actualy be better way to manage range frame
--TODO, add fixate on mythic. No debuff. Player sees eyes but no debuff. Might have to do nameplate/accro target scanning to warn who has it
--TODO, probably fix more timers. Especially mythic fire and arcane.
--[[
(ability.id = 213853 or ability.id = 213567 or ability.id = 213564 or ability.id = 213852 or ability.id = 212735 or ability.id = 213275 or ability.id = 213390 or ability.id = 213083 or ability.id = 212492 or ability.id = 230951 or ability.id = 230504) and type = "begincast" or
ability.id = 230403 and type = "cast" or
(ability.id = 213864 or ability.id = 216389 or ability.id = 213867 or ability.id = 213869) and type = "applybuff" or
(ability.id = 212531 or ability.id = 213148) and type = "applydebuff" or
ability.id = 230951 and type = "removebuff" or ability.id = 230414
--]]
--Phases
local warnFrostPhase				= mod:NewSpellAnnounce(213864, 2)
local warnFirePhase					= mod:NewSpellAnnounce(213867, 2)
local warnArcanePhase				= mod:NewSpellAnnounce(213869, 2)
--Debuffs
local warnMarkOfFrostChosen			= mod:NewTargetAnnounce(212531, 3)
local warnSearingBrandChosen		= mod:NewTargetAnnounce(213148, 3)
--Animate Specials Temp, to avoid spam
local warnFrozenTempest				= mod:NewCastAnnounce(213083, 4)
local warnArmageddon				= mod:NewAddsLeftAnnounce(213568, 2)
--Mythic
local warnFelSoul					= mod:NewSpellAnnounce(230951, 3)

local specWarnAnnihilate			= mod:NewSpecialWarningCount(212492, "Tank", nil, nil, 3, 2)
local specWarnAnnihilateOther		= mod:NewSpecialWarningTaunt(212492, nil, nil, nil, 1, 2)
--Debuffs
local specWarnMarkOfFrost			= mod:NewSpecialWarningYou(212531, nil, nil, nil, 1, 2)
local yellMarkofFrost				= mod:NewYell(212531)
local specWarnFrostbitten			= mod:NewSpecialWarningStack(212647, nil, 6, nil, nil, 1, 6)
local specWarnSearingBrand			= mod:NewSpecialWarningMoveAway(213148, nil, nil, nil, 1, 2)
local specWarnSearingBrandDodge		= mod:NewSpecialWarningDodge(213148, nil, nil, nil, 2, 6)
local specWarnArcaneOrb				= mod:NewSpecialWarningDodge(213519, nil, nil, nil, 2, 2)
--Detonates
local specWarnFrostdetonate			= mod:NewSpecialWarningMoveAway(212735, nil, nil, nil, 3, 2)
local yellFrostDetonate				= mod:NewYell(212735, 29870)--29870 "Detonate" short name
local specWarnFireDetonate			= mod:NewSpecialWarningMoveAway(213275, nil, nil, nil, 3, 2)
local yellFireDetonate				= mod:NewYell(213275, 29870)--29870 "Detonate" short name
local specWarnArcaneDetonate		= mod:NewSpecialWarningDodge(213390, nil, nil, nil, 3, 2)
--GTFOs
local specWarnPoolOfFrost			= mod:NewSpecialWarningMove(212736, nil, nil, nil, 1, 2)
local specWarnBurningGround			= mod:NewSpecialWarningMove(213278, nil, nil, nil, 1, 2)
local specWarnArcaneFog				= mod:NewSpecialWarningMove(213504, nil, nil, nil, 1, 2)--Fog and orbs combined for simplicity
local specWarnFelStomp				= mod:NewSpecialWarningMove(230414, nil, nil, nil, 1, 2)--Mythic
--Animates
local specWarnAnimateFrost			= mod:NewSpecialWarningSwitch(213853, "-Healer", nil, nil, 1, 2)--Currently spell ID does not contain "animate" in name, which makes warning confusing. Hopefully blizzard fixes
local specWarnAnimateFire			= mod:NewSpecialWarningSwitch(213567, "-Healer", nil, nil, 1, 2)
local specWarnAnimateArcane			= mod:NewSpecialWarningSwitch(213564, "-Healer", nil, nil, 1, 2)
--Mythic
local specWarnDecimate				= mod:NewSpecialWarningSpell(230504, nil, nil, nil, 1, 2)
local specWarnFelLash				= mod:NewSpecialWarningSoon(230403, nil, nil, nil, 1, 2)

local timerFrostPhaseCD				= mod:NewNextTimer(80, 213864, nil, nil, nil, 6)
local timerFirePhaseCD				= mod:NewNextTimer(85, 213867, nil, nil, nil, 6)
local timerArcanePhaseCD			= mod:NewNextTimer(85, 213869, nil, nil, nil, 6)
local timerAnnihilateCD				= mod:NewNextCountTimer(40, 212492, nil, "Tank", nil, 5, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_TANK_ICON)
--Debuffs
local timerMarkOfFrostCD			= mod:NewNextTimer(16, 212531, nil, nil, nil, 3)
local timerSearingBrandCD			= mod:NewNextTimer(16, 213148, nil, nil, nil, 3)
local timerArcaneOrbCD				= mod:NewNextTimer(11.5, 213519, nil, nil, nil, 3)
--Replicates
local timerMarkOfFrostRepCD			= mod:NewNextTimer(16, 212530, 160324, nil, nil, 3)--Short name "Replicate"
local timerSearingBrandRepCD		= mod:NewNextTimer(16, 213182, 160324, nil, nil, 3)--Short name "Replicate"
local timerArcaneOrbRepCD			= mod:NewNextTimer(14.5, 213852, 160324, nil, nil, 3)--Short name "Replicate"
--Detonates
local timerMarkOfFrostDetonateCD	= mod:NewNextTimer(16, 212735, 29870, nil, nil, 3, nil, DBM_CORE_HEALER_ICON)--Short name "Detonate"
local timerSearingBrandDetonateCD	= mod:NewNextTimer(16, 213275, 29870, nil, nil, 3, nil, DBM_CORE_HEALER_ICON)--Short name "Detonate"
local timerArcaneOrbDetonateCD		= mod:NewNextTimer(16, 213390, 29870, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_HEALER_ICON)--Short name "Detonate"
--Animates
local timerAnimateFrostCD			= mod:NewNextTimer(16, 213853, 124338, nil, nil, 1, 57612, DBM_CORE_TANK_ICON)--"Animated" short name. Wrong tense but only short spell I can use
local timerAnimateFireCD			= mod:NewNextTimer(16, 213567, 124338, nil, nil, 1, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_TANK_ICON)--"Animated" short name. Wrong tense but only short spell I can use
local timerAnimateArcaneCD			= mod:NewNextTimer(16, 213564, 124338, nil, nil, 1, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_DAMAGE_ICON..DBM_CORE_TANK_ICON)--"Animated" short name. Wrong tense but only short spell I can use
--Animate Specials
local timerArmageddon				= mod:NewCastTimer(33, 213568, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
--Mythic
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerFelSoulCD				= mod:NewNextTimer(15, 230951, nil, nil, nil, 1, nil, DBM_CORE_HEROIC_ICON)
local timerFelSoul					= mod:NewBuffActiveTimer(45, 230951, nil, nil, nil, 6)
local timerDecimateCD				= mod:NewCDTimer(17, 230504, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--17-20 (Tank timer by default, holy/ret/etc that's doing taunting will have to enable by default)
local timerFelStompCD				= mod:NewNextTimer(25, 230414, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
local timerFelLashCD				= mod:NewNextCountTimer(25, 230403, nil, nil, nil, 2, nil, DBM_CORE_HEROIC_ICON)

local berserkTimer					= mod:NewBerserkTimer(600)--480

local countdownFelLash				= mod:NewCountdown(8, 230403)
local countdownMarkOfFrost			= mod:NewCountdown("Alt30", 212531, nil, nil, 3)
local countdownSearingBrand			= mod:NewCountdown("Alt30", 213148, nil, nil, 3)
local countdownAnnihilate			= mod:NewCountdown("Alt30", 212492, "Tank")
local countdownArmageddon			= mod:NewCountdown("AltTwo33", 213568)

local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceAnnihilate				= mod:NewVoice(212492, "Tank")--defensive/tauntboss
--Debuffs
local voiceMarkOfFrost				= mod:NewVoice(212531)--scatter/??? (??? not used yet, need to determine stacks for grouping up to clear then make voice maybe that says "stand near another mark of frost" maybe?)
local voiceFrostbitten				= mod:NewVoice(212647)--stackhigh
local voiceSearingBrand				= mod:NewVoice(213148)--scatter/farfromline
local voiceArcaneOrb				= mod:NewVoice(213519)--watchorb
--Detonates
local voiceFrostDetonate			= mod:NewVoice(212735)--runout
local voiceFireDetonate				= mod:NewVoice(213275)--runout
local voiceArcaneDetonate			= mod:NewVoice(213390)--watchorb
--GTFOs
local voicePoolOfFrost				= mod:NewVoice(212736)--runaway
local voiceBurningGround			= mod:NewVoice(213278)--runaway
local voiceArcaneFog				= mod:NewVoice(213504)--runaway
local voiceFelStomp					= mod:NewVoice(230414)--runaway
--Animates
local voiceAnimateFrost				= mod:NewVoice(213853)--mobsoon
local voiceAnimateFire				= mod:NewVoice(213567)--mobsoon
local voiceAnimateArcane			= mod:NewVoice(213564)--mobsoon
--Mythic
local voiceDecimate					= mod:NewVoice(230504)--carefly
local voiceFelLash					= mod:NewVoice(230403)--gathershare

mod:AddRangeFrameOption("8")
mod:AddHudMapOption("HudMapOnBrandCharge", 213166)
mod:AddSetIconOption("SetIconOnFrozenTempest", 213083, true, true)
mod:AddSetIconOption("SetIconOnSearingDetonate", 213275, true)
mod:AddSetIconOption("SetIconOnBurstOfFlame", 213760, true, true)
mod:AddSetIconOption("SetIconOnBurstOfMagic", 213808, true, true)
mod:AddNamePlateOption("NPAuraOnMarkOfFrost", 212531)
mod:AddInfoFrameOption(212647)

mod.vb.annihilateCount = 0
mod.vb.armageddonAdds = 0
mod.vb.felLashCount = 0
local MarkOfFrostDebuff = GetSpellInfo(212587)
local SearingBrandDebuff = GetSpellInfo(213166)
local annihilatedDebuff = GetSpellInfo(215458)
local rangeShowAll = false
local chargeTable = {}
local annihilateTimers = {8.0, 45.0, 40.0, 44.0, 38.0, 37.0, 33.0, 47.0, 41.0, 44.0, 38.0, 37.0, 33.0}--Need longer pulls/more data. However this pattern did prove to always be same
local mythicAnnihilateTimers = {8, 46, 30, 37, 35, 43, 27, 37, 41, 37, 35, 43, 27}
local felLashTimers = {21, 10.9, 6, 12, 6}
local searingDetonateIcons = {}

local debuffFilter
local UnitDebuff = UnitDebuff
do
	debuffFilter = function(uId)
		if UnitDebuff(uId, MarkOfFrostDebuff) or UnitDebuff(uId, SearingBrandDebuff) then
			return true
		end
	end
end

--TODO, if Elisande method is superior, switch to it to speed up line drawing.
local function hudDelay(self)
	local currentTank = self:GetCurrentTank()
	if not UnitDebuff("player", SearingBrandDebuff) then
		specWarnSearingBrandDodge:Show()
		voiceSearingBrand:Play("farfromline")
	end
	if not currentTank then
		DBM:Debug("Tank Detection Failure in hudDelay", 2)
		return
	end
	DBMHudMap:RegisterRangeMarkerOnPartyMember(213166, "party", UnitName("player"), 0.7, 5, nil, nil, nil, 1, nil, false):Appear()--Create Player Dot
	for i = 1, #chargeTable do
		local name = chargeTable[i]
		DBMHudMap:RegisterRangeMarkerOnPartyMember(213166, "party", name, 0.35, 5, nil, nil, nil, 0.5, nil, false):Appear():SetLabel(name, nil, nil, nil, nil, nil, 0.8, nil, -13, 8, nil)
		DBMHudMap:AddEdge(1, 0, 0, 0.5, 5, currentTank, name, nil, nil, nil, nil, 125)
	end
end

local function findSearingMark(self)
	if UnitDebuff("player", SearingBrandDebuff) then
		specWarnFireDetonate:Show()
		voiceFireDetonate:Play("runout")
		yellFireDetonate:Yell()
	end
	table.wipe(searingDetonateIcons)
	if self.Options.SetIconOnSearingDetonate then
		for uId in DBM:GetGroupMembers() do
			if UnitDebuff(uId, SearingBrandDebuff) then
				local name = DBM:GetUnitFullName(uId)
				searingDetonateIcons[#searingDetonateIcons+1] = name
				self:SetIcon(name, #searingDetonateIcons, 3)
			end
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.annihilateCount = 0
	self.vb.armageddonAdds = 0
	timerAnnihilateCD:Start(8-delay, 1)
	countdownAnnihilate:Start(8-delay)
	--Rest of timers are triggered by frost buff 0.1 seconds into pull
	table.wipe(chargeTable)
	table.wipe(searingDetonateIcons)
	rangeShowAll = false
	if self:IsMythic() then
		self.vb.felLashCount = 0
		berserkTimer:Start(450)
	elseif self:IsEasy() then
		berserkTimer:Start(-delay)--600 confirmed on normal (needs reconfirm on live)
	else
		berserkTimer:Start(480-delay)--480 confirmed on heroic (needs reconfirm on live)
	end
	if self.Options.NPAuraOnMarkOfFrost then
		DBM:FireEvent("BossMod_EnableFriendlyNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnBrandCharge then
		DBMHudMap:Disable()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnMarkOfFrost then
		DBM.Nameplate:Hide(false, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 213853 then--Mark of Frost (Animate)
		specWarnAnimateFrost:Show()
		voiceAnimateFrost:Play("mobsoon")--using this trigger, mobsoon
	elseif spellId == 213567 then--Animate: Searing Brand
		specWarnAnimateFire:Show()
		voiceAnimateFire:Play("mobsoon")
	elseif spellId == 213564 then--Animate: Arcane Orb
		specWarnAnimateArcane:Show()
		voiceAnimateArcane:Play("mobsoon")
		if not self:IsEasy() then
			timerArmageddon:Start()
			countdownArmageddon:Start()
		end
	elseif spellId == 213852 then--Replicate: Arcane Orb
		specWarnArcaneOrb:Show()
		voiceArcaneOrb:Play("watchorb")
	elseif spellId == 212735 then--Detonate: Mark of Frost
		if UnitDebuff("player", MarkOfFrostDebuff) then
			specWarnFrostdetonate:Show()
			voiceFrostDetonate:Play("runout")
			yellFrostDetonate:Yell()
		end
	elseif spellId == 213390 then--Detonate: Arcane Orb
		--specWarnArcaneDetonate:Show()
		--voiceArcaneDetonate:Play("watchorb")
		DBM:AddMsg("If you see this message it means blizzard fixed Detonate: Arcane Orb combat log trigger. Report this to DBM authors to improve mod. You may recieve double warnings on this spell until mod is updated.")
	elseif spellId == 213083 then--Frozen Tempest
		warnFrozenTempest:Show()
		if self.Options.SetIconOnFrozenTempest then
			self:ScanForMobs(args.sourceGUID, 2, 8, 1, 0.2, 10, "SetIconOnFrozenTempest")
		end
	elseif spellId == 212492 then--Annihilate
		local targetName, uId, bossuid = self:GetBossTarget(104881, true)
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			specWarnAnnihilate:Show(self.vb.annihilateCount+1)
			voiceAnnihilate:Play("defensive")
		else
			if not UnitDebuff("player", annihilatedDebuff) then
				specWarnAnnihilateOther:Schedule(4, targetName)
				voiceAnnihilate:Schedule(4, "tauntboss")
			end
		end
	elseif spellId == 230951 then
		warnFelSoul:Show()
		timerDecimateCD:Start(12.4)
	elseif spellId == 230504 then
		local targetName, uId, bossuid = self:GetBossTarget(115905)
		if bossuid then
			local tanking, status = UnitDetailedThreatSituation("player", bossuid)
			if tanking or (status == 3) then--Player is current target
				specWarnDecimate:Show()
				voiceDecimate:Play("carefly")
			end
		end
		timerDecimateCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 230403 then
		self.vb.felLashCount = self.vb.felLashCount + 1
		local timer = felLashTimers[self.vb.felLashCount+1]
		if timer then
			specWarnFelLash:Schedule(timer-3)
			voiceFelLash:Schedule(timer-3, "gathershare")
			timerFelLashCD:Start(timer, self.vb.felLashCount+1)
			countdownFelLash:Start(timer)
		end
	elseif spellId == 212492 then--Annihilate
		self.vb.annihilateCount = self.vb.annihilateCount + 1
		local nextCount = self.vb.annihilateCount+1
		local timer = self:IsMythic() and mythicAnnihilateTimers[nextCount] or annihilateTimers[nextCount]
		if timer then	
			timerAnnihilateCD:Start(timer-3, nextCount)
			countdownAnnihilate:Start(timer-3)
		end
		if nextCount == 6 and not self:IsMythic() then
			--Better place to start arcane orb timer since it's cast 1.5 seconds after arcane phase begins and this is last annihilate in fire phase
			timerArcaneOrbCD:Start()
		end
	elseif spellId == 213275 and self.Options.SetIconOnBurstOfFlame then--Detonate: Searing Brand
		self:ScanForMobs(107285, 0, 8, 6, 0.2, 12, "SetIconOnBurstOfFlame")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 213864 or spellId == 216389 then--Icy enchantment (Two versions for some reason, probably normal/lfr version and heroic/mythic)
		warnFrostPhase:Show()
		voicePhaseChange:Play("phasechange")
		if self:IsMythic() then
			timerFelSoulCD:Start(15)
			timerMarkOfFrostCD:Start(18)
			timerMarkOfFrostRepCD:Start(28)
			timerMarkOfFrostDetonateCD:Start(48)
			timerAnimateFrostCD:Start(65)
			timerFirePhaseCD:Start(75)
		else
			timerMarkOfFrostCD:Start(18)
			timerMarkOfFrostRepCD:Start(38)
			timerMarkOfFrostDetonateCD:Start(68)
			timerAnimateFrostCD:Start(75)
			timerFirePhaseCD:Start(85)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8, debuffFilter)
		end
		if self.Options.InfoFrame and not self:IsLFR() then
			DBM.InfoFrame:SetHeader(GetSpellInfo(212647))
			DBM.InfoFrame:Show(6, "playerdebuffstacks", 212647)
		end
	elseif spellId == 213867 then--Fiery Enchantment
		warnFirePhase:Show()
		voicePhaseChange:Play("phasechange")
		if self:IsMythic() then
			timerFelSoulCD:Start(15)
			timerSearingBrandCD:Start(17.8)
			timerFelStompCD:Start(25)
			timerSearingBrandRepCD:Start(27)
			self:Schedule(37, findSearingMark, self)--Schedule markers to go out 3 seconds before detonate cast, making a 6 total seconds to position instead of 3
			timerSearingBrandDetonateCD:Start(40)
			timerAnimateFireCD:Start(55)
			timerArcanePhaseCD:Start(75)
		else
			timerSearingBrandCD:Start(17.8)
			timerSearingBrandRepCD:Start(27)
			self:Schedule(42, findSearingMark, self)--Schedule markers to go out 3 seconds before detonate cast, making a 6 total seconds to position instead of 3
			timerSearingBrandDetonateCD:Start(45)
			timerAnimateFireCD:Start(62)
			timerArcanePhaseCD:Start(85)
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 213869 then--Magic Enchantment
		warnArcanePhase:Show()
		voicePhaseChange:Play("phasechange")
		if self:IsMythic() then
			self.vb.felLashCount = 0
			timerFelSoulCD:Start(12)
			--Arcane orb not started here, started somewhere else so timer is actually useful
			timerArcaneOrbRepCD:Start(15)
			specWarnFelLash:Schedule(18)
			voiceFelLash:Schedule(18, "gathershare")
			timerFelLashCD:Start(21, 1)
			countdownFelLash:Start(21)
			timerArcaneOrbDetonateCD:Start(35)--Not in combat log, So difficult to fix until transcriptor. Needs verification
			specWarnArcaneDetonate:Schedule(35)--^^
			voiceArcaneDetonate:Schedule(35, "watchorb")--^^
			timerAnimateArcaneCD:Start(55)--Oddly slightly longer on mythic than others
			timerFrostPhaseCD:Start(70)
		else
			--Arcane orb not started here, started somewhere else so timer is actually useful
			timerArcaneOrbRepCD:Start(15)
			timerArcaneOrbDetonateCD:Start(35)--Not in combat log, but this is when yell occurs
			specWarnArcaneDetonate:Schedule(35)
			voiceArcaneDetonate:Schedule(35, "watchorb")
			timerAnimateArcaneCD:Start(51.9)
			timerFrostPhaseCD:Start(70)
		end
		if self.Options.RangeFrame and self:IsRanged() then
			DBM.RangeCheck:Show(8)--Show everyone for better arcane orb spread
		else--Melee, kill range frame this phase
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 212531 then--Mark of Frost (5sec Targetting Debuff)
		warnMarkOfFrostChosen:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnMarkOfFrost:Show()
			voiceMarkOfFrost:Play("targetyou")
			countdownMarkOfFrost:Start(5)
			self:AntiSpam(7, args.destName)
			yellMarkofFrost:Yell()
		end
		if self.Options.NPAuraOnMarkOfFrost then
			DBM.Nameplate:Show(false, args.destName, spellId, nil, 5)
		end
	elseif spellId == 212587 then
		if args:IsPlayer() and self:AntiSpam(7, args.destName) then
			specWarnMarkOfFrost:Show()
			voiceMarkOfFrost:Play("targetyou")
			yellMarkofFrost:Yell()
		end
		if self.Options.NPAuraOnMarkOfFrost then
			DBM.Nameplate:Show(false, args.destName, spellId)
		end
	elseif spellId == 213148 then--Searing Brand (5sec Targetting Debuff)
		warnSearingBrandChosen:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSearingBrand:Show()
			voiceSearingBrand:Play("scatter")
			countdownSearingBrand:Start()
		end
		if self.Options.HudMapOnBrandCharge and not self:HasMapRestrictions() then
			self:Unschedule(hudDelay)
			if not tContains(args.destName, args.destName) then
				chargeTable[#chargeTable+1] = args.destName
			end
			self:Schedule(0.3, hudDelay, self)
		end
	elseif spellId == 213569 then--Armageddon Applied to mobs
		self.vb.armageddonAdds = self.vb.armageddonAdds + 1
	elseif spellId == 230951 then
		timerFelSoul:Start()
--	elseif spellId == 213760 and self.Options.SetIconOnBurstOfFlame then--Burst of Flame
		--self:ScanForMobs(args.destGUID, 0, 8, 6, 0.1, 10, "SetIconOnBurstOfFlame")
--	elseif spellId == 213808 and self.Options.SetIconOnBurstOfMagic then--Burst of Magic
		--self:ScanForMobs(args.destGUID, 0, 8, 8, 0.1, 12, "SetIconOnBurstOfMagic")
	elseif spellId == 212647 then
		local amount = args.amount or 1
		if args:IsPlayer() and amount % 2 == 0 and amount >= 6 then
			specWarnFrostbitten:Show(amount)
			voiceFrostbitten:Play("stackhigh")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 213569 then--Armageddon Applied to mobs
		self.vb.armageddonAdds = self.vb.armageddonAdds - 1
		local count = self.vb.armageddonAdds
		if count < 4 then
			warnArmageddon:Show(count)
			if count == 0 then
				timerArmageddon:Stop()
				countdownArmageddon:Cancel()
			end
		end
	elseif spellId == 212531 then--Mark of Frost (5sec Targetting Debuff)
		if args:IsPlayer() then
			countdownMarkOfFrost:Cancel()
		end
		if self.Options.NPAuraOnMarkOfFrost then
			DBM.Nameplate:Hide(false, args.destName, spellId)
		end
	elseif spellId == 213148 and args:IsPlayer() then--Searing Brand (5sec Targetting Debuff)
		countdownSearingBrand:Cancel()
	elseif spellId == 230951 then
		timerFelSoul:Stop()
	elseif spellId == 212587 then
		if self.Options.NPAuraOnMarkOfFrost then
			DBM.Nameplate:Hide(false, args.destName, spellId)
		end
	end
end
	
do
	local playerGUID = UnitGUID("player")
	function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
		if spellId == 212736 and destGUID == playerGUID and self:AntiSpam(2, 1) then
			specWarnPoolOfFrost:Show()
			voicePoolOfFrost:Play("runaway")
		elseif spellId == 213278 and destGUID == playerGUID and self:AntiSpam(2, 2) then
			specWarnBurningGround:Show()
			voiceBurningGround:Play("runaway")
		elseif spellId == 213504 and destGUID == playerGUID and self:AntiSpam(2, 3) then
			specWarnArcaneFog:Show()
			voiceArcaneFog:Play("runaway")
		elseif spellId == 230414 and destGUID == playerGUID and self:AntiSpam(2, 4) then
			specWarnFelStomp:Show()
			voiceFelStomp:Play("runaway")
		end
	end
	mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
	
	function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
		if spellId == 213520 and destGUID == playerGUID and self:AntiSpam(2, 1) then
			specWarnArcaneFog:Show()
			voiceArcaneFog:Play("runaway")
		end
	end
	mod.SPELL_MISSED = mod.SPELL_DAMAGE
end

--More accurate way to do this for now, too many spell Ids right now don't know what's what for sure. However a simple spell NAME check should work fairly reliable for test purposes
function mod:UNIT_AURA(uId)
	local hasDebuff = UnitDebuff("player", MarkOfFrostDebuff) or UnitDebuff("player", SearingBrandDebuff)
	if hasDebuff and not rangeShowAll then--Has 1 or more debuff, show all players on range frame
		rangeShowAll = true
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	elseif not hasDebuff and rangeShowAll then--No debuffs, only show those that have debuffs
		rangeShowAll = false
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8, debuffFilter)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 215455 then--Arcane Orb
		specWarnArcaneOrb:Show()
		voiceArcaneOrb:Play("watchorb")
	elseif spellId == 213390 then--Detonate: Arcane Orb (still missing from combat log, although this event is 3 seconds slower than scheduling or using yell)
		self:ScanForMobs(107287, 0, 8, 8, 0.2, 12, "SetIconOnBurstOfMagic")
--		specWarnArcaneDetonate:Show()
--		voiceArcaneDetonate:Play("watchorb")
	end
end
