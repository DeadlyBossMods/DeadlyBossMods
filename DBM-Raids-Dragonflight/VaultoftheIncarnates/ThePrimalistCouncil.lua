local mod	= DBM:NewMod(2486, "DBM-Raids-Dragonflight", 3, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(187771, 187768, 187772, 187767)
mod:SetEncounterID(2590)
mod:SetUsedIcons(1, 2)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20221222000000)
mod:SetMinSyncRevision(20221214000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 373059 372315 372394 372322 372056 372027 372279 374038 375331 397134",
	"SPELL_AURA_APPLIED 391599 371836 371591 386440 371624 386375 372056 374039 372027 386289 386370",
	"SPELL_AURA_APPLIED_DOSE 391599 371836 372027 372056",
	"SPELL_AURA_REMOVED 391599 371836 374039",
	"SPELL_AURA_REMOVED_DOSE 391599 371836",
	"SPELL_PERIODIC_DAMAGE 371514",
	"SPELL_PERIODIC_MISSED 371514"
)

--[[
(ability.id = 373059 or ability.id = 372322 or ability.id = 372056 or ability.id = 372027 or ability.id = 372279 or ability.id = 374038 or ability.id = 375331 or ability.id = 397134) and type = "begincast"
 or (ability.id = 386440 or ability.id = 386375 or ability.id = 386370 or ability.id = 386289) and type = "applybuff"
--]]
--General
local specWarnGTFO								= mod:NewSpecialWarningGTFO(371514, nil, nil, nil, 1, 8)

--local berserkTimer							= mod:NewBerserkTimer(600)
--Kadros Icewrath
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24952))
local warnFrostTomb								= mod:NewTargetNoFilterAnnounce(371591, 4)
local warnGlacialConvocation					= mod:NewSpellAnnounce(386440, 4)

local specWarnPrimalBlizzard					= mod:NewSpecialWarningCount(373059, nil, nil, nil, 2, 2)
local specWarnPrimalBlizzardStack				= mod:NewSpecialWarningStack(373059, nil, 7, nil, nil, 1, 6)
local specWarnFrostSpike						= mod:NewSpecialWarningInterrupt(372315, "HasInterrupt", nil, nil, 1, 2)

local timerPrimalBlizzardCD						= mod:NewCDCountTimer(79.4, 373059, nil, nil, nil, 2)--Can be delayed by many seconds

mod:AddInfoFrameOption(373059, false)
--Dathea Stormlash
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24958))
local warnConductiveMark						= mod:NewTargetAnnounce(371624, 4, nil, false)--Even with global target filter on by default, off by default due to spam potential
local warnStormingConvocation					= mod:NewSpellAnnounce(386375, 4)

local specWarnConductiveMarkSpread				= mod:NewSpecialWarningMoveAway(371624, nil, nil, nil, 2, 2)
local specWarnConductiveMark					= mod:NewSpecialWarningMoveTo(371624, nil, nil, nil, 1, 13)
local yellConductiveMark						= mod:NewYell(371624, 28836)
local specWarnLightningBolt						= mod:NewSpecialWarningInterrupt(372394, "HasInterrupt", nil, nil, 1, 2)

local timerConductiveMarkCD						= mod:NewCDCountTimer(24.4, 371624, nil, nil, nil, 3)
local timerChainLightningCD						= mod:NewCDTimer(9.1, 372279, nil, "Healer", nil, 3)--9.1-15.4

--Opalfang
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24967))
local warnCrush									= mod:NewStackAnnounce(372056, 2, nil, "Tank|Healer")
local warnQuakingConvocation					= mod:NewSpellAnnounce(386370, 4)

local specWarnEarthenPillar						= mod:NewSpecialWarningCount(397134, nil, nil, nil, 2, 2)--Warn everyone for now, change if it has emotes or debuff later
local specWarnCrush								= mod:NewSpecialWarningDefensive(372056, nil, nil, nil, 2, 2)
local specWarnCrushTaunt						= mod:NewSpecialWarningTaunt(372056, nil, nil, nil, 1, 2)

local timerEarthenPillarCD						= mod:NewCDCountTimer(40.8, 397134, nil, nil, nil, 3)--40.8--71
local timerCrushCD								= mod:NewCDCountTimer(21.6, 372056, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Embar Firepath
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24965))
local warnMeteorAxe								= mod:NewTargetNoFilterAnnounce(374038, 4)
local warnSlashingBlaze							= mod:NewStackAnnounce(372027, 2, nil, "Tank|Healer")
local warnBurningConvocation					= mod:NewSpellAnnounce(386289, 4)

local specWarnMeteorAxe							= mod:NewSpecialWarningYouPos(374038, nil, nil, nil, 1, 2)
local yellMeteorAxe								= mod:NewShortPosYell(374038, 374043, nil, nil, "YELL")
local yellMeteorAxeFades						= mod:NewIconFadesYell(374038, 374043, nil, nil, "YELL")
local specWarnSlashingBlaze						= mod:NewSpecialWarningDefensive(372027, nil, nil, nil, 2, 2)
local specWarnSlashingBlazeTaunt				= mod:NewSpecialWarningTaunt(372027, nil, nil, nil, 1, 2)

local timerMeteorAxeCD							= mod:NewCDCountTimer(39.1, 374038, nil, nil, nil, 3)
local timerSlashingBlazeCD						= mod:NewCDCountTimer(27.7, 372027, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddSetIconOption("SetIconOnMeteorAxe", 374038, true, 9, {1, 2})

local blizzardStacks = {}
local playerBlizzardHigh = false
mod.vb.blizzardCast = 0
mod.vb.markCast = 0
mod.vb.pillarCast = 0
mod.vb.crushCast = 0
mod.vb.meteorCast = 0
mod.vb.meteorTotal = 0
mod.vb.blazeCast = 0
local meteorIcons = {}
local difficultyName = "normal"--Unused right now, mythic and normal are same with very minor variances, heroic is probably obsolete but will see on live
local allTimers = {
	["mythic"] = {--Needs work, some of these can be lower
		--Conductive Mark
		[375331] = {13, 42.5, 26, 24.7, 26, 26.8, 25, 26, 27, 27},
		--Pillars
		[372322] = {5, 27, 29, 26, 25, 28, 27, 26, 27, 27, 26, 28},
		--Primal Blizzard (excluded for now)
		[373059] = {37, 89, 80, 81},
	},
	["heroic"] = {--Needs work, some of these can be lower
		--Conductive Mark
		[375331] = {15.7, 55.9, 35.3, 36.5, 34.1, 36.5, 36.5, 35.2, 37.7, 32.8, 35.2},
		--Pillars
		[372322] = {7.2, 35.3, 37.7, 35.2, 36.5, 35.3, 35.2, 34.1, 37.7, 34, 35.2, 37.6},
		--Primal Blizzard (excluded for now)
		[373059] = {49.8, 118, 105.8, 108},
	},
	["normal"] = {--Needs work, some of these can be lower (Also includes LFR)
		--Conductive Mark
		[375331] = {16.7, 70.5, 43.7, 44.9, 43.7, 44.9, 43.8, 41.2, 44.9, 45, 42.5},
		--Pillars
		[372322] = {8.5, 42.9, 47.6, 43.7, 43.7, 46.1, 43.7, 42.5, 47.3, 42.5, 43.7, 47.4},
		--Primal Blizzard (excluded for now)
		[373059] = {60, 149.6, 133, 133},
	},
}

function mod:OnCombatStart(delay)
	table.wipe(blizzardStacks)
	playerBlizzardHigh = false
	self.vb.blizzardCast = 0
	self.vb.markCast = 0
	self.vb.pillarCast = 0
	self.vb.crushCast = 0
	self.vb.meteorCast = 0
	self.vb.blazeCast = 0
	if self:IsHard() then
		--Same on heroic and mythic
		--Embar Firepath
		timerSlashingBlazeCD:Start(10-delay, 1)
		if self:IsMythic() then
			difficultyName = "mythic"
			--Kadros Icewrath
			timerPrimalBlizzardCD:Start(37-delay, 1)
			--Dathea Stormlsh
			timerChainLightningCD:Start(12.1-delay)
			timerConductiveMarkCD:Start(13-delay, 1)
			--Opalfang
			timerEarthenPillarCD:Start(5-delay, 1)
			timerCrushCD:Start(28.1-delay, 1)--TODO verify, seems iffy, but maybe delayed by other casts being altered
			--Embar Firepath
			timerMeteorAxeCD:Start(22.7-delay, 1)
		else--Heroic
			difficultyName = "heroic"
			--Kadros Icewrath
			timerPrimalBlizzardCD:Start(48-delay, 1)
			--Dathea Stormlsh
			timerChainLightningCD:Start(12.1-delay)
			timerConductiveMarkCD:Start(15.7-delay, 1)
			--Opalfang
			timerEarthenPillarCD:Start(6.9-delay, 1)
			timerCrushCD:Start(18.1-delay, 1)
			--Embar Firepath
			timerMeteorAxeCD:Start(29.6-delay, 1)
		end
	else--Timers are slowed down
		difficultyName = "normal"
		--Kadros Icewrath
		timerPrimalBlizzardCD:Start(60-delay, 1)
		--Dathea Stormlsh
		timerChainLightningCD:Start(10.7-delay)
		timerConductiveMarkCD:Start(16.7-delay, 1)
		--Opalfang
		timerEarthenPillarCD:Start(8.5-delay, 1)
		timerCrushCD:Start(18.2-delay, 1)
		--Embar Firepath
		timerSlashingBlazeCD:Start(9.2-delay, 1)
		timerMeteorAxeCD:Start(22.3-delay, 1)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(373059))
		DBM.InfoFrame:Show(self:IsMythic() and 20 or 10, "table", blizzardStacks, 1)--On mythic, see everyone to coordinate clears, else just show top idiots because cleares are infinite
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		difficultyName = "mythic"
	elseif self:IsHeroic() then
		difficultyName = "heroic"
	else
		difficultyName = "normal"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 373059 then
		self.vb.blizzardCast = self.vb.blizzardCast + 1
		specWarnPrimalBlizzard:Show(self.vb.blizzardCast)
		specWarnPrimalBlizzard:Play("aesoon")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.blizzardCast+1) or self:IsMythic() and 80 or self:IsHeroic() and 105.8 or self:IsEasy() and 133
		timerPrimalBlizzardCD:Start(timer, self.vb.blizzardCast+1)
	elseif spellId == 372315 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnFrostSpike:Show(args.sourceName)
		specWarnFrostSpike:Play("kickcast")
	elseif spellId == 372394 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnLightningBolt:Show(args.sourceName)
		specWarnLightningBolt:Play("kickcast")
	elseif spellId == 372322 or spellId == 397134 then
		self.vb.pillarCast = self.vb.pillarCast + 1
		specWarnEarthenPillar:Show(self.vb.pillarCast)
		specWarnEarthenPillar:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, 372322, self.vb.pillarCast+1) or self:IsMythic() and 25 or self:IsHeroic() and 34 or self:IsEasy() and 42.5
		timerEarthenPillarCD:Start(timer, self.vb.pillarCast+1)
	elseif spellId == 372056 then
		self.vb.crushCast = self.vb.crushCast + 1
		timerCrushCD:Start(nil, self.vb.crushCast+1)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnCrush:Show()
			specWarnCrush:Play("defensive")
		end
	elseif spellId == 372027 then
		self.vb.blazeCast = self.vb.blazeCast + 1
		timerSlashingBlazeCD:Start(nil, self.vb.blazeCast+1)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnSlashingBlaze:Show()
			specWarnSlashingBlaze:Play("defensive")
		end
	elseif spellId == 372279 then
		timerChainLightningCD:Start()
	elseif spellId == 374038 then
		self.vb.meteorCast = self.vb.meteorCast + 1
		table.wipe(meteorIcons)
--		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.meteorCast+1) or 49.7
		timerMeteorAxeCD:Start(self:IsEasy() and 66 or self:IsHeroic() and 52.3 or 39.1, self.vb.meteorCast+1)
	elseif spellId == 375331 then
		self.vb.markCast = self.vb.markCast + 1
		specWarnConductiveMarkSpread:Show()
		specWarnConductiveMarkSpread:Play("range5")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.markCast+1) or self:IsMythic() and 25 or self:IsHeroic() and 32.8 or self:IsEasy() and 41.2
		if timer then
			timerConductiveMarkCD:Start(timer, self.vb.markCast+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 391599 or spellId == 371836 then--Mythic, Non Mythic
		local amount = args.amount or 1
		blizzardStacks[args.destName] = amount
		if args:IsPlayer() and amount >= 7 then
			playerBlizzardHigh = true
			specWarnPrimalBlizzardStack:Show(amount)
			specWarnPrimalBlizzardStack:Play("stackhigh")
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(blizzardStacks)
		end
	elseif spellId == 371591 then
		warnFrostTomb:CombinedShow(2, args.destName)--If I learned anything from jaina, loose aggregation is required
	elseif spellId == 386440 then
		warnGlacialConvocation:Show()
		timerPrimalBlizzardCD:Stop()
	elseif spellId == 371624 then
		warnConductiveMark:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnConductiveMark:Show(DBM_COMMON_L.PILLAR)
			specWarnConductiveMark:Play("movetopillar")
			yellConductiveMark:Yell()
		end
	elseif spellId == 386375 then
		warnStormingConvocation:Show()
		timerConductiveMarkCD:Stop()
		timerChainLightningCD:Stop()
	elseif spellId == 372056 and not args:IsPlayer() then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
			local remaining
			if expireTime then
				remaining = expireTime-GetTime()
			end
			if (not remaining or remaining and remaining < 6.1) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
				specWarnCrushTaunt:Show(args.destName)
				specWarnCrushTaunt:Play("tauntboss")
			else
				warnCrush:Show(args.destName, amount)
			end
		end
	elseif spellId == 386370 then
		warnQuakingConvocation:Show()
		timerEarthenPillarCD:Stop()
		timerCrushCD:Stop()
	elseif spellId == 374039 then
		meteorIcons[#meteorIcons+1] = args.destName
		if #meteorIcons == 2 or DBM:NumRealAlivePlayers() < 2 then
			table.sort(meteorIcons, DBM.SortByTankRoster)
			for i = 1, #meteorIcons do
				local name = meteorIcons[i]
				if self.Options.SetIconOnMeteorAxe then
					self:SetIcon(name, i)
				end
				if name == DBM:GetMyPlayerInfo() then
					specWarnMeteorAxe:Show(self:IconNumToTexture(i))
					specWarnMeteorAxe:Play("mm"..i)
					yellMeteorAxe:Yell(i, i)
					yellMeteorAxeFades:Countdown(spellId, nil, i)
				end
			end
			warnMeteorAxe:Show(table.concat(meteorIcons, "<, >"))
		end
	elseif spellId == 372027 and not args:IsPlayer() then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
			local remaining
			if expireTime then
				remaining = expireTime-GetTime()
			end
			if (not remaining or remaining and remaining < 6.1) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
				specWarnSlashingBlazeTaunt:Show(args.destName)
				specWarnSlashingBlazeTaunt:Play("tauntboss")
			else
				warnSlashingBlaze:Show(args.destName, amount)
			end
		end
	elseif spellId == 386289 then
		warnBurningConvocation:Show()
		timerMeteorAxeCD:Stop()
		timerSlashingBlazeCD:Stop()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 391599 or spellId == 371836 then--Mythic, Non Mythic
		blizzardStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(blizzardStacks)
		end
		if args:IsPlayer() then
			playerBlizzardHigh = false
		end
	elseif spellId == 374039 then
		if self.Options.SetIconOnMeteorAxe then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellMeteorAxeFades:Cancel()
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 391599 or spellId == 371836 then
		local amount = args.amount or 1
		blizzardStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(blizzardStacks)
		end
		if args:IsPlayer() and amount < 8 then
			playerBlizzardHigh = false
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	--Warn for standing in fire unless it's to clear a high blizzard
	--(if you're clearing low stacks you're just taking needless damage and should be warned for it
	if spellId == 371514 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) and not playerBlizzardHigh then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
