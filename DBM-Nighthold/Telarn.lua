local mod	= DBM:NewMod(1761, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(104528)--109042
mod:SetEncounterID(1886)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)
--mod.respawnTime = 15--Definitely lower than 30, but couldn't run back fast enough to see. 10-20

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 218438 218463 218466 218470 218148 218774 219049 218927 216830 216877 223034 223219",
	"SPELL_CAST_SUCCESS 218424 218807 223437",
	"SPELL_AURA_APPLIED 218809 218503 218304 218342",
	"SPELL_AURA_APPLIED_DOSE 218503",
	"SPELL_AURA_REMOVED 218809 218304",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"UNIT_DIED",
	"UNIT_HEALTH target focus mouseover"
)

--TODO. see how many CoN go out and auto assign soakers for it. I bet it's 2 melee 2 ranged and 1 healer. Redo icons accordingly
--TODO, flare? wtf? tooltip is either wrong or boss has one useless insigificant spell
--TODO, adjust 15% on stars if it's too low/high. 25% was used on algalon for reference
--TODO, see if controlled chaos 10-30 are no longer hidden in later tests. if still hidden, have to use scheduling and exact timing synced to videos
--(ability.id = 218438 or ability.id = 218774 or ability.id = 219049 or ability.id = 218927 or ability.id = 216830 or ability.id = 216877 or ability.id = 218148) and type = "begincast" or (ability.id = 218807 or ability.id = 218424) and type = "cast"
--or self:IsMythic() and self.vb.phase == 1--Ready to go in case my theory is correct
--Stage 1: The High Botanist
local warnRecursiveStrikes			= mod:NewStackAnnounce(218503, 2, nil, "Tank")
local warnControlledChaos			= mod:NewCountAnnounce(218438, 3)--Not currently functional
local warnSummonChaosSpheres		= mod:NewSpellAnnounce(223034, 2)
local warnParasiticFetter			= mod:NewTargetAnnounce(218304, 3)
local warnParasiticFixate			= mod:NewTargetAnnounce(218342, 4, nil, false)--Spammy if things go to shit, so off by default
--Stage 2: Nightosis
local warnPhase2					= mod:NewPhaseAnnounce(2)
--local warnFlare						= mod:NewSpellAnnounce(218806, 2, nil, "Tank")
local warnPlasmaSpheres				= mod:NewSpellAnnounce(218774, 2)
--Stage 3: Pure Forms
local warnPhase3					= mod:NewPhaseAnnounce(3)
local warnToxicSpores				= mod:NewSpellAnnounce(219049, 3)
local warnCoN						= mod:NewTargetAnnounce(218809, 4)
local warnGraceofNature				= mod:NewCastAnnounce(218927, 4, nil, nil, "Tank")
local warnChaosSpheresOfNature		= mod:NewSpellAnnounce(223219, 4)

--Stage 1: The High Botanist
local specWarnRecursiveStrikes		= mod:NewSpecialWarningTaunt(218503, nil, nil, nil, 1, 2)
local specWarnControlledChaos		= mod:NewSpecialWarningDodge(218438, nil, nil, nil, 2, 2)
local specWarnLasher				= mod:NewSpecialWarningSwitch("ej13699", "Dps", nil, nil, 1, 2)
local yellParasiticFetter			= mod:NewYell(218304)
local specWarnParasiticFetter		= mod:NewSpecialWarningClose(218304, nil, nil, nil, 1, 2)
local specWarnParasiticFixate		= mod:NewSpecialWarningRun(218342, nil, nil, nil, 4, 2)
local specWarnSolarCollapse			= mod:NewSpecialWarningDodge(218148, nil, nil, nil, 2, 2)
--Stage 2: Nightosis
local specwarnStarLow				= mod:NewSpecialWarning("warnStarLow", "Tank|Healer", nil, nil, 2)--aesoon?
--Stage 3: Pure Forms
local specWarnGraceOfNature			= mod:NewSpecialWarningMove(218927, "Tank", nil, nil, 3, 2)
local specWarnCoN					= mod:NewSpecialWarningYouPos(218809, nil, nil, nil, 1, 5)
local yellCoN						= mod:NewPosYell(218809)

--All abilities have same cd. 35 seconds in phase 1, 55 in phase 2 and 70 in phase 3
--Mythic is unknown but I suspect it's inversed. 70 when all alive, 55 when one dead 35 if only one left
--Stage 1: The High Botanist
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerControlledChaosCD		= mod:NewNextTimer(35, 218438, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerSummonChaosSpheresCD		= mod:NewAITimer(35, 223034, nil, nil, nil, 1, nil, DBM_CORE_HEROIC_ICON)
local timerParasiticFetterCD		= mod:NewNextTimer(35, 218304, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)--Technically can also be made add timer instead of targetted
local timerSolarCollapseCD			= mod:NewNextTimer(35, 218148, nil, nil, nil, 3)
local timerCollapseofNightCD		= mod:NewNextTimer(35, 223437, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)

--Stage 2: Nightosis
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerPlasmaSpheresCD			= mod:NewNextTimer(55, 218774, nil, nil, nil, 1)
--Stage 3: Pure Forms
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerToxicSporesCD			= mod:NewNextTimer(8.5, 219049, nil, nil, nil, 3)--Exception to 35, 55, 70 rule
local timerGraceOfNatureCD			= mod:NewNextTimer(70, 218927, nil, "Tank", nil, 5)
local timerCoNCD					= mod:NewNextTimer(70, 218809, nil, nil, nil, 3)
local timerChaotiSpheresofNatureCD	= mod:NewAITimer(35, 223219, nil, nil, nil, 1, nil, DBM_CORE_HEROIC_ICON)

local countdownControlledChaos		= mod:NewCountdown(35, 218438)
local countdownParasiticFetter		= mod:NewCountdown("Alt35", 218304, "-Tank")
local countdownGraceOfNature		= mod:NewCountdown("Alt70", 218927, "Tank")
local countdownCoN					= mod:NewCountdown("AltTwo70", 218809, "-Tank")

local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
--Stage 1: The High Botanist
local voiceRecursiveStrikes			= mod:NewVoice(218503)--tauntboss
local voiceControlledChaos			= mod:NewVoice(218438)--watchstep
local voiceLasher					= mod:NewVoice("ej13699", "RangedDps")--killmob
local voiceParasiticFetter			= mod:NewVoice(218304)--runaway
local voiceParasiticFixate			= mod:NewVoice(218342)--targetyou
local voiceSolarCollapse			= mod:NewVoice(218148)--watchstep
--Stage 2: Nightosis

--Stage 3: Pure Forms
local voiceGraceOfNature			= mod:NewVoice(218927, "Tank")--bossout
local voiceCoN						= mod:NewVoice(218809)--mmX

mod:AddRangeFrameOption(8, 218807)
mod:AddSetIconOption("SetIconOnCoN", 218807, true)
mod:AddHudMapOption("HudMapOnCoN", 218807)

mod.vb.CoNIcon = 1
mod.vb.phase = 1

local sentLowHP = {}
local warnedLowHP = {}
local UnitDebuff = UnitDebuff
local callOfNightName = GetSpellInfo(218809)
local hasCoN, noCoN
do
	--hasCoN not used
	hasCoN = function(uId)
		if UnitDebuff(uId, callOfNightName) then
			return true
		end
	end
	noCoN = function(uId)
		if not UnitDebuff(uId, callOfNightName) then
			return true
		end
	end
end

function mod:OnCombatStart(delay)
	table.wipe(sentLowHP)
	table.wipe(warnedLowHP)
	self.vb.CoNIcon = 1
	self.vb.phase = 1
	timerSolarCollapseCD:Start(10-delay)
	timerParasiticFetterCD:Start(21-delay)
	countdownParasiticFetter:Start(21-delay)
	timerControlledChaosCD:Start(-delay)
	countdownControlledChaos:Start()
	if self:IsMythic() then
		--probably custom timer code here
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnCoN then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 218438 then
		specWarnControlledChaos:Show()
		voiceControlledChaos:Play("watchstep")
		--Add filter to make sure it doesn't start timers off chaos spheres dying?
		if self.vb.phase == 3 then
			timerControlledChaosCD:Start(70)
			countdownControlledChaos:Start(70)
		elseif self.vb.phase == 2 then
			timerControlledChaosCD:Start(55)
			countdownControlledChaos:Start(55)
		else
			timerControlledChaosCD:Start()
			countdownControlledChaos:Start()
		end
	elseif spellId == 223034 then--Summon Chaos Spheres
		warnSummonChaosSpheres:Show()
		timerSummonChaosSpheresCD:Start()
	elseif spellId == 218463 then--(10)
		warnControlledChaos:Show(10)
	elseif spellId == 218466 then--(20)
		warnControlledChaos:Show(20)
	elseif spellId == 218470 then--(30)
		warnControlledChaos:Show(30)
	elseif spellId == 218148 then
		specWarnSolarCollapse:Show()
		voiceSolarCollapse:Play("watchstep")
		if self.vb.phase == 3 then
			timerSolarCollapseCD:Start(70)
		elseif self.vb.phase == 2 then
			timerSolarCollapseCD:Start(55)
		else
			timerSolarCollapseCD:Start()--35
		end
--	elseif spellId == 218806 then
--		warnFlare:Show()
	elseif spellId == 218774 then
		warnPlasmaSpheres:Show()
		if self.vb.phase == 3 then
			timerPlasmaSpheresCD:Start(70)
		else
			timerPlasmaSpheresCD:Start()
		end
	elseif spellId == 223219 then--Summon Chaotic Spheres of Nature
		warnChaosSpheresOfNature:Show()
		timerChaotiSpheresofNatureCD:Start()
	elseif spellId == 219049 then
		warnToxicSpores:Show()
		timerToxicSporesCD:Start()
	elseif spellId == 218927 then
		specWarnGraceOfNature:Show()
		voiceGraceOfNature:Play("bossout")
		timerGraceOfNatureCD:Start()--Not yet known, assumed 70
		countdownGraceOfNature:Start()
	elseif spellId == 216830 then--Phase 2
		self.vb.phase = 2
		warnPhase2:Show()
		voicePhaseChange:Play("ptwo")
		timerControlledChaosCD:Stop()
		countdownControlledChaos:Cancel()
		timerParasiticFetterCD:Stop()
		countdownParasiticFetter:Cancel()
		timerSolarCollapseCD:Stop()
		timerSolarCollapseCD:Start(12)
		timerParasiticFetterCD:Start(23.5)
		countdownParasiticFetter:Start(23.5)
		timerPlasmaSpheresCD:Start(37)
		timerControlledChaosCD:Start(57)
		countdownControlledChaos:Start(57)
	elseif spellId == 216877 then--Phase 3
		self.vb.phase = 3
		warnPhase3:Show()
		voicePhaseChange:Play("pthree")
		timerControlledChaosCD:Stop()
		countdownControlledChaos:Cancel()
		timerParasiticFetterCD:Stop()
		countdownParasiticFetter:Cancel()
		timerSolarCollapseCD:Stop()
		timerPlasmaSpheresCD:Stop()
		timerToxicSporesCD:Start(8.5)
		timerSolarCollapseCD:Start(27)
		timerParasiticFetterCD:Start(28)
		countdownParasiticFetter:Start(28)
		timerControlledChaosCD:Start(37)
		countdownControlledChaos:Start(37)
		timerPlasmaSpheresCD:Start(52)
		timerCoNCD:Start(64)--Probably will be changed
		countdownCoN:Start(64)
		timerGraceOfNatureCD:Start(72)--Might change
		countdownGraceOfNature:Start(72)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 218424 then
		if self.vb.phase == 3 then
			timerParasiticFetterCD:Start(70)
			countdownParasiticFetter:Start(70)
		elseif self.vb.phase == 2 then
			timerParasiticFetterCD:Start(55)
			countdownParasiticFetter:Start(55)
		else
			timerParasiticFetterCD:Start()--35
			countdownParasiticFetter:Start()
		end
	elseif spellId == 218807 then
		timerCoNCD:Start()
		countdownCoN:Start()
	elseif spellId == 223437 then
		
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 218809 then
		warnCoN:CombinedShow(0.5, args.destName)
		self.vb.CoNIcon = self.vb.CoNIcon + 1
		local number = self.vb.CoNIcon
		if self.Options.HudMapOnCoN then
			if args:IsPlayer() then
				DBMHudMap:RegisterRangeMarkerOnPartyMember(2188092, "party", UnitName("player"), 0.9, 1200, nil, nil, nil, 1, nil, false):Appear()
			else
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 8, 1200, nil, nil, nil, 0.5):Appear():RegisterForAlerts(nil, args.destName)
			end
		end
		if args:IsPlayer() then
			specWarnCoN:Show(self:IconNumToString(number))
			yellCoN:Yell(self:IconNumToString(number), number, number)
			voiceCoN:Play("mm"..number)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8, noCoN, nil, nil, true)
				DBM:AddMsg(L.RadarMessage)
			end
		end
		if self.Options.SetIconOnCoN and number < 9 then
			self:SetIcon(args.destName, number)
		end
	elseif spellId == 218503 then
		local amount = args.amount or 1
		if amount % 3 == 0 or amount > 7 then
			warnRecursiveStrikes:Show(args.destName, amount)
			if not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") and self:AntiSpam(3, 1) then
				specWarnRecursiveStrikes:Show(args.destName)
				voiceRecursiveStrikes:Play("tauntboss")
			end
		end
	elseif spellId == 218304 then
		if args:IsPlayer() then
			yellParasiticFetter:Yell()
		end
		if self:CheckNearby(20, args.destName) then
			specWarnParasiticFetter:Show(args.destName)
			voiceParasiticFetter:Play("runaway")
		else
			warnParasiticFetter:Show(args.destName)
		end
	elseif spellId == 218342 then
		warnParasiticFixate:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnParasiticFixate:Show()
			voiceParasiticFixate:Play("targetyou")
		end
--	elseif spellId == 219009 then
--		local targetName = args.destName
--		if targetName == UnitName("target") or targetName == UnitName("focus") then
--			specWarnGraceOfNature:Show(targetName)
--			voiceGraceOfNature:Play("bossout")
--		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 218809 then
		if self.Options.HudMapOnCoN then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
			if self.Options.HudMapOnCoN then
				DBMHudMap:FreeEncounterMarkerByTarget(2188092, args.destName)
			end
		end
		if self.Options.SetIconOnCoN then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 218304 and self:AntiSpam(5, 2) and not UnitDebuff("player", args.spellName) then
		specWarnLasher:Show()
		voiceLasher:Play("killmob")
	end
end

function mod:UNIT_DIED(args)
	if not self:IsMythic() then return end
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 109040 then--Arcanist Tel'arn
		self.vb.phase = self.vb.phase + 1
		timerCoNCD:Stop()
		countdownCoN:Cancel()
		timerControlledChaosCD:Stop()
		countdownControlledChaos:Cancel()
		timerSummonChaosSpheresCD:Stop()
		if self.vb.phase == 2 then--1 boss dead
			--Solarist Tel'arn replaces Solar Collapse with Collapse of Night when Arcanist Tel'arn is killed first
			local solarelapsed, solartotal = timerSolarCollapseCD:GetTime()
			timerSolarCollapseCD:Stop()
			if solarelapsed > 0 then
				local solarremaining = solartotal - solarelapsed
				timerCollapseofNightCD:Update(solarelapsed, solartotal)
				countdownCoN:Start(solarremaining)--Call of night countdown added to solar collapse
			end
			--Naturalist Tel'arn's Parsitic Fetter causes Controlled Chaos when removed if Arcanist Tel'arn is killed first
		elseif self.vb.phase == 3 then--2 bosses dead
			--These requires checking which boss is left
			for i = 1, 5 do
				local bossUID = "boss"..i
				if UnitExists(bossUID) then
					local cid = self:GetUnitCreatureId(bossUID)
					if cid == 109038 then--Solarist Tel'arn is what's left
						--Nothing?
						break
					elseif cid == 109041 then--Naturalist Tel'arn
						--Naturalist Tel'arn gains Summon Chaotic Spheres of Nature when he is the last form alive
						timerChaotiSpheresofNatureCD:Start(1)
						break
					end
				end
			end
		end
	elseif cid == 109038 then--Solarist Tel'arn
		self.vb.phase = self.vb.phase + 1
		timerSolarCollapseCD:Stop()
		timerCollapseofNightCD:Stop()
		timerPlasmaSpheresCD:Stop()
		if self.vb.phase == 2 then--1 boss dead
			--Arcanist Tel'arn's replaces Controlled Chaos with Summon Chaos Spheres when Solarist Tel'arn is killed first
			local controlledelapsed, controlledtotal = timerControlledChaosCD:GetTime()
			timerControlledChaosCD:Stop()
			countdownControlledChaos:Cancel()
			if controlledelapsed > 0 then
				timerSummonChaosSpheresCD:Update(controlledelapsed, controlledtotal)
			end
			--Naturalist Tel'arn's Toxic Spores cause a Solar Collapse at the target's location when Solarist Tel'arn is killed first
		elseif self.vb.phase == 3 then--2 bosses dead
			--These requires checking which boss is left
			for i = 1, 5 do
				local bossUID = "boss"..i
				if UnitExists(bossUID) then
					local cid = self:GetUnitCreatureId(bossUID)
					if cid == 109041 then--Naturalist Tel'arn is what's left
						--Naturalist Tel'arn gains Summon Chaotic Spheres of Nature when he is the last form alive
						timerChaotiSpheresofNatureCD:Start(1)
						break
					elseif cid == 109040 then--Arcanist Tel'arn
						--Arcanist Tel'arn's Recursive Strikes creates Plasma Spheres when it expires if Solarist Tel'arn is killed second
						break
					end
				end
			end
		end
	elseif cid == 109041 then--Naturalist Tel'arn
		self.vb.phase = self.vb.phase + 1
		if self.vb.phase == 2 then--1 boss dead
			--Arcanist Tel'arn's Call of Night periodically summons Toxic Spores when Naturalist Tel'arn is killed first
			--Solarist Tel'arn's Plasma Spheres create Parasitic Lashers when killed if Naturalist Tel'arn is killed first.
		elseif self.vb.phase == 3 then--2 bosses dead
			--These requires checking which boss is left
			for i = 1, 5 do
				local bossUID = "boss"..i
				if UnitExists(bossUID) then
					local cid = self:GetUnitCreatureId(bossUID)
					if cid == 109038 then--Solarist Tel'arn is what's left
						--Solarist Tel'arn's plasma Spheres create Toxic Spores when killed if Naturalist Tel'arn is killed second.
						--Flare applies Parasitic Fetter to all targets hit if Naturalist Tel'arn is killed second
						break
					elseif cid == 109040 then--Arcanist Tel'arn
						--Controlled Chaos causes several points of Solar Collapse to spawn around it's perimeter when Solarist Tel'arn is killed second
						break
					end
				end
			end
		end
	end
end

function mod:UNIT_HEALTH(uId)
	local cid = self:GetUnitCreatureId(uId)
	if cid == 109804 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.15 then
		local guid = UnitGUID(uId)
		if not sentLowHP[guid] then
			sentLowHP[guid] = true
			self:SendSync("lowhealth", guid)
		end
	end
end

function mod:OnSync(msg, guid)
	if msg == "lowhealth" and guid and not warnedLowHP[guid] then
		warnedLowHP[guid] = true
		specwarnStarLow:Show()
	end
end
