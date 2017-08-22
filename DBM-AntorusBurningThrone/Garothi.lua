local mod	= DBM:NewMod(1992, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 16369 $"):sub(12, -3))
mod:SetCreatureID(122450)
mod:SetEncounterID(2076)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
--mod:SetHotfixNoticeRev(16350)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244969 246408 247044",
	"SPELL_CAST_SUCCESS 246220",
	"SPELL_AURA_APPLIED 246220 247159 244152 244410 245770 246687 246920",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 246220 244152 244410 245770 246687 246920",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"--Assuming cannons are unique boss unitID
)

local annihilator = EJ_GetSectionInfo(15917)
local Decimator = EJ_GetSectionInfo(15915)
--TODO, work in range frame to include searing barrage, for ranged
--TODO, improve luring destruction if draw in needs specific action
--TODO, see how apoc drives affect other timers and impliment
--TODO, annilation have targetting? does mythic version have a cast ID? could only find one cast start ID
--[[
(ability.id = 244969 or ability.id = 246408 or ability.id = 247044) and type = "begincast"
 or abiity.id = 246220 and type = "cast"
 or (ability.id = 244152) and type = "applybuff"
 or (ability.id = 246220) and type = "applydebuff"
--]]
local warnFelBombardment				= mod:NewTargetAnnounce(246220, 2)
local warnDecimation					= mod:NewTargetAnnounce(244410, 4)

local specWarnFelBombardment			= mod:NewSpecialWarningMoveAway(246220, nil, nil, nil, 1, 2)
local yellFelBombardment				= mod:NewFadesYell(246220)
local specWarnFelBombardmentTaunt		= mod:NewSpecialWarningTaunt(246220, nil, nil, nil, 1, 2)
local specWarnApocDrive					= mod:NewSpecialWarningSwitch(244152, nil, nil, nil, 1, 2)
local specWarnEradication				= mod:NewSpecialWarningRun(244969, nil, nil, nil, 4, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Decimator
local specWarnDecimation				= mod:NewSpecialWarningMoveAway(244410, nil, nil, nil, 1, 2)
local yellDecimation					= mod:NewFadesYell(244410)
local specWarnDecimationStun			= mod:NewSpecialWarningYou(246920, nil, nil, nil, 1, 2)--Mythic
local yellDecimationStun				= mod:NewFadesYell(246920)--Mythic
--Annihilator
local specWarnAnnihilation				= mod:NewSpecialWarningSpell(247044, nil, nil, nil, 1, 2)
--Mythic
local specWarnLuringDestruction			= mod:NewSpecialWarningSpell(247159, nil, nil, nil, 2, 2)

local timerFelBombardmentCD				= mod:NewCDTimer(20, 246220, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerApocDriveCast				= mod:NewCastTimer(20, 247159, nil, nil, nil, 6)
--local timerEradicationCD				= mod:NewAITimer(20, 244969, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
mod:AddTimerLine(Decimator)
local timerDecimationCD					= mod:NewAITimer(20, 244410, nil, nil, nil, 3)
mod:AddTimerLine(annihilator)
local timerAnnihilationCD				= mod:NewAITimer(20, 247044, nil, nil, nil, 3)

mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerLuringDestructionCD			= mod:NewAITimer(61, 247159, nil, nil, nil, 2)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownSingularity			= mod:NewCountdown(50, 235059)

local voiceFelBombardment				= mod:NewVoice(246220)--runout/keepmove
local voiceApocDrive					= mod:NewVoice(244152)--targetchange
local voiceEradication					= mod:NewVoice(244969)--justrun
--local voiceGTFO						= mod:NewVoice(238028, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway
--Decimator
local voiceDecimation					= mod:NewVoice(244410)--runout
local voiceDecimationStun				= mod:NewVoice(246920)--targetyou
--Annihilator
local voiceAnnihilation					= mod:NewVoice(247044)--helpsoak

--Mythic
local voiceLuringDestruction			= mod:NewVoice(247159)--aesoon

mod:AddSetIconOption("SetIconOnDecimation", 244410, true)
--mod:AddInfoFrameOption(239154, true)
mod:AddRangeFrameOption("7/17")

mod.vb.deciminationActive = 0
mod.vb.FelBombardmentActive = 0

local debuffFilter
local updateRangeFrame
do
	local decimination, mythicDecimination, FelBombardment = GetSpellInfo(244410), GetSpellInfo(246920), GetSpellInfo(246220)
	local UnitDebuff = UnitDebuff
	debuffFilter = function(uId)
		if UnitDebuff(uId, decimination) or UnitDebuff(uId, mythicDecimination) or UnitDebuff(uId, FelBombardment) then
			return true
		end
	end
	updateRangeFrame = function(self)
		if not self.Options.RangeFrame then return end
		if self.vb.deciminationActive > 0 then
			if UnitDebuff("player", decimination) or UnitDebuff("player", mythicDecimination) then
				DBM.RangeCheck:Show(17)--Show Everyone
			else
				DBM.RangeCheck:Show(17, debuffFilter)--Show only those affected by debuff
			end
		elseif self.vb.FelBombardmentActive > 0 then
			if UnitDebuff("player", FelBombardment) then
				DBM.RangeCheck:Show(7)--Will round to 8
			else
				DBM.RangeCheck:Show(7, debuffFilter)
			end
		else
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.deciminationActive = 0
	self.vb.FelBombardmentActive = 0
	timerFelBombardmentCD:Start(9.7-delay)
	--timerEradicationCD:Start(1-delay)
	timerDecimationCD:Start(1-delay)
	timerAnnihilationCD:Start(1-delay)
	if self:IsMythic() then
		timerLuringDestructionCD:Start(1-delay)
	end
	DBM:AddMsg(DBM_CORE_NEED_LOGS)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	DBM:AddMsg(DBM_CORE_NEED_LOGS)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 244969 or spellId == 246408 then
		--specWarnEradication:Show()
		--voiceEradication:Play("justrun")
		--timerEradicationCD:Start()
--[[	elseif spellId == 247044 then
		specWarnAnnihilation:Show()
		voiceAnnihilation:Play("helpsoak")
		timerAnnihilationCD:Start()--]]
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 246220 then
		--timerFelBombardmentCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 246220 then
		self.vb.FelBombardmentActive = self.vb.FelBombardmentActive + 1
		timerFelBombardmentCD:Start()
		if args:IsPlayer() then
			specWarnFelBombardment:Show()
			voiceFelBombardment:Play("runout")
			voiceFelBombardment:Schedule(5, "keepmove")
			yellFelBombardment:Countdown(5)
		elseif self:IsTank() then
			specWarnFelBombardmentTaunt:Show(args.destName)
			voiceFelBombardment:Play("tauntboss")
		else
			warnFelBombardment:Show(args.destName)
		end
		updateRangeFrame(self)
	elseif spellId == 247159 then
		specWarnLuringDestruction:Show()
		voiceLuringDestruction:Play("aesoon")
		timerLuringDestructionCD:Start()
	elseif spellId == 244152 then--Apocolypse Drive
		--Probably stop other timers too
		specWarnApocDrive:Show()
		voiceApocDrive:Play("targetchange")
		timerApocDriveCast:Start()
	elseif spellId == 244410 or spellId == 245770 or spellId == 246687 or spellId == 246920 then
		self.vb.deciminationActive = self.vb.deciminationActive + 1
		if self:AntiSpam(10, 1) then
			timerDecimationCD:Start()
		end
		warnDecimation:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			local _, _, _, _, _, _, expires = UnitDebuff("player", args.spellName)
			local remaining = expires-GetTime()
			if spellId == 246920 then--Mythic rules
				specWarnDecimationStun:Show()
				yellDecimationStun:Countdown(remaining)
				voiceDecimationStun:Play("targetyou")
			else
				specWarnDecimation:Show()
				yellDecimation:Countdown(remaining)
				voiceDecimation:Play("runout")
			end
		end
		if self.Options.SetIconOnDecimation then
			self:SetIcon(args.destName, self.vb.deciminationActive)
		end
		updateRangeFrame(self)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 246220 then
		self.vb.FelBombardmentActive = self.vb.FelBombardmentActive - 1
		if args:IsPlayer() then
			yellFelBombardment:Cancel()
		end
		updateRangeFrame(self)
	elseif spellId == 244152 then--Apocolypse Drive
		timerApocDriveCast:Stop()
		--Probably start other timers too
	elseif spellId == 244410 or spellId == 245770 or spellId == 246687 or spellId == 246920 then
		self.vb.deciminationActive = self.vb.deciminationActive - 1
		if args:IsPlayer() then
			yellDecimationStun:Cancel()
			yellDecimation:Cancel()
		end
		if self.Options.SetIconOnDecimation then
			self:SetIcon(args.destName, 0)
		end
		updateRangeFrame(self)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		voiceGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:238502") then

	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 121193 then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 245515 then--decimator-cannon-eject
		timerDecimationCD:Stop()
		--TODO, not stop it on mythic? or restart it maybe
		specWarnEradication:Show()
		voiceEradication:Play("justrun")
	elseif spellId == 245527 then--annihilator-cannon-eject
		timerAnnihilationCD:Stop()
		--TODO, not stop it on mythic? or restart it maybe
		specWarnEradication:Show()
		voiceEradication:Play("justrun")
	elseif spellId == 247044 then
		specWarnAnnihilation:Show()
		voiceAnnihilation:Play("helpsoak")
		timerAnnihilationCD:Start()
	end
end
