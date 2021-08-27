local mod	= DBM:NewMod(2440, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175559)
mod:SetEncounterID(2422)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetBossHPInfoToHighest()--Boss heals at least twice
mod.noBossDeathKill = true--Instructs mod to ignore 175559 deaths, since it dies multiple times
mod:SetHotfixNoticeRev(20210815000000)
mod:SetMinSyncRevision(20210815000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 348071 348428 346459 352999 347291 352997 348756 353000 352293 349799 355127 352379 355055 352355 352348 354198 358999",
	"SPELL_CAST_SUCCESS 181113",
	"SPELL_SUMMON 352096 352094 352092 346469",
	"SPELL_AURA_APPLIED 352530 348978 347292 347518 347454 355948 353808 348760 352051 355389 348787",
	"SPELL_AURA_APPLIED_DOSE 352051",
	"SPELL_AURA_REMOVED 354198 348978 347292 355948 353808 348760 355389 348787",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
)

--TODO, track https://ptr.wowhead.com/spell=354289/necrotic-miasma on infoframe?
--TODO, figure out how to add https://ptr.wowhead.com/spell=354638/deep-freeze
--TODO, echo timer can probably be immproved by checking mana when it is cast
--TODO, nameplate aura that shows X or ✔️ over nameplate when it's ok to kill
--https://ptr.wowhead.com/spell=348434/soul-exhaustion used in LFR/normal instead of other one?
--[[
(ability.id = 348071 or ability.id = 346459 or ability.id = 352999 or ability.id = 347291 or ability.id = 352997 or ability.id = 348756 or ability.id = 353000 or ability.id = 352293 or ability.id = 352379 or ability.id = 355055 or ability.id = 352355 or ability.id = 352348 or ability.id = 354198 or ability.id = 358999) and type = "begincast"
 or ability.id = 352530 or ability.id = 352051 or ability.id = 181113
 or (ability.id = 352096 or ability.id = 352094 or ability.id = 352092) and type = "summon"
 or target.id = 176929 and type = "death"
 or (ability.id = 349799 or ability.id = 348428) and type = "begincast"
--]]
--Stage One: Chains and Ice
local warnNecroticSurge								= mod:NewCountAnnounce(352051, 3)
local warnSoulExhaustion							= mod:NewTargetNoFilterAnnounce(348978, 2, nil, "Tank|Healer")
local warnGlacialWrath								= mod:NewTargetNoFilterAnnounce(353808, 3)
local warnPiercingWail								= mod:NewCastAnnounce(348428, 2)
local warnOblivionsEcho								= mod:NewTargetNoFilterAnnounce(347292, 2)
local warnFrostBlast								= mod:NewTargetNoFilterAnnounce(348756, 4)
--Stage Two: The Phylactery Opens
local warnFrostboundDevoted							= mod:NewSpellAnnounce("ej23781", 2, 352096, false)
local warnSoulReaver								= mod:NewSpellAnnounce("ej23423", 2, 352094)
local warnAbom										= mod:NewSpellAnnounce("ej23424", 2, 352092)
local warnDemolish									= mod:NewCastAnnounce(349799, 2)
----Remnant of Kel'Thuzad
local warnFreezingBlast								= mod:NewCountAnnounce(352379, 3)
--Stage Three
local warnOnslaughtoftheDamned						= mod:NewSpellAnnounce(352348, 2)

--Stage One: Chains and Ice
local specWarnSoulExhaustion						= mod:NewSpecialWarningYou(348978, nil, nil, nil, 1, 2)
local specWarnSoulExhaustionSwap					= mod:NewSpecialWarningTaunt(348978, nil, nil, nil, 1, 2)
local specWarnHowlingBlizzard						= mod:NewSpecialWarningDodge(354198, nil, nil, nil, 2, 2)
local specWarnDarkEvocation							= mod:NewSpecialWarningSpell(352530, nil, nil, nil, 2, 2)
local specWarnCorpseDetonation						= mod:NewSpecialWarningRun(355389, nil, nil, nil, 4, 2)
local specWarnSoulFracture							= mod:NewSpecialWarningDefensive(348071, nil, nil, nil, 1, 2)
local specWarnGlacialWrathYou						= mod:NewSpecialWarningYouPos(353808, nil, nil, nil, 1, 2)
local yellGlacialWrath								= mod:NewShortPosYell(353808)
local yellGlacialWrathFades							= mod:NewIconFadesYell(353808)
local specWarnOblivionsEcho							= mod:NewSpecialWarningMoveAway(347292, nil, nil, nil, 1, 2)
local yellOblivionsEcho								= mod:NewShortYell(347292)
local specWarnOblivionsEchoNear						= mod:NewSpecialWarningMove(347518, nil, nil, nil, 1, 2)
local specWarnFrostBlast							= mod:NewSpecialWarningMoveTo(348756, nil, nil, nil, 1, 2)
local yellFrostBlast								= mod:NewYell(348756, nil, nil, nil, "YELL")
local yellFrostBlastFades							= mod:NewShortFadesYell(348756, nil, nil, nil, "YELL")
--Stage Two: The Phylactery Opens
----Remnant of Kel'Thuzad
local specWarnFoulWinds								= mod:NewSpecialWarningSpell(355127, nil, nil, nil, 2, 2, 4)
local specWarnFreezingBlast							= mod:NewSpecialWarningDodge(352379, nil, nil, nil, 2, 2)
local specWarnGlacialWinds							= mod:NewSpecialWarningDodge(355055, nil, nil, nil, 2, 2)
local specWarnUndyingWrath							= mod:NewSpecialWarningRun(352355, nil, nil, nil, 4, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
--Stage One: Chains and Ice
local timerHowlingBlizzardCD						= mod:NewCDTimer(114.3, 354198, nil, nil, nil, 2)--Boss Mana timer
local timerHowlingBlizzard							= mod:NewBuffActiveTimer(23, 354198, nil, nil, nil, 5)
local timerDarkEvocationCD							= mod:NewCDTimer(86.2, 352530, nil, nil, nil, 3)--Boss Mana timer
local timerSoulFractureCD							= mod:NewCDTimer(32.8, 348071, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerSoulExaustion							= mod:NewTargetTimer(60, 348978, nil, "Tank|Healer", nil, 5)
local timerGlacialWrathCD							= mod:NewCDTimer(109.9, 346459, nil, nil, nil, 3, nil, DBM_CORE_L.DAMAGE_ICON)
local timerOblivionsEchoCD							= mod:NewCDTimer(37, 347291, nil, nil, nil, 3)--37-60, 48.6 is the good median but it truly depends on dps
local timerFrostBlastCD								= mod:NewCDTimer(40.1, 348756, nil, nil, nil, 3, nil, DBM_CORE_L.MAGIC_ICON)
--Stage Two: The Phylactery Opens
local timerVengefulDestruction						= mod:NewCastTimer(23, 352293, nil, nil, nil, 6)
----Remnant of Kel'Thuzad
local timerFoulWindsCD								= mod:NewCDTimer(12.1, 355127, nil, nil, nil, 2, nil, DBM_CORE_L.MYTHIC_ICON)
local timerFreezingBlastCD							= mod:NewNextCountTimer(4.9, 352379, nil, nil, nil, 3)
local timerGlacialWindsCD							= mod:NewNextTimer(13.3, 352379, nil, nil, nil, 3)
--Stage Three
local timerOnslaughtoftheDamnedCD					= mod:NewNextTimer(40.2, 352348, nil, nil, nil, 1)
--local berserkTimer								= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(354206, true)
mod:AddSetIconOption("SetIconOnGlacialWrath", 353808, false, false, {1, 2, 3, 4})--Sets icons on players (can be used with spike marking)
mod:AddSetIconOption("SetIconOnGlacialSpike", "ej23449", true, true, {1, 2, 3, 4})--Sets icons on spikes spawned by players (can be used with player market)
mod:AddSetIconOption("SetIconOnEcho", 347291, false, false, {1, 2, 3, 4})--Off by default since it conflicts with wrath icons
mod:AddSetIconOption("SetIconOnReaper", "ej23423", true, true, {6, 7, 8})--Shares icons with Shards, but rarely at same time
mod:AddSetIconOption("SetIconOnShards", "ej23224", true, true, {4, 5, 6, 7, 8})--5 shards mythic (shares icons with reaper but rarely at same time)
mod:AddNamePlateOption("NPAuraOnNecroticEmpowerment", 355948)
mod:AddNamePlateOption("NPAuraOnFixate", 355389)

mod.vb.echoIcon = 1
mod.vb.wrathIcon = 1
mod.vb.spikeIcon = 1
mod.vb.addIcon = 8
mod.vb.shardIcon = 8
mod.vb.frostBlastCount = 0
mod.vb.freezingBlastCount = 0
mod.vb.oblivionEchoCast = 0
local playerPhased = false

function mod:OnCombatStart(delay)
	self.vb.echoIcon = 1
	self.vb.wrathIcon = 1
	self.vb.spikeIcon = 1
	self.vb.addIcon = 8
	self.vb.shardIcon = 8
	self:SetStage(1)
	self.vb.frostBlastCount = 0
	self.vb.freezingBlastCount = 0
	self.vb.oblivionEchoCast = 0
	playerPhased = false
	if self:IsLFR() then--Special snowflake
		timerSoulFractureCD:Start(5.6-delay)
		timerOblivionsEchoCD:Start(9.3-delay)
		timerGlacialWrathCD:Start(19-delay)
		timerFrostBlastCD:Start(42.1-delay)
		timerHowlingBlizzardCD:Start(85.8-delay)
	else
		timerSoulFractureCD:Start(10.6-delay)--10.6-13.7
		timerOblivionsEchoCD:Start(14.3-delay)--14-18.3
		timerGlacialWrathCD:Start(24-delay)
		timerFrostBlastCD:Start(45-delay)--45.3-49
		timerDarkEvocationCD:Start(49-delay)--49-53
		timerHowlingBlizzardCD:Start(89-delay)--89-94.
	end
--	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_L.INFOFRAME_POWER)
		DBM.InfoFrame:Show(3, "enemypower", 2)
	end
	if self.Options.NPAuraOnNecroticEmpowerment or self.Options.NPAuraOnFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnNecroticEmpowerment or self.Options.NPAuraOnFixate then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 348071 then
		self.vb.shardIcon = 8
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnSoulFracture:Show()
			specWarnSoulFracture:Play("carefly")
		end
		timerSoulFractureCD:Start()
	elseif spellId == 348428 and self:AntiSpam(3, 1) then
		warnPiercingWail:Show()
	elseif spellId == 352999 or spellId == 346459 then--346459 confirmed heroic/heroic, 352999 unknown
		self.vb.wrathIcon = 1
		self.vb.spikeIcon = 1
		timerGlacialWrathCD:Start()
	elseif spellId == 347291 or spellId == 352997 then--347291 confirmed heroic,
		self.vb.oblivionEchoCast = self.vb.oblivionEchoCast + 1
		self.vb.echoIcon = 1
		timerOblivionsEchoCD:Start(self.vb.oblivionEchoCast == 1 and 61.1 or 37)--Still possibly not best way to code it
	elseif spellId == 348756 or spellId == 353000 or spellId == 358999 then--348756 P1 358999 P2, 353000 unknown
		self.vb.frostBlastCount = self.vb.frostBlastCount + 1
		timerFrostBlastCD:Start(self.vb.phase == 3 and (self:IsLFR() and 28.4 or 13.4) or self.vb.frostBlastCount % 2 == 0 and 69.1 or 40.1)
	elseif spellId == 352293 then--Vengeful Destruction
		--Stop KT timers
		self:SetStage(2)
		self.vb.addIcon = 8
		self.vb.shardIcon = 8
		self.vb.frostBlastCount = 0
		self.vb.freezingBlastCount = 0
		self.vb.oblivionEchoCast = 0
		timerHowlingBlizzardCD:Stop()
		timerDarkEvocationCD:Stop()
		timerSoulFractureCD:Stop()
		timerGlacialWrathCD:Stop()
		timerOblivionsEchoCD:Stop()
		timerFrostBlastCD:Stop()
		--Start KTs destruction cast timer
		timerVengefulDestruction:Start()
		--Start Remnant timers (may not start here but when he's actually engaged/attacked after entering zone
		timerFreezingBlastCD:Start(6.8, 1)
		if self:IsMythic() then
			timerFoulWindsCD:Start(6.1)
		end
	elseif spellId == 349799 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			warnDemolish:Show()
		end
	elseif spellId == 355127 then
		if playerPhased then
			specWarnFoulWinds:Show()
			specWarnFoulWinds:Play("keepmove")
		end
		timerFoulWindsCD:Start()
	elseif spellId == 352379 then
		self.vb.freezingBlastCount = self.vb.freezingBlastCount + 1
		if not playerPhased and self.vb.freezingBlastCount == 1 then
			specWarnFreezingBlast:Show()
			specWarnFreezingBlast:Play("shockwave")
		else
			warnFreezingBlast:Show(self.vb.freezingBlastCount)
		end
		timerFreezingBlastCD:Start(4.9, self.vb.freezingBlastCount+1)
	elseif spellId == 355055 then
		if playerPhased then
			specWarnGlacialWinds:Show()
			specWarnGlacialWinds:Play("watchstep")
		end
		timerGlacialWindsCD:Start()
	elseif spellId == 352355 then
		if playerPhased then
			specWarnUndyingWrath:Show()
			specWarnUndyingWrath:Play("justrun")
		end
		--Stop Remnant timers (may not stop here)
		timerFreezingBlastCD:Stop()
		timerFoulWindsCD:Stop()
		timerGlacialWindsCD:Stop()
	elseif spellId == 352348 then--Onsalught of the Damned
		warnOnslaughtoftheDamned:Show()
		timerOnslaughtoftheDamnedCD:Start()
	elseif spellId == 354198 then
		if not playerPhased then
			specWarnHowlingBlizzard:Show()
			specWarnHowlingBlizzard:Play("watchstep")
		end
		timerHowlingBlizzardCD:Start()
		timerHowlingBlizzard:Start()--20+3
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 181113 then--Encounter Spawn
		if self.Options.SetIconOnShards then
			self:ScanForMobs(args.sourceGUID, 2, self.vb.shardIcon, 1, 0.2, 12, "SetIconOnShards", nil, nil, nil, true)
		end
		self.vb.spikeIcon = self.vb.shardIcon - 1
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	--https://ptr.wowhead.com/npc=176703/frostbound-devoted / https://ptr.wowhead.com/npc=176974/soul-reaver / https://ptr.wowhead.com/npc=176973/unstoppable-abomination
	if spellId == 352096 or spellId == 352094 or spellId == 352092 then
		if spellId == 352096 and self:AntiSpam(3, 3) then
			warnFrostboundDevoted:Show()
		elseif spellId == 352094 then
			if self:AntiSpam(3, 4) then
				warnSoulReaver:Show()
			end
			if self.Options.SetIconOnReaper then
				self:ScanForMobs(args.destGUID, 2, self.vb.addIcon, 1, 0.2, 12, "SetIconOnReaper", nil, nil, nil, true)
			end
			self.vb.addIcon = self.vb.addIcon - 1
		elseif spellId == 352092 and self:AntiSpam(3, 5) then
			warnAbom:Show()
		end
	elseif spellId == 346469 then--Glacial Spikes
		if self.Options.SetIconOnGlacialSpike then
			self:ScanForMobs(args.destGUID, 2, self.vb.spikeIcon, 1, 0.2, 12, "SetIconOnGlacialSpike", nil, nil, nil, true)
		end
		self.vb.spikeIcon = self.vb.spikeIcon + 1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 352530 then
		specWarnDarkEvocation:Show()
		specWarnDarkEvocation:Play("specialsoon")
		timerDarkEvocationCD:Start()
	elseif spellId == 348978 then
		if args:IsPlayer() then
			specWarnSoulExhaustion:Show()
			specWarnSoulExhaustion:Play("targetyou")
		else
			if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
				specWarnSoulExhaustionSwap:Show(args.destName)
				specWarnSoulExhaustionSwap:Play("tauntboss")
			else
				warnSoulExhaustion:Show(args.destName)
			end
		end
		timerSoulExaustion:Start(args.destName)
	elseif spellId == 347292 then--Actual target of Echo, causing the silence field
		local icon = self.vb.echoIcon
		if self.Options.SetIconOnEcho then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnOblivionsEcho:Show()
			specWarnOblivionsEcho:Play("runout")
			yellOblivionsEcho:Yell(icon, icon)
		end
		warnOblivionsEcho:CombinedShow(0.3, args.destName)
		self.vb.echoIcon = self.vb.echoIcon + 1
	elseif (spellId == 347518 or spellId == 347454) and args:IsPlayer() and not DBM:UnitDebuff("player", 347292) and self:AntiSpam(3, 6) then--Walked into someone elses silence field
		specWarnOblivionsEchoNear:Show()
		specWarnOblivionsEchoNear:Play("runaway")
	elseif spellId == 355948 then
		if self.Options.NPAuraOnNecroticEmpowerment then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 353808 then
		local icon = self.vb.wrathIcon
		--Mark the players first
		if self.Options.SetIconOnGlacialWrath then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnGlacialWrathYou:Show(self:IconNumToTexture(icon))
			specWarnGlacialWrathYou:Play("mm"..icon)
			yellGlacialWrath:Yell(icon, icon)
			yellGlacialWrathFades:Countdown(spellId, nil, icon)
		end
		warnGlacialWrath:CombinedShow(0.5, args.destName)
		self.vb.wrathIcon = self.vb.wrathIcon + 1
		if self.vb.wrathIcon > 8 then
			self.vb.wrathIcon = 1
			DBM:AddMsg("Cast event for Glacial Wrath is wrong, doing backup icon reset")
		end
	elseif spellId == 348760 then--and self:AntiSpam(5, args.destName)
		if args:IsPlayer() then
			specWarnFrostBlast:Show(DBM_CORE_L.ALLIES)
			specWarnFrostBlast:Play("gathershare")
			yellFrostBlast:Yell()
			yellFrostBlastFades:Countdown(spellId)
		else
			warnFrostBlast:Show(args.destName)
		end
	elseif spellId == 352051 then--Necrotic Surge
		if self.vb.phase == 2 then
			self:SetStage(1)
			warnNecroticSurge:Show(args.amount or 1)
			if self:IsLFR() then--Only difficulty the timers differ (no dark evo)
				timerSoulFractureCD:Start(5.2)
				timerOblivionsEchoCD:Start(10.1)
				timerGlacialWrathCD:Start(19.1)
				timerFrostBlastCD:Start(41.6)
				timerHowlingBlizzardCD:Start(86.5)
			else
				timerSoulFractureCD:Start(10.2)
				timerOblivionsEchoCD:Start(14.1)--14.1-15.1.
				timerGlacialWrathCD:Start(24.9)--24.9-25.1. Is 24.9 the new low?
				timerFrostBlastCD:Start(47.1)--47-48.5
				timerDarkEvocationCD:Start(50.6)--50-52.3
				timerHowlingBlizzardCD:Start(91.9)
			end
		end
	elseif spellId == 355389 then
		if args:IsPlayer() then
			specWarnCorpseDetonation:Show()
			specWarnCorpseDetonation:Play("justrun")
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 348787 and args:IsPlayer() then--Phylactery
		playerPhased = true
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 354198 then
		timerHowlingBlizzard:Stop()
	elseif spellId == 347292 then
		if self.Options.SetIconOnEcho then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 355948 then
		if self.Options.NPAuraOnNecroticEmpowerment then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 353808 then
		if self.Options.SetIconOnGlacialWrath then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 348760 then
		if args:IsPlayer() then
			yellFrostBlastFades:Cancel()
		end
	elseif spellId == 355389 then
		if args:IsPlayer() then
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 348787 and args:IsPlayer() then--Phylactery
		playerPhased = false
	elseif spellId == 348978 then
		timerSoulExaustion:Stop(args.destName)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 176929 then--remnant-of-kelthuzad
		self:SetStage(3)
		timerFreezingBlastCD:Stop()
		timerFoulWindsCD:Stop()
		timerGlacialWindsCD:Stop()
--		self:UnregisterShortTermEvents()
		--Stop P2 stuff that may have carried over
		timerHowlingBlizzardCD:Stop()
		timerDarkEvocationCD:Stop()
		timerSoulFractureCD:Stop()
		timerGlacialWrathCD:Stop()
		timerOblivionsEchoCD:Stop()
		timerFrostBlastCD:Stop()
		timerFrostBlastCD:Start(8.5)
		if not self:IsLFR() then--LFR get continued march of forsaken adds instead
			timerOnslaughtoftheDamnedCD:Start(45.1)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]
