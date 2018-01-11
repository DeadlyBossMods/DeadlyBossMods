local mod	= DBM:NewMod(2031, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(124828)
mod:SetEncounterID(2092)
mod:SetZone()
mod:SetBossHPInfoToHighest()--Because of heal on mythic
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7)
mod:SetHotfixNoticeRev(16993)
mod:SetMinSyncRevision(16895)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 248165 248317 257296 255594 257645 252516 256542 255648 257619",
	"SPELL_CAST_SUCCESS 248499 258039 258838 252729 252616 256388 258029",
	"SPELL_AURA_APPLIED 248499 248396 250669 251570 255199 253021 255496 255496 255478 252729 252616 255433 255430 255429 255425 255422 255419 255418 258647 258646 257869 257931 257966 258838",
	"SPELL_AURA_APPLIED_DOSE 248499 258039 258838",
	"SPELL_AURA_REMOVED 250669 251570 255199 253021 255496 255496 255478 255433 255430 255429 255425 255422 255419 255418 258039 257966 258647 258646 258838",
	"SPELL_INTERRUPT",
	"SPELL_PERIODIC_DAMAGE 248167",
	"SPELL_PERIODIC_MISSED 248167",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, custom warning to combine soulburst and bomb into single message instead of two messages, while still separating targets
--TODO, interrupt warnings for Designates if not affected by Inevitability?
--TODO, More info on InfoFrame?
--TODO, warnings when eonar transitions from gift to withering. other titan stuff?
--[[
(ability.id = 256544 or ability.id = 255826 or ability.id = 248165 or ability.id = 248317 or ability.id = 257296 or ability.id = 255594 or ability.id = 252516 or ability.id = 255648 or ability.id = 257645 or ability.id = 256542 or ability.id = 257619 or ability.id = 255935) and type = "begincast"
 or (ability.id = 248499 or ability.id = 258039 or ability.id = 252729 or ability.id = 252616 or ability.id = 256388 or ability.id = 258838 or ability.id = 258029) and type = "cast"
 or (ability.id = 250669 or ability.id = 251570 or ability.id = 255199 or ability.id = 257931 or ability.id = 257869 or ability.id = 257966) and type = "applydebuff" or type = "interrupt" and target.id = 124828
--]]
local warnPhase						= mod:NewPhaseChangeAnnounce()
--Stage One: Storm and Sky
local warnTorturedRage				= mod:NewCountAnnounce(257296, 2)
local warnSweepingScythe			= mod:NewStackAnnounce(248499, 2, nil, "Tank")
local warnBlightOrb					= mod:NewCountAnnounce(248317, 2)
local warnSoulblight				= mod:NewTargetAnnounce(248396, 2, nil, false, 2)
local warnSkyandSea					= mod:NewTargetAnnounce(255594, 1)
--Stage one Mythic
local warnSargRage					= mod:NewTargetAnnounce(257869, 3)
local warnSargFear					= mod:NewTargetAnnounce(257931, 3)
--Stage Two: The Protector Redeemed
local warnSoulburst					= mod:NewTargetAnnounce(250669, 2)
local warnSoulbomb					= mod:NewTargetAnnounce(251570, 3)
local warnAvatarofAggra				= mod:NewTargetAnnounce(255199, 1)
--Stage Three: The Arcane Masters
local warnCosmicRay					= mod:NewTargetAnnounce(252729, 3)
local warnCosmicBeacon				= mod:NewTargetAnnounce(252616, 2)
local warnDiscsofNorg				= mod:NewCastAnnounce(252516, 1)
--Stage Three Mythic
local warnSargSentence				= mod:NewTargetAnnounce(257966, 3)
local warnEdgeofAnni				= mod:NewCountAnnounce(258834, 4)
local warnSoulRendingScythe			= mod:NewStackAnnounce(258838, 2, nil, "Tank")
--Stage Four: The Gift of Life, The Forge of Loss (Non Mythic)
local warnGiftOfLifebinder			= mod:NewCastAnnounce(257619, 1)
local warnDeadlyScythe				= mod:NewStackAnnounce(258039, 2, nil, "Tank")

--Stage One: Storm and Sky
local specWarnSweepingScythe		= mod:NewSpecialWarningStack(248499, nil, 3, nil, nil, 1, 6)
local specWarnSweepingScytheTaunt	= mod:NewSpecialWarningTaunt(248499, nil, nil, nil, 1, 2)
local specWarnConeofDeath			= mod:NewSpecialWarningDodge(248165, nil, nil, nil, 1, 2)
local specWarnSoulblight			= mod:NewSpecialWarningMoveAway(248396, nil, nil, nil, 1, 2)
local yellSoulblight				= mod:NewYell(248396)
local specWarnGiftofSea				= mod:NewSpecialWarningYou(258647, nil, nil, nil, 1, 2)
local yellGiftofSea					= mod:NewPosYell(258647, L.SeaText)
local specWarnGiftofSky				= mod:NewSpecialWarningYou(258646, nil, nil, nil, 1, 2)
local yellGiftofSky					= mod:NewPosYell(258646, L.SkyText)
--Mythic P1
local specWarnSargRage				= mod:NewSpecialWarningMoveAway(257869, nil, nil, nil, 3, 2)
local yellSargRage					= mod:NewYell(257869)
local specWarnSargFear				= mod:NewSpecialWarningMoveTo(257931, nil, nil, nil, 3, 2)
local yellSargFear					= mod:NewYell(257931)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Stage Two: The Protector Redeemed
local specWarnSoulburst				= mod:NewSpecialWarningMoveAway(250669, nil, nil, nil, 1, 2)
local yellSoulburst					= mod:NewPosYell(250669)
local yellSoulburstFades			= mod:NewIconFadesYell(250669)
local specWarnSoulbomb				= mod:NewSpecialWarningYou(251570, nil, nil, nil, 1, 2)
local specWarnSoulbombMoveTo		= mod:NewSpecialWarningMoveTo(251570, nil, nil, nil, 1, 7)
local yellSoulbomb					= mod:NewPosYell(251570, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
local yellSoulbombFades				= mod:NewIconFadesYell(251570)
local specWarnEdgeofObliteration	= mod:NewSpecialWarningSpell(255826, nil, nil, nil, 2, 2)
local specWarnAvatarofAggra			= mod:NewSpecialWarningYou(255199, nil, nil, nil, 1, 2)
--Stage Three: The Arcane Masters
local specWarnCosmicRay				= mod:NewSpecialWarningYou(252729, nil, nil, nil, 1, 2)
local yellCosmicRay					= mod:NewYell(252729)
local specWarnCosmicBeacon			= mod:NewSpecialWarningMoveAway(252616, nil, nil, nil, 1, 2)
local yellCosmicBeacon				= mod:NewYell(252616)
--Stage Three Mythic
local specWarnSargSentence			= mod:NewSpecialWarningYou(257966, nil, nil, nil, 1, 2)
local yellSargSentence				= mod:NewYell(257966)
local yellSargSentenceFades			= mod:NewShortFadesYell(257966)
local specWarnApocModule			= mod:NewSpecialWarningSwitchCount(258029, "Dps", nil, nil, 3, 2)--EVERYONE
local specWarnEdgeofAnni			= mod:NewSpecialWarningDodge(258834, nil, nil, nil, 2, 2)
local specWarnSoulrendingScythe		= mod:NewSpecialWarningStack(258838, nil, 2, nil, nil, 1, 2)
local specWarnSoulrendingScytheTaunt= mod:NewSpecialWarningTaunt(258838, nil, nil, nil, 1, 2)
--Stage Four: The Gift of Life, The Forge of Loss (Non Mythic)
local specWarnEmberofRage			= mod:NewSpecialWarningDodge(257299, nil, nil, nil, 2, 2)
local specWarnDeadlyScythe			= mod:NewSpecialWarningStack(258039, nil, 2, nil, nil, 1, 2)
local specWarnDeadlyScytheTaunt		= mod:NewSpecialWarningTaunt(258039, nil, nil, nil, 1, 2)
local specWarnReorgModule			= mod:NewSpecialWarningSwitchCount(256389, "RangedDps", nil, nil, 1, 2)--Ranged only?

local timerNextPhase				= mod:NewPhaseTimer(74)
--Stage One: Storm and Sky
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerSweepingScytheCD			= mod:NewCDCountTimer(5.6, 248499, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--5.6-15.7
local timerConeofDeathCD			= mod:NewCDCountTimer(19.4, 248165, nil, nil, nil, 3)--19.4-24
local timerBlightOrbCD				= mod:NewCDCountTimer(22, 248317, nil, nil, nil, 3)--22-32
local timerTorturedRageCD			= mod:NewCDCountTimer(13, 257296, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)--13-16
local timerSkyandSeaCD				= mod:NewCDCountTimer(25.1, 255594, nil, nil, nil, 5)--25.1-27.8
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)--Mythic Stage 1
local timerSargGazeCD				= mod:NewCDCountTimer(35.2, 258068, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
--Stage Two: The Protector Redeemed
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerSoulBombCD				= mod:NewNextTimer(42, 251570, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON)
local timerSoulBurstCD				= mod:NewNextCountTimer("d42", 250669, nil, nil, nil, 3)
local timerEdgeofObliterationCD		= mod:NewCDCountTimer(34, 255826, nil, nil, nil, 2)
local timerAvatarofAggraCD			= mod:NewCDTimer(59.9, 255199, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
--Stage Three: The Arcane Masters
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerCosmicRayCD				= mod:NewCDTimer(19.9, 252729, nil, nil, nil, 3)--All adds seem to cast it at same time, so one timer for all
local timerCosmicBeaconCD			= mod:NewCDTimer(19.9, 252616, nil, nil, nil, 3)--All adds seem to cast it at same time, so one timer for all
local timerDiscsofNorg				= mod:NewCastTimer(12, 252516, nil, nil, nil, 6)
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)--Mythic 3
local timerSoulrendingScytheCD		= mod:NewCDTimer(8.5, 258838, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerSargSentenceCD			= mod:NewCDCountTimer(35.2, 257966, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
local timerEdgeofAnniCD				= mod:NewCDTimer(5.5, 258834, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
--Stage Four: The Gift of Life, The Forge of Loss (Non Mythic)
mod:AddTimerLine(SCENARIO_STAGE:format(4))
local timerDeadlyScytheCD			= mod:NewCDTimer(5.5, 258039, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerReorgModuleCD			= mod:NewCDCountTimer(48.1, 256389, nil, nil, nil, 1)

local berserkTimer					= mod:NewBerserkTimer(600)

--Stage One: Storm and Sky
local countdownSoulbomb				= mod:NewCountdown(50, 251570)
--Stage Two: The Protector Redeemed

--Stage Four
local countdownDeadlyScythe			= mod:NewCountdown("Alt5", 258039, false, nil, 3)--Off by default since it'd be almost non stop, so users can elect into this one
local countdownReorgModule			= mod:NewCountdown("AltTwo48", 256389, "-Tank")

mod:AddSetIconOption("SetIconGift", 255594, true)--5 and 6
mod:AddSetIconOption("SetIconOnAvatar", 255199, true)--4
mod:AddSetIconOption("SetIconOnSoulBomb", 251570, true)--3 and 7
mod:AddSetIconOption("SetIconOnSoulBurst", 250669, true)--2
mod:AddSetIconOption("SetIconOnVulnerability", 255418, true, true)--1-7
mod:AddInfoFrameOption(258040, true)--Change to EJ entry since spell not localized
mod:AddNamePlateOption("NPAuraOnInevitability", 253021)
mod:AddNamePlateOption("NPAuraOnCosmosSword", 255496)
mod:AddNamePlateOption("NPAuraOnEternalBlades", 255478)
mod:AddNamePlateOption("NPAuraOnVulnerability", 255418)

local avatarOfAggramar, aggramarsBoon = DBM:GetSpellInfo(255199), DBM:GetSpellInfo(255200)
local playerAvatar = false
mod.vb.phase = 1
mod.vb.coneCount = 0
mod.vb.SkyandSeaCount = 0
mod.vb.blightOrbCount = 0
mod.vb.TorturedRage = 0
mod.vb.soulBurstIcon = 3
mod.vb.moduleCount = 0
mod.vb.EdgeofObliteration = 0
mod.vb.sentenceCount = 0
mod.vb.gazeCount = 0
mod.vb.scytheCastCount = 0
mod.vb.firstscytheSwap = false
--P3 Mythic Timers
local torturedRage = {40, 40, 50, 30, 35, 10, 8, 35, 10, 8, 35}--3 timers from method video not logs, verify by logs to improve accuracy
local sargSentence = {53, 56.9, 60, 53, 53}--1 timer from method video not logs, verify by logs to improve accuracy
local apocModule = {31, 47, 48.2, 46.6, 53, 53}--Some variation detected in logs do to delay in combat log between spawn and cast (one timer from method video)
local sargGaze = {23, 75, 70, 53, 53}--1 timer from method video not logs, verify by logs to improve accuracy
local edgeofAnni = {5, 5, 90, 5, 45, 5}--All timers from method video (6:05 P3 start, 6:10, 6:15, 7:45, 7:50, 8:35, 8:40)

local function startAnnihilationStuff(self, quiet)
	self.vb.EdgeofObliteration = self.vb.EdgeofObliteration + 1
	if quiet then--Second cast within 5 second period, do a quiet 2nd warn
		warnEdgeofAnni:Show(self.vb.EdgeofObliteration)
	else--Special warning
		specWarnEdgeofAnni:Show(self.vb.EdgeofObliteration)
	end
	local timer = edgeofAnni[self.vb.EdgeofObliteration+1]
	if timer then
		timerEdgeofAnniCD:Start(timer, self.vb.EdgeofObliteration+1)
		self:Schedule(timer, startAnnihilationStuff, self, timer < 6)
	end
end

local function checkForMissingSentence(self)
	self:Unschedule(checkForMissingSentence)
	self.vb.sentenceCount = self.vb.sentenceCount + 1
	local timer = sargSentence[self.vb.sentenceCount+1]
	if timer then
		timerSargSentenceCD:Start(timer-10, self.vb.sentenceCount+1)--Timer minus 10 or next expected sentence cast
		self:Schedule(timer, checkForMissingSentence, self)--10 seconds after expected sentence cast
	end
	DBM:Debug("checkForMissingSentence ran, which means all sentence immuned", 2)
end

local function delayedBoonCheck(self, stage4)
	if not UnitBuff("player", aggramarsBoon) then
		if stage4 then
			specWarnSoulbombMoveTo:Show(DBM_CORE_ROOM_EDGE)
			specWarnSoulbombMoveTo:Play("runtoedge")
		else
			specWarnSoulbombMoveTo:Show(avatarOfAggramar)
			specWarnSoulbombMoveTo:Play("movetotank")
		end
	end
end

function mod:OnCombatStart(delay)
	avatarOfAggramar, aggramarsBoon = DBM:GetSpellInfo(255199), DBM:GetSpellInfo(255200)
	playerAvatar = false
	self.vb.phase = 1
	self.vb.coneCount = 0
	self.vb.SkyandSeaCount = 0
	self.vb.blightOrbCount = 0
	self.vb.TorturedRage = 0
	self.vb.soulBurstIcon = 3
	self.vb.EdgeofObliteration = 0
	self.vb.moduleCount = 0
	self.vb.sentenceCount = 0
	self.vb.gazeCount = 0
	self.vb.scytheCastCount = 0
	self.vb.firstscytheSwap = false
	timerSweepingScytheCD:Start(5.8-delay, 1)
	timerSkyandSeaCD:Start(10.8-delay, 1)
	timerTorturedRageCD:Start(12-delay, 1)
	timerConeofDeathCD:Start(30.3-delay, 1)
	timerBlightOrbCD:Start(35.2-delay, 1)
	if self:IsMythic() then
		timerSargGazeCD:Start(8.5-delay, 1)
		berserkTimer:Start(660-delay)
	else
		berserkTimer:Start(720-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Show(4, "enemypower", 2)
	end
	if self.Options.NPAuraOnInevitability or self.Options.NPAuraOnCosmosSword or self.Options.NPAuraOnEternalBlades or self.Options.NPAuraOnVulnerability then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnInevitability or self.Options.NPAuraOnCosmosSword or self.Options.NPAuraOnEternalBlades or self.Options.NPAuraOnVulnerability then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 248165 then
		self.vb.coneCount = self.vb.coneCount + 1
		specWarnConeofDeath:Show()
		specWarnConeofDeath:Play("shockwave")
		timerConeofDeathCD:Start(nil, self.vb.coneCount+1)
	elseif spellId == 248317 then
		self.vb.blightOrbCount = self.vb.blightOrbCount + 1
		warnBlightOrb:Show(self.vb.blightOrbCount)
		timerBlightOrbCD:Start(nil, self.vb.blightOrbCount+1)
	elseif spellId == 257296 then
		self.vb.TorturedRage = self.vb.TorturedRage + 1
		warnTorturedRage:Show(self.vb.TorturedRage)
		if self:IsMythic() and self.vb.phase == 3 then
			local timer = torturedRage[self.vb.TorturedRage+1]
			if timer then
				timerTorturedRageCD:Start(timer, self.vb.TorturedRage+1)
			end
		else
			timerTorturedRageCD:Start(nil, self.vb.TorturedRage+1)
		end
	elseif spellId == 255594 then
		self.vb.SkyandSeaCount = self.vb.SkyandSeaCount + 1
		timerSkyandSeaCD:Start(nil, self.vb.SkyandSeaCount+1)
	elseif spellId == 252516 then
		warnDiscsofNorg:Show()
		timerDiscsofNorg:Start()
	elseif spellId == 255648 then--Golganneth's Wrath
		self.vb.phase = 2
		self.vb.scytheCastCount = 0
		self.vb.firstscytheSwap = false
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(2))
		timerConeofDeathCD:Stop()
		timerBlightOrbCD:Stop()
		timerTorturedRageCD:Stop()
		timerSweepingScytheCD:Stop()
		timerSkyandSeaCD:Stop()
		timerSargGazeCD:Stop()
		timerNextPhase:Start(16)
		timerSweepingScytheCD:Start(17.3, 1)
		timerAvatarofAggraCD:Start(20.9)
		timerEdgeofObliterationCD:Start(21, 1)
		timerSoulBombCD:Start(30.8)
		countdownSoulbomb:Start(30.8)
		timerSoulBurstCD:Start(30.8, 1)
		if self:IsMythic() then
			self.vb.gazeCount = 0
			timerSargGazeCD:Start(28.4, 1)
		end
	elseif spellId == 257645 then--Temporal Blast (Stage 3)
		timerAvatarofAggraCD:Stop()--Always cancel this here, it's not canceled by argus becoming inactive and can still be cast during argus inactive transition phase
		if self.vb.phase < 3 then
			self.vb.phase = 3
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
			timerSweepingScytheCD:Stop()
			timerTorturedRageCD:Stop()
			timerSoulBombCD:Stop()
			countdownSoulbomb:Cancel()
			timerSoulBurstCD:Stop()
			timerEdgeofObliterationCD:Stop()
			timerAvatarofAggraCD:Stop()
			timerSargGazeCD:Stop()
			if not self:IsMythic() then
				timerCosmicRayCD:Start(30)
				timerCosmicBeaconCD:Start(40)
				if self.Options.InfoFrame then
					DBM.InfoFrame:Hide()
				end
			end
		end
	elseif spellId == 256542 then--Reap Soul
		if not self:IsMythic() then
			self.vb.phase = 4
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(4))
			if self.Options.InfoFrame then
				DBM.InfoFrame:Show(4, "enemypower", 2)
			end
		end
		timerCosmicRayCD:Stop()
		timerCosmicBeaconCD:Stop()
		timerDiscsofNorg:Stop()
		timerSargGazeCD:Stop()
		timerNextPhase:Start(35)--or 53.8
	elseif spellId == 257619 then--Gift of the Lifebinder (p4/p3mythic)
		warnGiftOfLifebinder:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 248499 then
		self.vb.scytheCastCount = self.vb.scytheCastCount + 1
		if self.vb.scytheCastCount == 3 then
			self.vb.firstscytheSwap = true
		end
		timerSweepingScytheCD:Start(nil, self.vb.scytheCastCount+1)
	elseif spellId == 258039 then
		timerDeadlyScytheCD:Start()
		countdownDeadlyScythe:Start(5.5)
	elseif spellId == 258838 then--Mythic Scythe
		timerSoulrendingScytheCD:Start()
	elseif spellId == 255826 then
		self.vb.EdgeofObliteration = self.vb.EdgeofObliteration + 1
		specWarnEdgeofObliteration:Show()
		specWarnEdgeofObliteration:Play("watchstep")
		timerEdgeofObliterationCD:Start(nil, self.vb.EdgeofObliteration+1)
	elseif spellId == 252729 and self:AntiSpam(5, 3) then
		timerCosmicRayCD:Start()
	elseif spellId == 252616 and self:AntiSpam(5, 4) then
		timerCosmicBeaconCD:Start()
	elseif spellId == 256388 and self:AntiSpam(5, 5) then--Initialization Sequence
		self.vb.moduleCount = self.vb.moduleCount + 1
		specWarnReorgModule:Show(self.vb.moduleCount)
		specWarnReorgModule:Play("killmob")
		timerReorgModuleCD:Start(nil, self.vb.moduleCount+1)
		countdownReorgModule:Start()
	elseif spellId == 258029 and self:AntiSpam(5, 7) then--Initialization Sequence (Mythic)
		self.vb.moduleCount = self.vb.moduleCount + 1
		specWarnApocModule:Show(self.vb.moduleCount)
		specWarnApocModule:Play("killmob")
		local timer = apocModule[self.vb.moduleCount+1] or 46.6
		timerReorgModuleCD:Start(timer, self.vb.moduleCount+1)
		countdownReorgModule:Start(timer)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 248499 then--Heroic/non mythic
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			local amount = args.amount or 1
			local swapAmount = (self:IsLFR() or not self.vb.firstscytheSwap) and 3 or 2
			if amount >= swapAmount then
				if args:IsPlayer() then
					specWarnSweepingScythe:Show(amount)
					specWarnSweepingScythe:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitIsDeadOrGhost("player") and not UnitDebuff("player", args.spellName) then
						specWarnSweepingScytheTaunt:Show(args.destName)
						specWarnSweepingScytheTaunt:Play("tauntboss")
					else
						warnSweepingScythe:Show(args.destName, amount)
					end
				end
			else
				warnSweepingScythe:Show(args.destName, amount)
			end
		end
	elseif spellId == 258039 then--Heroic
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnDeadlyScythe:Show(amount)
					specWarnDeadlyScythe:Play("stackhigh")
				else
					warnDeadlyScythe:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 258838 then--Mythic
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnSoulrendingScythe:Show(amount)
					specWarnSoulrendingScythe:Play("stackhigh")
				else
					warnSoulRendingScythe:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 248396 then
		warnSoulblight:Show(args.destName)
		if args:IsPlayer() then
			specWarnSoulblight:Show()
			specWarnSoulblight:Play("runout")
			yellSoulblight:Yell()
		end
	elseif spellId == 250669 then
		warnSoulburst:CombinedShow(0.3, args.destName)--2 Targets
		if self.vb.soulBurstIcon > 7 then
			self.vb.soulBurstIcon = 3
		end
		local icon = self.vb.soulBurstIcon
		if args:IsPlayer() then
			specWarnSoulburst:Show()
			specWarnSoulburst:Play("targetyou")
			specWarnSoulburst:ScheduleVoice(self:IsMythic() and 7 or 10, "runout")
			yellSoulburst:Yell(icon == 7 and 2 or 1, icon, icon)
			yellSoulburstFades:Countdown(self:IsMythic() and 12 or 15, nil, icon)
		end
		if self.Options.SetIconOnSoulBurst then
			self:SetIcon(args.destName, icon)
		end
		self.vb.soulBurstIcon = self.vb.soulBurstIcon + 4--Icons 3 and 7 used to match BW
	elseif spellId == 251570 then
		if args:IsPlayer() then
			specWarnSoulbomb:Show()
			specWarnSoulbomb:Play("targetyou")
			self:Schedule(7, delayedBoonCheck, self)
			yellSoulbomb:Yell(2, args.spellName, 2)
			yellSoulbombFades:Countdown(self:IsMythic() and 12 or 15, nil, 2)
		elseif playerAvatar then
			specWarnSoulbombMoveTo:Show(args.destName)
			specWarnSoulbombMoveTo:Play("helpsoak")
		else
			warnSoulbomb:Show(args.destName)
		end
		if self.Options.SetIconOnSoulBomb then
			self:SetIcon(args.destName, 2)
		end
		if self.vb.phase == 4 then
			timerSoulBurstCD:Start(40, 2)
			timerSoulBombCD:Start(80)
			countdownSoulbomb:Start(80)
			timerSoulBurstCD:Start(80, 1)
		else
			timerSoulBurstCD:Start(19.8, 2)
			timerSoulBombCD:Start(42)
			countdownSoulbomb:Start(42)
			timerSoulBurstCD:Start(42, 1)
		end
	elseif spellId == 255199 then
		if self.vb.phase == 2 then--Sometime gets cast once in p3, don't want to start timer if it does
			timerAvatarofAggraCD:Start()
		end
		if args:IsPlayer() then
			specWarnAvatarofAggra:Show()
			specWarnAvatarofAggra:Play("targetyou")
			playerAvatar = true
		else
			warnAvatarofAggra:Show(args.destName)
		end
		if self.Options.SetIconOnAvatar then
			self:SetIcon(args.destName, 4)
		end
	elseif spellId == 253021 then--Inevitability
		if self.Options.NPAuraOnInevitability then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 20)
		end
	elseif spellId == 255496 then--Sword of the Cosmos
		if self.Options.NPAuraOnCosmosSword then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 255478 then--Blades of the Eternal
		if self.Options.NPAuraOnEternalBlades then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 40)
		end
	elseif spellId == 252729 then
		if args:IsPlayer() then
			specWarnCosmicRay:Show()
			specWarnCosmicRay:Play("targetyou")
			yellCosmicRay:Yell()
		else
			warnCosmicRay:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 252616 then
		if args:IsPlayer() then
			specWarnCosmicBeacon:Show()
			specWarnCosmicBeacon:Play("runout")
			yellCosmicBeacon:Yell()
		else
			warnCosmicBeacon:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 258647 then--Gift of Sea
		warnSkyandSea:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnGiftofSea:Show()
			specWarnGiftofSea:Play("targetyou")
			yellGiftofSea:Yell()
		end
		if self.Options.SetIconGift then
			self:SetIcon(args.destName, 6)
		end
	elseif spellId == 258646 then--Gift of Sky
		warnSkyandSea:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnGiftofSky:Show()
			specWarnGiftofSky:Play("targetyou")
			yellGiftofSky:Yell()
		end
		if self.Options.SetIconGift then
			self:SetIcon(args.destName, 5)
		end
	elseif spellId == 255433 or spellId == 255430 or spellId == 255429 or spellId == 255425 or spellId == 255422 or spellId == 255419 or spellId == 255418 then--Vulnerability
		if self.Options.NPAuraOnVulnerability then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
		if self.Options.SetIconOnVulnerability then
			if spellId == 255433 then--Arcane
				self:ScanForMobs(args.destGUID, 2, 5, 1, 0.2, 15)
			elseif spellId == 255430 then--Shadow
				self:ScanForMobs(args.destGUID, 2, 3, 1, 0.2, 15)
			elseif spellId == 255429 then--Fire
				self:ScanForMobs(args.destGUID, 2, 2, 1, 0.2, 15)
			elseif spellId == 255425 then--Frost
				self:ScanForMobs(args.destGUID, 2, 6, 1, 0.2, 15)
			elseif spellId == 255422 then--Nature
				self:ScanForMobs(args.destGUID, 2, 4, 1, 0.2, 15)
			elseif spellId == 255419 then--Holy
				self:ScanForMobs(args.destGUID, 2, 1, 1, 0.2, 15)
			elseif spellId == 255418 then--Melee
				self:ScanForMobs(args.destGUID, 2, 7, 1, 0.2, 15)
			end
		end
	elseif spellId == 257869 then
		warnSargRage:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSargRage:Show()
			specWarnSargRage:Play("scatter")
			yellSargRage:Yell()
		end
	elseif spellId == 257931 then
		warnSargFear:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSargFear:Show(DBM_ALLY)
			specWarnSargFear:Play("gathershare")
			yellSargFear:Yell()
		end
	elseif spellId == 257966 then--Sentence of Sargeras
		if self:AntiSpam(5, 6) then
			self:Unschedule(checkForMissingSentence)
			self.vb.sentenceCount = self.vb.sentenceCount + 1
			local timer = sargSentence[self.vb.sentenceCount+1]
			if timer then
				timerSargSentenceCD:Start(timer, self.vb.sentenceCount+1)
				self:Schedule(timer+10, checkForMissingSentence, self)--Check for missing sentence event 10 seconds after expected to recover timer if all immuned
			end
		end
		warnSargSentence:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSargSentence:Show()
			specWarnSargSentence:Play("targetyou")
			yellSargSentence:Yell()
			yellSargSentenceFades:Countdown(30)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 250669 then
		if args:IsPlayer() then
			yellSoulburstFades:Cancel()
			specWarnSoulburst:CancelVoice()
		end
		if self.Options.SetIconOnSoulBurst then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 251570 then
		if args:IsPlayer() then
			self:Unschedule(delayedBoonCheck)
			yellSoulbombFades:Cancel()
		end
		if self.Options.SetIconOnSoulBomb then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 255199 then
		if args:IsPlayer() then
			playerAvatar = false
		end
		if self.Options.SetIconOnAvatar then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 258647 then--Gift of Sea
		if self.Options.SetIconGift then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 258646 then--Gift of Sky
		if self.Options.SetIconGift then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 253021 then--Inevitability
		if self.Options.NPAuraOnInevitability then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 255496 then--Sword of the Cosmos
		if self.Options.NPAuraOnCosmosSword then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 255478 then--Blades of the Eternal
		if self.Options.NPAuraOnEternalBlades then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 255433 or spellId == 255430 or spellId == 255429 or spellId == 255425 or spellId == 255422 or spellId == 255419 or spellId == 255418 then--Vulnerability
		if self.Options.NPAuraOnVulnerability then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 258039 then--Heroic
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			if not args:IsPlayer() then--Removed from tank that's not you (only time it's removed is on death)
				specWarnDeadlyScytheTaunt:Show(args.destName)
				specWarnDeadlyScytheTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 258838 then--Mythic
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			if not args:IsPlayer() then--Removed from tank that's not you (only time it's removed is on death)
				specWarnSoulrendingScytheTaunt:Show(args.destName)
				specWarnSoulrendingScytheTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 257966 then--Sentence of Sargeras
		if args:IsPlayer() then
			yellSargSentenceFades:Cancel()
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 256544 then
		self.vb.TorturedRage = 0
		if self:IsMythic() then
			self.vb.gazeCount = 0
			self.vb.EdgeofObliteration = 0
			timerSoulrendingScytheCD:Start(3.5)
			timerEdgeofAnniCD:Start(5, 1)
			self:Schedule(5, startAnnihilationStuff, self)
			timerSargGazeCD:Start(23, 1)
			timerReorgModuleCD:Start(31.3, 1)
			countdownReorgModule:Start(31.3)
			timerTorturedRageCD:Start(40, 1)
			timerSargSentenceCD:Start(53, 1)
		else
			if not self:IsHeroic() then
				timerSweepingScytheCD:Start(5, 1)
			else
				timerDeadlyScytheCD:Start(5)
			end
			local currentPowerPercent = UnitPower("boss1")/UnitPowerMax("boss1")
			local remainingPercent
			if currentPowerPercent then
				remainingPercent = 1.0 - currentPowerPercent
			end
			if remainingPercent then
				timerReorgModuleCD:Start(48.1*remainingPercent, 1)
				countdownReorgModule:Start(48.1*remainingPercent)
			end
			timerTorturedRageCD:Start(10, 1)
			timerSoulBurstCD:Start(20, 1)--First one is only burst, afterwards it's bomb and burst then burst only again
			timerSoulBombCD:Start(20)
			countdownSoulbomb:Start(20)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 248167 and destGUID == UnitGUID("player") and self:AntiSpam(2, 5) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellId)
	if spellId == 257300 and self:AntiSpam(5, 1) then--Ember of Rage
		specWarnEmberofRage:Show()
		specWarnEmberofRage:Play("watchstep")
	elseif spellId == 34098 and self.vb.phase == 2 then--ClearAllDebuffs (12 before Tempoeral Blast)
		self.vb.phase = 3
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(3))
		timerSweepingScytheCD:Stop()
		timerTorturedRageCD:Stop()
		timerSoulBombCD:Stop()
		countdownSoulbomb:Cancel()
		timerSoulBurstCD:Stop()
		timerEdgeofObliterationCD:Stop()
		timerSargGazeCD:Stop()
		if not self:IsMythic() then
			timerCosmicRayCD:Start(42)
			timerCosmicBeaconCD:Start(52)
			if self.Options.InfoFrame then
				DBM.InfoFrame:Hide()
			end
		end
	elseif spellId == 258068 then--Sargeras' Gaze
		self.vb.gazeCount = self.vb.gazeCount + 1
		if self.vb.phase == 2 then
			timerSargGazeCD:Start(60, self.vb.gazeCount+1)
		elseif self.vb.phase == 3 then
			local timer = sargGaze[self.vb.gazeCount+1]
			if timer then
				timerSargGazeCD:Start(timer, self.vb.gazeCount+1)
			end
		else--Stage 1
			timerSargGazeCD:Start(35.2, self.vb.gazeCount+1)
		end
	end
end
