local mod	= DBM:NewMod(2738, "DBM-Raids-Midnight", 3, 1307)
--local L		= mod:GetLocalizedStrings()--Nothing to localize for blank mods

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(244761)
mod:SetEncounterID(3181)
--mod:SetHotfixNoticeRev(20250823000000)
--mod:SetMinSyncRevision(20250823000000)
mod:SetZone(2912)

mod:RegisterCombat("combat")

--TODO, actually break down abilities by stage for easier UI navigation. Right now they're just in encounter event order
--TODO, i suspect voidstalker sting is more or less spammed and you just clear it with other mechanics before it's unmangable, adjust warnings if i'm wrong
--TODO, announce https://www.wowhead.com/spell=1232467/grasp-of-emptiness cast or do PAs cover it
--TODO, figure out https://www.wowhead.com/spell=1239582/cosmic-overload for mythic only (169)
--TODO, fine other mythic only spells, likely tucked away in undocumented encounterID space
--TODO, add https://www.wowhead.com/beta/spell=1227557/devouring-cosmos private aura if it's NOT berserk
local warnSilverStrikeArrow				= mod:NewCountAnnounce(1233602, 2)--P1/P3
local warnNullCorona					= mod:NewCountAnnounce(1233865, 2, nil, "Healer")--P1+
local warnRiftSimulacrum				= mod:NewSpellAnnounce(1261016, 2)--P2 Starting
local warnVoidStalkerSting				= mod:NewCountAnnounce(1237035, 2)--Stage 2 non mythic

local specWarnVoidExpulsion				= mod:NewSpecialWarningCount(1283236, nil, nil, nil, 2, 2)--P1+
--local specWarnSingularityEruption		= mod:NewSpecialWarningDodgeCount(1235622, nil, nil, nil, 2, 2)--Intermission 1
--local specWarnVoidstalkerSting		= mod:NewSpecialWarningCount(1237035, false, nil, nil, 2, 2)--Stage 2 non mythic
local specWarnCalloftheVoid				= mod:NewSpecialWarningSwitchCount(1237837, nil, nil, nil, 2, 2)--P2
local specWarnCosmicBarrier				= mod:NewSpecialWarningSwitchCount(1246918, "Dps", nil, nil, 2, 2)--P2
local specWarnDevouringCosmos			= mod:NewSpecialWarningCount(1238843, nil, nil, nil, 3, 2)--P3
local specWarnDarkHand					= mod:NewSpecialWarningDefensive(1238844, nil, nil, nil, 1, 2)--P1 Tank Add
local specWarnRavenousAbyss				= mod:NewSpecialWarningDodgeCount(1243753, nil, nil, nil, 4, 2)--P1 Add
local specWarnInterruptingTremor		= mod:NewSpecialWarningCast(1243743, "SpellCaster", nil, nil, 1, 2)--P1 Add
local specWarnCosmicPortal				= mod:NewSpecialWarningCount(1261339, nil, nil, nil, 2, 2)--Mythic only mechanic of unknown nature
local specWarnRiftSlash					= mod:NewSpecialWarningDefensive(1246461, nil, nil, nil, 1, 2)--P2 Rift Simulacrum slash attack

local timerNullCoronaCD					= mod:NewCDCountTimer(20.5, 1233865, DBM_COMMON_L.HEALABSORB.." (%s)", nil, nil, 3)--P1+
local timerVoidExpulsionCD				= mod:NewCDCountTimer(20.5, 1283236, nil, nil, nil, 3)--P1+
local timerSilverstrikeArrowCD			= mod:NewCDCountTimer(20.5, 1233602, 208407, nil, nil, 3)--P1/P3, shortname "Arrow"
local timerSilverstrikeBarrageCD		= mod:NewCDCountTimer(20.5, 1234564, 208071, nil, nil, 3)--Intermission 1, shortname "Arrow Barrage"
--local timerSingularityEruptionCD		= mod:NewCDCountTimer(20.5, 1235622, nil, nil, nil, 3)--Intermission 1 (Passive, doesn't have a timer)
local timerVoidstalkerStingCD			= mod:NewCDCountTimer(20.5, 1237035, nil, nil, nil, 2)--Stage 2 non mythic
local timerCalloftheVoidCD				= mod:NewCDCountTimer(20.5, 1237837, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1)--P2
local timerRangerCaptainsMarkCD			= mod:NewCDCountTimer(20.5, 1237614, 208407, nil, nil, 3)--P3, also shortname "Arrow"
local timerCosmicBarrierCD				= mod:NewCDCountTimer(20.5, 1246918, 151702, nil, nil, 5)--P2, shortname "Shield"
local timerAspectoftheEndCD				= mod:NewCDCountTimer(20.5, 1239111, 1234576, nil, nil, 3)--Intermission 2, shortname "Tethers"
local timerGraspofEmptynessCD			= mod:NewCDCountTimer(20.5, 1232470, 367465, nil, nil, 3)--P1, shortname "Grasp"
local timerDevouringCosmosCD			= mod:NewCDCountTimer(20.5, 1238843, nil, nil, nil, 5, nil, DBM_COMMON_L.DEADLY_ICON)--P3
local timerDarkHandCD					= mod:NewCDCountTimer(20.5, 1238844, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--P1 Tank Add
local timerRavenousAbyssCD				= mod:NewCDCountTimer(20.5, 1243753, nil, nil, nil, 2)--P1 Add
local timerInterruptingTremorCD			= mod:NewCDCountTimer(20.5, 1243743, "SpellCaster", nil, nil, 2)--P1 Add
--local timerRiftSimulacrumCD			= mod:NewCDCountTimer(20.5, 1261016, nil, nil, nil, 6)--P2 Starting (stage 2 bar does this, this timer never fires)
local timerCosmicPortalCD				= mod:NewCDCountTimer(20.5, 1261339, nil, nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)--Mythic only mechanic of unknown nature
local timerRiftSlashCD					= mod:NewCDCountTimer(20.5, 1246461, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--P2 Rift Simulacrum slash attack
local timerStage2CD						= mod:NewCDTimer(20.5, 1272966, nil, nil, nil, 6)
local timerStage3CD						= mod:NewCDTimer(20.5, 1273378, nil, nil, nil, 6)

mod:AddPrivateAuraSoundOption(1233865, true, 1233865, 1, 1)--Null Corona
mod:AddPrivateAuraSoundOption(1283236, true, 1283236, 1, 1)--Void Expulsion
mod:AddPrivateAuraSoundOption(1242553, true, 1283236, 1, 2)--Void Remnants (GTFO left by Void Expulsion)
mod:AddPrivateAuraSoundOption(1233602, true, 1233602, 1, 1)--Silverstrike Arrow
mod:AddPrivateAuraSoundOption(1243981, true, 1234564, 1, 3)--Silverstrike Barrage
--mod:AddPrivateAuraSoundOption(1234570, false, 1234570, 1, 1)--Stellar Emission (stacking debuff during Intermission 1)
mod:AddPrivateAuraSoundOption(1238206, true, 1238206, 1, 2)--Volatile Fissure
mod:AddPrivateAuraSoundOption(1237623, true, 1237614, 1, 1)--Ranger Captain's Mark
mod:AddPrivateAuraSoundOption(1239111, true, 1239111, 1, 1)--Aspect of the End
mod:AddPrivateAuraSoundOption(1255453, false, 1239111, 1, 3)--Gravity Collapse (Aspect of the End debuff)
mod:AddPrivateAuraSoundOption(1232470, true, 1232470, 1, 1)--Grasp of Emptiness
mod:AddPrivateAuraSoundOption(1243753, true, 1243753, 1, 3)--Failing to get out of Ravenous Abyss
mod:AddPrivateAuraSoundOption(1238708, true, 1238708, 1, 1)--Dark Rush

mod.vb.coronaCount = 0
mod.vb.expulsionCount = 0
mod.vb.voidExpulsionCount = 0
mod.vb.silverstrikeArrowCount = 0
mod.vb.silverstrikeBarrageCount = 0
mod.vb.singularityEruptionCount = 0
mod.vb.voidstalkerStingCount = 0
mod.vb.calloftheVoidCount = 0
mod.vb.darkHandCount = 0
mod.vb.ravenousAbyssCount = 0
mod.vb.interruptingTremorCount = 0
mod.vb.rangerMarkCount = 0
mod.vb.cosmicBarrierCount = 0
mod.vb.aspectoftheEndCount = 0
mod.vb.graspofEmptynessCount = 0
mod.vb.devouringCosmosCount = 0
local cachedEventIDs = {}
local lastResolvedType, lastResolvedTimer

---@param self DBMMod
local function unsetBackupTL(self)
	self:DisableAlertOptions({64, 65, 66})--Dark Hand, Ravenous Abyss, Interrupting Tremor
	self:DisableTimelineOptions({64, 65, 66})
end

function mod:OnLimitedCombatStart()
	table.wipe(cachedEventIDs)
	lastResolvedType, lastResolvedTimer = nil, nil
	self.vb.coronaCount = 1
	self.vb.expulsionCount = 1
	self.vb.voidExpulsionCount = 1
	self.vb.silverstrikeArrowCount = 1
	self.vb.silverstrikeBarrageCount = 1
	self.vb.singularityEruptionCount = 1
	self.vb.voidstalkerStingCount = 1
	self.vb.calloftheVoidCount = 1
	self.vb.darkHandCount = 1
	self.vb.ravenousAbyssCount = 1
	self.vb.interruptingTremorCount = 1
	self.vb.rangerMarkCount = 1
	self.vb.cosmicBarrierCount = 1
	self.vb.aspectoftheEndCount = 1
	self.vb.graspofEmptynessCount = 1
	self.vb.devouringCosmosCount = 1
	self:SetStage(1)

	if DBM.Options.HardcodedTimer and self:IsEasy() then
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		)
		--Stage 1 opener has an unresolved 4s overlap (Dark Hand, Interrupting Tremor, Ravenous Abyss);
		--register Blizz API fallbacks so passthrough bars keep correct sounds/colors.
		if self:IsTank() then
			specWarnDarkHand:SetAlert(64, "defensive", 2, 2)
		end
		timerDarkHandCD:SetTimeline(64)
		specWarnRavenousAbyss:SetAlert(65, "watchstep", 2, 2)
		timerRavenousAbyssCD:SetTimeline(65)
		specWarnInterruptingTremor:SetAlert(66, "stopcast", 2, 2, 0)
		timerInterruptingTremorCD:SetTimeline(66)
		self:Schedule(8, unsetBackupTL, self)--Unregister fallbacks after opener overlap window
	else
		--Blizz API fallbacks
		timerNullCoronaCD:SetTimeline(4)
		specWarnVoidExpulsion:SetAlert(5, "aesoon", 2, 2, 0)
		timerVoidExpulsionCD:SetTimeline(5)
		timerSilverstrikeArrowCD:SetTimeline(6)
		timerSilverstrikeBarrageCD:SetTimeline(7)
--		specWarnSingularityEruption:SetAlert(8, "watchstep", 2, 2)
--		timerSingularityEruptionCD:SetTimeline(8)
		timerVoidstalkerStingCD:SetTimeline(9)
		specWarnCalloftheVoid:SetAlert(10, "mobsoon", 2, 2)
		timerCalloftheVoidCD:SetTimeline(10)
		timerRangerCaptainsMarkCD:SetTimeline({11, 131})--Regular, Mythic?
		specWarnCosmicBarrier:SetAlert(12, "attackshield", 2, 2, 0)
		timerCosmicBarrierCD:SetTimeline(12)
		timerAspectoftheEndCD:SetTimeline(13)
		timerGraspofEmptynessCD:SetTimeline({14, 132})--Regular, Mythic?
		specWarnDevouringCosmos:SetAlert(15, "changeplatform", 19, 4)
		timerDevouringCosmosCD:SetTimeline(15)
		if self:IsTank() then
			specWarnDarkHand:SetAlert(64, "defensive", 2, 2)
		end
		timerDarkHandCD:SetTimeline(64)
		specWarnRavenousAbyss:SetAlert(65, "watchstep", 2, 2)
		timerRavenousAbyssCD:SetTimeline(65)
		specWarnInterruptingTremor:SetAlert(66, "stopcast", 2, 2, 0)
		timerInterruptingTremorCD:SetTimeline(66)
		warnRiftSimulacrum:SetAlert(135, "ptwo", 2, 2, 0)--Verify
--		timerRiftSimulacrumCD:SetTimeline(135)
		specWarnCosmicPortal:SetAlert(136, "bigmobsoon", 2, 2)
		timerCosmicPortalCD:SetTimeline(136)
		if self:IsTank() then
			specWarnRiftSlash:SetAlert(137, "defensive", 2, 2)
		end
		timerRiftSlashCD:SetTimeline(137)
		timerStage2CD:SetTimeline(351)
	end

	self:EnablePrivateAuraSound({1233865,1233887}, "absorbyou", 19)
	self:EnablePrivateAuraSound(1283236, "orbrun", 2)
	self:EnablePrivateAuraSound(1233602, "arrowyou", 19)
	self:EnablePrivateAuraSound(1243981, "debuffyou", 17)
	self:EnablePrivateAuraSound({1237623,1259861}, "markyou", 19)
	self:EnablePrivateAuraSound(1239111, "lineapart", 2)
	self:EnablePrivateAuraSound({1232470,1260027}, "graspyou", 19)
	self:EnablePrivateAuraSound(1255453, "debuffyou", 2)
	self:EnablePrivateAuraSound(1242553, "watchfeet", 8)
	self:EnablePrivateAuraSound(1243753, "debuffyou", 17)
--	self:EnablePrivateAuraSound(1234570, "debuffyou", 17)--Phase soft enrage, probably not worth annoucning, it kinda just persistently stacks
	self:EnablePrivateAuraSound(1238206, "watchfeet", 8)
	self:EnablePrivateAuraSound(1238708, "speedyou", 19)
end

function mod:OnCombatEnd()
	table.wipe(cachedEventIDs)
	lastResolvedType, lastResolvedTimer = nil, nil
	self:UnregisterShortTermEvents()
end

do
	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersEasy(self, timer, timerExact, eventID)
		local stage = self:GetStage()
		if stage == 1 then
			--Stage 1
			--NOTE: Per encounter secret restrictions, only eventID + duration are used.
			--S1 still has one unresolved opener overlap intentionally skipped in this scope:
			--4s overlap among Dark Hand, Interrupting Tremor, and Ravenous Abyss.
			--Recurring Dark Hand remains resolved by the unique 17s bucket.
			--Recurring casts are now split by exact duration: 19.5 (Abyss) vs 20.0 (Tremor).
			if timer == 60 or timer == 39 then--Void Expulsion
				timerVoidExpulsionCD:TLStart(timer, eventID, self.vb.voidExpulsionCount)
				cachedEventIDs[eventID] = "voidExpulsion"
				return true
			elseif timer == 46 or timer == 47 or timer == 48 then--Null Corona
				timerNullCoronaCD:TLStart(timer, eventID, self.vb.coronaCount)
				cachedEventIDs[eventID] = "nullCorona"
				return true
			elseif timer == 21 or timer == 23 or timer == 24 then--Silverstrike Arrow
				timerSilverstrikeArrowCD:TLStart(timer, eventID, self.vb.silverstrikeArrowCount)
				cachedEventIDs[eventID] = "silverstrikeArrow"
				return true
			elseif timer == 5 or timer == 28 or timer == 32 then--Grasp of Emptiness
				timerGraspofEmptynessCD:TLStart(timer, eventID, self.vb.graspofEmptynessCount)
				cachedEventIDs[eventID] = "grasp"
				return true
			elseif timer == 17 then--Dark Hand
				timerDarkHandCD:TLStart(timer, eventID, self.vb.darkHandCount)
				cachedEventIDs[eventID] = "darkHand"
				return true
			elseif timer == 20 then--Ravenous Abyss (19.5) OR Interrupting Tremor (20.0)
				if timerExact and timerExact < 19.75 then
					timerRavenousAbyssCD:TLStart(timerExact, eventID, self.vb.ravenousAbyssCount)
					cachedEventIDs[eventID] = "ravenousAbyss"
					return true
				elseif timerExact and timerExact >= 19.75 then
					timerInterruptingTremorCD:TLStart(timerExact, eventID, self.vb.interruptingTremorCount)
					cachedEventIDs[eventID] = "interruptingTremor"
					return true
				end
			elseif timer == 2 or timer == 3 or timer == 6 then--Silverstrike Barrage starts Intermission 1 (Stage 1.5)
				self:SetStage(1.5)
				timerSilverstrikeBarrageCD:TLStart(timer, eventID, self.vb.silverstrikeBarrageCount)
				cachedEventIDs[eventID] = "silverstrikeBarrage"
				return true
			end
		elseif stage == 1.5 then
			--Intermission 1 (Stage 1.5)
			if timer == 2 or timer == 3 or timer == 6 then--Silverstrike Barrage sequence
				timerSilverstrikeBarrageCD:TLStart(timer, eventID, self.vb.silverstrikeBarrageCount)
				cachedEventIDs[eventID] = "silverstrikeBarrage"
				return true
			elseif timer == 25 then--Stage 2 marker; phase actually starts on STATE_CHANGED.
				timerStage2CD:TLStart(timer, eventID)
				cachedEventIDs[eventID] = "stage2Start"
				return true
			end
		elseif stage == 2 then
			--Stage 2
			--NOTE: 20s overlap is inferred using recent cast context when available:
			--Voidstalker(5/6) -> Voidstalker(20), Void Expulsion(14) -> Void Expulsion(20).
			--Unknown contexts intentionally fall through to Blizzard passthrough.
			if timer == 11 then--Null Corona (first Stage 2 event)
				timerNullCoronaCD:TLStart(timer, eventID, self.vb.coronaCount)
				cachedEventIDs[eventID] = "nullCorona"
				lastResolvedType, lastResolvedTimer = "nullCorona", timer
				return true
			elseif timer == 5 or timer == 6 then--Voidstalker Sting
				timerVoidstalkerStingCD:TLStart(timer, eventID, self.vb.voidstalkerStingCount)
				cachedEventIDs[eventID] = "voidstalkerSting"
				lastResolvedType, lastResolvedTimer = "voidstalkerSting", timer
				return true
			elseif timer == 10 then--Call of the Void
				timerCalloftheVoidCD:TLStart(timer, eventID, self.vb.calloftheVoidCount)
				cachedEventIDs[eventID] = "calloftheVoid"
				lastResolvedType, lastResolvedTimer = "calloftheVoid", timer
				return true
			elseif timer == 12 then--Rift Slash
				timerRiftSlashCD:TLStart(timer, eventID)
				cachedEventIDs[eventID] = "riftSlash"
				lastResolvedType, lastResolvedTimer = "riftSlash", timer
				return true
			elseif timer == 14 then--Void Expulsion
				timerVoidExpulsionCD:TLStart(timer, eventID, self.vb.voidExpulsionCount)
				cachedEventIDs[eventID] = "voidExpulsion"
				lastResolvedType, lastResolvedTimer = "voidExpulsion", timer
				return true
			elseif timer == 19 then--Ranger Captain's Mark
				timerRangerCaptainsMarkCD:TLStart(timer, eventID, self.vb.rangerMarkCount)
				cachedEventIDs[eventID] = "rangerMark"
				lastResolvedType, lastResolvedTimer = "rangerMark", timer
				return true
			elseif timer == 20 then--Ambiguous: Voidstalker Sting OR Void Expulsion
				if lastResolvedType == "voidstalkerSting" and (lastResolvedTimer == 5 or lastResolvedTimer == 6) then
					timerVoidstalkerStingCD:TLStart(timer, eventID, self.vb.voidstalkerStingCount)
					cachedEventIDs[eventID] = "voidstalkerSting"
					lastResolvedType, lastResolvedTimer = "voidstalkerSting", timer
					return true
				elseif lastResolvedType == "voidExpulsion" and lastResolvedTimer == 14 then
					timerVoidExpulsionCD:TLStart(timer, eventID, self.vb.voidExpulsionCount)
					cachedEventIDs[eventID] = "voidExpulsion"
					lastResolvedType, lastResolvedTimer = "voidExpulsion", timer
					return true
				end
			elseif timer == 22 then--Cosmic Barrier
				timerCosmicBarrierCD:TLStart(timer, eventID, self.vb.cosmicBarrierCount)
				cachedEventIDs[eventID] = "cosmicBarrier"
				lastResolvedType, lastResolvedTimer = "cosmicBarrier", timer
				return true
			elseif timer == 2 then--Silverstrike Barrage starts Intermission 2 (Stage 2.5)
				self:SetStage(2.5)
				timerSilverstrikeBarrageCD:TLStart(timer, eventID, self.vb.silverstrikeBarrageCount)
				cachedEventIDs[eventID] = "silverstrikeBarrage"
				lastResolvedType, lastResolvedTimer = "silverstrikeBarrage", timer
				return true
			end
		elseif stage == 2.5 then
			--Intermission 2 (Stage 2.5)
			if timer == 10 or timer == 3 then--Silverstrike Barrage sequence
				timerSilverstrikeBarrageCD:TLStart(timer, eventID, self.vb.silverstrikeBarrageCount)
				cachedEventIDs[eventID] = "silverstrikeBarrage"
				return true
			elseif timer == 20 then--Stage 3 marker; phase actually starts on STATE_CHANGED.
				timerStage3CD:TLStart(timer, eventID)
				cachedEventIDs[eventID] = "stage3Start"
				return true
			end
		elseif stage == 3 then
			--Stage 3
			--NOTE: 18s overlap is inferred using recent cast context when available:
			--Aspect(8) -> Grasp(18), Aspect(39) -> Voidstalker(18), opening Voidstalker(15) -> Voidstalker(18).
			--Unknown contexts intentionally fall through to Blizzard passthrough.
			if timer == 29 or timer == 30 then--Null Corona
				timerNullCoronaCD:TLStart(timer, eventID, self.vb.coronaCount)
				cachedEventIDs[eventID] = "nullCorona"
				lastResolvedType, lastResolvedTimer = "nullCorona", timer
				return true
			elseif timer == 59 or timer == 60 then--Devouring Cosmos
				timerDevouringCosmosCD:TLStart(timer, eventID, self.vb.devouringCosmosCount)
				cachedEventIDs[eventID] = "devouringCosmos"
				lastResolvedType, lastResolvedTimer = "devouringCosmos", timer
				return true
			elseif timer == 8 or timer == 9 or timer == 21 or timer == 39 then--Aspect of the End
				timerAspectoftheEndCD:TLStart(timer, eventID, self.vb.aspectoftheEndCount)
				cachedEventIDs[eventID] = "aspectoftheEnd"
				lastResolvedType, lastResolvedTimer = "aspectoftheEnd", timer
				return true
			elseif timer == 12 or timer == 14 or timer == 15 then--Voidstalker Sting
				timerVoidstalkerStingCD:TLStart(timer, eventID, self.vb.voidstalkerStingCount)
				cachedEventIDs[eventID] = "voidstalkerSting"
				lastResolvedType, lastResolvedTimer = "voidstalkerSting", timer
				return true
			elseif timer == 18 then--Ambiguous: Voidstalker Sting OR Grasp of Emptiness
				if (lastResolvedType == "aspectoftheEnd" and lastResolvedTimer == 8) then
					timerGraspofEmptynessCD:TLStart(timer, eventID, self.vb.graspofEmptynessCount)
					cachedEventIDs[eventID] = "grasp"
					lastResolvedType, lastResolvedTimer = "grasp", timer
					return true
				elseif (lastResolvedType == "aspectoftheEnd" and lastResolvedTimer == 39) or (lastResolvedType == "voidstalkerSting" and lastResolvedTimer == 15) then
					timerVoidstalkerStingCD:TLStart(timer, eventID, self.vb.voidstalkerStingCount)
					cachedEventIDs[eventID] = "voidstalkerSting"
					lastResolvedType, lastResolvedTimer = "voidstalkerSting", timer
					return true
				end
			elseif timer == 17 or timer == 19 or timer == 20 then--Grasp of Emptiness
				timerGraspofEmptynessCD:TLStart(timer, eventID, self.vb.graspofEmptynessCount)
				cachedEventIDs[eventID] = "grasp"
				lastResolvedType, lastResolvedTimer = "grasp", timer
				return true
			end
		end
	end

	--Note, bar stage changing and canceling is handled by core
	function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
		if eventInfo.source ~= 0 then return end
		local eventID = eventInfo.id
		local timerExact = eventInfo.duration
		local timer = math.floor(timerExact + 0.5)
		if self:IsEasy() then
			local handled = timersEasy(self, timer, timerExact, eventID)
			if not handled then--Ambiguous/unresolvable duration; let Blizzard show its own bar
				DBM:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo, nil, nil, nil, true)
			end
		end
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		if eventState == 2 then
			local eventType = cachedEventIDs[eventID]
			if eventType == "voidExpulsion" then
				specWarnVoidExpulsion:Show(self.vb.voidExpulsionCount)
				specWarnVoidExpulsion:Play("aesoon")
				self.vb.voidExpulsionCount = self.vb.voidExpulsionCount + 1
			elseif eventType == "nullCorona" then
				warnNullCorona:Show(self.vb.coronaCount)
				self.vb.coronaCount = self.vb.coronaCount + 1
			elseif eventType == "silverstrikeArrow" then
				warnSilverStrikeArrow:Show(self.vb.silverstrikeArrowCount)
				self.vb.silverstrikeArrowCount = self.vb.silverstrikeArrowCount + 1
			elseif eventType == "grasp" then
				self.vb.graspofEmptynessCount = self.vb.graspofEmptynessCount + 1
			elseif eventType == "darkHand" then
				if self:IsTank() then
					specWarnDarkHand:Show()
					specWarnDarkHand:Play("defensive")
				end
				self.vb.darkHandCount = self.vb.darkHandCount + 1
			elseif eventType == "ravenousAbyss" then
				specWarnRavenousAbyss:Show(self.vb.ravenousAbyssCount)
				specWarnRavenousAbyss:Play("watchstep")
				self.vb.ravenousAbyssCount = self.vb.ravenousAbyssCount + 1
			elseif eventType == "interruptingTremor" then
				specWarnInterruptingTremor:Show()
				specWarnInterruptingTremor:Play("stopcast")
				self.vb.interruptingTremorCount = self.vb.interruptingTremorCount + 1
			elseif eventType == "silverstrikeBarrage" then
				self.vb.silverstrikeBarrageCount = self.vb.silverstrikeBarrageCount + 1
			elseif eventType == "voidstalkerSting" then
				warnVoidStalkerSting:Show(self.vb.voidstalkerStingCount)
				self.vb.voidstalkerStingCount = self.vb.voidstalkerStingCount + 1
			elseif eventType == "calloftheVoid" then
				specWarnCalloftheVoid:Show(self.vb.calloftheVoidCount)
				specWarnCalloftheVoid:Play("mobsoon")
				self.vb.calloftheVoidCount = self.vb.calloftheVoidCount + 1
			elseif eventType == "riftSlash" then
				if self:IsTank() then
					specWarnRiftSlash:Show()
					specWarnRiftSlash:Play("defensive")
				end
			elseif eventType == "cosmicBarrier" then
				specWarnCosmicBarrier:Show(self.vb.cosmicBarrierCount)
				specWarnCosmicBarrier:Play("attackshield")
				self.vb.cosmicBarrierCount = self.vb.cosmicBarrierCount + 1
			elseif eventType == "rangerMark" then
				self.vb.rangerMarkCount = self.vb.rangerMarkCount + 1
			elseif eventType == "aspectoftheEnd" then
				self.vb.aspectoftheEndCount = self.vb.aspectoftheEndCount + 1
			elseif eventType == "devouringCosmos" then
				specWarnDevouringCosmos:Show(self.vb.devouringCosmosCount)
				specWarnDevouringCosmos:Play("changeplatform")
				self.vb.devouringCosmosCount = self.vb.devouringCosmosCount + 1
			elseif eventType == "stage2Start" then
				self:SetStage(2)
			elseif eventType == "stage3Start" then
				self:SetStage(3)
			end
			cachedEventIDs[eventID] = nil
		elseif eventState == 3 then
			cachedEventIDs[eventID] = nil
		end
	end
end
