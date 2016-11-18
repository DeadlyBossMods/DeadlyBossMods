local mod	= DBM:NewMod(1829, "DBM-TrialofValor", nil, 861)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(114537)
mod:SetEncounterID(2008)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
mod:SetHotfixNoticeRev(15453)
mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227967 228730 228514 228390 228565 228032 228854 227903 228056",
	"SPELL_CAST_SUCCESS 227967 228300 228519",
	"SPELL_AURA_APPLIED 229119 227982 193367 228519 232488 228054 230267",
	"SPELL_AURA_REMOVED 193367 229119 230267 228300 167910 228054",
	"SPELL_PERIODIC_DAMAGE 227998",
	"SPELL_PERIODIC_MISSED 227998",
	"UNIT_DIED",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"CHAT_MSG_MONSTER_YELL",
	"RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 228730 or ability.id = 228032 or ability.id = 228565 or ability.id = 227967) and type = "begincast" or
(ability.id = 228390 or ability.id = 228300 or ability.id = 227903 or ability.id = 228056) and type = "cast" or
ability.id = 228300 and type = "removebuff" or ability.id = 167910
--]]
--TODO, Add range finder for Taint of the sea?
--TODO, figure out what to do with Torrent
--TODO, figure out what to do with Lantern of Darkness (Night Watch Mariner)
--TODO, figure out what to do with Ghostly Rage (Night Watch Mariner)
--TODO, figure out what to do with Give no Quarter (Night Watch Mariner)
--TODO, add Helarjer Mistcaller stuff for mythic
--TODO, timer update code for fury of maw, when mistcaller gets off a cast
--TODO, more work with Corrupted Axion and Dark Hatred
--TODO, better way to handle  tentacle strikes than just antispamming 2nd and 3rd in mythic sets?
--Stage One: Low Tide
local warnOrbOfCorruption			= mod:NewTargetAnnounce(229119, 3)
local warnTaintOfSea				= mod:NewTargetAnnounce(228054, 2)
local warnTentacleStrike			= mod:NewCountAnnounce(228730, 4)
--Stage Two: From the Mists (65%)
--local warnTorrent					= mod:NewSpellAnnounce(228514, 3)
----Grimelord
local warnOrbOfCorruption			= mod:NewTargetAnnounce(229119, 3)
local warnFetidRot					= mod:NewTargetAnnounce(193367, 3)
----Night Watch Mariner
----MistCaller
local warnMistInfusion				= mod:NewTargetAnnounce(228854, 4)
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
local specWarnTentacleStrike		= mod:NewSpecialWarningSoakPos(228730, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(228730), nil, 2)
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
--Stage Three: Helheim's Last Stand
local specWarnCorruptedBreath		= mod:NewSpecialWarningSpell(228565, nil, nil, nil, 2)
local specWarnOrbOfCorrosion		= mod:NewSpecialWarningYou(230267, nil, nil, nil, 1, 5)
local yellOrbOfCorrosion			= mod:NewPosYell(230267)

--Stage One: Low Tide
local timerOrbOfCorruptionCD		= mod:NewNextTimer(25, 229119, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerTaintOfSeaCD				= mod:NewCDTimer(14.5, 228088, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON)
local timerBilewaterBreathCD		= mod:NewNextTimer(40, 227967, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)--On for everyone though so others avoid it too
local timerTentacleStrikeCD			= mod:NewNextTimer(30, 228730, nil, nil, nil, 2)
local timerTentacleStrike			= mod:NewCastSourceTimer(6, 228730, nil, nil, nil, 5)
local timerExplodingOozes			= mod:NewCastTimer(22.5, 227992, nil, nil, nil, 2, nil, DBM_CORE_DAMAGE_ICON)
--Stage Two: From the Mists (65%)
local timerFuryofMaw				= mod:NewBuffActiveTimer(32, 228032, nil, nil, nil, 2)
----Helya
local timerFuryofMawCD				= mod:NewNextTimer(44.5, 228032, nil, nil, nil, 2)
----Grimelord
--local timerGrimeLordCD				= mod:NewCDTimer(52.7, "ej14263", nil, nil, nil, 1, 228519)
--local timerNightWatchCD				= mod:NewCDTimer(52.7, "ej14278", nil, "Tank", nil, 1, 228632)
local timerAddsCD					= mod:NewCDTimer(75.5, 167910, nil, nil, nil, 1)
local timerSludgeNovaCD				= mod:NewCDTimer(24.5, 228390, nil, "Melee", nil, 2)
local timerAnchorSlamCD				= mod:NewCDTimer(12, 228519, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
----Night Watch Mariner
--Stage Three: Helheim's Last Stand
local timerCorruptedBreathCD		= mod:NewCDTimer(40, 228565, nil, nil, nil, 2)
local timerOrbOfCorrosionCD			= mod:NewCDTimer(17, 230267, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)

--local berserkTimer					= mod:NewBerserkTimer(300)

--Stage One: Low Tide
local countdownOrbs					= mod:NewCountdown("AltTwo18", 229119)
local countdownOozeExplosions		= mod:NewCountdown(22.5, 227992)
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
--Stage Three: Helheim's Last Stand
local voiceOrbofCorrosion			= mod:NewVoice(230267)--orbrun

mod:AddRangeFrameOption(5, 193367)
mod:AddSetIconOption("SetIconOnTaint", 228088, false)
mod:AddSetIconOption("SetIconOnOrbs", 229119, true)--Healer (Star), Tank (Circle), Deeps (Diamond)
mod:AddInfoFrameOption(193367)

local seenMobs = {}
mod.vb.phase = 1
mod.vb.rottedPlayers = 0

function mod:OnCombatStart(delay)
	table.wipe(seenMobs)
	self.vb.phase = 1
	self.vb.rottedPlayers = 0
	if self:IsLFR() then--was ONLY LFR that had diff timers, normal testing had same as heroic
		timerOrbOfCorruptionCD:Start(18-delay)--START
		countdownOrbs:Start(18-delay)
		timerBilewaterBreathCD:Start(42-delay)--Check if changed, because normals timers all match LFR except this
		timerTentacleStrikeCD:Start(53-delay)
	elseif self:IsNormal() then
		timerBilewaterBreathCD:Start(13.3-delay)
		timerOrbOfCorruptionCD:Start(18-delay)--START
		countdownOrbs:Start(18-delay)
		timerTentacleStrikeCD:Start(53-delay)
	elseif self:IsMythic() then
		timerBilewaterBreathCD:Start(11-delay)
		timerOrbOfCorruptionCD:Start(14-delay)--START
		countdownOrbs:Start(14-delay)
		timerTentacleStrikeCD:Start(35-delay)
	else--TODO, reverify heroic. maybe they changed after tested to match LFR/normal
		timerBilewaterBreathCD:Start(12-delay)
		timerOrbOfCorruptionCD:Start(29-delay)--START
		countdownOrbs:Start(29-delay)
		timerTentacleStrikeCD:Start(36-delay)
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
	elseif spellId == 228730 then
		if self:AntiSpam(10, 3) then
			if self:IsEasy() then
				timerTentacleStrikeCD:Start(40)
			elseif self:IsMythic() then
				timerTentacleStrikeCD:Start(35)
			else
				timerTentacleStrikeCD:Start(42.5)
			end
		end
--	elseif spellId == 228514 then
--		warnTorrent:Show()
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
		else
			timerCorruptedBreathCD:Start(47.5)
		end
	elseif spellId == 228032 then--Phase 3 Fury of the Maw
		specWarnFuryofMaw:Show()
		if self:IsLFR() then
			timerFuryofMawCD:Start(92)
		else
			timerFuryofMawCD:Start(74.6)
		end
	elseif spellId == 228854 then
		warnMistInfusion:Show()
	elseif spellId == 227903 then
		if self:IsEasy() then
			timerOrbOfCorruptionCD:Start(31.2)
			countdownOrbs:Start(31.2)
		elseif self:IsMythic() then
			timerOrbOfCorruptionCD:Start(24)
			countdownOrbs:Start(24)
		else
			timerOrbOfCorruptionCD:Start(28)
			countdownOrbs:Start(28)
		end
	elseif spellId == 228056 then
		if self:IsLFR() then
			timerOrbOfCorrosionCD:Start(32.7)
			countdownOrbs:Start(32.7)
		else--Reverify normal
			timerOrbOfCorrosionCD:Start(17)
			countdownOrbs:Start(17)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 227967 then
		--Start ooze stuff here since all their stuff is hidden from combat log
		timerExplodingOozes:Start()
		countdownOozeExplosions:Start()
	elseif spellId == 228300 then--Phase 2 Fury of the Maw
		specWarnFuryofMaw:Show()
		timerFuryofMaw:Start()
	elseif spellId == 228519 then
		timerAnchorSlamCD:Start(nil, args.sourceGUID)
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
			if self:IsTanking(uId) then
				self:SetIcon(args.destName, 2)--Circle
			elseif self:IsHealer(uId) then--LFR/Normal doesn't choose a healer, just tank/damage
				self:SetIcon(args.destName, 1)--Star
			else
				self:SetIcon(args.destName, 3)--Diamond
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
			if self:IsTanking(uId) then--Filter numties standing in front of boss that shouldn't be
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
			self:SetSortedIcon(0.5, args.destName, 4)
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
			timerFuryofMawCD:Start()
		end
	elseif spellId == 167910 and self:AntiSpam(10, 2) then
		self:SendSync("Adds")--I've outrnaged the combat log event for this being on one of the side platforms, since this event is already coming from further away (in water)
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 114709 then--GrimeLord
		timerSludgeNovaCD:Stop(args.destGUID)
		timerAnchorSlamCD:Stop(args.destGUID)
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
				timerAnchorSlamCD:Start(14, GUID)
				timerSludgeNovaCD:Start(17.5, GUID)
				--timerGrimeLordCD:Start()
			elseif cid == 114809 then--Night Watch Mariner
				--timerNightWatchCD:Start()
			end
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
	if (msg == L.phaseThree or msg:find(L.phaseThree)) then
		self:SendSync("Phase3")--Syncing to help unlocalized clients
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg:find(L.near) then
		if self:IsMythic() then
			warnTentacleStrike:Show(DBM_CORE_FRONT)
			if self:AntiSpam(12, 4) then
				specWarnTentacleStrike:Show(L.multiple)
			end
		else
			specWarnTentacleStrike:Show(DBM_CORE_FRONT)
		end
		timerTentacleStrike:Start(DBM_CORE_FRONT)
	elseif msg:find(L.far) then
		if self:IsMythic() then
			warnTentacleStrike:Show(DBM_CORE_BACK)
			if self:AntiSpam(12, 4) then
				specWarnTentacleStrike:Show(L.multiple)
			end
		else
			specWarnTentacleStrike:Show(DBM_CORE_BACK)
		end
		timerTentacleStrike:Start(DBM_CORE_BACK)
	--Backup for the like 8 languages dbm doesn't have translators for
	elseif msg:find("inv_misc_monsterhorn_03") then
		if self:IsMythic() then
			warnTentacleStrike:Show(DBM_CORE_UNKNOWN)
			if self:AntiSpam(12, 4) then
				specWarnTentacleStrike:Show(L.multiple)
			end
		else
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
	if spellId == 228088 then--Taint of Sea
		if self:IsEasy() then--Cast MORE OFTEN in LFR
			if self.vb.phase == 3 then
				timerTaintOfSeaCD:Start(27)
			else
				timerTaintOfSeaCD:Start(12.1)
			end
		else
			if self.vb.phase == 3 then
				timerTaintOfSeaCD:Start(22)
			else
				timerTaintOfSeaCD:Start()
			end
		end
	elseif spellId == 228372 then--Mists of Helheim (Phase 2)
		self.vb.phase = 2
		timerTentacleStrikeCD:Stop()
		timerBilewaterBreathCD:Stop()
		timerOrbOfCorruptionCD:Stop()
		countdownOrbs:Cancel()
		--timerGrimeLordCD:Start(14)
		--timerNightWatchCD:Start(14)
		timerAddsCD:Start(14)
	elseif spellId == 228546 and not self.vb.phase == 3 then--Helya (Phase 3, 6 seconds slower than yell)
		self.vb.phase = 3
		timerFuryofMawCD:Stop()
		--timerGrimeLordCD:Stop()
		--timerNightWatchCD:Stop()
		timerOrbOfCorrosionCD:Start(11)
		countdownOrbs:Start(11)
		if self:IsEasy() then
			timerCorruptedBreathCD:Start(40)
			timerFuryofMawCD:Start(90)
			timerAddsCD:Start(97)
		else
			timerCorruptedBreathCD:Start(19.4)
			timerFuryofMawCD:Start(30)
			timerAddsCD:Start(38)
		end
	end
end

function mod:OnSync(msg)
	if not self:IsInCombat() then return end
	if msg == "Phase3" and not self.vb.phase == 3 then
		self.vb.phase = 3
		timerFuryofMawCD:Stop()
		--timerGrimeLordCD:Stop()
		--timerNightWatchCD:Stop()
		timerOrbOfCorrosionCD:Start(17)
		countdownOrbs:Start(17)
		if self:IsEasy() then--Still long?
			timerCorruptedBreathCD:Start(46)
			timerFuryofMawCD:Start(96)
			timerAddsCD:Start(103)
		else
			timerCorruptedBreathCD:Start(25.4)
			timerFuryofMawCD:Start(36)
			timerAddsCD:Start(44)
		end
	elseif msg == "Adds" then
		if self.vb.phase == 2 then
			timerAddsCD:Start(75.5)
		else
			timerAddsCD:Start(92)
		end
	end
end
