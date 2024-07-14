local mod	= DBM:NewMod(2519, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(204931)

mod:SetEncounterID(2677)
--mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20240206000000)
mod:SetMinSyncRevision(20231208000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 419506 420422 417455 417431 412761 428963 428400 428971 428968 428965 419123 422837 410223 425492 422518 419144",
	"SPELL_CAST_SUCCESS 430441 422935 422524 426368",
	"SPELL_AURA_APPLIED 417807 417443 429866 423717 425494 422517 429903 429906",
	"SPELL_AURA_APPLIED_DOSE 417807 417443 429866 425494",
	"SPELL_AURA_REMOVED 419144",
	"SPELL_PERIODIC_DAMAGE 419504 425483",
	"SPELL_PERIODIC_MISSED 419504 425483",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

--[[
(ability.id = 419506 or ability.id = 420422 or ability.id = 417455 or ability.id = 417431 or ability.id = 419144 or ability.id = 412761 or ability.id = 428963 or ability.id = 428400 or ability.id = 428971 or ability.id = 428968 or ability.id = 428965 or ability.id = 419123 or ability.id = 422837 or ability.id = 410223 or ability.id = 425492 or ability.id = 422518) and type = "begincast"
 or (ability.id = 430441 or ability.id = 414186 or ability.id = 421937 or ability.id = 422935 or ability.id = 429875 or ability.id = 429876 or ability.id = 422524 or ability.id = 426368 or ability.id = 414186 or ability.id = 422032) and type = "cast"
 or ability.id = 419144 and (type = "applybuff" or type = "removebuff")
 or (ability.id = 414187 or ability.id = 425525 or ability.id = 428988 or ability.id = 428970) and type = "applydebuff"
 or ability.id = 422517 and type = "applybuff"
 or ability.id = 417807 and type = "applydebuff"
--]]
--TODO, tank swap stacks/when to taunt in stage 3, or maybe periods of time it shoudln't happen on mythic (if holding seed and shit going on, don't distract with taunt warning type deal)
--General
local warnPhase										= mod:NewPhaseChangeAnnounce(2, 2, nil, nil, nil, nil, nil, 2)

local specWarnGTFO									= mod:NewSpecialWarningGTFO(419504, nil, nil, nil, 1, 8)

local timerPhaseCD									= mod:NewStageTimer(60, 408330)
--local berserkTimer								= mod:NewBerserkTimer(600)
--Stage One: The Dream Render
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26666))
local warnDarkflameShades							= mod:NewCountAnnounce(430441, 2, nil, false)
local warnDarkflameCleave							= mod:NewCountAnnounce(426368, 4, nil, nil, 845)
local warnFirestorm									= mod:NewCountAnnounce(419506, 4, nil, nil, nil, nil, nil, 2)--icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter
local warnBlaze										= mod:NewCountAnnounce(414186, 3, nil, nil, nil, nil, nil, 2)
local warnAflame									= mod:NewCountAnnounce(417807, 3, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(417807))--Player
local warnFyralathsMark								= mod:NewStackAnnounce(417443, 3, nil, "Tank|Healer")

local specWarnWildFire								= mod:NewSpecialWarningCount(420422, nil, nil, nil, 2, 2)
local specWarnDreamRend								= mod:NewSpecialWarningRunCount(417455, nil, nil, nil, 4, 2)
local specWarnFyralathsBite							= mod:NewSpecialWarningDefensive(417431, nil, nil, nil, 1, 2)
local specWarnFyralathsMark							= mod:NewSpecialWarningTaunt(417443, nil, 37454, nil, 1, 2)

local timerDarkflameShadesCD						= mod:NewCDCountTimer(49, 430441, nil, false, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerDarkflameCleaveCD						= mod:NewCDCountTimer(49, 426368, DBM_COMMON_L.GROUPSOAKS.." (%s)", nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)--Shortname "Soaks"
local timerDarkflameCleave							= mod:NewCastCountTimer(4, 426368, DBM_COMMON_L.GROUPSOAKS.." (%s)", nil, nil, 5, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerFirestormCD								= mod:NewCDCountTimer(49, 419506, nil, nil, nil, 3)
local timerWildFireCD								= mod:NewCDCountTimer(49, 420422, nil, nil, nil, 2)
local timerDreamRendCD								= mod:NewCDCountTimer(49, 417455, nil, nil, nil, 3)--"Pull" short text. MIght change to "Pull in" though if it's unclear to users
local timerBlazeCD									= mod:NewCDCountTimer(49, 414186, nil, nil, nil, 3)
local timeAFlameCD									= mod:NewCDCountTimer(49, 417807, nil, "RemoveMagic", 2, 5, nil, DBM_COMMON_L.MAGIC_ICON)
local timerFyralathsBiteCD							= mod:NewCDCountTimer(49, 417431, DBM_COMMON_L.FRONTAL.." (%s)", nil, 2, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddPrivateAuraSoundOption(419060, true, 419506, 1)--Firestorm
mod:AddPrivateAuraSoundOption(426370, true, 426370, 1)--Darkflame Cleave
mod:AddPrivateAuraSoundOption(414187, true, 414186, 1)--Blaze
--Intermission: Amirdrassil in Peril
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26667))
local warnShadowflameOrbs							= mod:NewCountAnnounce(421937, 2)
local warnShadowflameEruption						= mod:NewCountAnnounce(429866, 4, nil, false, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(429866))--Player

local specWarnIncarnate								= mod:NewSpecialWarningDodgeCount(412761, nil, 374763, nil, 2, 2)
local specWarnShadowflameBreath						= mod:NewSpecialWarningDodgeCount(410223, nil, 17088, nil, 2, 2)
local specWarnFlamebound							= mod:NewSpecialWarningYou(429903, nil, nil, nil, 1, 15, 4)
local specWarnShadowbound							= mod:NewSpecialWarningYou(429906, nil, nil, nil, 1, 15, 4)

local timerCorrupt									= mod:NewCastTimer(13, 419144, nil, nil, nil, 6)
local timerShadowflameOrbsCD						= mod:NewCDCountTimer(49, 421937, nil, nil, nil, 5)
local timerIncarnateCD								= mod:NewCDCountTimer(8.5, 412761, 374763, nil, nil, 6)--Short name "Lift off"
--local timerIncarnate								= mod:NewCastTimer(8.5, 412761, 374763, nil, nil, 2)
local timerShadowflameBreathCD						= mod:NewCDCountTimer(49, 410223, 17088, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)

--mod:AddPrivateAuraSoundOption(429903, true, 429903, 1)--Flamebound
--mod:AddPrivateAuraSoundOption(429906, true, 429906, 1)--Shadowbound
--Stage Two: Children of the Stars
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26668))
local warnSpirits									= mod:NewCountAnnounce(422032, 3, nil, nil, 263222)
local warnGreaterFirestorm							= mod:NewCountAnnounce(422518, 3)
local warnExplodingCore								= mod:NewCastAnnounce(428400, 4)
local warnMythicDebuffs								= mod:NewAnnounce("warnMythicDebuffs", 3, 428970, nil, nil, nil, 428970)

local specWarnMoltenGauntlet						= mod:NewSpecialWarningDefensive(428963, nil, nil, nil, 1, 2)
local specWarnShadowGauntlet						= mod:NewSpecialWarningDefensive(428965, nil, nil, nil, 1, 2)
local specWarnFlamefall								= mod:NewSpecialWarningRunCount(419123, nil, nil, nil, 4, 2)
local specWarnShadowflameDevastation				= mod:NewSpecialWarningDodgeCount(422524, nil, 406227, nil, 2, 2)--Short name "Deep Breath"

local timerSpiritsCD								= mod:NewCDCountTimer(49, 422032, 263222, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)--Shortname "Spirits"
local timerGreaterFirestormCD						= mod:NewCDCountTimer(49, 422518, 419506, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)
local timerMoltenGauntletCD							= mod:NewCDNPTimer(11.7, 428963, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local timerMoltenEruptionCD							= mod:NewCDNPTimer(23, 428971, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerShadowGauntletCD							= mod:NewCDNPTimer(11.7, 428965, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local timerShadowCageCD								= mod:NewCDNPTimer(23, 428968, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerMythicDebuffs							= mod:NewTimer(45, "timerMythicDebuffs", 428970, nil, nil, 3, nil, nil, nil, nil, nil, nil, nil, 428970)--Key matched to BW
local timerFlamefallCD								= mod:NewCDCountTimer(49, 419123, nil, nil, nil, 2)
local timerShadowflameDevastationCD					= mod:NewCDCountTimer(49, 422524, 406227, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddPrivateAuraSoundOption(422520, true, 422518, 1)--Greater Firestorm
mod:AddPrivateAuraSoundOption(428988, true, 428971, 1)--Molten Eruption
mod:AddPrivateAuraSoundOption(428970, true, 428968, 1)--Shadow Cage
--Stage Three: Shadowflame Incarnate
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26670))
local warnBloom										= mod:NewYouAnnounce(423717, 1)
local warnInfernalMaw								= mod:NewStackAnnounce(425492, 3, nil, "Tank|Healer")
local warnEternalFirestorm							= mod:NewCountAnnounce(422935, 4)
local warnEternalFirestormSwirl						= mod:NewCountAnnounce(402736, 3, nil, nil, 143413)--Short name "Swirl" 143413

local specWarnApocalypseRoar						= mod:NewSpecialWarningCount(422837, nil, 140459, nil, 2, 13)
local specWarnInfernalMaw							= mod:NewSpecialWarningDefensive(425492, nil, nil, nil, 1, 2)
local specWarnInfernalMawTaunt						= mod:NewSpecialWarningTaunt(425492, nil, nil, nil, 1, 2)

local timerApocalypseroarCD							= mod:NewCDCountTimer(49, 422837, 140459, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerInfernalMawCD							= mod:NewCDCountTimer(49, 425492, nil, "Tank|healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerEternalFirestormCD						= mod:NewCDCountTimer(41, 422935, 419506, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)
local timerEternalFirestormSwirlCD					= mod:NewCDCountTimer(41, 402736, 143413, nil, nil, 3)--short name "Swirl"
local timerCorruptedSeedsCD							= mod:NewCDCountTimer(41, 430048, nil, nil, nil, 5, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddPrivateAuraSoundOption(423601, true, 423601, 1)--Seed of Amirdrassil
mod:AddPrivateAuraSoundOption(430048, true, 430048, 1)--Corrupted Seed
mod:AddPrivateAuraSoundOption(425525, true, 422935, 1)--Eternal Firestorm

mod.vb.darkflameCleaveCount = 0
mod.vb.firestormCount = 0--reused for empowered version
mod.vb.wildfireCount = 0
mod.vb.dreamRendCount = 0
mod.vb.blazeCount = 0
mod.vb.aflameCount = 0
mod.vb.tankCount = 0--Reused for tank ability in all stages
--Intermission
mod.vb.shadowflameBreathCount = 0
mod.vb.orbsCount = 0
--Stage 2
mod.vb.spiritsCount = 0
mod.vb.flameFallCount = 0
mod.vb.shadowflameDevastation = 0
mod.vb.incarnCount = 0
mod.vb.debuffsCount = 0
mod.vb.addsAlive = 0
--Stage 3
mod.vb.roarCount = 0
mod.vb.swirlCount = 0

local allTimers = {
	[1.5] = {
		--Blaze (Mythic Only intermission Blaze)
		[4141862] = {28, 8},
		--Shadowflame Orbs
		[421937] = {3.5, 6, 6},
	},
	[2] = {--Same in all difficulties, minus Aflame
		--Flamefall
		[420422] = {5.8, 75, 79.9},
		--Fyr'alath's Bite
		[417431] = {17.9, 11.0, 60.0, 11.0, 11.0, 58.0, 11.0, 11.0},
		--Greater Firestorm
		[422518] = {35.8, 79.9, 80.0},
		--Shadowflame Devastation
		[422524] = {58.8, 80},
		--Spirits of the Kaldorai
		[422032] = {20, 20, 20, 25, 26, 25, 25, 25},
		--Blaze (Heroic+ only)
		[414186] = {20, 14.9, 25, 30, 26.9, 23, 30, 25},
		--Blaze (Mythic only)
		[4141862] = {20, 14.9, 25, 33.9, 22.9, 23, 33.9, 21},
		--Incarnate
		[412761] = {44.6, 80.0, 79.5},
		--Aflame (Heroic)
		[4178072] = {27.1, 16.0, 58.0, 16.0, 64.1, 15.9, 13.5},
		--Aflame (Normal)
		[4178071] = {35.4, 74.0, 80.0},
	},
	[3] = {
		--Eternal Firestorm Embers
		[402736] = {3.8, 6.4, 11.5, 11.5, 11.5, 5, 6.4, 11.5, 11.5, 11.5, 5, 6.4, 11.5, 11.5, 11.5, 5, 6.4, 11.5, 11.5, 11.5, 5, 6.4, 11.5, 11.5, 11.5},--Effectively 5, 6.4, 11.5, 11.5, 11.5 repeating, but with variance and no way to resync when it strays a little
	},
}

local function blazeLoop(self)
	self.vb.blazeCount = self.vb.blazeCount + 1
	warnBlaze:Show(self.vb.blazeCount)
	warnBlaze:Play("farfromline")
	local stage = self.vb.phase
	local timer
	if stage == 1 then
		if self:IsMythic() then
			timer = self.vb.blazeCount % 2 == 0 and 34 or 27
		else
			timer = self.vb.blazeCount % 2 == 0 and 29.5 or 23.9
		end
	elseif stage == 1.5 or stage == 2 then--Still best sequenced sine it's larger pattern
		timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, self:IsMythic() and 4141862 or 414186, self.vb.blazeCount+1)
	else--Stage 3
		timer = self:IsMythic() and (self.vb.blazeCount % 2 == 0 and 33 or 13) or (self.vb.blazeCount % 2 == 0 and 28 or 13)
	end
	if timer then
		timerBlazeCD:Start(timer, self.vb.blazeCount+1)
		self:Schedule(timer, blazeLoop, self)
	end
end

local function eternalFireLoop(self)
	self.vb.firestormCount = self.vb.firestormCount + 1
	warnEternalFirestorm:Show(self.vb.firestormCount)
	local timer = self:IsMythic() and 46 or 41
	timerEternalFirestormCD:Start(timer, self.vb.firestormCount+1)
	self:Schedule(timer, eternalFireLoop, self)
end

local function eternalFireSwirlLoop(self)
	self.vb.swirlCount = self.vb.swirlCount + 1
	warnEternalFirestormSwirl:Show(self.vb.swirlCount)
	local timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, 402736, self.vb.swirlCount+1)
	if timer then
		timerEternalFirestormSwirlCD:Start(timer, self.vb.swirlCount+1)
		self:Schedule(timer, eternalFireSwirlLoop, self)
	end
end

--Countmod inherits firestorm count on initial then iterates on loop
local function mythicDebuffs(self)
	self.vb.debuffsCount = self.vb.debuffsCount + 1
	warnMythicDebuffs:Show(self.vb.debuffsCount)
	timerMythicDebuffs:Start(23, self.vb.debuffsCount+1)
	self:Schedule(23, mythicDebuffs, self)
end

local function orbsLoop(self)
	self.vb.orbsCount = self.vb.orbsCount + 1
	warnShadowflameOrbs:Show(self.vb.orbsCount)
	local timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, 421937, self.vb.orbsCount+1)
	if timer then
		timerShadowflameOrbsCD:Start(timer, self.vb.orbsCount+1)
		self:Schedule(timer, orbsLoop, self)
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.darkflameCleaveCount = 0
	self.vb.firestormCount = 0
	self.vb.wildfireCount = 0
	self.vb.blazeCount = 0
	self.vb.aflameCount = 0
	self.vb.tankCount = 0
	self.vb.shadowflameBreathCount = 0
	self.vb.spiritsCount = 0
	self.vb.flameFallCount = 0
	self.vb.shadowflameDevastation = 0
	self.vb.roarCount = 0
	self.vb.incarnCount = 0
	self.vb.dreamRendCount = 0
	self.vb.swirlCount = 0

	--Hopefully the API doesn't mind registering 16 private auras at same time on pull
	--It's not DBMs fault designers got carried away :D
	self:EnablePrivateAuraSound(419060, "runout", 2)--Firestorm
	self:EnablePrivateAuraSound(414187, "lineyou", 17)--Blaze
	self:EnablePrivateAuraSound(421825, "lineyou", 17, 414187)--Register Additional blaze Ids (6 in total)
	self:EnablePrivateAuraSound(421826, "lineyou", 17, 414187)--Register Additional blaze Ids (6 in total)
	self:EnablePrivateAuraSound(421827, "lineyou", 17, 414187)--Register Additional blaze Ids (6 in total)
	self:EnablePrivateAuraSound(421828, "lineyou", 17, 414187)--Register Additional blaze Ids (6 in total)
	self:EnablePrivateAuraSound(421829, "lineyou", 17, 414187)--Register Additional blaze Ids (6 in total)
	self:EnablePrivateAuraSound(422520, "runout", 2)--Greater Firestorm
	self:EnablePrivateAuraSound(423601, "seedyou", 15)--Seed of Amirdrassil
	self:EnablePrivateAuraSound(430048, "seedyou", 15)--Corrupted Seed
	self:EnablePrivateAuraSound(425525, "runout", 2)--Eternal Firestorm
	if self:IsMythic() then
		self:EnablePrivateAuraSound(426370, "gathershare", 2)--Darkflame Cleave
--		self:EnablePrivateAuraSound(429903, "flameyou", 15)--Flamebound
--		self:EnablePrivateAuraSound(429906, "shadowyou", 15)--Shadowbound
		self:EnablePrivateAuraSound(428988, "flameyou", 15)--Molten Eruption (because both molten and shadow are bombs, can't just use bombyou for both, so better to elemental asign)
		self:EnablePrivateAuraSound(428970, "shadowyou", 15)--Shadow Cage (because both molten and shadow are bombs, can't just use bombyou for both, so better to elemental asign)
		timerWildFireCD:Start(4, 1)
		timerDarkflameShadesCD:Start(6.4, 1)--Bite minus 2.5
		timeAFlameCD:Start(7.9, 1)
		timerFyralathsBiteCD:Start(8.9, 1)
		timerFirestormCD:Start(12.5, 1)
		timerDarkflameCleaveCD:Start(28, 1)
		timerBlazeCD:Start(36, 1)--Heroic/Mythic only
		self:Schedule(36, blazeLoop, self)
		timerDreamRendCD:Start(41.9, 1)
	else
		timerWildFireCD:Start(3.9, 1)
		timeAFlameCD:Start(self:IsHard() and 7.9 or 12, 1)
		timerFyralathsBiteCD:Start(8.9, 1)
		timerFirestormCD:Start(12.9, 1)
		timerDreamRendCD:Start(41.9, 1)
		if self:IsHeroic() then
			timerBlazeCD:Start(32, 1)--Heroic/Mythic only
			self:Schedule(32, blazeLoop, self)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 419506 then
		self.vb.firestormCount = self.vb.firestormCount + 1
		warnFirestorm:Show(self.vb.firestormCount)
		warnFirestorm:Play("watchstep")
		timerFirestormCD:Start(self:IsMythic() and 61 or 53.4, self.vb.firestormCount+1)
	elseif spellId == 420422 then
		self.vb.wildfireCount = self.vb.wildfireCount + 1
		specWarnWildFire:Show(self.vb.wildfireCount)
		specWarnWildFire:Play("aesoon")
		local timer
		if self.vb.wildfireCount == 1 then--One off cast
			timer = self:IsMythic() and 38 or 24
		else--It's just a static repeating timer
			timer = self:IsMythic() and 61 or 53.4
		end
		timerWildFireCD:Start(timer, self.vb.wildfireCount+1)
	elseif spellId == 417455 then
		self.vb.dreamRendCount = self.vb.dreamRendCount + 1
		specWarnDreamRend:Show(self.vb.dreamRendCount)
		specWarnDreamRend:Play("justrun")
		timerDreamRendCD:Start(self:IsMythic() and 61 or 53.4, self.vb.dreamRendCount+1)
	elseif spellId == 417431 then
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then--Boss1 isn't certainty, could be tree, GUID matching used
			specWarnFyralathsBite:Show()
			specWarnFyralathsBite:Play("defensive")
		end
		local timer
		if self:GetStage(2) then
			timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, spellId, self.vb.tankCount+1)
		else--Stage 1
			--31, 15, 15 repeating on mythic, 23.4, 15.0, 15.0 repeating non mythc
			if self.vb.tankCount % 3 == 0 then
				timer = self:IsMythic() and 31 or 23.4
			else
				timer = 15
			end
		end
		if timer then
			timerFyralathsBiteCD:Start(timer, self.vb.tankCount+1)
		end
	elseif spellId == 419144 then--Corrupt
		timerShadowflameOrbsCD:Start(3.5, 1)
		self:Schedule(3.5, orbsLoop, self)
	elseif spellId == 412761 then
		self.vb.incarnCount = self.vb.incarnCount + 1
		specWarnIncarnate:Show(self.vb.incarnCount)
		if self:GetStage(1) then
			specWarnIncarnate:Play("carefly")--Stage 1, it's transition which comes with knockback
			self:SetStage(1.5)
			self.vb.addsAlive = 0
			self.vb.orbsCount = 0
			self.vb.blazeCount = 0
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
			warnPhase:Play("phasechange")
			timerFirestormCD:Stop()
			timerWildFireCD:Stop()
			timerDreamRendCD:Stop()
			timerFyralathsBiteCD:Stop()
			timerBlazeCD:Stop()--Heroic/Mythic only
			self:Unschedule(blazeLoop)
			timerDarkflameShadesCD:Stop()--Mythic Only
			timerDarkflameCleaveCD:Stop()--Mythic Only
			timerCorrupt:Start(13)
			if self:IsMythic() then
				timerBlazeCD:Start(28, 1)--Mythic only
				self:Schedule(28, blazeLoop, self)
			end
		else
			if self.vb.incarnCount == 3 then--only two sets of adds, 3rd one is only a knockback cause he's going dragon again
				specWarnIncarnate:Play("carefly")
			else
				specWarnIncarnate:Play("mobsoon")--Stage 2, he's lifting off for big adds
			end
			local timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, spellId, self.vb.incarnCount+1)
			if timer then
				timerIncarnateCD:Start(timer, self.vb.incarnCount+1)
			end
		end
	elseif spellId == 422518 then
		self.vb.firestormCount = self.vb.firestormCount + 1
		warnGreaterFirestorm:Show(self.vb.firestormCount)
		local timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, spellId, self.vb.firestormCount+1)
		if timer then
			timerGreaterFirestormCD:Start(timer, self.vb.firestormCount+1)
		end
--		timerIncarnate:Start()--Always cast after
	elseif spellId == 428963 then
		timerMoltenGauntletCD:Start(nil, args.sourceGUID)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnMoltenGauntlet:Show()
			specWarnMoltenGauntlet:Play("defensive")
		end
	elseif spellId == 428965 then--Not verified yet
		timerShadowGauntletCD:Start(nil, args.sourceGUID)
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
		local timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, spellId, self.vb.flameFallCount+1)
		if timer then
			timerFlamefallCD:Start(timer, self.vb.flameFallCount+1)
		end
	elseif spellId == 422837 then
		self.vb.roarCount = self.vb.roarCount + 1
		specWarnApocalypseRoar:Show(self.vb.roarCount)
		specWarnApocalypseRoar:Play("pushbackincoming")
		timerApocalypseroarCD:Start(self:IsMythic() and 46 or 40.9, self.vb.roarCount+1)
		if self:IsMythic() then
			timerCorruptedSeedsCD:Start(18, self.vb.roarCount)
		end
	elseif spellId == 410223 then
		self.vb.shadowflameBreathCount = self.vb.shadowflameBreathCount + 1
		specWarnShadowflameBreath:Show(self.vb.shadowflameBreathCount)
		specWarnShadowflameBreath:Play("breathsoon")
		timerShadowflameBreathCD:Start(self:IsMythic() and 46 or 40.9, self.vb.shadowflameBreathCount+1)
	elseif spellId == 425492 then
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then--Boss1 isn't certainty, could be tree, GUID matching used
			specWarnInfernalMaw:Show()
			specWarnInfernalMaw:Play("defensive")
		end
		--Mythic 30, 3, 10, 3 repeating
		--Non Mythic 25, 3, 10, 3 repeating
		local timer
		if self.vb.tankCount % 4 == 0 then
			timer = self:IsMythic() and 30 or 25
		elseif self.vb.tankCount % 4 == 2 then
			timer = 10
		else--cast 1, and cast 3
			timer = 3
		end
		timerInfernalMawCD:Start(timer, self.vb.tankCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 430441 then
		warnDarkflameShades:Show(self.vb.tankCount+1)
		local timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, spellId, self.vb.tankCount+2)
		if timer then
			timerDarkflameShadesCD:Start(timer, self.vb.tankCount+2)
		end
	elseif spellId == 422524 then
		self.vb.shadowflameDevastation = self.vb.shadowflameDevastation + 1
		specWarnShadowflameDevastation:Show(self.vb.shadowflameDevastation)
		specWarnShadowflameDevastation:Play("breathsoon")
		local timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, spellId, self.vb.shadowflameDevastation+1)
		if timer then
			timerShadowflameDevastationCD:Start(timer, self.vb.shadowflameDevastation+1)
		end
	elseif spellId == 426368 then
		self.vb.darkflameCleaveCount = self.vb.darkflameCleaveCount + 1
		warnDarkflameCleave:Show(self.vb.darkflameCleaveCount)
		timerDarkflameCleave:Start(4, self.vb.darkflameCleaveCount)
		timerDarkflameCleaveCD:Start(61, self.vb.darkflameCleaveCount+1)
	elseif spellId == 422935 then--Eternal Firestorm
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
			timerEternalFirestormCD:Start(18, 1)
			self:Schedule(18, eternalFireLoop, self)
			timerApocalypseroarCD:Start(34, 1)
			if self:IsHard() then
				timerBlazeCD:Start(12, 1)--Heroic/Mythic only
				self:Schedule(12, blazeLoop, self)
				if self:IsMythic() then
					timerEternalFirestormCD:Start(3.8, 1)
					self:Schedule(3.8, eternalFireSwirlLoop, self)
				end
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 417807 then
		local amount = args.amount or 1
		if amount == 1 and self:AntiSpam(6, 2) then
			self.vb.aflameCount = self.vb.aflameCount + 1
			local timer
			if self:GetStage(2, 1) then--1 and 1.5 (ie < 2)
				timer = self:IsHard() and 8 or 12
			else
				local checkedId = self:IsHard() and 4178072 or 4178071
				timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, checkedId, self.vb.aflameCount+1)
			end
			if timer then
				timeAFlameCD:Start(timer, self.vb.aflameCount+1)
			end
		end
		if args:IsPlayer() then
			if amount % 4 == 1 then --1, 5, 9, etc...
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
		local timer = (self:GetFromTimersTable(allTimers, false, false, 417431, self.vb.tankCount+1) or 15) - 5
		if amount >= 2 and (not remaining or remaining and remaining < timer) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
			specWarnFyralathsMark:Show(args.destName)
			specWarnFyralathsMark:Play("tauntboss")
		else
			warnFyralathsMark:Show(args.destName, amount)
		end
	elseif spellId == 425494 then
		local amount = args.amount or 1
		if amount % 4 == 0 then--if amount >= 4 and (amount % 2 == 0) then (maybe use this instead of every 4 feels too infrequent)
			if not args:IsPlayer() then
				specWarnInfernalMawTaunt:Show(args.destName)
				specWarnInfernalMawTaunt:Play("tauntboss")
			else
				warnInfernalMaw:Show(args.destName, amount)
			end
		end
	elseif spellId == 423717 and args:IsPlayer() then
		warnBloom:Show()
--	elseif spellId == 388479 and self:AntiSpam(5, 5) then
--		self.vb.spiritsCount = self.vb.spiritsCount + 1
--		warnSpirits:Show(self.vb.spiritsCount)
--		timerSpiritsCD:Start()
	elseif spellId == 422517 and self:AntiSpam(3, args.destGUID) then
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 207796 then--Burning Colossus
			self.vb.addsAlive = self.vb.addsAlive + 1
			timerMoltenGauntletCD:Start(6.2, args.destGUID)
		elseif cid == 214012 then--Dark Colossus
			self.vb.addsAlive = self.vb.addsAlive + 1
			timerShadowGauntletCD:Start(6.2, args.destGUID)
			--If starting timer object here, no reason for mythic check
			self.vb.debuffsCount = 0
			timerMythicDebuffs:Start(6.9, 1)
			self:Schedule(6.9, mythicDebuffs, self)
		end
	elseif spellId == 429903 and args:IsPlayer() then
		specWarnFlamebound:Show()
		specWarnFlamebound:Play("flameyou")
	elseif spellId == 429906 and args:IsPlayer() then
		specWarnShadowbound:Show()
		specWarnShadowbound:Play("shadowyou")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 419144 and self:GetStage(2, 1) then--Corrupt ending, also appies 426815 when this ends
		self:SetStage(2)
		timerBlazeCD:Stop()
		self:Unschedule(blazeLoop)
		timerShadowflameOrbsCD:Stop()
		self:Unschedule(orbsLoop)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		self.vb.firestormCount = 0
		self.vb.blazeCount = 0
		self.vb.tankCount = 0
		self.vb.incarnCount = 0
		self.vb.aflameCount = 0
		timerFlamefallCD:Start(5.8, 1)

		timerFyralathsBiteCD:Start(17.9, 1)
		timerSpiritsCD:Start(19.1, 1)
		timeAFlameCD:Start(27.1, 1)
		timerGreaterFirestormCD:Start(34.9, 1)
		timerIncarnateCD:Start(43.4, 1)
		timerShadowflameDevastationCD:Start(57.9, 1)
		timerPhaseCD:Start(215, 3)
		if self:IsHard() then
			timerBlazeCD:Start(20.7, 1)--Heroic/Mythic only
			self:Schedule(20.7, blazeLoop, self)
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
			local timer = self:GetFromTimersTable(allTimers, false, self.vb.phase, 422032, self.vb.spiritsCount+1)
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
		self.vb.addsAlive = self.vb.addsAlive - 1
		timerMoltenGauntletCD:Stop(args.destGUID)
		--timerMoltenEruptionCD:Stop(args.destGUID)
		if self.vb.addsAlive == 0 then
			timerMythicDebuffs:Stop()
			self:Unschedule(mythicDebuffs)
		end
	elseif cid == 214012 then--Dark Colossus
		self.vb.addsAlive = self.vb.addsAlive - 1
		timerShadowGauntletCD:Stop(args.destGUID)
		--timerShadowCageCD:Stop(args.destGUID)
		if self.vb.addsAlive == 0 then
			timerMythicDebuffs:Stop()
			self:Unschedule(mythicDebuffs)
		end
	end
end
