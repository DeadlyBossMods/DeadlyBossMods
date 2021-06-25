local mod	= DBM:NewMod(2441, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(178423)--ID taken from Banshee Form, so should be right
mod:SetEncounterID(2435)
mod:SetUsedIcons(5, 6, 7, 8)
mod:SetHotfixNoticeRev(20210530000000)--2021-05-30
mod:SetMinSyncRevision(20210530000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 349419 347726 347609 352663 353418 353417 348094 355540 352271 351075 351179 351353 356023 354011 353969 354068 353952 353935 354147 357102",
	"SPELL_CAST_SUCCESS 351178",
	"SPELL_AURA_APPLIED 347504 347807 347670 349458 348064 347607 350857 348146 351109 351117 351451 353929 357882 357886 357720 353935 348064 356986",
	"SPELL_AURA_APPLIED_DOSE 347807 347607 351672",
	"SPELL_AURA_REMOVED 347504 347807 351109",
	"SPELL_AURA_REMOVED_DOSE 347807",
	"CHAT_MSG_RAID_BOSS_EMOTE"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, do what with the combo of attacks of windrunner? IE https://ptr.wowhead.com/spell=347928/withering-fire
--TODO, infoframe on barbed stacks useful? add more stuff to it like banshees bane in phase 3 and adds/orbs monitors in phase 2?
--TODO, do more with Ranger's Heartseeker? Currently just guestiate timer between casts and stack monitor
--TODO, determine add warnings/timers for phase 2
--TODO, icons for crushing dread? Depends on number of debuffs and number of adds etc
--TODO, verify/improve orb auto marking on mythic
--TODO, do more with https://ptr.wowhead.com/spell=351939/curse-of-lethargy?
--TODO, use shadow dagger timer in phase 1 as well? or any of other windrunner abilities need timers
--TODO, add counts to everything that's kept
--TODO, chains cast timer for when they land?
--[[
(ability.id = 349419 or ability.id = 347609 or ability.id = 352663 or ability.id = 353418 or ability.id = 353417 or ability.id = 348094 or ability.id = 355540 or ability.id = 352271 or ability.id = 354011 or ability.id = 353969 or ability.id = 354068 or ability.id = 353952 or ability.id = 354147 or ability.id = 357102 or ability.id = 347726 or ability.id = 353935) and type = "begincast"
 or (ability.id = 356986 or ability.id = 347504 or ability.id = 350857 or ability.id = 348146) and (type = "begincast" or type = "applydebuff" or type = "applybuff" or type = "removebuff" or type = "removedebuff")
 or (ability.id = 351075 or ability.id = 351117 or ability.id = 351353 or ability.id = 356023) and type = "begincast"
 or ability.id = 347704 and type = "applydebuff"
--]]

--General
local warnPhase										= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Stage One: A Cycle of Hatred
local warnWindrunnerOver							= mod:NewEndAnnounce(347504, 2)
local warnShadowDagger								= mod:NewTargetNoFilterAnnounce(347670, 2, nil, "Healer")
local warnDominationChains							= mod:NewTargetAnnounce(349458, 2)--Could be spammy, unknown behavior
--local warnVeilofDarkness							= mod:NewTargetNoFilterAnnounce(347704, 2)
local warnRangersHeartseeker						= mod:NewSpellAnnounce(352663, 2, nil, "Tank")
local warnBansheesMark								= mod:NewStackAnnounce(347607, 2, nil, "Tank|Healer")
--Intermission: A Monument to our Suffering
local warnRive										= mod:NewCountAnnounce(353418, 4)--May default off by default depending on feedback
--Stage Two: The Banshee Queen
local warnWindsofIcecrown							= mod:NewTargetCountAnnounce(356986, 1, nil, nil, nil, nil, nil, nil, true)
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
local specWarnDominationChains						= mod:NewSpecialWarningCount(349419, nil, nil, nil, 2, 2)
local specWarnVeilofDarkness						= mod:NewSpecialWarningDodgeCount(347704, nil, nil, nil, 2, 2)
local specWarnWailingArrow							= mod:NewSpecialWarningRun(348064, nil, nil, nil, 4, 2)
local specWarnWailingArrowTaunt						= mod:NewSpecialWarningTaunt(348064, nil, nil, nil, 1, 2)
--local specWarnBansheesMark						= mod:NewSpecialWarningStack(347607, nil, 3, nil, nil, 1, 2)
--local specWarnBansheesMarkTaunt					= mod:NewSpecialWarningTaunt(347607, nil, nil, nil, 1, 2)
--Intermission: A Monument to our Suffering
local specWarnBansheeWail							= mod:NewSpecialWarningMoveAway(348094, nil, nil, nil, 2, 2)
--Stage Two: The Banshee Queen
local specWarnHauntingWave							= mod:NewSpecialWarningDodge(352271, nil, nil, nil, 2, 2)
local specWarnRuin									= mod:NewSpecialWarningInterrupt(355540, nil, nil, nil, 3, 2)
----Forces of the Maw
local specWarnLashingStrike							= mod:NewSpecialWarningYou(351179, nil, nil, nil, 1, 2)--Mawforged Souljudge
local yellLashingStrike								= mod:NewYell(351179)--Mawforged Souljudge
local specWarnCrushingDread							= mod:NewSpecialWarningMoveAway(351117, nil, nil, nil, 1, 2)--Mawforged Souljudge
local yellCrushingDread								= mod:NewYell(351117)--Mawforged Souljudge
local specWarnTerrorOrb								= mod:NewSpecialWarningInterruptCount(356023, nil, nil, nil, 1, 2, 4)--Mawforged Summoner
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
local timerWindrunnerCD								= mod:NewCDCountTimer(50.3, 347504, nil, nil, nil, 6, nil, nil, nil, 1, 3)
local timerDominationChainsCD						= mod:NewCDCountTimer(50.7, 349419, nil, nil, nil, 3)
local timerVeilofDarknessCD							= mod:NewCDCountTimer(48.8, 347726, nil, nil, nil, 3)
local timerWailingArrowCD							= mod:NewCDCountTimer(33.9, 347609, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
--Intermission: A Monument to our Suffering
local timerRiveCD									= mod:NewCDCountTimer(48.8, 353418, nil, nil, nil, 3)
local timerNextPhase								= mod:NewPhaseTimer(16.5, 348094, nil, nil, nil, 6)
--Stage Two: The Banshee Queen
--local timerRuinCD									= mod:NewAITimer(23, 355540, nil, nil, nil, 2)--Add Interrupt icon if it's actually interruptable
--local timerHauntingWaveCD							= mod:NewAITimer(23, 352271, nil, nil, nil, 2)
local timerWindsofIcecrown							= mod:NewBuffActiveTimer(35, 356986, nil, nil, nil, 5, nil, DBM_CORE_L.DAMAGE_ICON)
--Unstoppable Force ~9sec cd
----Forces of the Maw

--Stage Three: The Freedom of Choice
local timerShadowDaggerCD							= mod:NewCDCountTimer(23, 353935, nil, nil, nil, 3)--Only used in phase 3, in phase 1 it's tied to windrunner
local timerBaneArrowsCD								= mod:NewCDCountTimer(23, 354011, nil, nil, nil, 3)
local timerBansheesFuryCD							= mod:NewCDCountTimer(23, 354068, nil, nil, nil, 2)
local timerBansheesScreamCD							= mod:NewCDCountTimer(23, 353952, nil, nil, nil, 3)
local timerRazeCD									= mod:NewCDCountTimer(23, 354147, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(347807, true)
mod:AddSetIconOption("SetIconOnTerrorOrb", 356023, true, true, {4, 5, 6, 7, 8})--Didn't see any on heroic
mod:AddNamePlateOption("NPAuraOnEnflame", 351109)--Mawsworn Hopebreaker

--P1+ variable
mod.vb.winrunnerCount = 0
mod.vb.dominationChainsCount = 0
mod.vb.veilofDarknessCount = 0
mod.vb.wailingArrowCount = 0
--Intermission (P1.5) variables
mod.vb.riveCount = 0
--P2+ variables
mod.vb.addIcon = 8
mod.vb.icecrownCast = 0
mod.vb.hauntingWavecount = 0
--P3+ variables
mod.vb.baneArrowCount = 0
mod.vb.shadowDaggerCount = 0
mod.vb.bansheeScreamCount = 0
mod.vb.bansheesFuryCount = 0
mod.vb.razeCount = 0
local BarbedStacks = {}
local castsPerGUID = {}
local difficultyName = "None"
local allTimers = {--Much of table unused, just templated in case earlier difficulties also sequence better
	["lfr"] = {
		[1] = {

		},
		[1.5] = {

		},
		[2] = {

		},
		[3] = {
			--Bane Arrows
			[354011] = {},
			--Shadow Dagger
			[353935] = {},
			--Banshee Scream
			[353952] = {},
			--Wailing Arrow
			[347609] = {},
			--Veil of Darkness
--			[347726] = {},
		},
	},
	["normal"] = {
		[1] = {

		},
		[1.5] = {

		},
		[2] = {

		},
		[3] = {
			--Bane Arrows
			[354011] = {},
			--Shadow Dagger
			[353935] = {},
			--Banshee Scream
			[353952] = {},
			--Wailing Arrow
			[347609] = {},
			--Veil of Darkness
--			[347726] = {},
		},
	},
	["heroic"] = {
		[1] = {

		},
		[1.5] = {

		},
		[2] = {

		},
		[3] = {--Initial numbers not verified, justtemplates from wowhead
			--Bane Arrows
			[354011] = {19.6, 43.3},
			--Shadow Dagger
			[353935] = {22.2, 36.2},
			--Banshee Scream
			[353952] = {27.8, 7.5},
			--Wailing Arrow
			[347609] = {49, 3, 3},
			--Veil of Darkness
--			[347726] = {46},
			--Banshees Fury
--			[347726] = {65.6},
			--Raze
--			[347726] = {72.6},
		},
	},
	["mythic"] = {
		[1] = {

		},
		[2] = {

		},
		[3] = {
			--Bane Arrows
			[354011] = {},
			--Shadow Dagger
			[353935] = {},
			--Banshee Scream
			[353952] = {},
			--Wailing Arrow
			[347609] = {},
			--Veil of Darkness
--			[347726] = {},
		},
	},
}

function mod:OnCombatStart(delay)
	table.wipe(BarbedStacks)
	table.wipe(castsPerGUID)
	self:SetStage(1)
	self.vb.winrunnerCount = 0
	self.vb.dominationChainsCount = 0
	self.vb.veilofDarknessCount = 0
	self.vb.wailingArrowCount = 0
	self.vb.addIcon = 8
	if self:IsMythic() then
		difficultyName = "mythic"
	else
		if self:IsHeroic() then
			difficultyName = "heroic"
		elseif self:IsNormal() then
			difficultyName = "normal"
		else
			difficultyName = "lfr"
		end
	end
	timerWindrunnerCD:Start(8.4-delay, 1)
--	timerShadowDaggerCD:Start(-delay)
	timerDominationChainsCD:Start(28.3-delay, 1)
	timerVeilofDarknessCD:Start(46.7-delay, 1)
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

function mod:OnTimerRecovery()
	if self:IsMythic() then
		difficultyName = "mythic"
	elseif self:IsHeroic() then
		difficultyName = "heroic"
	elseif self:IsNormal() then
		difficultyName = "normal"
	else
		difficultyName = "lfr"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 349419 then
		self.vb.dominationChainsCount = self.vb.dominationChainsCount + 1
		specWarnDominationChains:Show(self.vb.dominationChainsCount)
		specWarnDominationChains:Play("watchstep")
		timerDominationChainsCD:Start(nil, self.vb.dominationChainsCount+1)
--	elseif spellId == 347726 then
--		self.vb.veilofDarknessCount = self.vb.veilofDarknessCount + 1
--		timerVeilofDarknessCD:Start()
	elseif spellId == 347609 then
		self.vb.wailingArrowCount = self.vb.wailingArrowCount + 1
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.wailingArrowCount+1]
		if timer then
			timerWailingArrowCD:Start(timer,  self.vb.wailingArrowCount+1)
		end
	elseif spellId == 352663 then
		warnRangersHeartseeker:Show()
	elseif (spellId == 353418 or spellId == 353417) then--Rive
		self.vb.riveCount = self.vb.riveCount + 1
		warnRive:Show(self.vb.riveCount)
	elseif spellId == 348094 then
		specWarnBansheeWail:Show()
		specWarnBansheeWail:Play("scatter")
	elseif spellId == 355540 then
		specWarnRuin:Show()
		specWarnRuin:Play("kickcast")
--		timerRuinCD:Start()
	elseif spellId == 352271 then
		self.vb.hauntingWavecount = self.vb.hauntingWavecount + 1
		specWarnHauntingWave:Show(self.vb.hauntingWavecount)
		specWarnHauntingWave:Play("watchwave")
--		timerHauntingWaveCD:Start()
	elseif spellId == 351075 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		if self:AntiSpam(3, 1) then--If multiple cast it at same time
			warnUnstoppableForce:Show(castsPerGUID[args.sourceGUID])
		end
--	elseif spellId == 351179 then
--		timerAbsorbingChargeCD:Start(18.3, args.sourceGUID)

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
		self.vb.baneArrowCount = self.vb.baneArrowCount + 1
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.baneArrowCount+1]
		if timer then
			timerBaneArrowsCD:Start(timer,  self.vb.baneArrowCount+1)
		end
	elseif spellId == 353969 then
		warnBansheesHeartseeker:Show()
	elseif spellId == 354068 then
		self.vb.bansheesFuryCount = self.vb.bansheesFuryCount + 1
--		timerBansheesFuryCD:Start()
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
		self.vb.bansheeScreamCount = self.vb.bansheeScreamCount + 1
		local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.bansheeScreamCount+1]
		if timer then
			timerBansheesScreamCD:Start(timer, self.vb.bansheeScreamCount+1)
		end
	elseif spellId == 353935 then
		if self.vb.phase == 3 then
			self.vb.shadowDaggerCount = self.vb.shadowDaggerCount + 1
			local timer = allTimers[difficultyName][self.vb.phase][spellId][self.vb.shadowDaggerCount+1]
			if timer then
				timerShadowDaggerCD:Start(timer,  self.vb.shadowDaggerCount+1)
			end
		end
	elseif spellId == 354147 then
		self.vb.razeCount = self.vb.razeCount + 1
		specWarnRaze:Show(self.vb.razeCount)
		specWarnRaze:Play("justrun")
--		timerRazeCD:Start(nil, self.vb.razeCount+1)
		--TODO, maybe reset cast counts here for each platform, or another specific trigger
	elseif spellId == 357102 then--Raid Portal: Oribos
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		self:SetStage(3)
		self.vb.baneArrowCount = 0
		self.vb.shadowDaggerCount = 0
		self.vb.bansheeScreamCount = 0
		self.vb.bansheesFuryCount = 0
		self.vb.veilofDarknessCount = 0--Used only once per platform but might as well count it
		self.vb.wailingArrowCount = 0
		self.vb.razeCount = 0
--		timerRuinCD:Stop()
--		timerHauntingWaveCD:Stop()
--		timerVeilofDarknessCD:Stop()
		timerBaneArrowsCD:Start(19.6, 1)
		timerShadowDaggerCD:Start(22.2, 1)
		timerBansheesScreamCD:Start(27.8, 1)
		timerWailingArrowCD:Start(49, 1)
		timerVeilofDarknessCD:Start(46, 1)
		timerBansheesFuryCD:Start(65.6, 1)
		timerRazeCD:Start(72.6, 1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 351178 then
		if args:IsPlayer() then
			specWarnLashingStrike:Show()
			specWarnLashingStrike:Play("targetyou")
			yellLashingStrike:Yell()
		else
			warnLashingStrike:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 347504 then
		self.vb.winrunnerCount = self.vb.winrunnerCount + 1
		specWarnWindrunner:Show(self.vb.winrunnerCount)
		specWarnWindrunner:Play("specialsoon")
		timerWindrunnerCD:Start(nil, self.vb.winrunnerCount+1)
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
	elseif spellId == 348064 then
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
		self:SetStage(1.5)--Intermission to phase 2
		self.vb.dominationChainsCount = 0
		self.vb.riveCount = 0
		timerWindrunnerCD:Stop()
		timerDominationChainsCD:Stop()
		timerVeilofDarknessCD:Stop()
		timerDominationChainsCD:Start(1.5, 1)--Practically right away
		timerRiveCD:Start(11.2)--Init timer only, for when the spam begins
		timerNextPhase:Start(61)
	elseif spellId == 348146 and self.vb.phase < 2 then
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		self:SetStage(2)
		self.vb.veilofDarknessCount = 0
		self.vb.icecrownCast = 0
		self.vb.hauntingWavecount = 0
		timerDominationChainsCD:Stop()
		timerNextPhase:Stop()
		--Phase 2 timers a waste of time at this point since it was so buggy
--		timerRuinCD:Start(63.5)
--		timerHauntingWaveCD:Start(33.1)
--		timerVeilofDarknessCD:Start(3, 1)--Not in combat log in phase 2 and beyond so unless players fuck up mechanic can't get timer for it
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
	elseif spellId == 356986 then
		self.vb.icecrownCast = self.vb.icecrownCast + 1
		warnWindsofIcecrown:Show(self.vb.icecrownCast, args.destName)
		timerWindsofIcecrown:Start()
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
	elseif spellId == 356986 then
		timerWindsofIcecrown:Stop()
--		timerHauntingWaveCD:Start(15.6)
--		timerRuinCD:start(68.8)
--	elseif spellId == 348146 then

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

--"<55.31 21:07:27> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\Icons\\Ability_Argus_DeathFog.blp:20|t %s begins to cast |cFFFF0000|Hspell:347704|h[Veil of Darkness]|h|r!#Sylvanas Windrunner#####0#0##0#30#nil#0#false#false#false#false", -- [1092]
--"<57.93 21:07:29> [CLEU] SPELL_CAST_START#Vehicle-0-2083-2450-4126-175732-00002FED6E#Sylvanas Windrunner##nil#347726#Veil of Darkness#nil#nil", -- [1151]
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:347704") then--Faster than Combat log by 2.5 seconds in phase 1 and doesn't exist in combat log at all in phase 3 because reasons
		self.vb.veilofDarknessCount = self.vb.veilofDarknessCount + 1
		specWarnVeilofDarkness:Show(self.vb.veilofDarknessCount)
		specWarnVeilofDarkness:Play("watchstep")
		--Do nothing in phase 2 right now
		--Phase 2 is a clusterfuck
		--Phase 3 it's only cast once per platform so doesn't need timer start here either
		if self.vb.phase == 1 then
			timerVeilofDarknessCD:Start(48.8, self.vb.wailingArrowCount+1)
--		elseif self.vb.phase == 3 then
--			local timer = allTimers[difficultyName][self.vb.phase][347726][self.vb.veilofDarknessCount+1]
--			if timer then
--				timerVeilofDarknessCD:Start(timer, self.vb.wailingArrowCount+1)
--			end
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
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 3) then
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
