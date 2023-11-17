local mod	= DBM:NewMod(2519, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(204931)

mod:SetEncounterID(2677)
--mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20231116000000)
mod:SetMinSyncRevision(20231114000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 428960 419506 420422 417455 417431 419144 412761 428963 428400 428971 428968 428965 419123 422837 410223 425492 422518",
	"SPELL_CAST_SUCCESS 428954 414186 422935 422524",
--	"SPELL_SUMMON 422029",
	"SPELL_AURA_APPLIED 428961 417807 417443 429866 423717 425494",
	"SPELL_AURA_APPLIED_DOSE 417807 417443 429866 425494",
	"SPELL_AURA_REMOVED 419144",
--	"SPELL_AURA_REMOVED_DOSE",
	"SPELL_PERIODIC_DAMAGE 419504 425483",
	"SPELL_PERIODIC_MISSED 419504 425483",
	"UNIT_DIED"
)

--[[
(ability.id = 428960 or ability.id = 419506 or ability.id = 420422 or ability.id = 417455 or ability.id = 417431 or ability.id = 419144 or ability.id = 412761 or ability.id = 428963 or ability.id = 428400 or ability.id = 428971 or ability.id = 428968 or ability.id = 428965 or ability.id = 419123 or ability.id = 422837 or ability.id = 410223 or ability.id = 425492 or ability.id = 422518) and type = "begincast"
 or (ability.id = 428954 or ability.id = 414186 or ability.id = 421937 or ability.id = 422935 or ability.id = 429875 or ability.id = 429876 or ability.id = 422524) and type = "cast"
 or ability.id = 419144 and (type = "applybuff" or type = "removebuff")
 or ability.id = 414187 and type = "applydebuff"
--]]
--TODO, right cast ID for Darkflame cleave to add nameplate CD timer to mob
--TODO, what do with Flamespawn on mythic?
--TODO, what to do with Aflame stacks, it seems like something that may be spammy if stacks up quickly so it's off by default for now
--TODO, tank swap stacks/when to taunt
--TODO, spawn events or IEEU for the big adds in stage 2 for starting initial nameplate timers
--TODO, do more with raging ember and screaming soul?
--TODO, seeds detection/timer in stage 3, it's a big part of things

--TODO, common locals/short names applied to mod
--General
local warnPhase										= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)

local specWarnGTFO									= mod:NewSpecialWarningGTFO(419504, nil, nil, nil, 1, 8)

--local berserkTimer								= mod:NewBerserkTimer(600)
--Stage One: The Dream Render
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26666))
local warnDarkflameShades							= mod:NewCountAnnounce(428954, 3)
local warnFirestorm									= mod:NewCountAnnounce(419506, 4)
local warnBlaze										= mod:NewCountAnnounce(414186, 3)
local warnAflame									= mod:NewCountAnnounce(417807, 3, nil, false, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(417807))--Player
local warnFyralathsMark								= mod:NewStackAnnounce(417443, 3, nil, "Tank|Healer")

local specWarnFyralathsFlame						= mod:NewSpecialWarningYou(428961, nil, nil, nil, 1, 2, 4)--Not a private aura (at least not yet)
local yellFyralathsFlame							= mod:NewShortYell(428961)
--local specWarnFirestorm								= mod:NewSpecialWarningDodgeCount(419506, nil, nil, nil, 2, 2)
local specWarnWildFire								= mod:NewSpecialWarningCount(420422, nil, nil, nil, 2, 2)
local specWarnDreamRend								= mod:NewSpecialWarningRunCount(417455, nil, nil, nil, 4, 2)
local specWarnFyralathsBite							= mod:NewSpecialWarningDefensive(417431, nil, nil, nil, 1, 2)
local specWarnFyralathsMark							= mod:NewSpecialWarningTaunt(417443, nil, nil, nil, 1, 2)

local timerDarkflameShadesCD						= mod:NewCDCountTimer(49, 428954, nil, nil, nil, 1, nil, DBM_CORE_L.MYTHIC_ICON)
--local timerFyralathsFlameCD						= mod:NewCDNPTimer(11.8, 428960, nil, nil, nil, 3, nil, DBM_COMMON_L.TANK_ICON)
local timerFirestormCD								= mod:NewCDCountTimer(49, 419506, nil, nil, nil, 3)
local timerWildFireCD								= mod:NewCDCountTimer(49, 420422, nil, nil, nil, 2)
local timerDreamRendCD								= mod:NewCDCountTimer(49, 417455, nil, nil, nil, 3)
local timerBlazeCD									= mod:NewCDCountTimer(49, 414186, nil, nil, nil, 3)
local timerFyralathsBiteCD							= mod:NewCDCountTimer(49, 417431, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerCorrupt									= mod:NewCastTimer(13, 419144, nil, nil, nil, 6)

mod:AddPrivateAuraSoundOption(419060, true, 419506, 1)--Firestorm
mod:AddPrivateAuraSoundOption(426370, true, 426370, 1)--Darkflame Cleave
mod:AddPrivateAuraSoundOption(414187, true, 414186, 1)--Blaze
--mod:AddRangeFrameOption("5/6/10")
--mod:AddInfoFrameOption(407919, true)
--mod:AddSetIconOption("SetIconOnSinSeeker", 335114, true, false, {1, 2, 3})
--Intermission: Amirdrassil in Peril
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26667))
local warnShadowflameEruption						= mod:NewCountAnnounce(429866, 4, nil, false, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(429866))--Player

local specWarnIncarnate								= mod:NewSpecialWarningDodge(412761, nil, nil, nil, 2, 2)
local specWarnShadowflameBreath						= mod:NewSpecialWarningDodgeCount(410223, nil, nil, nil, 2, 2)

local timerIncarnate								= mod:NewCastTimer(8.5, 412761, nil, nil, nil, 2)
local timerShadowflameBreathCD						= mod:NewCDCountTimer(49, 410223, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddPrivateAuraSoundOption(429903, true, 429903, 1)--Flamebound
mod:AddPrivateAuraSoundOption(429906, true, 429906, 1)--Shadowbound
--Stage Two: Children of the Stars
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26668))
local warnSpirits									= mod:NewCountAnnounce(422029, 3)
local warnGreaterFirestorm							= mod:NewCountAnnounce(422518, 3)
local warnExplodingCore								= mod:NewCastAnnounce(428400, 4)

--local specWarnGreaterFirestorm						= mod:NewSpecialWarningDodgeCount(422518, nil, nil, nil, 2, 2)
local specWarnMoltenGauntlet						= mod:NewSpecialWarningDefensive(428963, nil, nil, nil, 1, 2)
local specWarnShadowGauntlet						= mod:NewSpecialWarningDefensive(428965, nil, nil, nil, 1, 2)
local specWarnFlamefall								= mod:NewSpecialWarningRunCount(419123, nil, nil, nil, 4, 2)
local specWarnShadowflameDevastation				= mod:NewSpecialWarningDodgeCount(422524, nil, nil, nil, 2, 2)

local timerSpiritsCD								= mod:NewCDCountTimer(49, 422029, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerGreaterFirestormCD						= mod:NewCDCountTimer(49, 422518, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)
local timerMoltenGauntletCD							= mod:NewCDNPTimer(11.7, 428963, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local timerMoltenEruptionCD						= mod:NewCDNPTimer(49, 428971, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
--local timerShadowGauntletCD						= mod:NewCDNPTimer(49, 428965, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local timerShadowCageCD							= mod:NewCDNPTimer(49, 428968, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerFlamefallCD								= mod:NewCDCountTimer(49, 419123, nil, nil, nil, 2)
local timerShadowflameDevastationCD					= mod:NewCDCountTimer(49, 422524, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddPrivateAuraSoundOption(422520, true, 422518, 1)--Greater Firestorm
mod:AddPrivateAuraSoundOption(428988, true, 428971, 1)--Molten Eruption
mod:AddPrivateAuraSoundOption(428970, true, 428968, 1)--Shadow Cage
--Stage Three: Shadowflame Incarnate
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26670))
local warnBloom										= mod:NewYouAnnounce(423717, 1)
local warnInfernalMaw								= mod:NewStackAnnounce(425492, 3, nil, "Tank|Healer")

local specWarnApocalypseRoar						= mod:NewSpecialWarningCount(422837, nil, nil, nil, 2, 13)
local specWarnInfernalMaw							= mod:NewSpecialWarningDefensive(425492, nil, nil, nil, 1, 2)
--local specWarnInfernalMawTaunt					= mod:NewSpecialWarningTaunt(425492, nil, nil, nil, 1, 2)

local timerApocalypseroarCD							= mod:NewCDCountTimer(49, 422837, nil, nil, nil, 2)
local timerInfernalMawCD							= mod:NewCDCountTimer(49, 425492, nil, "Tank|healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddPrivateAuraSoundOption(423601, true, 423601, 1)--Seed of Amirdrassil
mod:AddPrivateAuraSoundOption(430048, true, 430048, 1)--Corrupted Seed
mod:AddPrivateAuraSoundOption(425525, true, 422935, 1)--Eternal Firestorm

mod.vb.darkflameShadesCount = 0
mod.vb.firestormCount = 0--reused for empowered version
mod.vb.wildfireCount = 0
mod.vb.dreamRendCount = 0
mod.vb.blazeCount = 0
mod.vb.tankCount = 0--Reused for tank ability in all stages
--Intermission
mod.vb.shadowflameBreathCount = 0
--Stage 2
mod.vb.spiritsCount = 0
mod.vb.flameFallCount = 0
mod.vb.shadowflameDevastation = 0
--Stage 3
mod.vb.roarCount = 0

local difficultyName = "lfr"
local allTimers = {--428954 for darkflame flames mythic
	["normal"] = {--Normal WIP
		[1] = {
			--Wildfire
			[420422] = {3.9, 24.0, 53.4},
			--Fyralaths Bite
			[417431] = {8.9, 15.0, 15.0, 23.5, 15.0, 15.0},
			--Firestorm
			[419506] = {12.9, 53.5},
			--Dreams Rend
			[417455] = {41.9, 53.4},
			--Blaze (Heroic+ only)
			[414186] = {32, 23.9, 29.5},
		},
		[2] = {
			--Flamefall
			[420422] = {5.8, 75, 79.9},
			--Fyralaths Bite
			[417431] = {18.7, 11.0, 60.0, 11.0, 11.0, 58.0, 11.0, 11.0},
			--Greater Firestorm
			[422518] = {35.8, 79.9, 80.0},
			--Shadowflame Devastation
			[422524] = {58.8, 80},
			--Spirits of the Kaldorai
			[422029] = {20, 20, 20, 25, 30, 25, 25, 25},
			--Blaze (Heroic+ only)
			[414186] = {20.7, 14.9, 25, 30, 26.9, 23, 30, 25},
		},
		[3] = {
			--Infernal Maw
			[425492] = {4.9, 3.0, 10.0, 3.0, 25.0, 3.0, 10.0, 3.0, 25.0, 10.0, 3.0, 25.0, 3.0, 10.0, 3.0},
			--Shadowflame Breath
			[410223] = {10, 41.0, 41.0, 41.0},
			--Apocalypse Roar
			[422837] = {34, 41.0, 40.9, 40.9},
			--Blaze (Heroic+ only)
			[414186] = {12, 40.9, 40.9},
		},
	},
}

local function blazeLoop(self)
	self.vb.blazeCount = self.vb.blazeCount + 1
	warnBlaze:Show(self.vb.blazeCount)
	local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, 414186, self.vb.blazeCount+1)
	if timer then
		timerBlazeCD:Start(timer, self.vb.blazeCount+1)
		self:Schedule(timer, blazeLoop, self)
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.darkflameShadesCount = 0
	self.vb.firestormCount = 0
	self.vb.wildfireCount = 0
	self.vb.blazeCount = 0
	self.vb.tankCount = 0
	self.vb.shadowflameBreathCount = 0
	self.vb.spiritsCount = 0
	self.vb.flameFallCount = 0
	self.vb.shadowflameDevastation = 0
	self.vb.roarCount = 0
	timerWildFireCD:Start(3.9, 1)
	timerFyralathsBiteCD:Start(8.9, 1)
	timerFirestormCD:Start(12.9, 1)
	timerDreamRendCD:Start(41.9, 1)

	--Hopefully the API doesn't mind registering 16 private auras at same time on pull
	--It's not DBMs fault designers got carried away :D
	self:EnablePrivateAuraSound(419060, "runout", 2)--Firestorm
	self:EnablePrivateAuraSound(414187, "bombyou", 2)--Blaze
	self:EnablePrivateAuraSound(421825, "bombyou", 2, 414187)--Register Additional blaze Ids (6 in total)
	self:EnablePrivateAuraSound(421826, "bombyou", 2, 414187)--Register Additional blaze Ids (6 in total)
	self:EnablePrivateAuraSound(421827, "bombyou", 2, 414187)--Register Additional blaze Ids (6 in total)
	self:EnablePrivateAuraSound(421828, "bombyou", 2, 414187)--Register Additional blaze Ids (6 in total)
	self:EnablePrivateAuraSound(421829, "bombyou", 2, 414187)--Register Additional blaze Ids (6 in total)
	self:EnablePrivateAuraSound(422520, "runout", 2)--Greater Firestorm
	self:EnablePrivateAuraSound(423601, "seedyou", 15)--Seed of Amirdrassil
	self:EnablePrivateAuraSound(430048, "seedyou", 15)--Corrupted Seed
	self:EnablePrivateAuraSound(425525, "runout", 2)--Eternal Firestorm
	if self:IsMythic() then
		difficultyName = "mythic"
		self:EnablePrivateAuraSound(426370, "gathershare", 2)--Darkflame Cleave
		self:EnablePrivateAuraSound(429903, "flameyou", 15)--Flamebound
		self:EnablePrivateAuraSound(429906, "shadowyou", 15)--Shadowbound
		self:EnablePrivateAuraSound(428988, "flameyou", 15)--Molten Eruption (because both molten and shadow are bombs, can't just use bombyou for both, so better to elemental asign)
		self:EnablePrivateAuraSound(428970, "shadowyou", 15)--Shadow Cage (because both molten and shadow are bombs, can't just use bombyou for both, so better to elemental asign)
		timerDarkflameShadesCD:Start(1)
		timerBlazeCD:Start(32, 1)--Heroic/Mythic only
		self:Schedule(32, blazeLoop, self)
	elseif self:IsHeroic() then
		difficultyName = "normal"--Same as heroic, plus blaze
		timerBlazeCD:Start(32, 1)--Heroic/Mythic only
		self:Schedule(32, blazeLoop, self)
	else
		difficultyName = "normal"
	end
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		difficultyName = "mythic"
	elseif self:IsHeroic() then
		difficultyName = "heroic"
	elseif self:IsNormal() then
		difficultyName = "normal"
	else
		difficultyName = "lfr"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 428960 then
		DBM:Debug("Fyralaths Flame", 3)--Honestly just here so LUAcheck doesn't complain statement is empty
		--timerFyralathsFlameCD:Start(nil, args.sourceGUID)
	elseif spellId == 419506 then
		self.vb.firestormCount = self.vb.firestormCount + 1
		warnFirestorm:Show(self.vb.firestormCount)
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.firestormCount+1)
		if timer then
			timerFirestormCD:Start(timer, self.vb.firestormCount+1)
		end
	elseif spellId == 420422 then
		self.vb.wildfireCount = self.vb.wildfireCount + 1
		specWarnWildFire:Show(self.vb.wildfireCount)
		specWarnWildFire:Play("aesoon")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.wildfireCount+1)
		if timer then
			timerWildFireCD:Start(timer, self.vb.wildfireCount+1)
		end
	elseif spellId == 417455 then
		self.vb.dreamRendCount = self.vb.dreamRendCount + 1
		specWarnDreamRend:Show(self.vb.dreamRendCount)
		specWarnDreamRend:Play("justrun")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.dreamRendCount+1)
		if timer then
			timerDreamRendCD:Start(timer, self.vb.dreamRendCount+1)
		end
	elseif spellId == 417431 then
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then--Boss1 isn't certainty, could be tree, GUID matching used
			specWarnFyralathsBite:Show()
			specWarnFyralathsBite:Play("defensive")
		end
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.tankCount+1)
		if timer then
			timerFyralathsBiteCD:Start(timer, self.vb.tankCount+1)
		end
	elseif spellId == 419144 then--Corrupt
		self:SetStage(1.5)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
		warnPhase:Play("phasechange")

--		timerIncarnateCD:Start(1)
		timerShadowflameBreathCD:Start(1)
	elseif spellId == 412761 then
		if self:GetStage(1) then
			timerFirestormCD:Stop()
			timerWildFireCD:Stop()
			timerDreamRendCD:Stop()
			timerFyralathsBiteCD:Stop()
			timerBlazeCD:Stop()--Heroic/Mythic only
			self:Unschedule(blazeLoop)
			timerDarkflameShadesCD:Stop()--Mythic Only
			timerCorrupt:Start(13)
		end
		specWarnIncarnate:Show()
		specWarnIncarnate:Play("carefly")
--		timerIncarnateCD:Start()
	elseif spellId == 422518 then
		self.vb.firestormCount = self.vb.firestormCount + 1
		warnGreaterFirestorm:Show(self.vb.firestormCount)
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.firestormCount+1)
		if timer then
			timerGreaterFirestormCD:Start(timer, self.vb.firestormCount+1)
		end
		timerIncarnate:Start()--Always cast after
	elseif spellId == 428963 then
		timerMoltenGauntletCD:Start(nil, args.sourceGUID)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnMoltenGauntlet:Show()
			specWarnMoltenGauntlet:Play("defensive")
		end
	elseif spellId == 428965 then--Not verified yet
		--timerShadowGauntletCD:Start(nil, args.sourceGUID)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnShadowGauntlet:Show()
			specWarnShadowGauntlet:Play("defensive")
		end
	elseif spellId == 428400 and self:AntiSpam(5, 1) then--Not verified yet
		warnExplodingCore:Show()
--	elseif spellId == 428971 then--Not verified yet
		--timerMoltenEruptionCD:Start(nil, args.sourceGUID)
--	elseif spellId == 428968 then--Not verified yet
		--timerShadowCageCD:Start(nil, args.sourceGUID)
	elseif spellId == 419123 then
		self.vb.flameFallCount = self.vb.flameFallCount + 1
		specWarnFlamefall:Show(self.vb.flameFallCount)
		specWarnFlamefall:Play("justrun")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.flameFallCount+1)
		if timer then
			timerFlamefallCD:Start(timer, self.vb.flameFallCount+1)
		end
	elseif spellId == 422837 then
		self.vb.roarCount = self.vb.roarCount + 1
		specWarnApocalypseRoar:Show(self.vb.roarCount)
		specWarnApocalypseRoar:Play("pushbackincoming")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.roarCount+1)
		if timer then
			timerApocalypseroarCD:Start(timer, self.vb.roarCount+1)
		end
	elseif spellId == 410223 then
		self.vb.shadowflameBreathCount = self.vb.shadowflameBreathCount + 1
		specWarnShadowflameBreath:Show(self.vb.shadowflameBreathCount)
		specWarnShadowflameBreath:Play("breathsoon")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.shadowflameBreathCount+1)
		if timer then
			timerShadowflameBreathCD:Start(timer, self.vb.shadowflameBreathCount+1)
		end
	elseif spellId == 425492 then
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then--Boss1 isn't certainty, could be tree, GUID matching used
			specWarnInfernalMaw:Show()
			specWarnInfernalMaw:Play("defensive")
		end
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.tankCount+1)
		if timer then
			timerInfernalMawCD:Start(timer, self.vb.tankCount+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 428954 then--Not verified yet
		self.vb.darkflameShadesCount = self.vb.darkflameShadesCount + 1
		warnDarkflameShades:Show(self.vb.darkflameShadesCount)
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.darkflameShadesCount+1)
		if timer then
			timerDarkflameShadesCD:Start(timer, self.vb.darkflameShadesCount+1)
		end
--	elseif spellId == 414186 then--Not verified yet
--		self.vb.blazeCount = self.vb.blazeCount + 1
--		warnBlaze:Show(self.vb.blazeCount)
--		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.blazeCount+1)
--		if timer then
--			timerBlazeCD:Start(timer, self.vb.blazeCount+1)
--		end
	elseif spellId == 422524 then
		self.vb.shadowflameDevastation = self.vb.shadowflameDevastation + 1
		specWarnShadowflameDevastation:Show(self.vb.shadowflameDevastation)
		specWarnShadowflameDevastation:Play("breathsoon")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.shadowflameDevastation+1)
		if timer then
			timerShadowflameDevastationCD:Start(timer, self.vb.shadowflameDevastation+1)
		end
	elseif spellId == 422935 then
		if self:GetStage(3, 1) then
			self:SetStage(3)
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
			warnPhase:Play("pthree")
			self.vb.firestormCount = 0
			self.vb.blazeCount = 0
			self.vb.tankCount = 0
			self.vb.shadowflameBreathCount = 0
			timerSpiritsCD:Stop()
			timerGreaterFirestormCD:Stop()
			timerFlamefallCD:Stop()
			timerShadowflameDevastationCD:Stop()
			timerFyralathsBiteCD:Stop()
			timerBlazeCD:Stop()
			self:Unschedule(blazeLoop)
			timerInfernalMawCD:Start(4.9, 1)
			timerShadowflameBreathCD:Start(10, 1)
			timerApocalypseroarCD:Start(34, 1)
			if self:IsHard() then
				timerBlazeCD:Start(12, 1)--Heroic/Mythic only
				self:Schedule(12, blazeLoop, self)
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 428961 then
		if args:IsPlayer() then
			specWarnFyralathsFlame:Show()
			specWarnFyralathsFlame:Play("scatter")
			yellFyralathsFlame:Yell()
		end
	elseif spellId == 417807 then
		if args:IsPlayer() then
			local amount = args.amount or 1
			if amount % 4 == 0 then --4, 8, 12, etc...
				warnAflame:Show(amount)
			end
		end
	elseif spellId == 429866 then
		if args:IsPlayer() and self:AntiSpam(3, 3) then
			local amount = args.amount or 1
--			if amount % 2 == 1 then -- 1, 3, 5...
				warnShadowflameEruption:Show(amount)
--			end
		end
	elseif spellId == 417443 then
		local amount = args.amount or 1
		local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
		local remaining
		if expireTime then
			remaining = expireTime-GetTime()
		end
		local timer = (self:GetFromTimersTable(allTimers, difficultyName, false, 417431, self.vb.tankCount+1) or 15) - 5
		if (not remaining or remaining and remaining < timer) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
			specWarnFyralathsMark:Show(args.destName)
			specWarnFyralathsMark:Play("tauntboss")
		else
			warnFyralathsMark:Show(args.destName, amount)
		end
	elseif spellId == 425494 then
		local amount = args.amount or 1
--		local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
--		local remaining
--		if expireTime then
--			remaining = expireTime-GetTime()
--		end
--		local timer = (self:GetFromTimersTable(allTimers, difficultyName, false, 425492, self.vb.tankCount+1) or 17.9) - 5
--		if (not remaining or remaining and remaining < timer) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
--			specWarnInfernalMawTaunt:Show(args.destName)
--			specWarnInfernalMawTaunt:Play("tauntboss")
--		else
			warnInfernalMaw:Show(args.destName, amount)
--		end
	elseif spellId == 423717 and args:IsPlayer() then
		warnBloom:Show()
--	elseif spellId == 388479 and self:AntiSpam(5, 2) then
--		self.vb.spiritsCount = self.vb.spiritsCount + 1
--		warnSpirits:Show(self.vb.spiritsCount)
--		timerSpiritsCD:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 419144 and self:GetStage(2, 1) then--Corrupt ending, also appies 426815 when this ends
		self:SetStage(2)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		self.vb.firestormCount = 0
		self.vb.blazeCount = 0
		self.vb.tankCount = 0
		timerSpiritsCD:Start(2)
		timerFlamefallCD:Start(5.8, 1)
		timerFyralathsBiteCD:Start(18.8, 1)
		timerSpiritsCD:Start(20, 1)
		timerGreaterFirestormCD:Start(35.8, 1)
		timerShadowflameDevastationCD:Start(58.8, 1)

		if self:IsHard() then
			timerBlazeCD:Start(20.7, 1)--Heroic/Mythic only
			self:Schedule(20.7, blazeLoop, 1)
		end
	end
end
--mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 419504 or spellId == 425483) and destGUID == UnitGUID("player") and self:AntiSpam(3, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

do
	local spiritsName = DBM:EJ_GetSectionInfo(28082)
	--<138.97 20:33:14> [CHAT_MSG_MONSTER_YELL] This tree will not fall!#Spirit of the Kaldorei###Spirit of the Kaldorei##0#0##0#1231#nil#0#false#false#false#false
	--"<158.99 20:33:34> [CHAT_MSG_MONSTER_YELL] Amirdrassil must not fall.#Spirit of the Kaldorei###Spirit of the Kaldorei##0#0##0#1236#nil#0#false#false#false#false",
	--"<183.92 20:33:59> [CHAT_MSG_MONSTER_YELL] Our lives are sworn to Amirdrassil!#Spirit of the Kaldorei###Spirit of the Kaldorei##0#0##0#1241#nil#0#false#false#false#false",
	function mod:CHAT_MSG_MONSTER_YELL(msg, mob)
		if mob == spiritsName then--Spirits yell when they spawn, no other time, so match action name with auto localized name, no localizing required
			self.vb.spiritsCount = self.vb.spiritsCount + 1
			warnSpirits:Show(self.vb.spiritsCount)
			local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, 422029, self.vb.spiritsCount+1)
			if timer then
				timerSpiritsCD:Start(timer, self.vb.spiritsCount+1)
			end
		end
	end
end

--https://www.wowhead.com/ptr-2/npc=214011/flamespawn
--https://www.wowhead.com/ptr-2/npc=207800/spirit-of-the-kaldorei
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 212422 then--Darkflame Shade
		--timerFyralathsFlameCD:Stop(args.destGUID)
	elseif cid == 207796 then--Burning Colossus
		timerMoltenGauntletCD:Stop(args.destGUID)
		--timerMoltenEruptionCD:Stop(args.destGUID)
	elseif cid == 214012 then--Dark Colossus
		--timerShadowGauntletCD:Stop(args.destGUID)
		--timerShadowCageCD:Stop(args.destGUID)
	end
end
