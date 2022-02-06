local mod	= DBM:NewMod(2457, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(181398, 181334)--Could be others
mod:SetEncounterID(2543)
mod:SetUsedIcons(1, 2, 6, 7, 8)
--mod:SetHotfixNoticeRev(20210902000000)
--mod:SetMinSyncRevision(20210706000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 360006 361913 361923 359960 360717 360145 360229 360284",
	"SPELL_CAST_SUCCESS 360319 360420",
	"SPELL_SUMMON 361915",
	"SPELL_AURA_APPLIED 360300 360012 361934 362020 361945 359963 360418 360146 360148 363191 360241 360287",
	"SPELL_AURA_APPLIED_DOSE 360287",
	"SPELL_AURA_REMOVED 360300 360012 361934 362020 361945 360418 360146 360148 363191 360241",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, if bosses have synced energy and hit 100 at same time, combine their special timers into a...special timer.
--TODO, pre spread warning for cloud of carrion?
--TODO, how many total Clouds of carrion go out? how much antispam filtering is needed?
--TODO, how to handle debuff icons, infoframe, etc. Kinda need to see cast frequency, effectiveness in clearning them etc and how much margin for failure should be considered
--TODO, as such, icons, infoframe etc for bursting and cluods of carrion are on hold for now
--TODO, manifest shadows need a special warning?
--TODO, possibly adjust timing of opened veins warning to better align with swaps of other boss, when more precise timings are known
--TODO, detect https://ptr.wowhead.com/spell=360428/moment-of-clarity ?
--TODO, properly detect aura of shadow up. not sure if the buff is on boss or players, boss is assumed ATM
--TODO, target scan Slumber Cloud? two are spawned at once though so even if it works it's only one of them
--TODO, tank defensive warnings may feel like too much by default and be better as opt ins, will guage feedback from testing (if there is testing)
--General
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption("5/8/10")
--Mal'Ganis
mod:AddTimerLine(DBM:EJ_GetSectionInfo(23927))
local warnCloudofCarrion						= mod:NewTargetNoFilterAnnounce(360012, 3)
local warnManifestShadows						= mod:NewCountAnnounce(361913, 3)
local warnFullyFormed							= mod:NewSpellAnnounce(361945, 3)

local specWarnUntoDarkness						= mod:NewSpecialWarningCount(360319, nil, nil, nil, 2, 2)
local specWarnCloudofCarrion					= mod:NewSpecialWarningMoveAway(360319, nil, nil, nil, 2, 2)--Pre spread warning?
local specWarnCloudofCarrionDebuff				= mod:NewSpecialWarningYou(360012, nil, nil, nil, 1, 2)
local specWarnCloudofCarrionDebuffMove			= mod:NewSpecialWarningMoveTo(360012, false, nil, nil, 1, 2)--Off by default because person has to actually have basic understanding of mechanic first, then agree to this helpful warning to help with it
local yellCloudofCarrion						= mod:NewYell(360012)
local specWarnLeechingClaws						= mod:NewSpecialWarningDefensive(359960, nil, nil, nil, 1, 2)
local specWarnOpenedVeins						= mod:NewSpecialWarningTaunt(359963, nil, nil, nil, 1, 2)
----Shadow adds
local specWarnRavenousHunger					= mod:NewSpecialWarningInterruptCount(361923, "HasInterrupt", nil, nil, 1, 2)

local timerUntoDarknessCD						= mod:NewAITimer(28.8, 360319, nil, nil, nil, 6)
local timerSwarmofDecay							= mod:NewBuffActiveTimer(20, 360300, 56158, nil, nil, 6)--Short text swarm, timer is used for both swarms
local timerCloudofCarrionCD						= mod:NewAITimer(28.8, 360006, nil, nil, nil, 3)
local timerManifestShadowsCD					= mod:NewAITimer(28.8, 361913, nil, nil, nil, 1)
local timerLeechingClawsCD						= mod:NewAITimer(28.8, 359960, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON, nil, 2, 4)

mod:AddInfoFrameOption(360319, false)
mod:AddSetIconOption("SetIconOnManifestShadows", 361913, true, true, {6, 7, 8})--On by default since they'll be used by most interrupt helpers
mod:AddNamePlateOption("NPAuraOnIncompleteForm", 362020, false)--Off by default so it doesn't cover up interrupt weak aura counters, which i suspect many will use
mod:AddNamePlateOption("NPAuraOnFullyFormed", 361945, true)--Might also cover up interrupt weak auras, but this signifies target is now very dangerous but killable on mythic difficulty
--Kin'tessa
mod:AddTimerLine(DBM:EJ_GetSectionInfo(23929))
local warnShatterMind							= mod:NewSpellAnnounce(360420, 4)--Kind of a generic alert to say "this pull is a wash"
local warnFearfulTrepidation					= mod:NewTargetNoFilterAnnounce(360146, 3)
local warnAuraofShadows							= mod:NewSpellAnnounce(363191, 4)
local warnAuraofShadowsOver						= mod:NewEndAnnounce(363191, 1)
local warnSlumberCloud							= mod:NewCountAnnounce(360229, 2)
local warnAnguishingStrike						= mod:NewStackAnnounce(360287, 2, nil, "Tank|Healer")

local specWarnInfiltrationofDread				= mod:NewSpecialWarningCount(360717, nil, nil, nil, 2, 2)
local specWarnFearfulTrepidation				= mod:NewSpecialWarningYou(360146, nil, nil, nil, 2, 2)
local yellFearfulTrepidation					= mod:NewShortPosYell(360146)
local yellFearfulTrepidationFades				= mod:NewIconFadesYell(360146)
local specWarnBurstingDread						= mod:NewSpecialWarningDispel(360148, "RemoveMagic", nil, nil, 1, 2)
local specWarnUnsettlingDreams					= mod:NewSpecialWarningDispel(360241, "RemoveMagic", nil, nil, 1, 2)
local specWarnAnguishingStrike					= mod:NewSpecialWarningDefensive(360284, nil, nil, nil, 1, 2)
local specWarnAnguishingStrikeStack				= mod:NewSpecialWarningStack(350202, nil, 3, nil, nil, 1, 6)
local specWarnAnguishingStrikeTaunt				= mod:NewSpecialWarningTaunt(350202, nil, nil, nil, 1, 2)

local timerInfiltrationofDreadCD				= mod:NewAITimer(28.8, 360717, nil, nil, nil, 6)
local timerParanoia								= mod:NewBuffFadesTimer(25, 360418, nil, nil, nil, 5)
local timerFearfulTrepidationCD					= mod:NewAITimer(28.8, 360145, nil, nil, nil, 3)--DBM_COMMON_L.MAGIC_ICON
local timerSlumberCloudCD						= mod:NewAITimer(28.8, 360229, nil, nil, nil, 3)
local timerAnguishingStrikeCD					= mod:NewAITimer(28.8, 360284, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddSetIconOption("SetIconOnFearfulTrepidation", 360146, true, false, {1, 2})--On by default because max targets shows 2 debuffs can be out, and don't want both carrions running to same person. with icons the carrions can make split decisions to pick an icon each are going to

mod.vb.darknessCount = 0
mod.vb.shadowsCount = 0
mod.vb.shadowsIcon = 8
mod.vb.trepidationIcon = 1
mod.vb.infiltrationCount = 0
mod.vb.cloudCount = 0
mod.vb.auraofShadowsOn = false
local castsPerGUID = {}
local playerDebuffed = false

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

function mod:OnCombatStart(delay)
	self.vb.darknessCount = 0
	self.vb.shadowsCount = 0
	self.vb.shadowsIcon = 8
	self.vb.trepidationIcon = 1
	self.vb.infiltrationCount = 0
	self.vb.cloudCount = 0
	playerDebuffed = false
	--Mal'Ganis
	timerUntoDarknessCD:Start(1-delay)
	timerCloudofCarrionCD:Start(1-delay)
	timerManifestShadowsCD:Start(1-delay)
	timerLeechingClawsCD:Start(1-delay)
	--Kin'tessa
	timerInfiltrationofDreadCD:Start(1-delay)
	timerFearfulTrepidationCD:Start(1-delay)
	timerSlumberCloudCD:Start(1-delay)
	timerAnguishingStrikeCD:Start(1-delay)
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

--[[
function mod:OnTimerRecovery()

end
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 360006 then
		specWarnCloudofCarrion:Show()
		specWarnCloudofCarrion:Play("scatter")
		timerCloudofCarrionCD:Start()
	elseif spellId == 361913 then
		self.vb.shadowsCount = self.vb.shadowsCount + 1
		warnManifestShadows:Show(self.vb.shadowsCount)
		timerManifestShadowsCD:Start()
		self.vb.shadowsIcon = 8
	elseif spellId == 361923 then
		if not castsPerGUID[args.sourceGUID] then--This should have been set in summon event
			--But if that failed, do it again here and scan for mobs again here too
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnManifestShadows then
				self:ScanForMobs(args.sourceGUID, 2, self.vb.shadowsIcon, 1, nil, 12, "SetIconOnManifestShadows")
			end
			self.vb.shadowsIcon = self.vb.shadowsIcon - 1
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnRavenousHunger:Show(args.sourceName, count)
			if count == 1 then
				specWarnRavenousHunger:Play("kick1r")
			elseif count == 2 then
				specWarnRavenousHunger:Play("kick2r")
			elseif count == 3 then
				specWarnRavenousHunger:Play("kick3r")
			elseif count == 4 then
				specWarnRavenousHunger:Play("kick4r")
			elseif count == 5 then
				specWarnRavenousHunger:Play("kick5r")
			else
				specWarnRavenousHunger:Play("kickcast")
			end
		end
	elseif spellId == 359960 then
		if self:IsTanking("player", nil, nil, nil, args.sourseGUID) then--Change to boss1/2 if confirmed it's consistent
			specWarnLeechingClaws:Show()
			specWarnLeechingClaws:Play("defensive")
		end
		timerLeechingClawsCD:Start()
	elseif spellId == 360717 then
		self.vb.infiltrationCount = self.vb.infiltrationCount + 1
		specWarnInfiltrationofDread:Show(self.vb.infiltrationCount)
		specWarnInfiltrationofDread:Play("specialsoon")
		timerInfiltrationofDreadCD:Start()
	elseif spellId == 360145 then
		self.vb.trepidationIcon = 1
		timerFearfulTrepidationCD:Start()
	elseif spellId == 360229 then
		self.vb.cloudCount = self.vb.cloudCount + 1
		warnSlumberCloud:Show(self.vb.cloudCount)
		timerSlumberCloudCD:Start()
	elseif spellId == 360284 then
		if self:IsTanking("player", nil, nil, nil, args.sourseGUID) then--Change to boss1/2 if confirmed it's consistent
			specWarnAnguishingStrike:Show()
			specWarnAnguishingStrike:Play("defensive")
		end
		timerAnguishingStrikeCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 360319 then
		self.vb.darknessCount = self.vb.darknessCount + 1
		specWarnUntoDarkness:Show(self.vb.darknessCount)
		specWarnUntoDarkness:Play("specialsoon")
		timerUntoDarknessCD:Start()
	elseif spellId == 360420 then
		warnShatterMind:Show()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 361915 then
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
		end
		if self.Options.SetIconOnManifestShadows then
			self:ScanForMobs(args.destGUID, 2, self.vb.shadowsIcon, 1, nil, 12, "SetIconOnManifestShadows")
		end
		self.vb.shadowsIcon = self.vb.shadowsIcon - 1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 360300 then
		timerSwarmofDecay:Start()
	elseif spellId == 360012 then
		if args:IsPlayer() then
			specWarnCloudofCarrionDebuff:Show()
			specWarnCloudofCarrionDebuff:Play("range5")
			yellCloudofCarrion:Yell()
			updateRangeFrame(self)
		else
			warnCloudofCarrion:Show(args.destName)
		end
	elseif spellId == 361934 or spellId == 362020 then
		if self.Options.NPAuraOnIncompleteForm then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 361945 then
		if self:AntiSpam(3, 2) then--If multiple adds they'll fully form at same time
			warnFullyFormed:Show()
		end
		if self.Options.NPAuraOnFullyFormed then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 359963 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then--If not on a tank, it's just some numpty in wrong place
			if not args:IsPlayer() and not DBM:UnitDebuff("player", spellId) then
				specWarnOpenedVeins:Show(args.destName)
				specWarnOpenedVeins:Play("tauntboss")
			end
		end
	elseif spellId == 360418 and args:IsPlayer() then
		timerParanoia:Start()
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
		elseif self.Options.SpecWarn360012moveto and DBM:UnitDebuff("player", 360012) then--If have Carrion debuff, spec warn to runt o tepidate debuff to clear it
			specWarnCloudofCarrionDebuffMove:CombinedShow(0.3, args.destName)
			specWarnCloudofCarrionDebuffMove:ScheduleVoice(0.3, "gathershare")
		else
			warnFearfulTrepidation:Show(icon, args.destName)
		end
		self.vb.trepidationIcon = self.vb.trepidationIcon + 1
	elseif spellId == 360148 then
		if args:IsPlayer() then
			playerDebuffed = true
			specWarnBurstingDread:Cancel()
			specWarnBurstingDread:CancelVoice()
		end
		--Smart code that only warns player to dispel it, if they thesmelves aren't a victim of it and dispel is off CD
		if self:CheckDispelFilter() and not playerDebuffed then
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
		if self:CheckDispelFilter() and not playerDebuffed then
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
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnAnguishingStrikeStack:Show(amount)
					specWarnAnguishingStrikeStack:Play("stackhigh")
				else
--					local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
--					local remaining
--					if expireTime then
--						remaining = expireTime-GetTime()
--					end
--					if (not remaining or remaining and remaining < 6.7) and not UnitIsDeadOrGhost("player") then--TODO, adjust remaining when Cd known
--						specWarnAnguishingStrikeTaunt:Show(args.destName)
--						specWarnAnguishingStrikeTaunt:Play("tauntboss")
--					else
						warnAnguishingStrike:Show(args.destName, amount)
--					end
				end
			else
				warnAnguishingStrike:Show(args.destName, amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 360300 then
		timerSwarmofDecay:Stop()
	elseif spellId == 360012 then
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	elseif spellId == 361934 or spellId == 362020 then
		if self.Options.NPAuraOnIncompleteForm then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 361945 then
		if self.Options.NPAuraOnFullyFormed then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 360418 and args:IsPlayer() then
		timerParanoia:Stop()
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
	elseif cid == 181334 then--Kin'tessa
		timerInfiltrationofDreadCD:Stop()
		timerFearfulTrepidationCD:Stop()
		timerSlumberCloudCD:Stop()
		timerAnguishingStrikeCD:Stop()
--	elseif cid == 181925 then--Slumber Cloud

	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]
