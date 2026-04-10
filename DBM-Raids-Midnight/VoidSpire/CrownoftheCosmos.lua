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
--local timerRiftSimulacrumCD			= mod:NewCDCountTimer(20.5, 1261016, nil, nil, nil, 6)--P2 Starting (stage 2 bar does this, this timer never fires)
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
local badStateDetected = false
local stage2p5Seen, stage3Recovered = false, false
local stage2TwentyCount = 0
local heroicStage2InitialRiftSeen = false
local stage1FortyEightCount = 0
local lastTLEvent = 0

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
local function setFallback(self)
	--Blizz API fallbacks
	timerNullCoronaCD:SetTimeline(4)
	specWarnVoidExpulsion:SetAlert(5, "aesoon", 2, 2, 0)
	timerVoidExpulsionCD:SetTimeline(5)
	timerSilverstrikeArrowCD:SetTimeline(6)
	timerSilverstrikeBarrageCD:SetTimeline(7)
--	specWarnSingularityEruption:SetAlert(8, "watchstep", 2, 2)
--	timerSingularityEruptionCD:SetTimeline(8)
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
	if self:IsSpellCaster() then
		specWarnInterruptingTremor:SetAlert(66, "stopcast", 2, 2, 0)
	else
		specWarnInterruptingTremor:SetAlert(66, "aesoon", 2, 2, 0)
	end
	timerInterruptingTremorCD:SetTimeline(66)
	warnRiftSimulacrum:SetAlert(135, "ptwo", 2, 2, 0)--Verify
--	timerRiftSimulacrumCD:SetTimeline(135)
	specWarnCosmicPortal:SetAlert(136, "bigmobsoon", 2, 2)
	timerCosmicPortalCD:SetTimeline(136)
	if self:IsTank() then
		specWarnRiftSlash:SetAlert(137, "defensive", 2, 2)
	end
	timerRiftSlashCD:SetTimeline(137)
	timerStage2CD:SetTimeline(351)
end

---@param self DBMMod
local function moriumIsTanked(self)
	if self:IsTanking("player", "boss1", nil, true) then
		specWarnDarkHand:Show()
		specWarnDarkHand:Play("defensive")
	end
end

function mod:OnLimitedCombatStart()
	self:TLCountReset()
	self:TLResolveReset()
	stage2p5Seen, stage3Recovered = false, false
	stage2TwentyCount = 0
	heroicStage2InitialRiftSeen = false
	stage1FortyEightCount = 0
	lastTLEvent = 0
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
	self:SetStage(1)

	if DBM.Options.HardcodedTimer and (self:IsEasy() or self:IsHeroic()) and not badStateDetected then
		self:IgnoreBlizzardAPI()
		self:RegisterShortTermEvents(
			"ENCOUNTER_TIMELINE_EVENT_ADDED",
			"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED"
		)
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
	stage1FortyEightCount = 0
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
				timerNullCoronaCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "nullCorona", "coronaCount"))
				self:TLResolvePush("nullCorona", timer)
			elseif timer == 28 or timer == 29 or timer == 31 or timer == 32 then--Grasp of Emptiness
				timerGraspofEmptynessCD:TLStart(timerExact, eventID, self:TLCountStart(eventID, "grasp", "graspofEmptynessCount"))
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
			end
		elseif eventState == 3 then
			local eventType = self:TLCountCancel(eventID)
			if not eventType then return end
			if eventType == "stage2Start" then
				stage2TwentyCount = 0
				heroicStage2InitialRiftSeen = false
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
