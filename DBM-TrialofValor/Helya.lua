local mod	= DBM:NewMod(1829, "DBM-TrialofValor", nil, 861)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(114537)
mod:SetEncounterID(2008)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(15486)
mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227967 228390 228565 228032 228854 227903 228056 228619 228633",
	"SPELL_CAST_SUCCESS 228300 228519 228854",
	"SPELL_AURA_APPLIED 229119 227982 193367 228519 232488 228054 230267",
	"SPELL_AURA_REMOVED 193367 229119 230267 228300 228054",
	"SPELL_PERIODIC_DAMAGE 227998",
	"SPELL_PERIODIC_MISSED 227998",
	"SPELL_INTERRUPT",
	"UNIT_DIED",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 228730 or ability.id = 228032 or ability.id = 228565 or ability.id = 227967 or ability.id = 228619 or ability.id = 228633) and type = "begincast" or
(ability.id = 228390 or ability.id = 228300 or ability.id = 227903 or ability.id = 228056 or ability.id = 228519) and type = "cast" or
ability.id = 228300 and type = "removebuff" or ability.id = 167910 or (ability.name = "Fetid Rot" or ability.id = 228054) and (type = "cast" or type = "applydebuff")
or ability.id = 227992
--]]
--TODO, Add range finder for Taint of the sea?
--TODO, figure out what to do with Ghostly Rage (Night Watch Mariner). Most say it's not needed and fight already has too much information, so still holding off on this
--TODO, VERIFY timer update code for fury of maw, when mistcaller gets off a cast
--TODO, more work with Corrupted Axion and Dark Hatred?
--Stage One: Low Tide
local warnOrbOfCorruption			= mod:NewTargetAnnounce(229119, 3)
local warnTaintOfSea				= mod:NewTargetAnnounce(228054, 2)
--Stage Two: From the Mists (65%)
----Grimelord
local warnOrbOfCorruption			= mod:NewTargetAnnounce(229119, 3)
local warnFetidRot					= mod:NewTargetAnnounce(193367, 3)
----Night Watch Mariner
----MistCaller
local warnMistInfusion				= mod:NewCastAnnounce(228854, 4, nil, nil, false)
--Stage Three: Helheim's Last Stand
local warnDarkHatred				= mod:NewTargetAnnounce(232488, 3)
local warnOrbOfCorrosion			= mod:NewTargetAnnounce(230267, 3)

--Stage One: Low Tide
local specWarnOrbOfCorruption		= mod:NewSpecialWarningYou(229119, nil, nil, nil, 1, 5)
local yellOrbOfCorruption			= mod:NewPosYell(229119)
local specWarnTaintofSea			= mod:NewSpecialWarningMoveAway(228088, nil, nil, nil, 1, 2)
local specWarnBilewaterBreath		= mod:NewSpecialWarningSpell(227967, nil, nil, nil, 2, 2)
local specWarnBilewaterRedox		= mod:NewSpecialWarningTaunt(227982, nil, nil, nil, 1, 2)
local specWarnBilewaterCorrosion	= mod:NewSpecialWarningMove(227998, nil, nil, nil, 1, 2)
local specWarnTentacleStrike		= mod:NewSpecialWarningCount(228730, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(228730), nil, 2)
--Stage Two: From the Mists (65%)
----Helya
local specWarnFuryofMaw				= mod:NewSpecialWarningSpell(228032, nil, nil, nil, 2)
----Grimelord
local specWarnGrimeLord				= mod:NewSpecialWarningSwitch("ej14263", "Tank", nil, nil, 1, 2)
local specWarnSludgeNova			= mod:NewSpecialWarningRun(228390, "Melee", nil, nil, 4, 3)
local specWarnFetidRot				= mod:NewSpecialWarningMoveAway(193367, nil, nil, nil, 1, 2)
local yellFetidRot					= mod:NewFadesYell(193367)
local specWarnAnchorSlam			= mod:NewSpecialWarningTaunt(228519, nil, nil, nil, 1, 2)
----Night Watch Mariner
local specWarnLanternofDarkness		= mod:NewSpecialWarningSpell(228619, nil, nil, nil, 2, 2)
local specWarnGiveNoQuarter			= mod:NewSpecialWarningDodge(228633, nil, nil, nil, 1, 2)
--Stage Three: Helheim's Last Stand
local specWarnCorruptedBreath		= mod:NewSpecialWarningSpell(228565, nil, nil, nil, 2)
local specWarnOrbOfCorrosion		= mod:NewSpecialWarningYou(230267, nil, nil, nil, 1, 5)
local yellOrbOfCorrosion			= mod:NewPosYell(230267)

--Stage One: Low Tide
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerOrbOfCorruptionCD		= mod:NewNextTimer(25, 229119, "OrbsTimerText", nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerTaintOfSeaCD				= mod:NewCDTimer(14.5, 228088, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON)
local timerBilewaterBreathCD		= mod:NewNextTimer(40, 227967, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)--On for everyone though so others avoid it too
local timerTentacleStrikeCD			= mod:NewNextCountTimer(30, 228730, nil, nil, nil, 2)
local timerTentacleStrike			= mod:NewCastSourceTimer(6, 228730, nil, nil, nil, 5)
local timerExplodingOozes			= mod:NewCastTimer(20.5, 227992, nil, nil, nil, 2, nil, DBM_CORE_DAMAGE_ICON)
--Stage Two: From the Mists (65%)
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerFuryofMaw				= mod:NewBuffActiveTimer(32, 228032, nil, nil, nil, 2)
----Helya
local timerFuryofMawCD				= mod:NewNextCountTimer(44.5, 228032, nil, nil, nil, 2)
local timerAddsCD					= mod:NewNextTimer(75.5, 167910, nil, nil, nil, 1)
----Grimelord
local timerSludgeNovaCD				= mod:NewCDTimer(24.2, 228390, nil, "Melee", nil, 2)
local timerAnchorSlamCD				= mod:NewCDTimer(12, 228519, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerFetidRotCD				= mod:NewCDTimer(13, 193367, nil, nil, nil, 3)
----Night Watch Mariner
local timerLanternofDarknessCD		= mod:NewNextTimer(25, 228619, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerGiveNoQuarterCD			= mod:NewNextTimer(6, 228633, nil, nil, nil, 3)
----Mythic Add
local timerMistInfusion				= mod:NewCastTimer(7, 228854, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--Stage Three: Helheim's Last Stand
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerCorruptedBreathCD		= mod:NewCDTimer(40, 228565, nil, nil, nil, 2)
local timerOrbOfCorrosionCD			= mod:NewNextTimer(17, 230267, "OrbsTimerText", nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)

local berserkTimer					= mod:NewBerserkTimer(660)

--Stage One: Low Tide
local countdownOrbs					= mod:NewCountdown("AltTwo18", 229119)
local countdownOozeExplosions		= mod:NewCountdown(20.5, 227992)
--Stage Two: From the Mists (65%)
--Stage Three: Helheim's Last Stand

--Stage One: Low Tide
local voiceOrbofCorruption			= mod:NewVoice(229119)--orbrun
local voiceTaintOfSea				= mod:NewVoice(228088)--scatter?runout?
local voiceBilewaterBreath			= mod:NewVoice(227967)--breathsoon
local voiceBilewaterRedox			= mod:NewVoice(227982)--tauntboss
local voiceBilewaterCorrosion		= mod:NewVoice(227998)--runaway
--Stage Two: From the Mists (65%)
----Grimelord
local voiceGrimeLord				= mod:NewVoice("ej14263", "Tank")--bigmob
local voiceFetidRot					= mod:NewVoice(193367)--range5
local voiceSludgeNova				= mod:NewVoice(228390, "Melee")--runout
local voiceAnchorSlam				= mod:NewVoice(228519)--tauntboss (maybe change to "changemt" if this add can be up with boss)
----Night Watch Mariner
local voiceLanternofDarkness		= mod:NewVoice(228619)--range5
local voiceGiveNoQuarter			= mod:NewVoice(228633)--watchstep
--Stage Three: Helheim's Last Stand (45%)
local voiceOrbofCorrosion			= mod:NewVoice(230267)--orbrun

mod:AddRangeFrameOption(5, 193367)
mod:AddSetIconOption("SetIconOnTaint", 228088, false)
mod:AddSetIconOption("SetIconOnOrbs", 229119, true)--Healer (Star), Tank (Circle), Deeps (Diamond)
mod:AddInfoFrameOption(193367)

local seenMobs = {}
--[[
35.405 Striking Tentacle 1 begins casting Tentacle Strike (melee)
39.384 Striking Tentacle 2 begins casting Tentacle Strike (melee)

71.364 Striking Tentacle 3 begins casting Tentacle Strike (melee)
71.364 Striking Tentacle 4 begins casting Tentacle Strike (ranged)

106.591	Striking Tentacle 5 begins casting Tentacle Strike (ranged)
110.597	Striking Tentacle 6 begins casting Tentacle Strike (range)

142.234	Striking Tentacle 7 begins casting Tentacle Strike (ranged)
146.222	Striking Tentacle 8 begins casting Tentacle Strike (melee)
150.230	Striking Tentacle 9 begins casting Tentacle Strike (ranged)

177.493	Striking Tentacle 10 begins casting Tentacle Strike (melee)
181.444	Striking Tentacle 11 begins casting Tentacle Strike (melee)
--]]
local mythicTentacleSpawns = {"2x"..DBM_CORE_FRONT, "1x"..DBM_CORE_FRONT.."/1x"..DBM_CORE_BACK, "2x"..DBM_CORE_BACK, "2x"..DBM_CORE_BACK.."/1x"..DBM_CORE_FRONT, "2x"..DBM_CORE_FRONT}
local phase3MythicOrbs = {6, 13, 13, 27.1, 10.7, 13, 25, 13, 13, 25, 13, 17.6, 19.5, 13, 13, 12, 12, 16.8, 8.2}--Needs more casts before berserk
local phase3MythicTaint = {0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 17, 14, 11}--Needs two-four more casts til berserk

mod.vb.phase = 1
mod.vb.rottedPlayers = 0
mod.vb.orbCount = 0
mod.vb.furyOfMawCount = 0
mod.vb.tentacleCount = 0
mod.vb.taintCount = 0

function mod:OnCombatStart(delay)
	table.wipe(seenMobs)
	self.vb.phase = 1
	self.vb.rottedPlayers = 0
	self.vb.orbCount = 0
	self.vb.furyOfMawCount = 0
	self.vb.tentacleCount = 0
	self.vb.taintCount = 0
	if self:IsEasy() then
		timerTaintOfSeaCD:Start(12.4-delay)
		timerBilewaterBreathCD:Start(13.3-delay)
		timerOrbOfCorruptionCD:Start(18-delay, 1, RANGED)--START
		countdownOrbs:Start(18-delay)
		timerTentacleStrikeCD:Start(53-delay, 1)
	elseif self:IsMythic() then
		timerBilewaterBreathCD:Start(11-delay)
		timerOrbOfCorruptionCD:Start(14-delay, 1, RANGED)--START
		countdownOrbs:Start(14-delay)
		timerTaintOfSeaCD:Start(15-delay)
		timerTentacleStrikeCD:Start(35-delay, 1)
		berserkTimer:Start(-delay)--11 Min confirmed
	else
		timerBilewaterBreathCD:Start(12-delay)
		timerTaintOfSeaCD:Start(19-delay)
		timerOrbOfCorruptionCD:Start(29-delay, 1, RANGED)--START
		countdownOrbs:Start(29-delay)
		timerTentacleStrikeCD:Start(36-delay, 1)
		berserkTimer:Start(-delay)--11 Min assumed
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227967 then
		specWarnBilewaterBreath:Show()
		voiceBilewaterBreath:Play("breathsoon")
		if self:IsNormal() then
			timerBilewaterBreathCD:Start(57)
		elseif self:IsMythic() then
			timerBilewaterBreathCD:Start(43)
		else--Verified heroic and LFR. TODO, verify mythic and reverify LFR
			timerBilewaterBreathCD:Start(52)
		end
		--Start ooze stuff here since all their stuff is hidden from combat log
		timerExplodingOozes:Start()
		countdownOozeExplosions:Start()
	elseif spellId == 228390 then
		if self:CheckTankDistance(args.sourceGUID, 18) then--18 has to be used because of limitations in 7.1 distance APIs
			--Only warn if you are near the person tanking this
			specWarnSludgeNova:Show()
			voiceSludgeNova:Play("runout")
		end
		timerSludgeNovaCD:Start()
	elseif spellId == 228565 then
		specWarnCorruptedBreath:Show()
		if self:IsEasy() then
			timerCorruptedBreathCD:Start(51)
		elseif self:IsMythic() then
			timerCorruptedBreathCD:Start(43)
		else
			timerCorruptedBreathCD:Start(47.5)
		end
	elseif spellId == 228032 then--Phase 3 Fury of the Maw
		self.vb.furyOfMawCount = self.vb.furyOfMawCount + 1
		specWarnFuryofMaw:Show(self.vb.furyOfMawCount)
		if self:IsLFR() then
			timerFuryofMawCD:Start(92, self.vb.furyOfMawCount+1)
		elseif self:IsNormal() then
			timerFuryofMawCD:Start(77, self.vb.furyOfMawCount+1)
		elseif self:IsMythic() then
			timerFuryofMawCD:Start(56, self.vb.furyOfMawCount+1)
		else
			timerFuryofMawCD:Start(74.6, self.vb.furyOfMawCount+1)
		end
		timerAddsCD:Start(7)
	elseif spellId == 228854 then
		if self:AntiSpam(0.5, 5) then--Combine two cast at same time, but if at least a second apart separate them
			warnMistInfusion:Show()
		end
		timerMistInfusion:Start(nil, args.sourceGUID)
	elseif spellId == 227903 then
		self.vb.orbCount = self.vb.orbCount + 1
		--Odd orbs are ranged and evens are melee
		local text = (self.vb.orbCount+1) % 2 == 0 and MELEE or RANGED
		if self:IsEasy() then
			timerOrbOfCorruptionCD:Start(31.2, self.vb.orbCount+1, text)
			countdownOrbs:Start(31.2)
		elseif self:IsMythic() then
			timerOrbOfCorruptionCD:Start(24, self.vb.orbCount+1, text)
			countdownOrbs:Start(24)
		else
			timerOrbOfCorruptionCD:Start(28, self.vb.orbCount+1, text)
			countdownOrbs:Start(28)
		end
	elseif spellId == 228056 then
		self.vb.orbCount = self.vb.orbCount + 1
		--Odd orbs are ranged and evens are melee
		local text = (self.vb.orbCount+1) % 2 == 0 and MELEE or RANGED
		if self:IsLFR() then
			timerOrbOfCorrosionCD:Start(32.7, self.vb.orbCount+1, text)
			countdownOrbs:Start(32.7)
		elseif self:IsMythic() then
			local timer = phase3MythicOrbs[self.vb.orbCount+1]
			if timer then
				timerOrbOfCorrosionCD:Start(timer, self.vb.orbCount+1, text)
				countdownOrbs:Start(timer)
			else
				timerOrbOfCorrosionCD:Start(12, self.vb.orbCount+1, text)
				countdownOrbs:Start(12)
			end
		else--Reverify normal
			timerOrbOfCorrosionCD:Start(17, self.vb.orbCount+1, text)
			countdownOrbs:Start(17)
		end
	elseif spellId == 228619 then
		specWarnLanternofDarkness:Show()
	elseif spellId == 228633 then
		specWarnGiveNoQuarter:Show()
		voiceGiveNoQuarter:Play("watchstep")
		if self:IsEasy() then
			timerGiveNoQuarterCD:Start(9.7)
		else
			timerGiveNoQuarterCD:Start(6)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 228300 then--Phase 2 Fury of the Maw
		self.vb.furyOfMawCount = self.vb.furyOfMawCount + 1
		specWarnFuryofMaw:Show(self.vb.furyOfMawCount)
		timerFuryofMaw:Start()
		if self:IsMythic() then
			timerAddsCD:Start(7)
		end
	elseif spellId == 228519 then
		if self:IsEasy() then
			timerAnchorSlamCD:Start(14, args.sourceGUID)
		else
			timerAnchorSlamCD:Start(12, args.sourceGUID)
		end
	elseif spellId == 228854 then--Mist infusion got off, update timers
		local elapsed, total = timerFuryofMawCD:GetTime(self.vb.furyOfMawCount+1)
		local remaining = total - elapsed
		if remaining and remaining > 11 then
			timerFuryofMawCD:Update(elapsed+11, total, self.vb.furyOfMawCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 229119 then
		warnOrbOfCorruption:CombinedShow(0.3, args.destName)
		if self.Options.SetIconOnOrbs then
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				self:SetIcon(args.destName, 2)--Circle
			elseif self:IsHealer(uId) then
				self:SetIcon(args.destName, 1)--Star
			else
				self:SetIcon(args.destName, 3)--Diamond
			end
		end
	elseif spellId == 230267 then
		warnOrbOfCorrosion:CombinedShow(0.3, args.destName)
		if self.Options.SetIconOnOrbs then
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsMythic() then
				if self:IsHealer(uId) then--On mythic, a tank isn't chosen, just 1 healer and 2 dps
					self:SetIcon(args.destName, 1)--Star
				else
					self:SetSortedIcon(1, args.destName, 2, 2)--Circle and Diamond
				end
			else
				if self:IsTanking(uId) then
					self:SetIcon(args.destName, 2)--Circle
				elseif self:IsHealer(uId) then--LFR/Normal doesn't choose a healer, just tank/damage
					self:SetIcon(args.destName, 1)--Star
				else
					self:SetIcon(args.destName, 3)--Diamond
				end
			end
		end
	elseif spellId == 227982 then
		if not args:IsPlayer() then
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then--Filter numties standing in front of boss that shouldn't be
				specWarnBilewaterRedox:Show(args.destName)
				voiceBilewaterRedox:Play("tauntboss")
			end
		end
	elseif spellId == 228519 then
		if not args:IsPlayer() then
			local uId = DBM:GetRaidUnitId(args.destName)
			--Filter numties standing in front of boss that shouldn't be
			--Also filter tanks that are too far away to taunt from (mythic split)
			if self:IsTanking(uId) and self:CheckNearby(18, args.destName) then
				specWarnAnchorSlam:Show(args.destName)
				voiceAnchorSlam:Play("tauntboss")
			end
		end
	elseif spellId == 193367 then
		self.vb.rottedPlayers = self.vb.rottedPlayers + 1
		warnFetidRot:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFetidRot:Show()
			voiceFetidRot:Play("range5")
			if self:IsMythic() then--yell on applied as well, it starts spreading MUCH sooner
				yellFetidRot:Yell(15)
			end
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
			if expires then
				local remaining = expires-GetTime()
				yellFetidRot:Schedule(remaining-1, 1)
				yellFetidRot:Schedule(remaining-2, 2)
				yellFetidRot:Schedule(remaining-3, 3)
			end
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() and not self:IsLFR() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(5, "playerdebuffstacks", args.spellName)
		end
	elseif spellId == 232488 then
		warnDarkHatred:CombinedShow(0.3, args.destName)
	elseif spellId == 228054 then
		warnTaintOfSea:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnTaintofSea:Show()
			voiceTaintOfSea:Play("scatter")
		end
		if self.Options.SetIconOnTaint then
			self:SetSortedIcon(0.5, args.destName, 4, 5)
		end
		if self:AntiSpam(5, 6) then
			self.vb.taintCount = self.vb.taintCount + 1
			if self:IsEasy() then--Cast MORE OFTEN in LFR/normal?
				if self.vb.phase == 3 then
					timerTaintOfSeaCD:Start(27)
				else
					timerTaintOfSeaCD:Start(12.1)
				end
			elseif self:IsMythic() then
				if self.vb.phase == 3 then
					local timer = phase3MythicTaint[self.vb.taintCount+1]
					if timer then
						timerTaintOfSeaCD:Start(timer)
					else
						timerTaintOfSeaCD:Start(11)--Assume rest are 11 until more data
					end
				else
					timerTaintOfSeaCD:Start(12.1)
				end
			else--Special snowflake for some reason (heroic)
				if self.vb.phase == 3 then
					timerTaintOfSeaCD:Start(25.5)--TODO, see what happens to it on heroic soft enrage mechanic
				else
					timerTaintOfSeaCD:Start()--14.5, only mode that's not 12.1
				end
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 193367 then
		self.vb.rottedPlayers = self.vb.rottedPlayers - 1
		if args:IsPlayer() then
			yellFetidRot:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
		if self.vb.rottedPlayers == 0 and self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 229119 then
		if self.Options.SetIconOnOrbs then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 228300 then
		timerFuryofMaw:Stop()
		if self.vb.phase == 2 then
			if self:IsEasy() then
				timerAddsCD:Start(7)
				timerFuryofMawCD:Start(45, self.vb.furyOfMawCount+1)
			elseif self:IsMythic() then
				timerFuryofMawCD:Start(37.3, self.vb.furyOfMawCount+1)
			else
				timerAddsCD:Start(7)
				timerFuryofMawCD:Start(42.6, self.vb.furyOfMawCount+1)
			end
		end
	elseif spellId == 228054 then
		if self.Options.SetIconOnTaint then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 227998 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnBilewaterCorrosion:Show()
		voiceBilewaterCorrosion:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 228854 then
		timerMistInfusion:Stop(args.dest.GUID)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 114709 then--GrimeLord
		timerSludgeNovaCD:Stop(args.destGUID)
		timerAnchorSlamCD:Stop(args.destGUID)
	elseif cid == 114809 then--Night Watch Mariner
		timerLanternofDarknessCD:Stop(args.destGUID)
		timerGiveNoQuarterCD:Stop(args.destGUID)
	elseif cid == 116335 then--Helarjar Mistwatcher
		timerMistInfusion:Stop(args.destGUID)
	end
end

--This is used over boats because it's more reliable
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local GUID = UnitGUID(unitID)
		if GUID and not seenMobs[GUID] then
			seenMobs[GUID] = true
			local cid = self:GetCIDFromGUID(GUID)
			if cid == 114709 then--GrimeLord
				specWarnGrimeLord:Show()
				voiceGrimeLord:Play("bigmob")
				timerFetidRotCD:Start(7, GUID)
				if not self:IsLFR() then
					timerAnchorSlamCD:Start(13.7, GUID)
				end
				timerSludgeNovaCD:Start(17.5, GUID)
			elseif cid == 114809 then--Night Watch Mariner
				if self.vb.phase == 2 then
					if self:IsMythic() then
						timerGiveNoQuarterCD:Start(7, GUID)
						timerLanternofDarknessCD:Start(26, GUID)
					else
						timerGiveNoQuarterCD:Start(7, GUID)
						timerLanternofDarknessCD:Start(30, GUID)
					end
				else
					if self:IsMythic() then
						timerGiveNoQuarterCD:Start(10, GUID)--Poor data. Oddity?
						timerLanternofDarknessCD:Start(30, GUID)
					else
						timerGiveNoQuarterCD:Start(7, GUID)
						timerLanternofDarknessCD:Start(35, GUID)
					end
				end
			end
		end
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg:find(L.near) then
		if not self:IsMythic() then
			specWarnTentacleStrike:Show(DBM_CORE_FRONT)
		end
		timerTentacleStrike:Start(DBM_CORE_FRONT)
	elseif msg:find(L.far) then
		if not self:IsMythic() then
			specWarnTentacleStrike:Show(DBM_CORE_BACK)
		end
		timerTentacleStrike:Start(DBM_CORE_BACK)
	--Backup for the like 8 languages dbm doesn't have translators for
	elseif msg:find("inv_misc_monsterhorn_03") then
		if not self:IsMythic() then
			specWarnTentacleStrike:Show(DBM_CORE_UNKNOWN)
		end
		timerTentacleStrike:Start(DBM_CORE_UNKNOWN)
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:227920") then
		specWarnOrbOfCorruption:Show()
		voiceOrbofCorruption:Play("orbrun")
		if self:IsTank() then
			yellOrbOfCorruption:Yell(2, 2, 2)
		elseif self:IsHealer() then--LFR/Normal doesn't choose a healer, just tank/damage
			yellOrbOfCorruption:Yell(1, 1, 1)
		else
			yellOrbOfCorruption:Yell(3, 3, 3)
		end
	elseif msg:find("spell:228058") then
		specWarnOrbOfCorrosion:Show()
		voiceOrbofCorrosion:Play("orbrun")
		if self:IsTank() then
			yellOrbOfCorrosion:Yell(2, 2, 2)
		elseif self:IsHealer() then--LFR/Normal doesn't choose a healer, just tank/damage
			yellOrbOfCorrosion:Yell(1, 1, 1)
		else
			yellOrbOfCorrosion:Yell(3, 3, 3)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 228372 then--Mists of Helheim (Phase 2)
		self.vb.phase = 2
		timerTentacleStrikeCD:Stop()
		timerBilewaterBreathCD:Stop()
		timerOrbOfCorruptionCD:Stop()
		countdownOrbs:Cancel()
		if not self:IsMythic() then
			--On mythic first fury of maw is instantly on phase change, adds timer is handled by that
			timerAddsCD:Start(14)
			timerFuryofMawCD:Start(36.5, 1)
		end
	elseif spellId == 228546 and not self.vb.phase == 3 then--Helya (Phase 3, 6 seconds slower than yell)
		self.vb.phase = 3
		self.vb.taintCount = 0--TODO, make sure helya happens before first taint goes out
		self.vb.orbCount = 0
		self.vb.furyOfMawCount = 0
		timerFuryofMawCD:Stop()
		if self:IsLFR() then
			timerOrbOfCorrosionCD:Start(11, 1, RANGED)--Needs recheck
			countdownOrbs:Start(11)--Needs recheck
			timerCorruptedBreathCD:Start(40)--Needs recheck
			timerFuryofMawCD:Start(90, 1)--Needs recheck
		elseif self:IsMythic() then
			timerOrbOfCorrosionCD:Start(6, 1, RANGED)
			countdownOrbs:Start(6)
			timerCorruptedBreathCD:Start(10)
			timerFuryofMawCD:Start(35, 1)
		elseif self:IsNormal() then--May still be same as heroic with variation
			timerOrbOfCorrosionCD:Start(12, 1, RANGED)--Needs recheck
			countdownOrbs:Start(12)--Needs more verification
			timerCorruptedBreathCD:Start(20.5)
			timerFuryofMawCD:Start(33, 1)--Needs more verification
		else--Heroic
			timerOrbOfCorrosionCD:Start(14, 1, RANGED)--Needs more verification
			countdownOrbs:Start(14)--Needs verification
			timerCorruptedBreathCD:Start(19.4)
			timerFuryofMawCD:Start(30, 1)
		end
	elseif spellId == 228838 then
		if self:IsEasy() then
			timerFetidRotCD:Start(15, UnitGUID(uId))
		elseif self:IsMythic() then
			timerFetidRotCD:Start(13, UnitGUID(uId))
		else
			timerFetidRotCD:Start(12, UnitGUID(uId))
		end
	elseif spellId == 228728 then--Tentacle strike activating
		self.vb.tentacleCount = self.vb.tentacleCount + 1
		if self:IsEasy() then
			timerTentacleStrikeCD:Start(40, self.vb.tentacleCount+1)
		elseif self:IsMythic() then
			timerTentacleStrikeCD:Start(35, self.vb.tentacleCount+1)
			local text = mythicTentacleSpawns[self.vb.tentacleCount]
			if text then
				specWarnTentacleStrike:Show(text)
			else
				specWarnTentacleStrike:Show(DBM_CORE_UNKNOWN)
			end
		else
			timerTentacleStrikeCD:Start(42.5, self.vb.tentacleCount+1)
		end
	end
end
