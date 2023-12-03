local mod	= DBM:NewMod(2556, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(206172)
mod:SetEncounterID(2708)
mod:SetUsedIcons(8, 7, 6)
mod:SetHotfixNoticeRev(20231113000000)
mod:SetMinSyncRevision(20231113000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 420846 429108 429180 429615 426855 426519 428471",--426147
	"SPELL_CAST_SUCCESS 420907 426519 422721 429108 429180",
	"SPELL_SUMMON 421419 428465",
	"SPELL_AURA_APPLIED 420554 425745 425781 423195 427722 428479 429983",
	"SPELL_AURA_APPLIED_DOSE 420554 428479 429983",
	"SPELL_AURA_REMOVED 423195",
	"UNIT_DIED",
	"RAID_BOSS_WHISPER"
)

--[[
(ability.id = 420846 or ability.id = 429108 or ability.id = 429180 or ability.id = 429615 or ability.id = 426855 or ability.id = 426519) and type = "begincast"
 or (ability.id = 420907 or ability.id = 425370) and type = "cast"
 or ability.id = 429655
 or (ability.id = 422721 or ability.id = 425370) and type = "cast"
 or ability.id = 429983 and (type = "applydebuff" or type = "applydebuffstack")
--]]
--TODO, Unravel stack tracking in Stage 2?
--Stage One: Rapid Iteration
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28355))
local warnContinuum									= mod:NewCountAnnounce(420846, 2)
local warnVerdantMatrix								= mod:NewCountAnnounce(420554, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(420554))
local warnInflorescence								= mod:NewYouAnnounce(423195, 1, nil, false, 2)--Can be spammy depending on player movements, off by default, most might track this with WA anyways
local warnSurgingGrowth								= mod:NewCountAnnounce(420971, 2)
local warnWeaversBurden								= mod:NewCountAnnounce(426519, 2, nil, nil, 167180)
local warnWeaversBurdenTargets						= mod:NewTargetCountAnnounce(426519, 2, nil, nil, 167180, nil, nil, nil, true)
local warnEphemeralFlora							= mod:NewCountAnnounce(430563, 3)
local warnLucidVulnerability						= mod:NewCountAnnounce(428479, 4, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(428479))--Player

local specWarnImpendingLoom							= mod:NewSpecialWarningDodgeCount(429615, nil, nil, nil, 2, 2)
local specWarnViridianRain							= mod:NewSpecialWarningDodgeCount(420907, nil, nil, nil, 2, 2)
local specWarnWeaversBurden							= mod:NewSpecialWarningMoveAway(426519, nil, 37859, nil, 1, 2)
local yellWeaversBurden								= mod:NewShortYell(426519, 37859)--ST "Bomb"
--local yellWeaversBurdenFades						= mod:NewShortFadesYell(426519)
local specWarnWeaversBurdenOther					= mod:NewSpecialWarningTaunt(426519, nil, 37859, nil, 1, 2)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(428474, nil, nil, nil, 1, 8)

local timerImpendingLoomCD							= mod:NewCDCountTimer(23.8, 429615, L.Threads, nil, nil, 3)
local timerEphemeralFloraCD							= mod:NewCDCountTimer(49, 430563, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerSurgingGrowthCD							= mod:NewCDCountTimer(7, 420971, DBM_COMMON_L.GROUPSOAKS.." (%s)", nil, nil, 3)--7-9, usually 8-9
local timerViridianRainCD							= mod:NewCDCountTimer(19.1, 420907, DBM_COMMON_L.AOEDAMAGE.." (%s)", nil, nil, 3)
local timerWeaversBurdenCD							= mod:NewCDCountTimer(17.8, 426519, 167180, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--ST "Bombs"
local berserkTimer									= mod:NewBerserkTimer(720)

mod:AddPrivateAuraSoundOption(427722, true, 426519, 1)--Weaver's Burden
--Stage Two: Creation Complete
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28356))
local warnFullBloom									= mod:NewCountAnnounce(426855, 2)
local warnRadialFlourish							= mod:NewCountAnnounce(425370, 2, nil, false)
local warnWakingDecimation							= mod:NewCountAnnounce(428471, 4)

local specWarnLumberingSlam							= mod:NewSpecialWarningDodge(429108, nil, nil, nil, 2, 2)

local timerFullBloomCD								= mod:NewCDCountTimer(49, 426855, nil, nil, nil, 6)
local timerLumberingSlamCD							= mod:NewCDNPTimer(18.2, 429108, nil, nil, nil, 3)--No reason to CL it, it's a nameplate only timer
local timerRadialFlourishCD							= mod:NewCDNPTimer(5.5, 425370, nil, false, nil, 3)--5-12 so kinda fickle, off by default
local timerWakingDecimation							= mod:NewCastTimer(36, 428471, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)--1sec delay before energy starts + 30 + 5 second cast

mod:AddSetIconOption("SetIconOnWarden", -27432, true, 5, {7, 6})
mod:AddSetIconOption("SetIconOnManifestedDream", -28482, true, 5, {8})

mod.vb.rbwDetected = false
mod.vb.contCount = 0
mod.vb.loomCount = 0
mod.vb.burdenCount = 0
mod.vb.surgingCount = 0
mod.vb.rainCount = 0
mod.vb.wardenIcon = 7
mod.vb.bloomCount = 0
mod.vb.floraCount = 0
local castsPerGUID = {}
local playerInflorescence = false

local function blizzardHatesCombatLogLoop(self, isLoop)
	self.vb.floraCount = self.vb.floraCount + 1
	warnEphemeralFlora:Show(self.vb.floraCount)
	if not isLoop then--Loop single time per rotation
		timerEphemeralFloraCD:Start(27, self.vb.floraCount+1)
		self:Schedule(27, blizzardHatesCombatLogLoop, self, true)
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	table.wipe(castsPerGUID)
	self.vb.rbwDetected = false
	self.vb.contCount = 0
	self.vb.loomCount = 0
	self.vb.burdenCount = 0
	self.vb.surgingCount = 0
	self.vb.rainCount = 0
	self.vb.bloomCount = 0
	self.vb.floraCount = 0
	self.vb.wardenIcon = 7
	timerSurgingGrowthCD:Start(10, 1)--It's difficult to accurately time, it has no cast event and using soaks is iffy
	timerWeaversBurdenCD:Start(18, 1)--Start
	timerViridianRainCD:Start(21, 1)
	timerImpendingLoomCD:Start(24, 1)
	timerFullBloomCD:Start(70, 1)
	if self:IsMythic() then
		timerEphemeralFloraCD:Start(28, 1)
		self:Schedule(28, blizzardHatesCombatLogLoop, self)
	end
	self:EnablePrivateAuraSound(427722, "runout", 2)--Weaver's Burden
	berserkTimer:Start(720-delay)
end

--function mod:OnCombatEnd()

--end

function mod:OnTimerRecovery()
	if DBM:UnitBuff("player", 423195) then
		playerInflorescence = true
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 420846 then--Continuum
		self:SetStage(0)
		self.vb.contCount = self.vb.contCount + 1
		--No count resets in BW, so no count resets in DBM
		self.vb.loomCount = 0
		self.vb.burdenCount = 0
		self.vb.surgingCount = 0
		self.vb.rainCount = 0
		self.vb.floraCount = 0
		warnContinuum:Show(self.vb.contCount)
		--Block first surging that happens during this cast
		self:AntiSpam(25, 2)--Block surging alert/timers initially, since 8 second loop doesn't start yet and we wanna start 28 timer
		--"<115.76 10:52:40> [CLEU] SPELL_CAST_START#Creature-0-1471-2549-13215-206172-0000588831#Nymue(70.4%-0.0%)##nil#420846#Continuum#nil#nil",
		--"<117.10 10:52:42> [CLEU] SPELL_AURA_APPLIED_DOSE#Creature-0-1471-2549-13215-206172-0000588831#Nymue#Player-1084-0A94E8A7#****#429983#Surging Growth#DEBUFF#4",
		--"<143.10 10:53:08> [CLEU] SPELL_AURA_REMOVED_DOSE#Creature-0-1471-2549-13215-206172-0000588831#Nymue#Player-1084-0A59CE90#****#429983#Surging Growth#DEBUFF#3",
		timerSurgingGrowthCD:Start(27.3, 1)--self.vb.surgingCount+1
		timerWeaversBurdenCD:Start(34.7, 1)--self.vb.burdenCount+1
		timerViridianRainCD:Start(36.7, 1)--self.vb.rainCount+1
		timerImpendingLoomCD:Start(40.6, 1)--self.vb.loomCount+1
		timerFullBloomCD:Start(87.2, self.vb.bloomCount+1)
		if self:IsMythic() then
			timerEphemeralFloraCD:Start(45, 1)--self.vb.floraCount+1
			self:Schedule(45, blizzardHatesCombatLogLoop, self)
		end
		self:UnregisterShortTermEvents()
	elseif spellId == 429615 then
		self.vb.loomCount = self.vb.loomCount + 1
		specWarnImpendingLoom:Show(self.vb.loomCount)
		specWarnImpendingLoom:Play("farfromline")
		if self.vb.loomCount % 2 == 1 then
			timerImpendingLoomCD:Start(nil, self.vb.loomCount+1)
		end
	elseif spellId == 426855 then--Full Bloom
		self:SetStage(0)
		self.vb.bloomCount = self.vb.bloomCount + 1
		warnFullBloom:Show(self.vb.bloomCount)
		self.vb.wardenIcon = 7
		timerViridianRainCD:Stop()
		timerImpendingLoomCD:Stop()
		timerSurgingGrowthCD:Stop()
		timerWeaversBurdenCD:Stop()
		timerEphemeralFloraCD:Stop()
		self:Unschedule(blizzardHatesCombatLogLoop)
		--Register events for Miasma during intermission only
		if self:IsMythic() then
			self:RegisterShortTermEvents(
				"SPELL_PERIODIC_DAMAGE 428474",
				"SPELL_PERIODIC_MISSED 428474"
			)
		end
	elseif spellId == 429108 or spellId == 429180 then
--		if self:CheckBossDistance(args.sourceGUID, true, 32698, 48) then
		if self:AntiSpam(4, 5) then
			specWarnLumberingSlam:Show()
			specWarnLumberingSlam:Play("shockwave")
		end
	elseif spellId == 426519 then
		self.vb.burdenCount = self.vb.burdenCount + 1
		if not self.vb.rbwDetected then
			warnWeaversBurden:Show(self.vb.burdenCount)
		end
		--21.0, 19.1, 20.0 then 36-37, 19.0, 20.1
		if self.vb.burdenCount % 3 ~= 0 then--3rd cast in each set is last one before full bloom
--			if self.vb.burdenCount % 3 ~= 0 then
				timerWeaversBurdenCD:Start(18, self.vb.burdenCount+1)
--			else
--				timerWeaversBurdenCD:Start(20, self.vb.burdenCount+1)
--			end
		end
--	elseif spellId == 424477 then
--		self.vb.surgingCount = self.vb.surgingCount + 1
--		warnSurgingGrowth:Show(self.vb.surgingCount)
--		timerSurgingGrowthCD:Start(nil, self.vb.surgingCount+1)
	elseif spellId == 428471 then
		warnWakingDecimation:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 420907 then
		self.vb.rainCount = self.vb.rainCount + 1
		specWarnViridianRain:Show(self.vb.rainCount)
		specWarnViridianRain:Play("watchstep")
		if self.vb.rainCount % 3 ~= 0 then--3rd cast in each set is last one before full bloom
			if self.vb.rainCount % 3 ~= 0 then
				timerViridianRainCD:Start(19, self.vb.rainCount+1)
			else
				timerViridianRainCD:Start(20, self.vb.rainCount+1)
			end
		end
	elseif spellId == 422721 then
--		if self:CheckBossDistance(args.sourceGUID, true, 32698, 48) then
		if self:AntiSpam(4, 4) then
			warnRadialFlourish:Show()
		end
		timerRadialFlourishCD:Start(nil, args.sourceGUID)
	elseif spellId == 426519 then
		--Weavers burden is a private aura, but one of targets is always the active tank.
		if args:IsPlayer() then
			if not self.vb.rbwDetected then
				yellWeaversBurden:Yell()
			end
		else
			--Delayed by a frame so as not to snipe the debuff
			specWarnWeaversBurdenOther:Schedule(0.1, args.destName)
			specWarnWeaversBurdenOther:ScheduleVoice(0.1, "tauntboss")
		end
	elseif spellId == 429108 or spellId == 429180 then
		timerLumberingSlamCD:Start(15.2, args.sourceGUID)
--	elseif spellId == 420971 then
--		self.vb.surgingCount = self.vb.surgingCount + 1
--		warnSurgingGrowth:Show(self.vb.surgingCount)
--		timerSurgingGrowthCD:Start()
--	elseif (spellId == 430562 or spellId == 430531) and self:AntiSpam(5, 2) then
--		self.vb.floraCount = self.vb.floraCount + 1
--		warnEphemeralFlora:Show(self.vb.floraCount)
--		timerEphemeralFloraCD:Start(nil, self.vb.floraCount+1)
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 421419 then--Cycle Warden
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
			if self.Options.SetIconOnWarden then
				self:ScanForMobs(args.destGUID, 2, self.vb.wardenIcon, 1, nil, 12, "SetIconOnWarden")
			end
			self.vb.wardenIcon = self.vb.wardenIcon - 1
		end
	elseif spellId == 428465 then--Manifested Dream
		if not castsPerGUID[args.destGUID] then
			timerWakingDecimation:Start(nil, args.destGUID)
			castsPerGUID[args.destGUID] = 0
			if self.Options.SetIconOnManifestedDream then
				self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 12, "SetIconOnManifestedDream")
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 420554 then
		if args:IsPlayer() and not playerInflorescence then
			warnVerdantMatrix:Cancel()
			warnVerdantMatrix:Schedule(1, args.amount or 1)
		end
--	elseif spellId == 427722 then
--		if args:IsPlayer() then
--			specWarnWeaversBurden:Show()
--			specWarnWeaversBurden:Play("runout")
--			yellWeaversBurden:Yell()
--			yellWeaversBurdenFades:Countdown(spellId)
--		else
--			specWarnWeaversBurdenOther:Show(args.destName)
--			specWarnWeaversBurdenOther:Play("tauntboss")
--		end
	elseif spellId == 423195 then
		if args:IsPlayer() then
			playerInflorescence = true
			if self:AntiSpam(3, 1) then
				warnInflorescence:Show()
			end
		end
	elseif spellId == 428479 then
		if args:IsPlayer() then
--			warnBlazingCoalescence:Cancel()
--			warnBlazingCoalescence:Schedule(1, args.amount or 1)
			warnLucidVulnerability:Show(args.amount or 1)
		end
	elseif spellId == 429983 and self:AntiSpam(5, 2) and self.vb.phase % 2 == 1 and not self:IsLFR() then
		self.vb.surgingCount = self.vb.surgingCount + 1
		warnSurgingGrowth:Show(self.vb.surgingCount)
		timerSurgingGrowthCD:Start(nil, self.vb.surgingCount+1)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 423195 then
		if args:IsPlayer() then
			playerInflorescence = false
		end
--	elseif spellId == 427722 then
--		if args:IsPlayer() then
--			yellWeaversBurdenFades:Cancel()
--		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	--Taking damage from miasma with vulnerability debuff
	if spellId == 428474 and destGUID == UnitGUID("player") and DBM:UnitDebuff("player", 428479) and self:AntiSpam(3, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 209800 then--cycle-warden
		timerLumberingSlamCD:Stop(args.destGUID)
		timerRadialFlourishCD:Stop(args.destGUID)
	elseif cid == 213143 then--Manifested Dream
		timerWakingDecimation:Stop(args.destGUID)
	end
end

--Since blizzard hasn't fixed this yet,
--and other addons and WAs are publically using this
--I guess DBM has to as well
function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:427722") then
		if not self.vb.rbwDetected then
			self.vb.rbwDetected = true
			--Unregister private auras, not needed
			if self.paSounds then
				self:DisablePrivateAuraSounds()--Dirty, does full purge but this fight only has the one so it's fine for now
			end
		else--Only use these warnings if private aura sound already disabled, so don't get double sound
			specWarnWeaversBurden:Show()
			specWarnWeaversBurden:Play("runout")
			yellWeaversBurden:Yell()
--			yellWeaversBurdenFades:Countdown(6)
		end
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("427722") and targetName then
		if not self.vb.rbwDetected then
			self.vb.rbwDetected = true
			--Unregister private auras, not needed
			if self.paSounds then
				self:DisablePrivateAuraSounds()--Dirty, does full purge but this fight only has the one so it's fine for now
			end
		end
		targetName = Ambiguate(targetName, "none")
		warnWeaversBurdenTargets:CombinedShow(0.6, self.vb.burdenCount, targetName)
	end
end
