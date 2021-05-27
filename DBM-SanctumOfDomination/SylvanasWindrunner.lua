local mod	= DBM:NewMod(2441, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(178423)--ID taken from Banshee Form, so should be right
mod:SetEncounterID(2435)
--mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20210526000000)--2021-05-26
--mod:SetMinSyncRevision(20201222000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 349419 347726 347609 352663 353418 353417 348094 355540 352271 351075 351179 351117 351353 356023 354011 353969 354068 353952 353935 354147",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 347504 347807 347670 349458 347704 347609 347607 350857 348146 351109 351117 351451 353929 357876 357882 357886 357720 353935",
	"SPELL_AURA_APPLIED_DOSE 347807 347607 351672",
	"SPELL_AURA_REMOVED 347504 347807 351109 348146",
	"SPELL_AURA_REMOVED_DOSE 347807"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, do what with the combo of attacks of windrunner? IE https://ptr.wowhead.com/spell=347928/withering-fire
--TODO infoframe on barbed stacks useful? add more stuff to it like banshees bane in phase 3 and adds/orbs monitors in phase 2?
--TODO, determin if 7 second cast for chains is pre cast for deciding who runs into them to clear barbed, or the channel on the already choosen vicims
--TODO, https://ptr.wowhead.com/spell=347608/sylvanas is caused by chains? More chains work needed in general
--TODO, Veil of Darkness has like 10 spellIds, so pretty much 90% chance this mod using the wrong one. Obviously do more with mechanic when spellIds worked out
--TODO, do more with Ranger's Heartseeker? Currently just guestiate timer between casts and stack monitor
--TODO, find a more accurate phase 2 trigger
--TODO, Ruin is inconsistent in journal is it interrupted or avoided? Two diff messages in journal so for now it's a general announce
--TODO, determine add warnings/timers for phase 2
--TODO, verify lashing strike target scan (or find alterneate targeting method)
--TODO, icons for crushing dread? Depends on number of debuffs and number of adds etc
--TODO, improve orb auto marking
--TODO, do more with https://ptr.wowhead.com/spell=351939/curse-of-lethargy?
--TODO, use shadow dagger timer in phase 1 as well? or any of other windrunner abilities need timers
--TODO, add counts to everything that's kept
--General
local warnPhase										= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Stage One: A Cycle of Hatred
local warnWindrunnerOver							= mod:NewEndAnnounce(347504, 2)
local warnShadowDagger								= mod:NewTargetNoFilterAnnounce(347670, 2, nil, "Healer")
local warnDominationChains							= mod:NewTargetAnnounce(349458, 2)--Could be spammy, unknown behavior
local warnVeilofDarkness							= mod:NewTargetNoFilterAnnounce(347704, 2)
local warnRangersHeartseeker						= mod:NewSpellAnnounce(352663, 2, nil, "Tank")
local warnBansheesMark								= mod:NewStackAnnounce(347607, 2, nil, "Tank|Healer")
--Intermission: A Monument to our Suffering

--Stage Two: The Banshee Queen
local warnRuin										= mod:NewCastAnnounce(355540, 4)
----Forces of the Maw
local warnUnstoppableForce							= mod:NewCountAnnounce(351075, 2)--Mawsworn Vanguard
local warnLashingStrike								= mod:NewTargetNoFilterAnnounce(351179, 3)--Mawforged Souljudge
local warnCrushingDread								= mod:NewTargetAnnounce(351117, 2)--Mawforged Souljudge
local warnSummonDecrepitOrbs						= mod:NewCountAnnounce(351353, 2)--Mawforged Summoner
local warnCurseofLthargy							= mod:NewTargetAnnounce(351451, 2)--Mawforged Summoner
--Stage Three: The Freedom of Choice
local warnBansheesHeartseeker						= mod:NewSpellAnnounce(353969, 2, nil, "Tank")
local warnBansheesBane								= mod:NewTargetNoFilterAnnounce(353929, 4)
local warnBansheesScream							= mod:NewTargetNoFilterAnnounce(357720, 3)

--local specWarnGTFO								= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)
--Stage One: A Cycle of Hatred
local specWarnWindrunner							= mod:NewSpecialWarningCount(347504, nil, nil, nil, 2, 2)
local specWarnVeilofDarkness						= mod:NewSpecialWarningYou(347704, nil, nil, nil, 1, 2)
--local specWarnExsanguinated						= mod:NewSpecialWarningStack(328897, nil, 2, nil, nil, 1, 6)
local specWarnWailingArrow							= mod:NewSpecialWarningRun(347609, nil, nil, nil, 4, 2)
local specWarnWailingArrowTaunt						= mod:NewSpecialWarningTaunt(347609, nil, nil, nil, 1, 2)
--local specWarnBansheesMark						= mod:NewSpecialWarningStack(347607, nil, 3, nil, nil, 1, 2)
--local specWarnBansheesMarkTaunt					= mod:NewSpecialWarningTaunt(347607, nil, nil, nil, 1, 2)
--Intermission: A Monument to our Suffering
local specWarnBansheeWail							= mod:NewSpecialWarningMoveAway(348094, nil, nil, nil, 2, 2)
--Stage Two: The Banshee Queen
--local specWarnRuin								= mod:NewSpecialWarningDodge(355540, nil, nil, nil, 2, 2)
local specWarnHauntingWave							= mod:NewSpecialWarningDodge(352271, nil, nil, nil, 2, 2)
----Forces of the Maw
local specWarnLashingStrike							= mod:NewSpecialWarningYou(351179, nil, nil, nil, 1, 2)--Mawforged Souljudge
local yellLashingStrike								= mod:NewYell(351179)--Mawforged Souljudge
local specWarnCrushingDread							= mod:NewSpecialWarningMoveAway(351117, nil, nil, nil, 1, 2)--Mawforged Souljudge
local yellCrushingDread								= mod:NewYell(351117)--Mawforged Souljudge
local specWarnTerrorOrb								= mod:NewSpecialWarningInterruptCount(356023, nil, nil, nil, 1, 2)--Mawforged Summoner
local specWarnCurseofLethargy						= mod:NewSpecialWarningYou(351451, nil, nil, nil, 1, 2)--Mawforged Summoner
local specWarnFury									= mod:NewSpecialWarningCount(351672, nil, DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.stack:format(12, 351672), nil, 1, 2)--Mawforged Goliath
local specWarnFuryOther								= mod:NewSpecialWarningTaunt(351672, nil, nil, nil, 1, 2)--Mawforged Goliath
--Stage Three: The Freedom of Choice
local specWarnBansheesBane							= mod:NewSpecialWarningYou(353929, nil, nil, nil, 1, 2)
local specWarnBansheesBaneTaunt						= mod:NewSpecialWarningTaunt(353929, nil, nil, nil, 1, 2)--Let the tank drop bane out by swapping for it
local specWarnBansheesBaneDispel					= mod:NewSpecialWarningDispel(353929, "RemoveMagic", nil, nil, 3, 2)--Dispel alert during Fury
local specWarnBansheeScream							= mod:NewSpecialWarningYou(357720, nil, nil, nil, 1, 2)
local yellBansheeScream								= mod:NewYell(357720)
local specWarnRaze									= mod:NewSpecialWarningRun(354147, nil, nil, nil, 4, 2)

--General
--local berserkTimer								= mod:NewBerserkTimer(600)
--Stage One: A Cycle of Hatred
--mod:AddTimerLine(BOSS)
local timerWindrunnerCD								= mod:NewAITimer(23, 347504, nil, nil, nil, 6, nil, nil, nil, 1, 3)
local timerShadowDaggerCD							= mod:NewAITimer(23, 353935, nil, nil, nil, 3)
local timerDominationChainsCD						= mod:NewAITimer(23, 349419, nil, nil, nil, 3)
local timerVeilofDarknessCD							= mod:NewAITimer(23, 347726, nil, nil, nil, 3)
local timerWailingArrowCD							= mod:NewAITimer(17.8, 347609, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerRangersHeartseekerCD						= mod:NewAITimer(17.8, 352663, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
--Intermission: A Monument to our Suffering
local timerBansheeWailCD							= mod:NewAITimer(23, 348094, nil, nil, nil, 2)
--Stage Two: The Banshee Queen
local timerRuinCD									= mod:NewAITimer(23, 355540, nil, nil, nil, 2)--Add Interrupt icon if it's actually interruptable
local timerHauntingWaveCD							= mod:NewAITimer(23, 352271, nil, nil, nil, 2)
----Forces of the Maw

--Stage Three: The Freedom of Choice
local timerBaneArrowsCD								= mod:NewAITimer(23, 354011, nil, nil, nil, 3)
local timerBansheesHeartseekerCD					= mod:NewAITimer(17.8, 353969, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerBansheesFuryCD							= mod:NewAITimer(23, 354068, nil, nil, nil, 2)
local timerBansheesScreamCD							= mod:NewAITimer(23, 353952, nil, nil, nil, 3)
local timerRazeCD									= mod:NewAITimer(23, 354147, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(347807, true)
mod:AddSetIconOption("SetIconOnTerrorOrb", 356023, true, true, {4, 5, 6, 7, 8})
mod:AddNamePlateOption("NPAuraOnEnflame", 351109)--Mawsworn Hopebreaker

mod.vb.phase = 1
mod.vb.winrunnerCount = 0
mod.vb.addIcon = 8
local BarbedStacks = {}
local castsPerGUID = {}

function mod:LashingStrikearget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnLashingStrike:Show()
		specWarnLashingStrike:Play("targetyou")
		yellLashingStrike:Yell()
	else
		warnLashingStrike:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	table.wipe(BarbedStacks)
	table.wipe(castsPerGUID)
	self.vb.phase = 1
	self.vb.winrunnerCount = 0
	self.vb.addIcon = 8
	timerWindrunnerCD:Start(1-delay)
--	timerShadowDaggerCD:Start(1-delay)
	timerDominationChainsCD:Start(1-delay)
	timerVeilofDarknessCD:Start(1-delay)
	timerRangersHeartseekerCD:Start(1-delay)
--	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(347807))
		DBM.InfoFrame:Show(10, "table", BarbedStacks, 1)
	end
	if self.Options.NPAuraOnEnflame then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnEnflame then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 349419 then
		timerDominationChainsCD:Start()
	elseif spellId == 347726 then
		timerVeilofDarknessCD:Start()
	elseif spellId == 347609 then
		timerWailingArrowCD:Start()
	elseif spellId == 352663 then
		warnRangersHeartseeker:Show()
		timerRangersHeartseekerCD:Start()
	elseif (spellId == 353418 or spellId == 353417) and self.vb.phase == 1 then--Rive
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
		warnPhase:Play("phasechange")
		self.vb.phase = 1.5--Intermission to phase 2
		timerWindrunnerCD:Stop()
--		timerShadowDaggerCD:Stop()
		timerDominationChainsCD:Stop()
		timerVeilofDarknessCD:Stop()
		timerRangersHeartseekerCD:Stop()
		timerDominationChainsCD:Start(2)
		timerBansheeWailCD:Start(2)
	elseif spellId == 348094 then
		specWarnBansheeWail:Show()
		specWarnBansheeWail:Play("scatter")
		timerBansheeWailCD:Start()
	elseif spellId == 355540 then
		warnRuin:Show()
		timerRuinCD:Start()
	elseif spellId == 352271 then
		specWarnHauntingWave:Show()
		specWarnHauntingWave:Play("watchwave")
		timerHauntingWaveCD:Start()
	elseif spellId == 351075 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		warnUnstoppableForce:Show(castsPerGUID[args.sourceGUID])
	elseif spellId == 351179 then
--		timerAbsorbingChargeCD:Start(18.3, args.sourceGUID)
		self:BossTargetScanner(args.sourceGUID, "LashingStrikearget", 0.1, 5, nil, nil, nil, nil, true)
	elseif spellId == 351353 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		warnSummonDecrepitOrbs:Show(castsPerGUID[args.sourceGUID])
	elseif spellId == 356023 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.vb.addIcon < 4 then--Only use up to 5 icons
				self.vb.addIcon = 8
			end
			if self.Options.SetIconOnTerrorOrb then
				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, 0.2, 12, "SetIconOnTerrorOrb")
			end
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnTerrorOrb:Show(args.sourceName, count)
			if count == 1 then
				specWarnTerrorOrb:Play("kick1r")
			elseif count == 2 then
				specWarnTerrorOrb:Play("kick2r")
			elseif count == 3 then
				specWarnTerrorOrb:Play("kick3r")
			elseif count == 4 then
				specWarnTerrorOrb:Play("kick4r")
			elseif count == 5 then
				specWarnTerrorOrb:Play("kick5r")
			else
				specWarnTerrorOrb:Play("kickcast")
			end
		end
	elseif spellId == 354011 then
		timerBaneArrowsCD:Start()
	elseif spellId == 353969 then
		warnBansheesHeartseeker:Show()
		timerBansheesHeartseekerCD:Start()
	elseif spellId == 354068 then
		timerBansheesFuryCD:Start()
		for uId in DBM:GetGroupMembers() do
			if DBM:UnitDebuff(uId, 353929, 357882) then
				local name = DBM:GetUnitFullName(uId)
				if self.Options.SpecWarn353929dispel then
					specWarnBansheesBaneDispel:CombinedShow(0.3, name)
					specWarnBansheesBaneDispel:ScheduleVoice(0.3, "helpdispel")
				else
					warnBansheesBane:CombinedShow(0.3, name)
				end
			end
		end
	elseif spellId == 353952 then
		timerBansheesScreamCD:Start()
	elseif spellId == 353935 then
		if self.vb.phase == 3 then
			timerShadowDaggerCD:Start()
		end
	elseif spellId == 354147 then
		specWarnRaze:Show()
		specWarnRaze:Play("justrun")
		timerRazeCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 328857 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 347504 then
		self.vb.winrunnerCount = self.vb.winrunnerCount + 1
		specWarnWindrunner:Show(self.vb.winrunnerCount)
		specWarnWindrunner:Play("specialsoon")
		timerWindrunnerCD:Start()
	elseif spellId == 347807 then
		local amount = args.amount or 1
		BarbedStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(BarbedStacks)
		end
	elseif spellId == 347670 or spellId == 353935 then
		warnShadowDagger:CombinedShow(0.3, args.destName)
	elseif spellId == 349458 then
		warnDominationChains:CombinedShow(0.3, args.destName)
	elseif spellId == 347704 or spellId == 357876 then
		warnVeilofDarkness:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnVeilofDarkness:Show()
			specWarnVeilofDarkness:Play("targetyou")
		end
	elseif spellId == 347609 then
		if args:IsPlayer() then
			specWarnWailingArrow:Show()
			specWarnWailingArrow:Play("justrun")
		else
			specWarnWailingArrowTaunt:Show(args.destName)
			specWarnWailingArrowTaunt:Play("tauntboss")
		end
	elseif spellId == 347607 then
		local amount = args.amount or 1
--		if amount >= 3 then
--			if args:IsPlayer() then
--				specWarnBansheesMark:Show(amount)
--				specWarnBansheesMark:Play("stackhigh")
--			else
--				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
--					specWarnBansheesMarkTaunt:Show(args.destName)
--					specWarnBansheesMarkTaunt:Play("tauntboss")
--				else
--					warnBansheesMark:Show(args.destName, amount)
--				end
--			end
--		else
			warnBansheesMark:Show(args.destName, amount)
--		end
	elseif spellId == 350857 and self.vb.phase == 1 then
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
		warnPhase:Play("phasechange")
		self.vb.phase = 1.5--Intermission to phase 2
		timerWindrunnerCD:Stop()
		timerDominationChainsCD:Stop()
		timerVeilofDarknessCD:Stop()
		timerRangersHeartseekerCD:Stop()
		timerDominationChainsCD:Start(2)
		timerBansheeWailCD:Start(2)
	elseif spellId == 348146 then
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		self.vb.phase = 2
		timerDominationChainsCD:Stop()
		timerBansheeWailCD:Stop()
		timerRuinCD:Start(3)
		timerHauntingWaveCD:Start(3)
		timerVeilofDarknessCD:Start(3)
		timerBansheeWailCD:Start(3)
	elseif spellId == 351109 then
		if self.Options.NPAuraOnEnflame then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 351117 or spellId == 357886 then
		warnCrushingDread:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnCrushingDread:Show()
			specWarnCrushingDread:Play("runout")
			yellCrushingDread:Yell()
		end
	elseif spellId == 351451 then
		warnCurseofLthargy:combinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnCurseofLethargy:Show()
			specWarnCurseofLethargy:Play("targetyou")
		end
	elseif spellId == 351672 then
		local amount = args.amount or 1
		if amount >= 12 and self:AntiSpam(4, 2) then
			if self:IsTanking("player", "boss1", nil, true) then
				specWarnFury:Show(amount)
				specWarnFury:Play("changemt")
			else
				specWarnFuryOther:Show(args.destName)
				specWarnFuryOther:Play("tauntboss")
			end
		end
	elseif spellId == 353929 or spellId == 357882 then
		if args:IsPlayer() then
			specWarnBansheesBane:Show()
			specWarnBansheesBane:Play("targetyou")
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnBansheesBaneTaunt:Show(args.destName)
				specWarnBansheesBaneTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 357720 then
		warnBansheesScream:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnBansheeScream:Show()
			specWarnBansheeScream:Play("scatter")
			yellBansheeScream:Yell()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 347504 then
		warnWindrunnerOver:Show()
	elseif spellId == 347807 then
		BarbedStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(BarbedStacks)
		end
	elseif spellId == 351109 then
		if self.Options.NPAuraOnEnflame then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 348146 then
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		self.vb.phase = 3
		timerRuinCD:Stop()
		timerHauntingWaveCD:Stop()
		timerVeilofDarknessCD:Stop()
		timerBansheeWailCD:Stop()
		timerBaneArrowsCD:Start(4)
		timerBansheesHeartseekerCD:Start(4)
		timerBansheesFuryCD:Start(4)
		timerWailingArrowCD:Start(4)
		timerVeilofDarknessCD:Start(4)
		timerBansheesScreamCD:Start(4)
		timerShadowDaggerCD:Start(4)
		timerRazeCD:Start(4)
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 347807 then
		BarbedStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(BarbedStacks)
		end
	end
end

--[[

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 177289 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 342074 then

	end
end
--]]
