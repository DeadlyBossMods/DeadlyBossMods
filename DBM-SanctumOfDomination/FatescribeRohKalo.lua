local mod	= DBM:NewMod(2447, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175730)
mod:SetEncounterID(2431)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20210902000000)
mod:SetMinSyncRevision(20210706000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 351680 350554 350421 353426 350169 354367 354265 357144 353603",
	"SPELL_CAST_SUCCESS 350355",
	"SPELL_AURA_APPLIED 354365 351680 353432 350568 356065 353195 354964 357739",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 354365 351680 350568 356065 353195 357739",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Extended todo, stuff that probably won't get done do to diminished time investment these days. Hard to stay motivated with so much support decline
--TODO, https://ptr.wowhead.com/spell=354966/unstable-accretion trackingn for mythic phase 2
--TODO, further timer data for longer pulls?
--TODO, add cast bars for the double beam casts that don't actually have double casts events
--TODO, verify add auto marking off IEEU
--TODO, improve P3 timers for invoke/bombs to account for when it will be delayed by runes? (likely will never actually get done, time investment these days is as diminished as support)
--[[
(ability.id = 350421 or ability.id = 351680 or ability.id = 350554 or ability.id = 354367 or ability.id = 354265 or ability.id = 357144) and type = "begincast"
 or (ability.id = 353195 or ability.id = 357739) and (type = "applybuff" or type = "removebuff")
 or (ability.id = 353195) and type = "applydebuff"
 or ability.id = 354964 and type = "applydebuff"
 --]]
--Stage One: Scrying Fate
mod:AddOptionLine(DBM:EJ_GetSectionInfo(22926), "announce")
local warnProbe									= mod:NewCastAnnounce(353603, 2)
local warnGrimPortent							= mod:NewTargetNoFilterAnnounce(354365, 4)--Mythic
local warnTwistFate								= mod:NewCountAnnounce(353931, 2, nil, "RemoveMagic")
local warnCallofEternity						= mod:NewTargetAnnounce(350554, 4, nil, nil, 37859)

local specWarnGrimPortent						= mod:NewSpecialWarningYouPos(354365, nil, nil, nil, 1, 2, 4)--Mythic
local yellGrimPortent							= mod:NewYell(354365)--Mythic
local yellGrimPortentFades						= mod:NewShortFadesYell(354365)--Mythic
local specWarnInvokeDestiny						= mod:NewSpecialWarningMoveAway(351680, nil, nil, nil, 1, 2)
local yellInvokeDestiny							= mod:NewYell(351680)
local yellInvokeDestinyFades					= mod:NewShortFadesYell(351680)
local specWarnInvokeDestinySwap					= mod:NewSpecialWarningTaunt(351680, nil, nil, nil, 1, 2)
local specWarnBurdenofDestinyYou				= mod:NewSpecialWarningRun(353432, nil, 244657, nil, 4, 2)--"Fixate"
local specWarnBurdenofDestiny					= mod:NewSpecialWarningSwitch(353432, "Dps", nil, nil, 1, 2)
local specWarnFatedConjunction					= mod:NewSpecialWarningDodge(350355, nil, 207544, nil, 2, 2)
local specWarnCallofEternity					= mod:NewSpecialWarningMoveAway(350554, nil, 37859, nil, 1, 2)
local yellCallofEternity						= mod:NewShortPosYell(350554, 37859)--"Bomb"
local yellCallofEternityFades					= mod:NewIconFadesYell(350554, 37859)

local timerGrimPortentCD						= mod:NewCDCountTimer(28.8, 354365, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)--28-46?
local timerGrimPortent							= mod:NewBuffFadesTimer(9, 354365, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerInvokeDestinyCD						= mod:NewCDCountTimer(37.8, 351680, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--37.8-41
local timerInvokeDestiny						= mod:NewAddsCustomTimer(8, 351680, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerTwistFateCD							= mod:NewCDCountTimer(48.7, 353931, nil, nil, 2, 5, nil, DBM_COMMON_L.MAGIC_ICON..DBM_COMMON_L.HEALER_ICON)
local timerFatedConjunctionCD					= mod:NewCDCountTimer(59.7, 350355, 207544, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON, nil, 1, 3)--"Beams"
local timerFatedConjunction						= mod:NewCastTimer(6.7, 350355, 207544, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerCallofEternityCD						= mod:NewCDCountTimer(37.9, 350554, 167180, nil, nil, 3)--"Bombs"

mod:AddSetIconOption("SetIconOnCallofEternity", 350554, true, false, {1, 2, 3, 4, 5})
mod:AddSetIconOption("SetIconOnGrimPortent", 354365, false, false, {1, 2, 3, 4, 5, 6, 7, 8})
mod:AddNamePlateOption("NPAuraOnBurdenofDestiny", 353432, true)
--Stage Two: Defying Destiny
mod:AddOptionLine(DBM:EJ_GetSectionInfo(22927), "announce")
local warnRunicAffinity							= mod:NewTargetNoFilterAnnounce(354964, 4)--Mythic

local specWarnRealignFate						= mod:NewSpecialWarningCount(351969, nil, nil, nil, 2, 2)
local specWarnRunicAffinity						= mod:NewSpecialWarningYou(354964, nil, nil, nil, 2, 2, 4)

local timerDespairCD							= mod:NewCDCountTimer("d17", 357144, nil, nil, nil, 4)--Tricky to type, it's interrupt bar in 3/4 difficulties, aoe run out in mythic
local timerDarkestDestiny						= mod:NewCastTimer(40, 353122, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
----Monstrosity
local warnDespair								= mod:NewCountAnnounce(357144, 3)

local specWarnDespair							= mod:NewSpecialWarningInterruptCount(357144, "HasInterrupt", nil, nil, 1, 2)--Non mythic only
local specWarnDespairRun						= mod:NewSpecialWarningRun(357144, nil, nil, nil, 4, 2, 4)

mod:AddSetIconOption("SetIconOnMonstrosity", "ej23764", true, true, {7, 8})
--Stage Three: Fated Terminus
mod:AddOptionLine(DBM:EJ_GetSectionInfo(23486), "announce")
local warnExtemporaneousFate					= mod:NewSoonAnnounce(353195, 3)

local specWarnExtemporaneousFate				= mod:NewSpecialWarningCount(353195, nil, nil, nil, 2, 2)

local timerRunicAffinityCD						= mod:NewCDCountTimer(39, 354964, nil, nil, nil, 3, nil, nil, true)--Used in state 3 only, in stage 1 it happens at same time as rings
local timerExtemporaneousFateCD					= mod:NewCDCountTimer(39, 353195, nil, nil, nil, 6, nil, nil, true)

--local berserkTimer							= mod:NewBerserkTimer(600)

mod:GroupSpells(351680, 353432)--Burden and invoke bundled (invoke is add fixate at end of burden)
mod:GroupSpells(351969, 353122)--Realign fate and darkest destiny which is channel for how long you have for fate

mod.vb.EternityIcon = 1
mod.vb.DebuffIcon = 1
mod.vb.realignCount = 0
mod.vb.twistCount = 0
mod.vb.eternityCount = 0
mod.vb.destinyCount = 0
mod.vb.conjunctionCount = 0
mod.vb.portentCount = 0
mod.vb.affinityCount = 0
mod.vb.extemporaneousCount = 0
mod.vb.addIcon = 8
local grimDebuffs = 0--Local variable for timer canceling only
local castsPerGUID = {}
local difficultyName = "normal"
local allTimers = {
	["mythic"] = {
		[1] = {
			--Twist Fate
			[354265] = {5.8, 31.5, 20, 37.7, 27.9, 18.2},--first is 11 the second time around
			--Call of Eternity
			[350554] = {17.8, 57.1, 37.6},--first is 23 the second time around
			--Invoke Destiny
			[351680] = {20, 45, 44.9, 34.4},--first is 25 the second time around
			--Fated Conjunction
			[350421] = {30, 47.4, 5, 7},--first is 35 the second time around
			--Grim Portent
			[354367] = {43, 75},--first is 48 the second time around
		},
		[3] = {
			--Twist Fate
			[354265] = {40, 16, 29, 46.5},
			--Call of Eternity
			[350554] = {13, 54.7, 29},
			--Invoke Destiny
			[351680] = {26, 44, 44.1},
			--Fated Conjunction
			[350421] = {18, 75, 7},
			--Extemporaneous Fate
			[353195] = {54, 89.4},--or 56?
		}
	},
	["normal"] = {--Same as heroic
		[1] = {--Timers after Realign Fate
			--Twist Fate
			[354265] = {10, 49.2, 75.2, 35.2, 10.9},--Last one is 10.9-38.9 for some reason
			--Call of Eternity
			[350554] = {29.4, 38.8, 34.1, 44.9, 41.3},
			--Invoke Destiny
			[351680] = {40.4, 39.3, 38.7, 40},
			--Fated Conjunction
			[350421] = {18.5, 59.7, 26.7, 23.4, 48.5},
		},
		[3] = {
			--Twist Fate
			[354265] = {50.5, 48.6, 38.8},
			--Call of Eternity
			[350554] = {11.5, 38.6, 38.8, 57.1},--second and third one can be flipped based on phasing timing, so for sequence sake lowest seen is used for both :\
					  --11.53, 75.89, 40.14
					  --11.5, 38.6, 73.1, 57.1
			--Invoke Destiny
			[351680] = {25.6, 43.7, 90},
			--Fated Conjunction
			[350421] = {9.4, 50.4, 51.1, 40.1, 26.7},
			--Extemporaneous Fate
			[353195] = {34.4, 42.1, 43.7},--Huge variations, 36-50
		}
	},
}

--Attempts to fix destiny timer when it's 73.1 instead of 38.6
--This schedule function will only run if it doesn't come on time, and restart the timer for remainder of 73.1
--local function fixEternity(self)
--	timerCallofEternityCD:Update(50, 73.1, self.vb.eternityCount+1)
--end

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self.vb.DebuffIcon = 1
	self:SetStage(1)
	self.vb.realignCount = 0
	self.vb.twistCount = 0
	self.vb.eternityCount = 0
	self.vb.destinyCount = 0
	self.vb.conjunctionCount = 0
	self.vb.portentCount = 0
	self.vb.extemporaneousCount = 0
--	berserkTimer:Start(-delay)
	if self:IsMythic() then
		difficultyName = "mythic"
		timerTwistFateCD:Start(5.8-delay, 1)
		timerCallofEternityCD:Start(17.8-delay, 1)
		timerInvokeDestinyCD:Start(20-delay, 1)
		timerFatedConjunctionCD:Start(30-delay, 1)
		timerGrimPortentCD:Start(43-delay, 1)
	else
		difficultyName = "normal"
		--Normal and Heroic timers are same here
		timerTwistFateCD:Start(4.6-delay, 1)
		timerFatedConjunctionCD:Start(13.1-delay, 1)--13.1-14.4
		timerCallofEternityCD:Start(24-delay, 1)
		timerInvokeDestinyCD:Start(35-delay, 1)
	end
	if self.Options.NPAuraOnBurdenofDestiny then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
--	DBM:AddMsg("Abilities on this fight can be volatile and sometimes skip casts/change order. DBM timers attempt to match the most common scenario of events but sometimes fight will do it's own thing")
end

function mod:OnCombatEnd()
	table.wipe(castsPerGUID)
	self:UnregisterShortTermEvents()
	if self.Options.NPAuraOnBurdenofDestiny then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		difficultyName = "mythic"
	else
		difficultyName = "normal"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 351680 then
		self.vb.destinyCount = self.vb.destinyCount + 1
		local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.destinyCount+1]
		if timer then
			timerInvokeDestinyCD:Start(timer, self.vb.destinyCount+1)
		end
	elseif spellId == 350554 then--Two sub cast IDs, but one primary?
--		self:Unschedule(fixEternity)
		self.vb.EternityIcon = 1
		self.vb.eternityCount = self.vb.eternityCount + 1
		local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.eternityCount+1]
		if timer then
			timerCallofEternityCD:Start(timer, self.vb.eternityCount+1)
			--if (self.vb.eternityCount+1) == 2 and self.vb.phase == 3 then
			--	self:Schedule(50, fixEternity, self)
			--end
		end
	elseif (spellId == 350421 or spellId == 353426 or spellId == 350169) then--350421 confiremd, others unknown
		self.vb.conjunctionCount = self.vb.conjunctionCount + 1
		specWarnFatedConjunction:Show()
		specWarnFatedConjunction:Play("watchstep")
		local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][350421][self.vb.conjunctionCount+1]
		if timer then
			timerFatedConjunctionCD:Start(timer, self.vb.conjunctionCount+1)
		end
		timerFatedConjunction:Start()--6.7
	elseif spellId == 354367 then
		grimDebuffs = 0
		self.vb.DebuffIcon = 1
		self.vb.portentCount = self.vb.portentCount + 1
		local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.portentCount+1]
		if timer then
			timerGrimPortentCD:Start(timer, self.vb.portentCount+1)
		end
	elseif spellId == 354265 then--Twist Fate
		self.vb.twistCount = self.vb.twistCount + 1
		warnTwistFate:Show(self.vb.twistCount)
		local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][spellId][self.vb.twistCount+1]
		if timer then
			timerTwistFateCD:Start(timer, self.vb.twistCount+1)
		end
	elseif spellId == 357144 then
		if not castsPerGUID[args.sourceGUID] then--Shouldn't happen, but failsafe
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		timerDespairCD:Start(17, count, args.sourceGUID)
		if self:IsMythic() then--Not interruptable on mythic
			if self:CheckBossDistance(args.destGUID, true, 21519, 23) or self:IsTank() then--23 yards away (mistletoe) or you're a tank, regular warning
				if self:AntiSpam(3, 1) then
					warnDespair:Show(count)
				end
			else--Special warning
				if self:AntiSpam(3, 2) then
					specWarnDespairRun:Show()
					specWarnDespairRun:Play("justrun")
				end
			end
		else
			timerDespairCD:UpdateInline(DBM_COMMON_L.INTERRUPT_ICON, count, args.sourceGUID)--It's only interruptable in non mythic, add icon there
			if self:CheckInterruptFilter(args.sourceGUID, false, false) then
				specWarnDespair:Show(args.sourceName, count)
				if count < 6 then
					specWarnDespair:Play("kick"..count.."r")
				else
					specWarnDespair:Play("kickcast")
				end
			end
		end
	elseif spellId == 353603 then
		if self:IsTanking("player", "boss1", nil, true) then
			warnProbe:Show()
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 353931 then
		timerTwistFateCD:Start()
	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 354365 then
		if args:IsDestTypePlayer() then
			grimDebuffs = grimDebuffs + 1
			local icon = self.vb.DebuffIcon
			if self.Options.SetIconOnGrimPortent and icon < 9 then
				self:SetIcon(args.destName, icon)
			end
			if args:IsPlayer() then
				specWarnGrimPortent:Show()
				specWarnGrimPortent:Play("targetyou")
				yellGrimPortent:Yell()
				yellGrimPortentFades:Countdown(spellId)
			end
			warnGrimPortent:CombinedShow(0.5, args.destName)
			self.vb.DebuffIcon = self.vb.DebuffIcon + 1
			timerGrimPortent:Start()
		end
	elseif spellId == 351680 then
		if args:IsPlayer() then
			specWarnInvokeDestiny:Show()
			specWarnInvokeDestiny:Play("runout")
			yellInvokeDestiny:Yell()
			yellInvokeDestinyFades:Countdown(spellId)
		else
			specWarnInvokeDestinySwap:Show(args.destName)
			specWarnInvokeDestinySwap:Play("tauntboss")
			specWarnInvokeDestinySwap:ScheduleVoice(1.5, "defensive")
		end
		timerInvokeDestiny:Start(8, self.vb.destinyCount)
	elseif spellId == 353432 then
		if args:IsPlayer() then
			specWarnBurdenofDestinyYou:Show()
			specWarnBurdenofDestinyYou:Play("justrun")
			if self.Options.NPAuraOnBurdenofDestiny then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
		elseif self:IsHard() then--Normal and LFR just blow it up, it doesn't do any damage
			specWarnBurdenofDestiny:Show()
			specWarnBurdenofDestiny:Play("killmob")
		end
	elseif spellId == 350568 or spellId == 356065 then
		local icon = self.vb.EternityIcon
		if self.Options.SetIconOnCallofEternity then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnCallofEternity:Show()--self:IconNumToTexture(icon)
			specWarnCallofEternity:Play("runout")--"mm"..icon
			yellCallofEternity:Yell(icon, icon)
			yellCallofEternityFades:Countdown(spellId, nil, icon)
		end
		warnCallofEternity:CombinedShow(0.5, args.destName)
		self.vb.EternityIcon = self.vb.EternityIcon + 1
	elseif spellId == 353195 then--Extemporaneous Fate
		self.vb.extemporaneousCount = self.vb.extemporaneousCount + 1
		specWarnExtemporaneousFate:Show(self.vb.extemporaneousCount)
		specWarnExtemporaneousFate:Play("specialsoon")
		timerDarkestDestiny:Start(30)
		local timer = allTimers[difficultyName][3][spellId][self.vb.extemporaneousCount+1] or 39--(technically timer is always 39 unless spell queued behind other spells. this seems to be lowest cast order priority)
		if timer then
			timerExtemporaneousFateCD:Start(timer, self.vb.extemporaneousCount+1)
		end
	elseif spellId == 354964 then
		warnRunicAffinity:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnRunicAffinity:Show()
			specWarnRunicAffinity:Play("targetyou")
		end
		if self:AntiSpam(5, 3) and self.vb.phase == 3 then
			self.vb.affinityCount = self.vb.affinityCount + 1
			--The same timer a Extemporaneous fate, just earlier, offset self handled
			local timer = allTimers[difficultyName][self.vb.phase] and allTimers[difficultyName][self.vb.phase][353195][self.vb.affinityCount+1] or 39
			if timer then
				timerRunicAffinityCD:Start(timer, self.vb.affinityCount+1)
			end
		end
	elseif spellId == 357739 then--Realign Fate
		self:SetStage(2)
		if self:IsFated() then
			self:AffixEvent(0)
		end
		self.vb.addIcon = 8
		self.vb.realignCount = self.vb.realignCount + 1
		specWarnRealignFate:Show(self.vb.realignCount)
		specWarnRealignFate:Play("specialsoon")
		timerInvokeDestinyCD:Stop()
		timerTwistFateCD:Stop()
		timerFatedConjunctionCD:Stop()
		timerCallofEternityCD:Stop()
		timerGrimPortentCD:Stop()
		timerDarkestDestiny:Start()
		self:RegisterShortTermEvents(
			"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
		)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 354365 then
		grimDebuffs = grimDebuffs - 1
		if self.Options.SetIconOnGrimPortent then
			self:SetIcon(args.destName, 0)
		end
		if grimDebuffs == 0 then
			timerGrimPortent:Stop()
		end
	elseif spellId == 351680 then
		if args:IsPlayer() then
			yellInvokeDestinyFades:Cancel()
		end
		timerInvokeDestiny:Stop()
	elseif spellId == 353432 then
		if args:IsPlayer() then
			if self.Options.NPAuraOnBurdenofDestiny then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 350568 or spellId == 356065 then
		if args:IsPlayer() then
			yellCallofEternityFades:Cancel()
		end
		if self.Options.SetIconOnCallofEternity then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 353195 then--Extemporaneous Fate
		timerDarkestDestiny:Stop()
	elseif (spellId == 357739) and self.vb.phase == 2 then
		self:UnregisterShortTermEvents()
		timerDarkestDestiny:Stop()
		self.vb.twistCount = 0
		self.vb.eternityCount = 0
		self.vb.destinyCount = 0
		self.vb.conjunctionCount = 0
		self.vb.portentCount = 0
		if self.vb.realignCount == 1 then--first cast
			self:SetStage(1)
			if self:IsFated() then
				self:AffixEvent(1, 2)
			end
			if self:IsMythic() then
				timerTwistFateCD:Start(11, 1)
				timerCallofEternityCD:Start(23, 1)
				timerInvokeDestinyCD:Start(25, 1)
				timerFatedConjunctionCD:Start(30, 1)
				timerGrimPortentCD:Start(48, 1)
			else
				timerTwistFateCD:Start(10, 1)--CAST_START
				timerFatedConjunctionCD:Start(18.5, 1)
				timerCallofEternityCD:Start(29.4, 1)
				timerInvokeDestinyCD:Start(40.4, 1)
			end
		else--Second cast
			self:SetStage(3)
			if self:IsFated() then
				self:AffixEvent(1, 3)
			end
			if self:IsMythic() then
				timerCallofEternityCD:Start(13, 1)
				timerFatedConjunctionCD:Start(18, 1)
				timerInvokeDestinyCD:Start(26, 1)
				timerRunicAffinityCD:Start(39, 1)
				timerTwistFateCD:Start(40, 1)
				timerExtemporaneousFateCD:Start(54, 1)--Rings activating
			else
				timerFatedConjunctionCD:Start(9.4, 1)--9.4-12.1
				timerCallofEternityCD:Start(11.5, 1)--11.5-14.5
				timerInvokeDestinyCD:Start(25.6, 1)
				if self:IsHeroic() then
					timerRunicAffinityCD:Start(30, 1)
				end
				timerExtemporaneousFateCD:Start(self:IsHeroic() and 46.7 or 34.4, 1)
				timerTwistFateCD:Start(50.5, 1)
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 180323 then--Fatespawn Monstrosity
		timerDespairCD:Stop(1, args.destGUID)
		timerDespairCD:Stop(2, args.destGUID)
		timerDespairCD:Stop(3, args.destGUID)
		timerDespairCD:Stop(4, args.destGUID)
		timerDespairCD:Stop(5, args.destGUID)
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local unitGUID = UnitGUID(unitID)
		if UnitExists(unitID) and not castsPerGUID[unitGUID] then
			castsPerGUID[unitGUID] = 0
			local cid = self:GetUnitCreatureId(unitID)
			if cid == 180323 then--Fatespawn Monstrosity
				--Initial despair timer, with new transcriptor log
				--timerDespairCD:Start(0, 1, unitGUID)
				if not GetRaidTargetIndex(unitID) then--Not already marked
					if self.Options.SetIconOnMonstrosity then
						self:SetIcon(unitID, self.vb.addIcon)
					end
					self.vb.addIcon = self.vb.addIcon - 1
				end
			end
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--"<1445.83 22:22:30> [UNIT_SPELLCAST_SUCCEEDED] Fatescribe Roh-Kalo(Shazzul) -Extemporaneous Fate- [[boss1:Cast-3-2012-2450-10555-353193-000195A188:353193]]", -- [28166]
--"<1453.06 22:22:37> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\Achievement_GuildPerk_WorkingOvertime_Rank2.blp:20|t Fatescribe Roh-Kalo is creating an |cFFFF0000|Hspell:353195|h[Extemporaneous Fate]|h|r!#Fatescribe Roh-Kalo###Fatescribe Roh-Kalo##0#0##0#572#nil#0#false#false#false#false", -- [28352]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then--Extemporaneous Fate (precast)
		warnExtemporaneousFate:Show()--PreWarning
	end
end
