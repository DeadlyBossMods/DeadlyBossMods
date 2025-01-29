if DBM:GetTOC() < 110100 then return end
local mod	= DBM:NewMod(2641, "DBM-Raids-WarWithin", 1, 1296)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(228648)
mod:SetEncounterID(3011)
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
--mod:SetHotfixNoticeRev(20240921000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2769)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 473748 466866 467606 466979 473655 473260",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 1217122 468119 472298 1214598 467108 467044 466128 464518 466093 1213817",
	"SPELL_AURA_APPLIED_DOSE 1217122 464518",
	"SPELL_AURA_REMOVED 1217122 466128 1213817",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
--	"UNIT_DIED"
--	"CHAT_MSG_RAID_BOSS_WHISPER",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, precise stacks to special warn for for high voltage stacks. Possibly add an infoframe to monitor player rotations
--TODO, what to do with resonate echoes
--TODO, change TTS on entranced to use extra action?
--TODO, personal stack tracker forhttps://www.wowhead.com/ptr-2/spell=1214164/excitement ?
--TODO, finetune tank stacks
--TODO, perfect staging timers for weak aura compat
--[[
(ability.id = 473748 or ability.id = 466866 or ability.id = 467606 or ability.id = 466979 or ability.id = 473655 or ability.id = 473260) and type = "begincast"
 or ability.id = 1213817 and (type = "applybuff" or type = "removebuff")
--]]
--Stage One: Party Starter
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31656))
--local warnDecimate								= mod:NewIncomingCountAnnounce(442428, 3)
local warnLingeringVoltage							= mod:NewCountAnnounce(1217122, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(1217122))--Player
local warnLingeringVoltageFaded						= mod:NewFadesAnnounce(1217122, 1)--Player
local warnResonantEchoes							= mod:NewYouAnnounce(468119, 3)
local warnEntrancedByEchoes							= mod:NewTargetNoFilterAnnounce(1214598, 4)
local warnSoundCannon								= mod:NewIncomingCountAnnounce(467606, 2)
local warnFaultyZap									= mod:NewTargetNoFilterAnnounce(466979, 3)
local warnTinnitus									= mod:NewStackAnnounce(464518, 2, nil, "Tank|Healer")
local warnHaywire									= mod:NewSpellAnnounce(466093, 4)

local specWarnAmplification							= mod:NewSpecialWarningDodgeCount(473748, nil, nil, nil, 2, 2)
local specWarnEchoingChant							= mod:NewSpecialWarningDodgeCount(466866, nil, nil, nil, 2, 2)
--local specWarnEntrancedByEchoes					= mod:NewSpecialWarningYou(472298, nil, nil, nil, 1, 2)
local specWarnSoundCannonSoak						= mod:NewSpecialWarningSoakCount(467606, nil, nil, nil, 2, 2, 4)
local specWarnEntrancedByCannon						= mod:NewSpecialWarningSwitchCustom(1214598, "Dps", nil, nil, 1, 2, 4)--Could be spammy?
local specWarnFaultyZap								= mod:NewSpecialWarningMoveAway(466979, nil, nil, nil, 1, 2)
local yellFaultyZap									= mod:NewYell(466979)
local specWarnSparkBlastIngition					= mod:NewSpecialWarningSwitchCount(472293, nil, nil, nil, 1, 2)
local specWarnTinnitusTaunt							= mod:NewSpecialWarningTaunt(464518, nil, nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(459785, nil, nil, nil, 1, 8)

local timerAmplificationCD							= mod:NewCDCountTimer(40, 473748, nil, nil, nil, 3)
local timerEchoingChantCD							= mod:NewCDCountTimer(97.3, 466866, nil, nil, nil, 3)
local timerSoundCannonCD							= mod:NewCDCountTimer(97.3, 467606, nil, nil, nil, 3)
local timerFaultyZapCD								= mod:NewCDCountTimer(97.3, 466979, nil, nil, nil, 3)
local timerSparkBlastIngitionCD						= mod:NewCDCountTimer(97.3, 472293, nil, nil, nil, 1, nil, DBM_COMMON_L.HEROIC_ICON)

mod:AddSetIconOption("SetIconOnAmp", 473748, false, 5, {1, 2, 3, 4, 5, 6, 7, 8})
mod:AddPrivateAuraSoundOption(469380, true, 467606, 1)
mod:AddNamePlateOption("NPAuraOnResonance", 466128, true)
--Stage Two: Hype Hustle
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31655))
local specWarnHypeHustle							= mod:NewSpecialWarningCount(464584, nil, nil, nil, 2, 2)
local specWarnHypeFever								= mod:NewSpecialWarningCount(473655, nil, nil, nil, 3, 2)
local specWarnBlaringDrop							= mod:NewSpecialWarningDodgeCount(473260, nil, nil, nil, 2, 15)

local timerPhaseTransition							= mod:NewStageCountTimer(33, 66911)--Synced spell key with BW for WA compat
local timerBlaringDropCD							= mod:NewNextCountTimer(8, 473260, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)

mod.vb.ampCount = 0
mod.vb.ampIcon = 1
mod.vb.chantCount = 0
mod.vb.cannonCount = 0
mod.vb.zapCount = 0
mod.vb.sparkCount = 0
mod.vb.sparkIcon = 8
mod.vb.hypeCount = 0
mod.vb.dropCount = 0
local activeBossGUIDS = {}
local savedDifficulty = "normal"
local allTimers = {
	["mythic"] = {
		--Amplification
		[473748] = {10.7, 40, 40},
		--Echoing Chant
		[466866] = {22.0, 32.5, 53.5},
		--Sound Cannon
		[467606] = {30.0, 37.2},
		--Faulty Zap
		[466979] = {40.5, 34.5, 26.0},
		--Spark Blast Ignition
		[472293] = {15.0, 82.5},
	},
	["heroic"] = {
		--Amplification
		[473748] = {10.7, 40, 40},
		--Echoing Chant
		[466866] = {21.5, 58.0, 28.6},
		--Sound Cannon
		[467606] = {27.5, 34.5},
		--Faulty Zap
		[466979] = {39.5, 35.5, 26.0},
		--Spark Blast Ignition
		[472293] = {15.0, 43.5, 44.7},
	},
	["normal"] = {
		--Amplification
		[473748] = {10.6, 40.2},
		--Echoing Chant
		[466866] = {23.0, 48.0, 31.5},
		--Sound Cannon
		[467606] = {30.1, 49.5},
		--Faulty Zap
		[466979] = {40.5, 34.5},
	},
}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	table.wipe(activeBossGUIDS)
	self.vb.ampIcon = 1
	self.vb.ampCount = 0
	self.vb.chantCount = 0
	self.vb.cannonCount = 0
	self.vb.zapCount = 0
	self.vb.sparkCount = 0
	self.vb.sparkIcon = 8
	self.vb.hypeCount = 0
	self.vb.dropCount = 0
	if self:IsMythic() then
		savedDifficulty = "mythic"
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
	timerAmplificationCD:Start(allTimers[savedDifficulty][473748][1]-delay, 1)
	if self:IsHard() then
		timerSparkBlastIngitionCD:Start(allTimers[savedDifficulty][472293][1]-delay, 1)
	end
	timerEchoingChantCD:Start(allTimers[savedDifficulty][466866][1]-delay, 1)
	timerSoundCannonCD:Start(allTimers[savedDifficulty][467606][1]-delay, 1)
	timerFaultyZapCD:Start(allTimers[savedDifficulty][466979][1]-delay, 1)
	timerPhaseTransition:Start(115.9, 2)
	self:EnablePrivateAuraSound(469380, "lineyou", 17)
	if self.Options.NPAuraOnResonance then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnResonance then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		savedDifficulty = "mythic"
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 473748 then
		self.vb.ampCount = self.vb.ampCount + 1
		specWarnAmplification:Show(self.vb.ampCount)
		specWarnAmplification:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.ampCount+1)
		if timer then
			timerAmplificationCD:Start(timer, self.vb.ampCount+1)
		end
	elseif spellId == 466866 then
		self.vb.chantCount = self.vb.chantCount + 1
		specWarnEchoingChant:Show(self.vb.chantCount)
		specWarnEchoingChant:Play("watchwave")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.chantCount+1)
		if timer then
			timerEchoingChantCD:Start(timer, self.vb.chantCount+1)
		end
	elseif spellId == 467606 then
		self.vb.cannonCount = self.vb.cannonCount + 1
		if self:IsMythic() then
			specWarnSoundCannonSoak:Show(self.vb.cannonCount)
			specWarnSoundCannonSoak:Play("helpsoak")
		else
			warnSoundCannon:Show(self.vb.cannonCount)
		end
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.cannonCount+1)
		if timer then
			timerSoundCannonCD:Start(timer, self.vb.cannonCount+1)
		end
	elseif spellId == 466979 then
		self.vb.zapCount = self.vb.zapCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.zapCount+1)
		if timer then
			timerFaultyZapCD:Start(timer, self.vb.zapCount+1)
		end
	elseif spellId == 473260 then
		self.vb.dropCount = self.vb.dropCount + 1
		specWarnBlaringDrop:Show(self.vb.dropCount)
		specWarnBlaringDrop:Play("getknockedup")
		if self.vb.blaringDropCount < 4 then
			timerBlaringDropCD:Start(nil, self.vb.dropCount+1)
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 439559 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1217122 then
		--TODO, infoframe stack tracking
		if args:IsPlayer() then
			local amount = args.amount or 1
			if amount % 5 == 0 then--Fine tune
				warnLingeringVoltage:Show(amount)
			end
		end
	elseif spellId == 468119 then
		if args:IsPlayer() then
			warnResonantEchoes:Show()
		end
	elseif spellId == 472298 or spellId == 1214598 then
		warnEntrancedByEchoes:CombinedShow(1, args.destName)
		if not args:IsPlayer() and self:AntiSpam(4, 1) then
			specWarnEntrancedByCannon:Show(args.destName)
			specWarnEntrancedByCannon:Play("findmc")
		end
	elseif (spellId == 467108 or spellId == 467044) and self:AntiSpam(5, 2, args.destName) then--Pre target debuff / target debuff
		warnFaultyZap:PreciseShow(4, args.destName)
		if args:IsPlayer() then
			specWarnFaultyZap:Show()
			specWarnFaultyZap:Play("scatter")
			yellFaultyZap:Yell()
		end
	elseif spellId == 466128 then
		if self.Options.NPAuraOnResonance then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 464518 then
		local amount = args.amount or 1
		if amount % 5 == 0 then--Fine tune
			if not args:IsPlayer() then
				if amount >= 10 and not DBM:UnitDebuff("player", spellId) then
					specWarnTinnitusTaunt:Show(args.destName)
					specWarnTinnitusTaunt:Play("tauntboss")
				else
					warnTinnitus:Show(args.destName, amount)
				end
			else
				warnTinnitus:Show(args.destName, amount)
			end
		end
	elseif spellId == 466093 and self:AntiSpam(3, 3) then
		warnHaywire:Show()
	elseif spellId == 1213817 then--Hype Hystle / Hype Fever (final hustle)
		self:SetStage(2)
		self.vb.hypeCount = self.vb.hypeCount + 1
		self.vb.blaringDropCount = 0
		timerAmplificationCD:Stop()
		timerEchoingChantCD:Stop()
		timerSoundCannonCD:Stop()
		timerFaultyZapCD:Stop()
		timerSparkBlastIngitionCD:Stop()
		timerBlaringDropCD:Start(5.2, 1)
		if self.vb.hypeCount < 3 then
			specWarnHypeHustle:Show(self.vb.hypeCount)
			specWarnHypeHustle:Play("phasechange")
			timerPhaseTransition:Start(36, 1)
		else
			specWarnHypeFever:Show(self.vb.hypeCount)
			specWarnHypeFever:Play("stilldanger")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1217122 then
		--TODO, infoframe stack tracking
		if args:IsPlayer() then
			warnLingeringVoltageFaded:Show()
		end
	elseif spellId == 466128 then
		if self.Options.NPAuraOnResonance then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 1213817 then--Sound Cloud
		self:SetStage(1)
		self.vb.ampCount = 0
		self.vb.chantCount = 0
		self.vb.cannonCount = 0
		self.vb.zapCount = 0
		self.vb.sparkCount = 0
		timerBlaringDropCD:Stop()
		timerAmplificationCD:Start(allTimers[savedDifficulty][473748][1], self.vb.ampCount+1)
		if self:IsHard() then
			timerSparkBlastIngitionCD:Start(allTimers[savedDifficulty][472293][1], self.vb.sparkCount+1)
		end
		timerEchoingChantCD:Start(allTimers[savedDifficulty][466866][1], self.vb.chantCount+1)
		timerSoundCannonCD:Start(allTimers[savedDifficulty][467606][1], self.vb.cannonCount+1)
		timerFaultyZapCD:Start(allTimers[savedDifficulty][466979][1], self.vb.zapCount+1)
		timerPhaseTransition:Start(115.9, 2)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 459785 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 230197 then--Amplifier

	end
end
--]]

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 10 do
		local unitID = "boss"..i
		local unitGUID = UnitGUID(unitID)
		if unitGUID and UnitExists(unitID) and not activeBossGUIDS[unitGUID] then
			activeBossGUIDS[unitGUID] = true
			local cid = self:GetUnitCreatureId(unitID)
			if cid == 230197 or cid == 233072 or cid == 236511 then--Applifier
				if self.Options.SetIconOnAmp then
					self:ScanForMobs(unitGUID, 2, self.vb.ampIcon, 1, nil, 12, "SetIconOnAmp")
				end
				self.vb.ampIcon = self.vb.ampIcon + 1
				if self.vb.ampIcon == 9 then
					self.vb.ampIcon = 1
				end
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, spellId)
	if spellId == 472306 then
		self.vb.sparkIcon = 8
		self.vb.sparkCount = self.vb.sparkCount + 1
		specWarnSparkBlastIngition:Show(self.vb.sparkCount)
		specWarnSparkBlastIngition:Play("killmob")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, 472293, self.vb.sparkCount+1)
		if timer then
			timerSparkBlastIngitionCD:Start(timer, self.vb.sparkCount+1)
		end
	end
end
