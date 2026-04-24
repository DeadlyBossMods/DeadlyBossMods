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
local warnRiftSimulacrum				= mod:NewCountAnnounce(1261016, 2)--P2 Starting
local warnVoidStalkerSting				= mod:NewCountAnnounce(1237035, 2)--Stage 2 non mythic

local specWarnVoidExpulsion				= mod:NewSpecialWarningCount(1283236, nil, nil, nil, 2, 2)--P1+
--local specWarnSingularityEruption		= mod:NewSpecialWarningDodgeCount(1235622, nil, nil, nil, 2, 2)--Intermission 1
--local specWarnVoidstalkerSting		= mod:NewSpecialWarningCount(1237035, false, nil, nil, 2, 2)--Stage 2 non mythic
local specWarnCalloftheVoid				= mod:NewSpecialWarningSwitchCount(1237837, nil, nil, nil, 2, 2)--P2
local specWarnCosmicBarrier				= mod:NewSpecialWarningSwitchCount(1246918, "Dps", nil, nil, 2, 2)--P2
local specWarnDevouringCosmos			= mod:NewSpecialWarningCount(1238843, nil, nil, nil, 3, 2)--P3
local specWarnDarkHand					= mod:NewSpecialWarningDefensive(1233787, nil, nil, nil, 1, 2)--P1 Tank Add
local specWarnRavenousAbyss				= mod:NewSpecialWarningDodgeCount(1243753, nil, nil, nil, 4, 2)--P1 Add
local specWarnInterruptingTremor		= mod:NewSpecialWarningCount(1243743, nil, nil, 2, 2, 2)--P1 Add
local specWarnCosmicPortal				= mod:NewSpecialWarningCount(1261339, nil, nil, nil, 2, 2)--Mythic only mechanic of unknown nature
local specWarnRiftSlash					= mod:NewSpecialWarningDefensive(1246461, nil, nil, nil, 1, 2)--P2 Rift Simulacrum slash attack

local timerNullCoronaCD					= mod:NewCDCountTimer(20.5, 1233865, DBM_COMMON_L.HEALABSORB.." (%s)", "-Tank", nil, 3, nil, DBM_COMMON_L.MAGIC_ICON..DBM_COMMON_L.HEALER_ICON)--P1+
local timerVoidExpulsionCD				= mod:NewCDCountTimer(20.5, 1283236, nil, nil, nil, 3)--P1+
local timerSilverstrikeArrowCD			= mod:NewCDCountTimer(20.5, 1233602, 208407, nil, nil, 3, nil, DBM_COMMON_L.IMPORTANT_ICON)--P1/P3, shortname "Arrow"
local timerSilverstrikeBarrageCD		= mod:NewCDCountTimer(20.5, 1234564, 208071, nil, nil, 3)--Intermission 1, shortname "Arrow Barrage"
--local timerSingularityEruptionCD		= mod:NewCDCountTimer(20.5, 1235622, nil, nil, nil, 3)--Intermission 1 (Passive, doesn't have a timer)
local timerVoidstalkerStingCD			= mod:NewCDCountTimer(20.5, 1237035, nil, nil, nil, 2)--Stage 2 non mythic
local timerCalloftheVoidCD				= mod:NewCDCountTimer(20.5, 1237837, DBM_COMMON_L.ADDS.." (%s)", nil, nil, 1)--P2
local timerRangerCaptainsMarkCD			= mod:NewCDCountTimer(20.5, 1237614, 208407, nil, nil, 3, nil, DBM_COMMON_L.IMPORTANT_ICON)--P3, also shortname "Arrow"
local timerCosmicBarrierCD				= mod:NewCDCountTimer(20.5, 1246918, 151702, nil, nil, 5)--P2, shortname "Shield"
local timerAspectoftheEndCD				= mod:NewCDCountTimer(20.5, 1239111, 1234576, nil, nil, 3, nil, DBM_COMMON_L.IMPORTANT_ICON)--Intermission 2, shortname "Tethers"
local timerGraspofEmptynessCD			= mod:NewCDCountTimer(20.5, 1232470, 367465, nil, nil, 3)--P1, shortname "Grasp"
local timerDevouringCosmosCD			= mod:NewCDCountTimer(20.5, 1238843, nil, nil, nil, 5, nil, DBM_COMMON_L.DEADLY_ICON)--P3
local timerDarkHandCD					= mod:NewCDCountTimer(20.5, 1233787, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--P1 Tank Add
local timerRavenousAbyssCD				= mod:NewCDCountTimer(20.5, 1243753, DBM_COMMON_L.AVOID.." (%s)", nil, nil, 3)--P1 Add
local timerInterruptingTremorCD			= mod:NewCDCountTimer(20.5, 1243743, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)--P1 Add
local timerRiftSimulacrumCD				= mod:NewCDCountTimer(20.5, 1261016, nil, nil, nil, 1)--P2/P3 mythic add spawn
local timerCosmicPortalCD				= mod:NewCDCountTimer(20.5, 1261339, nil, nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)--Mythic only mechanic of unknown nature
local timerRiftSlashCD					= mod:NewCDCountTimer(20.5, 1246461, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--P2 Rift Simulacrum slash attack
local timerStage2CD						= mod:NewCDTimer(20.5, 1272966, nil, nil, nil, 6)
local timerStage3CD						= mod:NewCDTimer(20.5, 1273378, nil, nil, nil, 6)
local timerBerserkCD					= mod:NewBerserkTimer(600)

mod:AddPrivateAuraSoundOption({1233865,1233887}, true, 1233865, 1, 1, "absorbyou", 19)--Null Corona
mod:AddPrivateAuraSoundOption(1283236, true, 1283236, 1, 1, "orbrun", 2)--Void Expulsion
mod:AddPrivateAuraSoundOption(1242553, true, 1283236, 1, 2, "watchfeet", 8)--Void Remnants (GTFO left by Void Expulsion)
mod:AddPrivateAuraSoundOption(1233602, true, 1233602, 1, 1, "arrowyou", 19)--Silverstrike Arrow
mod:AddPrivateAuraSoundOption(1243981, true, 1234564, 1, 3, "debuffyou", 17)--Silverstrike Barrage
--mod:AddPrivateAuraSoundOption(1234570, false, 1234570, 1, 1)--Stellar Emission (stacking debuff during Intermission 1)
mod:AddPrivateAuraSoundOption(1238206, true, 1238206, 1, 2, "watchfeet", 8)--Volatile Fissure
mod:AddPrivateAuraSoundOption({1237623,1259861}, true, 1237614, 1, 1, "markyou", 19)--Ranger Captain's Mark
mod:AddPrivateAuraSoundOption(1239111, true, 1239111, 1, 1, "lineapart", 2)--Aspect of the End
mod:AddPrivateAuraSoundOption(1255453, false, 1239111, 1, 3, "debuffyou", 2)--Gravity Collapse (Aspect of the End debuff)
mod:AddPrivateAuraSoundOption({1232470,1260027}, true, 1232470, 1, 1, "graspyou", 19)--Grasp of Emptiness
mod:AddPrivateAuraSoundOption(1243753, true, 1243753, 1, 3, "debuffyou", 17)--Failing to get out of Ravenous Abyss
mod:AddPrivateAuraSoundOption(1238708, true, 1238708, 1, 1, "speedyou", 19)--Dark Rush

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
mod.vb.riftSlashCount = 0
mod.vb.cosmicPortalCount = 0
mod.vb.riftSimulacrumCount = 0
local badStateDetected = false
local stage2p5Seen, stage3Recovered = false, false
local stage2TwentyCount = 0
local heroicStage2InitialRiftSeen = false
local mythicStage1SAOpenerSeen = false
local mythicStage1SAErrataAnchorTime = 0
local stage1FortyEightCount = 0
local lastTLEvent = 0
local mythicStage2RiftSimulacrumSeen = false
local mythicStage2VoidstalkerOpenerDone = false
local mythicStage2SixCount = 0
local mythicStage2FourCount = 0
local mythicStage2TwentyFiveCount = 0
local mythicStage1FortyCount = 0
local mythicStage3RiftSimulacrumSeen = false
local mythicStage3FourteenCount = 0
local mythicStage3FourteenDarkHandMode = false
local mythicStage3TremorWindow = 0

--Heroic Stage 3 disambiguation micro-table built from CrownWipe5.
--Key format: "<lastResolvedType>:<lastResolvedRoundedTimer>" -> current eventType.
local heroicStage3MicroTable = {
	[11] = {
		["aspectoftheEnd:8"] = "grasp",
		default = "nullCorona"
	},
	[12] = {
		["aspectoftheEnd:9"] = "grasp",
		default = "voidstalkerSting"
	},
	[18] = {
		["aspectoftheEnd:8"] = "grasp",
		["aspectoftheEnd:39"] = "voidstalkerSting",
		["voidstalkerSting:15"] = "voidstalkerSting",
		["grasp:7"] = "voidstalkerSting"
	}
}

---@param timer number
---@param lastResolvedType string?
---@param lastResolvedTimer number?
---@return string?
local function resolveHeroicStage3Ambiguous(timer, lastResolvedType, lastResolvedTimer)
	local timerTable = heroicStage3MicroTable[timer]
	if not timerTable then return nil end
	if lastResolvedType and lastResolvedTimer then
		local key = lastResolvedType .. ":" .. lastResolvedTimer
		local resolved = timerTable[key]
		if resolved then
			return resolved
		end
	end
	return timerTable.default
end

---@param self DBMMod
	---@param dontSetAlerts boolean? Called when user has disabled DBM bars and is only using timeline, therefore we must still enable SetTimeline calls even in hardcodes
local function setFallback(self, dontSetAlerts)
	--Blizz API fallbacks
	timerNullCoronaCD:SetTimeline(4)
	if not dontSetAlerts then
		specWarnVoidExpulsion:SetAlert(5, "aesoon", 2, 2, 0)
		specWarnCalloftheVoid:SetAlert(10, "mobsoon", 2, 2)
		specWarnCosmicBarrier:SetAlert(12, "attackshield", 2, 2, 0)
		specWarnDevouringCosmos:SetAlert(15, "changeplatform", 19, 4)
		if self:IsTank() then
			specWarnDarkHand:SetAlert(64, "defensive", 2, 2)
		end
		specWarnRavenousAbyss:SetAlert(65, "watchstep", 2, 2)
		if self:IsSpellCaster() then
			specWarnInterruptingTremor:SetAlert(66, "stopcast", 2, 2, 0)
		else
			specWarnInterruptingTremor:SetAlert(66, "aesoon", 2, 2, 0)
		end
	--	warnRiftSimulacrum:SetAlert(135, "bigmob", 2, 2, 0)
		specWarnCosmicPortal:SetAlert(136, "bigmobsoon", 2, 2)
		if self:IsTank() then
			specWarnRiftSlash:SetAlert(137, "defensive", 2, 2)
		end
	end
	timerVoidExpulsionCD:SetTimeline(5)
	timerSilverstrikeArrowCD:SetTimeline(6)
	timerSilverstrikeBarrageCD:SetTimeline(7)
--	specWarnSingularityEruption:SetAlert(8, "watchstep", 2, 2)
--	timerSingularityEruptionCD:SetTimeline(8)
	timerVoidstalkerStingCD:SetTimeline(9)
	timerCalloftheVoidCD:SetTimeline(10)
	timerRangerCaptainsMarkCD:SetTimeline({11, 131})--Regular, Mythic?
	timerCosmicBarrierCD:SetTimeline(12)
	timerAspectoftheEndCD:SetTimeline(13)
	timerGraspofEmptynessCD:SetTimeline({14, 132})--Regular, Mythic?
	timerDevouringCosmosCD:SetTimeline(15)
	timerDarkHandCD:SetTimeline(64)
	timerRavenousAbyssCD:SetTimeline(65)
	timerInterruptingTremorCD:SetTimeline(66)
	timerCosmicPortalCD:SetTimeline(136)
	timerRiftSlashCD:SetTimeline(137)
	timerStage2CD:SetTimeline(351)
	timerRiftSimulacrumCD:SetTimeline(135)
end

---@param self DBMMod
local function moriumIsTanked(self)
	if self:IsTanking("player", "boss1", nil, true) then
		specWarnDarkHand:Show()
		specWarnDarkHand:Play("carefly")
	end
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
	self:TLResolveReset()
	stage2p5Seen, stage3Recovered = false, false
	stage2TwentyCount = 0
	heroicStage2InitialRiftSeen = false
	mythicStage1SAOpenerSeen = false
	mythicStage1SAErrataAnchorTime = 0
	stage1FortyEightCount = 0
	mythicStage1FortyCount = 0
	lastTLEvent = 0
	mythicStage2RiftSimulacrumSeen = false
	mythicStage2VoidstalkerOpenerDone = false
	mythicStage2SixCount = 0
	mythicStage2FourCount = 0
	mythicStage2TwentyFiveCount = 0
	mythicStage3RiftSimulacrumSeen = false
	mythicStage3FourteenCount = 0
	mythicStage3FourteenDarkHandMode = false
	mythicStage3TremorWindow = 0
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
	self.vb.riftSlashCount = 1
	self.vb.cosmicPortalCount = 1
	self.vb.riftSimulacrumCount = 1
	self:SetStage(1)

	if DBM.Options.HardcodedTimer and not self:IsStory() and not badStateDetected then
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		)
		if DBM.Options.HideDBMBars then
			setFallback(self, true)
		end
		--pre Schedule first 3 abilities that have ambigous timers
		self:Schedule(4, moriumIsTanked, self)
		timerDarkHandCD:Start(4, 1)
		specWarnRavenousAbyss:Schedule(4, 1)
		specWarnRavenousAbyss:ScheduleVoice(4, "watchstep")
		timerRavenousAbyssCD:Start(4, 1)
		specWarnInterruptingTremor:Schedule(4, 1)
		if self:IsSpellCaster() then
			specWarnInterruptingTremor:ScheduleVoice(4, "stopcast")
		else
			specWarnInterruptingTremor:ScheduleVoice(4, "aesoon")
		end
		timerInterruptingTremorCD:Start(4, 1)
		if self:IsHeroic() then
			--Stage 1 has a 2 minute 10 second berserk
			timerBerserkCD:Start(130)
		end
	else
		setFallback(self)
	end
--	self:EnablePrivateAuraSound(1234570, "debuffyou", 17)--Phase soft enrage, probably not worth annoucning, it kinda just persistently stacks
end

function mod:OnCombatEnd()
	self:TLCountReset()
	self:TLResolveReset()
	stage2p5Seen, stage3Recovered = false, false
	stage2TwentyCount = 0
	heroicStage2InitialRiftSeen = false
	mythicStage1SAOpenerSeen = false
	mythicStage1SAErrataAnchorTime = 0
	stage1FortyEightCount = 0
	mythicStage1FortyCount = 0
	mythicStage2RiftSimulacrumSeen = false
	mythicStage2VoidstalkerOpenerDone = false
	mythicStage2SixCount = 0
	mythicStage2FourCount = 0
	mythicStage2TwentyFiveCount = 0
	mythicStage3RiftSimulacrumSeen = false
	mythicStage3FourteenCount = 0
	mythicStage3FourteenDarkHandMode = false
	mythicStage3TremorWindow = 0
	self:UnregisterShortTermEvents()
end

do
	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersEasy(self, timer, timerExact, eventID)
		if timer == 0 then return end--Absolute errata introduced into timeline by patch 12.0.5
		local stage = self:GetStage()
		if stage == 1 then
			--Stage 1
			--NOTE: Per encounter secret restrictions, only eventID + duration are used.
			--S1 still has one unresolved opener overlap intentionally skipped in this scope:
			--4s overlap among Dark Hand, Interrupting Tremor, and Ravenous Abyss.
			--Recurring Dark Hand remains resolved by the unique 17s bucket.
			--Recurring casts are now split by exact duration: 19.5 (Abyss) vs 20.0 (Tremor).
			if timer == 60 or timer == 39 then--Void Expulsion
				timerVoidExpulsionCD:TLStart(timer, eventID, self:TLCountStart(eventID, "voidExpulsion", "voidExpulsionCount"))
			elseif timer == 46 or timer == 47 or timer == 48 then--Null Corona
				timerNullCoronaCD:TLStart(timer, eventID, self:TLCountStart(eventID, "nullCorona", "coronaCount"))
			elseif timer == 21 or timer == 23 or timer == 24 then--Silverstrike Arrow
				timerSilverstrikeArrowCD:TLStart(timer, eventID, self:TLCountStart(eventID, "silverstrikeArrow", "silverstrikeArrowCount"))
			elseif timer == 5 or timer == 28 or timer == 32 then--Grasp of Emptiness
				timerGraspofEmptynessCD:TLStart(timer, eventID, self:TLCountStart(eventID, "grasp", "graspofEmptynessCount"))
			elseif timer == 17 then--Dark Hand
				timerDarkHandCD:TLStart(timer, eventID, self:TLCountStart(eventID, "darkHand", "darkHandCount"))
			elseif timer == 20 then--Ravenous Abyss (19.5) OR Interrupting Tremor (20.0)
				if timerExact and timerExact < 19.75 then
					timerRavenousAbyssCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "ravenousAbyss", "ravenousAbyssCount"))
				elseif timerExact and timerExact >= 19.75 then
					timerInterruptingTremorCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "interruptingTremor", "interruptingTremorCount"))
				end
			elseif timer == 4 then
				--Unresolveable initial casts, we just return to prevent fallback
				--Those initial 4 second timers and cast warnings are prescheduled on pull instead
				return
			elseif timer == 2 then
				--Intermission 1 starts with Silverstrike Barrage 1.5s (rounded 2).
				--Prefer exact-duration signal; keep legacy gap-check as backup.
				if (timerExact and timerExact < 1.75) and (GetTime() - lastTLEvent > 10) then
					self:SetStage(1.5)
					timerSilverstrikeBarrageCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "silverstrikeBarrage", "silverstrikeBarrageCount"))
					timerBerserkCD:Cancel()
				else
					timerNullCoronaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullCorona", "coronaCount"))
					self:TLResolvePush("nullCorona", timer)
				end
			elseif timer == 25 then
				--Recovery: if Stage Two marker appears while still in stage 1, transition chain was missed.
				if self:GetStage(1) then
					self:SetStage(1.5)
				end
				timerStage2CD:TLStart(timerExact, eventID)
				self:TLCountStart(eventID, "stage2Start")
			else--Reached end of chain without finding a valid timer, hardcode has failed, fall back to Blizz API
				badStateDetected = true
				self:ResumeBlizzardAPI()
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match encounter timeline events to expected timers, falling back to Blizzard API|r", nil, nil, nil, true)
			end
		elseif stage == 1.5 then
			--Intermission 1 (Stage 1.5)
			if timer == 2 or timer == 3 or timer == 6 then--Silverstrike Barrage sequence
				timerSilverstrikeBarrageCD:TLStart(timer, eventID, self:TLCountStart(eventID, "silverstrikeBarrage", "silverstrikeBarrageCount"))
			elseif timer == 25 then--Stage 2 marker; phase actually starts on STATE_CHANGED.
				timerStage2CD:TLStart(timer, eventID)
				self:TLCountStart(eventID, "stage2Start")
			end
		elseif stage == 2 then
			--Stage 2
			--NOTE: Stage 2 20s buckets are resolved by Stage 2-local occurrence index
			--using validated Easy-log ordering: 1st=Void Expulsion, 2nd=Voidstalker Sting,
			--then repeating for the rest of Stage 2.
			--Opener adds additional duration buckets not seen in later loops:
			--Null Corona(13), Void Expulsion(16), Voidstalker(8), Call(12), Ranger's Mark(21), Cosmic Barrier(24), Rift Slash(6).
			if timer == 11 or timer == 13 then--Null Corona
				timerNullCoronaCD:TLStart(timer, eventID, self:TLCountStart(eventID, "nullCorona", "coronaCount"))
				self:TLResolvePush("nullCorona", timer)
			elseif timer == 16 or timer == 14 then--Void Expulsion
				timerVoidExpulsionCD:TLStart(timer, eventID, self:TLCountStart(eventID, "voidExpulsion", "voidExpulsionCount"))
				self:TLResolvePush("voidExpulsion", timer)
			elseif timer == 8 then--Voidstalker Sting opener
				timerVoidstalkerStingCD:TLStart(timer, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
				self:TLResolvePush("voidstalkerSting", timer)
			elseif timer == 10 then--Call of the Void recurring
				timerCalloftheVoidCD:TLStart(timer, eventID, self:TLCountStart(eventID, "calloftheVoid", "calloftheVoidCount"))
				self:TLResolvePush("calloftheVoid", timer)
			elseif timer == 12 then--Ambiguous opener Call of the Void (12) vs Rift Slash (12)
				local lastResolvedType, lastResolvedTimer = self:TLResolvePeek()
				if lastResolvedType == "voidstalkerSting" and lastResolvedTimer == 8 then
					timerCalloftheVoidCD:TLStart(timer, eventID, self:TLCountStart(eventID, "calloftheVoid", "calloftheVoidCount"))
					self:TLResolvePush("calloftheVoid", timer)
				else
					timerRiftSlashCD:TLStart(timer, eventID, self:TLCountStart(eventID, "riftSlash", "riftSlashCount"))
					self:TLResolvePush("riftSlash", timer)
				end
			elseif timer == 6 then--Ambiguous opener Rift Slash (6) vs recurring Voidstalker Sting (6)
				local lastResolvedType, lastResolvedTimer = self:TLResolvePeek()
				if lastResolvedType == "cosmicBarrier" and lastResolvedTimer == 24 then
					timerRiftSlashCD:TLStart(timer, eventID, self:TLCountStart(eventID, "riftSlash", "riftSlashCount"))
					self:TLResolvePush("riftSlash", timer)
				else
					timerVoidstalkerStingCD:TLStart(timer, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
					self:TLResolvePush("voidstalkerSting", timer)
				end
			elseif timer == 5 then--Voidstalker Sting recurring
				timerVoidstalkerStingCD:TLStart(timer, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
				self:TLResolvePush("voidstalkerSting", timer)
			elseif timer == 21 or timer == 19 then--Ranger Captain's Mark
				timerRangerCaptainsMarkCD:TLStart(timer, eventID, self:TLCountStart(eventID, "rangerMark", "rangerMarkCount"))
				self:TLResolvePush("rangerMark", timer)
			elseif timer == 20 then--Ambiguous: Voidstalker Sting OR Void Expulsion
				--Observed complete Easy logs show a strict alternation for Stage 2 20s buckets:
				--1st=Void Expulsion, 2nd=Voidstalker Sting, then repeating.
				--Use Stage 2-local occurrence index for deterministic routing.
				stage2TwentyCount = stage2TwentyCount + 1
				if stage2TwentyCount % 2 == 1 then
					timerVoidExpulsionCD:TLStart(timer, eventID, self:TLCountStart(eventID, "voidExpulsion", "voidExpulsionCount"))
					self:TLResolvePush("voidExpulsion", timer)
				else
					--Blizzards timer is actually wrong, it starts a 20 second timer but it's cast 14 seconds later
					--This can be verified in week3 normal log where you can see every 20 second sting timer refreshed before expire with 6 sec remaining
					timerVoidstalkerStingCD:TLStart(14, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
					self:TLResolvePush("voidstalkerSting", timer)
				end
			elseif timer == 24 or timer == 22 then--Cosmic Barrier
				timerCosmicBarrierCD:TLStart(timer, eventID, self:TLCountStart(eventID, "cosmicBarrier", "cosmicBarrierCount"))
				self:TLResolvePush("cosmicBarrier", timer)
			elseif timer == 2 then--Silverstrike Barrage starts Intermission 2 (Stage 2.5)
				self:SetStage(2.5)
				stage2p5Seen = true
				timerSilverstrikeBarrageCD:TLStart(timer, eventID, self:TLCountStart(eventID, "silverstrikeBarrage", "silverstrikeBarrageCount"))
				self:TLResolvePush("silverstrikeBarrage", timer)
			end
		elseif stage == 2.5 then
			--Intermission 2 (Stage 2.5)
			--Hardening: if Stage 3 marker was missed/passthrough, auto-correct once using
			--durations unique to Stage 3 startup windows.
			if stage2p5Seen and not stage3Recovered and (timer == 59 or timer == 60 or timer == 29 or timer == 30) then
				stage3Recovered = true
				self:SetStage(3)
				DBM:Debug("Crown hardcoded: auto-corrected to Stage 3 in 2.5 using duration " .. timer .. " (eventID " .. eventID .. ")", 2, nil, nil, true)
				return timersEasy(self, timer, timerExact, eventID)
			end
			if timer == 10 or timer == 3 then--Silverstrike Barrage sequence
				timerSilverstrikeBarrageCD:TLStart(timer, eventID, self:TLCountStart(eventID, "silverstrikeBarrage", "silverstrikeBarrageCount"))
				self:TLResolvePush("silverstrikeBarrage", timer)
			elseif timer == 20 then--Stage 3 marker; phase actually starts on STATE_CHANGED.
				timerStage3CD:TLStart(timer, eventID)
				self:TLCountStart(eventID, "stage3Start")
			end
		elseif stage == 3 then
			--Stage 3
			--Known Stage 3 duration map (validated t=323-488):
			--Null Corona: 29/30
			--Devouring Cosmos: 59/60
			--Aspect of the End: 8/9/21/39
			--Voidstalker Sting: 12/14/15 (+18 ambiguous)
			--Grasp of Emptiness: 17/19/20 (+18 ambiguous)
			--NOTE: 18s overlap is inferred using recent cast context when available:
			--Aspect(8) -> Grasp(18), Aspect(39) -> Voidstalker(18), opening Voidstalker(15) -> Voidstalker(18).
			--Unknown contexts intentionally fall through to Blizzard passthrough.
			if timer == 29 or timer == 30 then--Null Corona
				timerNullCoronaCD:TLStart(timer, eventID, self:TLCountStart(eventID, "nullCorona", "coronaCount"))
				self:TLResolvePush("nullCorona", timer)
			elseif timer == 59 or timer == 60 then--Devouring Cosmos
				timerDevouringCosmosCD:TLStart(timer, eventID, self:TLCountStart(eventID, "devouringCosmos", "devouringCosmosCount"))
				self:TLResolvePush("devouringCosmos", timer)
			elseif timer == 8 or timer == 9 or timer == 21 or timer == 39 then--Aspect of the End
				if timer == 21 then
					--Blizzards timer is actually wrong, it starts a 21 second timer but it's cast 13 seconds later
					--This can be verified in week3 normal log where you can see the 21 second aspect timer refreshed before expire with 8 sec remaining
					timer = 13
				end
				timerAspectoftheEndCD:TLStart(timer, eventID, self:TLCountStart(eventID, "aspectoftheEnd", "aspectoftheEndCount"))
				self:TLResolvePush("aspectoftheEnd", timer)
			elseif timer == 12 or timer == 14 or timer == 15 then--Voidstalker Sting
				timerVoidstalkerStingCD:TLStart(timer, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
				self:TLResolvePush("voidstalkerSting", timer)
			elseif timer == 18 then--Ambiguous: Voidstalker Sting OR Grasp of Emptiness
				local lastResolvedType, lastResolvedTimer = self:TLResolvePeek()
				if (lastResolvedType == "aspectoftheEnd" and lastResolvedTimer == 8) then
					timerGraspofEmptynessCD:TLStart(timer, eventID, self:TLCountStart(eventID, "grasp", "graspofEmptynessCount"))
					self:TLResolvePush("grasp", timer)
				elseif (lastResolvedType == "aspectoftheEnd" and lastResolvedTimer == 39) or (lastResolvedType == "voidstalkerSting" and lastResolvedTimer == 15) then
					timerVoidstalkerStingCD:TLStart(timer, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
					self:TLResolvePush("voidstalkerSting", timer)
				end
			elseif timer == 17 or timer == 19 or timer == 20 then--Grasp of Emptiness
				timerGraspofEmptynessCD:TLStart(timer, eventID, self:TLCountStart(eventID, "grasp", "graspofEmptynessCount"))
				self:TLResolvePush("grasp", timer)
			end
		end
	end

	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersHeroic(self, timer, timerExact, eventID)
		if timer == 0 then return end--Absolute errata introduced into timeline by patch 12.0.5
		local stage = self:GetStage()
		if stage == 1 then
			--Stage 1 Heroic (Week 3 validated from CrownWipe2-5)
			if timer == 4 then
				--Unresolveable initial 4s casts (Tremor, Abyss, Dark Hand)
				--Those are prescheduled on pull
				return
			elseif timer == 2 then
				--Intermission 1 starts with Silverstrike Barrage 1.5s (rounded 2).
				--Prefer exact-duration signal; keep legacy gap-check as backup.
				if (timerExact and timerExact < 1.75) and (GetTime() - lastTLEvent > 10) then
					self:SetStage(1.5)
					timerSilverstrikeBarrageCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "silverstrikeBarrage", "silverstrikeBarrageCount"))
					timerBerserkCD:Cancel()
				else
					timerNullCoronaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullCorona", "coronaCount"))
					self:TLResolvePush("nullCorona", timer)
				end
			elseif timer == 25 then
				--Recovery: if Stage Two marker appears while still in stage 1, transition chain was missed.
				if self:GetStage(1) then
					self:SetStage(1.5)
				end
				timerStage2CD:TLStart(timerExact, eventID)
				self:TLCountStart(eventID, "stage2Start")
			elseif timer == 5 then--Grasp opener/late Grasp(4.5 rounded) OR late Null Corona(5)
				local lastResolvedType, lastResolvedTimer = self:TLResolvePeek()
				if lastResolvedType == "nullCorona" and lastResolvedTimer == 2 then
					timerNullCoronaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullCorona", "coronaCount"))
					self:TLResolvePush("nullCorona", timer)
				else
					timerGraspofEmptynessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grasp", "graspofEmptynessCount"))
					self:TLResolvePush("grasp", timer)
				end
			elseif timer == 11 or timer == 12 or timer == 13 then--Void Expulsion early buckets
				timerVoidExpulsionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidExpulsion", "voidExpulsionCount"))
				self:TLResolvePush("voidExpulsion", timer)
			elseif timer == 21 or timer == 23 or timer == 24 then--Silverstrike Arrow
				timerSilverstrikeArrowCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "silverstrikeArrow", "silverstrikeArrowCount"))
				self:TLResolvePush("silverstrikeArrow", timer)
			elseif timer == 26 then--Dark Hand
				timerDarkHandCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "darkHand", "darkHandCount"))
				self:TLResolvePush("darkHand", timer)
			elseif timer == 20 then--Ravenous Abyss (19.5) OR Interrupting Tremor (20.0)
				if timerExact and timerExact < 19.75 then
					timerRavenousAbyssCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "ravenousAbyss", "ravenousAbyssCount"))
					self:TLResolvePush("ravenousAbyss", timer)
				elseif timerExact and timerExact >= 19.75 then
					timerInterruptingTremorCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "interruptingTremor", "interruptingTremorCount"))
					self:TLResolvePush("interruptingTremor", timer)
				end
			elseif timer == 27 or timer == 44 or timer == 45 then--Null Corona
				if timer == 27 then
					--Blizzard timer is wrong here. We need to adjust it
					timerExact = 25.5
				end
				timerNullCoronaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullCorona", "coronaCount"))
				self:TLResolvePush("nullCorona", timer)
			elseif timer == 28 or timer == 29 or timer == 31 or timer == 32 then--Grasp of Emptiness
				local count = self:TLCountStart(eventID, "grasp", "graspofEmptynessCount")
				if count == 5 and timer == 28 then
					--Blizzard timer is wrong here. We need to adjust it
					timerExact = 23.5
				end
				timerGraspofEmptynessCD:TLStart(timerExact, eventID, count)
				self:TLResolvePush("grasp", timer)
			elseif timer == 39 then--Void Expulsion
				timerVoidExpulsionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidExpulsion", "voidExpulsionCount"))
				self:TLResolvePush("voidExpulsion", timer)
			elseif timer == 48 then--Void Expulsion (2nd cast) OR Null Corona (3rd cast); first occurrence is VE, second is NC
				stage1FortyEightCount = stage1FortyEightCount + 1
				if stage1FortyEightCount == 1 then
					timerVoidExpulsionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidExpulsion", "voidExpulsionCount"))
					self:TLResolvePush("voidExpulsion", timer)
				else
					timerNullCoronaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullCorona", "coronaCount"))
					self:TLResolvePush("nullCorona", timer)
				end
			else
				badStateDetected = true
				self:ResumeBlizzardAPI()
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match Heroic stage 1 timeline events, falling back to Blizzard API|r", nil, nil, nil, true)
			end
		elseif stage == 1.5 then
			--Intermission 1
			if timer == 2 or timer == 3 or timer == 6 or timer == 8 or timer == 10 then--Silverstrike Barrage sequence
				timerSilverstrikeBarrageCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "silverstrikeBarrage", "silverstrikeBarrageCount"))
			elseif timer == 25 then--Stage 2 marker; phase actually starts on STATE_CHANGED.
				timerStage2CD:TLStart(timerExact, eventID)
				self:TLCountStart(eventID, "stage2Start")
			end
		elseif stage == 2 then
			--Stage 2 Heroic (validated from CrownWipe3/4 and CrownWipe5 opener)
			if timer == 11 or timer == 13 then--Null Corona
				timerNullCoronaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullCorona", "coronaCount"))
				self:TLResolvePush("nullCorona", timer)
			elseif timer == 14 or timer == 15 or timer == 16 then--Void Expulsion
				timerVoidExpulsionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidExpulsion", "voidExpulsionCount"))
				self:TLResolvePush("voidExpulsion", timer)
			elseif timer == 8 then--Voidstalker Sting opener
				timerVoidstalkerStingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
				self:TLResolvePush("voidstalkerSting", timer)
			elseif timer == 10 then--Call of the Void recurring
				timerCalloftheVoidCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "calloftheVoid", "calloftheVoidCount"))
				self:TLResolvePush("calloftheVoid", timer)
			elseif timer == 12 then--Ambiguous opener/loop: Call of the Void OR Rift Slash
				local lastResolvedType, lastResolvedTimer = self:TLResolvePeek()
				if lastResolvedType == "voidstalkerSting" and lastResolvedTimer == 8 then
					timerCalloftheVoidCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "calloftheVoid", "calloftheVoidCount"))
					self:TLResolvePush("calloftheVoid", timer)
				else
					timerRiftSlashCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "riftSlash", "riftSlashCount"))
					self:TLResolvePush("riftSlash", timer)
				end
			elseif timer == 6 then--Heroic opener Rift Slash only; later 6s are Voidstalker Sting
				if not heroicStage2InitialRiftSeen then
					heroicStage2InitialRiftSeen = true
					timerRiftSlashCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "riftSlash", "riftSlashCount"))
					self:TLResolvePush("riftSlash", timer)
				else
					timerVoidstalkerStingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
					self:TLResolvePush("voidstalkerSting", timer)
				end
			elseif timer == 5 then--Voidstalker Sting recurring
				timerVoidstalkerStingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
				self:TLResolvePush("voidstalkerSting", timer)
			elseif timer == 19 or timer == 21 then--Ranger Captain's Mark
				timerRangerCaptainsMarkCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rangerMark", "rangerMarkCount"))
				self:TLResolvePush("rangerMark", timer)
			elseif timer == 20 then--Ambiguous: Voidstalker Sting OR Void Expulsion
				stage2TwentyCount = stage2TwentyCount + 1
				if stage2TwentyCount % 2 == 1 then
					timerVoidExpulsionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidExpulsion", "voidExpulsionCount"))
					self:TLResolvePush("voidExpulsion", timer)
				else
					timerVoidstalkerStingCD:TLStart(14, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
					self:TLResolvePush("voidstalkerSting", timer)
				end
			elseif timer == 22 or timer == 24 then--Cosmic Barrier
				timerCosmicBarrierCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "cosmicBarrier", "cosmicBarrierCount"))
				self:TLResolvePush("cosmicBarrier", timer)
			elseif timer == 25 then--Duplicate Stage 2 marker can appear in logs, ignore
				return
			elseif timer == 2 then--Intermission 2 opener
				self:SetStage(2.5)
				stage2p5Seen = true
				timerSilverstrikeBarrageCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "silverstrikeBarrage", "silverstrikeBarrageCount"))
				self:TLResolvePush("silverstrikeBarrage", timer)
			end
		elseif stage == 2.5 then
			--Intermission 2
			if stage2p5Seen and not stage3Recovered and (timer == 59 or timer == 60 or timer == 29 or timer == 30 or timer == 9 or timer == 39) then
				stage3Recovered = true
				self:SetStage(3)
				DBM:Debug("Crown heroic hardcoded: auto-corrected to Stage 3 in 2.5 using duration " .. timer .. " (eventID " .. eventID .. ")", 2, nil, nil, true)
				return timersHeroic(self, timer, timerExact, eventID)
			end
			if timer == 2 or timer == 3 or timer == 6 or timer == 9 or timer == 10 then--Silverstrike Barrage sequence
				timerSilverstrikeBarrageCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "silverstrikeBarrage", "silverstrikeBarrageCount"))
				self:TLResolvePush("silverstrikeBarrage", timer)
			elseif timer == 20 then--Stage 3 marker; phase actually starts on STATE_CHANGED.
				timerStage3CD:TLStart(timerExact, eventID)
				self:TLCountStart(eventID, "stage3Start")
			end
		elseif stage == 3 then
			--Stage 3 Heroic (partial, from CrownWipe5 + existing S3 map)
			if timer == 29 or timer == 30 then--Null Corona
				timerNullCoronaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullCorona", "coronaCount"))
				self:TLResolvePush("nullCorona", timer)
			elseif timer == 59 or timer == 60 then--Devouring Cosmos
				timerDevouringCosmosCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "devouringCosmos", "devouringCosmosCount"))
				self:TLResolvePush("devouringCosmos", timer)
			elseif timer == 8 or timer == 9 or timer == 21 or timer == 39 then--Aspect of the End
				if timer == 21 then
					timerAspectoftheEndCD:TLStart(13, eventID, self:TLCountStart(eventID, "aspectoftheEnd", "aspectoftheEndCount"))
				else
					timerAspectoftheEndCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "aspectoftheEnd", "aspectoftheEndCount"))
				end
				self:TLResolvePush("aspectoftheEnd", timer)
			elseif timer == 12 then--Ambiguous: Voidstalker Sting OR Grasp of Emptiness
				local lastResolvedType, lastResolvedTimer = self:TLResolvePeek()
				local eventType = resolveHeroicStage3Ambiguous(timer, lastResolvedType, lastResolvedTimer)
				if eventType == "grasp" then
					timerGraspofEmptynessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grasp", "graspofEmptynessCount"))
					self:TLResolvePush("grasp", timer)
				elseif eventType == "voidstalkerSting" then
					timerVoidstalkerStingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
					self:TLResolvePush("voidstalkerSting", timer)
				end
			elseif timer == 14 or timer == 15 then--Voidstalker Sting
				timerVoidstalkerStingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
				self:TLResolvePush("voidstalkerSting", timer)
			elseif timer == 18 then--Ambiguous: Voidstalker Sting OR Grasp of Emptiness
				local lastResolvedType, lastResolvedTimer = self:TLResolvePeek()
				local eventType = resolveHeroicStage3Ambiguous(timer, lastResolvedType, lastResolvedTimer)
				if eventType == "grasp" then
					timerGraspofEmptynessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grasp", "graspofEmptynessCount"))
					self:TLResolvePush("grasp", timer)
				elseif eventType == "voidstalkerSting" then
					timerVoidstalkerStingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
					self:TLResolvePush("voidstalkerSting", timer)
				end
			elseif timer == 7 or timer == 17 or timer == 19 or timer == 20 or timer == 32 then--Grasp of Emptiness
				timerGraspofEmptynessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grasp", "graspofEmptynessCount"))
				self:TLResolvePush("grasp", timer)
			elseif timer == 10 then--Call of the Void (seen in late heroic logs)
				timerCalloftheVoidCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "calloftheVoid", "calloftheVoidCount"))
				self:TLResolvePush("calloftheVoid", timer)
			elseif timer == 11 then--Ambiguous: Null Corona OR Grasp of Emptiness
				local lastResolvedType, lastResolvedTimer = self:TLResolvePeek()
				local eventType = resolveHeroicStage3Ambiguous(timer, lastResolvedType, lastResolvedTimer)
				if eventType == "grasp" then
					timerGraspofEmptynessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grasp", "graspofEmptynessCount"))
					self:TLResolvePush("grasp", timer)
				elseif eventType == "nullCorona" then
					timerNullCoronaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullCorona", "coronaCount"))
					self:TLResolvePush("nullCorona", timer)
				end
			elseif timer == 22 or timer == 24 then--Cosmic Barrier
				timerCosmicBarrierCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "cosmicBarrier", "cosmicBarrierCount"))
				self:TLResolvePush("cosmicBarrier", timer)
			end
		end
	end

	---@param self DBMMod
	---@param timer number
	---@param timerExact number
	---@param eventID number
	local function timersMythic(self, timer, timerExact, eventID)
		if timer == 0 then return end--Absolute errata introduced into timeline by patch 12.0.5
		local stage = self:GetStage()
		if stage == 1 then
			--Stage 1 Mythic (Week 5 validated from CrownWipe1/2)
			--Opener 4s casts (Dark Hand, Grasp, Interrupting Tremor, Ravenous Abyss) are pre-scheduled.
			if timer == 4 then
				return
			elseif timer == 84 or timer == 103 or timer == 104 then
				--Long-duration Grasp of Emptiness passive, skip (84 = week 6 errata re-broadcast with remaining time)
				return
			elseif timer == 5 or timer == 7 or timer == 11 or timer == 30 then
				--Week 6 patch bug: re-broadcasts of already-active bars at T=20.04 with remaining durations (IT=5, GoE=7, DH=11, VE=30)
				return
			elseif timer == 2 then
				--Intermission 1 starts with Silverstrike Barrage at ~1.5s (rounded 2).
				--NC(1) also fires as timer 2 (exact 1.666) at t=0 but prior t=0 events
				--have already updated lastTLEvent so the gap check correctly fails.
				if (timerExact and timerExact < 1.75) and (GetTime() - lastTLEvent > 10) then
					self:SetStage(1.5)
					timerSilverstrikeBarrageCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "silverstrikeBarrage", "silverstrikeBarrageCount"))
				else
					timerNullCoronaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullCorona", "coronaCount"))
					self:TLResolvePush("nullCorona", timer)
				end
			elseif timer == 1 then
				--Null Corona timer resend for an existing timer that's about to expire naturally. Ignore
				return
			elseif timer == 10 then
				--Void Expulsion (exact 10.0 opener and 9.583 recurring)
				timerVoidExpulsionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidExpulsion", "voidExpulsionCount"))
				self:TLResolvePush("voidExpulsion", timer)
			elseif timer == 33 then
				--Void Expulsion (exact 32.5)
				timerVoidExpulsionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidExpulsion", "voidExpulsionCount"))
				self:TLResolvePush("voidExpulsion", timer)
			elseif timer == 37 then
				--Null Corona
				timerNullCoronaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullCorona", "coronaCount"))
				self:TLResolvePush("nullCorona", timer)
			elseif timer == 40 then
				--Ambiguous: Void Expulsion (odd) OR Null Corona (even) - occurrence count
				mythicStage1FortyCount = mythicStage1FortyCount + 1
				if mythicStage1FortyCount % 2 == 1 then
					timerVoidExpulsionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidExpulsion", "voidExpulsionCount"))
					self:TLResolvePush("voidExpulsion", timer)
				else
					timerNullCoronaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullCorona", "coronaCount"))
					self:TLResolvePush("nullCorona", timer)
				end
			elseif timer == 23 then
				--Ambiguous: Grasp of Emptiness (G2/G6, each following Null Corona) OR Null Corona (NC4)
				local lastResolvedType = self:TLResolvePeek()
				if lastResolvedType == "nullCorona" then
					timerGraspofEmptynessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grasp", "graspofEmptynessCount"))
					self:TLResolvePush("grasp", timer)
				else
					timerNullCoronaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullCorona", "coronaCount"))
					self:TLResolvePush("nullCorona", timer)
				end
			elseif timer == 20 then
				--Ravenous Abyss (exact 19.5), Silverstrike Arrow opener (exact 20.0), or Interrupting Tremor (exact 20.0)
				if timerExact and timerExact < 19.55 then
					timerRavenousAbyssCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "ravenousAbyss", "ravenousAbyssCount"))
					self:TLResolvePush("ravenousAbyss", timer)
				elseif self:IsRoundedTimer(timerExact, 19.583, 0.2) then
					--Week 6 stage-end SA can arrive as exact ~19.58 (rounded 20)
					timerSilverstrikeArrowCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "silverstrikeArrow", "silverstrikeArrowCount"))
					self:TLResolvePush("silverstrikeArrow", timer)
				elseif not mythicStage1SAOpenerSeen then
					--First exact-20 is Silverstrike Arrow opener (SA1 at t=0)
					mythicStage1SAOpenerSeen = true
					timerSilverstrikeArrowCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "silverstrikeArrow", "silverstrikeArrowCount"))
					self:TLResolvePush("silverstrikeArrow", timer)
				else
					--Subsequent exact-20 is Interrupting Tremor
					timerInterruptingTremorCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "interruptingTremor", "interruptingTremorCount"))
					self:TLResolvePush("interruptingTremor", timer)
				end
			elseif timer == 17 or timer == 18 or timer == 19 then
				--Silverstrike Arrow durations (17.5/19.166). Week 6 errata can rebroadcast NC as timer=19
				--immediately after the true SA event. Anchor off exact SA(17.5±0.3), not rounded timer value.
				if self:IsRoundedTimer(timerExact, 17.5, 0.3) then
					mythicStage1SAErrataAnchorTime = GetTime()
					timerSilverstrikeArrowCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "silverstrikeArrow", "silverstrikeArrowCount"))
					self:TLResolvePush("silverstrikeArrow", timer)
				elseif timer == 19 and mythicStage1SAErrataAnchorTime > 0 and GetTime() - mythicStage1SAErrataAnchorTime < 2 then
					return
				else
					timerSilverstrikeArrowCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "silverstrikeArrow", "silverstrikeArrowCount"))
					self:TLResolvePush("silverstrikeArrow", timer)
				end
			elseif timer == 26 then
				--Ambiguous: Dark Hand (recurring) OR Grasp of Emptiness (G4, always preceded by Ravenous Abyss)
				local lastResolvedType = self:TLResolvePeek()
				if lastResolvedType == "ravenousAbyss" then
					timerGraspofEmptynessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grasp", "graspofEmptynessCount"))
					self:TLResolvePush("grasp", timer)
				else
					timerDarkHandCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "darkHand", "darkHandCount"))
					self:TLResolvePush("darkHand", timer)
				end
			elseif timer == 27 then
				--Grasp of Emptiness (G3, exact 26.666)
				timerGraspofEmptynessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grasp", "graspofEmptynessCount"))
				self:TLResolvePush("grasp", timer)
			elseif timer == 25 then
				--Recovery: Stage Two marker appearing while still in stage 1
				if self:GetStage(1) then
					self:SetStage(1.5)
				end
				timerStage2CD:TLStart(timerExact, eventID)
				self:TLCountStart(eventID, "stage2Start")
			else
				badStateDetected = true
				self:ResumeBlizzardAPI()
				self:UnregisterShortTermEvents()
				setFallback(self)
				DBM:Debug("|cffff0000Failed to match Mythic stage 1 timeline events, falling back to Blizzard API|r", nil, nil, nil, true)
			end
		elseif stage == 1.5 then
			--Intermission 1
			if timer == 2 or timer == 6 then--Silverstrike Barrage sequence
				timerSilverstrikeBarrageCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "silverstrikeBarrage", "silverstrikeBarrageCount"))
			elseif timer == 25 then--Stage 2 marker; phase actually starts on STATE_CHANGED.
				timerStage2CD:TLStart(timerExact, eventID)
				self:TLCountStart(eventID, "stage2Start")
			end
		elseif stage == 2 then
			--Stage 2 Mythic (Week 5 validated from CrownWipe1)
			--Stage 2.5 has no routeable signals on mythic; Stage 3 is detected by a long
			--silence followed by a new batch of timeline events.
			if GetTime() - lastTLEvent > 14 then
				self:SetStage(3)
				return timersMythic(self, timer, timerExact, eventID)
			end
			if timer == 2 then
				--Rift Simulacrum opener (first 2s) OR Voidstalker Sting recurring (2s)
				if not mythicStage2RiftSimulacrumSeen then
					mythicStage2RiftSimulacrumSeen = true
					timerRiftSimulacrumCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "riftSimulacrum", "riftSimulacrumCount"))
				else
					timerVoidstalkerStingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
				end
			elseif timer == 4 then
				--Rift Slash (short, after cancel) fires first; Call of the Void (short) fires second
				mythicStage2FourCount = mythicStage2FourCount + 1
				if mythicStage2FourCount % 2 == 1 then
					timerRiftSlashCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "riftSlash", "riftSlashCount"))
				else
					timerCalloftheVoidCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "calloftheVoid", "calloftheVoidCount"))
				end
			elseif timer == 6 then
				--Rift Slash opener fires first; Call of the Void opener fires second
				mythicStage2SixCount = mythicStage2SixCount + 1
				if mythicStage2SixCount == 1 then
					timerRiftSlashCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "riftSlash", "riftSlashCount"))
				else
					timerCalloftheVoidCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "calloftheVoid", "calloftheVoidCount"))
				end
			elseif timer == 10 then--Voidstalker Sting recurring
				timerVoidstalkerStingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
			elseif timer == 11 then--Grasp of Emptiness short recurring
				timerGraspofEmptynessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grasp", "graspofEmptynessCount"))
			elseif timer == 12 then
				--Voidstalker Sting opener (first 12s in Stage 2) then Rift Slash recurring
				if not mythicStage2VoidstalkerOpenerDone then
					mythicStage2VoidstalkerOpenerDone = true
					timerVoidstalkerStingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
				else
					timerRiftSlashCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "riftSlash", "riftSlashCount"))
				end
			elseif timer == 13 then--Grasp of Emptiness opener
				timerGraspofEmptynessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grasp", "graspofEmptynessCount"))
			elseif timer == 16 then--Rift Slash longer interval (will be cancelled by core)
				timerRiftSlashCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "riftSlash", "riftSlashCount"))
			elseif timer == 18 then--Void Expulsion recurring
				timerVoidExpulsionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidExpulsion", "voidExpulsionCount"))
			elseif timer == 20 then--Void Expulsion opener
				timerVoidExpulsionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidExpulsion", "voidExpulsionCount"))
			elseif timer == 23 then--Voidstalker Sting recurring
				timerVoidstalkerStingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
			elseif timer == 25 then
				--Ambiguous: Grasp of Emptiness OR Void Expulsion OR Ranger Captain's Mark
				--Mod-4 cycle from CrownWipe1: 1=GoE, 2=VE, 3=RCM, 0=RCM
				mythicStage2TwentyFiveCount = mythicStage2TwentyFiveCount + 1
				local mod4 = mythicStage2TwentyFiveCount % 4
				if mod4 == 1 then
					timerGraspofEmptynessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grasp", "graspofEmptynessCount"))
				elseif mod4 == 2 then
					timerVoidExpulsionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidExpulsion", "voidExpulsionCount"))
				else--mod4 == 3 or 0
					timerRangerCaptainsMarkCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rangerMark", "rangerMarkCount"))
				end
			elseif timer == 27 then--Ranger Captain's Mark opener
				timerRangerCaptainsMarkCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "rangerMark", "rangerMarkCount"))
			elseif timer == 50 then--Call of the Void long (will be cancelled by core)
				timerCalloftheVoidCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "calloftheVoid", "calloftheVoidCount"))
			end
		elseif stage == 3 then
			--Stage 3 Mythic (expanded with Week 6 Crown6-9)
			--Aspect: 6/7/19/41
			--Grasp: 9/10/16/35
			--Rift Simulacrum: 11/12
			--Voidstalker Sting: 12/14/15/16 (+17 ambiguous)
			--Cosmic Portal: 15 opener, recurring 14 after Devouring batch
			--Dark Hand: 20 and 14 (late loop, alternates with Voidstalker 14)
			--Null Corona: 29/30
			--Void Expulsion: 36/37
			--Devouring Cosmos: 59/60
			if timer == 6 or timer == 7 then--Aspect of the End
				timerAspectoftheEndCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "aspectoftheEnd", "aspectoftheEndCount"))
				self:TLResolvePush("aspectoftheEnd", timer)
			elseif timer == 8 then--Ravenous Abyss (exact ~8.0)
				timerRavenousAbyssCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "ravenousAbyss", "ravenousAbyssCount"))
				self:TLResolvePush("ravenousAbyss", timer)
			elseif timer == 9 or timer == 10 or timer == 35 then--Grasp of Emptiness
				timerGraspofEmptynessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grasp", "graspofEmptynessCount"))
				self:TLResolvePush("grasp", timer)
			elseif timer == 11 then--Rift Simulacrum recurring
				timerRiftSimulacrumCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "riftSimulacrum", "riftSimulacrumCount"))
				self:TLResolvePush("riftSimulacrum", timer)
			elseif timer == 12 then--Rift Simulacrum opener (first) OR Voidstalker Sting (subsequent)
				if not mythicStage3RiftSimulacrumSeen then
					mythicStage3RiftSimulacrumSeen = true
					timerRiftSimulacrumCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "riftSimulacrum", "riftSimulacrumCount"))
					self:TLResolvePush("riftSimulacrum", timer)
				else
					timerVoidstalkerStingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
					self:TLResolvePush("voidstalkerSting", timer)
				end
			elseif timer == 14 then--Ambiguous: Cosmic Portal recurring OR Dark Hand OR Voidstalker Sting
				local lastResolvedType, lastResolvedTimer = self:TLResolvePeek()
				if lastResolvedType == "devouringCosmos" and (lastResolvedTimer == 59 or lastResolvedTimer == 60) then
					timerCosmicPortalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "cosmicPortal", "cosmicPortalCount"))
					self:TLResolvePush("cosmicPortal", timer)
				elseif not mythicStage3FourteenDarkHandMode then
					if lastResolvedType == "voidstalkerSting" and lastResolvedTimer == 12 and self.vb.devouringCosmosCount >= 4 then
						mythicStage3FourteenDarkHandMode = true
						mythicStage3FourteenCount = 1
						timerDarkHandCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "darkHand", "darkHandCount"))
						self:TLResolvePush("darkHand", timer)
					else
						timerVoidstalkerStingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
						self:TLResolvePush("voidstalkerSting", timer)
					end
				else
					mythicStage3FourteenCount = mythicStage3FourteenCount + 1
					if mythicStage3FourteenCount % 2 == 1 then
						timerDarkHandCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "darkHand", "darkHandCount"))
						self:TLResolvePush("darkHand", timer)
					else
						timerVoidstalkerStingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
						self:TLResolvePush("voidstalkerSting", timer)
					end
				end
			elseif timer == 15 then--Ambiguous: Cosmic Portal opener OR Voidstalker Sting recurring
				if self.vb.cosmicPortalCount == 1 then
					timerCosmicPortalCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "cosmicPortal", "cosmicPortalCount"))
					self:TLResolvePush("cosmicPortal", timer)
				else
					timerVoidstalkerStingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
					self:TLResolvePush("voidstalkerSting", timer)
				end
			elseif timer == 16 then--Ambiguous: Voidstalker Sting opener OR Grasp of Emptiness recurring
				local lastResolvedType, lastResolvedTimer = self:TLResolvePeek()
				if (lastResolvedType == "aspectoftheEnd" and (lastResolvedTimer == 19 or lastResolvedTimer == 6))
					or (lastResolvedType == "darkHand" and lastResolvedTimer == 14) then
					timerGraspofEmptynessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grasp", "graspofEmptynessCount"))
					self:TLResolvePush("grasp", timer)
				else
					timerVoidstalkerStingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
					self:TLResolvePush("voidstalkerSting", timer)
				end
			elseif timer == 17 then--Ambiguous: Ravenous Abyss (exact ~16.5) OR Interrupting Tremor (late Stage 3 window) OR Voidstalker Sting (exact ~17+)
				if timerExact and timerExact < 16.75 then
					timerRavenousAbyssCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "ravenousAbyss", "ravenousAbyssCount"))
					self:TLResolvePush("ravenousAbyss", timer)
				elseif mythicStage3TremorWindow > 0 then
					mythicStage3TremorWindow = mythicStage3TremorWindow - 1
					timerInterruptingTremorCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "interruptingTremor", "interruptingTremorCount"))
					self:TLResolvePush("interruptingTremor", timer)
				else
					timerVoidstalkerStingCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidstalkerSting", "voidstalkerStingCount"))
					self:TLResolvePush("voidstalkerSting", timer)
				end
			elseif timer == 8 then--Ambiguous: Ravenous Abyss OR Interrupting Tremor (late Stage 3)
				local lastResolvedType, lastResolvedTimer = self:TLResolvePeek()
				if self.vb.devouringCosmosCount >= 3 and lastResolvedType == "voidstalkerSting" and lastResolvedTimer == 17 then
					mythicStage3TremorWindow = 2
					timerInterruptingTremorCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "interruptingTremor", "interruptingTremorCount"))
					self:TLResolvePush("interruptingTremor", timer)
				else
					timerRavenousAbyssCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "ravenousAbyss", "ravenousAbyssCount"))
					self:TLResolvePush("ravenousAbyss", timer)
				end
			elseif timer == 19 or timer == 41 then--Aspect of the End (recurring)
				timerAspectoftheEndCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "aspectoftheEnd", "aspectoftheEndCount"))
				self:TLResolvePush("aspectoftheEnd", timer)
			elseif timer == 20 then--Dark Hand
				timerDarkHandCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "darkHand", "darkHandCount"))
				self:TLResolvePush("darkHand", timer)
			elseif timer == 29 or timer == 30 then--Null Corona
				timerNullCoronaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullCorona", "coronaCount"))
				self:TLResolvePush("nullCorona", timer)
			elseif timer == 36 or timer == 37 then--Void Expulsion
				timerVoidExpulsionCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "voidExpulsion", "voidExpulsionCount"))
				self:TLResolvePush("voidExpulsion", timer)
			elseif timer == 59 or timer == 60 then--Devouring Cosmos
				mythicStage3TremorWindow = 0--Reset per-batch window so VS(timer=17) after this DC can't be mis-routed as IT
				timerDevouringCosmosCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "devouringCosmos", "devouringCosmosCount"))
				self:TLResolvePush("devouringCosmos", timer)
			end
		end
	end

	--Note, bar state changing and canceling is handled by core
	function mod:ENCOUNTER_TIMELINE_EVENT_ADDED(eventInfo)
		if eventInfo.source ~= 0 then return end
		local eventID = eventInfo.id
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
		lastTLEvent = GetTime()
	end

	function mod:ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED(eventID)
		lastTLEvent = GetTime()
		local eventState = C_EncounterTimeline.GetEventState(eventID)
		if not eventID or not eventState then return end
		if eventState == 2 then
			local eventType, eventCount = self:TLCountFinish(eventID)
			if not eventType then return end
			if eventType == "stage2Start" then
				stage2TwentyCount = 0
				heroicStage2InitialRiftSeen = false
				mythicStage2RiftSimulacrumSeen = false
				mythicStage2VoidstalkerOpenerDone = false
				mythicStage2SixCount = 0
				mythicStage2FourCount = 0
				mythicStage2TwentyFiveCount = 0
				self:SetStage(2)
				return
			elseif eventType == "stage3Start" then
				stage2p5Seen = true
				stage3Recovered = true
				self:SetStage(3)
				return
			end
			if not eventCount then return end
			if eventType == "voidExpulsion" then
				specWarnVoidExpulsion:Show(eventCount)
				specWarnVoidExpulsion:Play("aesoon")
			elseif eventType == "nullCorona" then
				warnNullCorona:Show(eventCount)
			elseif eventType == "silverstrikeArrow" then
				warnSilverStrikeArrow:Show(eventCount)
			elseif eventType == "darkHand" then
				moriumIsTanked(self)
			elseif eventType == "ravenousAbyss" then
				specWarnRavenousAbyss:Show(eventCount)
				specWarnRavenousAbyss:Play("watchstep")
			elseif eventType == "interruptingTremor" then
				specWarnInterruptingTremor:Show(eventCount)
				if self:IsSpellCaster() then
					specWarnInterruptingTremor:Play("stopcast")
				else
					specWarnInterruptingTremor:Play("aesoon")
				end
			elseif eventType == "voidstalkerSting" then
				warnVoidStalkerSting:Show(eventCount)
			elseif eventType == "calloftheVoid" then
				specWarnCalloftheVoid:Show(eventCount)
				specWarnCalloftheVoid:Play("mobsoon")
			elseif eventType == "riftSlash" then
				if self:IsTanking("player", "boss2", nil, true) then
					specWarnRiftSlash:Show()
					specWarnRiftSlash:Play("defensive")
				end
			elseif eventType == "cosmicBarrier" then
				specWarnCosmicBarrier:Show(eventCount)
				specWarnCosmicBarrier:Play("attackshield")
			elseif eventType == "devouringCosmos" then
				specWarnDevouringCosmos:Show(eventCount)
				specWarnDevouringCosmos:Play("changeplatform")
			elseif eventType == "riftSimulacrum" then
				warnRiftSimulacrum:Show(eventCount)
			end
		elseif eventState == 3 then
			local eventType = self:TLCountCancel(eventID)
			if not eventType then return end
			if eventType == "stage2Start" then
				stage2TwentyCount = 0
				heroicStage2InitialRiftSeen = false
				mythicStage2RiftSimulacrumSeen = false
				mythicStage2VoidstalkerOpenerDone = false
				mythicStage2SixCount = 0
				mythicStage2FourCount = 0
				mythicStage2TwentyFiveCount = 0
				self:SetStage(2)
				return
			elseif eventType == "stage3Start" then
				stage2p5Seen = true
				stage3Recovered = true
				self:SetStage(3)
				return
			end
		end
	end
end
