local mod	= DBM:NewMod(2335, "DBM-ZuldazarRaid", 2, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(145616)--145644 Bwonsamdi
mod:SetEncounterID(2272)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 8)
--mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 284831 284933 284686 283504 287116 287333 286695 286742",
	"SPELL_CAST_SUCCESS 284662 284781 288449 285347 285172",
	"SPELL_SUMMON 285003 285402",
	"SPELL_AURA_APPLIED 284831 285195 284662 284781 285349 288415 288449 284446 289162 286779 284455",
	"SPELL_AURA_APPLIED_DOSE 285195",
	"SPELL_AURA_REMOVED 284831 285195 288449 289162 286779 284276 284455",
	"SPELL_AURA_REMOVED_DOSE 285195",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 284831 or ability.id = 284933 or ability.id = 284686 or ability.id = 283504 or ability.id = 287116 or ability.id = 287333 or ability.id = 286695 or ability.id = 286742) and type = "begincast"
 or (ability.id = 284662 or ability.id = 284781 or ability.id = 288449 or ability.id = 285172) and type = "cast"
 or ability.id = 285347 and type = "cast" and source.id = 145616
 or (ability.id = 285003 or ability.id = 285402) and type = "summon"
 or (ability.id = 284276 or ability.id = 284446) and (type = "applybuff" or type = "removebuff")
--]]
--TODO, is serpent totem a kill target or a reposition raid one in most strats?
--TODO, detect voodoo doll targets? wasn't even used on heroic test (at least in phases 1-3)
--TODO, dread reaping fix?
--TODO, timers and bigger warnings for Seal of Bwonsamdi?
--TODO, shadow smash a tank swap?
--TODO, more add timers in general if verifying certain casts are long enough CD
--TODO, Stage Four: Uncontrollable Power?
--TODO, 286772 now returns invalid spellID on live?
--General
local warnPhase							= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Stage One: Zandalari Honor Guard
----Prelate Za'lan
local warnSealofPurification			= mod:NewTargetAnnounce(284662, 2)
----Siegebreaker Roka
local warnMeteorLeap					= mod:NewTargetNoFilterAnnounce(284686, 2)
----Headhunter Gal'wana
local warnGrieviousAxe					= mod:NewTargetNoFilterAnnounce(284781, 2, nil, "Healer")
--Stage Two: Bwonsamdi's Pact
local warnVoodooDoll					= mod:NewSpellAnnounce(285402, 3)
local warnScorchingDetonation			= mod:NewCastAnnounce(284831, 2, nil, false)
----Bwonsamdi
local warnDeathsDoor					= mod:NewTargetNoFilterAnnounce(288449, 2)
--Stage Three: Enter the Death Realm
local warnDreadreaping					= mod:NewSpellAnnounce(287116, 3)
local warnInevitableEnd					= mod:NewSpellAnnounce(287333, 3)
local warnZombieTotem					= mod:NewSpellAnnounce(285003, 2)
----Spirits
local warnSealofBwonsamdi				= mod:NewSpellAnnounce(286695, 3)
local warnShadowSmash					= mod:NewCastAnnounce(286742, 3)

--Stage One: Zandalari Honor Guard
local specWarnScorchingDetonation		= mod:NewSpecialWarningMoveAway(284831, nil, nil, nil, 3, 2)
local yellScorchingDetonation			= mod:NewYell(284831)
local yellScorchingDetonationFades		= mod:NewFadesYell(284831)
local specWarnScorchingDetonationOther	= mod:NewSpecialWarningTaunt(284831, nil, nil, nil, 1, 2)
local specWarnPlagueofToads				= mod:NewSpecialWarningDodge(284933, nil, nil, nil, 2, 2)
local specWarnSerpTotem					= mod:NewSpecialWarningSwitch(285172, "Ranged", nil, 2, 1, 2)
local specWarnSerpTotemDodge			= mod:NewSpecialWarningRun(285172, "Melee", nil, 2, 4, 2)
----Prelate Za'lan
local specWarnSealofPurification		= mod:NewSpecialWarningRun(284662, nil, nil, nil, 4, 2)
local yellSealofPurification			= mod:NewYell(284662)
----Siegebreaker Roka
local specWarnMeteorLeap				= mod:NewSpecialWarningMoveTo(284686, nil, nil, nil, 1, 2)
local yellMeteorLeap					= mod:NewYell(284686)
local yellMeteorLeapFades				= mod:NewShortFadesYell(284686)
----Headhunter Gal'wana
local specWarnGrievousAxe				= mod:NewSpecialWarningDefensive(284781, false, nil, nil, 1, 2)
--Stage Two: Bwonsamdi's Pact
local specWarnPlagueofFire				= mod:NewSpecialWarningMoveAway(285349, nil, nil, nil, 1, 2)
local yellPlagueofFire					= mod:NewYell(285349)
local specWarnZombieDustTotem			= mod:NewSpecialWarningSwitch(285003, "Dps", nil, nil, 1, 2)
----Bwonsamdi
local specWarnCaressofDeath				= mod:NewSpecialWarningDefensive(288415, nil, nil, nil, 1, 2)
local specWarnCaressofDeathOther		= mod:NewSpecialWarningTaunt(288415, false, nil, 2, 1, 2)
local specWarnSufferingSpirits			= mod:NewSpecialWarningCount(283504, nil, nil, nil, 2, 2)
local specWarnDeathsDoor				= mod:NewSpecialWarningMoveAway(288449, nil, nil, nil, 3, 2)
local yellDeathsDoor					= mod:NewYell(288449)
local yellDeathsDoorFades				= mod:NewFadesYell(288449)
--Stage Three: Enter the Death Realm
local specWarnInevitableEnd				= mod:NewSpecialWarningRun(287333, nil, nil, nil, 4, 2)
----Spirits
local specWarnShadowSmash				= mod:NewSpecialWarningDefensive(286742, nil, nil, nil, 1, 2)
local specWarnShadowSmashOther			= mod:NewSpecialWarningTaunt(286742, nil, nil, nil, 1, 2)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(286772, nil, nil, nil, 1, 8)
local specWarnFocusedDimise				= mod:NewSpecialWarningInterrupt(286779, nil, nil, nil, 1, 2)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
--Stage One: Zandalari Honor Guard
local timerScorchingDetonationCD		= mod:NewCDTimer(23.1, 284831, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerPlagueofToadsCD				= mod:NewCDTimer(21.1, 284933, nil, nil, nil, 1)
local timerSerpentTotemCD				= mod:NewCDTimer(31.6, 285172, nil, nil, nil, 1)
----Prelate Za'lan
local timerSealofPurificationCD			= mod:NewCDTimer(25.4, 284662, nil, nil, nil, 3)
----Siegebreaker Roka
local timerMeteorLeapCD					= mod:NewCDTimer(33.3, 284686, nil, nil, nil, 3)
----Headhunter Gal'wana
local timerGrievousAxeCD				= mod:NewCDTimer(17.1, 284781, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON)
--Stage Two: Bwonsamdi's Pact
local timerPlagueofFireCD				= mod:NewCDTimer(23, 285347, nil, nil, nil, 3)
local timerZombieDustTotemCD			= mod:NewCDTimer(44.9, 285003, nil, nil, nil, 1)
local timerVoodooDollCD					= mod:NewAITimer(14.1, 285402, nil, nil, nil, 1)
----Bwonsamdi
local timerSufferingSpiritsCD			= mod:NewAITimer(14.1, 283504, nil, nil, nil, 2)
local timerDeathsDoorCD					= mod:NewCDTimer(27.9, 288449, nil, nil, nil, 3)
--Stage Three: Enter the Death Realm
local timerSpiritVortex					= mod:NewCastTimer(5, 284478, nil, nil, nil, 6)
local timerDreadReapingCD				= mod:NewCDTimer(14.1, 287116, nil, nil, nil, 3)
local timerInevitableEndCD				= mod:NewCDTimer(14.1, 287333, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
----Spirits
local timerSealofBwonCD					= mod:NewCDTimer(25.5, 286695, nil, nil, nil, 5)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddSetIconOption("SetIconGift", 255594, true)
mod:AddRangeFrameOption(8, 285349)
mod:AddInfoFrameOption(285195, true)
mod:AddNamePlateOption("NPAuraOnRelentlessness", 289162)
mod:AddNamePlateOption("NPAuraOnFocusedDemise", 286779)
mod:AddBoolOption("AnnounceAlternatePhase", false, "announce")
--mod:AddSetIconOption("SetIconDarkRev", 273365, true)

mod.vb.phase = 1
mod.vb.sufferingSpirits = 0
local playerDeathPhase = false
local infoframeTable = {}

--"<24.26 16:22:52> [CLEU] SPELL_CAST_START#Creature-0-2083-2070-6821-146322-00005225A8#Siegebreaker Roka##nil#284686#Meteor Leap#nil#nil", -- [107]
--"<24.46 16:22:52> [DBM_Announce] Meteor Leap on >Lorn-Benedictus<#236171#target#284686#2335", -- [110]
--"<29.28 16:22:57> [CLEU] SPELL_CAST_SUCCESS#Creature-0-2083-2070-6821-146322-00005225A8#Siegebreaker Roka#Player-3296-000AA073#Lorn-Benedictus#284686#Meteor Leap#nil#nil", -- [133]
function mod:MeteorLeapTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnMeteorLeap:Show(GROUP)
		specWarnMeteorLeap:Play("gathershare")
		yellMeteorLeap:Yell()
		yellMeteorLeapFades:Countdown(4.8)--Target scan takes about 0.2 seconds
	elseif not self:IsTank() then
		specWarnMeteorLeap:Show(targetname)
		specWarnMeteorLeap:Play("gathershare")
	else
		warnMeteorLeap:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.sufferingSpirits = 0
	playerDeathPhase = false
	table.wipe(infoframeTable)
	if not self:IsLFR() then
		timerSealofPurificationCD:Start(9.7-delay)
	end
	if self:IsHard() then
		timerGrievousAxeCD:Start(8.2-delay)
	end
	timerMeteorLeapCD:Start(15.4-delay)
	timerScorchingDetonationCD:Start(25.3-delay)
	timerPlagueofToadsCD:Start(20.4-delay)
	timerSerpentTotemCD:Start(30.2-delay)
	if self.Options.NPAuraOnRelentlessness or self.Options.NPAuraOnFocusedDemise then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnRelentlessness or self.Options.NPAuraOnFocusedDemise then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:OnTimerRecovery()
	if DBM:UnitDebuff("player", 284455) then
		playerDeathPhase = true
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 284831 then
		if self.vb.phase >= 3 then
			timerScorchingDetonationCD:Start(32.8)
			if self:LatencyCheck() then
				self:SendSync("ScorchingDetonation")
			end
		elseif self.vb.phase == 2 then
			timerScorchingDetonationCD:Start(32.8)
		else--Phase 1
			timerScorchingDetonationCD:Start(23.1)
		end
	elseif spellId == 284933 then
		specWarnPlagueofToads:Show()
		specWarnPlagueofToads:Play("watchstep")
		if self.vb.phase == 1 then
			timerPlagueofToadsCD:Start(21.1)
		else
			timerPlagueofToadsCD:Start(60)
		end
	elseif spellId == 284686 then
		timerMeteorLeapCD:Start()
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "MeteorLeapTarget", 0.1, 8, true, nil, nil, nil, true)
	elseif spellId == 283504 then
		self.vb.sufferingSpirits = self.vb.sufferingSpirits + 1
		specWarnSufferingSpirits:Show(self.vb.sufferingSpirits)
		specWarnSufferingSpirits:Play("aesoon")
		timerSufferingSpiritsCD:Start()
	elseif spellId == 287116 and self:AntiSpam(5, 1) then
		warnDreadreaping:Show()
		--timerDreadReapingCD:Start()
		if self:LatencyCheck() then
			self:SendSync("DreadReaping")
		end
	elseif spellId == 287333 then
		specWarnInevitableEnd:Show()
		specWarnInevitableEnd:Play("justrun")
		--timerInevitableEndCD:Start()
		if self:LatencyCheck() then
			self:SendSync("InevitableEnd")
		end
	elseif spellId == 286695 and self:AntiSpam(5, 2) then
		warnSealofBwonsamdi:Show()
		timerSealofBwonCD:Start()
	elseif spellId == 286742 then
		warnShadowSmash:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 284662 then
		timerSealofPurificationCD:Start()
	elseif spellId == 284781 then
		timerGrievousAxeCD:Start()
	elseif spellId == 288449 then
		timerDeathsDoorCD:Start()
		if self.vb.phase >= 3 then
			if self:LatencyCheck() then
				self:SendSync("DeathsDoor")--used by rastakhan in P3
			end
		end
	elseif spellId == 285347 and self:AntiSpam(3, 3) and args:GetSrcCreatureID() == 145616 then--Plague of Fire
		timerPlagueofFireCD:Start()
	elseif spellId == 285172 then
		if self.Options.SpecWarn285172switch then
			specWarnSerpTotem:Show()
			specWarnSerpTotem:Play("attacktotem")
		else
			specWarnSerpTotemDodge:Show()
			specWarnSerpTotemDodge:Play("justrun")
		end
		timerSerpentTotemCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 285003 then
		specWarnZombieDustTotem:Show()
		specWarnZombieDustTotem:Play("attacktotem")
		timerZombieDustTotemCD:Start()
		if self.vb.phase >= 3 then
			if self:LatencyCheck() then
				self:SendSync("ZombieTotem")
			end
		end
	elseif spellId == 285402 then
		warnVoodooDoll:Show()
		timerVoodooDollCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 284831 then
		if args:IsPlayer() then
			specWarnScorchingDetonation:Show()
			specWarnScorchingDetonation:Play("runout")
			yellScorchingDetonation:Yell()
			yellScorchingDetonationFades:Countdown(5)
		else
			specWarnScorchingDetonationOther:Show(args.destName)
			specWarnScorchingDetonationOther:Play("tauntboss")
		end
	elseif spellId == 285195 then
		infoframeTable[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(infoframeTable)
		end
	elseif spellId == 284662 then
		if args:IsPlayer() then
			specWarnSealofPurification:Show()
			specWarnSealofPurification:Play("laserrun")
			specWarnSealofPurification:ScheduleVoice(1.5, "keepmove")
			yellSealofPurification:Yell()
		else
			warnSealofPurification:Show(args.destName)
		end
	elseif spellId == 284781 then
		if args:IsPlayer() then
			specWarnGrievousAxe:Show()
			specWarnGrievousAxe:Play("defensive")
		else
			warnGrieviousAxe:Show(args.destName)
		end
	elseif spellId == 285349 then
		if args:IsPlayer() then
			specWarnPlagueofFire:Show()
			specWarnPlagueofFire:Play("runout")
			yellPlagueofFire:Yell()
		end
	elseif spellId == 288415 then
		if args:IsPlayer() then
			specWarnCaressofDeath:Show()
			specWarnCaressofDeath:Play("defensive")
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) and not DBM:UnitDebuff("player", spellId) then
				specWarnCaressofDeathOther:Show(args.destName)
				specWarnCaressofDeathOther:Play("tauntboss")
			end
		end
	elseif spellId == 288449 then
		if args:IsPlayer() then
			specWarnDeathsDoor:Show()
			specWarnDeathsDoor:Play("runout")
			yellDeathsDoor:Yell()
			yellDeathsDoorFades:Countdown(8)
		else
			warnDeathsDoor:Show(args.destName)
		end
		if self.vb.phase >= 3 then
			self:SendSync("DeathsDoorTarget", args.destName)
		end
	elseif spellId == 284446 and self.vb.phase < 3 then--Bwonsamdi's Boon
		self.vb.phase = 3
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		timerScorchingDetonationCD:Stop()
		timerPlagueofFireCD:Stop()
		timerZombieDustTotemCD:Stop()
		timerVoodooDollCD:Stop()
		timerSufferingSpiritsCD:Stop()
		timerDeathsDoorCD:Stop()
		
		--Rasta
		timerSpiritVortex:Start(5)
		--timerZombieDustTotemCD:Start(3)--Not actually used in Stage 3?
		timerDeathsDoorCD:Start(27.5)--SUCCESS
		timerScorchingDetonationCD:Start(32.8)
		timerPlagueofFireCD:Start(40)
		--Bwon
		timerDreadReapingCD:Start(7.6)
		timerInevitableEndCD:Start(35.9)
		timerSealofBwonCD:Start(43)
--		self:RegisterShortTermEvents(
--			"SPELL_PERIODIC_DAMAGE 286772",
--			"SPELL_PERIODIC_MISSED 286772"
--		)
	elseif spellId == 289162 then
		if self.Options.NPAuraOnRelentlessness then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 286742 then
		if args:IsPlayer() then
			specWarnShadowSmash:Show()
			specWarnShadowSmash:Play("defensive")
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) and not DBM:UnitDebuff("player", spellId) then
				specWarnShadowSmashOther:Show(args.destName)
				specWarnShadowSmashOther:Play("changemt")
			end
		end
	elseif spellId == 286779 then
		if args:IsPlayer() then
			specWarnFocusedDimise:Show(args.sourceName)
			specWarnFocusedDimise:Play("kickcast")
			if self.Options.NPAuraOnFocusedDemise then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 5)
			end
		end
	elseif spellId == 284455 and args:IsPlayer() then
		playerDeathPhase = true
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 284831 then
		if args:IsPlayer() then
			yellScorchingDetonationFades:Cancel()
		end
	elseif spellId == 285195 then
		infoframeTable[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(infoframeTable)
		end
	elseif spellId == 288449 then
		if args:IsPlayer() then
			yellDeathsDoorFades:Cancel()
		end
	elseif spellId == 289162 then
		if self.Options.NPAuraOnRelentlessness then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 286779 then
		if self.Options.NPAuraOnFocusedDemise then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 284276 then--Bind Souls (P2 Start)
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		timerPlagueofToadsCD:Stop()
		timerSerpentTotemCD:Stop()
		timerScorchingDetonationCD:Stop()
		
		--Rasta
		timerZombieDustTotemCD:Start(26.3)
		timerScorchingDetonationCD:Start(33.6)
		timerPlagueofFireCD:Start(40.7)
		timerPlagueofToadsCD:Start(61.5)--Seen on mythic, on other difficulties?
		timerSufferingSpiritsCD:Start(2)--Never seen on heroic or mythic
		--Bwon
		timerDeathsDoorCD:Start(64.2)
		timerVoodooDollCD:Start(2)--Never seen on heroic
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(285195))
			DBM.InfoFrame:Show(5, "table", infoframeTable, 1)
		end
	elseif spellId == 284455 and args:IsPlayer() then
		playerDeathPhase = false
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 285195 then
		infoframeTable[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(infoframeTable)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 286772 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 146320 then--Prelate Za'lan
		timerSealofPurificationCD:Stop()
	elseif cid == 146322 then--Siegebreaker Roka
		timerMeteorLeapCD:Stop()
	elseif cid == 146326 then--Headhunter Galwana
		timerGrievousAxeCD:Stop()
	--elseif cid == 146766 then--Greater Serpent Totem
	
	--elseif cid == 146731 then--Zombie Dust Totem
	
	--elseif cid == 146933 then--Voodoo Doll
	
	--elseif cid == 146491 then--phantom-of-retribution
	
	--elseif cid == 146492 then--phantom-of-rage

	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	--if spellId == 285347 then--Plague of Fire
	
	--elseif spellId == 287165 then--King Rastakhan P1 -> P2 Conversation (alternate P2 start

--"<292.22 16:58:46> [UNIT_SPELLCAST_SUCCEEDED] King Rastakhan(??) -Summon Phantom of Retribution- boss1:Cast-3-2083-2070-6821-284540-002A522E86:284540
--"<292.24 16:58:46> [UNIT_SPELLCAST_SUCCEEDED] King Rastakhan(??) -Summon Phantom of Rage- boss1:Cast-3-2083-2070-6821-284542-002C522E86:284542
--"<292.24 16:58:46> [UNIT_SPELLCAST_SUCCEEDED] King Rastakhan(??) -Summon Phantom of Slaughter- boss1:Cast-3-2083-2070-6821-284543-002E522E86:284543
--"<292.24 16:58:46> [UNIT_SPELLCAST_SUCCEEDED] King Rastakhan(??) -Summon Phantom of Ruin- boss1:Cast-3-2083-2070-6821-284544-002FD22E86:284544
	--end
end
--]]

--On sync will always enable timers for both phases, so players changing phases will have working timers
--Announce alternate phase simply enables showing general announces for other phases as well
function mod:OnSync(msg, target)
	if msg == "ScorchingDetonation" then--Rastakhan
		if playerDeathPhase then
			if self.Options.AnnounceAlternatePhase then
				warnScorchingDetonation:Show()
			end
			timerScorchingDetonationCD:Start(32.8)
		end
	elseif msg == "DreadReaping" then--BwonSamdi
		if not playerDeathPhase then
			if self.Options.AnnounceAlternatePhase then
				warnDreadreaping:Show()
			end
			--timerDreadReapingCD:Start()
		end
	elseif msg == "InevitableEnd" then--BwonSamdi
		if not playerDeathPhase then
			if self.Options.AnnounceAlternatePhase then
				warnInevitableEnd:Show()
			end
			--timerInevitableEndCD:Start()
		end
	elseif msg == "DeathsDoor" then--Rastakhan (in p3+, in P2 where we don't sync, bwonsamdi)
		if playerDeathPhase then
			timerDeathsDoorCD:Start()
		end
	elseif msg == "DeathsDoorTarget" then--Rastakhan (in p3+, in P2 where we don't sync, bwonsamdi)
		if playerDeathPhase and self.Options.AnnounceAlternatePhase then
			warnDeathsDoor:Show(target)
		end
	elseif msg == "ZombieTotem" then--Rastakhan
		if playerDeathPhase then
			if self.Options.AnnounceAlternatePhase then
				warnZombieTotem:Show()
			end
			timerZombieDustTotemCD:Start()
		end
	end
end
