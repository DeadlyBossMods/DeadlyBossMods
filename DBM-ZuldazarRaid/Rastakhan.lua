local mod	= DBM:NewMod(2335, "DBM-ZuldazarRaid", 2, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(145616)
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
	"SPELL_CAST_START 284933 284686 283504 287116 287333 286695 286742",
	"SPELL_CAST_SUCCESS 284831 284662 284781 285213 288449",
	"SPELL_SUMMON 285172 285003 285402",
	"SPELL_AURA_APPLIED 284831 285195 284662 284781 285349 288449 289169 289162 286779",
	"SPELL_AURA_APPLIED_DOSE 285195",
	"SPELL_AURA_REMOVED 284831 285195 288449 289162 286779",
	"SPELL_AURA_REMOVED_DOSE 285195",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)


--TODO, is serpent totem a high priority?
--TODO, verify meteor leap target scan (or use better event if there is one)
--TODO, detect voodoo doll target
--TODO, dread reaping fix?
--TODO, detect which realm players are in for warning filtering
--TODO, timers and bigger warnings for Seal of Bwonsamdi?
--TODO, shadow smash a tank swap?
--TODO, more add timers in general if verifying certain casts are long enough CD
--TODO, Stage Four: Uncontrollable Power?
--General
local warnPhase							= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
--Stage One: Zandalari Honor Guard
local warnSerpTotem						= mod:NewSpellAnnounce(285172, 2)
----Prelate Za'lan
local warnSealofPurification			= mod:NewTargetAnnounce(284662, 2)
----Siegebreaker Roka
local warnMeteorLeap					= mod:NewTargetNoFilterAnnounce(284686, 2)
----Headhunter Gal'wana
local warnGrieviousAxe					= mod:NewTargetNoFilterAnnounce(284781, 2, nil, "Healer")
--Stage Two: Bwonsamdi's Pact
local warnVoodooDoll					= mod:NewSpellAnnounce(285402, 3)
----Bwonsamdi
local warnDeathsDoor					= mod:NewTargetAnnounce(288449, 2)
--Stage Three: Enter the Death Realm
local warnDreadreaping					= mod:NewSpellAnnounce(287116, 3)
----Spirits
local warnSealofBwonsamdi				= mod:NewSpellAnnounce(286695, 3)
local warnShadowSmash					= mod:NewCastAnnounce(286742, 3)

--Stage One: Zandalari Honor Guard
local specWarnScorchingDetonation		= mod:NewSpecialWarningMoveAway(284831, nil, nil, nil, 3, 2)
local yellScorchingDetonation			= mod:NewYell(284831)
local yellScorchingDetonationFades		= mod:NewFadesYell(284831)
local specWarnScorchingDetonationOther	= mod:NewSpecialWarningTaunt(284831, nil, nil, nil, 1, 2)
local specWarnPlagueofToads				= mod:NewSpecialWarningDodge(284933, nil, nil, nil, 2, 2)
----Prelate Za'lan
local specWarnSealofPurification		= mod:NewSpecialWarningRun(284662, nil, nil, nil, 4, 2)
local yellSealofPurification			= mod:NewYell(284662)
----Siegebreaker Roka
local specWarnMeteorLeap				= mod:NewSpecialWarningMoveTo(284686, nil, nil, nil, 1, 2)
local yellMeteorLeap					= mod:NewYell(284686)
----Headhunter Gal'wana
local specWarnGrievousAxe				= mod:NewSpecialWarningDefensive(284781, false, nil, nil, 1, 2)
--Stage Two: Bwonsamdi's Pact
local specWarnPlagueofFire				= mod:NewSpecialWarningMoveAway(285349, nil, nil, nil, 1, 2)
local yellPlagueofFire					= mod:NewYell(285349)
local specWarnZombieDustTotem			= mod:NewSpecialWarningSwitch(285003, "Dps", nil, nil, 1, 2)
----Bwonsamdi
local specWarnCaressofDeath				= mod:NewSpecialWarningDefensive(285213, nil, nil, nil, 1, 2)
local specWarnCaressofDeathOther		= mod:NewSpecialWarningTaunt(285213, nil, nil, nil, 1, 2)
local specWarnSufferingSpirits			= mod:NewSpecialWarningCount(283504, nil, nil, nil, 2, 2)
local specWarnDeathsDoor				= mod:NewSpecialWarningMoveAway(288449, nil, nil, nil, 3, 2)
local yellDeathsDoor					= mod:NewYell(288449)
local yellDeathsDoorFades				= mod:NewFadesYell(288449)
--Stage Three: Enter the Death Realm
local specWarnInevitableEnd				= mod:NewSpecialWarningRun(287333, nil, nil, nil, 4, 2)
----Spirits
local specWarnShadowSmash				= mod:NewSpecialWarningDefensive(286742, nil, nil, nil, 1, 2)
local specWarnShadowSmashOther			= mod:NewSpecialWarningTaunt(286742, nil, nil, nil, 1, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(286772, nil, nil, nil, 1, 8)
local specWarnFocusedDimise				= mod:NewSpecialWarningInterrupt(286779, nil, nil, nil, 1, 2)

--local yellMeteorLeapFades				= mod:NewShortFadesYell(284686)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
--Stage One: Zandalari Honor Guard
local timerScorchingDetonationCD		= mod:NewAITimer(14.1, 284831, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerPlagueofToadsCD				= mod:NewAITimer(14.1, 284933, nil, nil, nil, 1)
local timerSerpentTotemCD				= mod:NewAITimer(14.1, 285172, nil, nil, nil, 1)
----Prelate Za'lan
local timerSealofPurificationCD			= mod:NewAITimer(14.1, 284662, nil, nil, nil, 3)
----Siegebreaker Roka
local timerMeteorLeapCD					= mod:NewAITimer(14.1, 284686, nil, nil, nil, 3)
----Headhunter Gal'wana
local timerGrievousAxeCD				= mod:NewAITimer(14.1, 284781, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON)
--Stage Two: Bwonsamdi's Pact
local timerPlagueofFireCD				= mod:NewAITimer(14.1, 285347, nil, nil, nil, 3)
local timerZombieDustTotemCD			= mod:NewAITimer(14.1, 285003, nil, nil, nil, 1)
local timerVoodooDollCD					= mod:NewAITimer(14.1, 285402, nil, nil, nil, 1)
----Bwonsamdi
local timerCaressofDeathCD				= mod:NewAITimer(14.1, 285213, nil, "Tank", nil, 5, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_TANK_ICON)
local timerSufferingSpiritsCD			= mod:NewAITimer(14.1, 283504, nil, nil, nil, 2)
local timerDeathsDoorCD					= mod:NewAITimer(14.1, 288449, nil, nil, nil, 3)
--Stage Three: Enter the Death Realm
local timerDreadReapingCD				= mod:NewAITimer(14.1, 287116, nil, nil, nil, 3)
local timerInevitableEndCD				= mod:NewAITimer(14.1, 287333, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddSetIconOption("SetIconGift", 255594, true)
mod:AddRangeFrameOption(8, 285349)
mod:AddInfoFrameOption(285195, true)
mod:AddNamePlateOption("NPAuraOnRelentlessness", 289162)
mod:AddNamePlateOption("NPAuraOnFocusedDemise", 286779)
--mod:AddSetIconOption("SetIconDarkRev", 273365, true)

mod.vb.phase = 1
mod.vb.miniBosses = 3
mod.vb.sufferingSpirits = 0
local infoframeTable = {}

function mod:MeteorLeapTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnMeteorLeap:Show(GROUP)
		specWarnMeteorLeap:Play("gathershare")
		yellMeteorLeap:Yell()
		--yellMeteorLeapFades:Countdown()
	elseif not self:IsTank() then
		specWarnMeteorLeap:Show(targetname)
		specWarnMeteorLeap:Play("gathershare")
	else
		warnMeteorLeap:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.miniBosses = 3
	self.vb.sufferingSpirits = 0
	table.wipe(infoframeTable)
	timerScorchingDetonationCD:Start(1-delay)
	timerPlagueofToadsCD:Start(1-delay)
	timerSerpentTotemCD:Start(1-delay)
	timerSealofPurificationCD:Start(1-delay)
	timerMeteorLeapCD:Start(1-delay)
	timerGrievousAxeCD:Start(1-delay)
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

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 284933 then
		specWarnPlagueofToads:Show()
		specWarnPlagueofToads:Play("watchstep")
		timerPlagueofToadsCD:Start()
	elseif spellId == 284686 then
		timerMeteorLeapCD:Start()
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "MeteorLeapTarget", 0.1, 8, true, nil, nil, nil, true)
	elseif spellId == 283504 then
		self.vb.sufferingSpirits = self.vb.sufferingSpirits + 1
		specWarnSufferingSpirits:Show(self.vb.sufferingSpirits)
		specWarnSufferingSpirits:Play("aesoon")
		timerSufferingSpiritsCD:Start()
	elseif spellId == 287116 and self:AntiSpam(3, 1) then
		warnDreadreaping:Show()
		timerDreadReapingCD:Start()
	elseif spellId == 287333 then
		specWarnInevitableEnd:Show()
		specWarnInevitableEnd:Play("justrun")
		timerInevitableEndCD:Start()
	elseif spellId == 286695 then
		warnSealofBwonsamdi:Show()
	elseif spellId == 286742 then
		warnShadowSmash:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 284831 then
		timerScorchingDetonationCD:Start()
	elseif spellId == 284662 then
		timerSealofPurificationCD:Start()
	elseif spellId == 284781 then
		timerGrievousAxeCD:Start()
	elseif spellId == 285213 then
		timerCaressofDeathCD:Start()
	elseif spellId == 288449 then
		timerDeathsDoorCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 285172 then
		warnSerpTotem:Show()
		timerSerpentTotemCD:Start()
	elseif spellId == 285003 then
		specWarnZombieDustTotem:Show()
		specWarnZombieDustTotem:Play("attacktotem")
		timerZombieDustTotemCD:Start()
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
			if not DBM.InfoFrame:IsShown() then
				DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(285195))
				if DBM.Options.DebugMode and DBM.Options.DebugLevel == 3 then
					DBM.InfoFrame:Show(5, "table", infoframeTable, 1)
				else
					DBM.InfoFrame:Show(5, "playerdebuffstacks", 285195, 1)
				end
			else
				if DBM.Options.DebugMode and DBM.Options.DebugLevel == 3 then
					DBM.InfoFrame:UpdateTable(infoframeTable)
				end
			end
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
	elseif spellId == 285213 then
		if args:IsPlayer() then
			specWarnCaressofDeath:Show()
			specWarnCaressofDeath:Play("defensive")
		else
			specWarnCaressofDeathOther:Show(args.destName)
			specWarnCaressofDeathOther:Play("tauntboss")
		end
	elseif spellId == 288449 then
		if args:IsPlayer() then
			specWarnDeathsDoor:Show()
			specWarnDeathsDoor:Play("runout")
			yellDeathsDoor:Yell()
			yellDeathsDoorFades:Countdown(8)
		else
			warnDeathsDoor:CombinedShow(0.3, args.destName)--Multiple targets assumed, change if not
		end
	elseif spellId == 289169 and self.vb.phase < 3 then--Bwonsamdi's Boon
		self.vb.phase = 3
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		timerScorchingDetonationCD:Stop()
		timerScorchingDetonationCD:Stop()
		timerPlagueofFireCD:Stop()
		timerZombieDustTotemCD:Stop()
		timerVoodooDollCD:Stop()
		timerCaressofDeathCD:Stop()--SUCCESS
		timerSufferingSpiritsCD:Stop()
		timerDeathsDoorCD:Stop()
		--Resets of timers assumed, don't reset if they don't reset
		timerZombieDustTotemCD:Start(3)
		timerDeathsDoorCD:Start(3)
		timerCaressofDeathCD:Start(3)
		timerPlagueofFireCD:Start(3)
		timerDreadReapingCD:Start(3)
		timerInevitableEndCD:Start(3)
		self:RegisterShortTermEvents(
			"SPELL_PERIODIC_DAMAGE 286772",
			"SPELL_PERIODIC_MISSED 286772"
		)
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
		if self.Options.InfoFrame and DBM.Options.DebugMode and DBM.Options.DebugLevel == 3 then
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
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 285195 then
		infoframeTable[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			if #infoframeTable > 0 then
				if DBM.Options.DebugMode and DBM.Options.DebugLevel == 3 then
					DBM.InfoFrame:UpdateTable(infoframeTable)
				end
			else
				DBM.InfoFrame:Hide()
			end
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 286772 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--Probably temp location function
local function changeStage(self, stage)
	if self.vb.phase < 2 and stage == 2 then
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		timerPlagueofToadsCD:Stop()
		timerSerpentTotemCD:Stop()
		--Assumed
		timerScorchingDetonationCD:Stop()
		timerScorchingDetonationCD:Start(2)
		timerPlagueofFireCD:Start(2)
		timerZombieDustTotemCD:Start(2)
		timerVoodooDollCD:Start(2)
		timerCaressofDeathCD:Start(2)--SUCCESS
		timerSufferingSpiritsCD:Start(2)
		timerDeathsDoorCD:Start(2)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 146320 then--Prelate Za'lan
		timerSealofPurificationCD:Stop()
		self.vb.miniBosses = self.vb.miniBosses - 1
		if self.vb.miniBosses == 0 then
			changeStage(self, 2)
		end
	elseif cid == 146322 then--Siegebreaker Roka
		timerMeteorLeapCD:Stop()
		self.vb.miniBosses = self.vb.miniBosses - 1
		if self.vb.miniBosses == 0 then
			changeStage(self, 2)
		end
	elseif cid == 146326 then--Headhunter Galwana
		timerGrievousAxeCD:Stop()
		self.vb.miniBosses = self.vb.miniBosses - 1
		if self.vb.miniBosses == 0 then
			changeStage(self, 2)
		end
	--elseif cid == 146766 then--Greater Serpent Totem
	
	--elseif cid == 146731 then--Zombie Dust Totem
	
	--elseif cid == 146933 then--Voodoo Doll
	
	--elseif cid == 146491 then--phantom-of-retribution
	
	--elseif cid == 146492 then--phantom-of-rage

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 285347 then--Plague of Fire
		timerPlagueofFireCD:Start()
	end
end
