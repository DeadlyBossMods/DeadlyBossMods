local mod	= DBM:NewMod(2425, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(165318, 170323)
mod:SetEncounterID(2417)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3)
mod:SetBossHPInfoToHighest()
--mod:SetHotfixNoticeRev(20200112000000)--2020, 1, 12
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 333387 334765 334929 334004 334498 339690 339728 337741 339398 339164 334009",
	"SPELL_CAST_SUCCESS 334541 332150",
	"SPELL_AURA_APPLIED 329636 333913 334765 338156 338153 329808 334541 334616",
	"SPELL_AURA_APPLIED_DOSE 333913",
	"SPELL_AURA_REMOVED 329636 333913 334765 329808 334541",
	"SPELL_AURA_REMOVED_DOSE 333913",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
	"RAID_BOSS_WHISPER"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--https://shadowlands.wowhead.com/spell=334616/petrified
--TODO, verify boss Ids, multiple exist
--TODO, fix Wicked Blade targeting and if fix valid, icon mark them
--TODO, does Wicked Lactation stack? if not, rethink infoframe
--TODO, Serrated Swipe a tank mechanic or a random target one? seems too fast of cast for random
--TODO, optimize events for formations to eliminate antispam calls
--TODO, alternate the Stratagem timers, don't overlap them like AI timers require
--TODO, verify leap scripts. 334004 is a parent script, if used it's probably used in all difficulties 339164 is an easy mode sub script (removes mechanic) and 334009 is heroic/mythic sub script
--General Kaal
local warnBasaltForm							= mod:NewTargetNoFilterAnnounce(329636, 2)
local warnBasaltFormOver						= mod:NewEndAnnounce(329636, 1)
local warnWickedBlade							= mod:NewTargetNoFilterAnnounce(333376, 4)
local warnStoneShatterer						= mod:NewTargetNoFilterAnnounce(334765, 4)
--General Grashaal
local warnGraniteForm							= mod:NewTargetNoFilterAnnounce(329808, 2)
local warnGraniteFormOver						= mod:NewEndAnnounce(329808, 1)
local warnReverberatingLeap						= mod:NewTargetNoFilterAnnounce(334004, 3)
local warnCurseofPetrification					= mod:NewTargetNoFilterAnnounce(334541, 4)
local warnPulverize								= mod:NewCastAnnounce(339728, 3)
--Intermission Adds
local warnBreathofCorruption					= mod:NewCastAnnounce(337741, 3)

--General Kaal
local specWarnWickedBlade						= mod:NewSpecialWarningYou(333376, nil, nil, nil, 1, 2)
local yellWickedBlade							= mod:NewYell(333376)
local yellWickedBladeFades						= mod:NewFadesYell(333376)
local specWarnStoneShatterer					= mod:NewSpecialWarningYou(334765, false, nil, nil, 1, 2)
local yellStoneShattererFades					= mod:NewFadesYell(334765)
local specWarnSerratedSwipe						= mod:NewSpecialWarningDefensive(334929, nil, nil, nil, 1, 2)
local specWarnOutFlankStratagem					= mod:NewSpecialWarningCount(338156, nil, DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.spell:format(338156), nil, 2, 2, 4)--Keep Together
local specWarnTightFormationStratagem			= mod:NewSpecialWarningCount(338153, nil, DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.spell:format(338153), nil, 2, 2, 4)--Keep Apart
--local specWarnMutteringsofBetrayal			= mod:NewSpecialWarningStack(310563, nil, 3, nil, nil, 1, 6)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)
--General Grashaal
local specWarnReverberatingLeap					= mod:NewSpecialWarningMoveAway(334004, nil, nil, nil, 1, 2)
local yellReverberatingLeap						= mod:NewYell(334004, 183611)--Short text "Leap"
local yellReverberatingLeapFades				= mod:NewFadesYell(334004, 183611)--Short text "Leap"
local specWarnSeismicUpheaval					= mod:NewSpecialWarningDodge(334498, nil, nil, nil, 2, 2)
local specWarnCurseofPetrification				= mod:NewSpecialWarningYou(334541, nil, nil, nil, 3, 2)
local yellCurseofPetrification					= mod:NewYell(334541)
local yellCurseofPetrificationFades				= mod:NewFadesYell(334541)
local specWarnStoneBreakersCombo				= mod:NewSpecialWarningDefensive(339690, nil, nil, nil, 1, 2)
local specWarnPetrifiedTaunt					= mod:NewSpecialWarningTaunt(334616, nil, nil, nil, 3, 2)

--General Kaal
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22284))
local timerWickedBladeCD						= mod:NewAITimer(44.3, 333387, nil, nil, nil, 3)
local timerStoneShattererCD						= mod:NewAITimer(44.3, 334765, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)
local timerSerratedSwipeCD						= mod:NewAITimer(16.6, 334929, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerOutFlankCD							= mod:NewAITimer(44.3, 338156, nil, nil, nil, 6)--Keep Together
local timerTightFormationCD						= mod:NewAITimer(44.3, 338153, nil, nil, nil, 6)--Keep Apart
--General Grashaal
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22288))
local timerReverberatingLeapCD					= mod:NewAITimer(44.3, 334004, 183611, nil, nil, 3)--Short text "Leap"
local timerSeismicUpheavalCD					= mod:NewAITimer(44.3, 334498, nil, nil, nil, 3)
local timerCurseofPetrificationCD				= mod:NewAITimer(44.3, 334541, nil, nil, nil, 3)
local timerStoneBreakersComboCD					= mod:NewAITimer(16.6, 339690, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON, nil, 2, 3)
--Add Intermissions
local timerClusterBombardmentCD					= mod:NewAITimer(44.3, 332150, nil, nil, nil, 3)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
mod:AddInfoFrameOption(333913, true)
mod:AddSetIconOption("SetIconOnStoneShatterer", 334765, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnCurse", 334541, true, false, {4})
--mod:AddSetIconOption("SetIconOnLeap", 334004, true, false, {5})
--mod:AddNamePlateOption("NPAuraOnVolatileCorruption", 312595)

local LacerationStacks = {}
mod.vb.ShattererIcon = 1
mod.vb.phase = 1

function mod:LeapTarget(targetname, uId, bossuid, scanningTime)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnReverberatingLeap:Show()
		specWarnReverberatingLeap:Play("runout")
		yellReverberatingLeap:Yell()
		yellReverberatingLeapFades:Countdown(4-scanningTime)
	else
		warnReverberatingLeap:Show(targetname)
	end
--	if self.Options.SetIconOnLeap then
--		self:SetIcon(targetname, 5, 5-scanningTime)--So icon clears 1 second after blast
--	end
end

function mod:OnCombatStart(delay)
	table.wipe(LacerationStacks)
	self.vb.ShattererIcon = 1
	self.vb.phase = 1
	--General Kaal
	timerWickedBladeCD:Start(1-delay)
	timerStoneShattererCD:Start(1-delay)
	timerSerratedSwipeCD:Start(1-delay)
	timerOutFlankCD:Start(1-delay)
	timerTightFormationCD:Start(1-delay)
	--General Grashaal
	timerReverberatingLeapCD:Start(1-delay)
	timerSeismicUpheavalCD:Start(1-delay)
	timerCurseofPetrificationCD:Start(1-delay)--SUCCESS
	timerStoneBreakersComboCD:Start(1-delay)
--	if self.Options.NPAuraOnVolatileCorruption then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Show(4)--For Acid Splash
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(333913))
		DBM.InfoFrame:Show(10, "table", LacerationStacks, 1)
	end
--	berserkTimer:Start(-delay)--Confirmed normal and heroic
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.NPAuraOnVolatileCorruption then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 333387 then
		timerWickedBladeCD:Start()
	elseif spellId == 334765 then
		self.vb.ShattererIcon = 1
		timerStoneShattererCD:Start()
	elseif spellId == 334929 then
		timerSerratedSwipeCD:Start()
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnSerratedSwipe:Show()
			specWarnSerratedSwipe:Play("defensive")
		end
	elseif spellId == 334004 or spellId == 339164 or spellId == 334009 then
		timerReverberatingLeapCD:Start()
		self:BossTargetScanner(args.sourceGUID, "LeapTarget", 0.2, 10)--Scans for 2.0 of 4.0 second cast, will adjust later
	elseif spellId == 334498 then
		specWarnSeismicUpheaval:Show()
		specWarnSeismicUpheaval:Play("watchstep")
		timerSeismicUpheavalCD:Start()
	elseif spellId == 339690 then
		timerStoneBreakersComboCD:Start()
		if self:IsTanking("player", nil, nil, nil, args.sourceGUID) then
			specWarnStoneBreakersCombo:Show()
			specWarnStoneBreakersCombo:Play("defensive")
		end
	elseif spellId == 339728 then
		warnPulverize:Show()
	elseif spellId == 337741 or spellId == 339398 then
		warnBreathofCorruption:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 334541 then
		timerCurseofPetrificationCD:Start()
	elseif spellId == 332150 and self:AntiSpam(5, 3) then
		timerClusterBombardmentCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 329636 or spellId == 329808 then--70% and 40% transitions
		if spellId == 329636 then
			warnBasaltForm:Show(args.destName)
			--General Kaal
			timerWickedBladeCD:Stop()
			timerStoneShattererCD:Stop()
			timerSerratedSwipeCD:Stop()
			timerOutFlankCD:Stop()
			timerTightFormationCD:Stop()
		else
			warnGraniteForm:Show(args.destName)
			--General Grashaal
			timerReverberatingLeapCD:Stop()
			timerSeismicUpheavalCD:Stop()
			timerCurseofPetrificationCD:Stop()
			timerStoneBreakersComboCD:Stop()
			timerClusterBombardmentCD:Start(1)
		end
	elseif spellId == 329808 then
		warnGraniteForm:Show(args.destName)
	elseif spellId == 333913 then
		local amount = args.amount or 1
		LacerationStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(LacerationStacks)
		end
	elseif spellId == 334765 then
		if args:IsPlayer() then
			specWarnStoneShatterer:Show()
			specWarnStoneShatterer:Play("targetyou")
			yellStoneShattererFades:Countdown(spellId)
		end
		if self.Options.SetIconOnStoneShatterer then
			self:SetIcon(args.destName, self.vb.ShattererIcon)
		end
		self.vb.ShattererIcon = self.vb.ShattererIcon + 1
	elseif spellId == 338156 and self:AntiSpam(10, 1) then
		specWarnOutFlankStratagem:Show(DBM_CORE_L.BOSSTOGETHER)
		specWarnOutFlankStratagem:Play("phasechange")
	elseif spellId == 338153 and self:AntiSpam(10, 1) then
		specWarnTightFormationStratagem:Show(DBM_CORE_L.BOSSAPART)
		specWarnTightFormationStratagem:Play("phasechange")
	elseif spellId == 334541 then
		if args:IsPlayer() then
			specWarnCurseofPetrification:Show()
			specWarnCurseofPetrification:Play("targetyou")
			yellCurseofPetrification:Yell()
			yellCurseofPetrificationFades:Countdown(spellId)
		else
			warnCurseofPetrification:Show(args.destName)
		end
		if self.Options.SetIconOnCurse then
			self:SetIcon(args.destName, 4)
		end
	elseif spellId == 334616 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			if not args:IsPlayer() then
				specWarnPetrifiedTaunt:Show(args.destName)
				specWarnPetrifiedTaunt:Play("tauntboss")
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 329636 then--phase 2
		self.vb.phase = 2
		timerClusterBombardmentCD:Stop()--Probably stop in actual death counter later
		warnBasaltFormOver:Show()
		--General Kaal
		timerWickedBladeCD:Start(2)
		timerStoneShattererCD:Start(2)
		timerSerratedSwipeCD:Start(2)
		timerOutFlankCD:Start(2)
		timerTightFormationCD:Start(2)
	elseif spellId == 329808 then--Phase 3
		self.vb.phase = 3
		timerClusterBombardmentCD:Stop()--Probably stop in actual death counter later
		warnGraniteFormOver:Show()
		--General Grashaal
		timerReverberatingLeapCD:Start(3)
		timerSeismicUpheavalCD:Start(3)
		timerCurseofPetrificationCD:Start(3)--SUCCESS
		timerStoneBreakersComboCD:Start(3)
	elseif spellId == 333913 then
		LacerationStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(LacerationStacks)
		end
	elseif spellId == 334765 then
		if args:IsPlayer() then
			yellStoneShattererFades:Cancel()
		end
		if self.Options.SetIconOnStoneShatterer then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 334541 then
		if args:IsPlayer() then
			yellCurseofPetrificationFades:Cancel()
		end
		if self.Options.SetIconOnCurse then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 333913 then
		LacerationStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(LacerationStacks)
		end
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("333376") then
		specWarnWickedBlade:Show()
		specWarnWickedBlade:Play("targetyou")
		yellWickedBlade:Yell()
		yellWickedBladeFades:Countdown(4)
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("333376") and targetName then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName) then
			warnWickedBlade:CombinedShow(0.75, targetName)
		end
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 169601 then--aerial-commando

	elseif cid == 172858 then--stone-legion-goliath

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 310351 then

	end
end
