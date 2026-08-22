local mod	= DBM:NewMod(2895, "DBM-Raids-Midnight", 1, 1320)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(257758, 268956)--Ula'tek has two IDs?
mod:SetEncounterID(3492)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(3004)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

--TODO, threat based moher's wrath in hardcode, maybe disable hobbled sound if redundant/similtanious
--TODO, cull unused timers and warnings, like Fury Unleashed?
--TODO, which Gore Rattle id does TL use, does it use both? https://www.wowhead.com/spell=1304527/gore-rattle
--TODO, same with https://www.wowhead.com/spell=1311037/mothers-wrath and https://www.wowhead.com/spell=1287265/spectral-coils as gore rattle
--DBM:RegisterAltSpellName(1257717, DBM_COMMON_L.ADDS)--Alluring Bubble --> Adds
--local warnSerpentsBite					= mod:NewCountAnnounce(1295905, 2)--Hardcode only

local specWarnMothersWrath				= mod:NewSpecialWarningDefensive(1298367, nil, nil, nil, 1, 2, nil, nil, "defensive")
local specWarnRageoftheShackled			= mod:NewSpecialWarningCount(1286860, nil, nil, nil, 2, 2, nil, nil, "aesoon")
local specWarnCausticWaves				= mod:NewSpecialWarningCount(1292188, nil, nil, nil, 2, 2, nil, nil, "watchwave")
local specWarnFuryUnleashed				= mod:NewSpecialWarningCount(1286905, nil, nil, nil, 3, 2, nil, nil, "stilldanger")--Stage 3 berserk?
local specWarnGoreRattle				= mod:NewSpecialWarningSwitchCount(1298559, nil, nil, nil, 1, 2, nil, nil, "bigmob")
local specWarnToxicIncubation			= mod:NewSpecialWarningCount(1299757, nil, nil, nil, 2, 2, 4, nil, "helpsoak")--Is it a soak though?
local specWarnSpectralCoils				= mod:NewSpecialWarningCount(1300530, nil, nil, nil, 2, 2, nil, nil, "helpsoak")--Used by Gore Rattle
local specWarnCalloftheSerpent			= mod:NewSpecialWarningCount(1300751, nil, nil, nil, 1, 2, nil, nil, "mobsoon")
local specWarnCirclingPrey				= mod:NewSpecialWarningRunCount(1301510, nil, nil, nil, 2, 2, nil, nil, "justrun")
local specWarnVirulentSpit				= mod:NewSpecialWarningDodgeCount(1302982, nil, nil, nil, 2, 2, nil, nil, "watchstep")
local specWarnMephiticThrash			= mod:NewSpecialWarningDodgeCount(1296301, nil, nil, nil, 2, 2, nil, nil, "aesoon")--Used by Gore Rattle
local specWarnSubmerge					= mod:NewSpecialWarningCount(1292999, nil, nil, nil, 2, 2, nil, nil, "phasechange")

local timerMothersWrathCD				= mod:NewCDCountTimer(20.5, 1298367, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerRageoftheShackledCD			= mod:NewCDCountTimer(20.5, 1286860, nil, nil, nil, 2)
local timerCausticWavesCD				= mod:NewCDCountTimer(20.5, 1292188, nil, nil, nil, 3)
local timerFuryUnleashedCD				= mod:NewCDCountTimer(20.5, 1286905, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerGoreRattleCD					= mod:NewCDCountTimer(20.5, 1298559, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerSerpentsBiteCD				= mod:NewCDCountTimer(20.5, 1295905, nil, nil, nil, 3)
local timerToxicIncubationCD			= mod:NewCDCountTimer(20.5, 1299757, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerSpectralCoilsCD				= mod:NewCDCountTimer(20.5, 1300530, nil, nil, nil, 5)
local timerCalloftheSerpentCD			= mod:NewCDCountTimer(20.5, 1300751, nil, nil, nil, 1)
local timerCirclingPreyCD				= mod:NewCDCountTimer(20.5, 1301510, nil, nil, nil, 2)
local timerVirulentSpitCD				= mod:NewCDCountTimer(20.5, 1302982, nil, nil, nil, 3)
local timerMephiticThrashCD				= mod:NewCDCountTimer(20.5, 1296301, nil, nil, nil, 2)
local timerSubmergeCD					= mod:NewCDCountTimer(20.5, 1292999, nil, nil, nil, 6)

--local timerBerserkCD					= mod:NewBerserkTimer(600)

mod:AddAuraSoundOption(1300938, true, 1298367, 1, 3, "slowyou", 20, 0)--Hobbled
mod:AddAuraSoundOption(1292403, true, 1292188, 1, 3, "dotyou", 19, 0)--Caustic Wave Dot
mod:AddAuraSoundOption(1300685, true, 1300530, 1, 3, "debuffyou", 17, 0)--Soul Constrictor (can't soak Spectral Coils)
mod:AddAuraSoundOption(1293046, true, 1295905, 1, 1, "gathershare", 2, 0)--Serpent's Bite (targeted)
--mod:AddAuraSoundOption(1288879, true, 1295905, 1, 1, "gathershare", 2, 0)--Serpent's Bite (dot) (use if pre target spell aura doesn't work)
mod:AddAuraSoundOption(1306119, true, 1295905, 1, 3, "stunyou", 19, 0)--Calcified Corpse. Failed to clear Serpent's Bite
mod:AddAuraSoundOption(1312967, true, 1295905, 1, 1, "runout", 2, 0)--Volatile Purge (serpent's bite share debuff)
mod:AddAuraSoundOption(1302842, false, 1299757, 1, 3, "stackhigh", 6, 1)--Toxic Burn (may be spammy if rapid soaked, warns at 2+ stacks)
mod:AddAuraSoundOption(1301800, "RemovePoison", 1300751, 1, 3, "poisonyou", 20, 0)--Acidic Burst (Blightscale Viper adds debuffs)
mod:AddAuraSoundOption(1305163, true, 1300751, 1, 1, "runout", 2, 0)--Petrifying Sting (Target). Used by Blightscale Viper
mod:AddAuraSoundOption(1303414, true, 1300751, 1, 3, "stunyou", 2, 0)--Petrifying Sting (Got hit by it)
mod:AddAuraSoundOption(1295360, true, -35864, 1, 3, "eggyou", 20, 0)--Malignant Shell (non mythic)
mod:AddAuraSoundOption(1307612, true, -35864, 1, 3, "eggyou", 20, 0)--Noxious Shell (mythic)
mod:AddAuraSoundOption(1312150, true, -35864, 1, 3, "debuffyou", 17, 0)--Rancid Yolk
mod:AddAuraSoundOption(1301268, "Dps", -35864, 1, 3, "targetchange", 2, 0)--Putrid Membrane means a Blightscale Viper has spawned
mod:AddAuraSoundOption(1300312, true, -37007, 1, 3, "eggyou", 20, 0)--Doomscale Shell
mod:AddAuraSoundOption(1305775, true, -37007, 1, 3, "stunyou", 19, 0)--Dread Roar
mod:AddAuraSoundOption(1305650, true, -37007, 1, 3, "stunyou", 19, 0)--Agnuished Cry
mod:AddAuraSoundOption(1301118, true, -36292, 1, 1, "targetyou", 2, 0)--Grasping Fangs (targeted)
mod:AddAuraSoundOption(1311611, true, -36292, 1, 3, "slowyou", 20, 0)--Grasping Fangs (got hit by it) (maybe change to "break chain" or something?
mod:AddAuraSoundOption(1311602, true, -36292, 1, 3, "dotyou", 19, 0)--Blight Vein (broke Grasping Fangs)

local badStateDetected = false--Used to track if hardcode features have failed and we need to fall back to blizz API
local stage1SixtyTwoCount = 0--Normal: Call of the Serpent then Mother's Wrath share the exact 62s opening slot

mod.vb.mothersWrathCount = 1
mod.vb.rageCount = 1
mod.vb.causticWavesCount = 1
mod.vb.goreRattleCount = 1
mod.vb.spectralCoilsCount = 1
mod.vb.callCount = 1
mod.vb.mephiticThrashCount = 1
mod.vb.virulentSpitCount = 1

---@param self DBMMod
---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	if not dontSetAlerts then
		if self:IsTank() then
			specWarnMothersWrath:SetAlert({699,952}, "defensive", 2, 2)
		end
		specWarnRageoftheShackled:SetAlert(700, "aesoon", 2, 2)
		specWarnCausticWaves:SetAlert(719, "watchwave", 2, 2)
		specWarnFuryUnleashed:SetAlert({746,810}, "stilldanger", 3, 2, 0)
		specWarnGoreRattle:SetAlert({799,847}, "bigmob", 2, 2)
		specWarnToxicIncubation:SetAlert({806,950}, "helpsoak", 2, 2, 4)
		specWarnSpectralCoils:SetAlert({807,975}, "helpsoak", 2, 2)
		specWarnCalloftheSerpent:SetAlert(825, "mobsoon", 2, 2)
		specWarnCirclingPrey:SetAlert(826, "justrun", 2, 2)
		specWarnVirulentSpit:SetAlert(830, "watchstep", 2, 2)
		specWarnMephiticThrash:SetAlert(912, "aesoon", 2, 2)
		specWarnSubmerge:SetAlert(949, "phasechange", 2, 2)
	end
	--If user has DBM bars enabled, we only want to register colors to the blizz api so that the blizz bars are also colorized.
	--If user has bars disabled, or we are in a bad state, onlyColor is false and we register countdowns as well.
	local onlyColor = not DBM.Options.HideDBMBars and not badStateDetected
	timerMothersWrathCD:SetTimeline({699,952}, onlyColor)
	timerRageoftheShackledCD:SetTimeline(700, onlyColor)
	timerCausticWavesCD:SetTimeline(719, onlyColor)
	timerFuryUnleashedCD:SetTimeline({746,810}, onlyColor)
	timerGoreRattleCD:SetTimeline({799,847}, onlyColor)
	timerSerpentsBiteCD:SetTimeline(800, onlyColor)
	timerToxicIncubationCD:SetTimeline({806,950}, onlyColor)
	timerSpectralCoilsCD:SetTimeline({807,975}, onlyColor)
	timerCalloftheSerpentCD:SetTimeline(825, onlyColor)
	timerCirclingPreyCD:SetTimeline(826, onlyColor)
	timerVirulentSpitCD:SetTimeline(830, onlyColor)
	timerMephiticThrashCD:SetTimeline(912, onlyColor)
	timerSubmergeCD:SetTimeline(949, onlyColor)
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
	self:SetStage(1)
	stage1SixtyTwoCount = 0
	self.vb.mothersWrathCount = 1
	self.vb.rageCount = 1
	self.vb.causticWavesCount = 1
	self.vb.goreRattleCount = 1
	self.vb.spectralCoilsCount = 1
	self.vb.callCount = 1
	self.vb.mephiticThrashCount = 1
	self.vb.virulentSpitCount = 1
	--Hardcode features first
	if DBM.Options.HardcodedTimer and self:IsNormal() and not badStateDetected then
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		)
		setFallback(self, true)
	else
		setFallback(self)
	end
end


function mod:OnCombatEnd()
	self:TLCountReset()
	stage1SixtyTwoCount = 0
	self:UnregisterShortTermEvents()
	badStateDetected = false--TEMP, we want to allow partial hardcode to work each pull til it's finished
end

do
	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	--TODO: Stage 2 routing is incomplete, and stage 3 is unimplemented; the available Normal kill ended early before any stage 3 abilities. More log evidence is needed.
	local function timersAll(self, timer, timerExact, eventID)
		local handled = false
		local stage = self:GetStage()
		if stage == 1 and timer == 118 then--Stage 2 starts with the new 118s Rage of the Shackled timer
			self:SetStage(2)
			timerRageoftheShackledCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rage", "rageCount"))
			handled = true
		elseif stage == 1 then
			if timer == 42 then
				timerCausticWavesCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "causticWaves", "causticWavesCount"))
			elseif timer == 10 then
				timerMothersWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "mothersWrath", "mothersWrathCount"))
			elseif timer == 20 or timer == 84 then
				timerSpectralCoilsCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "spectralCoils", "spectralCoilsCount"))
			elseif timer == 130 then
				timerRageoftheShackledCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rage", "rageCount"))
			elseif timer == 5 then
				timerGoreRattleCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "goreRattle", "goreRattleCount"))
			elseif timer == 35 or timer == 41 then
				timerMephiticThrashCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "mephiticThrash", "mephiticThrashCount"))
			elseif timer == 62 then
				stage1SixtyTwoCount = stage1SixtyTwoCount + 1
				if stage1SixtyTwoCount == 1 then--Complete Normal corpus: opener Call, then Mother's Wrath
					timerCalloftheSerpentCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "call", "callCount"))
				elseif stage1SixtyTwoCount == 2 then
					timerMothersWrathCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "mothersWrath", "mothersWrathCount"))
				else
					return false
				end
			else
				return false
			end
			handled = true
		elseif stage == 2 then
			if timer == 118 then
				timerRageoftheShackledCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rage", "rageCount"))
			elseif timer == 30 or timer == 40 then
				timerVirulentSpitCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "virulentSpit", "virulentSpitCount"))
			else
				return false
			end
			handled = true
		end

		if not handled then--Reached end of chain without finding a valid timer, this means hardcode mod has failed, so we need to disable hardcoded features and fall back to blizz API
			badStateDetected = true
			self:ResumeBlizzardAPI()
			self:UnregisterShortTermEvents()
			setFallback(self)
			DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
		end
	end

	--Note, bar state changing and canceling is handled by core
	function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
		if eventInfo.source ~= 0 then return end
		local eventID = eventInfo.id
		local timerExact = eventInfo.duration
		local timer = math.floor(timerExact + 0.5)
		if not badStateDetected then
			timersAll(self, timer, timerExact, eventID)
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		if eventState == 2 then
			local eventType, eventCount = self:TLCountFinish(eventID)
			if eventType and eventCount then
				if eventType == "mothersWrath" then
					if self:IsTanking("player", "boss1", nil, true) then
						specWarnMothersWrath:Show()
						specWarnMothersWrath:Play("defensive")
					end
				elseif eventType == "rage" then
					specWarnRageoftheShackled:Show(eventCount)
					specWarnRageoftheShackled:Play("aesoon")
				elseif eventType == "causticWaves" then
					specWarnCausticWaves:Show(eventCount)
					specWarnCausticWaves:Play("watchwave")
				elseif eventType == "goreRattle" then
					specWarnGoreRattle:Show(eventCount)
					specWarnGoreRattle:Play("bigmob")
				elseif eventType == "spectralCoils" then
					specWarnSpectralCoils:Show(eventCount)
					specWarnSpectralCoils:Play("helpsoak")
				elseif eventType == "call" then
					specWarnCalloftheSerpent:Show(eventCount)
					specWarnCalloftheSerpent:Play("mobsoon")
				elseif eventType == "mephiticThrash" then
					specWarnMephiticThrash:Show(eventCount)
					specWarnMephiticThrash:Play("aesoon")
				elseif eventType == "virulentSpit" then
					specWarnVirulentSpit:Show(eventCount)
					specWarnVirulentSpit:Play("watchstep")
				end
			end
		elseif eventState == 3 then
			self:TLCountCancel(eventID)
		end
	end
end
