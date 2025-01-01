if DBM:GetTOC() < 110100 then return end
local mod	= DBM:NewMod(2641, "DBM-Raids-WarWithin", 1, 1296)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(214503)
mod:SetEncounterID(3011)
--mod:SetHotfixNoticeRev(20240921000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2769)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 473748 466866 467606 466979 472293 464584 473655 473260",
--	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON 464119 473555",
	"SPELL_AURA_APPLIED 1217122 468119 472298 1214598 467108 467044 472294 466128 464518",
	"SPELL_AURA_APPLIED_DOSE 1217122 464518",
	"SPELL_AURA_REMOVED 1217122 466128 464584"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
--	"UNIT_DIED"
--	"CHAT_MSG_RAID_BOSS_WHISPER",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--NOTE: https://www.wowhead.com/ptr-2/spell=467094/lingering-voltage doesn't seem to exist anymore in journal
--TODO, precise stacks to special warn for for high voltage stacks. Possibly add an infoframe to monitor player rotations
--TODO, what to do with resonate echoes
--TODO, alert when amplifier goes haywire?
--TODO, change TTS on entranced to use extra action?
--TODO, personal stack tracker forhttps://www.wowhead.com/ptr-2/spell=1214164/excitement ?
--TODO, finetune tank stacks
--TODO, perfect staging timers for weak aura compat
--Stage One: Party Starter
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31656))
--local warnDecimate								= mod:NewIncomingCountAnnounce(442428, 3)
local warnLingeringVoltage							= mod:NewCountAnnounce(1217122, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(1217122))--Player
local warnLingeringVoltageFaded						= mod:NewFadesAnnounce(1217122, 1)--Player
local warnResonantEchoes							= mod:NewYouAnnounce(468119, 3)
local warnEntrancedByEchoes							= mod:NewTargetNoFilterAnnounce(472298, 4)
local warnSoundCannon								= mod:NewIncomingCountAnnounce(467606, 2)
local warnFaultyZap									= mod:NewTargetNoFilterAnnounce(466979, 3)
local warnTinnitus									= mod:NewStackAnnounce(464518, 2, nil, "Tank|Healer")

local specWarnAmplification							= mod:NewSpecialWarningDodgeCount(473748, nil, nil, nil, 2, 2)
local specWarnEchoingChant							= mod:NewSpecialWarningDodgeCount(466866, nil, nil, nil, 2, 2)
local specWarnEntrancedByEchoes						= mod:NewSpecialWarningYou(472298, nil, nil, nil, 1, 2)
local specWarnSoundCannonSoak						= mod:NewSpecialWarningSoakCount(467606, nil, nil, nil, 2, 2, 4)
local specWarnEntrancedByCannon						= mod:NewSpecialWarningSwitchCustom(1214598, "Dps", nil, nil, 1, 2, 4)
local specWarnFaultyZap								= mod:NewSpecialWarningMoveAway(466979, nil, nil, nil, 1, 2)
local yellFaultyZap									= mod:NewYell(466979)
local specWarnSparkBlastIngition					= mod:NewSpecialWarningSwitchCount(472293, nil, nil, nil, 1, 2)
local specWarnTinnitusTaunt							= mod:NewSpecialWarningTaunt(464518, nil, nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(459785, nil, nil, nil, 1, 8)

local timerAmplificationCD							= mod:NewAITimer(97.3, 473748, nil, nil, nil, 3)
local timerEchoingChantCD							= mod:NewAITimer(97.3, 466866, nil, nil, nil, 3)
local timerSoundCannonCD							= mod:NewAITimer(97.3, 467606, nil, nil, nil, 3)
local timerFaultyZapCD								= mod:NewAITimer(97.3, 466979, nil, nil, nil, 3)
local timerSparkBlastIngitionCD						= mod:NewAITimer(97.3, 472293, nil, nil, nil, 1, nil, DBM_COMMON_L.HEROIC_ICON)

mod:AddSetIconOption("SetIconOnAmp", 473748, true, 5, {1, 2, 3})
mod:AddSetIconOption("SetIconOnSparkblast", 472293, true, 5, {7, 8})
mod:AddPrivateAuraSoundOption(469380, true, 467606, 1)
mod:AddNamePlateOption("NPAuraOnResonance", 466128, true)
--Stage Two: Hype Hustle
mod:AddTimerLine(DBM:EJ_GetSectionInfo(31655))
local specWarnHypeHustle							= mod:NewSpecialWarningCount(464584, nil, nil, nil, 2, 2)
local specWarnHypeFever								= mod:NewSpecialWarningCount(473655, nil, nil, nil, 3, 2)
local specWarnBlaringDrop							= mod:NewSpecialWarningDodgeCount(473260, nil, nil, nil, 2, 15)

local timerPhaseTransition							= mod:NewStageTimer(33)
local timerHypeHustleCD								= mod:NewAITimer(97.3, 464584, nil, nil, nil, 6)
local timerHypeFeverCD								= mod:NewAITimer(97.3, 473655, nil, nil, nil, 6)
local timerBlaringDropCD							= mod:NewAITimer(97.3, 473260, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)

mod.vb.ampCount = 0
mod.vb.ampIcon = 1
mod.vb.chantCount = 0
mod.vb.cannonCount = 0
mod.vb.zapCount = 0
mod.vb.sparkCount = 0
mod.vb.sparkIcon = 8
mod.vb.hypeCount = 0
mod.vb.dropCount = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.ampCount = 0
	self.vb.ampIcon = 1
	self.vb.chantCount = 0
	self.vb.cannonCount = 0
	self.vb.zapCount = 0
	self.vb.sparkCount = 0
	self.vb.sparkIcon = 8
	self.vb.hypeCount = 0
	self.vb.dropCount = 0
	timerAmplificationCD:Start(1)
	timerEchoingChantCD:Start(1)
	timerSoundCannonCD:Start(1)
	timerFaultyZapCD:Start(1)
	timerHypeHustleCD:Start(1)
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

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 473748 then
		self.vb.ampCount = self.vb.ampCount + 1
		specWarnAmplification:Show(self.vb.ampCount)
		specWarnAmplification:Play("watchstep")
		timerAmplificationCD:Start()--nil, self.vb.ampCount+1
	elseif spellId == 466866 then
		self.vb.chantCount = self.vb.chantCount + 1
		specWarnEchoingChant:Show(self.vb.chantCount)
		specWarnEchoingChant:Play("watchwave")
		timerEchoingChantCD:Start()--nil, self.vb.chantCount+1
	elseif spellId == 467606 then
		self.vb.cannonCount = self.vb.cannonCount + 1
		if self:IsMythic() then
			specWarnSoundCannonSoak:Show(self.vb.cannonCount)
			specWarnSoundCannonSoak:Play("helpsoak")
		else
			warnSoundCannon:Show(self.vb.cannonCount)
		end
		timerSoundCannonCD:Start()--nil, self.vb.cannonCount+1
	elseif spellId == 466979 then
		self.vb.zapCount = self.vb.zapCount + 1
		timerFaultyZapCD:Start()--nil, self.vb.zapCount+1
	elseif spellId == 472293 then
		self.vb.sparkIcon = 8
		self.vb.sparkCount = self.vb.sparkCount + 1
		specWarnSparkBlastIngition:Show(self.vb.sparkCount)
		specWarnSparkBlastIngition:Play("killmob")
		timerSparkBlastIngitionCD:Start()--nil, self.vb.sparkCount+1
	elseif spellId == 464584 or spellId == 473655 then--Hype Hystle / Hype Fever (final hustle)
		self:SetStage(2)
		self.vb.hypeCount = self.vb.hypeCount + 1
		timerAmplificationCD:Stop()
		timerEchoingChantCD:Stop()
		timerSoundCannonCD:Stop()
		timerFaultyZapCD:Stop()
		timerSparkBlastIngitionCD:Stop()
		timerHypeHustleCD:Stop()
		if spellId == 464584 then
			specWarnHypeHustle:Show(self.vb.hypeCount)
			specWarnHypeHustle:Play("phasechange")
			timerPhaseTransition:Start()
		else
			specWarnHypeFever:Show(self.vb.hypeCount)
			specWarnHypeFever:Play("stilldanger")
		end
	elseif spellId == 473260 then
		self.vb.dropCount = self.vb.dropCount + 1
		specWarnBlaringDrop:Show(self.vb.dropCount)
		specWarnBlaringDrop:Play("getknockedup")
		timerBlaringDropCD:Start()--nil, self.vb.dropCount+1
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 439559 then

	end
end
--]]

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 464119 or spellId == 473555 then
		if self.Options.SetIconOnAmp then
			self:ScanForMobs(args.destGUID, 2, self.vb.ampIcon, 1, nil, 12, "SetIconOnAmp")
		end
		self.vb.ampIcon = self.vb.ampIcon + 1
	end
end

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
	elseif spellId == 472298 then
		warnEntrancedByEchoes:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnEntrancedByEchoes:Show()
			specWarnEntrancedByEchoes:Play("findmc")
		end
	elseif spellId == 1214598 then
		if not args:IsPlayer() then
			specWarnEntrancedByCannon:Show(args.destName)
			specWarnEntrancedByCannon:Play("findmc")
		end
	elseif (spellId == 467108 or spellId == 467044) and self:AntiSpam(5, 1, args.destName) then--Pre target debuff / target debuff
		warnFaultyZap:PreciseShow(4, args.destName)
		if args:IsPlayer() then
			specWarnFaultyZap:Show()
			specWarnFaultyZap:Play("scatter")
			yellFaultyZap:Yell()
		end
	elseif spellId == 472294 then
		if self.Options.SetIconOnSparkblast then
			self:ScanForMobs(args.destGUID, 2, self.vb.sparkIcon, 1, nil, 12, "SetIconOnSparkblast")
		end
		self.vb.sparkIcon = self.vb.sparkIcon - 1
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
	elseif spellId == 464584 then--Hype Hystle
		self:SetStage(1)
		timerAmplificationCD:Start(2)
		timerEchoingChantCD:Start(2)
		timerSoundCannonCD:Start(2)
		timerFaultyZapCD:Start(2)
		timerSparkBlastIngitionCD:Start(2)
		if self.vb.hypeCount == 1 then
			timerHypeHustleCD:Start(2)
		else--3rd is next
			timerHypeFeverCD:Start(2)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 459785 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
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

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 433475 then

	end
end
--]]
