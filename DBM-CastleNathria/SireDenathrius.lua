local mod	= DBM:NewMod(2424, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(168938)
mod:SetEncounterID(2407)
mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20200112000000)--2020, 1, 12
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 326707 326851 327227 328117 329181 333932 330042 326005",
	"SPELL_CAST_SUCCESS 327039 327796 329951 332794 339196 333979",
	"SPELL_AURA_APPLIED 326699 338510 327039 327796 327992 329906 332585 332794 329951",
	"SPELL_AURA_APPLIED_DOSE 326699 329906 332585",
	"SPELL_AURA_REMOVED 326699 338510 327039 327796 328117 332794 329951",
	"SPELL_AURA_REMOVED_DOSE 326699",
	"SPELL_PERIODIC_DAMAGE 327992",
	"SPELL_PERIODIC_MISSED 327992",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, more fancy infoframe that will highlight all names that'll be affected by Blood Price when it expires
--TODO, custom warning for blood price if it affects multiple people
--TODO, any reason to track https://shadowlands.wowhead.com/spell=328839 ? gained each ravage cast
--TODO, add mythic stuff to mod, which I glanced over to get heroic mod ready faster.
--TODO, warnings and timers for Crimson Cabalist? All that stuff seems passive so nothing to really do for it besides Crescendo maybe
--TODO, fine tune Carnage stacks
--TODO, when boss commands Remornia, does it affect remornia's normal cast sequence/timers
--TODO, https://shadowlands.wowhead.com/spell=336008/smoldering-ire need anything special?
--TODO, verify spellIds for two different blood prices, and make sure there isn't overlap/double triggering for any of them
--TODO, handle sinister reflection better? for time being sub warnings don't exist, just a generic dodge warning for reflection spawn itself
--TODO, verify icon reset methods for all 3 icon debuffs
--General
local warnPhase									= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Stage One: Sinners Be Cleansed
local warnBloodPrice							= mod:NewSpellAnnounce(326851, 4)
--local warnBloodPrice							= mod:NewTargetCountAnnounce(326851, 3, nil, nil, nil, nil, nil, nil, true)--No Filter Warning
local warnFeedingTime							= mod:NewTargetAnnounce(327039, 2)--On this difficulty you don't need to help soak it so don't really NEED to know who it's on
local warnNightHunter							= mod:NewTargetNoFilterAnnounce(327796, 4)--General announce, if target special warning not enabled
--Stage Two: The Crimson Chorus
----Crimson Cabalist and horsemen
local warnCrescendo								= mod:NewSpellAnnounce(336162, 3)
----Remornia
local warnCarnage								= mod:NewStackAnnounce(329906, 2, nil, "Tank|Healer")
local warnImpale								= mod:NewTargetAnnounce(329951, 2)
----Sire Denathrius
--Stage Three: Indignation
local warnScorn									= mod:NewStackAnnounce(332585, 2, nil, "Tank|Healer")
local warnFatalFinesse							= mod:NewTargetNoFilterAnnounce(332794, 2)

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
----Remornia
local specWarnCarnage							= mod:NewSpecialWarningStack(329906, nil, 12, nil, nil, 1, 6)
local specWarnCarnageOther						= mod:NewSpecialWarningTaunt(329906, nil, nil, nil, 1, 6)
local specWarnImpale							= mod:NewSpecialWarningMoveAway(329951, nil, nil, nil, 1, 2)
local yellImpale								= mod:NewPosYell(329951)
local yellImpaleFades							= mod:NewIconFadesYell(329951)
----Sire Denathrius
local specWarnWrackingPain						= mod:NewSpecialWarningDodge(329181, "Tank", nil, nil, 1, 2)--Change to defensive if it can't be dodged
local specWarnHandofDestruction					= mod:NewSpecialWarningRun(333932, nil, nil, nil, 4, 2)
local specWarnCommandMassacre					= mod:NewSpecialWarningDodge(330042, nil, nil, nil, 2, 2)
--Stage Three: Indignation
local specWarnScorn								= mod:NewSpecialWarningStack(332585, nil, 12, nil, nil, 1, 6)
local specWarnScorneOther						= mod:NewSpecialWarningTaunt(332585, nil, nil, nil, 1, 6)
local specWarnShatteringPain					= mod:NewSpecialWarningCount(332619, nil, nil, nil, 2, 2)
local specWarnFatalfFinesse						= mod:NewSpecialWarningMoveAway(332794, nil, nil, nil, 1, 2)
local yellFatalfFinesse							= mod:NewPosYell(332794)
local yellFatalfFinesseFades					= mod:NewIconFadesYell(332794)
local specWarnSinisterReflection				= mod:NewSpecialWarningDodge(333979, nil, nil, nil, 3, 2)

--Stage One: Sinners Be Cleansed
--mod:AddTimerLine(BOSS)
local timerCleansingPainCD						= mod:NewAITimer(16.6, 326707, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON, nil, 2, 3)
local timerBloodPriceCD							= mod:NewAITimer(44.3, 326851, nil, nil, nil, 2, nil, DBM_CORE_L.HEALER_ICON)
local timerFeedingTimeCD						= mod:NewAITimer(44.3, 327039, nil, nil, nil, 3)--Normal/LFR
local timerNightHunterCD						= mod:NewAITimer(44.3, 327796, nil, nil, nil, 3, nil, DBM_CORE_L.HEROIC_ICON)--Heroic/mythic
local timerCommandRavageCD						= mod:NewAITimer(44.3, 327227, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)
--Intermission: March of the Penitent
local timerNextPhase							= mod:NewPhaseTimer(16.5, 328117, nil, nil, nil, 6, nil, nil, nil, 1, 4)
--Stage Two: The Crimson Chorus
----Remornia
local timerImpaleCD								= mod:NewAITimer(44.3, 329951, nil, nil, nil, 3)
----Sire Denathrius
local timerWrackingPainCD						= mod:NewAITimer(16.6, 329181, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerHandofDestructionCD					= mod:NewAITimer(44.3, 333932, nil, nil, nil, 2)
local timerCommandMassacreCD					= mod:NewAITimer(44.3, 330042, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)
--Stage Three: Indignation
local timerShatteringPainCD						= mod:NewAITimer(16.6, 332619, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerFatalFitnesseCD						= mod:NewAITimer(44.3, 332794, nil, nil, nil, 3)
local timerSinisterReflectionCD					= mod:NewAITimer(44.3, 333979, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
mod:AddInfoFrameOption(326699, true)
mod:AddSetIconOption("SetIconOnNightHunter", 327796, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnImpale", 329951, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnFatalFinesse", 332794, true, false, {1, 2, 3})
mod:AddNamePlateOption("NPAuraOnSpiteful", 338510)

local SinStacks = {}
--local playerDebuff = false
mod.vb.phase = 1
mod.vb.painCount = 0
mod.vb.RavageCount = 0
mod.vb.DebuffIcon = 1

function mod:OnCombatStart(delay)
	table.wipe(SinStacks)
--	playerDebuff = false
	self.vb.phase = 1
	self.vb.painCount = 0
	self.vb.RavageCount = 0
	self.vb.DebuffIcon = 1
	timerCleansingPainCD:Start(1-delay)
	timerBloodPriceCD:Start(1-delay)
	timerCommandRavageCD:Start(1-delay)
	if self:IsHard() then
		timerNightHunterCD:Start(1-delay)
	else
		timerFeedingTimeCD:Start(1-delay)
	end
	if self.Options.NPAuraOnSpiteful then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
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
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnSpiteful then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 326707 then--Sire Cleansing Pain
		self.vb.painCount = self.vb.painCount + 1
		specWarnCleansingPain:Show(self.vb.painCount)
		specWarnCleansingPain:Play("shockwave")
		timerCleansingPainCD:Start()
	elseif spellId == 326851 then
		timerBloodPriceCD:Start()
	elseif spellId == 327227 then
		self.vb.RavageCount = self.vb.RavageCount + 1
		specWarnCommandRavage:Show(self.vb.RavageCount)
		specWarnCommandRavage:Play("specialsoon")
		timerCommandRavageCD:Start()
	elseif spellId == 328117 then--March of the Penitent (first intermission)
		self.vb.phase = 1.5
		specWarnMarchofthePenitent:Show()
		timerCleansingPainCD:Stop()
		timerBloodPriceCD:Stop()
		timerCommandRavageCD:Stop()
		timerNightHunterCD:Stop()
		timerFeedingTimeCD:Stop()
		timerNextPhase:Start(16.5)
--		if playerDebuff then
			--Do some shit?
--		end
	elseif spellId == 329181 then
		specWarnWrackingPain:Show()
		specWarnWrackingPain:Play("shockwave")
		timerWrackingPainCD:Start()
	elseif spellId == 333932 then
		specWarnHandofDestruction:Show()
		specWarnHandofDestruction:Play("justrun")
		timerHandofDestructionCD:Start()
	elseif spellId == 330042 then
		specWarnCommandMassacre:Show()
		specWarnCommandMassacre:Play("watchstep")--Perhaps farfromline?
		timerCommandMassacreCD:Start()
	elseif spellId == 326005 then
		self.vb.phase = 3
		self.vb.painCount = 0--reused for shattering pain
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		--Remornia
		timerImpaleCD:Stop()
		--Denathrius
		timerWrackingPainCD:Stop()
		timerHandofDestructionCD:Stop()
		timerCommandMassacreCD:Stop()
		timerShatteringPainCD:Start(3)
		timerFatalFitnesseCD:Start(3)
		timerHandofDestructionCD:Start(3)
		timerBloodPriceCD:Start(3)
		timerSinisterReflectionCD:Start(3)
	elseif spellId == 332619 then
		self.vb.painCount = self.vb.painCount + 1
		specWarnShatteringPain:Show(self.vb.painCount)
		--if self:IsTanking("player", "boss1", nil, true) then
	--		specWarnShatteringPain:Play("defensive")
		--else
			specWarnShatteringPain:Play("carefly")
	--	end
		timerShatteringPainCD:Start()
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
	if spellId == 326851 then
		timerFeedingTimeCD:Start()
	elseif spellId == 327796 then
		self.vb.DebuffIcon = 1--Correct spot, if right event
		timerNightHunterCD:Start()
	elseif spellId == 329951 then
		self.vb.DebuffIcon = 1
		timerImpaleCD:Start()
	elseif spellId == 332794 then
		self.vb.DebuffIcon = 1
		timerFatalFitnesseCD:Start()
	elseif spellId == 339196 and self.vb.phase == 3 then
		warnBloodPrice:Show()
		timerBloodPriceCD:Start()
	elseif spellId == 333979 then
		specWarnSinisterReflection:Show()
		specWarnSinisterReflection:Play("watchstep")
		timerSinisterReflectionCD:Start()
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
--		if args:IsPlayer() then
--			playerDebuff = true
--		end
	elseif spellId == 338510 then
		if self.Options.NPAuraOnShield then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 14)
		end
	elseif spellId == 326851 then
		local affectedCount = SinStacks[args.destName]
		--warnBloodPrice:Show(args.destName, affectedCount)
		warnBloodPrice:Show()
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
			if amount >= 12 then
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
			if amount >= 12 then
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
		local icon = self.vb.DebuffIcon
		if args:IsPlayer() then
			specWarnFatalfFinesse:Show()
			specWarnFatalfFinesse:Play("runout")
			yellFatalfFinesse:Yell(icon, icon, icon)
			yellFatalfFinesseFades:Countdown(spellId, nil, icon)
		else
			warnFatalFinesse:Show(args.destName)
		end
		if self.Options.SetIconOnFatalFinesse then
			self:SetIcon(args.destName, icon)
		end
		self.vb.DebuffIcon = self.vb.DebuffIcon + 1
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
--		if args:IsPlayer() then
--			playerDebuff = false
--		end
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
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		--Remornia
		timerImpaleCD:Start(2)
		--Denathrius
		timerWrackingPainCD:Start(2)
		timerHandofDestructionCD:Start(2)
		timerCommandMassacreCD:Start(2)
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
		warnCrescendo:Show()
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

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 310351 then

	end
end
--]]
