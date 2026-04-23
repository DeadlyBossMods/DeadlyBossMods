local mod	= DBM:NewMod(2737, "DBM-Raids-Midnight", 3, 1307)
local L		= mod:GetLocalizedStrings()

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
local specWarnSacredShield					= mod:NewSpecialWarningCount(1248674, nil, nil, nil, 2, 2)
--local specWarnElekkCharge					= mod:NewSpecialWarningDodge(1249130, nil, nil, nil, 2, 2)--Part of sacred shield
--mod:GroupSpells(1248674, 1249130)--Sacred Shield + Elekk Charge
local specWarnSearingRadiance				= mod:NewSpecialWarningCount(1255738, nil, nil, nil, 2, 2)
local specWarnEmpoweredSearingRadiance		= mod:NewSpecialWarningCount(1276639, nil, nil, nil, 2, 2, 4)--Mythic empowered version
local specWarnJudgementShield				= mod:NewSpecialWarningCount(1251857, nil, nil, L.JudgementShield, 2, 2)
local specWarnDivineToll					= mod:NewSpecialWarningDodgeCount(1248652, nil, nil, DBM_COMMON_L.DODGES, 2, 2)
local specWarnAuraofWrath					= mod:NewSpecialWarningCount(1248449, nil, nil, nil, 2, 2)
local specWarnjudgementFinal				= mod:NewSpecialWarningCount(1246736, nil, nil, L.JudgementFV, 2, 2)
local specWarnDivineStorm					= mod:NewSpecialWarningCount(1246765, "MeleeDps", nil, nil, 2, 2)--review default later
local specWarnEmpoweredDivineStorm			= mod:NewSpecialWarningCount(1272310, "MeleeDps", nil, nil, 2, 2, 4)--Mythic empowered version
local specWarnSacredToll					= mod:NewSpecialWarningCount(1246749, nil, nil, DBM_COMMON_L.AOEDAMAGE, 2, 2)
local specWarnExecutionSentence				= mod:NewSpecialWarningSoakCount(1276368, nil, nil, DBM_COMMON_L.GROUPSOAKS, 2, 2)

local timerAuraofPeaceCD					= mod:NewCDCountTimer(20.5, 1248451, nil, nil, nil, 3, nil, DBM_COMMON_L.IMPORTANT_ICON)
local timerSacredShieldCD					= mod:NewCDCountTimer(20.5, 1248674, nil, nil, nil, 5)
--local timerElekkChargeCD					= mod:NewCDCountTimer(20.5, 1249130, nil, nil, nil, 3)--redundant
local timerTyrsWrathCD						= mod:NewCDCountTimer(20.5, 1248721, DBM_COMMON_L.HEALABSORBS.." (%s)", "Healer", nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerAuraofDevotionCD					= mod:NewCDCountTimer(20.5, 1246162, nil, nil, nil, 3, nil, DBM_COMMON_L.IMPORTANT_ICON)
local timerSearingRadianceCD				= mod:NewCDCountTimer(20.5, 1255738, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerEmpoweredSearingRadianceCD		= mod:NewCDCountTimer(20.5, 1276639, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON..DBM_COMMON_L.HEALER_ICON)
local timerJudgementShieldCD				= mod:NewCDCountTimer(20.5, 1251857, L.JudgementShield.." (%s)", "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerAvengerShieldCD					= mod:NewCDCountTimer(20.5, 1246485, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerEmpoweredAvengerShieldCD			= mod:NewCDCountTimer(20.5, 1276635, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerDivineTollCD						= mod:NewCDCountTimer(20.5, 1248652, DBM_COMMON_L.DODGES.." (%s)", nil, nil, 3)
local timerAuraofWrathCD					= mod:NewCDCountTimer(20.5, 1248449, nil, nil, nil, 5, nil, DBM_COMMON_L.IMPORTANT_ICON)
local timerjudgementFinalCD					= mod:NewCDCountTimer(20.5, 1246736, L.JudgementFV.." (%s)", "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerDivineStormCD					= mod:NewCDCountTimer(20.5, 1246765, nil, nil, nil, 3)
local timerEmpoweredDivineStormCD			= mod:NewCDCountTimer(20.5, 1272310, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerSacredTollCD						= mod:NewCDCountTimer(20.5, 1246749, DBM_COMMON_L.AOEDAMAGE.." (%s)", nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerExecutionSentenceCD				= mod:NewCDCountTimer(20.5, 1276368, DBM_COMMON_L.GROUPSOAKS.." (%s)", nil, nil, 3)
local timerZealousSpiritCD					= mod:NewCDCountTimer("d20.5", 1276243, nil, nil, nil, 6, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddPrivateAuraSoundOption(1276982, true, 1276982, 1, 2, "watchfeet", 8)--Divine Consecration (mythic version) (drops under various auras)
mod:AddPrivateAuraSoundOption(1246158, true, 1246158, 1, 2, "watchfeet", 8)--Consecration (non mythic version) (drops under various auras)
mod:AddPrivateAuraSoundOption(1248721, true, 1248721, 1, 1, "absorbyou", 19)--Tyrs Wrath
mod:AddPrivateAuraSoundOption(1251857, true, 1251857, 1, 3, "debuffyou", 17)--Judgement for Shield of the Righteous
mod:AddPrivateAuraSoundOption(1246487, true, 1246485, 1, 1, "scatter", 2)--Avenger's Shield
mod:AddPrivateAuraSoundOption(1246502, false, 1246485, 1, 3, "debuffyou", 17)--Avenger's Shield DOT
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
mod.vb.empoweredDivineStormCount = 0
mod.vb.empoweredAvengerShieldCount = 0
mod.vb.empoweredSearingRadianceCount = 0
local badStateDetected = false
local timer17Count = 0
local timer20Count = 0
local timer23Count = 0
local timer40Count = 0
local timer42Count = 0
local timer92Count = 0
local timer172Count = 0
local timer174Count = 0
local timer175Count = 0
local timer15Count = 0
local timer16Count = 0
local timer22Count = 0
local timer24Count = 0
local timer45Count = 0
local timer50Count = 0
local timer52Count = 0
local timer53Count = 0
local timer60Count = 0
local timer7Count = 0
local timer18Count = 0
local timer36Count = 0
local timer54Count = 0
local timer57Count = 0
local timer72Count = 0
local timer159Count = 0
local timer162Count = 0
local timer159Uses156Variant = false
local timer159Uses172Variant = false

---@param self DBMMod
	---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		specWarnAuraofPeace:SetAlert(71, "peaceaura", 19, 2)
		specWarnSacredShield:SetAlert(74, "attackshield", 2, 2)
		warnAuraofDevotion:SetAlert(76, "devotionaura", 19, 2)
		specWarnSearingRadiance:SetAlert({77,373}, "aesoon", 2, 2)
		if self:IsTank() then
			specWarnJudgementShield:SetAlert(78, "changemt", 2, 2)
		end
		specWarnDivineToll:SetAlert(80, "watchstep", 2, 3)
		specWarnAuraofWrath:SetAlert(81, "wrathaura", 19, 4)
		if self:IsTank() then
			specWarnjudgementFinal:SetAlert(82, "changemt", 2, 2)
		end
		specWarnDivineStorm:SetAlert({83,374}, "justrun", 2, 3)--very iffy
		specWarnSacredToll:SetAlert(84, "aesoon", 2, 2)
		specWarnExecutionSentence:SetAlert(85, "soakincoming", 19, 2)
		warnZealousSpirit:SetAlert({358,359,360}, "phasechange", 2, 2)
	end
	timerAuraofPeaceCD:SetTimeline(71)
--	specWarnElekkCharge:SetAlert(73, "chargemove", 2, 2, 0)
--	timerElekkChargeCD:SetTimeline(73)
	timerSacredShieldCD:SetTimeline(74)
	timerTyrsWrathCD:SetTimeline(75)
	timerAuraofDevotionCD:SetTimeline(76)
	timerSearingRadianceCD:SetTimeline(77)--Normal, mythic empowered
	timerEmpoweredSearingRadianceCD:SetTimeline(373)--mythic empowered
	timerJudgementShieldCD:SetTimeline(78)
	timerAvengerShieldCD:SetTimeline({79, 365})--Normal, mythic empowered
	timerDivineTollCD:SetTimeline(80)
	timerAuraofWrathCD:SetTimeline(81)
	timerjudgementFinalCD:SetTimeline(82)
	timerDivineStormCD:SetTimeline({83,374})--Normal, mythic empowered
	timerSacredTollCD:SetTimeline(84)
	timerExecutionSentenceCD:SetTimeline(85)
	timerZealousSpiritCD:SetTimeline({358,359,360})--one for each boss
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
	self.vb.auraofPeaceCount = 1
	self.vb.sacredShieldCount = 1
	self.vb.tyrsWrathCount = 1
	self.vb.auraofDevotionCount = 1
	self.vb.searingRadianceCount = 1
	self.vb.judgementShieldCount = 1
	self.vb.avengerShieldCount = 1
	self.vb.divineTollCount = 1
	self.vb.auraofWrathCount = 1
	self.vb.judgementFinalCount = 1
	self.vb.divineStormCount = 1
	self.vb.sacredTollCount = 1
	self.vb.executionSentenceCount = 1
	self.vb.zealousSpiritCount = 1
	self.vb.empoweredDivineStormCount = 1
	self.vb.empoweredAvengerShieldCount = 1
	self.vb.empoweredSearingRadianceCount = 1
	timer17Count = 0
	timer20Count = 0
	timer23Count = 0
	timer40Count = 0
	timer42Count = 0
	timer92Count = 0
	timer172Count = 0
	timer174Count = 0
	timer175Count = 0
	timer15Count = 0
	timer16Count = 0
	timer22Count = 0
	timer24Count = 0
	timer45Count = 0
	timer50Count = 0
	timer52Count = 0
	timer53Count = 0
	timer60Count = 0
	timer7Count = 0
	timer18Count = 0
	timer36Count = 0
	timer54Count = 0
	timer57Count = 0
	timer72Count = 0
	timer159Count = 0
	timer162Count = 0
	timer159Uses156Variant = false
	timer159Uses172Variant = false
	--Use FixBlizzardAPI to force fight to only show bars < 60 seconds by default since blizzard EXCESSIVELY overschedules timers on this fight
	self:FixBlizzardAPI()
	if DBM.Options.HardcodedTimer and (self:IsEasy() or self:IsHeroic() or self:IsMythic()) and not badStateDetected then
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		)
		if DBM.Options.HideDBMBars then
			setFallback(self, true)
		end
	else
		setFallback(self)
	end
end

function mod:OnCombatEnd()
	self:TLCountReset()
	timer17Count = 0
	timer20Count = 0
	timer23Count = 0
	timer40Count = 0
	timer42Count = 0
	timer92Count = 0
	timer172Count = 0
	timer174Count = 0
	timer175Count = 0
	timer15Count = 0
	timer16Count = 0
	timer22Count = 0
	timer24Count = 0
	timer45Count = 0
	timer50Count = 0
	timer52Count = 0
	timer53Count = 0
	timer60Count = 0
	timer7Count = 0
	timer18Count = 0
	timer36Count = 0
	timer54Count = 0
	timer57Count = 0
	timer72Count = 0
	timer159Count = 0
	timer162Count = 0
	timer159Uses156Variant = false
	timer159Uses172Variant = false
	self:UnregisterShortTermEvents()
end

do
	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersEasy(self, timer, timerExact, eventID)
		--Logic confirmed against LFR Week2 logs
		if timer == 131 then--Aura of Peace
			timerAuraofPeaceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraPeace", "auraofPeaceCount"))
		elseif timer == 86 then--Execution Sentence opener
			timerExecutionSentenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "executionSentence", "executionSentenceCount"))
		elseif timer == 83 then--Aura of Wrath opener
			timerAuraofWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraWrath", "auraofWrathCount"))
		elseif timer == 68 or timer == 66 or timer == 51 or timer == 46 or timer == 32 or timer == 29 or timer == 21 then--Sacred Shield
			timerSacredShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredShield", "sacredShieldCount"))
		elseif timer == 67 or timer == 48 or timer == 43 or timer == 41 or timer == 10 then--Avenger's Shield
			timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
		elseif timer == 38 then--Divine Toll opener
			timerDivineTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineToll", "divineTollCount"))
		elseif timer == 35 then--Aura of Devotion opener
			timerAuraofDevotionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraDevotion", "auraofDevotionCount"))
		elseif timer == 62 then--Sacred Toll
			timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
		elseif timer == 30 then--Judgement (Final Verdict)
			timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
		elseif timer == 26 then--Judgement (Shield)
			timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
		elseif timer == 17 then--Sacred Shield opener, later Avenger's Shield
			timer17Count = timer17Count + 1
			if timer17Count == 1 then
				timerSacredShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredShield", "sacredShieldCount"))
			else
				timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
			end
		elseif timer == 23 then--Sacred Toll opener, later Avenger's Shield
			timer23Count = timer23Count + 1
			if timer23Count == 1 then
				timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
			else
				timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
			end
		elseif timer == 42 then--Judgement pair (Shield then Final)
			timer42Count = timer42Count + 1
			if timer42Count % 2 == 1 then
				timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
			else
				timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
			end
		elseif timer == 40 then--Two Judgements then Sacred Toll
			timer40Count = timer40Count + 1
			if timer40Count <= 2 then
				if timer40Count % 2 == 1 then
					timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
				else
					timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
				end
			else
				timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
			end
		elseif timer == 92 then--Judgement pair (Shield then Final)
			timer92Count = timer92Count + 1
			if timer92Count == 1 then
				timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
			else
				timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
			end
		elseif timer == 174 then--Aura of Devotion then Divine Toll
			timer174Count = timer174Count + 1
			if timer174Count == 1 then
				timerAuraofDevotionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraDevotion", "auraofDevotionCount"))
			else
				timerDivineTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineToll", "divineTollCount"))
			end
		elseif timer == 172 then--Aura of Devotion then Divine Toll
			timer172Count = timer172Count + 1
			if timer172Count == 1 then
				timerAuraofDevotionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraDevotion", "auraofDevotionCount"))
			else
				timerDivineTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineToll", "divineTollCount"))
			end
		elseif timer == 175 then--Aura of Wrath, Execution Sentence, Aura of Peace
			timer175Count = timer175Count + 1
			if timer175Count == 1 then
				timerAuraofWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraWrath", "auraofWrathCount"))
			elseif timer175Count == 2 then
				timerExecutionSentenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "executionSentence", "executionSentenceCount"))
			else
				timerAuraofPeaceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraPeace", "auraofPeaceCount"))
			end
		elseif timer == 20 then
			--Observed LFR Week2 20s sequence (single full pull):
			--1 ST, 2 ST, 3 JS, 4 JF, 5 ST, 6 JS, 7 JF, 8 AV, 9 JS, 10 JF, 11 AV, 12 JS, 13 JF, 14 ST, 15 ST
			timer20Count = timer20Count + 1
			if timer20Count == 1 or timer20Count == 2 or timer20Count == 5 or timer20Count == 14 or timer20Count == 15 then
				timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
			elseif timer20Count == 3 or timer20Count == 6 or timer20Count == 9 or timer20Count == 12 then
				timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
			elseif timer20Count == 4 or timer20Count == 7 or timer20Count == 10 or timer20Count == 13 then
				timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
			elseif timer20Count == 8 or timer20Count == 11 then
				timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
			else
				--Unexpected additional 20s outside observed sequence
				if not DBM.Options.DebugMode then
					badStateDetected = true
					self:ResumeBlizzardAPI()
					self:UnregisterShortTermEvents()
					setFallback(self)
					DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
				else
					DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
				end
			end
		else--Reached end of chain without finding a valid timer, this means hardcode mod has failed, so we need to disable hardcoded features and fall back to blizz API
			if not DBM.Options.DebugMode then
				badStateDetected = true
				self:ResumeBlizzardAPI()
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			else
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
			end
		end
	end

	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersHeroic(self, timer, timerExact, eventID)
		--Logic confirmed against Heroic Week3 logs
		if timer == 131 then--Aura of Peace (opener)
			timerAuraofPeaceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraPeace", "auraofPeaceCount"))
		elseif timer == 86 then--Execution Sentence (opener)
			timerExecutionSentenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "executionSentence", "executionSentenceCount"))
		elseif timer == 83 then--Aura of Wrath (opener)
			timerAuraofWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraWrath", "auraofWrathCount"))
		elseif timer == 10 then--Sacred Toll (opener)
			timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
		elseif timer == 18 then--Divine Storm (opener)
			timerDivineStormCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineStorm", "divineStormCount"))
		elseif timer == 26 then--Judgement Shield (opener)
			timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
		elseif timer == 30 then--Judgement Final (opener)
			timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
		elseif timer == 35 then--Aura of Devotion (opener)
			timerAuraofDevotionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraDevotion", "auraofDevotionCount"))
		elseif timer == 38 then--Divine Toll (opener)
			timerDivineTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineToll", "divineTollCount"))
		elseif timer == 47 then--Searing Radiance (opener)
			timerSearingRadianceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "searingRadiance", "searingRadianceCount"))
		elseif timer == 176 then--Aura of Peace
			timerAuraofPeaceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraPeace", "auraofPeaceCount"))
		elseif timer == 12 then--Avenger's Shield
			timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
		elseif timer == 13 then--Sacred Toll
			timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
		elseif timer == 19 then--Divine Storm
			timerDivineStormCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineStorm", "divineStormCount"))
		elseif timer == 21 then--Sacred Toll
			timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
		elseif timer == 25 then--Avenger's Shield
			timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
		elseif timer == 39 then--Sacred Toll
			timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
		elseif timer == 43 then--Divine Storm
			timerDivineStormCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineStorm", "divineStormCount"))
		elseif timer == 57 then--Sacred Shield
			timerSacredShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredShield", "sacredShieldCount"))
		elseif timer == 59 then--Sacred Toll
			timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
		elseif timer == 62 then--Sacred Shield
			timerSacredShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredShield", "sacredShieldCount"))
		elseif timer == 65 then--Avenger's Shield
			timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
		elseif timer == 72 then--Sacred Toll
			timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
		elseif timer == 82 then--Searing Radiance
			timerSearingRadianceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "searingRadiance", "searingRadianceCount"))
		elseif timer == 87 then--Sacred Shield
			timerSacredShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredShield", "sacredShieldCount"))
		elseif timer == 130 then--Searing Radiance
			timerSearingRadianceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "searingRadiance", "searingRadianceCount"))
		elseif timer == 15 then--Opener Avenger's Shield, then Sacred Toll, Divine Storm, Avenger's Shield
			timer15Count = timer15Count + 1
			if timer15Count == 1 then
				timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
			elseif timer15Count == 2 then
				timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
			elseif timer15Count == 3 then
				timerDivineStormCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineStorm", "divineStormCount"))
			else
				timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
			end
		elseif timer == 16 then--Judgement pair (Shield then Final)
			timer16Count = timer16Count + 1
			if timer16Count % 2 == 1 then
				timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
			else
				timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
			end
		elseif timer == 17 then--Sacred Shield opener, then Avenger's Shield
			timer17Count = timer17Count + 1
			if timer17Count == 1 then
				timerSacredShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredShield", "sacredShieldCount"))
			else
				timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
			end
		elseif timer == 22 then--Divine Storm, then Avenger's Shield
			timer22Count = timer22Count + 1
			if timer22Count == 1 then
				timerDivineStormCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineStorm", "divineStormCount"))
			else
				timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
			end
		elseif timer == 23 then--Sacred Toll, then Judgement Shield, Judgement Final
			timer23Count = timer23Count + 1
			if timer23Count == 1 then
				timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
			elseif timer23Count == 2 then
				timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
			else
				timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
			end
		elseif timer == 24 then--Judgement pair (Shield then Final)
			timer24Count = timer24Count + 1
			if timer24Count % 2 == 1 then
				timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
			else
				timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
			end
		elseif timer == 40 then--Judgement pair (Shield then Final)
			timer40Count = timer40Count + 1
			if timer40Count % 2 == 1 then
				timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
			else
				timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
			end
		elseif timer == 42 then--Judgement pair (Shield then Final)
			timer42Count = timer42Count + 1
			if timer42Count % 2 == 1 then
				timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
			else
				timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
			end
		elseif timer == 45 then--Divine Storm then Sacred Toll
			timer45Count = timer45Count + 1
			if timer45Count == 1 then
				timerDivineStormCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineStorm", "divineStormCount"))
			else
				timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
			end
		elseif timer == 50 then--Sacred Shield then Divine Storm
			timer50Count = timer50Count + 1
			if timer50Count == 1 then
				timerSacredShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredShield", "sacredShieldCount"))
			else
				timerDivineStormCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineStorm", "divineStormCount"))
			end
		elseif timer == 52 then--Searing Radiance, Judgement Shield, Judgement Final
			timer52Count = timer52Count + 1
			if timer52Count == 1 then
				timerSearingRadianceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "searingRadiance", "searingRadianceCount"))
			elseif timer52Count == 2 then
				timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
			else
				timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
			end
		elseif timer == 53 then--Searing Radiance, Avenger's Shield, Sacred Shield
			timer53Count = timer53Count + 1
			if timer53Count == 1 then
				timerSearingRadianceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "searingRadiance", "searingRadianceCount"))
			elseif timer53Count == 2 then
				timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
			else
				timerSacredShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredShield", "sacredShieldCount"))
			end
		elseif timer == 60 then--Judgement Shield, Judgement Final, Sacred Shield
			timer60Count = timer60Count + 1
			if timer60Count == 1 then
				timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
			elseif timer60Count == 2 then
				timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
			else
				timerSacredShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredShield", "sacredShieldCount"))
			end
		elseif timer == 172 then--Aura of Wrath, Execution Sentence, Aura of Peace
			timer172Count = timer172Count + 1
			if timer172Count == 1 then
				timerAuraofWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraWrath", "auraofWrathCount"))
			elseif timer172Count == 2 then
				timerExecutionSentenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "executionSentence", "executionSentenceCount"))
			else
				timerAuraofPeaceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraPeace", "auraofPeaceCount"))
			end
		elseif timer == 174 then--Aura of Devotion, Divine Toll alternating
			timer174Count = timer174Count + 1
			if timer174Count % 2 == 1 then
				timerAuraofDevotionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraDevotion", "auraofDevotionCount"))
			else
				timerDivineTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineToll", "divineTollCount"))
			end
		elseif timer == 175 then--Aura of Wrath then Execution Sentence
			timer175Count = timer175Count + 1
			if timer175Count == 1 then
				timerAuraofWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraWrath", "auraofWrathCount"))
			else
				timerExecutionSentenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "executionSentence", "executionSentenceCount"))
			end
		elseif timer == 20 then
			--Observed Heroic Week3 20s sequence (single full pull):
			--1 DS, 2 ST, 3 DS, 4 ST, 5 AS, 6 AS, 7 JS, 8 JF, 9 AS, 10 JS, 11 JF, 12 AS, 13 DS, 14 DS, 15 ST, 16 DS, 17 JS, 18 JF, 19 DS, 20 DS
			timer20Count = timer20Count + 1
			if timer20Count == 1 or timer20Count == 3 or timer20Count == 13 or timer20Count == 14 or timer20Count == 16 or timer20Count == 19 or timer20Count == 20 then
				timerDivineStormCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineStorm", "divineStormCount"))
			elseif timer20Count == 2 or timer20Count == 4 or timer20Count == 15 then
				timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
			elseif timer20Count == 5 or timer20Count == 6 or timer20Count == 9 or timer20Count == 12 then
				timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
			elseif timer20Count == 7 or timer20Count == 10 or timer20Count == 17 then
				timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
			elseif timer20Count == 8 or timer20Count == 11 or timer20Count == 18 then
				timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
			else
				--Unexpected additional 20s outside observed sequence
				if not DBM.Options.DebugMode then
					badStateDetected = true
					self:ResumeBlizzardAPI()
					self:UnregisterShortTermEvents()
					setFallback(self)
					DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
				else
					DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
				end
			end
		else--Reached end of chain without finding a valid timer, this means hardcode mod has failed, so we need to disable hardcoded features and fall back to blizz API
			if not DBM.Options.DebugMode then
				badStateDetected = true
				self:ResumeBlizzardAPI()
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			else
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
			end
		end
	end

	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersMythic(self, timer, timerExact, eventID)
		--Logic confirmed against Mythic Week4 VanguardWipe3 logs
		--Divine Storm, Avenger's Shield, Searing Radiance have empowered and regular casts.
		--Empowered casts use different spellIds in logs (Divine Storm: 1272310, Avenger's Shield: 1276635, Searing Radiance: 1276639)
		if timer == 132 or timer == 158 then--Aura of Peace
			timerAuraofPeaceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraPeace", "auraofPeaceCount"))
		elseif timer == 135 then--Tyr's Wrath (opener)
			timerTyrsWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "tyrsWrath", "tyrsWrathCount"))
		elseif timer == 79 then--Aura of Wrath (opener)
			timerAuraofWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraWrath", "auraofWrathCount"))
		elseif timer == 82 then--Execution Sentence (opener)
			timerExecutionSentenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "executionSentence", "executionSentenceCount"))
		elseif timer == 26 then--Aura of Devotion (opener)
			timerAuraofDevotionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraDevotion", "auraofDevotionCount"))
		elseif timer == 29 then--Divine Toll (opener)
			timerDivineTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineToll", "divineTollCount"))
		elseif timer == 4 or timer == 110 then--Zealous Spirit
			if timer == 4 then
				--Concurrent schedule at T=0, first to be cast so no count adjustment
				timerZealousSpiritCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "zealousSpirit", "zealousSpiritCount"))
			else
				--Concurrent schedule at T=0, third one to be cast so count adjusted + 2
				timerZealousSpiritCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "zealousSpirit", "zealousSpiritCount")+2)
			end
		elseif timer == 58 then--Judgment Shield (opener)
			timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
		elseif timer == 62 then--Judgment Final (opener)
			timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
		elseif timer == 30 or self:IsRoundedTimer(timer, 44.5, 0.5) or self:IsRoundedTimer(timer, 51.5, 0.5) or timer == 61 or timer == 71 then--Sacred Shield
			timerSacredShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredShield", "sacredShieldCount"))
		elseif timer == 59 or timer == 50 or timer == 90 or timer == 119 or self:IsRoundedTimer(timer, 156.5, 0.5) or self:IsRoundedTimer(timer, 171.5, 0.5) then--Searing Radiance (regular and empowered variants)
			if self:IsRoundedTimer(timer, 156.5, 0.5) or self:IsRoundedTimer(timer, 171.5, 0.5) then
				if timer == 156 then
					timer159Uses156Variant = true
				elseif timer == 172 or timer == 157 then
					timer159Uses172Variant = true
				end
				--Empowered Cast (1276639)
				timerEmpoweredSearingRadianceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "empSearingRadiance", "empoweredSearingRadianceCount"))
			else
				timerSearingRadianceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "searingRadiance", "searingRadianceCount"))
			end
		elseif timer == 66 or timer == 6 or timer == 8 or self:IsRoundedTimer(timer, 11, 1) or timer == 14 or timer == 16 or timer == 75 or timer == 78 or timer == 91 then--Avenger's Shield (regular and empowered variants)
			if timer == 66 or timer == 91 then
				--Empowered Cast (1276635)
				timerEmpoweredAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "empAvengerShield", "empoweredAvengerShieldCount"))
			else
				timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
			end
		elseif timer == 123 or timer == 144 then--Divine Storm
			--Empowered Cast (1272310)
			timerEmpoweredDivineStormCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "empDivineStorm", "empoweredDivineStormCount"))
		elseif timer == 7 then--Searing Radiance opener, then Avenger's Shield
			timer7Count = timer7Count + 1
			if timer7Count == 1 then
				--Empowered Cast (1276639)
				timerEmpoweredSearingRadianceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "empSearingRadiance", "empoweredSearingRadianceCount"))
			else
				timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
			end
		elseif timer == 15 then--Divine Storm opener, then Avenger's Shield
			timer15Count = timer15Count + 1
			if timer15Count == 1 then
				timerDivineStormCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineStorm", "divineStormCount"))
			else
				timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
			end
		elseif timer == 20 then--Sacred Toll opener, then Avenger's Shield
			timer20Count = timer20Count + 1
			if timer20Count == 1 then
				timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
			else
				timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
			end
		elseif timer == 57 then--Zealous Spirit boss 2 opener, then Sacred Shield
			timer57Count = timer57Count + 1
			if timer57Count == 1 then
				--Concurrent schedule at T=0, second one to be cast so count adjusted + 1
				timerZealousSpiritCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "zealousSpirit", "zealousSpiritCount")+1)
			else
				timerSacredShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredShield", "sacredShieldCount"))
			end
		elseif timer == 72 then--Divine Storm, then Avenger's Shield empowered
			timer72Count = timer72Count + 1
			if timer72Count == 1 then
				timerDivineStormCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineStorm", "divineStormCount"))
			else
				timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
			end
		elseif timer == 162 then--Avenger's Shield empowered, Divine Storm empowered, Avenger's Shield empowered
			timer162Count = timer162Count + 1
			if timer162Count == 2 then
				--Empowered Cast (1272310)
				timerEmpoweredDivineStormCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "empDivineStorm", "empoweredDivineStormCount"))
			else
				--Empowered Cast (1276635)
				timerEmpoweredAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "empAvengerShield", "empoweredAvengerShieldCount"))
			end
		elseif timer == 36 then
			--Observed sequence: ST, JS, JF, ST, DS, DS, JS, JF
			timer36Count = timer36Count + 1
			if timer36Count == 1 or timer36Count == 4 then
				timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
			elseif timer36Count == 2 or timer36Count == 7 then
				timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
			elseif timer36Count == 3 or timer36Count == 8 then
				timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
			elseif timer36Count == 5 or timer36Count == 6 then
				timerDivineStormCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineStorm", "divineStormCount"))
			else
				if not DBM.Options.DebugMode then
					badStateDetected = true
					self:ResumeBlizzardAPI()
					self:UnregisterShortTermEvents()
					setFallback(self)
					DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
				else
					DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
				end
			end
		elseif timer == 54 then
			--Observed sequence: JS, JF, JS, JF, ST, JS, JF, JS, JF, ST, JS, JF
			timer54Count = timer54Count + 1
			if timer54Count == 1 or timer54Count == 3 or timer54Count == 6 or timer54Count == 8 or timer54Count == 11 then
				timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
			elseif timer54Count == 2 or timer54Count == 4 or timer54Count == 7 or timer54Count == 9 or timer54Count == 12 then
				timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
			elseif timer54Count == 5 or timer54Count == 10 then
				timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
			else
				if not DBM.Options.DebugMode then
					badStateDetected = true
					self:ResumeBlizzardAPI()
					self:UnregisterShortTermEvents()
					setFallback(self)
					DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
				else
					DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
				end
			end
		elseif timer == 159 then
			--Observed sequence variants:
			--Wipe3 (no rounded-156 SR): ZS, AoD, DT, ZS, AoW, ES, ZS, AoP, TW, ZS, SR, AoD, DT, ZS, SR, AoW, ES, ZS, TW
			--Wipe2 (rounded-156 SR present): ZS, AoD, DT, ZS, AoW, ES, ZS, AoP, TW, ZS, AoD, DT, ZS, SR, AoW, ES, ZS, TW
			--Wipe4 (rounded-172/157 SR present): ZS, AoD, DT, ZS, AoW, ES, AoP, TW, ZS, AoD, DT, ZS, SR, AoW, ES, ZS, TW
			timer159Count = timer159Count + 1
			local function attempt159ModuloFallback(routeLabel)
				DBM:Debug("|cffffff00[LightblindedVanguard] 159 verified routing exhausted at count " .. timer159Count .. " (path=" .. routeLabel .. ", v156=" .. tostring(timer159Uses156Variant) .. ", v172=" .. tostring(timer159Uses172Variant) .. "); attempting limited modulo fallback|r", nil, nil, nil, true)
				--Limited fallback scope: do not override validated 1-19 windows
				if timer159Count <= 19 then
					DBM:Debug("|cffff0000[LightblindedVanguard] 159 modulo fallback INVALID at count " .. timer159Count .. " (guarded validated window 1-19)|r", nil, nil, nil, true)
					return false
				end
				local modStep = timer159Count % 8
				if modStep == 1 or modStep == 4 or modStep == 7 then
					timerZealousSpiritCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "zealousSpirit", "zealousSpiritCount"))
					DBM:Debug("|cff00ff00[LightblindedVanguard] 159 modulo fallback VALID: count " .. timer159Count .. " -> zealousSpirit (mod=" .. modStep .. ")|r", nil, nil, nil, true)
					return true
				elseif modStep == 2 then
					timerAuraofDevotionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraDevotion", "auraofDevotionCount"))
					DBM:Debug("|cff00ff00[LightblindedVanguard] 159 modulo fallback VALID: count " .. timer159Count .. " -> auraDevotion (mod=" .. modStep .. ")|r", nil, nil, nil, true)
					return true
				elseif modStep == 3 then
					timerDivineTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineToll", "divineTollCount"))
					DBM:Debug("|cff00ff00[LightblindedVanguard] 159 modulo fallback VALID: count " .. timer159Count .. " -> divineToll (mod=" .. modStep .. ")|r", nil, nil, nil, true)
					return true
				elseif modStep == 5 then
					timerAuraofWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraWrath", "auraofWrathCount"))
					DBM:Debug("|cff00ff00[LightblindedVanguard] 159 modulo fallback VALID: count " .. timer159Count .. " -> auraWrath (mod=" .. modStep .. ")|r", nil, nil, nil, true)
					return true
				elseif modStep == 6 then
					timerExecutionSentenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "executionSentence", "executionSentenceCount"))
					DBM:Debug("|cff00ff00[LightblindedVanguard] 159 modulo fallback VALID: count " .. timer159Count .. " -> executionSentence (mod=" .. modStep .. ")|r", nil, nil, nil, true)
					return true
				elseif modStep == 0 then
					timerTyrsWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "tyrsWrath", "tyrsWrathCount"))
					DBM:Debug("|cff00ff00[LightblindedVanguard] 159 modulo fallback VALID: count " .. timer159Count .. " -> tyrsWrath (mod=" .. modStep .. ")|r", nil, nil, nil, true)
					return true
				end
				DBM:Debug("|cffff0000[LightblindedVanguard] 159 modulo fallback INVALID: unmapped mod step " .. modStep .. " at count " .. timer159Count .. "|r", nil, nil, nil, true)
				return false
			end
			if timer159Uses172Variant then
				if timer159Count == 1 or timer159Count == 4 or timer159Count == 9 or timer159Count == 12 or timer159Count == 16 then
					timerZealousSpiritCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "zealousSpirit", "zealousSpiritCount"))
				elseif timer159Count == 2 or timer159Count == 10 then
					timerAuraofDevotionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraDevotion", "auraofDevotionCount"))
				elseif timer159Count == 3 or timer159Count == 11 then
					timerDivineTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineToll", "divineTollCount"))
				elseif timer159Count == 5 or timer159Count == 14 then
					timerAuraofWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraWrath", "auraofWrathCount"))
				elseif timer159Count == 6 or timer159Count == 15 then
					timerExecutionSentenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "executionSentence", "executionSentenceCount"))
				elseif timer159Count == 7 then
					timerAuraofPeaceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraPeace", "auraofPeaceCount"))
				elseif timer159Count == 8 or timer159Count == 17 then
					timerTyrsWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "tyrsWrath", "tyrsWrathCount"))
				elseif timer159Count == 13 then
					timerSearingRadianceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "searingRadiance", "searingRadianceCount"))
				else
					if attempt159ModuloFallback("v172") then return end
					if not DBM.Options.DebugMode then
						badStateDetected = true
						self:ResumeBlizzardAPI()
						self:UnregisterShortTermEvents()
						setFallback(self)
						DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
					else
						DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
					end
				end
			elseif timer159Uses156Variant then
				if timer159Count == 1 or timer159Count == 4 or timer159Count == 7 or timer159Count == 10 then
					timerZealousSpiritCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "zealousSpirit", "zealousSpiritCount"))
				elseif timer159Count == 2 then
					timerAuraofDevotionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraDevotion", "auraofDevotionCount"))
				elseif timer159Count == 3 then
					timerDivineTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineToll", "divineTollCount"))
				elseif timer159Count == 5 then
					timerAuraofWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraWrath", "auraofWrathCount"))
				elseif timer159Count == 6 then
					timerExecutionSentenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "executionSentence", "executionSentenceCount"))
				elseif timer159Count == 8 then
					timerAuraofPeaceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraPeace", "auraofPeaceCount"))
				elseif timer159Count == 9 then
					timerTyrsWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "tyrsWrath", "tyrsWrathCount"))
				elseif timer159Count == 11 then
					timerAuraofDevotionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraDevotion", "auraofDevotionCount"))
				elseif timer159Count == 12 then
					timerDivineTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineToll", "divineTollCount"))
				elseif timer159Count == 13 or timer159Count == 17 then
					timerZealousSpiritCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "zealousSpirit", "zealousSpiritCount"))
				elseif timer159Count == 14 then
					timerSearingRadianceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "searingRadiance", "searingRadianceCount"))
				elseif timer159Count == 15 then
					timerAuraofWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraWrath", "auraofWrathCount"))
				elseif timer159Count == 16 then
					timerExecutionSentenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "executionSentence", "executionSentenceCount"))
				elseif timer159Count == 18 or timer159Count == 19 then
					timerTyrsWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "tyrsWrath", "tyrsWrathCount"))
				else
					if attempt159ModuloFallback("v156") then return end
					if not DBM.Options.DebugMode then
						badStateDetected = true
						self:ResumeBlizzardAPI()
						self:UnregisterShortTermEvents()
						setFallback(self)
						DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
					else
						DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
					end
				end
			else
				if timer159Count == 1 or timer159Count == 4 or timer159Count == 7 or timer159Count == 10 then
					timerZealousSpiritCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "zealousSpirit", "zealousSpiritCount"))
				elseif timer159Count == 2 then
					timerAuraofDevotionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraDevotion", "auraofDevotionCount"))
				elseif timer159Count == 3 then
					timerDivineTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineToll", "divineTollCount"))
				elseif timer159Count == 5 then
					timerAuraofWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraWrath", "auraofWrathCount"))
				elseif timer159Count == 6 then
					timerExecutionSentenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "executionSentence", "executionSentenceCount"))
				elseif timer159Count == 8 then
					timerAuraofPeaceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraPeace", "auraofPeaceCount"))
				elseif timer159Count == 9 then
					timerTyrsWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "tyrsWrath", "tyrsWrathCount"))
				elseif timer159Count == 11 then
					timerSearingRadianceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "searingRadiance", "searingRadianceCount"))
				elseif timer159Count == 12 then
					timerAuraofDevotionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraDevotion", "auraofDevotionCount"))
				elseif timer159Count == 13 then
					timerDivineTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineToll", "divineTollCount"))
				elseif timer159Count == 14 or timer159Count == 18 then
					timerZealousSpiritCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "zealousSpirit", "zealousSpiritCount"))
				elseif timer159Count == 15 then
					timerSearingRadianceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "searingRadiance", "searingRadianceCount"))
				elseif timer159Count == 16 then
					timerAuraofWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "auraWrath", "auraofWrathCount"))
				elseif timer159Count == 17 then
					timerExecutionSentenceCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "executionSentence", "executionSentenceCount"))
				elseif timer159Count == 19 then
					timerTyrsWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "tyrsWrath", "tyrsWrathCount"))
				else
					if attempt159ModuloFallback("default") then return end
					if not DBM.Options.DebugMode then
						badStateDetected = true
						self:ResumeBlizzardAPI()
						self:UnregisterShortTermEvents()
						setFallback(self)
						DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
					else
						DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
					end
				end
			end
		elseif timer == 18 then
			--Observed Mythic Week4 VanguardWipe3 18s sequence:
			--1DS 2ST 3DS 4ST 5DS 6ST 7AS 8ST 9DS 10JS 11JF 12AS 13DS 14ST 15DS 16ST 17DS 18ST 19DS 20AS 21ST 22DS 23ST 24JS 25JF 26DS 27ST 28DS 29ST 30DS 31ST 32DS 33AS 34AS
			timer18Count = timer18Count + 1
			if timer18Count == 1 or timer18Count == 3 or timer18Count == 5 or timer18Count == 9 or timer18Count == 13 or timer18Count == 15 or timer18Count == 17 or timer18Count == 19 or timer18Count == 22 or timer18Count == 26 or timer18Count == 28 or timer18Count == 30 or timer18Count == 32 then
				timerDivineStormCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "divineStorm", "divineStormCount"))
			elseif timer18Count == 2 or timer18Count == 4 or timer18Count == 6 or timer18Count == 8 or timer18Count == 14 or timer18Count == 16 or timer18Count == 18 or timer18Count == 21 or timer18Count == 23 or timer18Count == 27 or timer18Count == 29 or timer18Count == 31 then
				timerSacredTollCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "sacredToll", "sacredTollCount"))
			elseif timer18Count == 7 or timer18Count == 12 or timer18Count == 20 or timer18Count == 33 or timer18Count == 34 then
				timerAvengerShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "avengerShield", "avengerShieldCount"))
			elseif timer18Count == 10 or timer18Count == 24 then
				timerJudgementShieldCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementShield", "judgementShieldCount"))
			elseif timer18Count == 11 or timer18Count == 25 then
				timerjudgementFinalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "judgementFinal", "judgementFinalCount"))
			else
				if not DBM.Options.DebugMode then
					badStateDetected = true
					self:ResumeBlizzardAPI()
					self:UnregisterShortTermEvents()
					setFallback(self)
					DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
				else
					DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
				end
			end
		else--Reached end of chain without finding a valid timer, this means hardcode mod has failed, so we need to disable hardcoded features and fall back to blizz API
			if not DBM.Options.DebugMode then
				badStateDetected = true
				self:ResumeBlizzardAPI()
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			else
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers|r", nil, nil, nil, true)
			end
		end
	end
	--Note, bar state changing and canceling is handled by core
	function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
		if eventInfo.source ~= 0 then return end
		local eventID = eventInfo.id
--		local eventState = C_EncounterTimeline.GetEventState(eventID)
		local timerExact = eventInfo.duration
		local timer = math.floor(timerExact + 0.5)
		if not badStateDetected then
			if self:IsEasy() then
				timersEasy(self, timer, timerExact, eventID)
			elseif self:IsHeroic() then
				timersHeroic(self, timer, timerExact, eventID)
			elseif self:IsMythic() then
				timersMythic(self, timer, timerExact, eventID)
			end
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		if eventState == 2 then
			local eventType, eventCount = self:TLCountFinish(eventID)
			if not eventType or not eventCount then return end
			if eventType == "auraPeace" then
				specWarnAuraofPeace:Show(eventCount)
				specWarnAuraofPeace:Play("peaceaura")
			elseif eventType == "sacredShield" then
				specWarnSacredShield:Show(eventCount)
				specWarnSacredShield:Play("attackshield")
--				specWarnElekkCharge:Show()
--				specWarnElekkCharge:Play("chargemove")
			elseif eventType == "auraDevotion" then
				warnAuraofDevotion:Show(eventCount)
			elseif eventType == "judgementShield" then
				if self:IsTank() then
					specWarnJudgementShield:Show(eventCount)
					specWarnJudgementShield:Play("changemt")
				end
			elseif eventType == "divineToll" then
				specWarnDivineToll:Show(eventCount)
				specWarnDivineToll:Play("watchstep")
			elseif eventType == "auraWrath" then
				specWarnAuraofWrath:Show(eventCount)
				specWarnAuraofWrath:Play("wrathaura")
			elseif eventType == "judgementFinal" then
				if self:IsTank() then
					specWarnjudgementFinal:Show(eventCount)
					specWarnjudgementFinal:Play("changemt")
				end
			elseif eventType == "sacredToll" then
				specWarnSacredToll:Show(eventCount)
				specWarnSacredToll:Play("aesoon")
			elseif eventType == "executionSentence" then
				specWarnExecutionSentence:Show(eventCount)
				specWarnExecutionSentence:Play("soakincoming")
			elseif eventType == "divineStorm" then
				specWarnDivineStorm:Show(eventCount)
				specWarnDivineStorm:Play("justrun")
			elseif eventType == "empDivineStorm" then
				specWarnEmpoweredDivineStorm:Show(eventCount)
				specWarnEmpoweredDivineStorm:Play("justrun")
			elseif eventType == "searingRadiance" then
				specWarnSearingRadiance:Show(eventCount)
				specWarnSearingRadiance:Play("aesoon")
			elseif eventType == "empSearingRadiance" then
				specWarnEmpoweredSearingRadiance:Show(eventCount)
				specWarnEmpoweredSearingRadiance:Play("aesoon")
			elseif eventType == "zealousSpirit" then
				warnZealousSpirit:Show(eventCount)
			elseif eventType == "tyrsWrath" then
				--private aura handles sound
			end
		elseif eventState == 3 then
			self:TLCountCancel(eventID)
		end
	end
end
