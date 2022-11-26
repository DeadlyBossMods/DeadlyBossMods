local mod	= DBM:NewMod(2457, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(181398, 181399)
mod:SetEncounterID(2543)
mod:SetUsedIcons(1, 2, 6, 7, 8)
mod:SetHotfixNoticeRev(20220320000000)
mod:SetMinSyncRevision(20220308000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 360006 361913 361923 359960 360717 360145 360229 360284 360300 360304",
	"SPELL_CAST_SUCCESS 360420",
	"SPELL_AURA_APPLIED 360300 360304 360012 361934 362020 361945 359963 360418 360146 360148 363191 360241 360287 364985",
	"SPELL_AURA_APPLIED_DOSE 360287",
	"SPELL_AURA_REMOVED 360300 360304 360012 361934 362020 361945 360418 360146 360148 363191 360241 360516 364985",
	"UNIT_DIED"
)

--TODO, pre spread warning for cloud of carrion?
--TODO, manifest shadows need a special warning?
--TODO, possibly adjust timing of opened veins warning to better align with swaps of other boss, when more precise timings are known
--TODO, properly detect aura of shadow up. not sure if the buff is on boss or players, boss is assumed ATM
--TODO, tank defensive warnings may feel like too much by default and be better as opt ins, will guage feedback from testing (if there is testing)
--[[
(ability.id = 360006 or ability.id = 361913 or ability.id = 359960 or ability.id = 360717 or ability.id = 360145 or ability.id = 360229 or ability.id = 360284 or ability.id = 360300 or ability.id = 360304) and type = "begincast"
 or (ability.id = 360319 or ability.id = 360420) and type = "cast"
 or ability.id = 363191 or ability.id = 360516
 or (ability.id = 360300 or ability.id = 360304) and type = "removebuff"
--]]
--General
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

local berserkTimer								= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption("5/8/10")
--Mal'Ganis
mod:AddTimerLine(DBM:EJ_GetSectionInfo(23927))
local warnCloudofCarrion						= mod:NewTargetNoFilterAnnounce(360012, 3)
local warnManifestShadows						= mod:NewCountAnnounce(361913, 3)
local warnFullyFormed							= mod:NewSpellAnnounce(361945, 3)
local warnUntoDarknessOver						= mod:NewEndAnnounce(360319, 1)

local specWarnUntoDarkness						= mod:NewSpecialWarningCount(360319, nil, nil, nil, 2, 2)
local specWarnCloudofCarrion					= mod:NewSpecialWarningMoveAway(360012, nil, nil, nil, 2, 2)--Pre spread warning?
local specWarnCloudofCarrionDebuff				= mod:NewSpecialWarningYou(360012, nil, nil, nil, 1, 2)
local specWarnCloudofCarrionDebuffMove			= mod:NewSpecialWarningMoveTo(360012, false, nil, nil, 1, 2)--Off by default because person has to actually have basic understanding of mechanic first, then agree to this helpful warning to help with it
local yellCloudofCarrion						= mod:NewYell(360012)
local yellBitingWounds							= mod:NewIconRepeatYell(364985)
local specWarnLeechingClaws						= mod:NewSpecialWarningDefensive(359960, nil, nil, nil, 1, 2)
local specWarnOpenedVeins						= mod:NewSpecialWarningTaunt(359963, nil, nil, nil, 1, 2)
----Shadow adds
local specWarnRavenousHunger					= mod:NewSpecialWarningInterruptCount(361923, "HasInterrupt", nil, nil, 1, 2)

local timerUntoDarknessCD						= mod:NewCDCountTimer(102.4, 360319, nil, nil, nil, 6)--100+3sec cast time with standard variation, paused by infiltration of dread
local timerSwarmofDecay							= mod:NewBuffActiveTimer(20, 360300, 56158, nil, nil, 6)--Short text swarm, timer is used for both swarms
local timerCloudofCarrionCD						= mod:NewCDCountTimer(21.8, 360012, nil, nil, nil, 3)
local timerManifestShadowsCD					= mod:NewCDCountTimer(1, 361913, nil, nil, nil, 1)--No in between time
local timerLeechingClawsCD						= mod:NewCDTimer(16.9, 359960, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON, nil, 2, 4)

mod:AddInfoFrameOption(360319, false)
mod:AddSetIconOption("SetIconOnManifestShadows", 361913, true, true, {6, 7, 8})--On by default since they'll be used by most interrupt helpers
mod:AddNamePlateOption("NPAuraOnIncompleteForm", 362020, false)--Off by default so it doesn't cover up interrupt weak aura counters, which i suspect many will use
mod:AddNamePlateOption("NPAuraOnFullyFormed", 361945, true)--Might also cover up interrupt weak auras, but this signifies target is now very dangerous but killable on mythic difficulty
mod:GroupSpells(360012, 364985)--Group biting wounds with cloud of carrion
--Kin'tessa
mod:AddTimerLine(DBM:EJ_GetSectionInfo(23929))
local warnShatterMind							= mod:NewSpellAnnounce(360420, 4)--Kind of a generic alert to say "this pull is a wash"
local warnFearfulTrepidation					= mod:NewTargetCountAnnounce(360146, 3, nil, nil, 39176, nil, nil, nil, true)
local warnAuraofShadows							= mod:NewSpellAnnounce(363191, 4)
local warnAuraofShadowsOver						= mod:NewEndAnnounce(363191, 1)
local warnSlumberCloud							= mod:NewCountAnnounce(360229, 2)
local warnAnguishingStrike						= mod:NewStackAnnounce(360284, 2, nil, "Tank|Healer", 31907)--shorttext "Strike"

local specWarnInfiltrationofDread				= mod:NewSpecialWarningCount(360717, nil, nil, nil, 2, 2)
local specWarnFearfulTrepidation				= mod:NewSpecialWarningYou(360146, nil, 39176, nil, 2, 2)
local yellFearfulTrepidation					= mod:NewShortPosYell(360146, 39176)--Shorttext "Fear"
local yellFearfulTrepidationFades				= mod:NewIconFadesYell(360146, 39176)
local specWarnBurstingDread						= mod:NewSpecialWarningDispel(360148, "RemoveMagic", 39176, nil, 1, 2)--shorttext "Fear"
local specWarnUnsettlingDreams					= mod:NewSpecialWarningDispel(360241, "RemoveMagic", nil, nil, 1, 2)
local specWarnAnguishingStrike					= mod:NewSpecialWarningDefensive(360284, nil, 31907, nil, 1, 2)
local specWarnAnguishingStrikeStack				= mod:NewSpecialWarningStack(360284, nil, 3, 31907, nil, 1, 6)
local specWarnAnguishingStrikeTaunt				= mod:NewSpecialWarningTaunt(360284, nil, 31907, nil, 1, 2)

local timerInfiltrationofDreadCD				= mod:NewCDCountTimer(122.5, 360717, nil, nil, nil, 6)--120+3sec cast time with standard variation
local timerParanoia								= mod:NewBuffFadesTimer(25, 360418, nil, nil, nil, 5)
local timerFearfulTrepidationCD					= mod:NewCDCountTimer(29.1, 360145, 39176, nil, nil, 3)--DBM_COMMON_L.MAGIC_ICON
local timerSlumberCloudCD						= mod:NewCDCountTimer(32.8, 360229, nil, nil, nil, 3)
local timerAnguishingStrikeCD					= mod:NewCDTimer(9.7, 360284, 31907, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddSetIconOption("SetIconOnFearfulTrepidation", 360146, true, false, {1, 2})--On by default because max targets shows 2 debuffs can be out, and don't want both carrions running to same person. with icons the carrions can make split decisions to pick an icon each are going to
mod:GroupSpells(360717, 360418)--Group paranoia with parent mechanic Infiltration of dread

--Mal'Ganis
mod.vb.darknessCount = 0
mod.vb.carrionCount = 0
mod.vb.carrionDebuffs = 0
mod.vb.shadowsCount = 0
mod.vb.shadowsIcon = 8
--Kin'tessa
mod.vb.trepidationIcon = 1
mod.vb.infiltrationCount = 0
mod.vb.fearfulCount = 0
mod.vb.slumberCount = 0
mod.vb.auraofShadowsOn = false
local castsPerGUID = {}
local playerDebuffed = false
local carrionTime = 0

--Things get a bit complicated with debuff priority
local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self.vb.auraofShadowsOn then--Mythic fear mechanic
		--I know this is smaller range than fearful, but if fearful target goes to 0 right away they'll get feared into bumfuck
		--They are just going to have to be smart enough to joust this (stay within 8 til right before it expires then move out)
		DBM.RangeCheck:Show(8)
	elseif DBM:UnitDebuff("player", 360146) then--Fearful Trepidation
		DBM.RangeCheck:Show(10)
	elseif DBM:UnitDebuff("player", 360012) then--Cloud of Carrion
		DBM.RangeCheck:Show(5)
	else
		DBM.RangeCheck:Hide()
	end
end

local function BugsRepeater(self, text)
	yellBitingWounds:Yell(text)
	self:Schedule(1.5, BugsRepeater, self, text)
end

function mod:OnCombatStart(delay)
	self.vb.darknessCount = 0
	self.vb.shadowsCount = 0
	self.vb.shadowsIcon = 8
	self.vb.carrionCount = 0
	self.vb.carrionDebuffs = 0

	self.vb.trepidationIcon = 1
	self.vb.infiltrationCount = 0
	self.vb.fearfulCount = 0
	self.vb.slumberCount = 0
	playerDebuffed = false
	--Mal'Ganis
	timerCloudofCarrionCD:Start(6-delay, 1)--6-7 (leaning toward 7 on mythic)
	timerManifestShadowsCD:Start(12.1-delay, 1)--12-13 (leaning toward 13 on mythic)
	timerLeechingClawsCD:Start(15.7-delay)
	timerUntoDarknessCD:Start(50-delay, 1)
	--Kin'tessa
	timerAnguishingStrikeCD:Start(8.2-delay)
	timerSlumberCloudCD:Start(12.1-delay, 1)--12-13
	timerFearfulTrepidationCD:Start(25.2-delay, 1)
	timerInfiltrationofDreadCD:Start(123-delay, 1)
	berserkTimer:Start(self:IsMythic() and 540 or self:IsHeroic() and 600 or 780)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_L.INFOFRAME_POWER)
		DBM.InfoFrame:Show(2, "enemypower", 1)--TODO, figure out power type
	end
	if self.Options.NPAuraOnIncompleteForm or self.Options.NPAuraOnFullyFormed then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	table.wipe(castsPerGUID)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.NPAuraOnIncompleteForm or self.Options.NPAuraOnFullyFormed then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 360006 then
		carrionTime = GetTime()
		self.vb.carrionCount = self.vb.carrionCount + 1
		specWarnCloudofCarrion:Show()
		specWarnCloudofCarrion:Play("scatter")
		timerCloudofCarrionCD:Start(nil, self.vb.carrionCount+1)--21.8
	elseif spellId == 361913 then
		self.vb.shadowsCount = self.vb.shadowsCount + 1
		warnManifestShadows:Show(self.vb.shadowsCount)
--		timerManifestShadowsCD:Start(nil, self.vb.shadowsCount+1)--Never recast more than once between stages/rotations
		self.vb.shadowsIcon = 8
	elseif spellId == 361923 and castsPerGUID[args.sourceGUID] then
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnRavenousHunger:Show(args.sourceName, count)
			if count < 6 then
				specWarnRavenousHunger:Play("kick"..count.."r")
			else
				specWarnRavenousHunger:Play("kickcast")
			end
		end
	elseif spellId == 359960 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then--Change to boss1/2 if confirmed it's consistent
			specWarnLeechingClaws:Show()
			specWarnLeechingClaws:Play("defensive")
		end
		timerLeechingClawsCD:Start()--16.9
	elseif spellId == 360717 and self:AntiSpam(3, 1) then
		self.vb.infiltrationCount = self.vb.infiltrationCount + 1
		specWarnInfiltrationofDread:Show(self.vb.infiltrationCount)
		specWarnInfiltrationofDread:Play("specialsoon")
		--Stop some timers (May still be missing some that actually pause/resume instead, but seems accurate enough)
		--Mal'Ganis
		timerCloudofCarrionCD:Stop()
		timerManifestShadowsCD:Stop()
		timerLeechingClawsCD:Stop()
		--Kin'tessa
		timerAnguishingStrikeCD:Stop()
		timerSlumberCloudCD:Stop()
		if self:IsFated() then
			self:AffixEvent(0)
		end
	elseif (spellId == 360300 or spellId == 360304) and self:AntiSpam(3, 2) then
		self.vb.darknessCount = self.vb.darknessCount + 1
		specWarnUntoDarkness:Show(self.vb.darknessCount)
		specWarnUntoDarkness:Play("specialsoon")
		--Stop some timers (May still be missing some that actually pause/resume instead, but seems accurate enough)
		--Mal'Ganis
		timerCloudofCarrionCD:Stop()
		timerManifestShadowsCD:Stop()
		timerLeechingClawsCD:Stop()
		--Kin'tessa
		timerAnguishingStrikeCD:Stop()
		timerFearfulTrepidationCD:Stop()
	elseif spellId == 360145 then
		self.vb.fearfulCount = self.vb.fearfulCount + 1
		self.vb.trepidationIcon = 1
		timerFearfulTrepidationCD:Start(nil, self.vb.fearfulCount+1)--29.1
	elseif spellId == 360229 then
		self.vb.slumberCount = self.vb.slumberCount + 1--Doesn't reset, used by timers and announce
		warnSlumberCloud:Show(self.vb.slumberCount)
		timerSlumberCloudCD:Start(self:IsMythic() and 32.8 or 45, self.vb.slumberCount+1)
	elseif spellId == 360284 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then--Change to boss1/2 if confirmed it's consistent
			specWarnAnguishingStrike:Show()
			specWarnAnguishingStrike:Play("defensive")
		end
		timerAnguishingStrikeCD:Start()--9.7
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 360420 and self:AntiSpam(3, 1) then
		warnShatterMind:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 360012 then
		self.vb.carrionDebuffs = self.vb.carrionDebuffs + 1
		if args:IsPlayer() then
			specWarnCloudofCarrionDebuff:Show()
			specWarnCloudofCarrionDebuff:Play("range5")
			yellCloudofCarrion:Yell()
			updateRangeFrame(self)
		else
			if (GetTime() - carrionTime) < 4 then
				warnCloudofCarrion:CombinedShow(0.5, args.destName)
			end
		end
	elseif spellId == 361934 or spellId == 362020 then
		if self.Options.SetIconOnManifestShadows then
			self:ScanForMobs(args.destGUID, 2, self.vb.shadowsIcon, 1, nil, 12, "SetIconOnManifestShadows")
		end
		self.vb.shadowsIcon = self.vb.shadowsIcon - 1
		if self.Options.NPAuraOnIncompleteForm then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 361945 then
		if self:AntiSpam(3, 3) then--If multiple adds they'll fully form at same time
			warnFullyFormed:Show()
		end
		if self.Options.NPAuraOnFullyFormed then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 359963 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then--If not on a tank, it's just some numpty in wrong place
			if not args:IsPlayer() then
				local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if (not remaining or remaining and remaining < 5) and not UnitIsDeadOrGhost("player") then
					specWarnOpenedVeins:Show(args.destName)
					specWarnOpenedVeins:Play("tauntboss")
				end
			end
		end
	elseif (spellId == 360300 or spellId == 360304) and self:AntiSpam(3, 4) then--Darkness
		timerSwarmofDecay:Start()
		--This timer pauses, but also has a min time of 5 seconds so first we need to check and extend that if applicable
		if timerSlumberCloudCD:GetRemaining(self.vb.slumberCount+1) < 4.6 then
			local elapsed, total = timerSlumberCloudCD:GetTime(self.vb.slumberCount+1)
			local extend = 4.6 - (total-elapsed)
			timerSlumberCloudCD:Update(elapsed, total+extend, self.vb.slumberCount+1)
			DBM:Debug("timerSlumberCloudCD extended by: "..extend, 2)
		end
		timerSlumberCloudCD:Pause(self.vb.slumberCount+1)
		if self:IsFated() then
			self:AffixEvent(0)
		end
	elseif spellId == 360516 and self:AntiSpam(3, 5) then--Infiltration
		timerUntoDarknessCD:Pause(self.vb.darknessCount+1)--Pauses since bosses stop gaining energy
		--This timer pauses, but also has a min time of 5 seconds so first we need to check and extend that if applicable
		if timerFearfulTrepidationCD:GetRemaining(self.vb.fearfulCount+1) < 4.6 then
			local elapsed, total = timerFearfulTrepidationCD:GetTime(self.vb.fearfulCount+1)
			local extend = 4.6 - (total-elapsed)
			timerFearfulTrepidationCD:Update(elapsed, total+extend, self.vb.fearfulCount+1)
			DBM:Debug("timerFearfulTrepidationCD extended by: "..extend, 2)
		end
		timerFearfulTrepidationCD:Pause(self.vb.fearfulCount+1)
	elseif spellId == 360418 and args:IsPlayer() then
		timerParanoia:Start(self:IsEasy() and 40 or 25)
	elseif spellId == 360146 then
		local icon = self.vb.trepidationIcon
		if self.Options.SetIconOnFearfulTrepidation then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnFearfulTrepidation:Show()
			specWarnFearfulTrepidation:Play("runout")
			yellFearfulTrepidation:Yell(icon, icon)
			yellFearfulTrepidationFades:Countdown(spellId, nil, icon)
			updateRangeFrame(self)
			specWarnCloudofCarrionDebuffMove:Cancel()
			specWarnCloudofCarrionDebuffMove:CancelVoice()
		elseif self.Options.SpecWarn360012moveto and DBM:UnitDebuff("player", 360012) then--If have Carrion debuff, spec warn to runt o tepidate debuff to clear it
			specWarnCloudofCarrionDebuffMove:CombinedShow(0.5, args.destName)
			specWarnCloudofCarrionDebuffMove:ScheduleVoice(0.5, "gathershare")
		end
		warnFearfulTrepidation:CombinedShow(0.5, self.vb.fearfulCount, args.destName)
		self.vb.trepidationIcon = self.vb.trepidationIcon + 1
	elseif spellId == 360148 then
		if args:IsPlayer() then
			playerDebuffed = true
			specWarnBurstingDread:Cancel()
			specWarnBurstingDread:CancelVoice()
		end
		--Smart code that only warns player to dispel it, if they thesmelves aren't a victim of it and dispel is off CD
		if self:CheckDispelFilter("magic") and not playerDebuffed then
			specWarnBurstingDread:CombinedShow(0.3, args.destName)
			specWarnBurstingDread:ScheduleVoice(0.3, "helpdispel")
		end
	elseif spellId == 360241 then
		if args:IsPlayer() then
			playerDebuffed = true
			specWarnUnsettlingDreams:Cancel()
			specWarnUnsettlingDreams:CancelVoice()
		end
		--Smart code that only warns player to dispel it, if they thesmelves aren't a victim of it and dispel is off CD
		if self:CheckDispelFilter("magic") and not playerDebuffed then
			specWarnUnsettlingDreams:CombinedShow(0.3, args.destName)
			specWarnUnsettlingDreams:ScheduleVoice(0.3, "helpdispel")
		end
	elseif spellId == 363191 then
		self.vb.auraofShadowsOn = true
		updateRangeFrame(self)
		warnAuraofShadows:Show()
	elseif spellId == 360287 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then--If not on a tank, it's just some numpty in wrong place
			local amount = args.amount or 1
			if args:IsPlayer() and amount >= 3 then
				specWarnAnguishingStrikeStack:Show(amount)
				specWarnAnguishingStrikeStack:Play("stackhigh")
			else
				warnAnguishingStrike:Show(args.destName, amount)
			end
		end
	elseif spellId == 364985 then
		if args:IsPlayer() then
			self:Unschedule(BugsRepeater)
			self:Schedule(1.5, BugsRepeater, self, 7)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if (spellId == 360300 or spellId == 360304) and self:AntiSpam(3, 6) then--Both Swarm casts tied to Darkness
		warnUntoDarknessOver:Show()
		timerSwarmofDecay:Stop()
		--May still be missing some that actually pause/resume instead, but seems accurate enough
		--Mal
		timerLeechingClawsCD:Start(5)
		timerCloudofCarrionCD:Start(7.3, self.vb.carrionCount+1)
		timerManifestShadowsCD:Start(10.1, self.vb.shadowsCount+1)
		timerUntoDarknessCD:Start(nil, self.vb.darknessCount+1)--102.4
		--Kintessa
		timerFearfulTrepidationCD:Start(5, self.vb.fearfulCount+1)
		timerAnguishingStrikeCD:Start(7.4)--7.4-9.7
		--This timer resumes
		timerSlumberCloudCD:Resume(self.vb.slumberCount+1)
		if self:IsFated() then
			self:AffixEvent(1, 2)
		end
	elseif spellId == 360516 and self:AntiSpam(3, 7) then--Infiltration
		--May still be missing some that actually pause/resume instead, but seems accurate enough
		--Mal
		timerLeechingClawsCD:Start(4.6)--4.6-5.3
		timerCloudofCarrionCD:Start(6, self.vb.carrionCount+1)--6-7.1
		timerManifestShadowsCD:Start(10.6, self.vb.shadowsCount+1)
		timerUntoDarknessCD:Resume(self.vb.darknessCount+1)
		--Kintessa
		timerSlumberCloudCD:Start(4.6, self.vb.slumberCount+1)--4.6-5.3
		timerAnguishingStrikeCD:Start(7.1)
		timerInfiltrationofDreadCD:Start(nil, self.vb.infiltrationCount+1)--122.5
		--These timers resume
		timerFearfulTrepidationCD:Resume(self.vb.fearfulCount+1)
		if self:IsFated() then
			self:AffixEvent(1, 2)
		end
	elseif spellId == 360418 and args:IsPlayer() then
		timerParanoia:Stop()
	elseif spellId == 360012 then
		self.vb.carrionDebuffs = self.vb.carrionDebuffs + 1
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	elseif spellId == 361934 or spellId == 362020 then
		if self.Options.NPAuraOnIncompleteForm then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
		end
	elseif spellId == 361945 then
		if self.Options.NPAuraOnFullyFormed then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 360146 then
		if self.Options.SetIconOnFearfulTrepidation then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellFearfulTrepidationFades:Cancel()
			updateRangeFrame(self)
		end
	elseif spellId == 360148 then
		if args:IsPlayer() and not DBM:UnitDebuff("player", 360241) then
			playerDebuffed = false
		end
	elseif spellId == 360241 then
		if args:IsPlayer() and not DBM:UnitDebuff("player", 360148) then
			playerDebuffed = false
		end
	elseif spellId == 363191 then
		self.vb.auraofShadowsOn = false
		updateRangeFrame(self)
		warnAuraofShadowsOver:Show()
	elseif spellId == 364985 then
		if args:IsPlayer() then
			self:Unschedule(BugsRepeater)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 183138 then--Manifest Shadows/Inchoate Shadow
		castsPerGUID[args.destGUID] = nil
	elseif cid == 181398 then--Mal'Ganis
		timerUntoDarknessCD:Stop()
		timerCloudofCarrionCD:Stop()
		timerManifestShadowsCD:Stop()
		timerLeechingClawsCD:Stop()
	elseif cid == 181399 then--Kin'tessa
		timerInfiltrationofDreadCD:Stop()
		timerFearfulTrepidationCD:Stop()
		timerSlumberCloudCD:Stop()
		timerAnguishingStrikeCD:Stop()
	end
end
