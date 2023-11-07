local mod	= DBM:NewMod(2519, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(165066)--yeah, this is gonna need to see fight first, too many to guess
mod:SetEncounterID(2677)
--mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20231106000000)
--mod:SetMinSyncRevision(20231106000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 428960 419506 420422 417455 417431 419144 412761 428963 428400 428971 428968 428965 419123 422524 422837 410223 425492 422518",
	"SPELL_CAST_SUCCESS 428954 414186 421937 422935 429875 429876",
	"SPELL_SUMMON 422029",
	"SPELL_AURA_APPLIED 428961 417807 417443 429866 422457 423717 429672",
	"SPELL_AURA_APPLIED_DOSE 417807 417443 429866 429672",
	"SPELL_AURA_REMOVED 425346 419144",
--	"SPELL_AURA_REMOVED_DOSE",
	"SPELL_PERIODIC_DAMAGE 419504 425483",
	"SPELL_PERIODIC_MISSED 419504 425483",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"--Assumed tree is boss 2 and fyrak is boss 1, but can be other way around too
)

--[[

--]]
--TODO, right cast ID for Darkflame cleave to add nameplate CD timer to mob
--TODO, what do with Flamespawn on mythic?
--TODO, what to do with Aflame stacks, it seems like something that may be spammy if stacks up quickly so it's off by default for now
--TODO, tank swap stacks/when to taunt
--TODO, add orbs timer, or remove alert entirely if it's just passive
--TODO, verify https://www.wowhead.com/ptr-2/spell=422457/heart-of-amirdrassil for staging
--TODO, spawn events or IEEU for the big adds in stage 2 for starting initial nameplate timers
--TODO, do more with raging ember and screaming soul?
--TODO, seeds detection/timer in stage 3, it's a big part of things

--TODO, common locals/short names applied to mod by the 14th
--TODO, construct timer table by stage because 10 to 1, fight is gonna use it and it should be ready to go by 14th
--TODO, setup a WCL expression by the 14th
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
--local specWarnFyralathsMark							= mod:NewSpecialWarningTaunt(417443, nil, nil, nil, 1, 2)

local timerDarkflameShadesCD						= mod:NewAITimer(49, 428954, nil, nil, nil, 1, nil, DBM_CORE_L.MYTHIC_ICON)
--local timerFyralathsFlameCD						= mod:NewCDNPTimer(11.8, 428960, nil, nil, nil, 3, nil, DBM_COMMON_L.TANK_ICON)
local timerFirestormCD								= mod:NewAITimer(49, 419506, nil, nil, nil, 3)
local timerWildFireCD								= mod:NewAITimer(49, 420422, nil, nil, nil, 2)
local timerDreamRendCD								= mod:NewAITimer(49, 417455, nil, nil, nil, 3)
local timerBlazeCD									= mod:NewAITimer(49, 414186, nil, nil, nil, 3)
local timerFyralathsBiteCD							= mod:NewAITimer(49, 417431, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddPrivateAuraSoundOption(419060, true, 419506, 1)--Firestorm
mod:AddPrivateAuraSoundOption(426370, true, 426370, 1)--Darkflame Cleave
mod:AddPrivateAuraSoundOption(414187, true, 414186, 1)--Blaze
--mod:AddRangeFrameOption("5/6/10")
--mod:AddInfoFrameOption(407919, true)
--mod:AddSetIconOption("SetIconOnSinSeeker", 335114, true, false, {1, 2, 3})
--Intermission: Amirdrassil in Peril
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26667))
local warnOrbs										= mod:NewCountAnnounce(421937, 3)
local warnShadowflameEruption						= mod:NewCountAnnounce(429866, 4, nil, false, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(429866))--Player

local specWarnIncarnate								= mod:NewSpecialWarningDodge(412761, nil, nil, nil, 2, 2)
local specWarnShadowflameBreath						= mod:NewSpecialWarningDodgeCount(410223, nil, nil, nil, 2, 2)

local timerIncarnateCD								= mod:NewAITimer(49, 412761, nil, nil, nil, 2)
local timerShadowflameBreathCD						= mod:NewAITimer(49, 410223, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)

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

local timerSpiritsCD								= mod:NewAITimer(49, 422029, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerGreaterFirestormCD						= mod:NewAITimer(49, 422518, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)
--local timerMoltenGauntletCD						= mod:NewCDNPTimer(49, 428963, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local timerMoltenEruptionCD						= mod:NewCDNPTimer(49, 428971, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
--local timerShadowGauntletCD						= mod:NewCDNPTimer(49, 428965, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local timerShadowCageCD							= mod:NewCDNPTimer(49, 428968, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerFlamefallCD								= mod:NewAITimer(49, 419123, nil, nil, nil, 2)
local timerShadowflameDevastationCD					= mod:NewAITimer(49, 422524, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddPrivateAuraSoundOption(422520, true, 422518, 1)--Greater Firestorm
mod:AddPrivateAuraSoundOption(428988, true, 428971, 1)--Molten Eruption
mod:AddPrivateAuraSoundOption(428970, true, 428968, 1)--Shadow Cage
--Stage Three: Shadowflame Incarnate
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26670))
local warnBloom										= mod:NewYouAnnounce(423717, 1)
local warnEternalFirestorm							= mod:NewCountAnnounce(422935, 3)
local warnInfernalMaw								= mod:NewStackAnnounce(425492, 3, nil, "Tank|Healer")

--local specWarnEternalFirestorm						= mod:NewSpecialWarningDodgeCount(422935, nil, nil, nil, 2, 2)
local specWarnApocalypseRoar						= mod:NewSpecialWarningCount(422837, nil, nil, nil, 2, 13)
local specWarnInfernalMaw							= mod:NewSpecialWarningDefensive(425492, nil, nil, nil, 1, 2)
--local specWarnInfernalMawTaunt					= mod:NewSpecialWarningTaunt(425492, nil, nil, nil, 1, 2)

local timerEternalFirestormCD						= mod:NewAITimer(49, 422935, nil, nil, nil, 3)
local timerApocalypseroarCD							= mod:NewAITimer(49, 422837, nil, nil, nil, 2)
local timerInfernalMawCD							= mod:NewAITimer(49, 425492, nil, "Tank|healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

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
	timerFirestormCD:Start(1)
	timerWildFireCD:Start(1)
	timerDreamRendCD:Start(1)
	timerFyralathsBiteCD:Start(1)
	if self:IsHard() then
		timerBlazeCD:Start(1)--Heroic/Mythic only
	end

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
		self:EnablePrivateAuraSound(426370, "gathershare", 2)--Darkflame Cleave
		self:EnablePrivateAuraSound(429903, "flameyou", 15)--Flamebound
		self:EnablePrivateAuraSound(429906, "shadowyou", 15)--Shadowbound
		self:EnablePrivateAuraSound(428988, "flameyou", 15)--Molten Eruption (because both molten and shadow are bombs, can't just use bombyou for both, so better to elemental asign)
		self:EnablePrivateAuraSound(428970, "shadowyou", 15)--Shadow Cage (because both molten and shadow are bombs, can't just use bombyou for both, so better to elemental asign)
		timerDarkflameShadesCD:Start(1)
	end
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 428960 then
		DBM:Debug("Fyralaths Flame", 3)--Honestly just here so LUAcheck doesn't complain statement is empty
		--timerFyralathsFlameCD:Start(nil, args.sourceGUID)
	elseif spellId == 419506 then
		self.vb.firestormCount = self.vb.firestormCount + 1
		warnFirestorm:Show(self.vb.firestormCount)
		timerFirestormCD:Start()
	elseif spellId == 420422 then
		self.vb.wildfireCount = self.vb.wildfireCount + 1
		specWarnWildFire:Show(self.vb.wildfireCount)
		specWarnWildFire:Play("aesoon")
		timerWildFireCD:Start()
	elseif spellId == 417455 then
		self.vb.dreamRendCount = self.vb.dreamRendCount + 1
		specWarnDreamRend:Show(self.vb.dreamRendCount)
		specWarnDreamRend:Play("justrun")
		timerDreamRendCD:Start()
	elseif spellId == 417431 then
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then--Boss1 isn't certainty, could be tree, GUID matching used
			specWarnFyralathsBite:Show()
			specWarnFyralathsBite:Play("defensive")
		end
		timerFyralathsBiteCD:Start()
	elseif spellId == 419144 then
		self:SetStage(1.5)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
		warnPhase:Play("phasechange")
		timerFirestormCD:Stop()
		timerWildFireCD:Stop()
		timerDreamRendCD:Stop()
		timerBlazeCD:Stop()--Heroic/Mythic only
		timerDarkflameShadesCD:Stop()--Mythic Only
		timerIncarnateCD:Start(1)
		timerShadowflameBreathCD:Start(1)
	elseif spellId == 412761 then
		specWarnIncarnate:Show()
		specWarnIncarnate:Play("carefly")
		timerIncarnateCD:Start()
	elseif spellId == 422518 then
		self.vb.firestormCount = self.vb.firestormCount + 1
		warnGreaterFirestorm:Show(self.vb.firestormCount)
		timerGreaterFirestormCD:Start()
	elseif spellId == 428963 then
		--timerMoltenGauntletCD:Start(nil, args.sourceGUID)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnMoltenGauntlet:Show()
			specWarnMoltenGauntlet:Play("defensive")
		end
	elseif spellId == 428965 then
		--timerShadowGauntletCD:Start(nil, args.sourceGUID)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnShadowGauntlet:Show()
			specWarnShadowGauntlet:Play("defensive")
		end
	elseif spellId == 428400 and self:AntiSpam(5, 1) then
		warnExplodingCore:Show()
--	elseif spellId == 428971 then
		--timerMoltenEruptionCD:Start(nil, args.sourceGUID)
--	elseif spellId == 428968 then
		--timerShadowCageCD:Start(nil, args.sourceGUID)
	elseif spellId == 419123 then
		self.vb.flameFallCount = self.vb.flameFallCount + 1
		specWarnFlamefall:Show(self.vb.flameFallCount)
		specWarnFlamefall:Play("justrun")
		timerFlamefallCD:Start()
	elseif spellId == 422524 then
		self.vb.shadowflameDevastation = self.vb.shadowflameDevastation + 1
		specWarnShadowflameDevastation:Show(self.vb.shadowflameDevastation)
		specWarnShadowflameDevastation:Play("breathsoon")
		timerShadowflameDevastationCD:Start()
	elseif spellId == 422837 then
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
			timerEternalFirestormCD:Start(3)
			timerApocalypseroarCD:Start(3)
			timerShadowflameBreathCD:Start(3)
			timerInfernalMawCD:Start(3)
			if self:IsHard() then
				timerBlazeCD:Start(3)--Heroic/Mythic only
			end
		end
		self.vb.roarCount = self.vb.roarCount + 1
		specWarnApocalypseRoar:Show(self.vb.roarCount)
		specWarnApocalypseRoar:Play("pushbackincoming")
		timerApocalypseroarCD:Start()
	elseif spellId == 410223 then
		self.vb.shadowflameBreathCount = self.vb.shadowflameBreathCount + 1
		specWarnShadowflameBreath:Show(specWarnShadowflameBreath)
		specWarnShadowflameBreath:Play("breathsoon")
		timerShadowflameBreathCD:Start()--Probably different timers in intermission vs stage 3
	elseif spellId == 425492 then
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then--Boss1 isn't certainty, could be tree, GUID matching used
			specWarnInfernalMaw:Show()
			specWarnInfernalMaw:Play("defensive")
		end
		timerInfernalMawCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 428954 then
		self.vb.darkflameShadesCount = self.vb.darkflameShadesCount + 1
		warnDarkflameShades:Show(self.vb.darkflameShadesCount)
		timerDarkflameShadesCD:Start()
	elseif spellId == 414186 then
		self.vb.blazeCount = self.vb.blazeCount + 1
		warnBlaze:Show(self.vb.blazeCount)
		timerBlazeCD:Start()
	elseif spellId == 421937 or spellId == 429875 or spellId == 429876 then--All 3 types combined for now
		warnOrbs:Show()
	elseif spellId == 422935 then
		self.vb.firestormCount = self.vb.firestormCount + 1
		warnEternalFirestorm:Show()
		timerEternalFirestormCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 422029 and self:AntiSpam(5, 2) then
		self.vb.spiritsCount = self.vb.spiritsCount + 1
		warnSpirits:Show(self.vb.spiritsCount)
		timerSpiritsCD:Start()
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
			if amount % 2 == 1 then -- 1, 3, 5...
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
--		local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
--		local remaining
--		if expireTime then
--			remaining = expireTime-GetTime()
--		end
--		local timer = (self:GetFromTimersTable(allTimers, difficultyName, false, 417431, self.vb.tankCount+1) or 17.9) - 5
--		if (not remaining or remaining and remaining < timer) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
--			specWarnFyralathsMark:Show(args.destName)
--			specWarnFyralathsMark:Play("tauntboss")
--		else
			warnFyralathsMark:Show(args.destName, amount)
--		end
	elseif spellId == 429672 then
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
	elseif spellId == 422457 and self:GetStage(2, 1) then--Heart of Amirdrassil
		self:SetStage(2)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		self.vb.firestormCount = 0
		self.vb.blazeCount = 0
		self.vb.tankCount = 0
		timerIncarnateCD:Stop()
		timerSpiritsCD:Start(2)
		timerGreaterFirestormCD:Start(2)
		timerFlamefallCD:Start(2)
		timerShadowflameDevastationCD:Start(2)
		timerFyralathsBiteCD:Start(2)
		if self:IsHard() then
			timerBlazeCD:Start(2)--Heroic/Mythic only
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 425346 then--Roots of Amirdrassil
		DBM:Debug("Roots over", 2)
	elseif spellId == 419144 and self:GetStage(2, 1) then--Corrupt ending
		self:SetStage(2)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		self.vb.firestormCount = 0
		self.vb.blazeCount = 0
		self.vb.tankCount = 0
		timerIncarnateCD:Stop()
		timerSpiritsCD:Start(2)
		timerGreaterFirestormCD:Start(2)
		timerFlamefallCD:Start(2)
		timerShadowflameDevastationCD:Start(2)
		timerFyralathsBiteCD:Start(2)
		if self:IsHard() then
			timerBlazeCD:Start(2)--Heroic/Mythic only
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

--https://www.wowhead.com/ptr-2/npc=214011/flamespawn
--https://www.wowhead.com/ptr-2/npc=207800/spirit-of-the-kaldorei
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 212422 then--Darkflame Shade
		--timerFyralathsFlameCD:Stop(args.destGUID)
	elseif cid == 207796 then--Burning Colossus
		--timerMoltenGauntletCD:Stop(args.destGUID)
		--timerMoltenEruptionCD:Stop(args.destGUID)
	elseif cid == 214012 then--Dark Colossus
		--timerShadowGauntletCD:Stop(args.destGUID)
		--timerShadowCageCD:Stop(args.destGUID)
	end
end

--https://www.wowhead.com/ptr-2/spell=426368/darkflame-cleave
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if (spellId == 430427 or spellId == 422944) and self:GetStage(3, 1) then--Seeds of Amirdrassil stage triggers?
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
		timerEternalFirestormCD:Start(3)
		timerApocalypseroarCD:Start(3)
		timerShadowflameBreathCD:Start(3)
		timerInfernalMawCD:Start(3)
		if self:IsHard() then
			timerBlazeCD:Start(3)--Heroic/Mythic only
		end
	end
end
