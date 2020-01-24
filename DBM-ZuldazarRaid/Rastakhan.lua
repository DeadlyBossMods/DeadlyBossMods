local mod	= DBM:NewMod(2335, "DBM-ZuldazarRaid", 2, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(145616)--145644 Bwonsamdi
mod:SetEncounterID(2272)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 8)
mod:SetHotfixNoticeRev(18336)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 284831 284933 284686 287116 287333 286695 286742",
	"SPELL_CAST_SUCCESS 284662 284781 290955 288449 285347 285172 284521",
	"SPELL_SUMMON 285003 285402",
	"SPELL_AURA_APPLIED 284831 285195 284662 285349 288415 288449 284446 289162 286779 284455 284376",
	"SPELL_AURA_APPLIED_DOSE 285195",
	"SPELL_AURA_REMOVED 284831 285195 288449 289162 286779 284455",
	"SPELL_AURA_REMOVED_DOSE 285195",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 284831 or ability.id = 284933 or ability.id = 284686 or ability.id = 283504 or ability.id = 287116 or ability.id = 287333 or ability.id = 286695 or ability.id = 286742) and type = "begincast"
 or (ability.id = 284662 or ability.id = 284781 or ability.id = 290955 or ability.id = 288449 or ability.id = 285172 or ability.id = 284521 or ability.id = 288415) and type = "cast"
 or ability.id = 285347 and type = "cast" and source.id = 145616
 or (ability.id = 285003 or ability.id = 285402) and type = "summon"
 or (ability.id = 284276 or ability.id = 284446) and (type = "applybuff" or type = "removebuff")
 or ability.id = 288117 and type = "applydebuff"
 or ability.id = 284376 and type = "applydebuff"
--]]
--TODO, is serpent totem a kill target or a reposition raid one in most strats?
--TODO, dread reaping fix?
--TODO, timers and bigger warnings for Seal of Bwonsamdi?
--TODO, Update add timers when they teleport to death realm on mythic?
--TODO, 286772 now returns invalid spellID on live?
--TODO, remove countdown object when countdown code updated to auto disable on .fade events
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
--local warnVoodooDoll					= mod:NewSpellAnnounce(285402, 3)
local warnScorchingDetonation			= mod:NewTargetNoFilterAnnounce(284831, 2)
----Bwonsamdi
local warnDeathsDoor					= mod:NewTargetNoFilterAnnounce(288449, 2)
--Stage Three: Enter the Death Realm
local warnDreadreaping					= mod:NewSpellAnnounce(287116, 3)
local warnInevitableEnd					= mod:NewSpellAnnounce(287333, 3)
local warnZombieTotem					= mod:NewSpellAnnounce(285003, 2)
----Spirits
local warnSealofBwonsamdi				= mod:NewSpellAnnounce(286695, 3)

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
local yellMeteorLeap					= mod:NewYell(284686, nil, nil, nil, "YELL")
local yellMeteorLeapFades				= mod:NewShortFadesYell(284686, nil, nil, nil, "YELL")
----Headhunter Gal'wana
local specWarnGrievousAxe				= mod:NewSpecialWarningDefensive(284781, false, nil, nil, 1, 2)
--Stage Two: Bwonsamdi's Pact
local specWarnPlagueofFire				= mod:NewSpecialWarningMoveAway(285349, nil, nil, nil, 1, 2)
local yellPlagueofFire					= mod:NewYell(285349, 255782)
local specWarnZombieDustTotem			= mod:NewSpecialWarningSwitch(285003, "Dps", nil, nil, 1, 2)
----Bwonsamdi
local specWarnCaressofDeath				= mod:NewSpecialWarningDefensive(288415, nil, nil, nil, 1, 2)
local specWarnCaressofDeathOther		= mod:NewSpecialWarningTaunt(288415, false, nil, 2, 1, 2)
local specWarnDeathsDoor				= mod:NewSpecialWarningMoveAway(288449, nil, nil, nil, 3, 2)
local yellDeathsDoor					= mod:NewYell(288449)
local yellDeathsDoorFades				= mod:NewFadesYell(288449)
--Stage Three: Enter the Death Realm
local specWarnInevitableEnd				= mod:NewSpecialWarningRun(287333, nil, nil, nil, 4, 2)
----Spirits
local specWarnNecroticSmash				= mod:NewSpecialWarningDodge(286742, "Melee", nil, nil, 4, 2)
local specWarnNecroticSmashFuckedUp		= mod:NewSpecialWarningDefensive(286742, nil, nil, nil, 1, 2)--If tank gets hit by it, warn this
local specWarnNecroticSmashOther		= mod:NewSpecialWarningTaunt(286742, nil, nil, nil, 1, 2)--And warn other tank to taunt.
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(286772, nil, nil, nil, 1, 8)
local specWarnFocusedDimise				= mod:NewSpecialWarningInterrupt(286779, nil, nil, nil, 1, 2)

--Stage One: Zandalari Honor Guard
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19172))
local timerScorchingDetonationCD		= mod:NewCDCountTimer(23.1, 284831, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 4)
local timerPlagueofToadsCD				= mod:NewCDTimer(21.1, 284933, nil, nil, nil, 1)
local timerSerpentTotemCD				= mod:NewCDTimer(31.6, 285172, nil, nil, nil, 1)
mod:AddTimerLine(DBM_ADDS)
----Prelate Za'lan
local timerSealofPurificationCD			= mod:NewCDTimer(25.4, 284662, nil, nil, nil, 3)
----Siegebreaker Roka
local timerMeteorLeapCD					= mod:NewCDTimer(33.3, 284686, nil, nil, nil, 3)
----Headhunter Gal'wana
local timerGrievousAxeCD				= mod:NewCDTimer(17.1, 284781, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON)
--Stage Two: Bwonsamdi's Pact
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19242))
local timerPlagueofFireCD				= mod:NewCDTimer(23, 285347, nil, nil, nil, 3)
local timerZombieDustTotemCD			= mod:NewCDTimer(44.9, 285003, nil, nil, nil, 1)
----Bwonsamdi
local timerDeathsDoorCD					= mod:NewCDTimer(27.9, 288449, nil, nil, nil, 3)
--Stage Three: Enter the Death Realm
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19243))
local timerSpiritVortex					= mod:NewCastTimer(5, 284478, nil, nil, nil, 6)
local timerDreadReapingCD				= mod:NewCDTimer(14.1, 287116, nil, nil, nil, 3)
local timerInevitableEndCD				= mod:NewCDCountTimer(62.5, 287333, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON, nil, 1, 5)--62-75?
local timerAddsCD						= mod:NewAddsTimer(120, 284446, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)--Single use at start of Stage 3
----Spirits
mod:AddTimerLine(DBM_ADDS)
local timerSealofBwonCD					= mod:NewCDTimer(25.5, 286695, nil, nil, nil, 5)
local timerNecroticSmashCD				= mod:NewCDTimer(34.6, 286742, nil, nil, nil, 2)

--local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddNamePlateOption("NPAuraOnRelentlessness", 289162)
mod:AddNamePlateOption("NPAuraOnFocusedDemise", 286779)
mod:AddRangeFrameOption(8, 285349)
mod:AddInfoFrameOption(285195, true)
mod:AddBoolOption("AnnounceAlternatePhase", false, "announce")

mod.vb.phase = 1
mod.vb.scorchingDetCount = 0
mod.vb.InevitableEndCount = 0
local playerDeathPhase = false
local infoframeTable = {}

--"<24.26 16:22:52> [CLEU] SPELL_CAST_START#Creature-0-2083-2070-6821-146322-00005225A8#Siegebreaker Roka##nil#284686#Meteor Leap#nil#nil", -- [107]
--"<24.46 16:22:52> [DBM_Announce] Meteor Leap on >Lorn-Benedictus<#236171#target#284686#2335", -- [110]
--"<29.28 16:22:57> [CLEU] SPELL_CAST_SUCCESS#Creature-0-2083-2070-6821-146322-00005225A8#Siegebreaker Roka#Player-3296-000AA073#Lorn-Benedictus#284686#Meteor Leap#nil#nil", -- [133]
function mod:MeteorLeapTarget(targetname, uId, bossuid, scanningTime)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnMeteorLeap:Show(GROUP)
		specWarnMeteorLeap:Play("gathershare")
		yellMeteorLeap:Yell()
		yellMeteorLeapFades:Countdown(5-scanningTime)
	elseif not self:IsTank() then
		specWarnMeteorLeap:Show(targetname)
		specWarnMeteorLeap:Play("gathershare")
	else
		warnMeteorLeap:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.scorchingDetCount = 0
	self.vb.InevitableEndCount = 0
	playerDeathPhase = false
	table.wipe(infoframeTable)
	--Reset Fades
	timerInevitableEndCD:SetFade(false)
	timerDreadReapingCD:SetFade(false)
	timerZombieDustTotemCD:SetFade(false)
	timerScorchingDetonationCD:SetFade(false)
	timerPlagueofFireCD:SetFade(false)
	if not self:IsLFR() then
		timerSealofPurificationCD:Start(8.8-delay)
	end
	if self:IsHard() then
		timerGrievousAxeCD:Start(8.2-delay)
	end
	timerMeteorLeapCD:Start(15.4-delay)
	timerPlagueofToadsCD:Start(20.4-delay)
	timerScorchingDetonationCD:Start(25.3-delay, 1)
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
		--unfade Bwonsamdi timers
		timerInevitableEndCD:SetFade(false, self.vb.InevitableEndCount+1)
		timerDreadReapingCD:SetFade(false)
		--fade rastakhan timers
		timerZombieDustTotemCD:SetFade(true)
		timerScorchingDetonationCD:SetFade(true, self.vb.InevitableEndCount+1)
		timerPlagueofFireCD:SetFade(true)
		if not self:IsMythic() then
			timerNecroticSmashCD:SetFade(true)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 284831 then
		self.vb.scorchingDetCount = self.vb.scorchingDetCount + 1
		if self.vb.phase == 3 then
			timerScorchingDetonationCD:Start(32, self.vb.scorchingDetCount+1)
		elseif self.vb.phase == 4 then
			if self.vb.scorchingDetCount % 2 == 0 then
				timerScorchingDetonationCD:Start(27.8, self.vb.scorchingDetCount+1)
			else
				timerScorchingDetonationCD:Start(34, self.vb.scorchingDetCount+1)
			end
		elseif self.vb.phase == 2 then
			timerScorchingDetonationCD:Start(41.2, self.vb.scorchingDetCount+1)
		else--Phase 1
			timerScorchingDetonationCD:Start(22.7, self.vb.scorchingDetCount+1)
		end
	elseif spellId == 284933 and self:AntiSpam(5, 4) then
		specWarnPlagueofToads:Show()
		specWarnPlagueofToads:Play("watchstep")
		if self.vb.phase == 1 then
			timerPlagueofToadsCD:Start(21.1)
		elseif self.vb.phase == 4 then
			timerPlagueofToadsCD:Start(28.1)
		else--Phase 2
			timerPlagueofToadsCD:Start(59.3)
		end
	elseif spellId == 284686 then
		timerMeteorLeapCD:Start()
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "MeteorLeapTarget", 0.1, 8, true, nil, nil, nil, true)
	elseif spellId == 287116 and self:AntiSpam(5, 1) then
		if not playerDeathPhase then
			if self.Options.AnnounceAlternatePhase then
				warnDreadreaping:Show()
			end
		else
			warnDreadreaping:Show()
		end
		--timerDreadReapingCD:Start()
	elseif spellId == 287333 then
		self.vb.InevitableEndCount = self.vb.InevitableEndCount + 1
		if playerDeathPhase or self.vb.phase == 4 then
			specWarnInevitableEnd:Show()
			specWarnInevitableEnd:Play("justrun")
		else
			if self.Options.AnnounceAlternatePhase then
				warnInevitableEnd:Show()
			end
		end
		if self.vb.phase == 4 then
			timerInevitableEndCD:Start(62.3, self.vb.InevitableEndCount+1)
		else--Stage 3
			timerInevitableEndCD:Start(52.1, self.vb.InevitableEndCount+1)
		end
	elseif spellId == 286695 and self:AntiSpam(5, 2) then
		warnSealofBwonsamdi:Show()
		timerSealofBwonCD:Start()
	elseif spellId == 286742 then
		if self:IsMythic() or not playerDeathPhase then
			specWarnNecroticSmash:Show()
			specWarnNecroticSmash:Play("justrun")
		end
		timerNecroticSmashCD:Start(34.6)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 284662 then
		timerSealofPurificationCD:Start()
	elseif spellId == 284781 or spellId == 290955 then
		if self:AntiSpam(5, 5) then
			timerGrievousAxeCD:Start()
		end
		warnGrieviousAxe:CombinedShow(1.5, args.destName)
		if args:IsPlayer() then
			specWarnGrievousAxe:Show()
			specWarnGrievousAxe:Play("defensive")
		end
	elseif spellId == 288449 then
		if self.vb.phase == 4 then
			timerDeathsDoorCD:Start(37.4)
		else
			timerDeathsDoorCD:Start(27.9)
		end
	elseif spellId == 285347 and self:AntiSpam(3, 3) and args:GetSrcCreatureID() == 145616 then--Plague of Fire
		if self.vb.phase == 3 then
			timerPlagueofFireCD:Start(39)
		else--2 and 4
			timerPlagueofFireCD:Start(23)--23-25
		end
	elseif spellId == 285172 then
		if self.Options.SpecWarn285172switch then
			specWarnSerpTotem:Show()
			specWarnSerpTotem:Play("attacktotem")
		else
			specWarnSerpTotemDodge:Show()
			specWarnSerpTotemDodge:Play("justrun")
		end
		timerSerpentTotemCD:Start()
	elseif spellId == 284521 then--Spirit Expulsion
		playerDeathPhase = false
		self.vb.phase = 4
		self.vb.scorchingDetCount = 0
		self.vb.InevitableEndCount = 0
		--
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(4))
		warnPhase:Play("pfour")
		timerDeathsDoorCD:Stop()
		timerScorchingDetonationCD:Stop()
		timerPlagueofFireCD:Stop()
		timerInevitableEndCD:Stop()
		--unfade everything used in stage 4
		timerInevitableEndCD:SetFade(false)
		timerScorchingDetonationCD:SetFade(false)
		timerPlagueofFireCD:SetFade(false)
		if not self:IsMythic() then
			timerNecroticSmashCD:SetFade(false)
		end
		timerDeathsDoorCD:Start(9.3)
		timerPlagueofToadsCD:Start(15.1)
		timerScorchingDetonationCD:Start(19.2, 1)
		timerPlagueofFireCD:Start(27.3)
		timerInevitableEndCD:Start(28.2, 1)
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 285003 then
		if playerDeathPhase then
			if self.Options.AnnounceAlternatePhase then
				warnZombieTotem:Show()
			end
		else
			specWarnZombieDustTotem:Show()
			specWarnZombieDustTotem:Play("attacktotem")
		end
		timerZombieDustTotemCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 284831 then
		if args:IsPlayer() then
			specWarnScorchingDetonation:Show()
			specWarnScorchingDetonation:Play("runout")
			yellScorchingDetonation:Yell()
			yellScorchingDetonationFades:Countdown(spellId)
		else
			if playerDeathPhase then
				if self.Options.AnnounceAlternatePhase then
					warnScorchingDetonation:Show(args.destName)
				end
			else
				specWarnScorchingDetonationOther:Show(args.destName)
				specWarnScorchingDetonationOther:Play("tauntboss")
			end
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
			yellDeathsDoorFades:Countdown(spellId)
		else
			warnDeathsDoor:Show(args.destName)
		end
	--"<66.15 22:33:35> [CLEU] SPELL_AURA_REMOVED#Vehicle-0-3019-2070-28900-145616-0000493177#King Rastakhan#Vehicle-0-3019-2070-28900-145616-0000493177#King Rastakhan#284276#Bind Souls#BUFF#nil", -- [1068]
	--"<73.39 22:33:42> [CLEU] SPELL_AURA_APPLIED#Vehicle-0-3019-2070-28900-145644-0000493216#Unknown#Pet-0-3019-2070-28900-25867-04035496FD#Apok#284376#Death's Presence#DEBUFF#nil", -- [1197]
	elseif spellId == 284376 and self.vb.phase < 2 then--Bind Souls (P2 Start)
		self.vb.phase = 2
		self.vb.scorchingDetCount = 0
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		timerPlagueofToadsCD:Stop()
		timerSerpentTotemCD:Stop()
		timerScorchingDetonationCD:Stop()

		--Rasta
		timerZombieDustTotemCD:Start(19.2)
		timerScorchingDetonationCD:Start(26.5, 1)
		timerPlagueofFireCD:Start(33.7)--33-35.5
		timerPlagueofToadsCD:Start(39.8)
		--Bwon
		timerDeathsDoorCD:Start(52.8)--52-56
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(285195))
			DBM.InfoFrame:Show(5, "table", infoframeTable, 1)
		end
	elseif spellId == 284446 and self.vb.phase < 3 then--Bwonsamdi's Boon (shouldn't be needed but good to have)
		self.vb.phase = 3
		self.vb.scorchingDetCount = 0
		self.vb.InevitableEndCount = 0
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		timerScorchingDetonationCD:Stop()
		timerPlagueofFireCD:Stop()
		timerZombieDustTotemCD:Stop()
		timerDeathsDoorCD:Stop()
		--Set fade defaults to fade bwonsamdi's timers
		timerInevitableEndCD:SetFade(true)
		timerDreadReapingCD:SetFade(true)
		timerNecroticSmashCD:SetFade(false)
		--Rasta
		timerSpiritVortex:Start(5)
		timerAddsCD:Start(6)
		timerNecroticSmashCD:Start(22.3)
		--timerZombieDustTotemCD:Start(3)--Not actually used in Stage 3?
		timerDeathsDoorCD:Start(27.5)--SUCCESS
		timerScorchingDetonationCD:Start(32.8, 1)
		timerPlagueofFireCD:Start(40)
		--Bwon
		timerDreadReapingCD:Start(7.6)
		timerInevitableEndCD:Start(35.8, 1)--Can be delayed by up to 7.3 seconds for some reason
		--timerSealofBwonCD:Start(39.2)--13.4-87.5 (not reliable, what makes add start casting this?)
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
			specWarnNecroticSmashFuckedUp:Show()
			specWarnNecroticSmashFuckedUp:Play("defensive")
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) and not DBM:UnitDebuff("player", spellId) then
				specWarnNecroticSmashOther:Show(args.destName)
				specWarnNecroticSmashOther:Play("changemt")
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
		--unfade Bwonsamdi timers
		timerInevitableEndCD:SetFade(false, self.vb.InevitableEndCount+1)
		timerDreadReapingCD:SetFade(false)
		--fade rastakhan timers
		timerZombieDustTotemCD:SetFade(true)
		timerScorchingDetonationCD:SetFade(true, self.vb.scorchingDetCount+1)
		timerPlagueofFireCD:SetFade(true)
		if not self:IsMythic() then
			timerNecroticSmashCD:SetFade(true)
		end
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
	elseif spellId == 284455 and args:IsPlayer() then
		playerDeathPhase = false
		--fade Bwonsamdi timers
		if self.vb.phase == 3 then--Only unfaded if we leave death realm in P3, if we're leaving cause it's now P4, don't fade
			timerInevitableEndCD:SetFade(true, self.vb.InevitableEndCount+1)
		end
		timerDreadReapingCD:SetFade(true)
		--unfade rastakhan timers
		timerZombieDustTotemCD:SetFade(false)
		timerScorchingDetonationCD:SetFade(false, self.vb.scorchingDetCount+1)
		timerPlagueofFireCD:SetFade(false)
		if not self:IsMythic() then
			timerNecroticSmashCD:SetFade(false)
		end
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
	--elseif cid == 146491 then--phantom-of-retribution

	elseif cid == 146492 then--phantom-of-rage
		timerNecroticSmashCD:Stop()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	--"<195.03 22:35:44> [UNIT_SPELLCAST_SUCCEEDED] King Rastakhan(Towelliee) -King Rastakhan P2 -> P3 Conversation [DO NOT TRANSLATE]- [[boss1:Cast-3-3019-2070-28900-290801-000C493290:290801]]", -- [3752]
	--"<201.14 22:35:50> [CLEU] SPELL_CAST_SUCCESS#Vehicle-0-3019-2070-28900-145644-0000493216#Bwonsamdi#Vehicle-0-3019-2070-28900-145616-0000493177#King Rastakhan#284446#Bwonsamdi's Boon#nil#nil", -- [3850]
	if spellId == 290801 then--King Rastakhan P2 -> P3 Conversation [DO NOT TRANSLATE] (Only one faster than CLEU)
		self.vb.phase = 3
		self.vb.scorchingDetCount = 0
		self.vb.InevitableEndCount = 0
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		timerScorchingDetonationCD:Stop()
		timerPlagueofFireCD:Stop()
		timerZombieDustTotemCD:Stop()
		timerDeathsDoorCD:Stop()
		--Set fade defaults to fade bwonsamdi's timers
		timerInevitableEndCD:SetFade(true)
		timerDreadReapingCD:SetFade(true)
		--Rasta
		timerSpiritVortex:Start(11)
		timerAddsCD:Start(12)
		timerNecroticSmashCD:Start(28.3)
		--timerZombieDustTotemCD:Start(3)--Not actually used in Stage 3?
		timerDeathsDoorCD:Start(33.5)--SUCCESS
		timerScorchingDetonationCD:Start(38.8, 1)
		timerPlagueofFireCD:Start(46)
		--Bwon
		timerDreadReapingCD:Start(13.6)
		timerInevitableEndCD:Start(41.8, 1)--Can be delayed by up to 7.3 seconds for some reason
		--timerSealofBwonCD:Start(45.2)
--		self:RegisterShortTermEvents(
--			"SPELL_PERIODIC_DAMAGE 286772",
--			"SPELL_PERIODIC_MISSED 286772"
--		)
	--"<292.22 16:58:46> [UNIT_SPELLCAST_SUCCEEDED] King Rastakhan(??) -Summon Phantom of Retribution- boss1:Cast-3-2083-2070-6821-284540-002A522E86:284540
	--"<292.24 16:58:46> [UNIT_SPELLCAST_SUCCEEDED] King Rastakhan(??) -Summon Phantom of Rage- boss1:Cast-3-2083-2070-6821-284542-002C522E86:284542
	--"<292.24 16:58:46> [UNIT_SPELLCAST_SUCCEEDED] King Rastakhan(??) -Summon Phantom of Slaughter- boss1:Cast-3-2083-2070-6821-284543-002E522E86:284543
	--"<292.24 16:58:46> [UNIT_SPELLCAST_SUCCEEDED] King Rastakhan(??) -Summon Phantom of Ruin- boss1:Cast-3-2083-2070-6821-284544-002FD22E86:284544
--	elseif spellId == 284540 then--Summon Phantom of Retribution

	end
end
