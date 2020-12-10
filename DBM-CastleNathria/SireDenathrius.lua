local mod	= DBM:NewMod(2424, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(167406)
mod:SetEncounterID(2407)
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20201210000000)--2020, 12, 10
mod:SetMinSyncRevision(20201210000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 326707 326851 327227 328117 329181 333932",
	"SPELL_CAST_SUCCESS 327039 327796 329943 339196 330042 326005 332849 333980 329205 332619",
	"SPELL_AURA_APPLIED 326699 338510 327039 327796 327992 329906 332585 329951 332794 329205 329181",
	"SPELL_AURA_APPLIED_DOSE 326699 329906 332585",
	"SPELL_AURA_REMOVED 326699 338510 327039 327796 328117 329951 332794",
	"SPELL_AURA_REMOVED_DOSE 326699",
	"SPELL_PERIODIC_DAMAGE 327992",
	"SPELL_PERIODIC_MISSED 327992",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, any reason to track https://shadowlands.wowhead.com/spell=328839 ? gained each ravage cast
--TODO, add mythic stuff to mod, which I glanced over to get heroic mod ready faster.
--TODO, warnings and timers for Crimson Cabalist? All that stuff seems passive so nothing to really do for it besides Crescendo maybe
--TODO, fine tune Carnage stacks
--TODO, when boss commands Remornia, does it affect remornia's normal cast sequence/timers
--TODO, https://shadowlands.wowhead.com/spell=336008/smoldering-ire need anything special?
--TODO, verify spellIds for two different blood prices, and make sure there isn't overlap/double triggering for any of them
--TODO, handle sinister reflection better? for time being sub warnings don't exist, just a generic dodge warning for reflection spawn itself
--[[
(ability.id = 326707 or ability.id = 326851 or ability.id = 327227 or ability.id = 328117 or ability.id = 329181 or ability.id = 333932) and type = "begincast"
 or (ability.id = 326851 or ability.id = 327796 or ability.id = 329943 or ability.id = 339196 or ability.id = 330042 or ability.id = 326005 or ability.id = 332849 or ability.id = 333980 or ability.id = 329205 or ability.id = 332619) and type = "cast"
 or ability.id = 332794 and type = "applydebuff"
 or ability.id = 328117
--]]
--General
local warnPhase									= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Stage One: Sinners Be Cleansed
local warnBloodPrice							= mod:NewCountAnnounce(326851, 4)
local warnFeedingTime							= mod:NewTargetAnnounce(327039, 2)--On this difficulty you don't need to help soak it so don't really NEED to know who it's on
local warnNightHunter							= mod:NewTargetNoFilterAnnounce(327796, 4)--General announce, if target special warning not enabled
--Stage Two: The Crimson Chorus
----Crimson Cabalist and horsemen
local warnCrimsonCabalists						= mod:NewSpellAnnounce("ej22131", 2, 329711)
local warnCrescendo								= mod:NewSpellAnnounce(336162, 3)
----Remornia
local warnCarnage								= mod:NewStackAnnounce(329906, 2, nil, "Tank|Healer")
local warnImpale								= mod:NewTargetAnnounce(329951, 2)
----Sire Denathrius
--Stage Three: Indignation
local warnScorn									= mod:NewStackAnnounce(332585, 2, nil, "Tank|Healer")
local warnFatalFinesse							= mod:NewTargetNoFilterAnnounce(332794, 2)
--Mythic?
local warnBalefulResonance						= mod:NewTargetNoFilterAnnounce(329205, 2)

--Stage One: Sinners Be Cleansed
local specWarnCleansingPain						= mod:NewSpecialWarningCount(326707, nil, nil, nil, 2, 2)
local specWarnFeedingTime						= mod:NewSpecialWarningMoveAway(327039, nil, nil, nil, 1, 2)--Normal/LFR
local yellFeedingTime							= mod:NewYell(327039)--Normal/LFR
local yellFeedingTimeFades						= mod:NewFadesYell(327039)--Normal/LFR
local specWarnNightHunter						= mod:NewSpecialWarningYouPos(327796, nil, nil, nil, 1, 2, 3)--Heroic/Mythic
local yellNightHunter							= mod:NewPosYell(327796)--Heroic/Mythic (not red on purpose, you do NOT want to be anywhere near victim, you want to soak the line before victim)
local yellNightHunterFades						= mod:NewIconFadesYell(327796)--Heroic/Mythic (not red on purpose, you do NOT want to be anywhere near victim, you want to soak the line before victim)
local specWarnNightHunterTarget					= mod:NewSpecialWarningTarget(327796, false, nil, nil, 1, 2, 3)--Opt in, for people who are assigned to this soak
local specWarnCommandRavage						= mod:NewSpecialWarningCount(327227, nil, nil, nil, 2, 2)
--local specWarnMindFlay						= mod:NewSpecialWarningInterrupt(310552, "HasInterrupt", nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(327992, nil, nil, nil, 1, 8)
--Intermission: March of the Penitent
local specWarnMarchofthePenitent				= mod:NewSpecialWarningSpell(328117, nil, nil, nil, 2, 2)
--Stage Two: The Crimson Chorus
----Crimson Cabalist and horsemen
local specWarnCrescendo							= mod:NewSpecialWarningDodge(336162, false, nil, nil, 2, 2)
----Remornia
local specWarnCarnage							= mod:NewSpecialWarningStack(329906, nil, 6, nil, nil, 1, 6)
local specWarnCarnageOther						= mod:NewSpecialWarningTaunt(329906, nil, nil, nil, 1, 6)
local specWarnImpale							= mod:NewSpecialWarningMoveAway(329951, nil, nil, nil, 1, 2)
local yellImpale								= mod:NewPosYell(329951)
local yellImpaleFades							= mod:NewIconFadesYell(329951)
----Sire Denathrius
local specWarnWrackingPain						= mod:NewSpecialWarningDefensive(329181, "Tank", nil, nil, 1, 2)--Change to defensive if it can't be dodged
local specWarnWrackingPainTaunt					= mod:NewSpecialWarningTaunt(329181, nil, nil, nil, 1, 2)
local specWarnHandofDestruction					= mod:NewSpecialWarningRun(333932, nil, nil, nil, 4, 2)
local specWarnCommandMassacre					= mod:NewSpecialWarningDodgeCount(330042, nil, nil, nil, 2, 2)
--Stage Three: Indignation
local specWarnScorn								= mod:NewSpecialWarningStack(332585, nil, 6, nil, nil, 1, 6)
local specWarnScorneOther						= mod:NewSpecialWarningTaunt(332585, nil, nil, nil, 1, 6)
local specWarnShatteringPain					= mod:NewSpecialWarningCount(332619, nil, nil, nil, 2, 2)
local specWarnFatalfFinesse						= mod:NewSpecialWarningMoveAway(332794, nil, nil, nil, 1, 2)
local yellFatalfFinesse							= mod:NewPosYell(332794)
local yellFatalfFinesseFades					= mod:NewIconFadesYell(332794)
--Mythic Phase?
local specWarnBalefulResonance					= mod:NewSpecialWarningMoveAway(329205, nil, nil, nil, 1, 2, 4)--Mythic?
local yellBalefulResonance						= mod:NewYell(329205)--Mythic?
local yellBalefulResonanceFades					= mod:NewFadesYell(329205)--Mythic?

--Stage One: Sinners Be Cleansed
--mod:AddTimerLine(BOSS)
local timerCleansingPainCD						= mod:NewNextCountTimer(16.6, 326707, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON, nil, 2, 3)
local timerBloodPriceCD							= mod:NewCDCountTimer(57.3, 326851, nil, nil, nil, 2, nil, DBM_CORE_L.HEALER_ICON)
local timerFeedingTimeCD						= mod:NewAITimer(44.3, 327039, nil, nil, nil, 3)--Normal/LFR
local timerNightHunterCD						= mod:NewNextCountTimer(44.3, 327796, nil, nil, nil, 3, nil, DBM_CORE_L.HEROIC_ICON)--Heroic/mythic
local timerCommandRavageCD						= mod:NewCDCountTimer(57.2, 327227, 327122, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON, nil, 1, 4)--ShortName "Ravage" (the actual cast)
--Intermission: March of the Penitent
local timerNextPhase							= mod:NewPhaseTimer(16.5, 328117, nil, nil, nil, 6, nil, nil, nil, 1, 4)
--Stage Two: The Crimson Chorus
----Crimson Cabalist and horsemen
local timerCrimsonCabalistsCD					= mod:NewNextCountTimer(44.3, "ej22131", nil, nil, nil, 1, 329711)
----Remornia
local timerImpaleCD								= mod:NewNextCountTimer(44.3, 329951, nil, nil, nil, 3)
----Sire Denathrius
local timerWrackingPainCD						= mod:NewNextCountTimer(16.6, 329181, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerHandofDestructionCD					= mod:NewCDCountTimer(44.3, 333932, nil, nil, nil, 2)
local timerCommandMassacreCD					= mod:NewCDCountTimer(49.8, 330042, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)--47.4-51
--Stage Three: Indignation
local timerShatteringPainCD						= mod:NewCDTimer(23.1, 332619, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerFatalFitnesseCD						= mod:NewCDCountTimer(22, 332794, nil, nil, nil, 3)
--local timerSinisterReflectionCD				= mod:NewAITimer(44.3, 333979, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)
mod:AddTimerLine(PLAYER_DIFFICULTY6)
local timerBalefulResonanceCD					= mod:NewAITimer(22, 329205, nil, nil, nil, 3)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
mod:AddInfoFrameOption(326699, true)
mod:AddSetIconOption("SetIconOnNightHunter", 327796, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnImpale", 329951, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnFatalFinesse", 332794, true, false, {1, 2, 3})
--mod:AddNamePlateOption("NPAuraOnSpiteful", 338510)

mod.vb.phase = 1
mod.vb.priceCount = 0
mod.vb.painCount = 0
mod.vb.RavageCount = 0
mod.vb.MassacreCount = 0
mod.vb.ImpaleCount = 0
mod.vb.HandCount = 0
mod.vb.addCount = 0
mod.vb.DebuffCount = 0
mod.vb.DebuffIcon = 1
local P3Transition = false
local SinStacks = {}
local Timers = {
	[1] = {
		--Night Hunter
		[327796] = {12.3, 25, 30, 28, 30, 28},
		--Cleansing Pain (P1)
		[326707] = {5.9, 24.4, 32.8, 25.6, 32.8, 25.5},
	},
	[2] = {
		--Impale
		[329943] = {27.5, 26, 27, 23, 32, 18, 39},
		--Hand of Destruction P2
		[333932] = {47.6, 40.9, 40, 57},
		--Adds P2
		[12345] = {9.7, 85, 55},
	},
	[3] = {
		--Hand of Destruction P3
		[333932] = {27.6, 88, 31.7, 47.5},
		--Fatal Finesse P3
		[332794] = {17.5, 48, 6, 21, 27, 19, 26, 21, 40},
		--Cleansing Pain (P3 Mythic)
		[326707] = {},
	}
}

function mod:OnCombatStart(delay)
	table.wipe(SinStacks)
	self.vb.phase = 1
	self.vb.priceCount = 0
	self.vb.painCount = 0
	self.vb.RavageCount = 0
	self.vb.MassacreCount = 0
	self.vb.ImpaleCount = 0
	self.vb.HandCount = 0
	self.vb.addCount = 0
	self.vb.DebuffCount = 0
	self.vb.DebuffIcon = 1
	P3Transition = false
	timerCleansingPainCD:Start(6-delay, 1)
	timerBloodPriceCD:Start(22.3-delay, 1)
	timerCommandRavageCD:Start(50.5-delay, 1)
	if self:IsHard() then
		timerNightHunterCD:Start(12.1-delay, 1)
	else
		timerFeedingTimeCD:Start(1-delay)
	end
--	if self.Options.NPAuraOnSpiteful then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Show(4)--For Acid Splash
--	end
--	berserkTimer:Start(-delay)--Confirmed normal and heroic
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(326699))
		DBM.InfoFrame:Show(self:IsHard() and 30 or 10, "table", SinStacks, 1)--Show everyone on heroic+, filter down to 10 on normal/lfr
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.NPAuraOnSpiteful then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 326707 then--Sire Cleansing Pain
		self.vb.painCount = self.vb.painCount + 1
		specWarnCleansingPain:Show(self.vb.painCount)
		specWarnCleansingPain:Play("shockwave")
		local timer = Timers[self.vb.phase][spellId][self.vb.painCount+1]
		if timer then--Use scripted timer but if running out of script fall back to the 32/24 alternation
			timerCleansingPainCD:Start(timer or self.vb.painCount % 2 == 0 and 32.5 or 24.4, self.vb.painCount+1)
		end
	elseif spellId == 326851 then
		self.vb.priceCount = self.vb.priceCount + 1
		warnBloodPrice:Show(self.vb.priceCount)
		timerBloodPriceCD:Start(nil, self.vb.priceCount+1)
	elseif spellId == 327227 then
		self.vb.RavageCount = self.vb.RavageCount + 1
		specWarnCommandRavage:Show(self.vb.RavageCount)
		specWarnCommandRavage:Play("specialsoon")
		timerCommandRavageCD:Start(57.4, self.vb.RavageCount+1)
	elseif spellId == 328117 then--March of the Penitent (first intermission)
		self.vb.phase = 1.5
		specWarnMarchofthePenitent:Show()
		timerCleansingPainCD:Stop()
		timerBloodPriceCD:Stop()
		timerCommandRavageCD:Stop()
		timerNightHunterCD:Stop()
		timerFeedingTimeCD:Stop()
		timerNextPhase:Start(16.5)
	elseif spellId == 329181 then
		self.vb.painCount = self.vb.painCount + 1
		specWarnWrackingPain:Show()
		specWarnWrackingPain:Play("shockwave")
		--"Wracking Pain-329181-npc:167406 = pull:197.3, 19.5, 20.6, 19.5, 20.8, 19.5, 20.6, 19.4, 20.6", -- [10]
		timerWrackingPainCD:Start(self.vb.painCount % 2 == 0 and 20.6 or 19.4, self.vb.painCount+1)
	elseif spellId == 333932 and self:AntiSpam(10, 10) then
		self.vb.HandCount = self.vb.HandCount + 1
		specWarnHandofDestruction:Show()
		specWarnHandofDestruction:Play("justrun")
		local timer = Timers[self.vb.phase][spellId][self.vb.HandCount+1] or 41.2--Or part may not be accurate
		if timer then
			timerHandofDestructionCD:Start(timer, self.vb.HandCount+1)
		end
--	elseif spellId == 337785 then--Echo Cleansing Pain
--		specWarnCleansingPain:Show(0)
--		specWarnCleansingPain:Play("shockwave")
--	elseif spellId == 337857 then--Echo Hand of Destruction
--		specWarnHandofDestruction:Show()
--		specWarnHandofDestruction:Play("justrun")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 327039 then
		timerFeedingTimeCD:Start()
	elseif spellId == 327796 and self:AntiSpam(5, 1) then
		self.vb.DebuffIcon = 1
		self.vb.DebuffCount = self.vb.DebuffCount + 1
		local timer = Timers[self.vb.phase][spellId][self.vb.DebuffCount+1]
		if timer then
			timerNightHunterCD:Start(timer, self.vb.DebuffCount+1)
		end
	elseif spellId == 329943 then
		self.vb.DebuffIcon = 1
		self.vb.ImpaleCount = self.vb.ImpaleCount + 1
		local timer = Timers[self.vb.phase][spellId][self.vb.ImpaleCount+1]
		if timer then
			timerImpaleCD:Start(timer, self.vb.ImpaleCount+1)
		end
	elseif spellId == 339196 and self.vb.phase == 3 then
		self.vb.priceCount = self.vb.priceCount + 1
		warnBloodPrice:Show(self.vb.priceCount)
		timerBloodPriceCD:Start(nil, self.vb.priceCount+1)
	elseif spellId == 330042 then
		self.vb.MassacreCount = self.vb.MassacreCount + 1
		specWarnCommandMassacre:Show(self.vb.MassacreCount)
		specWarnCommandMassacre:Play("watchstep")--Perhaps farfromline?
		timerCommandMassacreCD:Start(47.4, self.vb.MassacreCount+1)
	elseif spellId == 326005 then
		self.vb.phase = 3
		self.vb.priceCount = 0
		self.vb.painCount = 0--reused for shattering pain
		self.vb.RavageCount = 0
		self.vb.MassacreCount = 0
		self.vb.DebuffCount = 0
		self.vb.HandCount = 0
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		--Remornia
		timerImpaleCD:Stop()
		--Denathrius
		timerWrackingPainCD:Stop()
		timerHandofDestructionCD:Stop()
		timerCommandMassacreCD:Stop()
		timerCrimsonCabalistsCD:Stop()
		timerShatteringPainCD:Start(13.3, 1)--SUCCESS
		timerFatalFitnesseCD:Start(17.4, 1)--SUCCESS/APPLIED
		timerHandofDestructionCD:Start(27.6, 1)--27-29
--		timerBloodPriceCD:Start(3)
--		timerSinisterReflectionCD:Start(40.8)
		timerCommandRavageCD:Start(50, 1)--Seems ravage always first Reflection
	elseif spellId == 332849 then--Reflection: Ravage
		self.vb.RavageCount = self.vb.RavageCount + 1
		specWarnCommandRavage:Show(self.vb.RavageCount)
		specWarnCommandRavage:Play("specialsoon")
		timerCommandMassacreCD:Start(40, self.vb.MassacreCount+1)
	elseif spellId == 333980 then
		self.vb.MassacreCount = self.vb.MassacreCount + 1
		specWarnCommandMassacre:Show(self.vb.MassacreCount)
		specWarnCommandMassacre:Play("watchstep")--Perhaps farfromline?
		timerCommandRavageCD:Start(40, self.vb.RavageCount+1)
	elseif spellId == 329205 then
		timerBalefulResonanceCD:Start()
	elseif spellId == 332619 then
		self.vb.painCount = self.vb.painCount + 1
		specWarnShatteringPain:Show(self.vb.painCount)
		--if self:IsTanking("player", "boss1", nil, true) then
	--		specWarnShatteringPain:Play("defensive")
		--else
			specWarnShatteringPain:Play("carefly")
	--	end
		timerShatteringPainCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 326699 then
		local amount = args.amount or 1
		SinStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(SinStacks)
		end
	elseif spellId == 338510 then
		if self.Options.NPAuraOnShield then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 14)
		end
--	elseif spellId == 326851 then--Blood Price
		--local affectedCount = SinStacks[args.destName]
		--for name, count in pairs(SinStacks) do
			--if count == affectedCount then

			--end
		--end
	elseif spellId == 327039 then
		if args:IsPlayer() then
			specWarnFeedingTime:Show()
			specWarnFeedingTime:Play("runout")
			yellFeedingTime:Yell()
			yellFeedingTimeFades:Countdown(spellId)
		else
			warnFeedingTime:Show(args.destName)
		end
	elseif spellId == 327796 then
		local icon = self.vb.DebuffIcon
		if args:IsPlayer() then
			--Unschedule target warning if you've become one of victims
			specWarnNightHunterTarget:Cancel()
			specWarnNightHunterTarget:CancelVoice()
			--Now show your warnings
			specWarnNightHunter:Show(self:IconNumToTexture(icon))
			specWarnNightHunter:Play("mm"..icon)
			yellNightHunter:Yell(icon, icon, icon)
			yellNightHunterFades:Countdown(spellId, nil, icon)
		elseif self.Options.SpecWarn327796target then
			--Don't show special warning if you're one of victims
			if not DBM:UnitDebuff("player", spellId) then
				specWarnNightHunterTarget:CombinedShow(0.5, args.destName)
				specWarnNightHunterTarget:ScheduleVoice(0.5, "helpsoak")
			end
		else
			warnNightHunter:Cancel()
			warnNightHunter:CombinedShow(0.5, args.destName)
		end
		if self.Options.SetIconOnNightHunter then
			self:SetIcon(args.destName, icon)
		end
		self.vb.DebuffIcon = self.vb.DebuffIcon + 1
		if self.vb.DebuffIcon > 8 then
			self.vb.DebuffIcon = 1
			DBM:AddMsg("Cast event for Night Hunter is wrong, doing backup icon reset")
		end
	elseif spellId == 327992 and args:IsPlayer() and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 329906 then
		local amount = args.amount or 1
		if (amount % 3 == 0) then
			if amount >= 6 then
				if args:IsPlayer() then
					specWarnCarnage:Show(amount)
					specWarnCarnage:Play("stackhigh")
				else
					--Don't show taunt warning if you're 3 tanking and aren't near the boss (this means you are the add tank)
					--Show taunt warning if you ARE near boss, or if number of alive tanks is less than 3
					if (self:CheckNearby(8, args.destName) or self:GetNumAliveTanks() < 3) and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then--Can't taunt less you've dropped yours off, period.
						specWarnCarnageOther:Show(args.destName)
						specWarnCarnageOther:Play("tauntboss")
					else
						warnCarnage:Show(args.destName, amount)
					end
				end
			else
				warnCarnage:Show(args.destName, amount)
			end
		end
	elseif spellId == 332585 then
		local amount = args.amount or 1
		if (amount % 3 == 0) then
			if amount >= 6 then
				if args:IsPlayer() then
					specWarnScorn:Show(amount)
					specWarnScorn:Play("stackhigh")
				else
					--Don't show taunt warning if you're 3 tanking and aren't near the boss (this means you are the add tank)
					--Show taunt warning if you ARE near boss, or if number of alive tanks is less than 3
					if (self:CheckNearby(8, args.destName) or self:GetNumAliveTanks() < 3) and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then--Can't taunt less you've dropped yours off, period.
						specWarnScorneOther:Show(args.destName)
						specWarnScorneOther:Play("tauntboss")
					else
						warnScorn:Show(args.destName, amount)
					end
				end
			else
				warnScorn:Show(args.destName, amount)
			end
		end
	elseif spellId == 329951 then
		warnImpale:CombinedShow(0.3, args.destName)
		local icon = self.vb.DebuffIcon
		if args:IsPlayer() then
			specWarnImpale:Show()
			specWarnImpale:Play("runout")
			yellImpale:Yell(icon, icon, icon)
			yellImpaleFades:Countdown(spellId, nil, icon)
		end
		if self.Options.SetIconOnImpale then
			self:SetIcon(args.destName, icon)
		end
		self.vb.DebuffIcon = self.vb.DebuffIcon + 1
	elseif spellId == 332794 then
		if self:AntiSpam(10, 4) then
			self.vb.DebuffIcon = 1
			self.vb.DebuffCount = self.vb.DebuffCount + 1
			local timer = Timers[self.vb.phase][spellId][self.vb.DebuffCount+1]
			if timer then
				timerFatalFitnesseCD:Start(timer, self.vb.DebuffCount+1)
			end
		end
		local icon = self.vb.DebuffIcon
		warnFatalFinesse:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFatalfFinesse:Show()
			specWarnFatalfFinesse:Play("runout")
			yellFatalfFinesse:Yell(icon, icon, icon)
			yellFatalfFinesseFades:Countdown(spellId, nil, icon)
		end
		if self.Options.SetIconOnFatalFinesse then
			self:SetIcon(args.destName, icon)
		end
		self.vb.DebuffIcon = self.vb.DebuffIcon + 1
	elseif spellId == 329205 then
		if args:IsPlayer() then
			specWarnBalefulResonance:Show()
			specWarnBalefulResonance:Play("runout")
			yellBalefulResonance:Yell()
			yellBalefulResonanceFades:Countdown(spellId)
		else
			warnBalefulResonance:Show(args.destName)
		end
	elseif spellId == 329181 then
		if not args:IsPlayer() then
			specWarnWrackingPainTaunt:Show(args.destName)
			specWarnWrackingPainTaunt:Play("tauntboss")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 326699 then
		SinStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(SinStacks)
		end
	elseif spellId == 338510 then
		if self.Options.NPAuraOnShield then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 327039 then
		if args:IsPlayer() then
			yellFeedingTimeFades:Cancel()
		end
	elseif spellId == 327796 then
		if args:IsPlayer() then
			yellNightHunterFades:Cancel()
		end
		if self.Options.SetIconOnNightHunter then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 328117 then--March of the Penitent
		self.vb.phase = 2
		self.vb.painCount = 0
		self.vb.DebuffCount = 0
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		--Remornia
		timerImpaleCD:Start(27.5, 1)
		--Denathrius
		timerCrimsonCabalistsCD:Start(9.7, 1)
		timerWrackingPainCD:Start(21.1, 1)
		timerHandofDestructionCD:Start(46.6, 1)
		timerCommandMassacreCD:Start(64.9, 1)
	elseif spellId == 329951 then
		if args:IsPlayer() then
			yellImpaleFades:Cancel()
		end
		if self.Options.SetIconOnImpale then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 332794 then
		if args:IsPlayer() then
			yellFatalfFinesseFades:Cancel()
		end
		if self.Options.SetIconOnFatalFinesse then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 326699 then
		SinStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(SinStacks)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 169196 and self:AntiSpam(3, 3) then--crimson-cabalist
		if self.Options.SpecWarn336162dodge then
			specWarnCrescendo:Show()
			specWarnCrescendo:Play("watchstep")
		else
			warnCrescendo:Show()
		end
	elseif cid == 169855 then--Remornia
		timerImpaleCD:Stop()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 327992 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.CrimsonSpawn or msg:find(L.CrimsonSpawn) then
		self:SendSync("CrimsonSpawn")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	--1 second faster than SPELL_CAST_START
	if spellId == 330613 and self:AntiSpam(10, 10) then--Script Activating to cast Hand of Destruction
		if not P3Transition then--We can't let a cast that slips through during Indignation screw up counts/timers
			self.vb.HandCount = self.vb.HandCount + 1
			local timer = Timers[self.vb.phase][333932][self.vb.HandCount+1]
			if timer then
				timerHandofDestructionCD:Start(timer, self.vb.HandCount+1)
			end
		end
		specWarnHandofDestruction:Show()
		specWarnHandofDestruction:Play("justrun")
	elseif spellId == 332749 and P3Transition then
		P3Transition = false
--	elseif spellId == 330939 and self.vb.phase == 3 then--Sinister Reflection

--	elseif spellId == 330885 then--Remornia P3 Transition (not currently needed, Insigniation works just fine)

	end
end

function mod:OnSync(msg)
	if not self:IsInCombat() then return end
	if msg == "CrimsonSpawn" then
		self.vb.addCount = self.vb.addCount + 1
		warnCrimsonCabalists:Show(self.vb.addCount)
		local timer = Timers[self.vb.phase][12345][self.vb.addCount+1]
		if timer then
			timerCrimsonCabalistsCD:Start(timer, self.vb.addCount+1)
		end
	end
end
