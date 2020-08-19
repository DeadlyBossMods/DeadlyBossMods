local mod	= DBM:NewMod(2425, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(168112, 168113)
mod:SetEncounterID(2417)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20200801000000)--2020, 8, 01
mod:SetMinSyncRevision(20200801000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 333387 334765 334929 334498 339690 339728 337741 339398 339164 334009 342256 340043",
	"SPELL_CAST_SUCCESS 334541 334765 334929",
	"SPELL_AURA_APPLIED 329636 333913 334765 338156 338153 329808 334541 334616 333377",
	"SPELL_AURA_APPLIED_DOSE 333913",
	"SPELL_AURA_REMOVED 329636 333913 334765 329808 334541 333377",
	"SPELL_AURA_REMOVED_DOSE 333913",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss3",
	"UNIT_SPELLCAST_START boss1 boss2"
)

--https://shadowlands.wowhead.com/spell=334616/petrified
--TODO, optimize events for formations to eliminate antispam calls
--TODO, alternate the Stratagem timers, don't overlap them like AI timers require
--TODO, verify timer for https://ptr.wowhead.com/spell=340043
--TODO, stack announces for https://ptr.wowhead.com/spell=340042/punishment if it stacks
--TODO, https://shadowlands.wowhead.com/spell=342254/wicked-slaughter targeting?
--[[
(ability.id = 333387 or ability.id = 334929 or ability.id = 339164 or ability.id = 334009 or ability.id = 334498 or ability.id = 339690 or ability.id = 339728 or ability.id = 337741 or ability.id = 339398) and type = "begincast"
 or (ability.id = 334541 or ability.id = 334765) and type = "cast"
 or ability.id = 329636 or ability.id = 329808
 --]]
--General Kaal
local warnBasaltForm							= mod:NewTargetNoFilterAnnounce(329636, 2)
local warnBasaltFormOver						= mod:NewEndAnnounce(329636, 1)
local warnWickedBlade							= mod:NewTargetNoFilterAnnounce(333376, 4)
local warnStoneShatterer						= mod:NewTargetNoFilterAnnounce(334765, 4)
local warnCallShadowForces						= mod:NewSpellAnnounce(342256, 2)
--General Grashaal
local warnGraniteForm							= mod:NewTargetNoFilterAnnounce(329808, 2)
local warnGraniteFormOver						= mod:NewEndAnnounce(329808, 1)
local warnReverberatingLeap						= mod:NewTargetNoFilterAnnounce(334004, 3)
local warnCurseofPetrification					= mod:NewTargetNoFilterAnnounce(334541, 4)
local warnStoneBreakerCombo						= mod:NewSpellAnnounce(339690, 3)
local warnPulverize								= mod:NewCastAnnounce(339728, 3, nil, nil, false)
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
--local specWarnLaceration						= mod:NewSpecialWarningStack(333913, nil, 3, nil, nil, 1, 6)
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
local timerWickedBladeCD						= mod:NewCDTimer(28.9, 333387, nil, nil, nil, 3)
local timerStoneShattererCD						= mod:NewCDTimer(43.6, 334765, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)
local timerSerratedSwipeCD						= mod:NewCDTimer(11.1, 334929, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)--12.6-18.1
local timerOutFlankCD							= mod:NewAITimer(44.3, 338156, nil, nil, nil, 6, nil, DBM_CORE_L.MYTHIC_ICON)--Keep Together
local timerTightFormationCD						= mod:NewAITimer(44.3, 338153, nil, nil, nil, 6, nil, DBM_CORE_L.MYTHIC_ICON)--Keep Apart
local timerCallShadowForcesCD					= mod:NewAITimer(28.9, 333387, nil, nil, nil, 1, nil, DBM_CORE_L.MYTHIC_ICON)
--General Grashaal
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22288))
local timerReverberatingLeapCD					= mod:NewCDTimer(29.8, 334004, 183611, nil, nil, 3)--Short text "Leap"
local timerSeismicUpheavalCD					= mod:NewCDTimer(28.3, 334498, nil, nil, nil, 3)--28.3-32
local timerCurseofPetrificationCD				= mod:NewCDTimer(61.8, 334541, nil, nil, nil, 3)
local timerStoneBreakersComboCD					= mod:NewCDTimer(24.6, 339690, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON, nil, 2, 3)--24.6-33.8
--Adds
local timerBreathofCorruptionCD					= mod:NewCDTimer(13.5, 337741, nil, nil, nil, 3)--13.5-17
local timerPunishingBlowCD						= mod:NewAITimer(24.6, 340043, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
mod:AddInfoFrameOption(333913, true)
mod:AddSetIconOption("SetIconOnStoneShatterer", 334765, true, false, {1, 2, 3, 4})
mod:AddSetIconOption("SetIconOnCurse", 334541, true, false, {5})
mod:AddSetIconOption("SetIconOnWickedBlade", 333387, false, false, {6, 7})--off by default since it relies on 100% boss mod raid
mod:AddSetIconOption("SetIconOnLeap", 334004, true, false, {8})
--mod:AddNamePlateOption("NPAuraOnVolatileCorruption", 312595)

local playerName = UnitName("player")
local LacerationStacks = {}
mod.vb.ShattererIcon = 1
mod.vb.wickedBladeIcon = 6
mod.vb.phase = 1

function mod:LeapTarget(targetname, uId)
	if not targetname then return end
	if self:AntiSpam(4, targetname.."2") then
		if targetname == playerName then
			specWarnReverberatingLeap:Show()
			specWarnReverberatingLeap:Play("runout")
			yellReverberatingLeap:Yell()
			yellReverberatingLeapFades:Countdown(3.97)--This scan method doesn't support scanningTime, but should be about right
		else
			warnReverberatingLeap:Show(targetname)
		end
		if self.Options.SetIconOnLeap then
			self:SetIcon(targetname, 8, 5)--So icon clears 1 second after blast
		end
	end
end

function mod:OnCombatStart(delay)
	table.wipe(LacerationStacks)
	self.vb.ShattererIcon = 1
	self.vb.wickedBladeIcon = 6
	self.vb.phase = 1
	--General Kaal
	timerSerratedSwipeCD:Start(8.2-delay)--START, but next timer is started at SUCCESS
	timerWickedBladeCD:Start(17.1-delay)
	timerStoneShattererCD:Start(31.7-delay)--SUCCESS
	if self:IsMythic() then
		timerOutFlankCD:Start(1-delay)
		timerTightFormationCD:Start(1-delay)
		timerCallShadowForcesCD:Start(1-delay)
	end
	--General Grashaal
	timerReverberatingLeapCD:Start(9.5-delay)
	timerStoneBreakersComboCD:Start(21-delay)
	timerSeismicUpheavalCD:Start(33.5-delay)
	timerCurseofPetrificationCD:Start(68.6-delay)--SUCCESS
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
		self.vb.wickedBladeIcon = 6
		timerWickedBladeCD:Start()
	elseif spellId == 334765 then
		self.vb.ShattererIcon = 1
	elseif spellId == 334929 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnSerratedSwipe:Show()
			specWarnSerratedSwipe:Play("defensive")
		end
	elseif spellId == 339164 or spellId == 334009 then--LFR/Normal, Heroic/Mythic
		timerReverberatingLeapCD:Start()
		--self:BossTargetScanner(args.sourceGUID, "LeapTarget", 0.01, 12)
	elseif spellId == 334498 then
		specWarnSeismicUpheaval:Show()
		specWarnSeismicUpheaval:Play("watchstep")
		timerSeismicUpheavalCD:Start()
	elseif spellId == 339690 then
		timerStoneBreakersComboCD:Start()
		if self:IsTanking("player", nil, nil, nil, args.sourceGUID) then
			specWarnStoneBreakersCombo:Show()
			specWarnStoneBreakersCombo:Play("defensive")
		else
			warnStoneBreakerCombo:Show()
		end
	elseif spellId == 339728 then
		warnPulverize:Show()
	elseif spellId == 337741 or spellId == 339398 then--337741 confirmed, 339398 unknown, porbably lfr/normal
		warnBreathofCorruption:Show()
		timerBreathofCorruptionCD:Start()
	elseif spellId == 342256 then
		warnCallShadowForces:Show()
		timerCallShadowForcesCD:Start()
	elseif spellId == 340043 then
		timerPunishingBlowCD:Start(10, args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 334541 then
		timerCurseofPetrificationCD:Start()
	elseif spellId == 334765 then
		timerStoneShattererCD:Start()
	elseif spellId == 334929 then--Boss stutter casts this often
		timerSerratedSwipeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 329636 then--70% transition
		warnBasaltForm:Show(args.destName)
		--General Kaal
		timerWickedBladeCD:Stop()
		timerStoneShattererCD:Stop()
		timerSerratedSwipeCD:Stop()
		timerOutFlankCD:Stop()
		timerTightFormationCD:Stop()
		timerCallShadowForcesCD:Stop()
	elseif spellId == 329808 then--40% transition
		warnGraniteForm:Show(args.destName)
		--General Grashaal
		timerReverberatingLeapCD:Stop()
		timerSeismicUpheavalCD:Stop()
		timerCurseofPetrificationCD:Stop()
		timerStoneBreakersComboCD:Stop()
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
			self:SetIcon(args.destName, 5)
		end
	elseif spellId == 334616 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			if not args:IsPlayer() then
				specWarnPetrifiedTaunt:Show(args.destName)
				specWarnPetrifiedTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 333377 and self:AntiSpam(4, args.destName .. "1") then
		warnWickedBlade:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnWickedBlade:Show()
			specWarnWickedBlade:Play("targetyou")
			yellWickedBlade:Yell()
			yellWickedBladeFades:Countdown(4)
		end
		if self.Options.SetIconOnWickedBlade then
			self:SetIcon(args.destName, self.vb.wickedBladeIcon, 5)
		end
		self.vb.wickedBladeIcon = self.vb.wickedBladeIcon + 1
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 329636 then--phase 2
		self.vb.phase = 2
		warnBasaltFormOver:Show()
		--General Kaal
		timerSerratedSwipeCD:Start(7.6)--START, but next timer is started at SUCCESS
		timerWickedBladeCD:Start(16.3)
		timerStoneShattererCD:Start(31.5)--SUCCESS
		if self:IsMythic() then
			timerOutFlankCD:Start(2)
			timerTightFormationCD:Start(2)
			timerCallShadowForcesCD:Start(2)
		end
	elseif spellId == 329808 then--Phase 3
		self.vb.phase = 3
		warnGraniteFormOver:Show()
		--General Grashaal
		timerReverberatingLeapCD:Start(10.9)
		timerStoneBreakersComboCD:Start(22.1)
		timerSeismicUpheavalCD:Start(31.9)
		timerCurseofPetrificationCD:Start(69.1)--SUCCESS
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
	if msg:find("333908") and self:AntiSpam(4, playerName.."1") then
		specWarnWickedBlade:Show()
		specWarnWickedBlade:Play("targetyou")
		yellWickedBlade:Yell()
		yellWickedBladeFades:Countdown(4)
	elseif msg:find("334094") and self:AntiSpam(4, playerName.."2") then--Leap Backup (if scan fails)
		specWarnReverberatingLeap:Show()
		specWarnReverberatingLeap:Play("runout")
		yellReverberatingLeap:Yell()
		yellReverberatingLeapFades:Countdown(3.5)--A good 0.5 sec slower
		if self.Options.SetIconOnLeap then
			self:SetIcon(playerName, 8, 4.5)--So icon clears 1 second after
		end
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("333908") and targetName then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName.."1") then
			warnWickedBlade:CombinedShow(0.75, targetName)
			if self.Options.SetIconOnWickedBlade then
				self:SetIcon(targetName, self.vb.wickedBladeIcon, 5)
			end
			self.vb.wickedBladeIcon = self.vb.wickedBladeIcon + 1
		end
	elseif msg:find("334094") and targetName then--Leap Backup (if scan fails)
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName.."2") then--Same antispam as RAID_BOSS_WHISPER on purpose. if player got personal warning they don't need this one
			warnReverberatingLeap:Show(targetName)
			if self.Options.SetIconOnLeap then
				self:SetIcon(targetName, 8, 4.5)--So icon clears 1 second after
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 172858 then--stone-legion-goliath
		timerBreathofCorruptionCD:Stop()
	elseif cid == 173276 then--Stone Legion Commando
		timerPunishingBlowCD:Stop(args.destGUID)
	elseif cid == 173280 then--stone-legion-skirmisher

	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--"<60.93 16:11:09> [UNIT_SPELLCAST_SUCCEEDED] Stone Legion Goliath(??) -Anchor Here- [[boss3:Cast-3-2084-2296-21431-45313-0013A47ADB:45313]]", -- [3631]
--"<72.07 16:11:20> [CLEU] SPELL_CAST_START#Creature-0-2084-2296-21431-172858-0000247ACF#Stone Legion Goliath##nil#337741#Breath of Corruption#nil#nil", -- [4358]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 45313 then--Anchor Here
		timerBreathofCorruptionCD:Start(11.1)
	end
end

--"<10.92 16:10:19> [UNIT_SPELLCAST_START] General Grashaal(Lightea) - Reverberating Leap - 5.2s [[boss2:Cast-3-2084-2296-21431-334009-0026A47AA9:334009]]", -- [614]
--"<10.92 16:10:19> [CLEU] SPELL_CAST_START#Creature-0-2084-2296-21431-168113-0000247A6F#General Grashaal##nil#334009#Reverberating Leap#nil#nil", -- [616]
--"<10.94 16:10:19> [DBM_Debug] boss2 changed targets to Kngflyven#nil", -- [618]
--"<11.38 16:10:19> [CHAT_MSG_ADDON] RAID_BOSS_WHISPER_SYNC#|TInterface\\Icons\\INV_ElementalEarth2.blp:20|t%s targets you with |cFFFF0000|Hspell:334094|h[Reverberating Leap]|h|r!#Kngflyven-TheMaw", -- [661]
function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 339164 or spellId == 334009 then
		self:BossUnitTargetScanner(uId, "LeapTarget", 1)
	end
end
