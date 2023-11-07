local mod	= DBM:NewMod(2556, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(206172)
mod:SetEncounterID(2708)
mod:SetUsedIcons(8, 7, 6)
mod:SetHotfixNoticeRev(20231027000000)
mod:SetMinSyncRevision(20231027000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 420846 429108 429180 429615 426855",--426519 426147
	"SPELL_CAST_SUCCESS 420907 425370",
	"SPELL_SUMMON 421419 428465",
	"SPELL_AURA_APPLIED 420554 425745 425781 423195 427722 428479",
	"SPELL_AURA_APPLIED_DOSE 420554 428479",
	"SPELL_AURA_REMOVED 423195",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 420846 or ability.id = 429108 or ability.id = 429180 or ability.id = 429615 or ability.id = 426855) and type = "begincast"
 or (ability.id = 420907 or ability.id = 425370) and type = "cast"
 or ability.id = 429655
--]]
--TODO, Unravel stack tracking in Stage 2?
--TODO, Wait for blizzard to add events for surging and flora to enable warnings/timers
--Stage One: Rapid Iteration
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28355))
local warnContinuum									= mod:NewCountAnnounce(420846, 2)
local warnVerdantMatrix								= mod:NewCountAnnounce(420554, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(420554))
local warnInflorescence								= mod:NewYouAnnounce(423195, 1, nil, false, 2)--Can be spammy depending on player movements, off by default, most might track this with WA anyways
local warnSurgingGrowth								= mod:NewCountAnnounce(420971, 2)
local warnWeaversBurden								= mod:NewCountAnnounce(426519, 2, nil, nil, 167180)
local warnEphemeral									= mod:NewCountAnnounce(430563, 3)
local warnLucidVulnerability						= mod:NewCountAnnounce(428479, 4, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(428479))--Player

local specWarnImpendingLoom							= mod:NewSpecialWarningDodgeCount(429615, nil, nil, nil, 2, 2)
local specWarnViridianRain							= mod:NewSpecialWarningDodgeCount(420907, nil, nil, nil, 2, 2)
local specWarnWeaversBurden							= mod:NewSpecialWarningMoveAway(426519, nil, 37859, nil, 1, 2)--Main tank warning only
local yellWeaversBurden								= mod:NewShortYell(426519, 37859)--ST "Bomb"
--local yellWeaversBurdenFades						= mod:NewShortFadesYell(426519)
local specWarnWeaversBurdenOther					= mod:NewSpecialWarningTaunt(426519, nil, 37859, nil, 1, 2)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(428474, nil, nil, nil, 1, 8)

local timerImpendingLoomCD							= mod:NewCDCountTimer(23.8, 429615, DBM_COMMON_L.DODGES.." (%s)", nil, nil, 3)
--local timerEphemeralFloraCD						= mod:NewAITimer(49, 430563, nil, nil, nil, 3)
--local timerSurgingGrowthCD						= mod:NewAITimer(49, 420971, nil, nil, nil, 3)
local timerViridianRainCD							= mod:NewCDCountTimer(19.1, 420907, DBM_COMMON_L.AOEDAMAGE.." (%s)", nil, nil, 3)
local timerWeaversBurdenCD							= mod:NewCDCountTimer(17.8, 426519, 167180, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--ST "Bombs"
local berserkTimer									= mod:NewBerserkTimer(720)

mod:AddPrivateAuraSoundOption(427722, true, 426519, 1)--Weaver's Burden
--Stage Two: Creation Complete
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28356))
local warnFullBloom									= mod:NewCountAnnounce(426855, 2)

local specWarnLumberingSlam							= mod:NewSpecialWarningDodge(429108, nil, nil, nil, 2, 2)
local specWarnRadialFlourish						= mod:NewSpecialWarningDodge(425370, nil, nil, nil, 2, 2)

local timerFullBloomCD								= mod:NewCDCountTimer(49, 426855, nil, nil, nil, 6)
local timerLumberingSlamCD							= mod:NewCDNPTimer(18.2, 429108, nil, nil, nil, 3)--No reason to CL it, it's a nameplate only timer
local timerRadialFlourishCD							= mod:NewCDNPTimer(5, 425370, nil, false, nil, 3)--5-12 so kinda fickle, off by default
local timerWakingDecimation							= mod:NewCastTimer(36, 428471, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)--1sec delay before energy starts + 30 + 5 second cast

mod:AddSetIconOption("SetIconOnWarden", -27432, true, 5, {7, 6})
mod:AddSetIconOption("SetIconOnManifestedDream", -28482, true, 5, {8})

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
--	timerSurgingGrowthCD:Start(10)--It's difficult to accurately time, it has no cast event and using soaks is iffy
	timerViridianRainCD:Start(21, 1)
	timerWeaversBurdenCD:Start(21, 1)
	timerImpendingLoomCD:Start(24, 1)
	timerFullBloomCD:Start(70, 1)
--	if self:IsMythic() then
		--timerEphemeralFloraCD:Start()
--	end
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
		--No count resets in BW, so no count resets in DBM
--		self.vb.loomCount = 0
--		self.vb.burdenCount = 0
--		self.vb.surgingCount = 0
--		self.vb.rainCount = 0
--		self.vb.floraCount = 0
		warnContinuum:Show(self.vb.contCount)
--		timerSurgingGrowthCD:Start(2, self.vb.surgingCount+1)
		timerViridianRainCD:Start(36.7, self.vb.rainCount+1)
		timerWeaversBurdenCD:Start(36.7, self.vb.burdenCount+1)
		timerImpendingLoomCD:Start(40.6, self.vb.loomCount+1)
		timerFullBloomCD:Start(87.2, self.vb.bloomCount+1)
--		if self:IsMythic() then
			--timerEphemeralFloraCD:Start(2, self.vb.floraCount+1)
--		end
		self:UnregisterShortTermEvents()
	elseif spellId == 429615 then
		self.vb.loomCount = self.vb.loomCount + 1
		specWarnImpendingLoom:Show(self.vb.loomCount)
		specWarnImpendingLoom:Play("watchstep")
		if self.vb.loomCount % 2 == 1 then
			timerImpendingLoomCD:Start(nil, self.vb.loomCount+1)
		end
	elseif spellId == 426855 then--Full Bloom
		self:SetStage(2)
		self.vb.bloomCount = self.vb.bloomCount + 1
		warnFullBloom:Show(self.vb.bloomCount)
		self.vb.wardenIcon = 7
		timerViridianRainCD:Stop()
		timerImpendingLoomCD:Stop()
--		timerSurgingGrowthCD:Stop()
		timerWeaversBurdenCD:Stop()
		--Register events for Miasma during intermission only
		if self:IsMythic() then
			self:RegisterShortTermEvents(
				"SPELL_PERIODIC_DAMAGE 428474",
				"SPELL_PERIODIC_MISSED 428474"
			)
		end
	elseif spellId == 429108 or spellId == 429180 then
		if self:CheckBossDistance(args.sourceGUID, false, 1180, 33) then
			specWarnLumberingSlam:Show()
			specWarnLumberingSlam:Play("shockwave")
		end
		timerLumberingSlamCD:Start(nil, args.sourceGUID)
--	elseif spellId == 426519 then

--	elseif spellId == 424477 then
--		self.vb.surgingCount = self.vb.surgingCount + 1
--		specWarnSurgingGrowth:Show(self.vb.surgingCount)
--		specWarnSurgingGrowth:Play("watchstep")
--		timerSurgingGrowthCD:Start(nil, self.vb.surgingCount+1)
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
--	elseif (spellId == 430562 or spellId == 430531) and self:AntiSpam(5, 2) then
--		self.vb.floraCount = self.vb.floraCount + 1
--		warnEphemeral:Show(self.vb.floraCount)
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
	if spellId == 428474 and destGUID == UnitGUID("player") and DBM:UnitDebuff("player", 428479) and self:AntiSpam(3, 4) then
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 426519 then--Weaver's Burden
		self.vb.burdenCount = self.vb.burdenCount + 1
		warnWeaversBurden:Show(self.vb.burdenCount)
		--21.0, 19.1, 20.0 then 36-37, 19.0, 20.1
		if self.vb.burdenCount % 3 ~= 0 then--3rd cast in each set is last one before full bloom
			if self.vb.burdenCount % 3 ~= 0 then
				timerWeaversBurdenCD:Start(19, self.vb.burdenCount+1)
			else
				timerWeaversBurdenCD:Start(20, self.vb.burdenCount+1)
			end
		end
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
	end
end
