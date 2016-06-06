local mod	= DBM:NewMod(1751, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(104881)
mod:SetEncounterID(1871)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 213853 213567 213564 213852 212735 213275 213390 213083 212492",
	"SPELL_AURA_APPLIED 213864 216389 213867 213869 212531 213148 213569",
	"SPELL_AURA_REMOVED 213569 212531 213148",
	"SPELL_PERIODIC_DAMAGE 212736 213278 213504",
	"SPELL_PERIODIC_MISSED 212736 213278 213504",
	"SPELL_DAMAGE 213520",
	"SPELL_MISSED 213520",
	"UNIT_AURA player",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, possibly dump UNIT_AURA unless that proves to actualy be better way to manage range frame
--TODO, Tank strategies varied a bit and blizz will probably adjust behavior on annihilate so review this again later date
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

local specWarnAnnihilate			= mod:NewSpecialWarningCount(212492, "Tank", nil, nil, 3, 2)
local specWarnAnnihilateOther		= mod:NewSpecialWarningTaunt(212492, nil, nil, nil, 1, 2)
--Debuffs
local specWarnMarkOfFrost			= mod:NewSpecialWarningMoveAway(212531, nil, nil, nil, 1, 2)
local specWarnSearingBrand			= mod:NewSpecialWarningMoveAway(213148, nil, nil, nil, 1, 2)
local specWarnSearingBrandDodge		= mod:NewSpecialWarningDodge(213148, nil, nil, nil, 2, 6)
local specWarnArcaneOrb				= mod:NewSpecialWarningDodge(213519, nil, nil, nil, 2, 2)
--Detonates
local specWarnFrostdetonate			= mod:NewSpecialWarningMoveAway(212735, nil, nil, nil, 3, 2)
local yellFrostDetonate				= mod:NewYell(212735, 29870)--29870 "Detonate" short name
local specWarnFireDetonate			= mod:NewSpecialWarningMoveAway(213275, nil, nil, nil, 3, 2)
local yellFireDetonate				= mod:NewYell(213275, 29870)--29870 "Detonate" short name
local specWarnArcanedetonate		= mod:NewSpecialWarningDodge(213390, nil, nil, nil, 3, 2)
--GTFOs
local specWarnPoolOfFrost			= mod:NewSpecialWarningMove(212736, nil, nil, nil, 1, 2)
local specWarnBurningGround			= mod:NewSpecialWarningMove(213278, nil, nil, nil, 1, 2)
local specWarnArcaneFog				= mod:NewSpecialWarningMove(213504, nil, nil, nil, 1, 2)--Fog and orbs combined for simplicity
--Animates
local specWarnAnimateFrost			= mod:NewSpecialWarningSwitch(213853, "-Healer", nil, nil, 1, 2)--Currently spell ID does not contain "animate" in name, which makes warning confusing. Hopefully blizzard fixes
local specWarnAnimateFire			= mod:NewSpecialWarningSwitch(213567, "-Healer", nil, nil, 1, 2)
local specWarnAnimateArcane			= mod:NewSpecialWarningSwitch(213564, "-Healer", nil, nil, 1, 2)
--Animate Specials

local timerFrostPhaseCD				= mod:NewNextTimer(80, 213864, nil, nil, nil, 6)
local timerFirePhaseCD				= mod:NewNextTimer(85, 213867, nil, nil, nil, 6)
local timerArcanePhaseCD			= mod:NewNextTimer(85, 213869, nil, nil, nil, 6)
local timerAnnihilateCD				= mod:NewCDCountTimer(40, 212492, nil, "Tank", nil, 5, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_TANK_ICON)
--Debuffs
local timerMarkOfFrostCD			= mod:NewNextTimer(16, 212531, nil, nil, nil, 3)
local timerSearingBrandCD			= mod:NewNextTimer(16, 213148, nil, nil, nil, 3)
local timerArcaneOrbCD				= mod:NewNextTimer(14.5, 213519, nil, nil, nil, 3)
--Replicates
local timerMarkOfFrostRepCD			= mod:NewNextTimer(16, 212530, 160324, nil, nil, 3)--Short name "Replicate"
local timerSearingBrandRepCD		= mod:NewNextTimer(16, 213182, 160324, nil, nil, 3)--Short name "Replicate"
local timerArcaneOrbRepCD			= mod:NewNextTimer(14.5, 213852, 160324, nil, nil, 3)--Short name "Replicate"
--Detonates
local timerMarkOfFrostDetonateCD	= mod:NewNextTimer(16, 212735, 29870, nil, nil, 3, nil, DBM_CORE_HEALER_ICON)--Short name "Detonate"
local timerSearingBrandDetonateCD	= mod:NewNextTimer(16, 213275, 29870, nil, nil, 3, nil, DBM_CORE_HEALER_ICON)--Short name "Detonate"
local timerArcaneOrbDetonateCD		= mod:NewNextTimer(16, 213390, 29870, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_HEALER_ICON)--Short name "Detonate"
--Animates
local timerAnimateFrostCD			= mod:NewNextTimer(16, 213853, 124338, nil, nil, 1, nil, DBM_CORE_TANK_ICON)--"Animated" short name. Wrong tense but only short spell I can use
local timerAnimateFireCD			= mod:NewNextTimer(16, 213567, 124338, nil, nil, 1, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_TANK_ICON)--"Animated" short name. Wrong tense but only short spell I can use
local timerAnimateArcaneCD			= mod:NewNextTimer(16, 213564, 124338, nil, nil, 1, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_DAMAGE_ICON..DBM_CORE_TANK_ICON)--"Animated" short name. Wrong tense but only short spell I can use
--Animate Specials
local timerArmageddon				= mod:NewCastTimer(33, 213568, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)

local countdownMarkOfFrost			= mod:NewCountdown("Alt30", 212531, nil, nil, 3)
local countdownSearingBrand			= mod:NewCountdown("Alt30", 213148, nil, nil, 3)
local countdownAnnihilate			= mod:NewCountdown("Alt30", 212492, "Tank")
local countdownArmageddon			= mod:NewCountdown("AltTwo33", 213568)

local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceAnnihilate				= mod:NewVoice(212492, "Tank")--defensive/tauntboss
--Debuffs
local voiceMarkOfFrost				= mod:NewVoice(212531)--scatter/??? (??? not used yet, need to determine stacks for grouping up to clear then make voice maybe that says "stand near another mark of frost" maybe?)
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
--Animates
local voiceAnimateFrost				= mod:NewVoice(213853)--mobsoon
local voiceAnimateFire				= mod:NewVoice(213567)--mobsoon
local voiceAnimateArcane			= mod:NewVoice(213564)--mobsoon
--Animate Specials

mod:AddRangeFrameOption("8")
--mod:AddSetIconOption("SetIconOnMC", 163472, false)
mod:AddHudMapOption("HudMapOnBrandCharge", 213166)

mod.vb.annihilateCount = 0
mod.vb.armageddonAdds = 0
local MarkOfFrostDebuff = GetSpellInfo(212587)
local SearingBrandDebuff = GetSpellInfo(213166)
local rangeShowAll = false
local chargeTable = {}
local annihilateTimers = {8, 45, 40, 44, 20, 18, 47, 20, 13}--Need longer pulls/more data. However this pattern did prove to always be same

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

function mod:OnCombatStart(delay)
	self.vb.annihilateCount = 0
	self.vb.armageddonAdds = 0
	timerAnnihilateCD:Start(8-delay, 1)
	countdownAnnihilate:Start(8-delay)
	--Rest of timers are triggered by frost buff 0.1 seconds into pull
	table.wipe(chargeTable)
	local rangeShowAll = false
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnBrandCharge then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 213853 then--Mark of Frost (Animate)
		specWarnAnimateFrost:Show()
		voiceAnimateFrost:Play("mobsoon")--using this trigger, mobsoon
		DBM:AddMsg("If you see this message it means blizzard fixed Animate frost combat log trigger. Report this to DBM authors to improve mod. You may recieve double warnings on this spell until mod is updated.")
	elseif spellId == 213567 then--Animate: Searing Brand
		specWarnAnimateFire:Show()
		voiceAnimateFire:Play("mobsoon")
	elseif spellId == 213564 then--Animate: Arcane Orb
		specWarnAnimateArcane:Show()
		voiceAnimateArcane:Play("mobsoon")
		timerArmageddon:Start()
		countdownArmageddon:Start()
	elseif spellId == 213852 then--Replicate: Arcane Orb
		specWarnArcaneOrb:Show()
		voiceArcaneOrb:Play("watchorb")
	elseif spellId == 212735 then--Detonate: Mark of Frost
		if UnitDebuff("player", MarkOfFrostDebuff) then
			specWarnFrostdetonate:Show()
			voiceFrostDetonate:Play("runout")
			yellFrostDetonate:Yell()
		end
	elseif spellId == 213275 then--Detonate: Searing Brand
		if UnitDebuff("player", SearingBrandDebuff) then
			specWarnFireDetonate:Show()
			voiceFireDetonate:Play("runout")
			yellFireDetonate:Yell()
		end
	elseif spellId == 213390 then--Detonate: Arcane Orb
		specWarnArcanedetonate:Show()
		voiceArcaneDetonate:Play("watchorb")
		DBM:AddMsg("If you see this message it means blizzard fixed Detonate: Arcane Orb combat log trigger. Report this to DBM authors to improve mod. You may recieve double warnings on this spell until mod is updated.")
	elseif spellId == 213083 then--Frozen Tempest
		warnFrozenTempest:Show()
	elseif spellId == 212492 then--Annihilate
		self.vb.annihilateCount = self.vb.annihilateCount + 1
		local targetName, uId, bossuid = self:GetBossTarget(104881, true)
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			specWarnAnnihilate:Show(self.vb.annihilateCount)
			voiceAnnihilate:Play("defensive")
		else
			specWarnAnnihilateOther:Schedule(4, targetName)
			voiceAnnihilate:Schedule(4, "changemt")
		end
		local nextCount = self.vb.annihilateCount+1
		local timer = annihilateTimers[nextCount]
		if timer then	
			timerAnnihilateCD:Start(timer, nextCount)
			countdownAnnihilate:Start(timer)
		end
		if nextCount == 6 then
			--Better place to start arcane orb timer since it's cast 1.5 seconds after arcane phase begins and this is last annihilate in fire phase
			timerArcaneOrbCD:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 213864 or spellId == 216389 then--Icy enchantment (Two versions for some reason, probably normal/lfr version and heroic/mythic)
		warnFrostPhase:Show()
		voicePhaseChange:Play("phasechange")
		timerMarkOfFrostCD:Start(18)
		timerMarkOfFrostRepCD:Start(28)
		timerMarkOfFrostDetonateCD:Start(48)
		timerAnimateFrostCD:Start(65)--Timer is for cast start, which is hidden at moment, so DBM will trigger warning 3 seconds after timer ends (cast finish) right now
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8, debuffFilter)
		end
		timerFirePhaseCD:Start(85)
	elseif spellId == 213867 then--Fiery Enchantment
		warnFirePhase:Show()
		voicePhaseChange:Play("phasechange")
		timerSearingBrandCD:Start(17.8)
		timerSearingBrandRepCD:Start(25)
		timerSearingBrandDetonateCD:Start(45)
		timerAnimateFireCD:Start(62)
		timerArcanePhaseCD:Start(85)
	elseif spellId == 213869 then--Magic Enchantment
		warnArcanePhase:Show()
		voicePhaseChange:Play("phasechange")
		--Arcane orb not started here, started somewhere else so timer is actually useful
		timerArcaneOrbRepCD:Start(25)
		timerArcaneOrbDetonateCD:Start(47.9)
		timerAnimateArcaneCD:Start(61.9)
		if self.Options.RangeFrame and self:IsRanged() then
			DBM.RangeCheck:Show(8)--Show everyone for better arcane orb spread
		else--Melee, kill range frame this phase
			DBM.RangeCheck:Hide()
		end
		timerFrostPhaseCD:Start(80)
	elseif spellId == 212531 then--Mark of Frost (5sec Targetting Debuff)
		warnMarkOfFrostChosen:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnMarkOfFrost:Show()
			voiceMarkOfFrost:Play("scatter")
			countdownMarkOfFrost:Start(5)
		end
	elseif spellId == 213148 then--Searing Brand (5sec Targetting Debuff)
		warnSearingBrandChosen:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSearingBrand:Show()
			voiceSearingBrand:Play("scatter")
			countdownSearingBrand:Start()
		end
		if self.Options.HudMapOnBrandCharge then
			self:Unschedule(hudDelay)
			if not tContains(args.destName, args.destName) then
				chargeTable[#chargeTable+1] = args.destName
			end
			self:Schedule(0.3, hudDelay, self)
		end
	elseif spellId == 213569 then--Armageddon Applied to mobs
		self.vb.armageddonAdds = self.vb.armageddonAdds + 1
	end
end

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
	elseif spellId == 212531 and args:IsPlayer() then--Mark of Frost (5sec Targetting Debuff)
		countdownMarkOfFrost:Cancel()
	elseif spellId == 213148 and args:IsPlayer() then--Searing Brand (5sec Targetting Debuff)
		countdownSearingBrand:Cancel()
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
	if spellId == 213853 then--Animate Mark of Frost. Not currently incombat log
		specWarnAnimateFrost:Show()
		voiceAnimateFrost:Play("mobkill")--using this trigger, mobkill
--		timerAnimateFrostCD:Start()
	elseif spellId == 215455 then--Arcane Orb
		specWarnArcaneOrb:Show()
		voiceArcaneOrb:Play("watchorb")
	elseif spellId == 213390 then--Detonate: Arcane Orb
		specWarnArcanedetonate:Show()
		voiceArcaneDetonate:Play("watchorb")
	end
end
