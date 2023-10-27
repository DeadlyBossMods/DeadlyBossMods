local wowToc, testBuild = DBM:GetTOC()
if (wowToc < 100200) and not testBuild then return end
local mod	= DBM:NewMod(2556, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(206172)
mod:SetEncounterID(2708)
mod:SetUsedIcons(8, 7, 6)
mod:SetHotfixNoticeRev(20231021000000)
mod:SetMinSyncRevision(20231021000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 420846 429108 429180 429615 426855",--426519 426147
	"SPELL_CAST_SUCCESS 420907 425370",
	"SPELL_SUMMON 421419 428465",
	"SPELL_AURA_APPLIED 420554 425745 425781 423195 427722 428479",
	"SPELL_AURA_APPLIED_DOSE 420554 428479",
	"SPELL_AURA_REMOVED 423195",
--	"SPELL_AURA_REMOVED_DOSE",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 420846 or ability.id = 429108 or ability.id = 429180 or ability.id = 429615 or ability.id = 426855) and type = "begincast"
 or (ability.id = 420907 or ability.id = 425370) and type = "cast"
 or ability.id = 429655
--]]
--TODO, possibly infoframe to track some things, but need the fight overview and mythic mechanics to gauge it
--TODO, Unravel stack tracking in Stage 2?
--TODO, Review and add/tweak mythic mechanics once more
--TODO, proper event for reclaimation activating for cast bar and alert
--Stage One: Rapid Iteration
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28355))
local warnContinuum									= mod:NewCountAnnounce(420846, 2)
local warnVerdantMatrix								= mod:NewCountAnnounce(420554, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(420554))
local warnInflorescence								= mod:NewYouAnnounce(423195, 1)
local warnSurgingGrowth								= mod:NewCountAnnounce(420971, 2)
local warnWeaversBurden								= mod:NewCountAnnounce(426519, 2, nil, nil, 167180)
local warnReclamation								= mod:NewSpellAnnounce(430485, 4)
local warnEphemeral									= mod:NewCountAnnounce(430563, 3)
local warnLucidVulnerability						= mod:NewCountAnnounce(428479, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(428479))--Player

local specWarnImpendingLoom							= mod:NewSpecialWarningDodgeCount(429615, nil, nil, nil, 2, 2)
local specWarnViridianRain							= mod:NewSpecialWarningDodgeCount(420907, nil, nil, nil, 2, 2)
local specWarnWeaversBurden							= mod:NewSpecialWarningMoveAway(426519, nil, 37859, nil, 1, 2)--Main tank warning only
local yellWeaversBurden								= mod:NewShortYell(426519, 37859)--ST "Bomb"
--local yellWeaversBurdenFades						= mod:NewShortFadesYell(426519)
local specWarnWeaversBurdenOther					= mod:NewSpecialWarningTaunt(426519, nil, 37859, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(409058, nil, nil, nil, 1, 8)

local timerImpendingLoomCD							= mod:NewCDCountTimer(23.8, 429615, DBM_COMMON_L.DODGES.." (%s)", nil, nil, 3)
--local timerEphemeralFloraD						= mod:NewAITimer(49, 430563, nil, nil, nil, 3)
--local timerSurgingGrowthCD						= mod:NewAITimer(49, 420971, nil, nil, nil, 3)
local timerViridianRainCD							= mod:NewCDCountTimer(19.8, 420907, DBM_COMMON_L.AOEDAMAGE.." (%s)", nil, nil, 3)
local timerWeaversBurdenCD							= mod:NewCDCountTimer(17.8, 426519, 167180, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--ST "Bombs"
local berserkTimer									= mod:NewBerserkTimer(720)

mod:AddPrivateAuraSoundOption(427722, true, 426519, 1)--Weaver's Burden
--Stage Two: Creation Complete
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28356))
local warnFullBloom									= mod:NewCountAnnounce(426855, 2)

local specWarnLumberingSlam							= mod:NewSpecialWarningDodge(429108, nil, nil, nil, 2, 2)
local specWarnRadialFlourish						= mod:NewSpecialWarningDodge(425370, nil, nil, nil, 2, 2)

local timerFullBloomCD								= mod:NewCDCountTimer(49, 426855, nil, nil, nil, 6)
local timerLumberingSlamCD							= mod:NewCDNPTimer(19.7, 429108, nil, nil, nil, 3)--No reason to CL it, it's a nameplate only timer
local timerRadialFlourishCD							= mod:NewCDNPTimer(5, 425370, nil, false, nil, 3)--5-12 so kinda fickle, off by default
local timerWakingDecimation							= mod:NewCastTimer(35, 428471, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)--Time guessed, 30+5sec cast

mod:AddSetIconOption("SetIconOnWarden", -27432, true, 5, {7, 6})
mod:AddSetIconOption("SetIconOnManifestedDream", -28223, true, 5, {8})

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

function mod:OnCombatStart(delay)
	self:SetStage(1)
	table.wipe(castsPerGUID)
	self.vb.contCount = 0
	self.vb.loomCount = 0
	self.vb.burdenCount = 0
	self.vb.surgingCount = 0
	self.vb.rainCount = 0
	self.vb.bloomCount = 0
	self.vb.floraCount = 0
	self.vb.wardenIcon = 7
	timerViridianRainCD:Start(20, 1)
	timerImpendingLoomCD:Start(24, 1)
--	timerSurgingGrowthCD:Start(1)--Despite what journal says, it's never used in stage 1
	timerWeaversBurdenCD:Start(20.1, 1)
	timerFullBloomCD:Start(76, 1)
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
	if spellId == 420846 then
		self:SetStage(1)
		self.vb.contCount = self.vb.contCount + 1
		self.vb.loomCount = 0
		self.vb.burdenCount = 0
		self.vb.surgingCount = 0
		self.vb.rainCount = 0
		warnContinuum:Show(self.vb.contCount)
		timerViridianRainCD:Start(36.7, 1)
		timerWeaversBurdenCD:Start(36.7, 1)
		timerImpendingLoomCD:Start(40.6, 1)
--		timerSurgingGrowthCD:Start(2)
		timerFullBloomCD:Start(87.7, self.vb.bloomCount+1)
	elseif spellId == 429615 then
		self.vb.loomCount = self.vb.loomCount + 1
		specWarnImpendingLoom:Show(self.vb.loomCount)
		specWarnImpendingLoom:Play("watchstep")
		timerImpendingLoomCD:Start()
	elseif spellId == 426855 then--Full Bloom
		self:SetStage(2)
		self.vb.bloomCount = self.vb.bloomCount + 1
		warnFullBloom:Show(self.vb.bloomCount)
		self.vb.wardenIcon = 7
		timerViridianRainCD:Stop()
		timerImpendingLoomCD:Stop()
--		timerSurgingGrowthCD:Stop()
		timerWeaversBurdenCD:Stop()
	elseif spellId == 429108 or spellId == 429180 then
		if self:CheckBossDistance(args.sourceGUID, false, 1180, 33) then
			specWarnLumberingSlam:Show()
			specWarnLumberingSlam:Play("shockwave")
		end
		timerLumberingSlamCD:Start(nil, args.sourceGUID)
--	elseif spellId == 426519 then
--		self.vb.burdenCount = self.vb.burdenCount + 1
--		timerWeaversBurdenCD:Start()
--	elseif spellId == 424477 then
--		self.vb.surgingCount = self.vb.surgingCount + 1
--		specWarnSurgingGrowth:Show(self.vb.surgingCount)
--		specWarnSurgingGrowth:Play("watchstep")
--		timerSurgingGrowthCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 420907 then
		self.vb.rainCount = self.vb.rainCount + 1
		specWarnViridianRain:Show(self.vb.rainCount)
		specWarnViridianRain:Play("watchstep")
		timerViridianRainCD:Start(nil, self.vb.rainCount+1)
	elseif spellId == 425370 then
		if self:CheckBossDistance(args.sourceGUID, false, 1180, 33) then
			specWarnRadialFlourish:Show()
			specWarnRadialFlourish:Play("watchstep")
		end
		timerRadialFlourishCD:Start(nil, args.sourceGUID)
--	elseif spellId == 420971 then
--		self.vb.surgingCount = self.vb.surgingCount + 1
--		specWarnSurgingGrowth:Show(self.vb.surgingCount)
--		specWarnSurgingGrowth:Play("watchstep")
--		timerSurgingGrowthCD:Start()
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
--mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 409058 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 209800 then--cycle-warden
		timerLumberingSlamCD:Stop(args.destGUID)
		timerRadialFlourishCD:Stop(args.destGUID)
	elseif cid == 213143 then--Manifested Dream
		timerWakingDecimation:Stop(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 430099 then--Surging Growth
		self.vb.surgingCount = self.vb.surgingCount + 1
		warnSurgingGrowth:Show(self.vb.surgingCount)
		--timerSurgingGrowthCD:Start(100, self.vb.surgingCount+1)
	elseif spellId == 426519 then--Weaver's Burden
		self.vb.burdenCount = self.vb.burdenCount + 1
		warnWeaversBurden:Show(self.vb.burdenCount)
		timerWeaversBurdenCD:Start(nil, self.vb.burdenCount+1)
		--Weavers burden is a private aura, but one of targets is always the active tank.
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnWeaversBurden:Show()
			specWarnWeaversBurden:Play("runout")
			yellWeaversBurden:Yell()
--			yellWeaversBurdenFades:Countdown(8)
		else
			local bossTarget = UnitName("boss1target") or DBM_COMMON_L.UNKNOWN
			--Delayed by a frame so as not to snipe the debuff
			specWarnWeaversBurdenOther:Schedule(0.1, bossTarget)
			specWarnWeaversBurdenOther:ScheduleVoice(0.1, "tauntboss")
		end
	elseif spellId == 430484 then--[DNT] Reclamation
		warnReclamation:Show()
	elseif (spellId == 430562 or spellId == 430531) and self:AntiSpam(5, 2) then
		self.vb.floraCount = self.vb.floraCount + 1
		warnEphemeral:Show(self.vb.floraCount)
		--timerEphemeralFloraD:Start(nil, self.vb.floraCount+1)
	end
end
