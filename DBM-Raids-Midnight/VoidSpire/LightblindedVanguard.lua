local mod	= DBM:NewMod(2737, "DBM-Raids-Midnight", 3, 1307)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(250589)--War Chaplain Senn main boss, 250588 Commander Venel Lightblood, 250587 general Amias Bellamy
mod:SetEncounterID(3180)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2912)

mod:RegisterCombat("combat")

--NOTE, 1251886 is tied to a now removed spell from game, so eventID 72 useless
--NOTE, https://www.wowhead.com/beta/spell=1249130/elekk-charge is a private aura on the boss
local warnAuraofDevotion					= mod:NewCountAnnounce(1246162, 2)
local warnZealousSpirit						= mod:NewCountAnnounce(1276243, 2)

local specWarnAuraofPeace					= mod:NewSpecialWarningDodgeCount(1248451, nil, nil, nil, 2, 2)
local specWarnSacredShield					= mod:NewSpecialWarningCount(1249260, nil, nil, nil, 2, 2)
local specWarnElekkCharge					= mod:NewSpecialWarningDodge(1249130, nil, nil, nil, 2, 2)--Part of sacred shield
mod:GroupSpells(1249260, 1249130)--Sacred Shield + Elekk Charge
local specWarnSearingRadiance				= mod:NewSpecialWarningCount(1255738, nil, nil, nil, 2, 2)
local specWarnJudgementShield				= mod:NewSpecialWarningCount(1251857, nil, nil, nil, 2, 2)
local specWarnDivineToll					= mod:NewSpecialWarningCount(1248652, nil, nil, nil, 2, 2)
local specWarnAuraofWrath					= mod:NewSpecialWarningCount(1248449, nil, nil, nil, 2, 2)
local specWarnjudgementFinal				= mod:NewSpecialWarningCount(1246736, nil, nil, nil, 2, 2)
local specWarnDivineStorm					= mod:NewSpecialWarningCount(1246765, "Melee", nil, nil, 2, 2)--review default later
local specWarnSacredToll					= mod:NewSpecialWarningCount(1246749, nil, nil, nil, 2, 2)
local specWarnExecutionSentence				= mod:NewSpecialWarningSoakCount(1276368, nil, nil, nil, 2, 2)

local timerAuraofPeaceCD					= mod:NewCDCountTimer(20.5, 1248451, nil, nil, nil, 3)
local timerSacredShieldCD					= mod:NewCDCountTimer(20.5, 1249260, nil, nil, nil, 5)
--local timerElekkChargeCD					= mod:NewCDCountTimer(20.5, 1249130, nil, nil, nil, 3)--redundant
local timerTyrsWrathCD						= mod:NewCDCountTimer(20.5, 1248721, nil, nil, nil, 3)
local timerAuraofDevotionCD					= mod:NewCDCountTimer(20.5, 1246162, nil, nil, nil, 3)
local timerSearingRadianceCD				= mod:NewCDCountTimer(20.5, 1255738, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerJudgementShieldCD				= mod:NewCDCountTimer(20.5, 1251857, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerAvengerShieldCD					= mod:NewCDCountTimer(20.5, 1246487, nil, nil, nil, 3)
local timerDivineTollCD						= mod:NewCDCountTimer(20.5, 1248652, nil, nil, nil, 3)
local timerAuraofWrathCD					= mod:NewCDCountTimer(20.5, 1248449, nil, nil, nil, 5)
local timerjudgementFinalCD					= mod:NewCDCountTimer(20.5, 1246736, nil, "Tank", nil, 5)
local timerDivineStormCD					= mod:NewCDCountTimer(20.5, 1246765, nil, nil, nil, 3)
local timerSacredTollCD						= mod:NewCDCountTimer(20.5, 1246749, nil, nil, nil, 2)
local timerExecutionSentenceCD				= mod:NewCDCountTimer(20.5, 1276368, nil, nil, nil, 3)
local timerZealousSpiritCD					= mod:NewCDCountTimer(20.5, 1276243, nil, nil, nil, 6, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddPrivateAuraSoundOption(1276982, true, 1276982, 1, 2, "watchfeet", 8)--Divine Consecration (mythic version) (drops under various auras)
mod:AddPrivateAuraSoundOption(1246158, true, 1246158, 1, 2, "watchfeet", 8)--Consecration (non mythic version) (drops under various auras)
mod:AddPrivateAuraSoundOption(1248721, true, 1248721, 1, 1, "absorbyou", 19)--Tyrs Wrath
mod:AddPrivateAuraSoundOption(1251857, true, 1251857, 1, 3, "debuffyou", 17)--Judgement for Shield of the Righteous
mod:AddPrivateAuraSoundOption(1246487, true, 1246487, 1, 1, "scatter", 2)--Avenger's Shield
mod:AddPrivateAuraSoundOption(1246502, false, 1246487, 1, 3, "debuffyou", 17)--Avenger's Shield DOT
mod:AddPrivateAuraSoundOption(1248652, true, 1248652, 1, 1, "debuffyou", 17)--Divine Toll
mod:AddPrivateAuraSoundOption(1246736, true, 1246736, 1, 3, "debuffyou", 17)--Judgement for Final Verdict
mod:AddPrivateAuraSoundOption({1248985,1248994}, true, 1276368, 1, 1, "gathershare", 2)--Execution Sentence targets
mod:AddPrivateAuraSoundOption({1249008,1249024}, false, 1276368, 1, 3, "debuffyou", 17)--Execution Sentence Soak debuff
mod:AddPrivateAuraSoundOption(1272324, true, 1246765, 1, 2, "watchfeet", 8)--Divine Tempest (GTFO from empowered divine storm)

mod.vb.auraofPeaceCount = 0
mod.vb.sacredShieldCount = 0
mod.vb.tyrsWrathCount = 0
mod.vb.auraofDevotionCount = 0
mod.vb.searingRadianceCount = 0
mod.vb.judgementShieldCount = 0
mod.vb.avengerShieldCount = 0
mod.vb.divineTollCount = 0
mod.vb.auraofWrathCount = 0
mod.vb.judgementFinalCount = 0
mod.vb.divineStormCount = 0
mod.vb.sacredTollCount = 0
mod.vb.executionSentenceCount = 0
mod.vb.zealousSpiritCount = 0

function mod:OnLimitedCombatStart()
	self.vb.auraofPeaceCount = 0
	self.vb.sacredShieldCount = 0
	self.vb.tyrsWrathCount = 0
	self.vb.auraofDevotionCount = 0
	self.vb.searingRadianceCount = 0
	self.vb.judgementShieldCount = 0
	self.vb.avengerShieldCount = 0
	self.vb.divineTollCount = 0
	self.vb.auraofWrathCount = 0
	self.vb.judgementFinalCount = 0
	self.vb.divineStormCount = 0
	self.vb.sacredTollCount = 0
	self.vb.executionSentenceCount = 0
	self.vb.zealousSpiritCount = 0
	--TODO, hardcoded features

	--Blizz API fallbacks
	specWarnAuraofPeace:SetAlert(71, "peaceaura", 19, 2)
	timerAuraofPeaceCD:SetTimeline(71)
	specWarnElekkCharge:SetAlert(73, "chargemove", 2, 2, 0)
--	timerElekkChargeCD:SetTimeline(73)
	specWarnSacredShield:SetAlert(74, "attackshield", 2, 2)
	timerSacredShieldCD:SetTimeline(74)
	timerTyrsWrathCD:SetTimeline(75)
	warnAuraofDevotion:SetAlert(76, "devotionaura", 19, 2)
	timerAuraofDevotionCD:SetTimeline(76)
	specWarnSearingRadiance:SetAlert({77,373}, "aesoon", 2, 2)
	timerSearingRadianceCD:SetTimeline({77,373})--Normal, mythic empowered
	if self:IsTank() then
		specWarnJudgementShield:SetAlert(78, "changemt", 2, 2)
	end
	timerJudgementShieldCD:SetTimeline(78)
	timerAvengerShieldCD:SetTimeline({79, 365})--Normal, mythic empowered
	specWarnDivineToll:SetAlert(80, "watchstep", 2, 3)
	timerDivineTollCD:SetTimeline(80)
	specWarnAuraofWrath:SetAlert(81, "wrathaura", 19, 4)
	timerAuraofWrathCD:SetTimeline(81)
	if self:IsTank() then
		specWarnjudgementFinal:SetAlert(82, "changemt", 2, 2)
	end
	timerjudgementFinalCD:SetTimeline(82)
	specWarnDivineStorm:SetAlert({83,374}, "justrun", 2, 3)--very iffy
	timerDivineStormCD:SetTimeline({83,374})--Normal, mythic empowered
	specWarnSacredToll:SetAlert(84, "aesoon", 2, 2)
	timerSacredTollCD:SetTimeline(84)
	specWarnExecutionSentence:SetAlert(85, "soakincoming", 19, 2)
	timerExecutionSentenceCD:SetTimeline(85)
	warnZealousSpirit:SetAlert({358,359,360}, "phasechange", 2, 2)
	timerZealousSpiritCD:SetTimeline({358,359,360})--one for each boss

end

--[[
--Note, bar stage changing and canceling is handled by core
function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
	if eventInfo.source ~= 0 then return end
	local eventID = eventInfo.id
--	local eventState = C_EncounterTimeline.GetEventState(eventID)
	local timer = math.floor(eventInfo.duration + 0.5)
end
--]]
