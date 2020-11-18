local mod	= DBM:NewMod(2425, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(168112, 168113)
mod:SetEncounterID(2417)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20200911000000)--2020, 9, 11
mod:SetMinSyncRevision(20200911000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 333387 334765 334929 334498 342544 342256 342722 332683 342425 344496",
	"SPELL_CAST_SUCCESS 334765 334929 342732 342253 342985 339690",
	"SPELL_SUMMON 342255 342257 342258 342259",
	"SPELL_AURA_APPLIED 329636 333913 334765 338156 338153 329808 333377 339690 342655 340037 343273 342425 336212",
	"SPELL_AURA_APPLIED_DOSE 333913",
	"SPELL_AURA_REMOVED 329636 333913 334765 329808 333377 339690 340037",
	"SPELL_AURA_REMOVED_DOSE 333913",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_START boss1 boss2"
)

--TODO, review more of timers with some bug fixes to fight as well as just a better version of transcriptor recording it., especailly P3 timers after intermission 2
--TODO, stack announces for https://ptr.wowhead.com/spell=340042/punishment?
--TODO, heart rend is renamed to Soul Crusher in journal, but spell data not renamed yet. Apply rename when it happens.
--TODO, find a way to move timers for Adds to nameplate bars, otherwise they are far less useful and will only feel like spam. They'll be extremely useful on NPs though
--[[
(ability.id = 333387 or ability.id = 334929 or ability.id = 344496 or ability.id = 334498 or ability.id = 342544 or ability.id = 342256 or ability.id = 342425 or ability.id = 332683) and type = "begincast"
 or (ability.id = 334765 or ability.id = 339690 or ability.id = 342253) and type = "cast"
 or ability.id = 329636 or ability.id = 329808 or ability.id = 342255 or ability.id = 342257 or ability.id = 342258 or ability.id = 342259
 or (target.id = 168112 or target.id = 168113 or target.id = 172858) and type = "death"
 or (ability.id = 340043 or ability.id = 332683) and type = "begincast"
 or ability.id = 342732 and type = "cast"
 --]]
 --General
local warnHardenedStoneForm						= mod:NewTargetNoFilterAnnounce(329636, 2)
local warnHardenedStoneFormOver					= mod:NewEndAnnounce(329636, 1)
local warnSoldiersOath							= mod:NewTargetNoFilterAnnounce(336212, 4)
--General Kaal
local warnWickedBlade							= mod:NewTargetNoFilterAnnounce(333376, 4)
local warnHeartRend								= mod:NewTargetNoFilterAnnounce(334765, 4)
local warnCallShadowForces						= mod:NewSpellAnnounce(342256, 2)
--General Grashaal
local warnReverberatingEruption					= mod:NewTargetNoFilterAnnounce(344496, 3)
local warnCrystalize							= mod:NewTargetNoFilterAnnounce(339690, 2)
local warnPulverizingMeteor						= mod:NewTargetNoFilterAnnounce(342544, 4)
--Adds
local warnStoneLegionGoliath					= mod:NewSpellAnnounce("ej22764", 2, 343273)
local warnVolatileAnimaInfusion					= mod:NewTargetNoFilterAnnounce(342655, 2, nil, false)
local warnRavenousFeast							= mod:NewTargetNoFilterAnnounce(343273, 3)
local warnStonewrathExhaust						= mod:NewCastAnnounce(342722, 3)
local warnWickedSlaughter						= mod:NewTargetNoFilterAnnounce(342253, 2, nil, "Tank")--So tanks know where adds went
local warnStonegaleEffigy						= mod:NewSpellAnnounce(342985, 3)

--General Kaal
local specWarnWickedBlade						= mod:NewSpecialWarningYouPos(333376, nil, nil, nil, 1, 2)
local yellWickedBlade							= mod:NewPosYell(333376)
local yellWickedBladeFades						= mod:NewIconFadesYell(333376)
local specWarnHeartRend							= mod:NewSpecialWarningYou(334765, false, nil, nil, 1, 2)
local specWarnSerratedSwipe						= mod:NewSpecialWarningDefensive(334929, nil, nil, nil, 1, 2)
--local specWarnLaceration						= mod:NewSpecialWarningStack(333913, nil, 3, nil, nil, 1, 6)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)
--General Grashaal
local specWarnReverberatingEruption				= mod:NewSpecialWarningYou(344496, nil, nil, nil, 1, 2)
local yellReverberatingEruption					= mod:NewYell(344496, 138658)--Short text "Eruption"
local yellReverberatingEruptionFades			= mod:NewFadesYell(344496, 138658)--Short text "Eruption"
local specWarnSeismicUpheaval					= mod:NewSpecialWarningDodge(334498, nil, nil, nil, 2, 2)
local specWarnCrystalize						= mod:NewSpecialWarningYou(339690, nil, nil, nil, 1, 2)
local yellCrystalize							= mod:NewYell(339690, nil, nil, nil, "YELL")
local yellCrystalizeFades						= mod:NewFadesYell(339690, nil, nil, nil, "YELL")
local specWarnMeteor							= mod:NewSpecialWarningYou(342544, nil, nil, nil, 1, 2)
local yellMeteor								= mod:NewYell(342544, nil, nil, nil, "YELL")
local specWarnStoneFist							= mod:NewSpecialWarningDefensive(342425, nil, nil, nil, 1, 2)
local specWarnStoneFistTaunt					= mod:NewSpecialWarningTaunt(342425, nil, nil, nil, 1, 2)
--Adds/Intermissions
local specWarnVolatileStoneShell				= mod:NewSpecialWarningSwitch(340037, "Dps", nil, nil, 1, 2)
local specWarnShatteringBlast					= mod:NewSpecialWarningSpell(332683, nil, nil, nil, 2, 2)

--General Kaal
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22284))
local timerWickedBladeCD						= mod:NewCDTimer(28.9, 333387, nil, nil, nil, 3)--28.9-44
local timerHeartRendCD							= mod:NewCDTimer(40.1, 334765, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)--40-52
local timerSerratedSwipeCD						= mod:NewCDTimer(13.4, 334929, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)--13.4-18.6
local timerCallShadowForcesCD					= mod:NewCDTimer(47.5, 342256, nil, nil, nil, 1, nil, DBM_CORE_L.MYTHIC_ICON)
--General Grashaal
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22288))
local timerReverberatingEruptionCD				= mod:NewCDTimer(30, 344496, 138658, nil, nil, 3, nil, nil, nil, 1, 3)--31.1-40, Short text "Eruption"
local timerSeismicUpheavalCD					= mod:NewCDTimer(30.1, 334498, nil, nil, nil, 3)--28.3-32
local timerCrystalizeCD							= mod:NewCDTimer(53.5, 339690, nil, nil, nil, 5, nil, nil, nil, 2, 3)--53.5-60
local timerStoneFistCD							= mod:NewCDTimer(35.1, 342425, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)
--Phasing
local timerShatteringBlast						= mod:NewCastTimer(5, 332683, nil, nil, nil, 2)
--Adds
mod:AddTimerLine(DBM_CORE_L.ADDS)
local timerRavenousFeastCD						= mod:NewCDTimer(22.7, 343273, nil, nil, nil, 3)--Kind of all over the place right now 23-30)
local timerWickedSlaughterCD					= mod:NewCDTimer(10.9, 342253, nil, "Tank", nil, 3, nil, DBM_CORE_L.MYTHIC_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
mod:AddInfoFrameOption(333913, true)
mod:AddSetIconOption("SetIconOnWickedBlade", 333387, true, false, {1, 2})
mod:AddSetIconOption("SetIconOnCrystalize", 339690, true, false, {3})
mod:AddSetIconOption("SetIconOnEruption", 344496, true, false, {4})
mod:AddSetIconOption("SetIconOnHeartRend", 334765, false, false, {4, 5, 6, 7})--Off by default, conflicts with two other icon options
mod:AddSetIconOption("SetIconOnShadowForces", 342256, true, true, {6, 7, 8})
mod:AddNamePlateOption("NPAuraOnVolatileShell", 340037)

local playerName = UnitName("player")
local LacerationStacks = {}
mod.vb.HeartIcon = 4
mod.vb.wickedBladeIcon = 1
mod.vb.phase = 1

function mod:EruptionTarget(targetname, uId)
	if not targetname then return end
	if self:AntiSpam(4, targetname.."2") then
		if targetname == playerName then
			specWarnReverberatingEruption:Show()
			specWarnReverberatingEruption:Play("runout")
			yellReverberatingEruption:Yell()
			yellReverberatingEruptionFades:Countdown(3.97)--This scan method doesn't support scanningTime, but should be about right
		else
			warnReverberatingEruption:Show(targetname)
		end
		if self.Options.SetIconOnEruption then
			self:SetIcon(targetname, 4, 5)--So icon clears 1 second after blast
		end
	end
end

function mod:MeteorTarget(targetname, uId)
	if not targetname then return end
	if targetname == playerName then
		specWarnMeteor:Show()
		specWarnMeteor:Play("runout")
		yellMeteor:Yell()
	else
		warnPulverizingMeteor:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	table.wipe(LacerationStacks)
	self.vb.HeartIcon = 4
	self.vb.wickedBladeIcon = 1
	self.vb.phase = 1
	--General Kaal
	--Summons a goliath instantly on pull now, no timer needed for this
	timerSerratedSwipeCD:Start(7.3-delay)--START, but next timer is started at SUCCESS
	timerWickedBladeCD:Start(16.6-delay)
	timerHeartRendCD:Start(33.2-delay)--SUCCESS
	if self:IsMythic() then
		timerCallShadowForcesCD:Start(10.5-delay)
	end
	--General Grashaal Air ability
	timerCrystalizeCD:Start(36.4-delay)
	if self.Options.NPAuraOnVolatileShell then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
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
	if self.Options.NPAuraOnVolatileShell then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 333387 then
		self.vb.wickedBladeIcon = 1
		timerWickedBladeCD:Start()
	elseif spellId == 334765 then
		self.vb.HeartIcon = 4
	elseif spellId == 334929 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnSerratedSwipe:Show()
			specWarnSerratedSwipe:Play("defensive")
		end
	elseif spellId == 344496 then
		timerReverberatingEruptionCD:Start()
		--self:BossTargetScanner(args.sourceGUID, "EruptionTarget", 0.01, 12)
	elseif spellId == 334498 then
		specWarnSeismicUpheaval:Show()
		specWarnSeismicUpheaval:Play("watchstep")
		timerSeismicUpheavalCD:Start()
	elseif spellId == 342544 then
		self:BossTargetScanner(args.sourceGUID, "MeteorTarget", 0.05, 12)
	elseif spellId == 342256 then
		warnCallShadowForces:Show()
		timerCallShadowForcesCD:Start()
	elseif spellId == 342722 then
		warnStonewrathExhaust:Show()
	elseif spellId == 332683 then
		specWarnShatteringBlast:Show()
		specWarnShatteringBlast:Play("carefly")
		timerShatteringBlast:Start()
		--Start INCOMING boss timers here, that seems to be how it's scripted.
		self.vb.phase = self.vb.phase + 1
		if self.vb.phase == 2 then
			--General Grashaal
			--Boss continues timer for crystalize/combo from air phase, it doesn't start here
			--just spell queued depending on overlap with Grashaal resuming other stuff
			timerStoneFistCD:Start(11.7)--11.7-39.4
			timerReverberatingEruptionCD:Start(11.1)--11-23.27
			timerSeismicUpheavalCD:Start(30.9)--30.9-39.3
			--Kael also resumes summing adds on mythic once intermission 1 is over, but it's pretty instant
--			if self:IsMythic() then
--				timerCallShadowForcesCD:Start(0)--0-5
--			end
		else--Stage 3 (Both Generals at once)
			--General Kaal returning
			--These probably need redoing
			timerSerratedSwipeCD:Start(5.5)--START, but next timer is started at SUCCESS
			timerHeartRendCD:Start(16.2)--SUCCESS
			timerWickedBladeCD:Start(34.2)
			--Kael also resumes summing adds on mythic once intermission 2 is over
			if self:IsMythic() then
				timerCallShadowForcesCD:Start(8)
			end
		end
	elseif spellId == 342425 then
		timerStoneFistCD:Start()
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnStoneFist:Show()
			specWarnStoneFist:Play("defensive")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 334765 then
		timerHeartRendCD:Start()
	elseif spellId == 334929 then--Boss stutter casts this often
		timerSerratedSwipeCD:Start(12)--13.5 - 1.5
	elseif spellId == 339690 then
		timerCrystalizeCD:Start()
	elseif spellId == 342732 then
		timerRavenousFeastCD:Start(30, args.sourceGUID)
	elseif spellId == 342253 then
		warnWickedSlaughter:CombinedShow(1.5, args.destName)--Needs to allow at least 1.5 to combine targets
		timerWickedSlaughterCD:Start(11, args.sourceGUID)
	elseif spellId == 342985 and self:AntiSpam(3, 3) then
		warnStonegaleEffigy:Show()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 342255 then--Summon Reinforcements
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 172858 then--stone-legion-goliath
			warnStoneLegionGoliath:Show()
			if self:IsHard() then
				timerRavenousFeastCD:Start(31.4, args.destGUID)
			end
		end
	elseif spellId == 342257 or spellId == 342258 or spellId == 342259 then
		if self.Options.SetIconOnShadowForces then
			local icon = spellId == 342257 and 8 or spellId == 342258 and 7 or 6
			self:ScanForMobs(args.destGUID, 2, icon, 1, 0.2, 12)
		end
		timerWickedSlaughterCD:Start(10.6, args.destGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 329636 or spellId == 329808 then--50% transition for Kaal/50% transition for Grashaal
		warnHardenedStoneForm:Show(args.destName)
		timerCallShadowForcesCD:Stop()--The only timer that stops here is this one, rest continue on until boss leaves
	elseif spellId == 333913 then
		local amount = args.amount or 1
		LacerationStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(LacerationStacks)
		end
	elseif spellId == 334765 then
		if args:IsPlayer() then
			specWarnHeartRend:Show()
			specWarnHeartRend:Play("targetyou")
		end
		if self.Options.SetIconOnHeartRend then
			self:SetIcon(args.destName, self.vb.HeartIcon)
		end
		self.vb.HeartIcon = self.vb.HeartIcon + 1
	elseif spellId == 333377 and self:AntiSpam(4, args.destName .. "1") then
		warnWickedBlade:CombinedShow(0.3, args.destName)
		local icon = self.vb.wickedBladeIcon
		if args:IsPlayer() then
			specWarnWickedBlade:Show(self:IconNumToTexture(icon))
			specWarnWickedBlade:Play("mm"..icon)
			yellWickedBlade:Yell(icon, icon, icon)
			yellWickedBladeFades:Countdown(4, nil, icon)
		end
		if self.Options.SetIconOnWickedBlade then
			self:SetIcon(args.destName, icon, 5)
		end
		self.vb.wickedBladeIcon = self.vb.wickedBladeIcon + 1
	elseif spellId == 339690 then
		if args:IsPlayer() then
			specWarnCrystalize:Show()
			specWarnCrystalize:Play("targetyou")
			yellCrystalize:Yell()
			yellCrystalizeFades:Countdown(spellId)
		else
			warnCrystalize:Show(args.destName)
		end
		if self.Options.SetIconOnCrystalize then
			self:SetIcon(args.destName, 3)
		end
	elseif spellId == 342655 then
		warnVolatileAnimaInfusion:Show(args.destName)
	elseif spellId == 340037 then
		if self:AntiSpam(5, 1) then
			specWarnVolatileStoneShell:Show()
			specWarnVolatileStoneShell:Play("targetchange")
		end
		if self.Options.NPAuraOnVolatileShell then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 4)
		end
	elseif spellId == 343273 then
		warnRavenousFeast:CombinedShow(0.3, args.destName)--Combined in case it'll clobber everyone near them too
	elseif spellId == 342425 and not args:IsPlayer() then
		specWarnStoneFistTaunt:Show(args.destName)
		specWarnStoneFistTaunt:Play("tauntboss")
	elseif spellId == 336212 then
		warnSoldiersOath:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 329636 then--phase 2 (Kael Departing, Grashaal landing)
		warnHardenedStoneFormOver:Show()
		--Stop Outgoing boss (Kael) timers here
		timerWickedBladeCD:Stop()
		timerHeartRendCD:Stop()
		timerSerratedSwipeCD:Stop()
		--Start Outgoing boss (Kael) (stuff he still casts airborn) here as well
		timerWickedBladeCD:Start(26.2)
	elseif spellId == 329808 then
		warnHardenedStoneFormOver:Show()
		--No timer action should be needed here, boss doesn't leave.
		--Shattering started incoming bosses timers and boss already active doesn't reset timers
	elseif spellId == 333913 then
		LacerationStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(LacerationStacks)
		end
	elseif spellId == 334765 then
		if self.Options.SetIconOnHeartRend then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 339690 then
		if args:IsPlayer() then
			yellCrystalizeFades:Cancel()
		end
		if self.Options.SetIconOnCrystalize then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 340037 then
		if self.Options.NPAuraOnVolatileShell then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
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
	if msg:find("344496") and self:AntiSpam(4, playerName.."2") then--Eruption Backup (if scan fails)
		specWarnReverberatingEruption:Show()
		specWarnReverberatingEruption:Play("runout")
		yellReverberatingEruption:Yell()
		yellReverberatingEruptionFades:Countdown(3.5)--A good 0.5 sec slower
		if self.Options.SetIconOnEruption then
			self:SetIcon(playerName, 4, 4.5)--So icon clears 1 second after
		end
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("344496") and targetName then--Eruption Backup (if scan fails)
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName.."2") then--Same antispam as RAID_BOSS_WHISPER on purpose. if player got personal warning they don't need this one
			warnReverberatingEruption:Show(targetName)
			if self.Options.SetIconOnEruption then
				self:SetIcon(targetName, 4, 4.5)--So icon clears 1 second after
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 172858 then--stone-legion-goliath
		timerRavenousFeastCD:Stop(args.destGUID)
	elseif cid == 173280 then--stone-legion-skirmisher
		timerWickedSlaughterCD:Stop(args.destGUID)
	elseif cid == 168112 then--Kaal
		timerWickedBladeCD:Stop()
		timerHeartRendCD:Stop()
		timerSerratedSwipeCD:Stop()
		timerCallShadowForcesCD:Stop()
	elseif cid == 168113 then--Grashaal
		timerReverberatingEruptionCD:Stop()
		timerSeismicUpheavalCD:Stop()
		timerCrystalizeCD:Stop()
		timerStoneFistCD:Stop()
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

--"<10.92 16:10:19> [UNIT_SPELLCAST_START] General Grashaal(Lightea) - Reverberating Leap - 5.2s [[boss2:Cast-3-2084-2296-21431-334009-0026A47AA9:334009]]", -- [614]
--"<10.92 16:10:19> [CLEU] SPELL_CAST_START#Creature-0-2084-2296-21431-168113-0000247A6F#General Grashaal##nil#334009#Reverberating Leap#nil#nil", -- [616]
--"<10.94 16:10:19> [DBM_Debug] boss2 changed targets to Kngflyven#nil", -- [618]
--"<11.38 16:10:19> [CHAT_MSG_ADDON] RAID_BOSS_WHISPER_SYNC#|TInterface\\Icons\\INV_ElementalEarth2.blp:20|t%s targets you with |cFFFF0000|Hspell:334094|h[Reverberating Leap]|h|r!#Kngflyven-TheMaw", -- [661]
function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 344496 then
		self:BossUnitTargetScanner(uId, "EruptionTarget", 1)
	end
end
