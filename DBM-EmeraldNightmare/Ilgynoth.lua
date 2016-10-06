local mod	= DBM:NewMod(1738, "DBM-EmeraldNightmare", nil, 768)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(105393)
mod:SetEncounterID(1873)
mod:SetZone()
mod:SetUsedIcons(8, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(15299)
mod.respawnTime = 29

mod:RegisterCombat("combat")
mod.syncThreshold = 30

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 210931 209471 208697 208929 208689 210781 208685 218415 223121",
	"SPELL_CAST_SUCCESS 210984 215128 209387 208929",
	"SPELL_AURA_APPLIED 209915 210099 210984 215234 215128 212886",
	"SPELL_AURA_APPLIED_DOSE 210984",
	"SPELL_AURA_REMOVED 209915 215128 208929",
	"SPELL_PERIODIC_DAMAGE 212886",
	"SPELL_PERIODIC_MISSED 212886",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_DIED",
	"RAID_BOSS_WHISPER",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_ADDON"
)

--TODO, figure out voice to use for specWarnHeartPhaseBegin
--TODO, more adds timers (especially corruptors/deathglarers)
--TODO, improve spew corruption to work like thogar bombs (continous alerts/yells)
--TODO, Death Blossom timer for first cast afer a heart phase.
--Stage One: The Ruined Ground
--(ability.id = 208697 or ability.id = 208929 or ability.id = 218415) and type = "begincast" or ability.id = 209915
local warnNightmareGaze				= mod:NewSpellAnnounce(210931, 3, nil, false)--Something tells me this is just something it spam casts
local warnFixate					= mod:NewTargetAnnounce(210099, 2, nil, false)--Spammy so default off
local warnNightmareExplosion		= mod:NewCastAnnounce(209471, 3)
local warnEyeOfFate					= mod:NewStackAnnounce(210984, 2, nil, "Tank")
local warnCorruptorTentacle			= mod:NewSpellAnnounce("ej13191", 2, 208929)
local warnSpewCorruption			= mod:NewTargetAnnounce(208929, 3, nil, true, 2)
local warnSpewCorruptionSoon		= mod:NewSoonAnnounce(208929, 3)
local warnGroundSlam				= mod:NewTargetAnnounce(208689, 2)--Figure this out later
local warnDeathglareTentacle		= mod:NewSpellAnnounce("ej13190", 2, 208697)
local warnDeathBlossom				= mod:NewCastAnnounce(218415, 4)
--Stage Two: The Heart of Corruption
local warnCursedBlood				= mod:NewTargetAnnounce(215128, 3)

--Stage One: The Ruined Ground
local specWarnNightmareCorruption	= mod:NewSpecialWarningMove(212886, nil, nil, nil, 1, 2)
local specWarnFixate				= mod:NewSpecialWarningMoveTo(210099, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(210099), nil, 1, 2)
local specWarnNightmareHorror		= mod:NewSpecialWarningSwitch("ej13188", "-Healer", nil, nil, 1, 2)--spellId for summon 210289
local specWarnEyeOfFate				= mod:NewSpecialWarningStack(210984, nil, 2)
local specWarnEyeOfFateOther		= mod:NewSpecialWarningTaunt(210984, nil, nil, nil, 1, 2)
local specWarnMindFlay				= mod:NewSpecialWarningInterrupt(208697, "HasInterrupt", nil, 2, 1, 2)
--local specWarnCorruptorTentacle		= mod:NewSpecialWarningSwitch("ej13191", false, nil, nil, 1)
local specWarnSpewCorruption		= mod:NewSpecialWarningRun(208929, nil, nil, nil, 4, 2)
local yellSpewCorruption			= mod:NewYell(208929)
local specWarnNightmarishFury		= mod:NewSpecialWarningDefensive(215234, "Tank", nil, nil, 3, 2)
local specWarnDominatorTentacle		= mod:NewSpecialWarningSwitch("ej13189", "-Healer", nil, 2, 1)
local specWarnGroundSlam			= mod:NewSpecialWarningYou(208689, nil, nil, nil, 1, 2)
local yellGroundSlam				= mod:NewYell(208689)
local specWarnGroundSlamNear		= mod:NewSpecialWarningClose(208689, nil, nil, nil, 1, 2)
--Stage Two: The Heart of Corruption
local specWarnHeartPhaseBegin		= mod:NewSpecialWarningFades(209915, nil, nil, nil, 1)
local specWarnCursedBlood			= mod:NewSpecialWarningMoveAway(215128, nil, nil, nil, 1, 2)
local yellCursedBlood				= mod:NewFadesYell(215128)

--Stage One: The Ruined Ground
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerDeathGlareCD				= mod:NewCDTimer(220, "ej13190", nil, nil, nil, 1, 208697)
local timerCorruptorTentacleCD		= mod:NewCDTimer(220, "ej13191", nil, nil, nil, 1, 208929)
local timerNightmareHorrorCD		= mod:NewCDTimer(220, "ej13188", nil, nil, nil, 1, 210289)
local timerEyeOfFateCD				= mod:NewCDTimer(10, 210984, nil, "Tank", nil, 5)
local timerNightmareishFuryCD		= mod:NewNextTimer(10.9, 215234, nil, "Tank", nil, 5)
local timerGroundSlamCD				= mod:NewNextTimer(21.9, 208689, nil, nil, nil, 3)
local timerDeathBlossomCD			= mod:NewNextTimer(105, 218415, nil, nil, nil, 2, nil, DBM_CORE_HEROIC_ICON)
local timerDeathBlossom				= mod:NewCastTimer(15, 218415, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON)
--Stage Two: The Heart of Corruption
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerDarkReconstitution		= mod:NewCastTimer(50, 210781, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON)
local timerFinalTorpor				= mod:NewCastTimer(90, 223121, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON)
local timerCursedBloodCD			= mod:NewNextTimer(15, 215128, nil, nil, nil, 3)

--Stage One: The Ruined Ground
local countdownNightmareHorror		= mod:NewCountdown("Alt50", 210289)
local countdownDeathBlossom			= mod:NewCountdown("AltTwo15", 218415)
--Stage Two: The Heart of Corruption
local countdownDarkRecon			= mod:NewCountdown("Alt50", 210781, nil, nil, 10)

--Stage One: The Ruined Ground
local voiceNightmareCorruption		= mod:NewVoice(212886)--runaway
local voiceFixate					= mod:NewVoice(210099)--targetyou
local voiceNightmareHorror			= mod:NewVoice("ej13188", "-Healer")--bigmob
local voiceEyeOfFate				= mod:NewVoice(210984)--changemt
local voiceMindFlay					= mod:NewVoice(208697, "HasInterrupt", nil, 2)--kickcast
local voiceSpewCorruption			= mod:NewVoice(208929)--runout
local voiceNightmarishFury			= mod:NewVoice(210984)--defensive
local voiceGroundSlam				= mod:NewVoice(208689)--targetyou/watchwave

mod:AddSetIconOption("SetIconOnSpew", 208929, false)
mod:AddSetIconOption("SetIconOnOoze", "ej13186", false)
mod:AddRangeFrameOption(8, 215128)
mod:AddInfoFrameOption(210099)
mod:AddDropdownOption("InfoFrameBehavior", {"Fixates", "Adds"}, "Fixates", "misc")

mod.vb.phase = 1
mod.vb.DominatorCount = 0
mod.vb.CorruptorCount = 0
mod.vb.DeathglareCount = 0
mod.vb.NightmareCount = 0
mod.vb.IchorCount = 0
--Not to be confused with counts above, this is SPANW count not add total count like above
mod.vb.DeathglareSpawn = 0
mod.vb.CorruptorSpawn = 0
local UnitExists, UnitGUID, UnitDetailedThreatSituation = UnitExists, UnitGUID, UnitDetailedThreatSituation
local eyeName = EJ_GetSectionInfo(13185)
local addsTable = {}
local phase1Deathglares = {26, 69, 85, 55}--Variation 26, 75, 85, 60
local phase1Corruptors = {90, 95, 35}--Variation 90, 95, 40
local phase1DeathBlossom = {60, 100, 35}

local phase2Deathglares = {21.5, 90, 130}--21.5, 95
local phase2Corruptors = {45, 95, 35, 85, 40}--45, 75 (need more data)
local phase2MythicCorruptors = {45, 75}--(need more data)
local phase2DeathBlossom = {80}--Unknown beyond first cast
local autoMarkScannerActive = false

local updateInfoFrame, sortInfoFrame
do
	local lines = {}
	sortInfoFrame = function(a, b)
		local a = lines[a]
		local b = lines[b]
		if not tonumber(a) then a = -1 end
		if not tonumber(b) then b = -1 end
		if a > b then return true else return false end
	end

	local DominatorTentacle, CorruptorTentacle, DeathglareTentacle, NightmareHorror, NightmareIchor = EJ_GetSectionInfo(13189), EJ_GetSectionInfo(13191), EJ_GetSectionInfo(13190), EJ_GetSectionInfo(13188), EJ_GetSectionInfo(13186)
	updateInfoFrame = function()
		table.wipe(lines)
		if mod.vb.NightmareCount > 0 then
			if mod:IsTank() then--Add needs to be tanked
				lines["|cff00ffff"..NightmareHorror.."|r"] = mod.vb.NightmareCount
			else
				lines[NightmareHorror] = mod.vb.NightmareCount
			end
		end
		if mod.vb.DominatorCount > 0 then
			if mod:IsTank() then--Add needs to be tanked
				lines["|cff00ffff"..DominatorTentacle.."|r"] = mod.vb.DominatorCount
			else
				lines[DominatorTentacle] = mod.vb.DominatorCount
			end
		end
		if mod.vb.CorruptorCount > 0 then
			lines[CorruptorTentacle] = mod.vb.CorruptorCount
		end
		if mod.vb.DeathglareCount > 0 then
			lines[DeathglareTentacle] = mod.vb.DeathglareCount
		end
		if mod.vb.IchorCount > 0 then
			lines[NightmareIchor] = mod.vb.IchorCount
		end
		return lines
	end
end

--This clean method will only work until 7.1. After which it'll have to be replaced with something FAR uglier
local function autoMarkOozesUntil71(self)
	self:Unschedule(autoMarkOozesUntil71)
	if self.vb.IchorCount == 0 then
		autoMarkScannerActive = false
		return
	end--None left, abort scans
	local lowestUnitID = nil
	local lowestHealth = 100
	for i = 1, 25 do
		local UnitID = "nameplate"..i
		local GUID = UnitGUID(UnitID)
		if GUID then
			local cid = self:GetCIDFromGUID(GUID)
			if cid == 105721 then
				local unitHealth = UnitHealth(UnitID) / UnitHealthMax(UnitID)
				if unitHealth < lowestHealth then
					lowestHealth = unitHealth
					lowestUnitID = UnitID
				end
			end
		end
	end
	if lowestUnitID then
		self:SetIcon(lowestUnitID, 8)
	end
	self:Schedule(1, autoMarkOozesUntil71, self)
end

function mod:SpewCorruptionTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		warnSpewCorruptionSoon:Show()
	end
end

function mod:OnCombatStart(delay)
	table.wipe(addsTable)
	self.vb.phase = 1
	self.vb.DominatorCount = 0
	self.vb.CorruptorCount = 0
	self.vb.DeathglareCount = 0
	self.vb.NightmareCount = 0
	self.vb.IchorCount = 0
	self.vb.DeathglareSpawn = 0
	self.vb.CorruptorSpawn = 0
	autoMarkScannerActive = false
	timerNightmareishFuryCD:Start(6-delay)
	timerGroundSlamCD:Start(12-delay)
	timerDeathGlareCD:Start(26-delay)
	timerNightmareHorrorCD:Start(65-delay)
	timerCorruptorTentacleCD:Start(90-delay)
	if self:IsMythic() then
		self.vb.deathBlossomCount = 0
		timerDeathBlossomCD:Start(60)
	end
	if self.Options.InfoFrame then
		if self.Options.InfoFrameBehavior == "Fixates" then
			DBM.InfoFrame:SetHeader(GetSpellInfo(210099))
			DBM.InfoFrame:Show(10, "playerbaddebuff", 210099)
		else
			DBM.InfoFrame:SetHeader(UNIT_NAMEPLATES_SHOW_ENEMY_MINIONS)
			DBM.InfoFrame:Show(5, "function", updateInfoFrame, sortInfoFrame)
		end
	end
	if self:AntiSpam(15, 2) then
		--Do nothing. Just to avoid spam on pull
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 210931 then
		warnNightmareGaze:Show()
	elseif spellId == 209471 then
		if self:AntiSpam(3, 5) then
			warnNightmareExplosion:Show()
		end
		autoMarkOozesUntil71(self)
	elseif spellId == 208697 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnMindFlay:Show(args.sourceName)
			voiceMindFlay:Play("kickcast")
		end
		if not addsTable[args.sourceGUID] then
			addsTable[args.sourceGUID] = true
			self.vb.DeathglareCount = self.vb.DeathglareCount + 1
			if self:AntiSpam(10, 6) then
				self.vb.DeathglareSpawn = self.vb.DeathglareSpawn + 1
				warnDeathglareTentacle:Show()
				local nextCount = self.vb.DeathglareSpawn + 1
				local timer = self.vb.phase == 2 and phase2Deathglares[nextCount] or phase1Deathglares[nextCount]
				if timer then
					timerDeathGlareCD:Start(timer)
				end
			end
		end
	elseif spellId == 208929 then
		self:BossTargetScanner(args.sourceGUID, "SpewCorruptionTarget", 0.2, 16)
		if not addsTable[args.sourceGUID] then
			addsTable[args.sourceGUID] = true
			self.vb.CorruptorCount = self.vb.CorruptorCount + 1
			if self:AntiSpam(10, 7) then
				self.vb.CorruptorSpawn = self.vb.CorruptorSpawn + 1
				warnCorruptorTentacle:Show()
				local nextCount = self.vb.CorruptorSpawn + 1
				local timer = self.vb.phase == 2 and (self:IsMythic() and phase2MythicCorruptors[nextCount] or phase2Corruptors[nextCount]) or phase1Corruptors[nextCount]
				if timer then
					timerCorruptorTentacleCD:Start(timer)
				end
			end
		end
	elseif spellId == 210781 then--Dark Reconstitution
		if self:IsMythic() then
			timerDarkReconstitution:Start(55)
			countdownDarkRecon:Start(55)
		else
			timerDarkReconstitution:Start()
			countdownDarkRecon:Start()
		end
	elseif spellId == 208685 and self:AntiSpam(4, 2) then--Rupturing roar (Untanked tentacle)
		specWarnDominatorTentacle:Show()
	elseif spellId == 218415 then
		self.vb.deathBlossomCount = self.vb.deathBlossomCount + 1
		warnDeathBlossom:Show()
		timerDeathBlossom:Start()
		countdownDeathBlossom:Start()
		local nextCount = self.vb.deathBlossomCount + 1
		local timer = self.vb.phase == 2 and phase2DeathBlossom[nextCount] or phase1DeathBlossom[nextCount]
		if timer then
			timerDeathBlossomCD:Start(timer, self.vb.deathBlossomCount+1)
		end
	elseif spellId == 223121 then
		timerFinalTorpor:Start()
		countdownDarkRecon:Start(90)
	elseif spellId == 208689 and self:AntiSpam(2, 6) then
		timerGroundSlamCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 210984 then
		timerEyeOfFateCD:Start(nil, args.sourceGUID)
	elseif spellId == 209387 then--First thing Nightmare Horror casts that can give us GUID
		timerEyeOfFateCD:Start(14, args.sourceGUID)
	elseif spellId == 208929 then
		warnSpewCorruption:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnSpewCorruption:Show()
			voiceSpewCorruption:Play("runout")
			yellSpewCorruption:Yell()
		end
		if self.Options.SetIconOnSpew then
			self:SetAlphaIcon(0.5, args.destName)--Number of icons is 2 3 or 4. 4 only if fight is too long really.
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 209915 then--Stuff of Nightmares
		timerCursedBloodCD:Stop()
		timerNightmareishFuryCD:Start(7)
		timerGroundSlamCD:Start(13)
		if self:IsMythic() then
			self.vb.deathBlossomCount = 0
			timerDeathBlossomCD:Start(80)
		end
		timerDeathGlareCD:Start(21.5)
		timerCorruptorTentacleCD:Start(45)
		timerNightmareHorrorCD:Start(95)
		self.vb.phase = self.vb.phase + 1
		self.vb.DeathglareSpawn = 0
		self.vb.CorruptorSpawn = 0
	elseif spellId == 210099 then--Ooze Fixate
		warnFixate:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show(eyeName)
			voiceFixate:Play("targetyou")
		end
		if not addsTable[args.sourceGUID] then
			addsTable[args.sourceGUID] = true
			self.vb.IchorCount = self.vb.IchorCount + 1
			if self.Options.SetIconOnOoze and not self:IsLFR() and not autoMarkScannerActive then
				autoMarkScannerActive = true
				self:Schedule(2.5, autoMarkOozesUntil71, self)
			end
		end
	elseif spellId == 210984 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnEyeOfFate:Show(amount)
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
						specWarnEyeOfFateOther:Show(args.destName)
						voiceEyeOfFate:Play("changemt")
					else
						warnEyeOfFate:Show(args.destName, amount)
					end
				end
			else
				warnEyeOfFate:Show(args.destName, amount)
			end
		end
	elseif spellId == 215234 then
		if self:AntiSpam(3, 4) then
			timerNightmareishFuryCD:Start()
		end
		--Hopefully this has a boss unitID
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnNightmarishFury:Show()
				voiceNightmarishFury:Play("defensive")
				break
			end
		end
	elseif spellId == 215128 then
		warnCursedBlood:CombinedShow(0.5, args.destName)--Multi target assumed
		if self:AntiSpam(2, 3) then
			timerCursedBloodCD:Start()
		end
		if args:IsPlayer() then
			specWarnCursedBlood:Show()
			yellCursedBlood:Schedule(7, 1)
			yellCursedBlood:Schedule(6, 2)
			yellCursedBlood:Schedule(5, 3)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 212886 and args:IsPlayer() and self:AntiSpam(2, 1) then
		specWarnNightmareCorruption:Show()
		voiceNightmareCorruption:Play("runaway")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 209915 then--Stuff of Nightmares
		specWarnHeartPhaseBegin:Show()
		timerDeathGlareCD:Stop()
		timerCorruptorTentacleCD:Stop()
		timerNightmareHorrorCD:Stop()
		timerDeathBlossomCD:Stop()
		timerCursedBloodCD:Start()
	elseif spellId == 215128 and args:IsPlayer() then
		yellCursedBlood:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 208929 and self.Options.SetIconOnSpew then
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 212886 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnNightmareCorruption:Show()
		voiceNightmareCorruption:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local bossUnitID
		if UnitExists(bossUnitID) then--Check if new units exist we haven't detected and added yet.
			local cid = self:GetCIDFromGUID(UnitGUID(bossUnitID))
			if not addsTable[UnitGUID(bossUnitID)] and cid == 105304 then--Dominator Tentacle
				if self:AntiSpam(4, 2) then
					specWarnDominatorTentacle:Show()
				end
				addsTable[UnitGUID(bossUnitID)] = true
				self.vb.DominatorCount = self.vb.DominatorCount + 1
			end
		end
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:208689") then
		specWarnGroundSlam:Show()
		yellGroundSlam:Yell()
		voiceGroundSlam:Play("targetyou")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 105591 or cid == 105304 or cid == 105383 or cid == 105322 or cid == 105721 then
		self:SendSync("EnemyDied", args.destGUID)
	end
end

function mod:OnSync(msg, guid)
	--Syncing used do to combat log range issues if raid is too spread out
	--It's easy to be out of range of combat log event
	if not self:IsInCombat() then return end
	if msg == "EnemyDied" and guid then
		local cid = self:GetCIDFromGUID(guid)
		if cid == 105591 then--Nightmare Horror
			self.vb.NightmareCount = self.vb.NightmareCount - 1
			timerEyeOfFateCD:Stop(guid)
		elseif cid == 105304 then--Dominator Tentacle
			self.vb.DominatorCount = self.vb.DominatorCount - 1
			if self.vb.DominatorCount == 0 then
				timerNightmareishFuryCD:Stop()
				timerGroundSlamCD:Stop()
			end
		elseif cid == 105383 then--Corruptor tentacle
			self.vb.CorruptorCount = self.vb.CorruptorCount - 1
		elseif cid == 105322 then--Deathglare Tentacle
			self.vb.DeathglareCount = self.vb.DeathglareCount - 1
		elseif cid == 105721 then--Nightmare Ichor
			self.vb.IchorCount = self.vb.IchorCount - 1
		end
	end
end

do
	--This method is still 4 seconds faster than using Seeping Corruption
	local NightmareHorror = EJ_GetSectionInfo(13188)
	function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, targetname)
		if targetname == NightmareHorror then
			specWarnNightmareHorror:Show()
			voiceNightmareHorror:Play("bigmob")
			timerNightmareHorrorCD:Start()
			self.vb.NightmareCount = self.vb.NightmareCount + 1
			--timerEyeOfFateCD:Start(18)--Started at seeping corruption for mob GUID
		end
	end
end

function mod:CHAT_MSG_ADDON(prefix, msg, channel, targetName)
	if prefix ~= "Transcriptor" then return end
	if msg:find("spell:208689") and self:AntiSpam(2, targetName) then--Ground Slam
		targetName = Ambiguate(targetName, "none")
		if self:CheckNearby(5, targetName) then
			specWarnGroundSlamNear:Show(targetName)
			voiceGroundSlam:Play("watchwave")
		else
			warnGroundSlam:CombinedShow(1, targetName)
		end
	end
end
