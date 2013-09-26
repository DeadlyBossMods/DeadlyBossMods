local mod	= DBM:NewMod(867, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71734)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_POWER_FREQUENT boss1"
)

--Sha of Pride
local warnGiftOfTitans			= mod:NewTargetAnnounce(144359, 1)
local warnSwellingPride			= mod:NewCountAnnounce(144400, 3)
local warnMark					= mod:NewTargetAnnounce(144351, 3, nil, mod:IsHealer())
local warnWoundedPride			= mod:NewTargetAnnounce(144358, 4, nil, mod:IsTank() or mod:IsHealer())
local warnSelfReflection		= mod:NewSpellAnnounce(144800, 3)
local warnCorruptedPrison		= mod:NewTargetAnnounce(144574, 3)
local warnBanishment			= mod:NewTargetAnnounce(145215, 3)--Heroic
local warnWeakenedResolve		= mod:NewTargetAnnounce(147207, 2, nil, false)--Heroic
local warnUnleashed				= mod:NewSpellAnnounce(144832, 3)--Phase 2
--Pride
local warnBurstingPride			= mod:NewTargetAnnounce(144911, 2)--25-49 Energy
local warnProjection			= mod:NewTargetAnnounce(146822, 3)--50-74 Energy
local warnAuraOfPride			= mod:NewTargetAnnounce(146817, 3)--75-99 Energy
local warnOvercome				= mod:NewTargetAnnounce(144843, 3)--100 Energy (pre mind control)
local warnOvercomeMC			= mod:NewTargetAnnounce(144863, 4)--Mind control version (ie applied being hit by swelling pride while you have 144843)
--Manifestation of Pride
local warnManifestation			= mod:NewSpellAnnounce("ej8262", 3, "Interface\\Icons\\achievement_raid_terraceofendlessspring04")
local warnMockingBlast			= mod:NewSpellAnnounce(144379, 3, nil, false)

--Sha of Pride
local specWarnGiftOfTitans		= mod:NewSpecialWarningYou(144359)
local yellGiftOfTitans			= mod:NewYell(146594, nil, false)
local specWarnSwellingPride		= mod:NewSpecialWarningCount(144400, nil, nil, nil, 2)
local specWarnWoundedPride		= mod:NewSpecialWarningSpell(144358, mod:IsTank())
local specWarnSelfReflection	= mod:NewSpecialWarningSpell(144800, nil, nil, nil, 2)
local specWarnCorruptedPrison	= mod:NewSpecialWarningSpell(144574)
local specWarnCorruptedPrisonYou= mod:NewSpecialWarningYou(144574, false)--Since you can't do anything about it, might as well be off by default. but an option cause someone will want it
local yellCorruptedPrison		= mod:NewYell(144574, nil, false)
--Pride
local specWarnBurstingPride		= mod:NewSpecialWarningMove(144911)--25-49 Energy
local yellBurstingPride			= mod:NewYell(144911)
local specWarnProjection		= mod:NewSpecialWarningYou(146822, nil, nil, nil, 3)--50-74 Energy
local specWarnAuraOfPride		= mod:NewSpecialWarningYou(146817)--75-99 Energy
local yellAuraOfPride			= mod:NewYell(146817)
local specWarnOvercome			= mod:NewSpecialWarningYou(144843, nil, nil, nil, 3)--100 EnergyHonestly, i have a feeling your best option if this happens is to find a way to kill yourself!
local specWarnBanishment		= mod:NewSpecialWarningYou(145215, nil, nil, nil, 3)--Heroic
--Manifestation of Pride
local specWarnManifestation		= mod:NewSpecialWarningSwitch("ej8262", not mod:IsHealer())--Spawn warning, need trigger first
local specWarnMockingBlast		= mod:NewSpecialWarningInterrupt(144379)

--Sha of Pride
local timerGiftOfTitansCD		= mod:NewNextTimer(25.5, 144359)--NOT cast or tied or boss, on it's own
--These abilitie timings are all based on boss1 UNIT_POWER. All timers have a 1 second variance
local timerMarkCD				= mod:NewNextTimer(20.5, 144351, nil, mod:IsHealer())
local timerSelfReflectionCD		= mod:NewNextTimer(25, 144800)
local timerWoundedPrideCD		= mod:NewNextTimer(30, 144358, nil, mod:IsTank())--A tricky on that is based off unit power but with variable timings, but easily workable with an 11, 26 rule
local timerBanishmentCD			= mod:NewNextTimer(37.5, 145215)
local timerCorruptedPrisonCD	= mod:NewNextTimer(53, 144574)--Technically 51 for Imprison base cast, but this is timer til debuffs go out.
local timerManifestationCD		= mod:NewNextTimer(60, "ej8262", nil, nil, nil, "Interface\\Icons\\achievement_raid_terraceofendlessspring04")
local timerSwellingPrideCD		= mod:NewNextCountTimer(75.5, 144400)
local timerWeakenedResolve		= mod:NewBuffFadesTimer(60, 147207, nil, false)
--Pride
local timerBurstingPride		= mod:NewCastTimer(3, 144911)
local timerProjection			= mod:NewCastTimer(6, 146822)

local berserkTimer				= mod:NewBerserkTimer(600)

local countdownSwellingPride	= mod:NewCountdown(75.5, 144400)
local countdownReflection		= mod:NewCountdown(25, 144800, false, nil, nil, nil, true)

mod:AddBoolOption("InfoFrame")
mod:AddBoolOption("SetIconOnMark", false)

local tinsert, tconcat, twipe = table.insert, table.concat, table.wipe--Sha of tables....Might as well cache frequent table globals
local UnitPower, UnitPowerMax, UnitIsDeadOrGhost, UnitGUID = UnitPower, UnitPowerMax, UnitIsDeadOrGhost, UnitGUID
local giftOfTitansTargets = {}
local burstingPrideTargets = {}
local projectionTargets = {}
local auraOfPrideTargets = {}--74-99 Energy
local banishmentTargets = {}--Heroic
local overcomeTargets = {}--100 Energy
local overcomeMCTargets = {}--100 Energy MC
local markOfArroganceTargets = {}
local markOfArroganceIcons = {}
local corruptedPrisonTargets = {}
local prideLevel = EJ_GetSectionInfo(8255)
local firstWound = false
local manifestationWarned = false
local swellingCount = 0

local function warnGiftOfTitansTargets()
	warnGiftOfTitans:Show(tconcat(giftOfTitansTargets, "<, >"))
	twipe(giftOfTitansTargets)
	timerGiftOfTitansCD:Start()
end

local function warnBurstingPrideTargets()
	warnBurstingPride:Show(tconcat(burstingPrideTargets, "<, >"))
	twipe(burstingPrideTargets)
end

local function warnProjectionTargets()
	warnProjection:Show(tconcat(projectionTargets, "<, >"))
	twipe(projectionTargets)
end

local function warnAuraOfPrideTargets()
	warnAuraOfPride:Show(tconcat(auraOfPrideTargets, "<, >"))
	twipe(auraOfPrideTargets)
end

local function warnOvercomeTargets()
	warnOvercome:Show(tconcat(overcomeTargets, "<, >"))
	twipe(overcomeTargets)
end

local function warnOvercomeMCTargets()
	warnOvercomeMC:Show(tconcat(overcomeMCTargets, "<, >"))
	twipe(overcomeMCTargets)
end

local function warnBanishmentTargets()
	warnBanishment:Show(tconcat(banishmentTargets, "<, >"))
	twipe(banishmentTargets)
end

local function warnMarkTargets()
	warnMark:Show(tconcat(markOfArroganceTargets, "<, >"))
	timerMarkCD:Start()
	twipe(markOfArroganceTargets)
end

local function warnCorruptedPrisonTargets()
	warnCorruptedPrison:Show(tconcat(corruptedPrisonTargets, "<, >"))
	specWarnCorruptedPrison:Show()
	twipe(corruptedPrisonTargets)
end

local function ClearMarkTargets()
	twipe(markOfArroganceIcons)
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetMarkIcons()
		table.sort(markOfArroganceIcons, sort_by_group)
		local markIcon = 1
		for i, v in ipairs(markOfArroganceIcons) do
			self:SetIcon(v, markIcon)
			markIcon = markIcon + 1
		end
		self:Schedule(1.5, ClearMarkTargets)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
	end
end

function mod:OnCombatStart(delay)
	twipe(giftOfTitansTargets)
	twipe(burstingPrideTargets)
	twipe(projectionTargets)
	twipe(banishmentTargets)
	twipe(overcomeTargets)
	twipe(overcomeMCTargets)
	twipe(markOfArroganceTargets)
	twipe(auraOfPrideTargets)
	twipe(corruptedPrisonTargets)
	twipe(markOfArroganceIcons)
	timerGiftOfTitansCD:Start(7.5-delay)
	timerMarkCD:Start(-delay)
	if not self:IsDifficulty("lfr25") then
		timerWoundedPrideCD:Start(10-delay)
	end
	timerSelfReflectionCD:Start(-delay)
	countdownReflection:Start(-delay)
	timerCorruptedPrisonCD:Start(-delay)
	timerManifestationCD:Start(-delay)
	timerSwellingPrideCD:Start(-delay, 1)
	countdownSwellingPride:Start(-delay)
	berserkTimer:Start(-delay)
	firstWound = false
	manifestationWarned = false
	swellingCount = 0
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(prideLevel)
		DBM.InfoFrame:Show(5, "playerpower", 5, ALTERNATE_POWER_INDEX)
	end
	if self:IsDifficulty("heroic10", "heroic25") then
		timerBanishmentCD:Start(-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144400 then
		swellingCount = swellingCount + 1
		warnSwellingPride:Show(swellingCount)
		specWarnSwellingPride:Show(swellingCount)
	elseif args.spellId == 144379 then
		local sourceGUID = args.sourceGUID
		warnMockingBlast:Show()
		if sourceGUID == UnitGUID("target") or sourceGUID == UnitGUID("focus") then 
			specWarnMockingBlast:Show(args.sourceName)
		end
	elseif args.spellId == 144832 then
		--These abilitie cd reset on SPELL_CAST_START (they no longer desync though, they sync back up after first off sync cast)
		countdownReflection:Cancel()
		countdownSwellingPride:Cancel()
		timerSwellingPrideCD:Cancel()
		if not self:IsDifficulty("lfr25") then
			timerWoundedPrideCD:Start()
		end
		timerSelfReflectionCD:Start()
		countdownReflection:Start()
		timerCorruptedPrisonCD:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerBanishmentCD:Start()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 144400 then--Swelling Pride Cast END
		firstWound = false
		--Since we register this event anyways for bursting, might as well start cd bars here instead
		timerSelfReflectionCD:Start()
		countdownReflection:Start()
		timerCorruptedPrisonCD:Start()
		timerManifestationCD:Start()
		timerSwellingPrideCD:Start(nil, swellingCount + 1)
		countdownSwellingPride:Start()
		if not self:IsDifficulty("lfr25") then
			timerWoundedPrideCD:Start(11)
		end
		if self:IsDifficulty("heroic10", "heroic25") then
			timerBanishmentCD:Start()
		end
		--This is done here because a lot can change during a cast, and we need to know players energy when cast ends, i.e. this event
		for uId in DBM:GetGroupMembers() do
			local maxPower = UnitPowerMax(uId, ALTERNATE_POWER_INDEX)
			if maxPower ~= 0 and not UnitIsDeadOrGhost(uId) then--PTR work around mainly, div by 0 crap
				local unitsPower = UnitPower(uId, ALTERNATE_POWER_INDEX) / maxPower * 100
				if unitsPower > 24 and unitsPower < 50 then--Valid Bursting target
					local targetName = DBM:GetUnitFullName(uId)
					burstingPrideTargets[#burstingPrideTargets + 1] = targetName
					self:Unschedule(warnBurstingPrideTargets)
					self:Schedule(0.5, warnBurstingPrideTargets)
					if targetName == UnitName("player") then
						specWarnBurstingPride:Show()
						yellBurstingPride:Yell()
						timerBurstingPride:Start()
					end
				end
			end
		end
	elseif args.spellId == 144832 then
		warnUnleashed:Show()
		timerGiftOfTitansCD:Cancel()
		firstWound = false
		timerManifestationCD:Start()--Not yet verified if altered or not
		timerSwellingPrideCD:Start(75, swellingCount + 1)--Not yet verified if altered or not (it would be 62 instead of 60 though since we'd be starting at 0 energy instead of cast finish of last swelling)
		countdownSwellingPride:Start(75)--Not yet verified if altered or not (it would be 62 instead of 60 though since we'd be starting at 0 energy instead of cast finish of last swelling)
	elseif args.spellId == 144800 then
		warnSelfReflection:Show()
		specWarnSelfReflection:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(144359, 146594) then
		giftOfTitansTargets[#giftOfTitansTargets + 1] = args.destName
		self:Unschedule(warnGiftOfTitansTargets)
		self:Schedule(0.5, warnGiftOfTitansTargets)
		if args:IsPlayer() then
			specWarnGiftOfTitans:Show()
			if not self:IsDifficulty("lfr25") then
				yellGiftOfTitans:Yell()
			end
		end
	elseif args.spellId == 145215 then
		banishmentTargets[#banishmentTargets + 1] = args.destName
		self:Unschedule(warnBanishmentTargets)
		self:Schedule(0.5, warnBanishmentTargets)
		if args:IsPlayer() then
			specWarnBanishment:Show()
		end
	elseif args.spellId == 146822 then
		projectionTargets[#projectionTargets + 1] = args.destName
		self:Unschedule(warnProjectionTargets)
		self:Schedule(0.5, warnProjectionTargets)
		if args:IsPlayer() then
			specWarnProjection:Show()
			timerProjection:Start()
		end
	elseif args.spellId == 146817 then
		auraOfPrideTargets[#auraOfPrideTargets + 1] = args.destName
		self:Unschedule(warnAuraOfPrideTargets)
		self:Schedule(0.5, warnAuraOfPrideTargets)
		if args:IsPlayer() then
			specWarnAuraOfPride:Show()
			yellAuraOfPride:Yell()
		end
	elseif args.spellId == 144843 then--Same spellid fires for both versions, so we have to do some more advanced filtering
		if bit.band(args.destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= 0 then--Mind controled version
			overcomeMCTargets[#overcomeMCTargets + 1] = args.destName
			self:Unschedule(warnOvercomeMCTargets)
			self:Schedule(0.5, warnOvercomeMCTargets)
		else--Non mind controlled version
			overcomeTargets[#overcomeTargets + 1] = args.destName
			self:Unschedule(warnOvercomeTargets)
			self:Schedule(0.5, warnOvercomeTargets)
			if args:IsPlayer() then
				specWarnOvercome:Show()
			end
		end
	elseif args.spellId == 144351 then
		markOfArroganceTargets[#markOfArroganceTargets + 1] = args.destName
		self:Unschedule(warnMarkTargets)
		self:Schedule(0.5, warnMarkTargets)
		if self.Options.SetIconOnMark and args:IsDestTypePlayer() then--Filter further on icons because we don't want to set icons on grounding totems
			tinsert(markOfArroganceIcons, DBM:GetRaidUnitId(DBM:GetFullPlayerNameByGUID(args.destGUID)))
			self:UnscheduleMethod("SetMarkIcons")
			if (self:IsDifficulty("normal25", "heroic25") and #markOfArroganceIcons >= 8) or (self:IsDifficulty("normal10", "heroic10") and #markOfArroganceIcons >= 3) then
				self:SetMarkIcons()
			else
				if self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
					self:ScheduleMethod(0.5, "SetMarkIcons")
				end
			end
		end
	elseif args.spellId == 144358 then
		warnWoundedPride:Show(args.destName)
		specWarnWoundedPride:Show()
		if not firstWound and not self:IsDifficulty("lfr25") then
			firstWound = true
			timerWoundedPrideCD:Start()
		end
	elseif args:IsSpellID(144574, 144636) then--Locational spellids, 2 from 10 man, 25 man will use all 4 where we can get other 2
		corruptedPrisonTargets[#corruptedPrisonTargets + 1] = args.destName
		self:Unschedule(warnCorruptedPrisonTargets)
		self:Schedule(0.5, warnCorruptedPrisonTargets)
		if args:IsPlayer() then
			specWarnCorruptedPrisonYou:Show()
			yellCorruptedPrison:Yell()
		end
	elseif args.spellId == 147207 then
		warnWeakenedResolve:Show(args.destName)
		if args:IsPlayer() then
			timerWeakenedResolve:Start()
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED--In case i decide to do something with fact healer debuff stacks if you suck at dispels

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 144351 and self.Options.SetIconOnMark then
		self:SetIcon(args.destName, 0)
	elseif args.spellId == 147207 and args:IsPlayer() then
		timerWeakenedResolve:Cancel()
	end
end

function mod:UNIT_POWER_FREQUENT(uId)
	local power = UnitPower(uId)
	if power > 81 and not manifestationWarned then--May not be 100% precise, but very close, it spawns around 80-85 energy
		manifestationWarned = true
		warnManifestation:Show()
		specWarnManifestation:Show()--No spawn trigger to speak of. fortunately for us, they spawn based on boss power.
	elseif power > 10 and manifestationWarned then
		manifestationWarned = false
	end
end
