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
	"SPELL_CAST_START 213853 213567 213564 212530 213852 212735 213275 213390 213083 213281 212492",
	"SPELL_CAST_SUCCESS 213182 212531 213148 213519",
	"SPELL_AURA_APPLIED 213864 216389 213867 213869 212531 212587 209948 212738 213148 213166 213519",
	"SPELL_AURA_REMOVED 213864 216389 213867 213869",
	"SPELL_PERIODIC_DAMAGE 212736 213278 213504",
	"SPELL_PERIODIC_MISSED 212736 213278 213504",
	"UNIT_AURA player"
)

--TODO, hudmap for charge needs review once data collected
--TODO, correct all spellids, poissibly dump UNIT_AURA unless that proves to actualy be better way to manage range frame
--TODO, add armageddon. It has too many spellIDs and none of them look like a cast ID, so a drycode would be sloppy at best
--TODO, see if timers actually reset on phase changes or if particular spells are on continous cooldowns whole fight and simply go off as whatever school she's currently in. I have a feeling it might be ladder
--TODO, replicate timers?
--TODO, based on timings I suspect tanks will have to swap boss every TWO annihilates, unless she literally only casts it once every 90 seconds?
--Phases
local warnFrostPhase				= mod:NewSpellAnnounce(213864, 2)
local warnFirePhase					= mod:NewSpellAnnounce(213867, 2)
local warnArcanePhase				= mod:NewSpellAnnounce(213869, 2)
--Debuffs
local warnMarkOfFrostChosen			= mod:NewTargetAnnounce(212531, 3)
local warnSearingBrandChosen		= mod:NewTargetAnnounce(213148, 3)
local warnArcaneOrb					= mod:NewTargetAnnounce(213519, 3)
--Animate Specials Temp, to avoid spam
local warnFrozenTempest				= mod:NewCastAnnounce(213083, 4)
local warnPyroblast					= mod:NewCastAnnounce(213281, 4)


local specWarnAnnihilate			= mod:NewSpecialWarningSpell(212492, "Tank", nil, nil, 3, 2)
local specWarnAnnihilateOther		= mod:NewSpecialWarningTaunt(212492, nil, nil, nil, 1, 2)
--Debuffs
local specWarnMarkOfFrost			= mod:NewSpecialWarningMoveAway(212531, nil, nil, nil, 1, 2)
local specWarnSearingBrand			= mod:NewSpecialWarningMoveAway(213148, nil, nil, nil, 1, 2)
local specWarnSearingBrandDodge		= mod:NewSpecialWarningDodge(213148, nil, nil, nil, 2, 6)
local specWarnArcaneOrb				= mod:NewSpecialWarningMoveAway(213519, nil, nil, nil, 1, 2)
--Detonates
local specWarnFrostdetonate			= mod:NewSpecialWarningMoveAway(212735, nil, nil, nil, 3, 2)
local yellFrostDetonate				= mod:NewYell(212735, 29870)--29870 "Detonate" short name
local specWarnFireDetonate			= mod:NewSpecialWarningMoveAway(213275, nil, nil, nil, 3, 2)
local yellFireDetonate				= mod:NewYell(213275, 29870)--29870 "Detonate" short name
local specWarnArcanedetonate		= mod:NewSpecialWarningMoveAway(213390, nil, nil, nil, 3, 2)
local yellArcaneDetonate			= mod:NewYell(213390, 29870)--29870 "Detonate" short name
--GTFOs
local specWarnPoolOfFrost			= mod:NewSpecialWarningMove(212736, nil, nil, nil, 1, 2)
local specWarnBurningGround			= mod:NewSpecialWarningMove(213278, nil, nil, nil, 1, 2)
local specWarnArcaneFog				= mod:NewSpecialWarningMove(213504, nil, nil, nil, 1, 2)
--Animates
local specWarnAnimateFrost			= mod:NewSpecialWarningSwitch(213853, "-Healer", nil, nil, 1, 2)--Currently spell ID does not contain "animate" in name, which makes warning confusing. Hopefully blizzard fixes
local specWarnAnimateFire			= mod:NewSpecialWarningSwitch(213567, "-Healer", nil, nil, 1, 2)
local specWarnAnimateArcane			= mod:NewSpecialWarningSwitch(213564, "-Healer", nil, nil, 1, 2)
--Animate Specials
--local specWarnPyroblast			= mod:NewSpecialWarningSpell(213281, nil, nil, nil, 2)

local timerAnnihilateCD				= mod:NewAITimer(16, 212492, nil, "Tank", nil, 5, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_TANK_ICON)
--Debuffs
local timerMarkOfFrostCD			= mod:NewAITimer(16, 212531, nil, nil, nil, 3)
local timerSearingBrandCD			= mod:NewAITimer(16, 213148, nil, nil, nil, 3)
local timerArcaneOrbCD				= mod:NewAITimer(16, 213519, nil, nil, nil, 3)
--Detonates
local timerMarkOfFrostDetonateCD	= mod:NewAITimer(16, 212735, 29870, nil, nil, 3, nil, DBM_CORE_HEALER_ICON)--Short name "Detonate"
local timerSearingBrandDetonateCD	= mod:NewAITimer(16, 213275, 29870, nil, nil, 3, nil, DBM_CORE_HEALER_ICON)--Short name "Detonate"
local timerArcaneOrbDetonateCD		= mod:NewAITimer(16, 213390, 29870, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_HEALER_ICON)--Short name "Detonate"
--Animates
local timerAnimateFrostCD			= mod:NewAITimer(16, 213853, 124338, nil, nil, 1, nil, DBM_CORE_TANK_ICON)--"Animated" short name. Wrong tense but only short spell I can use
local timerAnimateFireCD			= mod:NewAITimer(16, 213567, 124338, nil, nil, 1, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_TANK_ICON)--"Animated" short name. Wrong tense but only short spell I can use
local timerAnimateArcaneCD			= mod:NewAITimer(16, 213564, 124338, nil, nil, 1, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_DAMAGE_ICON..DBM_CORE_TANK_ICON)--"Animated" short name. Wrong tense but only short spell I can use

--local countdownMagicFire			= mod:NewCountdownFades(11.5, 162185)

local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceAnnihilate				= mod:NewVoice(212492, "Tank")--defensive/tauntboss
--Debuffs
local voiceMarkOfFrost				= mod:NewVoice(212531)--scatter/??? (??? not used yet, need to determine stacks for grouping up to clear then make voice maybe that says "stand near another mark of frost" maybe?)
local voiceSearingBrand				= mod:NewVoice(213148)--scatter/farfromline
local voiceArcaneOrb				= mod:NewVoice(213519)--scatter
--Detonates
local voiceFrostDetonate			= mod:NewVoice(212735)--runout
local voiceFireDetonate				= mod:NewVoice(213275)--runout
local voiceArcaneDetonate			= mod:NewVoice(213390)--runout
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

local MarkOfFrostDebuff = GetSpellInfo(212587)
local SearingBrandDebuff = GetSpellInfo(213166)
local ArcaneOrbDebuff = GetSpellInfo(213519)
local rangeShowAll = false
local chargeTable = {}

local debuffFilter
local UnitDebuff = UnitDebuff
do
	debuffFilter = function(uId)
		if UnitDebuff(uId, MarkOfFrostDebuff) or UnitDebuff(uId, SearingBrandDebuff) or UnitDebuff(uId, ArcaneOrbDebuff) then
			return true
		end
	end
end

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
	DBM:AddMsg("This experimental HUD is purely for code testing purposes. Right now it uses assumptions that may be false, so path it draws may not be accurate yet")
	for i = 1, #chargeTable do
		local name = chargeTable[i]
		local previousName
		if i > 1 then
			previousName = chargeTable[i-1]
		end
		if not previousName then previousName = currentTank end
		DBMHudMap:RegisterRangeMarkerOnPartyMember(213238, "party", name, 0.35, 5, nil, nil, nil, 0.5, nil, false):Appear():SetLabel(name, nil, nil, nil, nil, nil, 0.8, nil, -13, 8, nil)
		if previousName then--Create Line from current tank to seeker targets.
			DBMHudMap:AddEdge(1, 0, 0, 0.5, 5, previousName, name, nil, nil, nil, nil, 135)
		end
		if not chargeTable[i+1] then--Last person on table
			DBMHudMap:AddEdge(1, 0, 0, 0.5, 5, name, currentTank, nil, nil, nil, nil, 135)--Line back to tank
		end
	end
end

function mod:OnCombatStart(delay)
	timerAnnihilateCD:Start(1)
	--TODO: Start first phase timers here if boss starts off with one of buffs already applied (like trilliax did)
	table.wipe(chargeTable)
	local rangeShowAll = false
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8, debuffFilter)
	end
	DBM:AddMsg("Do to number of spellIds in play on this fight, drycode range frame and debuff warnings may be hit or miss.")
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.FelArrow then
--		DBM.Arrow:Hide()
--	end
	if self.Options.HudMapOnBrandCharge then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 213853 then--Mark of Frost (Animate)
		specWarnAnimateFrost:Show()
		voiceAnimateFrost:Play("mobsoon")
		timerAnimateFrostCD:Start()
	elseif spellId == 213567 then--Animate: Searing Brand
		specWarnAnimateFire:Show()
		voiceAnimateFire:Play("mobsoon")
		timerAnimateFireCD:Start()
	elseif spellId == 213564 then--Animate: Arcane Orb
		specWarnAnimateArcane:Show()
		voiceAnimateArcane:Play("mobsoon")
		timerAnimateArcaneCD:Start()
	elseif spellId == 212530 then--Replicate: Mark of Frost
		DBM:Debug("Replicate: Mark of Frost", 3)
	elseif spellId == 213852 then--Replicate: Arcane Orb
		DBM:Debug("Replicate: Arcane Orb", 3)
	elseif spellId == 212735 then--Detonate: Mark of Frost
		timerMarkOfFrostDetonateCD:Start()
		if UnitDebuff("player", MarkOfFrostDebuff) then
			specWarnFrostdetonate:Show()
			voiceFrostDetonate:Play("runout")
			yellFrostDetonate:Yell()
		end
	elseif spellId == 213275 then--Detonate: Searing Brand
		timerSearingBrandDetonateCD:Start()
		if UnitDebuff("player", SearingBrandDebuff) then
			specWarnFireDetonate:Show()
			voiceFireDetonate:Play("runout")
			yellFireDetonate:Yell()
		end
	elseif spellId == 213390 then--Detonate: Arcane Orb
		timerArcaneOrbDetonateCD:Start()
		if UnitDebuff("player", ArcaneOrbDebuff) then
			specWarnArcanedetonate:Show()
			voiceArcaneDetonate:Play("runout")
			yellArcaneDetonate:Yell()
		end
	elseif spellId == 213083 then--Frozen Tempest
		warnFrozenTempest:Show()
	elseif spellId == 213281 then--Pyroblast
		warnPyroblast:Show()
	elseif spellId == 212492 then--Annihilate
		local targetName, uId, bossuid = self:GetBossTarget(104881, true)
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			specWarnAnnihilate:Show()
			voiceAnnihilate:Play("defensive")
		else
			--specWarnAnnihilateOther:Schedule(4, targetName)
			--voiceAnnihilate:Schedule(4, "tauntboss")
		end
		timerAnnihilateCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 213182 then--Searing Brand (Replicate?)
		DBM:Debug("Searing Brand (Replicate?)", 3)
	elseif spellId == 212531 then--Mark of Frost (Debuff)
		--Totally assumed and probably wrong
		timerMarkOfFrostCD:Start()
	elseif spellId == 213148 then
		--Totally assumed and probably wrong
		timerSearingBrandCD:Start()
	elseif spellId == 213519 then
		--Totally assumed and probably wrong
		timerArcaneOrbCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 213864 or spellId == 216389 then--Icy enchantment (Two versions for some reason, probably normal/lfr version and heroic/mythic)
		warnFrostPhase:Show()
		voicePhaseChange:Play("phasechange")
		timerMarkOfFrostCD:Start(1)
		timerMarkOfFrostDetonateCD:Start(1)
		timerAnimateFrostCD:Start(1)
	elseif spellId == 213867 then--Fiery Enchantment
		warnFirePhase:Show()
		voicePhaseChange:Play("phasechange")
		timerSearingBrandCD:Start(1)
		timerSearingBrandDetonateCD:Start(1)
		timerAnimateFireCD:Start(1)
	elseif spellId == 213869 then--Magic Enchantment
		warnArcanePhase:Show()
		voicePhaseChange:Play("phasechange")
		timerArcaneOrbCD:Start(1)
		timerArcaneOrbDetonateCD:Start(1)
		timerAnimateArcaneCD:Start(1)
	elseif spellId == 212531 then--Mark of Frost (5sec Targetting Debuff)
		warnMarkOfFrostChosen:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnMarkOfFrost:Show()
			voiceMarkOfFrost:Play("scatter")
		end
	elseif spellId == 212587 then--Mark of Frost (Debuff)
		DBM:Debug("Mark of Frost (Debuff) detected on: "..args.destName, 3)
	elseif spellId == 209948 then--Mark of Frost (Tomb)
		DBM:Debug("Mark of Frost (Tomb) detected on: "..args.destName, 3)
	elseif spellId == 212738 then--Mark of Frost (Link)
		DBM:Debug("Mark of Frost (Link) detected on: "..args.destName, 3)
		--I suspect this one happens when two mark of frost debuff touch. Then detonate when they break this LINK
	elseif spellId == 213148 then--Searing Brand (5sec Targetting Debuff)
		warnSearingBrandChosen:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnSearingBrand:Show()
			voiceSearingBrand:Play("scatter")
		end
		if self.Options.HudMapOnBrandCharge then
			self:Unschedule(hudDelay)
			--Record video carefully, see if she charges targets in combat log order. if so should be easy to draw path on hud
			if not tContains(args.destName, args.destName) then
				chargeTable[#chargeTable+1] = args.destName
			end
			self:Schedule(0.5, hudDelay, self)
		end
	elseif spellId == 213166 then--Searing Brand (Debuff)
		--Fire dot from being charged. Probably don't need to actually use this here. Just UnitDebuff it on detonate cast. Reap Style
	elseif spellId == 213519 then--Arcane Orb (Debuff?) or 213565 or 213316 or 209853 or anything else.
		warnArcaneOrb:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnArcaneOrb:Show()
			voiceArcaneOrb:Play("scatter")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 213864 or spellId == 216389 then--Icy enchantment
		timerMarkOfFrostCD:Stop()
		timerMarkOfFrostDetonateCD:Stop()
		timerAnimateFrostCD:Stop()
	elseif spellId == 213867 then--Fiery Enchantment
		timerSearingBrandCD:Stop()
		timerSearingBrandDetonateCD:Stop()
		timerAnimateFireCD:Stop()
	elseif spellId == 213869 then--Magic Enchantment
		timerArcaneOrbCD:Stop()
		timerArcaneOrbDetonateCD:Stop()
		timerAnimateArcaneCD:Stop()
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
end

--More accurate way to do this for now, too many spell Ids right now don't know what's what for sure. However a simple spell NAME check should work fairly reliable for test purposes
function mod:UNIT_AURA(uId)
	local hasDebuff = UnitDebuff("player", MarkOfFrostDebuff) or UnitDebuff("player", SearingBrandDebuff) or UnitDebuff("player", ArcaneOrbDebuff)
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
