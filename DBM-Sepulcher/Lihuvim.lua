local mod	= DBM:NewMod(2461, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(182169)
mod:SetEncounterID(2539)
mod:SetUsedIcons(1, 2)
mod:SetHotfixNoticeRev(20220508000000)
mod:SetMinSyncRevision(20220508000000)
--mod.respawnTime = 29
--Disable all combat types to avoid him engaging during trash RP
mod:DisableRegenDetection()
mod:DisableIEEUCombatDetection()
mod.disableHealthCombat = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 362601 363130 364652 363088 365257 366001 368027",
	"SPELL_CAST_SUCCESS 363795 363676",
	"SPELL_AURA_APPLIED 362622 366012 363537 363795 363676 364312 363130 361200 368025 368024 368738 368740",--364092
	"SPELL_AURA_APPLIED_DOSE 368024 368025",
	"SPELL_AURA_REMOVED 363537 363795 363676 364312 363130 361200",--362622 366012 (mote Ids maybe?)
	"RAID_BOSS_WHISPER"
)

--TODO, wait for blizzard to add mote debuffs into combat log, redundant RBW will cover it for now
--TODO, Any add timers? they almost seemed inconsiquential (at least timer wise)
--TODO, announce when cast begins for Reorginate, or when it ends and who it's on?
--TODO, Degenerate is no longer in combat log
--[[
(ability.id = 362601 or ability.id = 363130 or ability.id = 364652 or ability.id = 363088 or ability.id = 368027) and type = "begincast"
 or (ability.id = 363795 or ability.id = 363676) and type = "cast"
 or ability.id = 361200 or ability.id = 363130
 or ability.id = 365257 and type = "begincast"
 or ability.id = 368738 and type = "applydebuff"
--]]
--Boss
local warnSynthesize							= mod:NewCountAnnounce(363130, 3)
local warnResonance								= mod:NewSpellAnnounce(368027, 3, nil, "Tank")
local warnKineticResonance						= mod:NewStackAnnounce(368024, 2, nil, "Tank|Healer")
local warnSunderingResonance					= mod:NewStackAnnounce(368025, 2, nil, "Tank|Healer")
--Adds
local warnFormSentry							= mod:NewSpellAnnounce(365257, 2)

--Boss
----Mythic
local specWarnHarmonicAlignment					= mod:NewSpecialWarningYou(368738, nil, nil, nil, 1, 12, 4)
local specWarnMelodicAlignment					= mod:NewSpecialWarningYou(368740, nil, nil, nil, 1, 12, 4)

local specWarnCosmicShift						= mod:NewSpecialWarningCount(363088, nil, DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.spell:format(363088), nil, 2, 13)
local specWarnUnstableMote						= mod:NewSpecialWarningYou(362622, nil, nil, nil, 1, 2)
local specWarnProtoformCascade					= mod:NewSpecialWarningDodge(364652, nil, 260885, nil, 1, 2)
local specWarnResonance							= mod:NewSpecialWarningDefensive(368027, false, nil, nil, 1, 2)
local specWarnKinResonanceTaunt					= mod:NewSpecialWarningTaunt(368024, false, nil, 2, 1, 2)
local specWarnSunResonanceTaunt					= mod:NewSpecialWarningTaunt(368025, nil, nil, nil, 1, 2)
local specWarnDeconstructingEnergy				= mod:NewSpecialWarningYou(363795, nil, 37859, nil, 1, 2)--Shorttext "Bomb"
local specWarnDeconstructingEnergyTaunt			= mod:NewSpecialWarningTaunt(363795, nil, 37859, nil, 1, 2)--Shorttext "Bomb"
local yellDeconstructingEnergy					= mod:NewYell(363795, 37859)--Shorttext "Bomb"
local yellDeconstructingEnergyFades				= mod:NewShortFadesYell(363795, 37859)--Shorttext "Bomb"

--Boss
----Mythic
local timerAlignmentShiftCD						= mod:NewCDTimer(20.6, 362659, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
----Other
local timerUnstableMoteCD						= mod:NewCDCountTimer(20.6, 362622, nil, nil, nil, 3)
local timerUnstableMote							= mod:NewBuffFadesTimer(5.9, 362622, nil, nil, nil, 5)--1.9+4
local timerProtoformRadiance					= mod:NewBuffActiveTimer(28.8, 363537, nil, nil, nil, 2)
local timerProtoformCascadeCD					= mod:NewCDCountTimer(10.9, 364652, 260885, nil, nil, 3)
local timerResonanceCD							= mod:NewCDCountTimer(41.2, 368027, DBM_COMMON_L.TANKCOMBOC, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerCosmicShiftCD						= mod:NewCDCountTimer(20.3, 363088, nil, nil, nil, 3)
local timerDeconstructingEnergyCD				= mod:NewCDCountTimer(37.2, 363795, 119342, nil, nil, 3)--Shorttext "Bombs"
local timerSynthesizeCD							= mod:NewCDCountTimer(101, 363130, nil, nil, nil, 6)
local timerSynthesize							= mod:NewBuffActiveTimer(20, 363130, nil, nil, nil, 6, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerRealignment							= mod:NewBuffActiveTimer(20, 361200, nil, nil, nil, 6)
local berserkTimer								= mod:NewBerserkTimer(480)
--Adds

mod:AddSetIconOption("SetIconOnDeconstructingEnergy", 363795, true, false, {1, 2})
mod:AddNamePlateOption("NPAuraOnEphemeralBarrier", 364312, true)
mod:GroupSpells(368027, 368025, 368024)--Group responance debuffs together
mod:GroupSpells(362659, 368738, 368740)--Group mythic debuffs together with Allignment Shift (https://ptr.wowhead.com/spell=362659/alignment-shift)

mod.vb.energyIcon = 1
mod.vb.moteCount = 0
mod.vb.synthesizeCount = 0
mod.vb.cascadeCount = 0
mod.vb.cosmicCount = 0
mod.vb.deconstructCount = 0
mod.vb.resonanceCount = 0
mod.vb.timerMode = 1
local grip, push = DBM:GetSpellInfo(56689), DBM:GetSpellInfo(359132)
local playerGrip = false
local difficultyName = mod:IsMythic() and "mythic" or mod:IsHeroic() and "heroic" or "easy"
local allTimers = {
	["easy"] = {--Normal and LFR combined
		[1] = {--Engage
			--Unstable Mote
			[362601] = {12, 31.5},--2nd doesn't always happen, depends on if synth is 45 or 46
			--Protoform Cascade
			[364652] = {5.7, 31.5},
			--Cosmic Shift
			[363088] = {29},
			--Deconstructing Energy
			[363676] = {20.4},
		},
		[2] = {--After Realignment
			--Unstable Mote
			[362601] = {12.4, 32.7, 30.4},
			--Protoform Cascade
			[364652] = {6.4, 32.7, 30.4, 14.5},
			--Cosmic Shift
			[363088] = {30.7, 23},
			--Deconstructing Energy
			[363676] = {20.9, 38.8},
		},
	},
	["heroic"] = {
		[1] = {--Engage
			--Unstable Mote
			[362601] = {12.1},
			--Protoform Cascade
			[364652] = {5},
			--Resonance
			[368027] = {38.7},
			--Cosmic Shift
			[363088] = {29},
			--Deconstructing Energy
			[363676] = {20.5},
		},
		[2] = {--After Realignment
			--Unstable Mote
			[362601] = {12.4, 38.8},
			--Protoform Cascade
			[364652] = {5.7, 71.6},
			--Resonance
			[368027] = {38.8, 44.9},
			--Cosmic Shift
			[363088] = {30.7, 38.8},
			--Deconstructing Energy
			[363676] = {20.9, 38.4},
		},
	},
	["mythic"] = {--Mythic should be same as heroic minus first engage timers being shorter. But we'll see if that's changed
		[1] = {--Engage
			--Unstable Mote
			[362601] = {12.1},
			--Protoform Cascade
			[364652] = {5.7},
			--Resonance
			[368027] = {},--Doesn't seem cast before first intermission
			--Cosmic Shift
			[363088] = {},--Doesn't seem cast before first intermission
			--Deconstructing Energy
			[363676] = {20.5},
		},
		[2] = {--After Realignment
			--Unstable Mote
			[362601] = {12.4, 38.8},
			--Protoform Cascade
			[364652] = {5.7, 71.6},
			--Resonance
			[368027] = {38.8, 44.9},
			--Cosmic Shift
			[363088] = {30.7, 38.8},
			--Deconstructing Energy
			[363676] = {20.9, 38.4},
		},
	},
}
--local alignmentTimers = {0, 36.1, 42.5, 34.9, 43.6, 62.2, 34.8, 43.7, 62.1, 34.9, 43.6, 62.2}

function mod:OnCombatStart(delay)
	self.vb.energyIcon = 1
	self.vb.moteCount = 0
	self.vb.synthesizeCount = 0
	self.vb.cascadeCount = 0
	self.vb.cosmicCount = 0
	self.vb.deconstructCount = 0
	self.vb.resonanceCount = 0
	self.vb.timerMode = 1
	playerGrip = false
	timerProtoformCascadeCD:Start(5-delay, 1)--5-6
	timerUnstableMoteCD:Start(12-delay, 1)
	timerDeconstructingEnergyCD:Start(20.5-delay, 1)--20.5-26 on normal, 20-21 heroic/mythic
	if self:IsMythic() then
		difficultyName = "mythic"
		--Earlier synth, no cosmic shift or resonance
		timerSynthesizeCD:Start(30-delay, 1)
	elseif self:IsHeroic() then
		difficultyName = "heroic"
		timerCosmicShiftCD:Start(29-delay, 1)
		timerResonanceCD:Start(43-delay, 1)
		timerSynthesizeCD:Start(45.4-delay, 1)
	else
		difficultyName = "easy"
		--Same as heroic, minus resonance mechanic not there at all
		timerCosmicShiftCD:Start(29-delay, 1)
		timerSynthesizeCD:Start(45.4-delay, 1)
	end
	berserkTimer:Start(self:IsMythic() and 600 or 480-delay)
	if self.Options.NPAuraOnEphemeralBarrier then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnEphemeralBarrier then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
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
	if spellId == 362601 then
		self.vb.moteCount = self.vb.moteCount + 1
		local timer = allTimers[difficultyName][self.vb.timerMode][spellId][self.vb.moteCount+1]
		if timer then
			timerUnstableMoteCD:Start(timer, self.vb.moteCount+1)
		end
		timerUnstableMote:Start()
	elseif spellId == 363130 then
		if self.vb.timerMode == 1 then
			self.vb.timerMode = 2
		end
		self.vb.synthesizeCount = self.vb.synthesizeCount + 1
		warnSynthesize:Show(self.vb.synthesizeCount)
		--stop some boss timers here
		timerUnstableMoteCD:Stop()
		timerProtoformCascadeCD:Stop()
		timerDeconstructingEnergyCD:Stop()
		timerCosmicShiftCD:Stop()
		timerResonanceCD:Stop()
		if self:IsFated() then
			self:AffixEvent(1, 2)--Restarts
		end
	elseif spellId == 364652 then
		self.vb.cascadeCount = self.vb.cascadeCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnProtoformCascade:Show()
			specWarnProtoformCascade:Play("defensive")
		end
		local timer = allTimers[difficultyName][self.vb.timerMode][spellId][self.vb.cascadeCount+1]
		if timer then
			timerProtoformCascadeCD:Start(timer, self.vb.cascadeCount+1)
		end
	elseif spellId == 363088 then
		self.vb.cosmicCount = self.vb.cosmicCount + 1
		if playerGrip then
			specWarnCosmicShift:Show(grip)
			specWarnCosmicShift:Play("pullin")
		else
			specWarnCosmicShift:Show(push)
			specWarnCosmicShift:Play("pushbackincoming")
		end
		local timer = allTimers[difficultyName][self.vb.timerMode][spellId][self.vb.cosmicCount+1]
		if timer then
			timerCosmicShiftCD:Start(timer, self.vb.cosmicCount+1)
		end
		if self:IsMythic() then
			timerAlignmentShiftCD:Start(7)
		end
	elseif spellId == 365257 and self:AntiSpam(5, 1) then
		warnFormSentry:Show()
	elseif spellId == 368027 then
		self.vb.resonanceCount = self.vb.resonanceCount + 1
		if self.Options.SpecWarn368027defensive and self:IsTanking("player", "boss1", nil, true) then
			specWarnResonance:Show()
			specWarnResonance:Play("defensive")
		else
			warnResonance:Show()
		end
		local timer = allTimers[difficultyName][self.vb.timerMode][spellId][self.vb.resonanceCount+1]
		if timer then
			timerResonanceCD:Start(timer, self.vb.resonanceCount+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 363795 or spellId == 363676 then
		self.vb.energyIcon = 1
		self.vb.deconstructCount = self.vb.deconstructCount + 1
		local timer = allTimers[difficultyName][self.vb.timerMode][spellId][self.vb.deconstructCount+1]
		if timer then
			timerDeconstructingEnergyCD:Start(timer, self.vb.deconstructCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if (spellId == 362622 or spellId == 366012) and self:AntiSpam(4, args.destName.."1") then
		if args:IsPlayer() and self:AntiSpam(3, 2) then
			specWarnUnstableMote:Show()
			specWarnUnstableMote:Play("targetyou")
		end
	elseif spellId == 363537 then
		timerProtoformRadiance:Start()
	elseif spellId == 363795 or spellId == 363676 then--363676 goes on tank, 363795 goes on dps
		local icon = self.vb.energyIcon
		if self.Options.SetIconOnDeconstructingEnergy then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnDeconstructingEnergy:Show()
			specWarnDeconstructingEnergy:Play("runout")
			yellDeconstructingEnergy:Yell(icon, icon)
			yellDeconstructingEnergyFades:Countdown(spellId, nil, icon)
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnDeconstructingEnergyTaunt:Show(args.destName)
				specWarnDeconstructingEnergyTaunt:Play("tauntboss")
			end
		end
		self.vb.energyIcon = self.vb.energyIcon + 1
	elseif spellId == 364312 and args:IsDestTypeHostile() then
		if self.Options.NPAuraOnEphemeralBarrier then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 363130 then
		timerSynthesize:Start(self:IsMythic() and 15 or 20)
	elseif spellId == 368024 then--Kinetic Resonance
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			warnKineticResonance:Show(args.destName, args.amount or 1)
		end
		if not args:IsPlayer() and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then
			specWarnKinResonanceTaunt:Show()
			specWarnKinResonanceTaunt:Play("tauntboss")
		end
	elseif spellId == 368025 then--Sundering Resonance
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			warnSunderingResonance:Show(args.destName, args.amount or 1)
		end
		if not args:IsPlayer() and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then
			specWarnSunResonanceTaunt:Show()
			specWarnSunResonanceTaunt:Play("tauntboss")
		end
	elseif spellId == 361200 then--Realignment
		timerRealignment:Start(30)
		if self:IsMythic() then
			timerAlignmentShiftCD:Start(31.5)
		end
	elseif spellId == 368738 and args:IsPlayer() then
		specWarnHarmonicAlignment:Show()
		specWarnHarmonicAlignment:Play("harmonic")
		playerGrip = false
	elseif spellId == 368740 and args:IsPlayer() then
		specWarnMelodicAlignment:Show()
		specWarnMelodicAlignment:Play("melodic")
		playerGrip = true
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 363537 then
		timerProtoformRadiance:Stop()
	elseif spellId == 363795 or spellId == 363676 then
		if self.Options.SetIconOnDeconstructingEnergy then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellDeconstructingEnergyFades:Cancel()
		end
	elseif spellId == 364312 and args:IsDestTypeHostile() then
		if self.Options.NPAuraOnEphemeralBarrier then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 363130 then
		timerSynthesize:Stop()
	elseif spellId == 361200 then--Realignment
		self.vb.moteCount = 0
		self.vb.cascadeCount = 0
		self.vb.cosmicCount = 0
		self.vb.deconstructCount = 0
		self.vb.resonanceCount = 0
		timerRealignment:Stop()
		timerProtoformCascadeCD:Start(5.7, 1)
		timerUnstableMoteCD:Start(12.4, 1)
		timerDeconstructingEnergyCD:Start(20.9, 1)
		timerCosmicShiftCD:Start(30.7, 1)
		if self:IsHard() then
			timerResonanceCD:Start(38.8, 1)
		end
		timerSynthesizeCD:Start(91.4, self.vb.synthesizeCount+1)
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("362622") and self:AntiSpam(3, 2) then
		specWarnUnstableMote:Show()
		specWarnUnstableMote:Play("targetyou")
	end
end
