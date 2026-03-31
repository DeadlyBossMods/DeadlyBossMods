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
local specWarnJudgementShield				= mod:NewSpecialWarningCount(1251857, nil, nil, L.JudgementShield, 2, 2)
local specWarnDivineToll					= mod:NewSpecialWarningDodgeCount(1248652, nil, nil, DBM_COMMON_L.DODGES, 2, 2)
local specWarnAuraofWrath					= mod:NewSpecialWarningCount(1248449, nil, nil, nil, 2, 2)
local specWarnjudgementFinal				= mod:NewSpecialWarningCount(1246736, nil, nil, L.JudgementFV, 2, 2)
local specWarnDivineStorm					= mod:NewSpecialWarningCount(1246765, "Melee", nil, nil, 2, 2)--review default later
local specWarnSacredToll					= mod:NewSpecialWarningCount(1246749, nil, nil, DBM_COMMON_L.AOEDAMAGE, 2, 2)
local specWarnExecutionSentence				= mod:NewSpecialWarningSoakCount(1276368, nil, nil, DBM_COMMON_L.GROUPSOAKS, 2, 2)

local timerAuraofPeaceCD					= mod:NewCDCountTimer(20.5, 1248451, nil, nil, nil, 3)
local timerSacredShieldCD					= mod:NewCDCountTimer(20.5, 1248674, nil, nil, nil, 5)
--local timerElekkChargeCD					= mod:NewCDCountTimer(20.5, 1249130, nil, nil, nil, 3)--redundant
local timerTyrsWrathCD						= mod:NewCDCountTimer(20.5, 1248721, DBM_COMMON_L.HEALABSORBS.." (%s)", "Healer", nil, 5)
local timerAuraofDevotionCD					= mod:NewCDCountTimer(20.5, 1246162, nil, nil, nil, 3)
local timerSearingRadianceCD				= mod:NewCDCountTimer(20.5, 1255738, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerJudgementShieldCD				= mod:NewCDCountTimer(20.5, 1251857, L.JudgementShield.." (%s)", "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerAvengerShieldCD					= mod:NewCDCountTimer(20.5, 1246487, nil, nil, nil, 3)
local timerDivineTollCD						= mod:NewCDCountTimer(20.5, 1248652, DBM_COMMON_L.DODGES.." (%s)", nil, nil, 3)
local timerAuraofWrathCD					= mod:NewCDCountTimer(20.5, 1248449, nil, nil, nil, 5)
local timerjudgementFinalCD					= mod:NewCDCountTimer(20.5, 1246736, L.JudgementFV.." (%s)", "Tank", nil, 5)
local timerDivineStormCD					= mod:NewCDCountTimer(20.5, 1246765, nil, nil, nil, 3)
local timerSacredTollCD						= mod:NewCDCountTimer(20.5, 1246749, DBM_COMMON_L.AOEDAMAGE.." (%s)", nil, nil, 2)
local timerExecutionSentenceCD				= mod:NewCDCountTimer(20.5, 1276368, DBM_COMMON_L.GROUPSOAKS.." (%s)", nil, nil, 3)
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

---@param self DBMMod
local function setFallback(self)
	--Blizz API fallbacks
	specWarnAuraofPeace:SetAlert(71, "peaceaura", 19, 2)
	timerAuraofPeaceCD:SetTimeline(71)
--	specWarnElekkCharge:SetAlert(73, "chargemove", 2, 2, 0)
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

function mod:OnLimitedCombatStart()
	self:TLCountReset()
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
	timer17Count = 0
	timer20Count = 0
	timer23Count = 0
	timer40Count = 0
	timer42Count = 0
	timer92Count = 0
	timer172Count = 0
	timer174Count = 0
	timer175Count = 0
	--TODO, hardcoded features
	if DBM.Options.HardcodedTimer and self:IsEasy() and not badStateDetected then
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		)
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
					if DBM.Options.IgnoreBlizzAPI then
						DBM.Options.IgnoreBlizzAPI = false
						DBM:FireEvent("DBM_ResumeBlizzAPI")
					end
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
				if DBM.Options.IgnoreBlizzAPI then
					DBM.Options.IgnoreBlizzAPI = false
					DBM:FireEvent("DBM_ResumeBlizzAPI")
				end
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
			elseif eventType == "zealousSpirit" then
				warnZealousSpirit:Show(eventCount)
			end
		elseif eventState == 3 then
			self:TLCountCancel(eventID)
		end
	end
end
