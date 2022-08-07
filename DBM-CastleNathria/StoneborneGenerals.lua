local mod	= DBM:NewMod(2425, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(168112, 168113)
mod:SetEncounterID(2417)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20210128000000)--2021, 01, 28
mod:SetMinSyncRevision(20210126000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 333387 334765 334929 334498 342544 342256 342722 332683 342425 344496 334009 344230",
	"SPELL_CAST_SUCCESS 334765 334929 342732 342253 342985 339690 342425",
	"SPELL_SUMMON 342255 342257 342258 342259",
	"SPELL_AURA_APPLIED 329636 333913 334765 338156 338153 329808 333377 339690 342655 340037 342425 336212",
	"SPELL_AURA_APPLIED_DOSE 333913",
	"SPELL_AURA_REMOVED 329636 333913 334765 329808 333377 339690 340037",
	"SPELL_AURA_REMOVED_DOSE 333913",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_START boss1 boss2 boss3 boss4 boss5",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, review more of timers with some bug fixes to fight as well as just a better version of transcriptor recording it., especailly P3 timers after intermission 2
--TODO, stack announces for https://ptr.wowhead.com/spell=340042/punishment?
--TODO, heart rend is renamed to Soul Crusher in journal, but spell data not renamed yet. Apply rename when it happens.
--TODO, find a way to move timers for Adds to nameplate bars, otherwise they are far less useful and will only feel like spam. They'll be extremely useful on NPs though
--[[
(ability.id = 334765 or ability.id = 333387 or ability.id = 334929 or ability.id = 344496 or ability.id = 334498 or ability.id = 342544 or ability.id = 342256 or ability.id = 342425 or ability.id = 332683 or ability.id = 344230 or ability.id = 334009) and type = "begincast"
 or (ability.id = 339690 or ability.id = 342253) and type = "cast"
 or ability.id = 329636 or ability.id = 329808 or ability.id = 342255 or ability.id = 342257 or ability.id = 342258 or ability.id = 342259
 or (target.id = 168112 or target.id = 168113 or target.id = 172858) and type = "death"
 or (ability.id = 340043 or ability.id = 332683) and type = "begincast"
 or ability.id = 342732 and type = "cast"
 --]]
 --General
local warnHardenedStoneForm						= mod:NewTargetNoFilterAnnounce(329636, 2)
local warnHardenedStoneFormOver					= mod:NewEndAnnounce(329636, 1)
local warnSoldiersOath							= mod:NewTargetNoFilterAnnounce(336212, 4)

local berserkTimer								= mod:NewBerserkTimer(600)

mod:AddBoolOption("ExperimentalTimerCorrection", true)
--General Kaal
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22284))
local warnWickedBlade							= mod:NewTargetCountAnnounce(333376, 4, nil, nil, nil, nil, nil, nil, true)
local warnHeartRend								= mod:NewTargetCountAnnounce(334765, 4, nil, "Healer", 2, nil, nil, nil, true)
local warnCallShadowForces						= mod:NewCountAnnounce(342256, 2)

local specWarnWickedBladeCast					= mod:NewSpecialWarningCount(333376, false, nil, nil, 2, 2)
local specWarnWickedBlade						= mod:NewSpecialWarningYouPos(333376, nil, nil, nil, 1, 2)
local yellWickedBlade							= mod:NewPosYell(333376)
local yellWickedBladeFades						= mod:NewIconFadesYell(333376)
local specWarnHeartRendCast						= mod:NewSpecialWarningCount(334765, false, nil, nil, 1, 2)
local specWarnHeartRend							= mod:NewSpecialWarningYou(334765, false, nil, nil, 1, 2)
local specWarnSerratedSwipe						= mod:NewSpecialWarningDefensive(334929, nil, nil, nil, 1, 2)

local timerWickedBladeCD						= mod:NewCDCountTimer(30, 333376, nil, nil, nil, 3, nil, nil, true)--30 unless ICDed
local timerHeartRendCD							= mod:NewCDCountTimer(42.1, 334765, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON, true)--42.4 unless ICDed
local timerSerratedSwipeCD						= mod:NewCDCountTimer(21.8, 334929, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON, true)
local timerCallShadowForcesCD					= mod:NewCDCountTimer(52, 342256, nil, nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddInfoFrameOption(333913, true)
mod:AddSetIconOption("SetIconOnHeartRend", 334765, true, false, {1, 2, 3, 4})--On by default since it's most important mechanic to manage outside of shadow forces
mod:AddSetIconOption("SetIconOnShadowForces", 342256, true, true, {6, 7, 8})
mod:AddSetIconOption("SetIconOnWickedBlade2", 333376, false, false, {1, 2})--Off by default since it conflicts with heart rend
mod:AddMiscLine(DBM_CORE_L.OPTION_CATEGORY_DROPDOWNS)
mod:AddDropdownOption("BladeMarking", {"SetOne", "SetTwo"}, "SetOne", "misc")--SetTwo is BW default
--General Grashaal
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22288))
local warnReverberatingEruption					= mod:NewTargetCountAnnounce(344496, 3, nil, nil, nil, nil, nil, nil, true)--Normal+
local warnReverberatingLeap						= mod:NewTargetCountAnnounce(334009, 3, nil, nil, nil, nil, nil, nil, true)--LFR
local warnCrystalize							= mod:NewTargetCountAnnounce(339690, 2, nil, nil, nil, nil, nil, nil, true)
local warnPulverizingMeteor						= mod:NewTargetCountAnnounce(342544, 4, nil, nil, nil, nil, nil, nil, true)

local specWarnReverberatingEruption				= mod:NewSpecialWarningYou(344496, nil, 138658, nil, 1, 2, 2)
local yellReverberatingEruption					= mod:NewYell(344496, 138658)--Short text "Eruption"
local yellReverberatingEruptionFades			= mod:NewFadesYell(344496, 138658)--Short text "Eruption"
local specWarnReverberatingLeap					= mod:NewSpecialWarningYou(334009, nil, 337445, nil, 1, 2, 1)
local yellReverberatingLeap						= mod:NewYell(334009, 337445)--Short text "Leap"
local yellReverberatingLeapFades				= mod:NewFadesYell(334009, 337445)--Short text "Leap"
local specWarnEchoingAnnihilation				= mod:NewSpecialWarningMoveTo(344721, false, nil, nil, 1, 2, 4)--Off by default since strats may vary. Auto asigns reverb soak by remember which one you spawned
local specWarnSeismicUpheaval					= mod:NewSpecialWarningDodge(334498, nil, nil, nil, 2, 2)
local specWarnCrystalize						= mod:NewSpecialWarningYou(339690, nil, nil, nil, 1, 2)
local specWarnCrystalizeTarget					= mod:NewSpecialWarningMoveTo(339690, false, nil, nil, 1, 2)
local yellCrystalize							= mod:NewYell(339690, nil, nil, nil, "YELL")
local yellCrystalizeFades						= mod:NewFadesYell(339690, nil, nil, nil, "YELL")
local specWarnMeteor							= mod:NewSpecialWarningYou(342544, nil, nil, nil, 1, 2)
local yellMeteor								= mod:NewYell(342544, nil, nil, nil, "YELL")
local specWarnStoneFist							= mod:NewSpecialWarningDefensive(342425, nil, nil, nil, 1, 2)
local specWarnStoneFistTaunt					= mod:NewSpecialWarningTaunt(342425, nil, nil, nil, 1, 2)

local timerReverberatingEruptionCD				= mod:NewCDCountTimer(30, 344496, 138658, nil, 3, 3, nil, nil, true)--Short text "Eruption" (Normal+)
local timerReverberatingLeapCD					= mod:NewCDCountTimer(30, 334009, 337445, nil, 3, 3, nil, nil, true)--Short text "Leap" (LFR)
local timerSeismicUpheavalCD					= mod:NewCDCountTimer(25.1, 334498, nil, nil, nil, 3, nil, nil, true)
local timerCrystalizeCD							= mod:NewCDCountTimer(55, 339690, nil, nil, 3, 5, nil, nil, true)--55 on mythic, 50 on non mythic
local timerStoneFistCD							= mod:NewCDCountTimer(18, 342425, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON, true)

mod:AddSetIconOption("SetIconOnEruption2", 344496, false, false, {4})--Off by default since it conflicts with heart rend
mod:AddSetIconOption("SetIconOnCrystalize", 339690, true, false, {5})
--Adds/Intermissions
local specWarnVolatileStoneShell				= mod:NewSpecialWarningSwitch(340037, "Dps", nil, nil, 1, 2)
local specWarnShatteringBlast					= mod:NewSpecialWarningSpell(332683, nil, nil, nil, 2, 2)

local timerShatteringBlast						= mod:NewCastTimer(5, 332683, nil, nil, nil, 2)
--Adds
mod:AddTimerLine(DBM_COMMON_L.ADDS)
local warnStoneLegionGoliath					= mod:NewSpellAnnounce("ej22777", 2, 343273)
local warnVolatileAnimaInfusion					= mod:NewTargetNoFilterAnnounce(342655, 2, nil, false)
local warnRavenousFeast							= mod:NewTargetCountAnnounce(343273, 3, nil, nil, nil, nil, nil, nil, true)
local warnStonewrathExhaust						= mod:NewCastAnnounce(342722, 3)
local warnWickedSlaughter						= mod:NewTargetNoFilterAnnounce(342253, 2, nil, "Tank")--So tanks know where adds went
local warnStonegaleEffigy						= mod:NewSpellAnnounce(342985, 3)

--local timerRavenousFeastCD						= mod:NewCDCountTimer(18.6, 343273, nil, nil, nil, 3)--Kind of all over the place right now 23-30)
local timerWickedSlaughterCD					= mod:NewCDTimer(8.5, 342253, nil, "Tank|Healer", nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddNamePlateOption("NPAuraOnVolatileShell", 340037)--Adds

local markingSet = "SetOne"
local playerName = UnitName("player")
local LacerationStacks = {}
local castsPerGUID = {}
local playerEruption = 0--Players eruption and the numbber that was theres
mod.vb.HeartIcon = 1
mod.vb.wickedBladeIcon = 1
mod.vb.bladeCount = 0
mod.vb.heartCount = 0
mod.vb.swipeCount = 0
mod.vb.forcesCount = 0
mod.vb.eruptionCount = 0
mod.vb.upHeavalCount = 0
mod.vb.crystalCount = 0
mod.vb.fistCount = 0
mod.vb.shieldUp = false
mod.vb.kaalDead = false
mod.vb.grashDead = false

--Seismic Upheavel triggers an 8 second ICD
--Crystalize triggers an 8 second ICD
--Reverberating Eruption triggers an 8 second ICD/ Leap is inconclusive but probably same
--Wicked blade triggers a 6 second ICD on all but swipe, which then only imposes 5
--Heart rend triggers 2.3 second ICD
--Stone fist triggers 3-3.5 second ICD
--Serrated swipe triggers 2.4 second ICD
--Exclusions:
--1-Heart rend DC not extended by crystalize most of time
--2-To prevent swipe from altering it's OWN CD since it's started in success and not start (where timer update is)
--3-To prevent stone fist from altering it's OWN CD since it's started in success and not start (where timer update is)
--4-Heart rend is not extended by LFR version Reverberation (or anything else?)
--5-Heart rend in general seems ot have half ICD of everything else when ICD is triggered
--Crystallize > tank abilities> wicked blade> eruption>seismic upheaval
local function updateAllTimers(self, ICD, exclusion)
	if not self.Options.ExperimentalTimerCorrection then return end
	DBM:Debug("updateAllTimers running", 3)
	exclusion = exclusion or 0
	--All phase abilities
	if not self.vb.grashDead and timerCrystalizeCD:GetRemaining(self.vb.crystalCount+1) < ICD then
		local elapsed, total = timerCrystalizeCD:GetTime(self.vb.crystalCount+1)
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerCrystalizeCD extended by: "..extend, 2)
--		timerCrystalizeCD:Stop()
		timerCrystalizeCD:Update(elapsed, total+extend, self.vb.crystalCount+1)
	end
	if not self.vb.kaalDead and timerWickedBladeCD:GetRemaining(self.vb.bladeCount+1) < ICD then
		local elapsed, total = timerWickedBladeCD:GetTime(self.vb.bladeCount+1)
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerWickedBladeCD extended by: "..extend, 2)
--		timerWickedBladeCD:Stop()
		timerWickedBladeCD:Update(elapsed, total+extend, self.vb.bladeCount+1)
	end
	local phase = self.vb.phase
	if not self.vb.kaalDead and (phase == 1 or phase == 3) then
		if exclusion ~= 1 and exclusion ~= 4 and timerHeartRendCD:GetRemaining(self.vb.heartCount+1) < (ICD/2) then
			local elapsed, total = timerHeartRendCD:GetTime(self.vb.heartCount+1)
			local extend = (ICD/2) - (total-elapsed)
			DBM:Debug("timerHeartRendCD extended by: "..extend, 2)
--			timerHeartRendCD:Stop()
			timerHeartRendCD:Update(elapsed, total+extend, self.vb.heartCount+1)
		end
		if exclusion ~= 2 and timerSerratedSwipeCD:GetRemaining(self.vb.swipeCount+1) < ICD then
			local elapsed, total = timerSerratedSwipeCD:GetTime(self.vb.swipeCount+1)
			local extend = ICD - (total-elapsed) - 1.5--Whatever ICD is, this ability specifically is that ICD minus 1
			DBM:Debug("timerSerratedSwipeCD extended by: "..extend, 2)
--			timerSerratedSwipeCD:Stop()
			timerSerratedSwipeCD:Update(elapsed, total+extend, self.vb.swipeCount+1)
		end
	end
	if not self.vb.grashDead and (phase == 2 or phase == 3) then
		if self:IsLFR() then
			if timerReverberatingLeapCD:GetRemaining(self.vb.eruptionCount+1) < ICD then
				local elapsed, total = timerReverberatingLeapCD:GetTime(self.vb.eruptionCount+1)
				local extend = ICD - (total-elapsed)
				DBM:Debug("timerReverberatingLeapCD extended by: "..extend, 2)
--				timerReverberatingLeapCD:Stop()
				timerReverberatingLeapCD:Update(elapsed, total+extend, self.vb.eruptionCount+1)
			end
		else
			if timerReverberatingEruptionCD:GetRemaining(self.vb.eruptionCount+1) < ICD then
				local elapsed, total = timerReverberatingEruptionCD:GetTime(self.vb.eruptionCount+1)
				local extend = ICD - (total-elapsed)
				DBM:Debug("timerReverberatingEruptionCD extended by: "..extend, 2)
--				timerReverberatingEruptionCD:Stop()
				timerReverberatingEruptionCD:Update(elapsed, total+extend, self.vb.eruptionCount+1)
			end
		end
		if not self.vb.shieldUp and timerSeismicUpheavalCD:GetRemaining(self.vb.upHeavalCount+1) < ICD then
			local elapsed, total = timerSeismicUpheavalCD:GetTime(self.vb.upHeavalCount+1)
			local extend = ICD - (total-elapsed)
			DBM:Debug("timerSeismicUpheavalCD extended by: "..extend, 2)
--			timerSeismicUpheavalCD:Stop()
			timerSeismicUpheavalCD:Update(elapsed, total+extend, self.vb.upHeavalCount+1)
		end
		if exclusion ~= 3 and timerStoneFistCD:GetRemaining(self.vb.fistCount+1) < ICD then
			local elapsed, total = timerStoneFistCD:GetTime(self.vb.fistCount+1)
			local extend = ICD - (total-elapsed)
			DBM:Debug("timerStoneFistCD extended by: "..extend, 2)
--			timerStoneFistCD:Stop()
			timerStoneFistCD:Update(elapsed, total+extend, self.vb.fistCount+1)
		end
	end
end

function mod:EruptionTarget(targetname, uId)
	if not targetname then return end
	if self:AntiSpam(4, targetname.."2") then
		if self.Options.SetIconOnEruption2 then
			self:SetIcon(targetname, 4, 5)--So icon clears 1 second after blast
		end
		if self:IsLFR() then
			if targetname == playerName then
				specWarnReverberatingLeap:Show()
				specWarnReverberatingLeap:Play("runout")
				yellReverberatingLeap:Yell()
				yellReverberatingLeapFades:Countdown(3.97)--This scan method doesn't support scanningTime, but should be about right
				playerEruption = self.vb.eruptionCount
			else
				warnReverberatingLeap:Show(self.vb.eruptionCount, targetname)
			end
		else
			if targetname == playerName then
				specWarnReverberatingEruption:Show()
				specWarnReverberatingEruption:Play("runout")
				yellReverberatingEruption:Yell()
				yellReverberatingEruptionFades:Countdown(3.97)--This scan method doesn't support scanningTime, but should be about right
				playerEruption = self.vb.eruptionCount
			else
				warnReverberatingEruption:Show(self.vb.eruptionCount, targetname)
			end
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
		warnPulverizingMeteor:Show(self.vb.crystalCount, targetname)
	end
end

function mod:OnCombatStart(delay)
	table.wipe(LacerationStacks)
	table.wipe(castsPerGUID)
	playerEruption = 0
	self.vb.HeartIcon = 1
	self.vb.wickedBladeIcon = self.Options.BladeMarking == "SetOne" and 1 or 2
	self:SetStage(1)
	self.vb.bladeCount = 0
	self.vb.heartCount = 0
	self.vb.swipeCount = 0
	self.vb.forcesCount = 0
	self.vb.eruptionCount = 0
	self.vb.upHeavalCount = 0
	self.vb.crystalCount = 0
	self.vb.fistCount = 0
	self.vb.shieldUp = false
	self.vb.kaalDead = false
	self.vb.grashDead = false
	--Summons a goliath instantly on pull now, no timer needed for this
	if self:IsMythic() then
		--Blizz made timers more consistent on mythic, but said "screw everyone else"
		--General Kaal
		timerSerratedSwipeCD:Start(8.1-delay, 1)--START, but next timer is started at SUCCESS
		timerCallShadowForcesCD:Start(10.5-delay, 1)
		timerWickedBladeCD:Start(18-delay, 1)--16.8-21
		timerHeartRendCD:Start(33.6-delay, 1)--START
		--General Grashaal Air ability
		timerCrystalizeCD:Start(32.5-delay, 1)
		berserkTimer:Start(720)
	else
		--Everyone else still gets crappy less consistent timers
		--General Kaal
		timerSerratedSwipeCD:Start(8.1-delay, 1)--START, but next timer is started at SUCCESS
		timerWickedBladeCD:Start(16.6-delay, 1)--16.8-21
		timerHeartRendCD:Start(28.9-delay, 1)--START 28-30
		--General Grashaal Air ability
		timerCrystalizeCD:Start(23.1-delay, 1)
		berserkTimer:Start(840)
	end
	if self.Options.NPAuraOnVolatileShell then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(333913))
		DBM.InfoFrame:Show(10, "table", LacerationStacks, 1)
	end
	if UnitIsGroupLeader("player") then self:SendSync(self.Options.BladeMarking) end
--	berserkTimer:Start(-delay)--Confirmed normal and heroic
end

function mod:OnCombatEnd()
	table.wipe(castsPerGUID)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnVolatileShell then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 333387 or spellId == 344230 then
		self.vb.bladeCount = self.vb.bladeCount + 1
		specWarnWickedBladeCast:Show(self.vb.bladeCount)
		specWarnWickedBladeCast:Play("specialsoon")
		self.vb.wickedBladeIcon = markingSet == "SetOne" and 1 or 2
		timerWickedBladeCD:Start(nil, self.vb.bladeCount+1)
		updateAllTimers(self, 6)
	elseif spellId == 334765 then
		self.vb.HeartIcon = 1
		self.vb.heartCount = self.vb.heartCount + 1
		specWarnHeartRendCast:Show(self.vb.heartCount)
		specWarnHeartRendCast:Play("specialsoon")
		timerHeartRendCD:Start(nil, self.vb.heartCount+1)
		updateAllTimers(self, 2.3)
	elseif spellId == 334929 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnSerratedSwipe:Show()
			specWarnSerratedSwipe:Play("defensive")
		end
		updateAllTimers(self, 2.4, 2)
	elseif spellId == 344496 then--Eruption (Normal+)
		--"Reverberating Eruption-344496-npc:168113 = pull:252.3, 40.0, 40.0, 32.1, 40.0, Intermission/22.5, 9.6/32.1, 31.9, 28.1", -- [6]
		self.vb.eruptionCount = self.vb.eruptionCount + 1
		timerReverberatingEruptionCD:Start(nil, self.vb.eruptionCount+1)
		if self:IsMythic() and playerEruption > 0 then
			specWarnEchoingAnnihilation:Show(self:IconNumToTexture(playerEruption))
			specWarnEchoingAnnihilation:Play("helpsoak")
		end
		updateAllTimers(self, 8)
		--self:BossTargetScanner(args.sourceGUID, "EruptionTarget", 0.01, 12)
	elseif spellId == 334009 then--Leap (LFR)
		self.vb.eruptionCount = self.vb.eruptionCount + 1
		timerReverberatingLeapCD:Start(nil, self.vb.eruptionCount+1)
		updateAllTimers(self, 8, 4)
		--self:BossTargetScanner(args.sourceGUID, "EruptionTarget", 0.01, 12)
	elseif spellId == 334498 then
		self.vb.upHeavalCount = self.vb.upHeavalCount + 1
		specWarnSeismicUpheaval:Show(self.vb.upHeavalCount)
		specWarnSeismicUpheaval:Play("watchstep")
		if not self.vb.shieldUp then
			timerSeismicUpheavalCD:Start(nil, self.vb.upHeavalCount+1)--usually averages around 30-40, but yes it goes this low as 25.1 when not spell queued to death
		end
		updateAllTimers(self, 8)
	elseif spellId == 342544 then
		self:BossTargetScanner(args.sourceGUID, "MeteorTarget", 0.05, 12)
	elseif spellId == 342256 then
		self.vb.forcesCount = self.vb.forcesCount + 1
		warnCallShadowForces:Show(self.vb.forcesCount)
		if not self.vb.shieldUp then
			timerCallShadowForcesCD:Start(nil, self.vb.forcesCount+1)
		end
	elseif spellId == 342722 then
		warnStonewrathExhaust:Show()
	elseif spellId == 332683 then
		self.vb.shieldUp = false--Technically not accurate but it's how fight is scripted
		specWarnShatteringBlast:Show()
		specWarnShatteringBlast:Play("carefly")
		timerShatteringBlast:Start()
		--Start INCOMING boss timers here, that seems to be how it's scripted.
		self:SetStage(0)
		self.vb.upHeavalCount = 0--always resets since boss stops casting it while shielded, so even between phase 2 and 3 there is a long break
		self.vb.forcesCount = 0
		if self.vb.phase == 2 then
			--Kaal's Wicked Blade timer is tied to shield 100%
			--Start initial Grashal timers and reset crystalize timer
			timerCrystalizeCD:Stop()--Chance this doesn't happen here but at shield
			timerCrystalizeCD:Start(18.5, self.vb.crystalCount+1)--18.5-20.7
			timerStoneFistCD:Start(26.4, 1)--26.4-28.1
			if self:IsLFR() then
				timerReverberatingLeapCD:Start(29.4, 1)--Assumed for now
			else
				timerReverberatingEruptionCD:Start(29.4, 1)--29.4-38.2 (it's basically either 29 or 38 based on if wicked blade happens first
			end
			timerSeismicUpheavalCD:Start(49.7, 1)--19.5-51.7 (19.9, 22.6, 43, 51.7, 29.8)
			--Kael also resumes summoning adds on mythic once intermission 1 is over, but it's pretty instant
--			if self:IsMythic() then
--				timerCallShadowForcesCD:Start(0, 1)--0-5
--			end
		else--Stage 3 (Both Generals at once)
			self.vb.heartCount = 0
			self.vb.swipeCount = 0
			--General Kaal returning
			--Kaal's Wicked Blade timer is tied to shield 100%
			timerSerratedSwipeCD:Start(13.8, 1)--START 13.8-14.1
			timerHeartRendCD:Start(35.8, 1)--START 35.8-38.2
			--Kael also resumes summing adds on mythic once intermission 2 is over
--			if self:IsMythic() then
--				timerCallShadowForcesCD:Start(8, 1)--8-16.6
--			end
			--General Grashaal
			--Restart timers
			timerCrystalizeCD:Stop()
			timerStoneFistCD:Stop()
			timerReverberatingLeapCD:Stop()
			timerReverberatingEruptionCD:Stop()
			timerCrystalizeCD:Start(12.4, self.vb.crystalCount+1)--12.4-12.7
			timerStoneFistCD:Start(20.9, self.vb.fistCount+1)--20.9-21.2
			if self:IsLFR() then
				timerReverberatingLeapCD:Start(25.2, self.vb.eruptionCount+1)--Guessed
			else
				timerReverberatingEruptionCD:Start(25.2, self.vb.eruptionCount+1)--25.2-30.9
			end
			--Re-enable Upheaval
			timerSeismicUpheavalCD:Start(44, 1)--44-44.4
		end
	elseif spellId == 342425 then
		updateAllTimers(self, 3, 3)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnStoneFist:Show()
			specWarnStoneFist:Play("defensive")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 334929 then--Boss stutter casts this often
		self.vb.swipeCount = self.vb.swipeCount + 1
		timerSerratedSwipeCD:Start(20.4, self.vb.swipeCount+1)--21.9 - 1.5
	elseif spellId == 339690 and self:AntiSpam(3, 1) then
		self.vb.crystalCount = self.vb.crystalCount + 1
		timerCrystalizeCD:Start(self:IsMythic() and 55 or 50, self.vb.crystalCount+1)
		updateAllTimers(self, 8, 1)
	elseif spellId == 342732 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		warnRavenousFeast:Show(count, args.destName)
--		timerRavenousFeastCD:Start(self:IsMythic() and 24.6 or 18.2, count+1, args.sourceGUID)
	elseif spellId == 342253 then
		warnWickedSlaughter:CombinedShow(1.5, args.destName)--Needs to allow at least 1.5 to combine targets
		timerWickedSlaughterCD:Start(8.5, args.sourceGUID)
	elseif spellId == 342985 and self:AntiSpam(3, 2) then
		warnStonegaleEffigy:Show()
	elseif spellId == 342425 then
		self.vb.fistCount = self.vb.fistCount + 1
		timerStoneFistCD:Start(15.5, self.vb.fistCount+1)--18-2.5
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 342255 then--Summon Reinforcements
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 172858 then--stone-legion-goliath
			warnStoneLegionGoliath:Show()
--			if self:IsHard() then
--				timerRavenousFeastCD:Start(23, 1, args.destGUID)--No longer reliable, used to be 27, now it's 6-23
--			end
		end
	elseif spellId == 342257 or spellId == 342258 or spellId == 342259 then
		if self.Options.SetIconOnShadowForces then
			local icon = spellId == 342257 and (markingSet == "SetOne" and 8 or 6) or spellId == 342258 and 7 or (markingSet == "SetOne" and 6 or 8)
			self:ScanForMobs(args.destGUID, 2, icon, 1, nil, 12, "SetIconOnShadowForces")
		end
		timerWickedSlaughterCD:Start(6.1, args.destGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 329636 or spellId == 329808 then--50% transition for Kaal/50% transition for Grashaal
		self.vb.shieldUp = true
		warnHardenedStoneForm:Show(args.destName)
		timerCallShadowForcesCD:Stop()--The only timer that always stops here is this one, rest continue on until boss leaves
		if spellId == 329808 then--Grashaal seems to stop casting this while stoned
			timerSeismicUpheavalCD:Stop()
		end
	elseif spellId == 333913 then
		local amount = args.amount or 1
		LacerationStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(LacerationStacks, 0.2)
		end
	elseif spellId == 334765 then
		if self.Options.SetIconOnHeartRend then
			self:SetIcon(args.destName, self.vb.HeartIcon)
		end
		if args:IsPlayer() then
			specWarnHeartRend:Show()
			specWarnHeartRend:Play("targetyou")
		end
		self.vb.HeartIcon = self.vb.HeartIcon + 1
		warnHeartRend:CombinedShow(0.3, self.vb.heartCount, args.destName)
	elseif spellId == 333377 then
		local icon = self.vb.wickedBladeIcon
		if self.Options.SetIconOnWickedBlade2 then
			self:SetIcon(args.destName, icon, 5)
		end
		if args:IsPlayer() then
			specWarnWickedBlade:Show(self:IconNumToTexture(icon))
			specWarnWickedBlade:Play("mm"..icon)
			yellWickedBlade:Yell(icon, icon, icon)
			yellWickedBladeFades:Countdown(4, nil, icon)
		end
		warnWickedBlade:CombinedShow(0.3, self.vb.bladeCount, args.destName)
		self.vb.wickedBladeIcon = self.vb.wickedBladeIcon + 1
	elseif spellId == 339690 then
		if self.Options.SetIconOnCrystalize then
			self:SetIcon(args.destName, markingSet == "SetOne" and 5 or 1)
		end
		if args:IsPlayer() then
			specWarnCrystalize:Show()
			specWarnCrystalize:Play("targetyou")
			yellCrystalize:Yell()
			yellCrystalizeFades:Countdown(spellId)
		elseif self.Options.SpecWarn339690moveto and DBM:UnitDebuff("player", 333913) then
			specWarnCrystalizeTarget:Show(args.destName)
			specWarnCrystalizeTarget:Play("gathershare")
		else
			warnCrystalize:Show(self.vb.crystalCount, args.destName)
		end
	elseif spellId == 342655 then
		warnVolatileAnimaInfusion:Show(args.destName)
	elseif spellId == 340037 then
		if self:AntiSpam(5, 3) then
			specWarnVolatileStoneShell:Show()
			specWarnVolatileStoneShell:Play("targetchange")
		end
		if self.Options.NPAuraOnVolatileShell then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 4)
		end
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
	if spellId == 329636 or spellId == 329808 then--phase 2 (Kael Departing, Grashaal landing)
		warnHardenedStoneFormOver:Show()
		timerWickedBladeCD:Stop()--Probably stops--resets now
		if spellId == 329636 then
			--Stop Outgoing boss (Kael) timers here
			timerHeartRendCD:Stop()
			timerSerratedSwipeCD:Stop()
			--Start Outgoing boss (Kael) (stuff he still casts airborn) here as well
			timerWickedBladeCD:Start(25.1, self.vb.bladeCount+1)--TODO, Needs more data and fixing, 25.7-32 spell queue seems off
		else
			timerWickedBladeCD:Start(19.6, self.vb.bladeCount+1)
		end
		--If crystalize was off CD going into this phase, the CD is reset.
		--But if crystalize was still ticking down it's CD, it's NOT reset
--		if timerCrystalizeCD:GetRemaining(self.vb.crystalCount+1) <= 0 then
--			timerCrystalizeCD:Stop()
--			timerCrystalizeCD:Start(self:IsMythic() and 55 or 50, self.vb.crystalCount+1)
--		end
	elseif spellId == 333913 then
		LacerationStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(LacerationStacks, 0.2)
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
			DBM.InfoFrame:UpdateTable(LacerationStacks, 0.2)
		end
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if (msg:find("344496") or msg:find("344500")) and self:AntiSpam(4, playerName.."2") then--Eruption Backup (if scan fails)
		if self.Options.SetIconOnEruption2 then
			self:SetIcon(playerName, 4, 4.5)--So icon clears 1 second after
		end
		specWarnReverberatingEruption:Show()
		specWarnReverberatingEruption:Play("runout")
		yellReverberatingEruption:Yell()
		yellReverberatingEruptionFades:Countdown(3.5)--A good 0.5 sec slower
		playerEruption = self.vb.eruptionCount
	elseif msg:find("334009") and self:AntiSpam(4, playerName.."2") then--Leap Backup (if scan fails)
		if self.Options.SetIconOnEruption2 then
			self:SetIcon(playerName, 4, 4.5)--So icon clears 1 second after
		end
		specWarnReverberatingLeap:Show()
		specWarnReverberatingLeap:Play("runout")
		yellReverberatingLeap:Yell()
		yellReverberatingLeapFades:Countdown(3.5)--A good 0.5 sec slower
		playerEruption = self.vb.eruptionCount
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if (msg:find("344496") or msg:find("344500")) and targetName then--Eruption Backup (if scan fails)
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName.."2") then--Same antispam as RAID_BOSS_WHISPER on purpose. if player got personal warning they don't need this one
			if self.Options.SetIconOnEruption2 then
				self:SetIcon(targetName, 4, 4.5)--So icon clears 1 second after
			end
			warnReverberatingEruption:Show(self.vb.eruptionCount, targetName)
		end
	elseif msg:find("334009") and targetName then--Leap Backup (if scan fails)
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName.."2") then--Same antispam as RAID_BOSS_WHISPER on purpose. if player got personal warning they don't need this one
			if self.Options.SetIconOnEruption2 then
				self:SetIcon(targetName, 4, 4.5)--So icon clears 1 second after
			end
			warnReverberatingLeap:Show(self.vb.eruptionCount, targetName)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 172858 then--stone-legion-goliath
--		timerRavenousFeastCD:Stop((castsPerGUID[args.sourceGUID] or 0)+1, args.destGUID)
	elseif cid == 173280 then--stone-legion-skirmisher
		timerWickedSlaughterCD:Stop(args.destGUID)
	elseif cid == 168112 and not self.vb.kaalDead then--Kaal
		self.vb.kaalDead = true
		timerWickedBladeCD:Stop()
		timerHeartRendCD:Stop()
		timerSerratedSwipeCD:Stop()
		timerCallShadowForcesCD:Stop()
		timerCrystalizeCD:Stop()--Yes this stops on kaal death too, because his death causes grashaal to recast it immediately
	elseif cid == 168113 and not self.vb.grashDead then--Grashaal
		self.vb.grashDead = true
		timerReverberatingEruptionCD:Stop()
		timerReverberatingLeapCD:Stop()
		timerSeismicUpheavalCD:Stop()
		timerCrystalizeCD:Stop()
		timerStoneFistCD:Stop()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
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
	if spellId == 344496 or spellId == 334009 then
		self:BossUnitTargetScanner(uId, "EruptionTarget", 1)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 343288 then
		local cid = self:GetUnitCreatureId(uId)
		if cid == 168112 and not self.vb.kaalDead then--Kaal
			self.vb.kaalDead = true
			timerWickedBladeCD:Stop()
			timerHeartRendCD:Stop()
			timerSerratedSwipeCD:Stop()
			timerCallShadowForcesCD:Stop()
			timerCrystalizeCD:Stop()--Yes this stops on kaal death too, because his death causes grashaal to recast it immediately
		elseif cid == 168113 and not self.vb.grashDead then--Grashaal
			self.vb.grashDead = true
			timerReverberatingEruptionCD:Stop()
			timerReverberatingLeapCD:Stop()
			timerSeismicUpheavalCD:Stop()
			timerCrystalizeCD:Stop()
			timerStoneFistCD:Stop()
		end
	end
end

do
	--Delayed function just to make absolute sure RL sync overrides user settings after OnCombatStart functions run
	local function UpdateYellIcons(self, msg)
		markingSet = msg
		self.vb.wickedBladeIcon = msg == "SetOne" and 1 or 2
	end

	function mod:OnSync(msg)
		self:Schedule(3, UpdateYellIcons, self, msg)
	end
end
