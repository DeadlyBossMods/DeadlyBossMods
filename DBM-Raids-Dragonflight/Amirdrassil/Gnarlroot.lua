local mod	= DBM:NewMod(2564, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(209333)
mod:SetEncounterID(2820)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20231116000000)
mod:SetMinSyncRevision(20231116000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 421898 421971 424352 422026 422039 421013 425816 425819",
--	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON 425366",
	"SPELL_AURA_APPLIED 422466 421972 426106 421038 421840 425820",
	"SPELL_AURA_APPLIED_DOSE 422466 426106 421038",
	"SPELL_AURA_REMOVED 421972 421840",
--	"SPELL_AURA_REMOVED_DOSE",
	"SPELL_PERIODIC_DAMAGE 422023 424970",
	"SPELL_PERIODIC_MISSED 422023 424970",
	"UNIT_DIED"
)

--[[
(ability.id = 421898 or ability.id = 421971 or ability.id = 424352 or ability.id = 422026 or ability.id = 422039 or ability.id = 421013) and type = "begincast"
 or ability.id = 421840
--]]
--TODO, maybe nameplate aura timers for https://www.wowhead.com/ptr-2/spell=422053/shadow-spines if it's not spam cast?
--Stage One: Garden of Despair
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27467))
local warnFlamingPestilence							= mod:NewCountAnnounce(421898, 3)
local warnShadowSpines								= mod:NewCountAnnounce(422053, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(422053))
local warnControlledBurn							= mod:NewTargetCountAnnounce(421972, 3, nil, nil, 167180, nil, nil, nil, true)
local warnDreadfireBarrage							= mod:NewStackAnnounce(424352, 2, nil, "Tank|Healer")
local warnFlamingSap								= mod:NewTargetAnnounce(425820, 2)

local specWarnControlledBurn						= mod:NewSpecialWarningYou(421972, nil, 37859, nil, 1, 2)
local yellControlledBurn							= mod:NewShortPosYell(421972, 37859)--Shortname "Bomb"
local yellControlledBurnFades						= mod:NewIconFadesYell(421972)
local specWarnDreadfireBarrage						= mod:NewSpecialWarningTaunt(424352, nil, 120360, nil, 1, 2)
local specWarnTorturedScream						= mod:NewSpecialWarningCount(422026, nil, 31295, nil, 2, 2)
local specWarnShadowflameCleave						= mod:NewSpecialWarningDodgeCount(422039, nil, nil, nil, 2, 2)
local specWarnBlazingPollen							= mod:NewSpecialWarningInterruptCount(425816, "HasInterrupt", nil, nil, 1, 2, 4)
local specWarnFlamingSap							= mod:NewSpecialWarningMoveAway(425820, nil, nil, nil, 1, 2, 4)
local yellFlamingSap								= mod:NewShortYell(425820)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(422023, nil, nil, nil, 1, 8)

local timerFlamingPestilenceCD						= mod:NewCDCountTimer(34.7, 421898, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1)
local timerControlledBurnCD							= mod:NewCDCountTimer(49, 421972, 167180, nil, nil, 3)--Shortname "Bombs"
local timerDreadfireBarrageCD						= mod:NewCDCountTimer(21.5, 424352, 120360, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Shortname Barrage
local timerTorturedScreamCD							= mod:NewCDCountTimer(11.8, 422026, 31295, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)--Scream shorttext
local timerShadowflameCleaveCD						= mod:NewCDCountTimer(49, 422039, DBM_COMMON_L.FRONTAL.." (%s)", nil, nil, 3)
local timerBlazingPollenCD							= mod:NewCDNPTimer(11.8, 425816, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--Nameplate only timer
local timerFlamingSapCD								= mod:NewCDNPTimer(11.8, 425820, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)
--local berserkTimer								= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnControlledBurn", 421972, true, 0, {1, 2, 3, 4})
mod:AddSetIconOption("SetIconOnBlazingTaintedTreant", -28350, true, 5, {8, 7, 6, 5})
--Intermission: Frenzied Growth
mod:AddTimerLine(DBM:EJ_GetSectionInfo(27475))
local warnDoomCultivation							= mod:NewCountAnnounce(421013, 3)
local warnEmberCharred								= mod:NewCountAnnounce(421038, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(421038))
local warnUprootedAgony								= mod:NewSpellAnnounce(421840, 1)
local warnUprootedAgonyOver							= mod:NewEndAnnounce(421840, 2)

--local specWarnEmberCharred						= mod:NewSpecialWarningYou(421038, nil, nil, nil, 1, 2)

local timerUprootAgonyCD							= mod:NewBuffActiveTimer(20, 421840, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerDoomCultivationCD						= mod:NewStageCountCycleTimer(49, 421013, nil, nil, nil, 6)

--p1
mod.vb.pestilanceCount = 0
mod.vb.burnCount = 0
mod.vb.burnIcon = 1
mod.vb.barrageCount = 0
mod.vb.screamCount = 0
mod.vb.cleaveCount = 0
--p2
mod.vb.doomCount = 0
local castsPerGUID = {}
local addUsedMarks = {}
local difficultyName = "easy"
--Timers Table Notes
--If initial and loop timers were close enough, they were combined and minned since 1-2sec variation is acceptable
--If the initial and repeat timers were radically different (consistently) like with Shadowflame heroic, two entries are used to separate them
local allTimers = {
	["easy"] = {
		--Controlled Burn
		[421971] = {33.2, 37.8},
		--Dreadfire Barrage
		[424352] = {9.9, 27.7, 27.7},
		--Flaming Pestilence
		[421898] = {16.5, 42.2},
		--Shadowflame Cleave
		[422039] = {22.1, 26.6, 26.6},
		--Tortured Scream
		[422026] = {3.2, 25.5, 25.5, 26.6},
	},
	["heroic"] = {
		--Controlled Burn
		[421971] = {30, 32.0},
		--Dreadfire Barrage
		[424352] = {8.9, 25, 25, 25},
		--Flaming Pestilence
		[421898] = {17.2, 38},
		--Shadowflame Cleave
		[422039] = {20, 23.9, 24},
		--Tortured Scream
		[422026] = {3, 22.9, 23, 24},
	},
	["mythic"] = {
		--Controlled Burn
		[421971] = {34, 33.9},
		--Dreadfire Barrage
		[424352] = {8.9, 20.0, 20.0, 13.9, 18.0},
		--Flaming Pestilence
		[421898] = {14.9, 42.0},
		--Shadowflame Cleave
		[422039] = {20, 23.9, 27.0},
		--Tortured Scream
		[422026] = {2.9, 23.0, 28.0, 21.9},
	},
}

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	table.wipe(addUsedMarks)
	self:SetStage(1)
	self.vb.pestilanceCount = 0
	self.vb.burnCount = 0
	self.vb.burnIcon = 1
	self.vb.barrageCount = 0
	self.vb.screamCount = 0
	self.vb.cleaveCount = 0
	self.vb.doomCount = 0
	--Mythic and heroic initials very close
	if self:IsMythic() then
		difficultyName = "mythic"
		timerTorturedScreamCD:Start(2.9-delay, 1)
		timerDreadfireBarrageCD:Start(8.9-delay, 1)
		timerFlamingPestilenceCD:Start(14.9-delay, 1)
		timerShadowflameCleaveCD:Start(20-delay, 1)
		timerControlledBurnCD:Start(34-delay, 1)
	elseif self:IsHeroic() then
		difficultyName = "heroic"
		timerTorturedScreamCD:Start(3-delay, 1)
		timerDreadfireBarrageCD:Start(8.9-delay, 1)
		timerFlamingPestilenceCD:Start(15-delay, 1)
		timerShadowflameCleaveCD:Start(20-delay, 1)
		timerControlledBurnCD:Start(30-delay, 1)
	else--Normal and LFR seem synced now
		difficultyName = "easy"
		timerTorturedScreamCD:Start(3.2-delay, 1)
		timerDreadfireBarrageCD:Start(9.9-delay, 1)
		timerFlamingPestilenceCD:Start(16.5-delay, 1)
		timerShadowflameCleaveCD:Start(22.1-delay, 1)
		timerControlledBurnCD:Start(33.2-delay, 1)
	end
	timerDoomCultivationCD:Start(92.2-delay, 2, 1)--Technically this variates too based on difficult, but meh, 2-3 sec at most
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		difficultyName = "mythic"
	elseif self:IsHeroic() then
		difficultyName = "heroic"
	else
		difficultyName = "easy"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 421898 then
		self.vb.pestilanceCount = self.vb.pestilanceCount + 1
		warnFlamingPestilence:Show(self.vb.pestilanceCount)
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.pestilanceCount+1)
		if timer then
			timerFlamingPestilenceCD:Start(timer, self.vb.pestilanceCount+1)
		end
	elseif spellId == 421971 then
		self.vb.burnCount = self.vb.burnCount + 1
		self.vb.burnIcon = 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.burnCount+1)
		if timer then
			timerControlledBurnCD:Start(timer, self.vb.burnCount+1)
		end
	elseif spellId == 424352 then
		self.vb.barrageCount = self.vb.barrageCount + 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.barrageCount+1)
		if timer then
			timerDreadfireBarrageCD:Start(timer, self.vb.barrageCount+1)
		end
	elseif spellId == 422026 then
		self.vb.screamCount = self.vb.screamCount + 1
		specWarnTorturedScream:Show(self.vb.screamCount)
		specWarnTorturedScream:Play("aesoon")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.screamCount+1)
		if timer then
			timerTorturedScreamCD:Start(timer, self.vb.screamCount+1)
		end
	elseif spellId == 422039 then
		self.vb.cleaveCount = self.vb.cleaveCount + 1
		specWarnShadowflameCleave:Show(self.vb.cleaveCount)
		specWarnShadowflameCleave:Play("shockwave")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.cleaveCount+1)
		if timer then
			timerShadowflameCleaveCD:Start(timer, self.vb.cleaveCount+1)
		end
	elseif spellId == 421013 then
		self:SetStage(2)
		self.vb.doomCount = self.vb.doomCount + 1
		timerFlamingPestilenceCD:Stop()
		timerControlledBurnCD:Stop()
		timerDreadfireBarrageCD:Stop()
		timerTorturedScreamCD:Stop()
		timerShadowflameCleaveCD:Stop()
	elseif spellId == 425816 then
--		timerBlazingPollenCD:Start(nil, args.sourceGUID)
--		timerFlamingSapCD:Start(nil, args.sourceGUID)
		if not castsPerGUID[args.sourceGUID] then--Shouldn't happen, but just in case
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnBlazingTaintedTreant then
				for i = 8, 5, -1 do
					if not addUsedMarks[i] then
						addUsedMarks[i] = args.sourceGUID
						self:ScanForMobs(args.sourceGUID, 2, i, 1, nil, 12, "SetIconOnBlazingTaintedTreant")
						break
					end
				end
			end
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnBlazingPollen:Show(args.sourceName, count)
			if count < 6 then
				specWarnBlazingPollen:Play("kick"..count.."r")
			else
				specWarnBlazingPollen:Play("kickcast")
			end
		end
	elseif spellId == 425819 then
		--timerFlamingSapCD:Start(nil, args.sourceGUID)
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 334945 then

	end
end
--]]

--https://www.wowhead.com/ptr-2/spell=418491/everweaving-threads
function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 425366 then--Tainted Treant
		if not castsPerGUID[args.destGUID] then
			--timerBlazingPollenCD:Start(nil, args.destGUID)
			castsPerGUID[args.destGUID] = 0
			if self.Options.SetIconOnBlazingTaintedTreant then
				for i = 8, 5, -1 do
					if not addUsedMarks[i] then
						addUsedMarks[i] = args.destGUID
						self:ScanForMobs(args.destGUID, 2, i, 1, nil, 12, "SetIconOnBlazingTaintedTreant")
						break
					end
				end
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 422466 then
		if args:IsPlayer() and self:AntiSpam(3, 1) then
			warnShadowSpines:Show(args.amount or 1)
		end
	elseif spellId == 421972 then
		local icon = self.vb.burnIcon
		if self.Options.SetIconOnControlledBurn then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnControlledBurn:Show()
			specWarnControlledBurn:Play("bombyou")
			yellControlledBurn:Yell(icon, icon)
			yellControlledBurnFades:Countdown(spellId, nil, icon)
		end
		warnControlledBurn:CombinedShow(0.5, self.vb.burnCount, args.destName)
		self.vb.burnIcon = self.vb.burnIcon + 1
	elseif spellId == 426106 then
		local amount = args.amount or 1
		--Applies 5 stacks at a time (then just refreshes after that)
		--so this should effectively warn once per barrage
		if amount % 5 == 0 then
			if args:IsPlayer() then--This basically can swap every 1-2 stacks based on it's cooldown.
				warnDreadfireBarrage:Show(args.destName, amount)
			else
				local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if (not remaining or remaining and remaining < 22) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
					specWarnDreadfireBarrage:Show(args.destName)
					specWarnDreadfireBarrage:Play("tauntboss")
				else
					warnDreadfireBarrage:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 421038 then
		if args:IsPlayer() then
			warnEmberCharred:Show(args.amount or 1)
		end
	elseif spellId == 421840 then
		warnUprootedAgony:Show()
		timerUprootAgonyCD:Start()
	elseif spellId == 425820 then
		warnFlamingSap:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFlamingSap:Show()
			specWarnFlamingSap:Play("range5")
			yellFlamingSap:Yell()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 421972 then
		if self.Options.SetIconOnControlledBurn then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 421840 then
		self:SetStage(1)
		warnUprootedAgonyOver:Show()
		self.vb.pestilanceCount = 0
		self.vb.burnCount = 0
		self.vb.barrageCount = 0
		self.vb.screamCount = 0
		self.vb.cleaveCount = 0
		timerUprootAgonyCD:Stop()
		if self:IsMythic() then
			timerTorturedScreamCD:Start(4.3, 1)
			timerDreadfireBarrageCD:Start(10.4, 1)
			timerFlamingPestilenceCD:Start(16.4, 1)
			timerShadowflameCleaveCD:Start(21.4, 1)
			timerControlledBurnCD:Start(35.4, 1)
			timerDoomCultivationCD:Start(94.1, 2, self.vb.doomCount+1)--Recheck multiple times
		elseif self:IsHeroic() then
			timerTorturedScreamCD:Start(4.5, 1)
			timerDreadfireBarrageCD:Start(10.5, 1)
			timerFlamingPestilenceCD:Start(16.5, 1)
			timerShadowflameCleaveCD:Start(21.5, 1)
			timerControlledBurnCD:Start(31.5, 1)
			timerDoomCultivationCD:Start(93.4, 2, self.vb.doomCount+1)
		else--LFR and normal
			timerTorturedScreamCD:Start(4.4, 1)
			timerDreadfireBarrageCD:Start(11, 1)
			timerFlamingPestilenceCD:Start(17.7, 1)
			timerShadowflameCleaveCD:Start(23.2, 1)
			timerControlledBurnCD:Start(34.3, 1)
			timerDoomCultivationCD:Start(94.4, 2, self.vb.doomCount+1)
		end
	end
end
--mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 422023 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 424970 and not DBM:UnitDebuff("player", 421038) and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--https://www.wowhead.com/ptr-2/npc=210231/tainted-lasher
--https://www.wowhead.com/ptr-2/npc=211904/tainted-treant
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 211904 then--Tainted Treant
		timerBlazingPollenCD:Stop(args.destGUID)
		timerFlamingSapCD:Stop(args.destGUID)
		for i = 8, 5, -1 do
			if addUsedMarks[i] == args.destGUID then
				addUsedMarks[i] = nil
				return
			end
		end
	end
end
