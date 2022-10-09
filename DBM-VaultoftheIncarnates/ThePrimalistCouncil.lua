local mod	= DBM:NewMod(2486, "DBM-VaultoftheIncarnates", nil, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(187771, 187768, 187772, 187767)
mod:SetEncounterID(2590)
mod:SetUsedIcons(1, 2)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20221008000000)
mod:SetMinSyncRevision(20221008000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 373059 372315 372394 372322 372056 372027 372279 374038",
	"SPELL_AURA_APPLIED 391599 371836 371591 386440 371624 386375 372056 374039 372027 386289 386370",
	"SPELL_AURA_APPLIED_DOSE 391599 371836 372027 372056",
	"SPELL_AURA_REMOVED 391599 371836 374039",
	"SPELL_AURA_REMOVED_DOSE 391599 371836",
	"SPELL_PERIODIC_DAMAGE 371514",
	"SPELL_PERIODIC_MISSED 371514",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4"
)

--TODO, conductive mark has numerous spellids and the one that's a cast looks like a hidden script. 10 to 1, it's not in combat log. (https://www.wowhead.com/beta/spell=375331/conductive-mark)
--TODO, mark some of conductive marks? On mythic it goes on 10 targets, not enough marks for all that, plus meteor axe needs 2 marks as prio
--TODO, earthen pillar targetting unclear, it probably uses RAID_BOSS_WHISPER if i had to guess, because there is no debuff
--General
local specWarnGTFO								= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--local berserkTimer							= mod:NewBerserkTimer(600)
--Kadros Icewrath
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24952))
local warnFrostTomb								= mod:NewTargetNoFilterAnnounce(371591, 4)
local warnGlacialConvocation					= mod:NewSpellAnnounce(386440, 4)

local specWarnPrimalBlizzard					= mod:NewSpecialWarningCount(373059, nil, nil, nil, 2, 2)
local specWarnPrimalBlizzardStack				= mod:NewSpecialWarningStack(373059, nil, 8, nil, nil, 1, 6)
local specWarnFrostSpike						= mod:NewSpecialWarningInterrupt(372315, "HasInterrupt", nil, nil, 1, 2)

local timerPrimalBlizzardCD						= mod:NewCDTimer(123, 373059, nil, nil, nil, 2)--123-140, for some reason boss likes to sit at full energy for for a while (but not always!)

mod:AddInfoFrameOption(373059, true)
--Dathea Stormlash
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24958))
local warnConductiveMark						= mod:NewTargetAnnounce(371624, 4, nil, false)--Even with global target filter on by default, off by default due to spam potential
--local warnChainLightning						= mod:NewTargetAnnounce(374021, 2)
local warnStormingConvocation					= mod:NewSpellAnnounce(386375, 4)

local specWarnConductiveMark					= mod:NewSpecialWarningYou(371624, nil, nil, nil, 1, 2)
local yellConductiveMark						= mod:NewShortYell(371624)
local specWarnLightningBolt						= mod:NewSpecialWarningInterrupt(372394, "HasInterrupt", nil, nil, 1, 2)
--local specWarnChainLightning					= mod:NewSpecialWarningMoveAway(374021, nil, nil, nil, 1, 2)
--local yellChainLightning						= mod:NewShortYell(374021)

local timerConductiveMarkCD						= mod:NewCDCountTimer(46.9, 371624, nil, nil, nil, 3)
local timerChainLightningCD						= mod:NewCDTimer(9.1, 374021, nil, "Healer", nil, 3)--9.1-15.4

mod:AddRangeFrameOption(5, 371624)
--Opalfang
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24967))
local warnCrush									= mod:NewStackAnnounce(372056, 2, nil, "Tank|Healer")
local warnQuakingConvocation					= mod:NewSpellAnnounce(386370, 4)

local specWarnEarthenPillar						= mod:NewSpecialWarningCount(370991, nil, nil, nil, 2, 2)--Warn everyone for now, change if it has emotes or debuff later
local specWarnCrush								= mod:NewSpecialWarningDefensive(372056, nil, nil, nil, 2, 2)
local specWarnCrushTaunt						= mod:NewSpecialWarningTaunt(372056, nil, nil, nil, 1, 2)

local timerEarthenPillarCD						= mod:NewCDCountTimer(40.8, 370991, nil, nil, nil, 3)--40.8--71
local timerCrushCD								= mod:NewCDCountTimer(21.6, 372056, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Embar Firepath
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24965))
local warnMeteorAxe								= mod:NewTargetNoFilterAnnounce(374043, 4)
local warnSlashingBlaze							= mod:NewStackAnnounce(372027, 2, nil, "Tank|Healer")
local warnBurningConvocation					= mod:NewSpellAnnounce(386289, 4)

local specWarnMeteorAxe							= mod:NewSpecialWarningYouPos(374043, nil, nil, nil, 1, 2)
local yellMeteorAxe								= mod:NewShortPosYell(374043)
local yellMeteorAxeFades						= mod:NewIconFadesYell(374043)
local specWarnSlashingBlaze						= mod:NewSpecialWarningDefensive(372027, nil, nil, nil, 2, 2)
local specWarnSlashingBlazeTaunt				= mod:NewSpecialWarningTaunt(372027, nil, nil, nil, 1, 2)

local timerMeteorAxeCD							= mod:NewCDCountTimer(49.7, 374043, nil, nil, nil, 3)
local timerSlashingBlazeCD						= mod:NewCDCountTimer(27.7, 372027, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddSetIconOption("SetIconOnMeteorAxe", 374043, true, false, {1, 2})

local blizzardStacks = {}
local playerBlizzardHigh = false
mod.vb.blizzardCast = 0
mod.vb.markCast = 0
mod.vb.pillarCast = 0
mod.vb.crushCast = 0
mod.vb.meteorCast = 0
mod.vb.blazeCast = 0
mod.vb.axeIcon = 1
local difficultyName = "heroic"--Unused right now, mythic and heroic same, will leave code in place until i know if normal/lfr also same or slower
local allTimers = {
	["heroic"] = {
		--Conductive Mark
		[375331] = {15.8, 52.2, 51.7, 49.2, 43.9, 49.6, 47.3, 27.6, 51.3, 53.4, 46.9, 50.8, 50.3, 29.2, 52.8, 51.1, 47.5, 50.3, 50.2, 29.6, 52.5, 53.3},
		--Meteor Axes
		[374038] = {26.0, 53.8, 49.7, 71.5, 68.6, 90.7, 50.5, 71.6, 69.1, 90.2, 51.5, 71.6, 69.1, 89.8, 51.1, 71.2},
		--Pillars
		[372322] = {5.9, 28.1, 47.2, 68.6, 42.0, 63.7, 64.1, 41.5, 69.7, 42.5, 64.3, 63.8, 41.3, 71.0, 40.8, 64.5, 64.8, 40.8, 69.9, 42.8},
		--Blizzard excluded because it's variation is not a consistent one
	},
}

function mod:OnCombatStart(delay)
	difficultyName = "heroic"--Temp setting to only difficult untl know for sure if other difficulties have faster or slower timers
	table.wipe(blizzardStacks)
	playerBlizzardHigh = false
	self.vb.blizzardCast = 0
	self.vb.markCast = 0
	self.vb.pillarCast = 0
	self.vb.crushCast = 0
	self.vb.meteorCast = 0
	self.vb.blazeCast = 0
	--Kadros Icewrath
	timerPrimalBlizzardCD:Start(39-delay, 1)
	--Dathea Stormlsh
	timerChainLightningCD:Start(12.1-delay)
	timerConductiveMarkCD:Start(15.8-delay, 1)
	--Opalfang
	timerEarthenPillarCD:Start(5.9-delay, 1)
	timerCrushCD:Start(18.3-delay, 1)
	--Embar Firepath
	timerSlashingBlazeCD:Start(12.3-delay, 1)
	timerMeteorAxeCD:Start(26-delay, 1)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(373059))
		DBM.InfoFrame:Show(self:IsMythic() and 20 or 10, "table", blizzardStacks, 1)--On mythic, see everyone to coordinate clears, else just show top idiots because cleares are infinite
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

function mod:OnTimerRecovery()
--	if self:IsMythic() then
--		difficultyName = "mythic"
--	elseif self:IsHeroic() then
		difficultyName = "heroic"
--	else
--		difficultyName = "normal"
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 373059 then
		self.vb.blizzardCast = self.vb.blizzardCast + 1
		specWarnPrimalBlizzard:Show()
		if self:IsHard() then
			specWarnPrimalBlizzard:Play("scatter")--Range 3
		else
			specWarnPrimalBlizzard:Play("aesoon")--Just aoe damage, spread mechanic disabled
		end
		timerPrimalBlizzardCD:Start(nil, self.vb.blizzardCast+1)
	elseif spellId == 372315 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnFrostSpike:Show(args.sourceName)
		specWarnFrostSpike:Play("kickcast")
	elseif spellId == 372394 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnLightningBolt:Show(args.sourceName)
		specWarnLightningBolt:Play("kickcast")
	elseif spellId == 372322 then
		self.vb.pillarCast = self.vb.pillarCast + 1
		specWarnEarthenPillar:Show()
		specWarnEarthenPillar:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.pillarCast+1) or 40.8
		timerEarthenPillarCD:Start(timer, self.vb.pillarCast+1)
	elseif spellId == 372056 then
		self.vb.crushCast = self.vb.crushCast + 1
		timerCrushCD:Start(nil, self.vb.crushCast+1)
		if self:IsTanking("player", nil, nil, nil, args.sourceGUID) then
			specWarnCrush:Show()
			specWarnCrush:Play("defensive")
		end
	elseif spellId == 372027 then
		self.vb.blazeCast = self.vb.blazeCast + 1
		timerSlashingBlazeCD:Start(nil, self.vb.blazeCast+1)
		if self:IsTanking("player", nil, nil, nil, args.sourceGUID) then
			specWarnSlashingBlaze:Show()
			specWarnSlashingBlaze:Play("defensive")
		end
	elseif spellId == 372279 then
		timerChainLightningCD:Start()
	elseif spellId == 374038 then
		self.vb.axeIcon = 1
		self.vb.meteorCast = self.vb.meteorCast + 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.meteorCast+1) or 49.7
		timerMeteorAxeCD:Start(timer, self.vb.meteorCast+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 391599 or spellId == 371836 then--Non Mythic, Mythic
		local amount = args.amount or 1
		blizzardStacks[args.destName] = amount
		if args:IsPlayer() and amount >= 8 then
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
			specWarnConductiveMark:Show()
			specWarnConductiveMark:Play("range5")
			yellConductiveMark:Yell()
		end
--	elseif spellId == 374021 then
--		warnChainLightning:CombinedShow(0.3, args.destName)
--		if args:IsPlayer() then
--			specWarnChainLightning:Show()
--			specWarnChainLightning:Play("range5")
--			yellChainLightning:Yell()
--		end
	elseif spellId == 386375 then
		warnStormingConvocation:Show()
		timerConductiveMarkCD:Stop()
		timerChainLightningCD:Stop()
	elseif spellId == 372056 and not args:IsPlayer() then
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
	elseif spellId == 386370 then
		warnQuakingConvocation:Show()
		timerEarthenPillarCD:Stop()
		timerCrushCD:Stop()
	elseif spellId == 374039 then
		local icon = self.vb.axeIcon
		if self.Options.SetIconOnMeteorAxe then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnMeteorAxe:Show(self:IconNumToTexture(icon))
			specWarnMeteorAxe:Play("mm"..icon)
			yellMeteorAxe:Yell(icon, icon)
			yellMeteorAxeFades:Countdown(spellId, nil, icon)
		end
		warnMeteorAxe:CombinedShow(0.3, args.destName)
		self.vb.axeIcon = self.vb.axeIcon + 1
	elseif spellId == 372027 and not args:IsPlayer() then
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
	elseif spellId == 386289 then
		warnBurningConvocation:Show()
		timerMeteorAxeCD:Stop()
		timerSlashingBlazeCD:Stop()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 391599 or spellId == 371836 then
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 375331 then
		self.vb.markCast = self.vb.markCast + 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.markCast+1)
		if timer then--No or rule, because it's got no reliable or timer
			timerConductiveMarkCD:Start(timer, self.vb.markCast+1)
		end
	end
end
