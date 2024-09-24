local mod	= DBM:NewMod(2602, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "story,lfr,normal,heroic,mythic"

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(218370)
mod:SetEncounterID(2922)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20240917000000)
mod:SetMinSyncRevision(20240910000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 437592 456623 437417 439814 440899 440883 437093 447076 447411 450191 449940 449986 447950 448458 448147 451600 455374 443888 445422 444829 445021 438976 443325 443336",
	"SPELL_CAST_SUCCESS 439299 449986",
	"SPELL_AURA_APPLIED 437586 441958 436800 440885 447207 453990 464056 447967 462558 451278 443903 455387 445880 445152 438974 443656 443726 443342 451832 464638 441556 445013 462693",--455404
	"SPELL_AURA_APPLIED_DOSE 449236 445880 443726 443342 464638 441556",
	"SPELL_AURA_REMOVED 437586 447207 453990 462558 451278 443903 455387 445152 443656 445013 445021",
	"SPELL_PERIODIC_DAMAGE 443403",
	"SPELL_PERIODIC_MISSED 443403",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--NOTE, 451320 wasn't used
--TODO, Phase 2 Entropic Conduit mythic mechanics
--TODO, add Gloom Orb nameplate timer?
--TODO, figure out a proper way to warn for Ousting Fragments. how far are they cast from Chamber guardian. maybe scoped alert for players within x yards of caster?
--TODO, appropriate stack high warning for https://www.wowhead.com/beta/spell=449236/caustic-fangs
--TODO, correct detection for https://www.wowhead.com/beta/spell=444502/conduit-collapse
--TODO, track player version of https://www.wowhead.com/beta/spell=445877/froth-vapor ?
--TODO, infoframe or more for https://www.wowhead.com/beta/spell=445013/dark-barrier ? depends on mob count
--TODO, add auto marking?
--TODO, https://www.wowhead.com/beta/spell=441865/royal-shackles alert too?
--[[
(ability.id = 437592 or ability.id = 456623 or ability.id = 437417 or ability.id = 439814 or ability.id = 440899 or ability.id = 440883 or ability.id = 437093 or ability.id = 447411 or ability.id = 450191 or ability.id = 448458 or ability.id = 448147 or ability.id = 451600 or ability.id = 455374 or ability.id = 443888 or ability.id = 445422 or ability.id = 444829 or ability.id = 438976 or ability.id = 443325 or ability.id = 443336) and type = "begincast"
or (ability.id = 439299) and type = "cast"
or (ability.id = 447076 or ability.id = 449940 or ability.id = 449986) and type = "begincast"
or ability. id = 447207 and type = "removebuff"
 or stoppedAbility.id = 449940 or stoppedAbility.id = 455374
 or ability.id = 445021 and type = "begincast"
 or (target.id = 223150 or target.id = 223318) and type = "death"
--]]
--General Stuff
local warnPhase									= mod:NewPhaseChangeAnnounce(0, nil, nil, nil, nil, nil, 2)

local specWarnGTFO								= mod:NewSpecialWarningGTFO(441958, nil, nil, nil, 1, 8)
--Stage One: A Queen's Venom
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28754))
local warnReactiveToxin							= mod:NewTargetCountAnnounce(437592, 3, nil, nil, nil, nil, nil, nil, true)
local warnSilkenTomb							= mod:NewCountAnnounce(439814, 2, nil, nil, nil, nil, DBM_COMMON_L.ROOTS)--Shortname Roots
local warnFrothyToxin							= mod:NewCountAnnounce(464638, 3, nil, false, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(464638))--Player
local warnReactionVapor							= mod:NewCountAnnounce(441556, 3, nil, false, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(441556))--Player

local specWarnReactiveToxin						= mod:NewSpecialWarningMoveAway(437592, nil, nil, nil, 1, 2)
local yellReactiveToxin							= mod:NewShortPosYell(437592)
local yellReactiveToxinFades					= mod:NewIconFadesYell(437592)
local specWarnConcentratedToxin					= mod:NewSpecialWarningMoveAway(451278, nil, 37859, nil, 1, 2)
local yellConcentratedToxin						= mod:NewShortYell(451278, 37859)--Shortname "Bomb"
local yellConcentratedToxinFades				= mod:NewShortFadesYell(451278, 37859)--Shortname "Bomb"
local specWarnVenomNova							= mod:NewSpecialWarningCount(437417, nil, 242396, nil, 2, 15)
--local specWarnSilkenTomb						= mod:NewSpecialWarningYou(439814, nil, nil, nil, 1, 2)
local specWarnLiquefy							= mod:NewSpecialWarningDefensive(440899, nil, nil, nil, 1, 2)
local specWarnLiquefyTaunt						= mod:NewSpecialWarningTaunt(440899, nil, nil, nil, 1, 2)
--local specWarnLiquefyNonTank					= mod:NewSpecialWarningYou(440885, nil, nil, nil, 1, 2)--No idea, wording changed since adding it. does liquify tank just get both debuffs?
local specWarnFeast								= mod:NewSpecialWarningDefensive(437093, nil, nil, nil, 1, 2)
--local specWarnFeastTaunt						= mod:NewSpecialWarningTaunt(437093, false, nil, 2, 1, 2)
local specWarnWebBlades							= mod:NewSpecialWarningDodgeCount(439299, nil, 138737, nil, 2, 2)

local timerReactiveToxinCD						= mod:NewCDCountTimer(49, 437592, nil, nil, nil, 3)
local timerVenomNovaCD							= mod:NewCDCountTimer(49, 437417, 242396, nil, nil, 3)--Shortname "Nova"
local timerSilkenTombCD							= mod:NewCDCountTimer(49, 439814, DBM_COMMON_L.ROOTS.." (%s)", nil, nil, 3)
local timerLiquefyCD							= mod:NewCDCountTimer(49, 440899, DBM_COMMON_L.TANKCOMBO.." (%s)", "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local timerFeastCD							= mod:NewCDCountTimer(49, 437093, nil, false, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Combine with liquefy if it is a combo
local timerWebBladesCD							= mod:NewCDCountTimer(49, 439299, 138737, nil, nil, 3)--Shortname "Blades"
local timerPredationCD							= mod:NewIntermissionCountTimer(140, 447207, nil, nil, nil, 6)

mod:AddSetIconOption("SetIconOnToxin", 437592, true, 10, {6, 3, 7, 1, 2})--(Priority for melee > ranged > healer)
mod:AddDropdownOption("ToxinBehavior", {"MatchBW", "UseAllAscending", "DisableIconsForRaid", "DisableAllForRaid"}, "MatchBW", "misc", nil, 437592)
--mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)
--Intermission: The Spider's Web
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28755))
local specWarnWrest							= mod:NewSpecialWarningCount(447411, nil, 193997, nil, 2, 12)--Shortname "Pull"

local timerWrestCD							= mod:NewCDCountTimer(49, 447411, 193997, nil, nil, 3)--Shortname "Pull"

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
local warnGloomEruption						= mod:NewSpellAnnounce(448046, 2, nil, nil, 406073, nil, nil, 15)--Shortname "Knock Up"

local specWarnDarkDetonation				= mod:NewSpecialWarningInterruptCount(455374, nil, nil, nil, 1, 2)

local timerGloomEruption					= mod:NewCastTimer(5, 448046, 406073, nil, nil, 5, nil, nil, nil, 1)--Shortname "Knock Up"
--Caustic Skitterer
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29645))
local warnCausticFangs						= mod:NewStackAnnounce(449236, 2, nil, "Tank")

local specWarnCausticFangs					= mod:NewSpecialWarningStack(449236, nil, 30, nil, nil, 1, 6, 3)
--Stage Three: Paranoia's Feast
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28757))
local warnAbyssalInfusion					= mod:NewTargetNoFilterAnnounce(443888, 3, nil, nil, 109400)--Shortname "Portals"
local warnFrothVapor						= mod:NewStackAnnounce(445880, 4)--Version on boss
local warnQueenSummon						= mod:NewCountAnnounce(444829, 2, nil, nil, nil, nil, DBM_COMMON_L.BIG_ADDS)--Shortname "Big Adds"
local warnRoyalCondemnation					= mod:NewTargetNoFilterAnnounce(438976, 3, nil, nil, 292910)--Shortname "Shackles"
local warnGloomHatchlings					= mod:NewStackAnnounce(443726, 2)--Version on boss
local warnGorge								= mod:NewStackAnnounce(443342, 3, nil, "Tank")

local specWarnAbyssalInfusion				= mod:NewSpecialWarningYouPos(443888, nil, 161722, nil, 1, 2)--Shortname "Portal" (will not override portals in api)
local yellAbyssalInfusion					= mod:NewShortPosYell(443888, 161722)--Shortname "Portal"
local yellAbyssalInfusionFades				= mod:NewIconFadesYell(443888, 161722)--Shortname "Portal"
local specWarnAbyssalReverb					= mod:NewSpecialWarningMoveAway(455387, nil, 37859, nil, 1, 2, 3)--Heroic+ secondary effect of Abyssal Infusion
local yellAbyssalReverb						= mod:NewShortYell(455387, 37859)
local yellAbyssalReverbFades				= mod:NewShortFadesYell(455387, 37859)
local specWarnFrothingGluttony				= mod:NewSpecialWarningRunCount(445422, nil, nil, DBM_COMMON_L.RING, 4, 12)
local specWarnAcolytesEssence				= mod:NewSpecialWarningMoveAway(445152, nil, nil, nil, 1, 2)
local yellAcolytesEssenceFades				= mod:NewShortFadesYell(445152)
local specWarnNullDetonation				= mod:NewSpecialWarningInterruptCount(445021, nil, nil, nil, 1, 2)
local specWarnRoyalCondemnation				= mod:NewSpecialWarningYouPos(438976, nil, 292910, nil, 1, 2)
local yellRoyalCondemnation					= mod:NewShortPosYell(438976, 292910)
--local yellRoyalCondemnationFades			= mod:NewIconFadesYell(438976)--No Duration on debuff
local specWarnInfest						= mod:NewSpecialWarningMoveAway(443325, nil, nil, nil, 1, 2)
local yellInfest							= mod:NewShortYell(443325)
local yellInfestFades						= mod:NewShortFadesYell(443325)
local specWarnInfestOther					= mod:NewSpecialWarningTaunt(443325, nil, nil, nil, 1, 2)
local specWarnGorge							= mod:NewSpecialWarningDefensive(443336, nil, nil, nil, 1, 2)
local specWarnCataclysmicEvolution			= mod:NewSpecialWarningTarget(451832, nil, nil, nil, 3, 2)

local timerAbyssalInfusionCD				= mod:NewCDCountTimer(49, 443888, 109400, nil, nil, 3)--Shortname "Portals"
local timerFrothingGluttonyCD				= mod:NewCDCountTimer(49, 445422, DBM_COMMON_L.RING.." (%s)", nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerQueensSummonsCD					= mod:NewCDCountTimer(49, 444829, DBM_COMMON_L.BIG_ADDS.." (%s)", nil, nil, 1)
local timerNullDetonationCD					= mod:NewCDNPTimer(8.2, 445021, nil, nil, nil, 4)
local timerRoyalCondemnationCD				= mod:NewCDCountTimer(49, 438976, 292910, nil, nil, 3)--Shortname "Shackles"
local timerInfestCD							= mod:NewCDCountTimer(49, 443325, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--I don't nessesarily agree with calling this Small adds, since timer syncs up to tank debuff, and small adds come from tank several seconds after. Plus "infest" is kinda clear anyways it's mechanic that spawns adds later
local timerGorgeCD							= mod:NewCDCountTimer(49, 443336, DBM_COMMON_L.POOLS.." (%s)", nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddSetIconOption("SetIconOnAbyssalInfusion", 443888, true, 0, {1, 2})
mod:AddSetIconOption("SetIconOnRoyalCondemnation", 438976, true, 0, {6, 3, 7})--3 on Mythic
mod:AddSetIconOption("SetIconOnQueensSummon", 444829, true, 5, {8, 5, 4})

local castsPerGUID = {}
local marksOrder = {6, 3, 7, 1, 2}--Icon order based on raid flares and not using green after much discussion on it with JW
local addMarks = {8, 5, 4}
--P1
local reactiveIcons = {}
mod.vb.ToxinBehavior = "MatchBW"
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
mod.vb.queensSummonIcon = 1
mod.vb.royalCondom = 0
mod.vb.royalCondomIcon = 1
mod.vb.infestCount = 0
mod.vb.gorgeCount = 0
mod.vb.cataEvoActivated = false

local savedDifficulty = "normal"
local allTimers = {
	["mythic"] = {
		[1] = {
			--Reactive Toxin
			[437592] = {0},
			--Venom Nova
			[437417] = {0},
			--Silken Tomb
			[439814] = {0},
			--Liquefy
			[440899] = {0},
			--Web Blades
			[439299] = {0}
		},
		[1.5] = {
			--Wrest
			[450191] = {0}--Technically diff spellid here, but table uses same one (different from normal)
		},
		[2] = {
			--Wrest
			[450191] = {0}--Then 8 repeating with exception of timer resetting when first platform adds die
		},
		[3] = {
			--Abyssal Infusion
			[443888] = {0},
			--Frothing Gluttony
			[445422] = {0},
			--Queen's Summons
			[444829] = {0},
			--Royal Condemnation
			[438976] = {0},
			--Infest
			[443325] = {0},
			--Gorge
			[443336] = {0},
			--Web Blades
			[439299] = {0}
		},
	},
	["heroic"] = {
		[1] = {
			--Reactive Toxin
			[437592] = {18.3, 55.8, 55.9},--56 repeating? (Same as normal)
			--Venom Nova
			[437417] = {29.4, 56, 56},--56 repeating? (Same as normal)
			--Silken Tomb
			[439814] = {57.4, 54, 15.9},--(different from normal)
			--Liquefy
			[440899] = {8.3, 39.7, 51},--(different from normal)
			--Web Blades
			[439299] = {20.4, 47, 47, 25}--(different from normal)
		},
		[1.5] = {
			--Wrest
			[450191] = {6, 19, 19}--Technically diff spellid here, but table uses same one (different from normal)
		},
		[2] = {
			--Wrest
			[450191] = {34.2}--Then 8 repeating with exception of timer resetting when first platform adds die
		},
		[3] = {
			--Abyssal Infusion
			[443888] = {57.4, 80, 80},
			--Frothing Gluttony
			[445422] = {68.4, 80, 80},
			--Queen's Summons
			[444829] = {119.8, 75},
			--Royal Condemnation
			[438976] = {48, 58.5, 99.4},
			--Infest
			[443325] = {29.4, 66, 81.9},
			--Gorge
			[443336] = {32.8, 66, 81.9},
			--Web Blades
			[439299] = {85.8, 39, 41, 18.6, 49.4}
		},
	},
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
			[450191] = {31.5}--Then 8 repeating
		},
		[3] = {
			--Abyssal Infusion
			[443888] = {57.4, 80, 80},
			--Frothing Gluttony
			[445422] = {68.4, 80, 80},
			--Queen's Summons
			[444829] = {114.5, 82},
			--Royal Condemnation
			[438976] = {47.8, 141.5},
			--Infest
			[443325] = {29.4, 66, 80},
			--Gorge
			[443336] = {35.3, 66, 80},
			--Web Blades
			[439299] = {201.2}--Yes this is true
		},
	},
	["story"] = {
		[1] = {
			--Reactive Toxin
			[437592] = {0},--Not used in Story
			--Venom Nova
			[437417] = {34.4},
			--Silken Tomb
			[439814] = {20.5, 38.0},
			--Liquefy
			[440899] = {0},--Not used in Story
			--Web Blades
			[439299] = {7.5, 38.0}
		},
		[1.5] = {
			--Wrest
			[450191] = {0}--Not used in story
		},
		[2] = {
			--Wrest
			[450191] = {0}--Not used in story
		},
		[3] = {
			--Abyssal Infusion
			[443888] = {0},--Not used in story
			--Frothing Gluttony
			[445422] = {62.4, 53.0},
			--Queen's Summons
			[444829] = {42.4, 53.0},
			--Royal Condemnation
			[438976] = {35.9, 53.0},
			--Infest
			[443325] = {0},--Not used in story
			--Gorge
			[443336] = {0},--Not used in story
			--Web Blades
			[439299] = {0}--Probably used but too late to ever see
		},
	},
}

---@param self DBMMod
local function sortToxin(self)
	table.sort(reactiveIcons, DBM.SortByMeleeRangedHealer)
	for i = 1, #reactiveIcons do
		local name = reactiveIcons[i]
		local icon
		if self.vb.ToxinBehavior == "MatchBW" then
			icon = marksOrder[i]
		elseif self.vb.ToxinBehavior == "UseAllAscending" then
			icon = i
		else--Disable Icons and Disable all for raid
			icon = 0
		end
		if icon > 0 and self.Options.SetIconOnToxin then
			--Mythic uses same icons in pairs, so people are paired up with same mark, can't mark both so only marks 1 of them
			self:SetIcon(name, icon)
		end
		if name == DBM:GetMyPlayerInfo() then
			specWarnReactiveToxin:Show()
			if icon > 0 then
				specWarnReactiveToxin:Play("mm"..icon)
			else
				specWarnReactiveToxin:Play("runout")
			end
			if self.vb.ToxinBehavior ~= "DisableAllForRaid" then
				yellReactiveToxin:Yell(icon)
				yellReactiveToxinFades:Countdown(437586, nil, icon)
			end
		end
	end
	warnReactiveToxin:Show(self.vb.reactiveCount+1, table.concat(reactiveIcons, "<, >"))
end

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
	self.vb.ToxinBehavior = self.Options.ToxinBehavior--Default it to whatever user has it set to, until group leader overrides it
	if self:IsMythic() then
		savedDifficulty = "mythic"
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	elseif self:IsStory() then
		savedDifficulty = "story"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
	timerReactiveToxinCD:Start(allTimers[savedDifficulty][1][437592][1]-delay, 1)
	timerVenomNovaCD:Start(allTimers[savedDifficulty][1][437417][1]-delay, 1)
	timerSilkenTombCD:Start(allTimers[savedDifficulty][1][439814][1]-delay, 1)
	timerLiquefyCD:Start(allTimers[savedDifficulty][1][440899][1]-delay, 1)
--	timerFeastCD:Start(allTimers[savedDifficulty][1][437093][1]-delay, 1)
	timerWebBladesCD:Start(allTimers[savedDifficulty][1][439299][1]-delay, 1)
	timerPredationCD:Start(153-delay, 1)--Max time, will happen sooner if boss hits 35%
	if self.Options.NPAuraOnEchoingConnection then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	--Group leader decides interrupt behavior
	if UnitIsGroupLeader("player") and not self:IsLFR() then
		if self.Options.ToxinBehavior == "MatchBW" then
			self:SendSync("MatchBW")
		elseif self.Options.ToxinBehavior == "UseAllAscending" then
			self:SendSync("UseAllAscending")
		elseif self.Options.ToxinBehavior == "DisableIconsForRaid" then
			self:SendSync("DisableIconsForRaid")
		elseif self.Options.ToxinBehavior == "DisableAllForRaid" then
			self:SendSync("DisableAllForRaid")
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnEchoingConnection then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		savedDifficulty = "mythic"
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	elseif self:IsStory() then
		savedDifficulty = "story"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 437592 or spellId == 456623 then--437592 confirmed, 456623 unknown
		self.vb.reactiveCount = self.vb.reactiveCount + 1
		table.wipe(reactiveIcons)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, 437592, self.vb.reactiveCount+1)
		if timer then
			timerReactiveToxinCD:Start(timer, self.vb.reactiveCount+1)
		end
	elseif spellId == 437417 then
		self.vb.novaCount = self.vb.novaCount + 1
		specWarnVenomNova:Show(self.vb.novaCount)
		specWarnVenomNova:Play("getknockedup")
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
		local uId = DBM:GetUnitIdFromGUID(args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID, false, false) and not DBM:UnitBuff(uId, 445013) then--Count interrupt, so cooldown is not checked
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
		if self:CheckBossDistance(args.sourceGUID, true, 32698, 48) and self:AntiSpam(5, 2) then--Just in case multiple do it at once
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
		self.vb.queensSummonIcon = 1
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
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1.5))
		warnPhase:Play("phasechange")
	elseif spellId == 449986 then--Aphotic Communion Starting
		self:SetStage(3)
		timerAcidicApocalypse:Stop()
		self.vb.webBladesCount = 0--Only repeat ability from earlier stage
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
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
		reactiveIcons[#reactiveIcons+1] = args.destName
		local expectedTotal = self:IsMythic() and 5 or self:IsHeroic() and 2 or 1
		local alivePlayers = DBM:NumRealAlivePlayers()
		--Auto scale expected if there aren't enough living players to meet it
		if expectedTotal > alivePlayers then
			expectedTotal = alivePlayers
		end
		self:Unschedule(sortToxin)
		if #reactiveIcons == expectedTotal then
			sortToxin(self)
		end
		self:Schedule(0.5, sortToxin, self)--Fallback in case scaling targets for normal/heroic
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
			specWarnConcentratedToxin:Play("runout")
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
			yellAbyssalInfusion:Yell(icon)
			yellAbyssalInfusionFades:Countdown(spellId, nil, icon)
		end
		warnAbyssalInfusion:CombinedShow(1, args.destName)
		self.vb.infusionIcon = self.vb.infusionIcon + 1
	elseif spellId == 438974 then
		if self:AntiSpam(5, 5) then
			--In case targeting goes out before cast start, we want to make sure icons reset on first target
			self.vb.royalCondomIcon = 1
		end
		local icon = marksOrder[self.vb.royalCondomIcon]
		if self.Options.SetIconOnRoyalCondemnation then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnRoyalCondemnation:Show(self:IconNumToTexture(icon))
			specWarnRoyalCondemnation:Play("mm"..icon)
			yellRoyalCondemnation:Yell(icon)
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
	elseif spellId == 451832 then
		self.vb.cataEvoActivated = true
		specWarnCataclysmicEvolution:Show(args.destName)
		specWarnCataclysmicEvolution:Play("stilldanger")
	elseif spellId == 464638 and args:IsPlayer() then
		warnFrothyToxin:Cancel()
		warnFrothyToxin:Schedule(1.5, 1)
	elseif spellId == 441556 and args:IsPlayer() then
		warnReactionVapor:Show(1)
	--elseif spellId == 455404 then
	--	if not args:IsPlayer() then
	--		specWarnFeastTaunt:Show(args.destName)
	--		specWarnFeastTaunt:Play("tauntboss")
	--	end
	elseif spellId == 445013 then--Dark barrier (perfect GUID matching for acolyte spawns
		if self.Options.SetIconOnQueensSummon then
			self:ScanForMobs(args.destGUID, 2, addMarks[self.vb.queensSummonIcon], 1, nil, 12, "SetIconOnQueensSummon")
		end
		self.vb.queensSummonIcon = self.vb.queensSummonIcon + 1
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	if spellId == 449236 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount % 10 == 0 then
				if args:IsPlayer() and args.amount >= 30 then
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
		local amount = args.amount or 1
		if amount % 6 == 0 then
			warnGorge:Show(args.destName, args.amount)
		end
	elseif spellId == 464638 and args:IsPlayer() then
		--if amount % 5 == 0 then
			warnFrothyToxin:Cancel()
			warnFrothyToxin:Schedule(1.5, args.amount)
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
		if self.Options.SetIconOnToxin and self.vb.ToxinBehavior ~= "DisableAllForRaid" then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 447207 then--Predation Shield
		self:SetStage(2)
		self.vb.wrestCount = 0
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		timerWrestCD:Stop()
		--timerWrestCD:Start(allTimers[savedDifficulty][2][450191][1], 1)
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
	elseif spellId == 445013 then--Dark Barrier Removed
		local uId = DBM:GetUnitIdFromGUID(args.destGUID)
		local _, _, _, _, _, _, _, _, castingSpellID = UnitCastingInfo(uId)
		if castingSpellID and castingSpellID == 445021 then
			if self:CheckInterruptFilter(args.destGUID, false, false) then--Count interrupt, so cooldown is not checked
				local count = castsPerGUID[args.destGUID] or 1
				specWarnNullDetonation:Show(args.sourceName, count)
				if count < 6 then
					specWarnNullDetonation:Play("kick"..count.."r")
				else
					specWarnNullDetonation:Play("kickcast")
				end
			end
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
		--TODO scope this
		if self:AntiSpam(3, 6) then
			warnGloomEruption:Show()
			warnGloomEruption:Play("getknockedup")
			timerGloomEruption:Start(self:IsEasy() and 7 or 6)
		end
		--Better place to start Stage 2 wrest timer
		if self.vb.wrestCount == 0 then
			timerWrestCD:Stop()
			timerWrestCD:Start(self:IsEasy() and 12.9 or 11.9, 1)
		end
	--elseif cid == 223318 then--Devoted Worshipper

	elseif cid == 223204 then--Chamber Guardian
		timerOustCD:Stop(args.destGUID)
	elseif cid == 221863 then--cycle-warden--Summoned Acolyte
		timerNullDetonationCD:Stop(nil, args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 446202 and self:IsStory() and self:AntiSpam(5, 7) then
		if self:GetStage(1) then
			--In story she skips 1.5 and goes into stage 2, but stage 2 in story is adds teleporting down and not players going up
			self:SetStage(2)
			self.vb.wrestCount = 0
			timerReactiveToxinCD:Stop()
			timerVenomNovaCD:Stop()
			timerSilkenTombCD:Stop()
			timerLiquefyCD:Stop()
			timerPredationCD:Stop()
		--	timerFeastCD:Stop()
			timerWebBladesCD:Stop()
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
			warnPhase:Play("ptwo")
		end
	end
end

function mod:OnSync(msg)
	if self:IsLFR() then return end
	if msg == "MatchBW" then
		self.vb.ToxinBehavior = "MatchBW"
	elseif msg == "UseAllAscending" then
		self.vb.ToxinBehavior = "UseAllAscending"
	elseif msg == "DisableIconsForRaid" then
		self.vb.ToxinBehavior = "DisableIconsForRaid"
	elseif msg == "DisableAllForRaid" then
		self.vb.ToxinBehavior = "DisableAllForRaid"
	end
end
