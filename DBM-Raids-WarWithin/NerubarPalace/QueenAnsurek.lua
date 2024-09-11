local mod	= DBM:NewMod(2602, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "story,lfr,normal,heroic,mythic"

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(227323)
mod:SetEncounterID(2922)
mod:SetUsedIcons(1, 2)
mod:SetHotfixNoticeRev(20240910000000)
mod:SetMinSyncRevision(20240910000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 437592 456623 437417 439814 440899 440883 437093 447076 447411 450191 449940 449986 447950 448458 448147 451600 455374 443888 445422 444829 445021 438976 443325 443336",
	"SPELL_CAST_SUCCESS 439299 449986",
	"SPELL_AURA_APPLIED 437586 441958 436800 440885 447207 453990 464056 447967 462558 451278 443903 455387 445880 445152 438974 443656 443726 443342 451832 464638 441556 455404",
	"SPELL_AURA_APPLIED_DOSE 449236 445880 443726 443342 464638 441556",
	"SPELL_AURA_REMOVED 437586 447207 453990 462558 451278 443903 455387 445152 443656",
	"SPELL_PERIODIC_DAMAGE 443403",
	"SPELL_PERIODIC_MISSED 443403",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--NOTE, 451320 wasn't used
--TODO, figure out how reactive toxin works and make mod less crappy
--TODO, figure out Silken Tomb targetting and make mod less crappy
--TODO, figure out Liquefy targetting and make mod less crappy
--TODO, Phase 2 Entropic Conduit mythic mechanics
--TODO, add Gloom Orb nameplate timer?
--TODO, figure out a proper way to warn for Ousting Fragments. how far are they cast from Chamber guardian. maybe scoped alert for players within x yards of caster?
--TODO, Dark Detonation nameplate cast bar?
--TODO, appropriate stack high warning for https://www.wowhead.com/beta/spell=449236/caustic-fangs
--TODO, correct detection for https://www.wowhead.com/beta/spell=444502/conduit-collapse
--TODO, use https://www.wowhead.com/beta/spell=445818/frothing-gluttony for anything?
--TODO, track player version of https://www.wowhead.com/beta/spell=445877/froth-vapor ?
--TODO, infoframe or more for https://www.wowhead.com/beta/spell=445013/dark-barrier ? depends on mob count
--TODO, add auto marking?
--TODO, https://www.wowhead.com/beta/spell=441865/royal-shackles alert too?
--TODO, figure out shortnames later. Right now mod is a bit of chaos til boss is actually pulled
--[[
(ability.id = 437592 or ability.id = 456623 or ability.id = 437417 or ability.id = 439814 or ability.id = 440899 or ability.id = 440883 or ability.id = 437093 or ability.id = 447411 or ability.id = 450191 or ability.id = 448458 or ability.id = 448147 or ability.id = 451600 or ability.id = 455374 or ability.id = 443888 or ability.id = 445422 or ability.id = 444829 or ability.id = 445021 or ability.id = 438976 or ability.id = 443325 or ability.id = 443336) and type = "begincast"
or (ability.id = 439299) and type = "cast"
or (ability.id = 447076 or ability.id = 449940 or ability.id = 449986) and type = "begincast"
or ability. id = 447207 and type = "removebuff"
 or stoppedAbility.id = 449940 or stoppedAbility.id = 455374
--]]
--General Stuff
local warnPhase									= mod:NewPhaseChangeAnnounce(0, nil, nil, nil, nil, nil, 2)

local specWarnGTFO								= mod:NewSpecialWarningGTFO(441958, nil, nil, nil, 1, 8)
--Stage One: A Queen's Venom
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28754))
local warnReactiveToxin							= mod:NewTargetAnnounce(437592, 3)
local warnSilkenTomb							= mod:NewCountAnnounce(439814, 2)
local warnFrothyToxin							= mod:NewCountAnnounce(464638, 3, nil, false, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(464638))--Player
local warnReactionVapor							= mod:NewCountAnnounce(441556, 3, nil, false, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(441556))--Player

local specWarnReactiveToxin						= mod:NewSpecialWarningMoveAway(437592, nil, nil, nil, 1, 2)
local yellReactiveToxin							= mod:NewShortYell(437592)
local yellReactiveToxinFades					= mod:NewShortFadesYell(437592)
local specWarnConcentratedToxin					= mod:NewSpecialWarningYou(451278, nil, nil, nil, 1, 2)
local yellConcentratedToxin						= mod:NewShortYell(451278)
local yellConcentratedToxinFades				= mod:NewShortFadesYell(451278)
local specWarnVenomNova							= mod:NewSpecialWarningCount(437417, nil, nil, nil, 2, 2)--not soak warning because it's used for both soak and avoid
--local specWarnSilkenTomb						= mod:NewSpecialWarningYou(439814, nil, nil, nil, 1, 2)
--local yellSilkenTomb							= mod:NewShortYell(439814)
local specWarnLiquefy							= mod:NewSpecialWarningDefensive(440899, nil, nil, nil, 1, 2)
local specWarnLiquefyTaunt						= mod:NewSpecialWarningTaunt(440899, nil, nil, nil, 1, 2)
--local specWarnLiquefyNonTank					= mod:NewSpecialWarningYou(440885, nil, nil, nil, 1, 2)--No idea, wording changed since adding it. does liquify tank just get both debuffs?
local specWarnFeast								= mod:NewSpecialWarningDefensive(437093, nil, nil, nil, 1, 2)
local specWarnFeastTaunt						= mod:NewSpecialWarningTaunt(437093, nil, nil, nil, 1, 2)
local specWarnWebBlades							= mod:NewSpecialWarningDodgeCount(439299, nil, nil, nil, 2, 2)

local timerReactiveToxinCD						= mod:NewCDCountTimer(49, 437592, nil, nil, nil, 3)
local timerVenomNovaCD							= mod:NewCDCountTimer(49, 437417, nil, nil, nil, 3)
local timerSilkenTombCD							= mod:NewCDCountTimer(49, 439814, nil, nil, nil, 3)
local timerLiquefyCD							= mod:NewCDCountTimer(49, 440899, DBM_COMMON_L.TANKCOMBO.." (%s)", "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local timerFeastCD							= mod:NewCDCountTimer(49, 437093, nil, false, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Combine with liquefy if it is a combo
local timerWebBladesCD							= mod:NewCDCountTimer(49, 439299, nil, nil, nil, 3)
local timerPredationCD							= mod:NewIntermissionCountTimer(140, 447207, nil, nil, nil, 6)

--mod:AddSetIconOption("SetIconOnSinSeeker", 335114, true, 0, {1, 2, 3})
--mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)
--Intermission: The Spider's Web
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28755))
local specWarnWrest							= mod:NewSpecialWarningCount(447411, nil, nil, nil, 2, 12)

local timerWrestCD							= mod:NewCDCountTimer(49, 447411, nil, nil, nil, 3)

mod:AddInfoFrameOption(447076, true)

--Stage Two: Royal Ascension
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28756))
--Mythic Stuff here

mod:AddNamePlateOption("NPAuraOnEchoingConnection", 453990)
----Queen Ansurek
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29628))
local timerAcidicApocalypse					= mod:NewCastTimer(35, 449940, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
----Ascended Voidspeaker
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29633))
local specWarnShadowblast					= mod:NewSpecialWarningInterruptCount(447950, nil, nil, nil, 1, 2)--No Cooldown, only spell lockout

----Devoted Worshipper
local warnCosmicApocalypse					= mod:NewCastAnnounce(448458, 3)
local specWarnGloomTouch					= mod:NewSpecialWarningMoveAway(447967, nil, nil, nil, 1, 2)
local yellGloomTouch						= mod:NewShortYell(447967)
local specWarnCosmicRupture					= mod:NewSpecialWarningYou(462558, nil, nil, nil, 1, 2, 4)--Mythic
local yellCosmicRupture						= mod:NewShortFadesYell(462558)
--local specWarnCosmicApocalypse				= mod:NewSpecialWarningSpell(448458, nil, nil, nil, 3, 2)

--local timerGloomTouchCD					= mod:NewCDNPTimer(49, 464056, nil, nil, nil, 3)
---Chamber Guardian
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29642))
local specWarnOust							= mod:NewSpecialWarningDefensive(448147, nil, nil, nil, 1, 2)

local timerOustCD							= mod:NewCDNPTimer(10, 448147, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Chamber Expeller
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29744))
local specWarnExpulsionBeam					= mod:NewSpecialWarningDodge(451600, nil, nil, nil, 2, 2)--Change to target warning if it can be scanned?

local timerExpulsionBeamCD					= mod:NewCDNPTimer(10, 451600, nil, nil, nil, 3)
--Chamber Acolyte
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29945))
local specWarnDarkDetonation				= mod:NewSpecialWarningInterruptCount(455374, nil, nil, nil, 1, 2)
--Caustic Skitterer
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29645))
local warnCausticFangs						= mod:NewStackAnnounce(449236, 2, nil, "Tank")

local specWarnCausticFangs					= mod:NewSpecialWarningStack(449236, nil, 30, nil, nil, 1, 6, 3)
--Stage Three: Paranoia's Feast
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28757))
local warnAbyssalInfusion					= mod:NewTargetNoFilterAnnounce(443888, 3)
local warnFrothVapor						= mod:NewStackAnnounce(445880, 4)--Version on boss
local warnQueenSummon						= mod:NewCountAnnounce(444829, 2)--NOT LOGGED, FIX ME WITH TRANSCRIPTOR
local warnRoyalCondemnation					= mod:NewTargetNoFilterAnnounce(438976, 3)
local warnGloomHatchlings					= mod:NewStackAnnounce(443726, 2)--Version on boss
local warnGorge								= mod:NewStackAnnounce(443342, 3, nil, "Tank")

local specWarnAbyssalInfusion				= mod:NewSpecialWarningYouPos(443888, nil, nil, nil, 1, 2)
local yellAbyssalInfusion					= mod:NewShortPosYell(443888)
local yellAbyssalInfusionFades				= mod:NewIconFadesYell(443888)
local specWarnAbyssalReverb					= mod:NewSpecialWarningMoveAway(455387, nil, nil, nil, 1, 2, 3)--Heroic+ secondary effect of Abyssal Infusion
local yellAbyssalReverb						= mod:NewShortYell(455387)
local yellAbyssalReverbFades				= mod:NewShortFadesYell(455387)
local specWarnFrothingGluttony				= mod:NewSpecialWarningRunCount(445422, nil, nil, nil, 4, 12)
local specWarnAcolytesEssence				= mod:NewSpecialWarningMoveAway(445152, nil, nil, nil, 1, 2)
local yellAcolytesEssenceFades				= mod:NewShortFadesYell(445152)
local specWarnNullDetonation				= mod:NewSpecialWarningInterruptCount(455374, nil, nil, nil, 1, 2)
local specWarnRoyalCondemnation				= mod:NewSpecialWarningYouPos(438976, nil, nil, nil, 1, 2)
local yellRoyalCondemnation					= mod:NewShortPosYell(438976)
--local yellRoyalCondemnationFades			= mod:NewIconFadesYell(438976)--No Duration on debuff
local specWarnInfest						= mod:NewSpecialWarningMoveAway(443325, nil, nil, nil, 1, 2)
local yellInfest							= mod:NewShortYell(443325)
local yellInfestFades						= mod:NewShortFadesYell(443325)
local specWarnInfestOther					= mod:NewSpecialWarningTaunt(443325, nil, nil, nil, 1, 2)
local specWarnGorge							= mod:NewSpecialWarningDefensive(443336, nil, nil, nil, 1, 2)
local specWarnCataclysmicEvolution			= mod:NewSpecialWarningTarget(451832, nil, nil, nil, 3, 2)

local timerAbyssalInfusionCD				= mod:NewCDCountTimer(49, 443888, nil, nil, nil, 3)
local timerFrothingGluttonyCD				= mod:NewCDCountTimer(49, 445422, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerQueensSummonsCD					= mod:NewCDCountTimer(49, 444829, nil, nil, nil, 1)
local timerNullDetonationCD					= mod:NewCDNPTimer(8.2, 455374, nil, nil, nil, 4)
local timerRoyalCondemnationCD				= mod:NewCDCountTimer(49, 438976, nil, nil, nil, 3)
local timerInfestCD							= mod:NewCDCountTimer(49, 443325, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerGorgeCD							= mod:NewCDCountTimer(49, 443336, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddSetIconOption("SetIconOnAbyssalInfusion", 443888, true, 0, {1, 2})
mod:AddSetIconOption("SetIconOnRoyalCondemnation", 438976, true, 0, {3, 4, 5})--3 on Mythic

local castsPerGUID = {}
--P1
mod.vb.reactiveCount = 0
mod.vb.novaCount = 0
mod.vb.tombCount = 0
mod.vb.tankComboCount = 0--Liquefy for now
mod.vb.feastCount = 0
mod.vb.webBladesCount = 0
--Intermission 1
mod.vb.wrestCount = 0
--P3
mod.vb.abyssalInfusionCount = 0
mod.vb.infusionIcon = 1
mod.vb.frothingGluttonyCount = 0
mod.vb.queensSummonsCount = 0
mod.vb.royalCondom = 0
mod.vb.royalCondomIcon = 3
mod.vb.infestCount = 0
mod.vb.gorgeCount = 0
mod.vb.cataEvoActivated = false

local savedDifficulty = "normal"
local allTimers = {
	["normal"] = {
		[1] = {
			--Reactive Toxin
			[437592] = {18.3, 56, 56},--56 repeating?
			--Venom Nova
			[437417] = {29.4, 56, 56},--56 repeating?
			--Silken Tomb
			[439814] = {57.4, 54},
			--Liquefy
			[440899] = {8.3, 40, 55},
			--Web Blades
			[439299] = {76.4, 48}
		},
		[1.5] = {
			--Wrest
			[450191] = {6, 19}--Technically diff spellid here, but table uses same one
		},
		[2] = {
			--Wrest
			[450191] = {32.2}--Then 8 repeating
		},
		[3] = {
			--Abyssal Infusion
			[443888] = {57.4, 80, 80},
			--Frothing Gluttony
			[445422] = {68.4, 80, 80},
			--Queen's Summons
			[444829] = {114.5, 82},
			--Royal Condemnation
			[438976] = {48, 141.5},
			--Infest
			[443325] = {29.4, 66, 80},
			--Gorge
			[443336] = {35.5, 66, 80},
			--Web Blades
			[439299] = {201.5}--Yes this is true
		},
	},
}

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self:SetStage(1)
	self.vb.reactiveCount = 0
	self.vb.novaCount = 0
	self.vb.tombCount = 0
	self.vb.tankComboCount = 0
	self.vb.feastCount = 0
	self.vb.webBladesCount = 0
	self.vb.wrestCount = 0
	self.vb.abyssalInfusionCount = 0
	self.vb.queensSummonsCount = 0
	self.vb.frothingGluttonyCount = 0
	self.vb.royalCondom = 0
	self.vb.infestCount = 0
	self.vb.gorgeCount = 0
	self.vb.cataEvoActivated = false
	--if self:IsMythic() then
	--	savedDifficulty = "mythic"
	--elseif self:IsHeroic() then
	--	savedDifficulty = "heroic"
	--else--Combine LFR and Normal
		savedDifficulty = "normal"
	--end
	timerReactiveToxinCD:Start(allTimers[savedDifficulty][1][437592][1]-delay, 1)
	timerVenomNovaCD:Start(allTimers[savedDifficulty][1][437417][1]-delay, 1)
	timerSilkenTombCD:Start(allTimers[savedDifficulty][1][439814][1]-delay, 1)
	timerLiquefyCD:Start(allTimers[savedDifficulty][1][440899][1]-delay, 1)
--	timerFeastCD:Start(allTimers[savedDifficulty][1][437093][1]-delay, 1)
	timerWebBladesCD:Start(allTimers[savedDifficulty][1][439299][1]-delay, 1)
	timerPredationCD:Start(153-delay)--Max time, will happen sooner if boss hits 35%
	if self.Options.NPAuraOnEchoingConnection then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	DBM:AddMsg("this mod is a WIP. Some warnings may be wrong or missing until fight seen on all difficulties")
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnEchoingConnection then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:OnTimerRecovery()
	--if self:IsMythic() then
	--	savedDifficulty = "mythic"
	--elseif self:IsHeroic() then
	--	savedDifficulty = "heroic"
	--else--Combine LFR and Normal
		savedDifficulty = "normal"
	--end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 437592 or spellId == 456623 then--437592 confirmed, 456623 unknown
		self.vb.reactiveCount = self.vb.reactiveCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 437592, self.vb.reactiveCount+1)
		if timer then
			timerReactiveToxinCD:Start(timer, self.vb.reactiveCount+1)
		end
	elseif spellId == 437417 then
		self.vb.novaCount = self.vb.novaCount + 1
		specWarnVenomNova:Show(self.vb.novaCount)
		if not DBM:UnitDebuff("player", 441692) then--Reaction Trauma (can't soak)
			specWarnVenomNova:Play("helpsoak")--Maybe something more specific like movetopool?
		else
			specWarnVenomNova:Play("watchwave")
		end
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 437417, self.vb.novaCount+1)
		if timer then
			timerVenomNovaCD:Start(timer, self.vb.novaCount+1)
		end
	elseif spellId == 439814 then
		self.vb.tombCount = self.vb.tombCount + 1
		warnSilkenTomb:Show(self.vb.tombCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 439814, self.vb.tombCount+1)
		if timer then
			timerSilkenTombCD:Start(timer, self.vb.tombCount+1)
		end
	elseif spellId == 440899 or spellId == 440883 then--Non Mythic / Mythic (assumed)
		self.vb.tankComboCount = self.vb.tankComboCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnLiquefy:Show()
			specWarnLiquefy:Play("defensive")
		end
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 440899, self.vb.tankComboCount+1)
		if timer then
			timerLiquefyCD:Start(timer, self.vb.tankComboCount+1)
		end
	elseif spellId == 437093 then
		self.vb.feastCount = self.vb.feastCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnFeast:Show()
			specWarnFeast:Play("defensive")
		end
		--local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 437093, self.vb.feastCount+1)
		--if timer then
		--	timerFeastCD:Start(timer, self.vb.feastCount+1)
		--end
	elseif spellId == 447411 or spellId == 450191 then--Intermission Left / Phase 2 right
		self.vb.wrestCount = self.vb.wrestCount + 1
		specWarnWrest:Show(self.vb.wrestCount)
		specWarnWrest:Play("pullin")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 450191, self.vb.wrestCount+1) or self:GetStage(2) and 8
		if timer then
			timerWrestCD:Start(timer, self.vb.wrestCount+1)
		end
	elseif spellId == 449940 then
		timerWrestCD:Stop()
		timerAcidicApocalypse:Start()--Basically phase 2.5 or transition to phase 3
	elseif spellId == 447950 then
		if not castsPerGUID[args.sourceGUID] then castsPerGUID[args.sourceGUID] = 0 end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnShadowblast:Show(args.sourceName, count)
			if count < 6 then
				specWarnShadowblast:Play("kick"..count.."r")
			else
				specWarnShadowblast:Play("kickcast")
			end
		end
	elseif spellId == 455374 then
		if not castsPerGUID[args.sourceGUID] then castsPerGUID[args.sourceGUID] = 0 end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnDarkDetonation:Show(args.sourceName, count)
			if count < 6 then
				specWarnDarkDetonation:Play("kick"..count.."r")
			else
				specWarnDarkDetonation:Play("kickcast")
			end
		end
	elseif spellId == 445021 then
		if not castsPerGUID[args.sourceGUID] then castsPerGUID[args.sourceGUID] = 0 end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnNullDetonation:Show(args.sourceName, count)
			if count < 6 then
				specWarnNullDetonation:Play("kick"..count.."r")
			else
				specWarnNullDetonation:Play("kickcast")
			end
		end
		timerNullDetonationCD:Start(nil, args.sourceGUID)
	elseif spellId == 448458 and self:AntiSpam(5, 1) then
		warnCosmicApocalypse:Show()
	elseif spellId == 448147 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnOust:Show()
			specWarnOust:Play("carefly")
		end
		timerOustCD:Start(nil, args.sourceGUID)
	elseif spellId == 451600 then
		if self:AntiSpam(5, 2) then--Just in case multiple do it at once
			specWarnExpulsionBeam:Show()
			specWarnExpulsionBeam:Play("farfromline")
		end
		timerExpulsionBeamCD:Start(nil, args.sourceGUID)
	elseif spellId == 443888 then
		self.vb.abyssalInfusionCount = self.vb.abyssalInfusionCount + 1
		self.vb.infusionIcon = 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 443888, self.vb.abyssalInfusionCount+1)
		if timer then
			timerAbyssalInfusionCD:Start(timer, self.vb.abyssalInfusionCount+1)
		end
	elseif spellId == 445422 and not self.vb.cataEvoActivated then
		self.vb.frothingGluttonyCount = self.vb.frothingGluttonyCount + 1
		specWarnFrothingGluttony:Show(self.vb.frothingGluttonyCount)
		specWarnFrothingGluttony:Play("pullin")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 445422, self.vb.frothingGluttonyCount+1)
		if timer then
			timerFrothingGluttonyCD:Start(timer, self.vb.frothingGluttonyCount+1)
		end
	elseif spellId == 444829 then
		self.vb.queensSummonsCount = self.vb.queensSummonsCount + 1
		warnQueenSummon:Show(self.vb.queensSummonsCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 444829, self.vb.queensSummonsCount+1)
		if timer then
			timerQueensSummonsCD:Start(timer, self.vb.queensSummonsCount+1)
		end
	elseif spellId == 438976 then
		self.vb.royalCondom = self.vb.royalCondom + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 438976, self.vb.royalCondom+1)
		if timer then
			timerRoyalCondemnationCD:Start(timer, self.vb.royalCondom+1)
		end
	elseif spellId == 443325 then
		self.vb.infestCount = self.vb.infestCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 443325, self.vb.infestCount+1)
		if timer then
			timerInfestCD:Start(timer, self.vb.infestCount+1)
		end
	elseif spellId == 443336 then
		self.vb.gorgeCount = self.vb.gorgeCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnGorge:Show()
			specWarnGorge:Play("defensive")
		end
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 443336, self.vb.gorgeCount+1)
		if timer then
			timerGorgeCD:Start(timer, self.vb.gorgeCount+1)
		end
	elseif spellId == 447076 then--Predation
		self:SetStage(1.5)
		self.vb.wrestCount = 0
		timerReactiveToxinCD:Stop()
		timerVenomNovaCD:Stop()
		timerSilkenTombCD:Stop()
		timerLiquefyCD:Stop()
		timerPredationCD:Stop()
	--	timerFeastCD:Stop()
		timerWebBladesCD:Stop()
		warnPhase:Show(1.5)
		warnPhase:Play("phasechange")

		timerWrestCD:Start(allTimers[savedDifficulty][1.5][450191][1], 1)
	elseif spellId == 449986 then--Aphotic Communion Starting
		self:SetStage(3)
		self.vb.webBladesCount = 0--Only repeat ability from earlier stage
		warnPhase:Show(3)
		warnPhase:Play("pthree")
		--Possibly move to cast finish later
		timerAbyssalInfusionCD:Start(allTimers[savedDifficulty][3][443888][1], 1)
		timerFrothingGluttonyCD:Start(allTimers[savedDifficulty][3][445422][1], 1)
		timerQueensSummonsCD:Start(allTimers[savedDifficulty][3][444829][1], 1)
		timerRoyalCondemnationCD:Start(allTimers[savedDifficulty][3][438976][1], 1)
		timerInfestCD:Start(allTimers[savedDifficulty][3][443325][1], 1)
		timerGorgeCD:Start(allTimers[savedDifficulty][3][443336][1], 1)
		timerWebBladesCD:Start(allTimers[savedDifficulty][1][439299][1], 1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 439299 and self:AntiSpam(5, 3) then
		self.vb.webBladesCount = self.vb.webBladesCount + 1
		specWarnWebBlades:Show(self.vb.webBladesCount)
		specWarnWebBlades:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 439299, self.vb.webBladesCount+1)
		if timer then
			timerWebBladesCD:Start(timer, self.vb.webBladesCount+1)
		end
	--elseif spellId == 449986 then--Aphotic Communion Finishing
	--	timerAbyssalInfusionCD:Start(3)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 437586 then
		warnReactiveToxin:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnReactiveToxin:Show()
			specWarnReactiveToxin:Play("runout")
			yellReactiveToxin:Yell()
			yellReactiveToxinFades:Countdown(spellId)
		end
	elseif spellId == 441958 and args:IsPlayer() and self:AntiSpam(3, 4) then--Grasping Silk
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 436800 and not args:IsPlayer() then
		specWarnLiquefyTaunt:Show(args.destName)
		specWarnLiquefyTaunt:Play("tauntboss")
	--elseif spellId == 440885 and args:IsPlayer() then
	--	specWarnLiquefyNonTank:Show()
	--	specWarnLiquefyNonTank:Play("targetyou")
	elseif spellId == 447207 then--Predation Shield
		if self.Options.Infoframe then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, "boss1")
		end
	elseif spellId == 453990 then
		if self.Options.NPAuraOnEchoingConnection then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 464056 or spellId == 447967 then--Left Mythic Gateway version, Right Mob version on all difficulties
		if args:IsPlayer() then
			specWarnGloomTouch:Show()
			specWarnGloomTouch:Play("runout")
			yellGloomTouch:Yell()
		end
	elseif spellId == 462558 then
		if args:IsPlayer() then
			specWarnCosmicRupture:Show()
			specWarnCosmicRupture:Play("targetyou")
			yellCosmicRupture:Countdown(spellId)
		end
	elseif spellId == 451278 then
		if args:IsPlayer() then
			specWarnConcentratedToxin:Show()
			specWarnConcentratedToxin:Play("targetyou")
			yellConcentratedToxin:Yell()
			yellConcentratedToxinFades:Countdown(spellId)
		end
	elseif spellId == 443903 then
		local icon = self.vb.infusionIcon
		if self.Options.SetIconOnAbyssalInfusion then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnAbyssalInfusion:Show(self:IconNumToTexture(icon))
			specWarnAbyssalInfusion:Play("mm"..icon)
			yellAbyssalInfusion:Yell(icon, icon)
			yellAbyssalInfusionFades:Countdown(spellId, nil, icon)
		end
		warnAbyssalInfusion:CombinedShow(1, args.destName)
		self.vb.infusionIcon = self.vb.infusionIcon + 1
	elseif spellId == 438974 then
		if self:AntiSpam(5, 5) then
			--In case targeting goes out before cast start, we want to make sure icons reset on first target
			self.vb.royalCondomIcon = 3
		end
		local icon = self.vb.royalCondomIcon
		if self.Options.SetIconOnRoyalCondemnation then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnRoyalCondemnation:Show(self:IconNumToTexture(icon))
			specWarnRoyalCondemnation:Play("mm"..icon)
			yellRoyalCondemnation:Yell(icon, icon - 2)
			--yellRoyalCondemnationFades:Countdown(spellId, nil, icon)
		end
		warnRoyalCondemnation:CombinedShow(1, args.destName)
		self.vb.royalCondomIcon = self.vb.royalCondomIcon + 1
	elseif spellId == 455387 then
		if args:IsPlayer() then
			specWarnAbyssalReverb:Show()
			specWarnAbyssalReverb:Play("runout")
			yellAbyssalReverb:Yell()
			yellAbyssalReverbFades:Countdown(spellId)
		end
	elseif spellId == 445880 then
		warnFrothVapor:Show(args.destName, 1)
	elseif spellId == 443726 then
		warnGloomHatchlings:Show(args.destName, 1)
	elseif spellId == 445152 then
		if args:IsPlayer() then
			specWarnAcolytesEssence:Show()
			specWarnAcolytesEssence:Play("targetyou")--Needs better audio
			yellAcolytesEssenceFades:Countdown(spellId)
		end
	elseif spellId == 443656 then
		if args:IsPlayer() then
			specWarnInfest:Show()
			specWarnInfest:Play("runout")
			yellInfest:Yell()
			yellInfestFades:Countdown(spellId)
		else
			specWarnInfestOther:Show(args.destName)
			specWarnInfestOther:Play("tauntboss")
		end
	elseif spellId == 443342 then
		warnGorge:Show(args.destName, 1)
	elseif spellId == 451832 then
		self.vb.cataEvoActivated = true
		specWarnCataclysmicEvolution:Show(args.destName)
		specWarnCataclysmicEvolution:Play("stilldanger")
	elseif spellId == 464638 and args:IsPlayer() then
		warnFrothyToxin:Show(1)
	elseif spellId == 441556 and args:IsPlayer() then
		warnReactionVapor:Show(1)
	elseif spellId == 455404 then
		if not args:IsPlayer() and not self:IsEasy() then
			specWarnFeastTaunt:Show(args.destName)
			specWarnFeastTaunt:Play("tauntboss")
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	if spellId == 449236 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount % 5 == 0 then
				if args:IsPlayer() and args.amount >= 30 then--Placeholder
					specWarnCausticFangs:Show(args.amount)
					specWarnCausticFangs:Play("stackhigh")
				else
					warnCausticFangs:Show(args.destName, args.amount)
				end
			end
		end
	elseif spellId == 445880 then
		warnFrothVapor:Cancel()
		--Scheduled in case boss absorbs a ton at once on bad pull
		warnFrothVapor:Schedule(1, args.destName, args.amount)
	elseif spellId == 443726 then
		warnGloomHatchlings:Show(args.destName, args.amount)
	elseif spellId == 443342 then
		warnGorge:Show(args.destName, args.amount)
	elseif spellId == 464638 and args:IsPlayer() then
		--if amount % 5 == 0 then
			warnFrothyToxin:Show(args.amount)
		--end
		--if args.amount >= 30 then--Placeholder
		--	specWarnFrothyToxin:Show(args.amount)
		--	specWarnFrothyToxin:Play("stackhigh")
		--end
	elseif spellId == 441556 and args:IsPlayer() then
		--if amount % 5 == 0 then
			warnReactionVapor:Show(args.amount)
		--end
		--if args.amount >= 30 then--Placeholder
		--	specWarnReactionVapor:Show(args.amount)
		--	specWarnReactionVapor:Play("stackhigh")
		--end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 437586 then
		if args:IsPlayer() then
			yellReactiveToxinFades:Cancel()
		end
	elseif spellId == 447207 then--Predation Shield
		self:SetStage(2)
		self.vb.wrestCount = 0
		warnPhase:Show(2)
		warnPhase:Play("ptwo")
		self.vb.wrestCount = 0
		timerWrestCD:Stop()
		timerWrestCD:Start(allTimers[savedDifficulty][2][450191][1], 1)
		if self.Options.Infoframe then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 453990 then
		if self.Options.NPAuraOnEchoingConnection then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 462558 then
		if args:IsPlayer() then
			yellCosmicRupture:Cancel()
		end
	elseif spellId == 451278 then
		if args:IsPlayer() then
			yellConcentratedToxinFades:Cancel()
		end
	elseif spellId == 443903 then
		if self.Options.SetIconOnAbyssalInfusion then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellAbyssalInfusionFades:Cancel()
		end
	elseif spellId == 455387 then
		if args:IsPlayer() then
			yellAbyssalReverbFades:Cancel()
		end
	elseif spellId == 445152 then
		if args:IsPlayer() then
			yellAcolytesEssenceFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 443403 and destGUID == UnitGUID("player") and self:AntiSpam(3, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 223150 then--Ascended Voidspeaker
		timerExpulsionBeamCD:Stop(nil, args.destGUID)
	--elseif cid == 223318 then--Devoted Worshipper

	elseif cid == 223204 then--Chamber Guardian
		timerOustCD:Stop(args.destGUID)
	--elseif cid == 224368 then--Chamber Expeller

	elseif cid == 221863 then--cycle-warden--Summoned Acolyte
		timerNullDetonationCD:Stop(nil, args.destGUID)
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 439299 and self:AntiSpam(5, 3) then

	end
end
--]]
