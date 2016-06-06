local mod	= DBM:NewMod(1427, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(92330)
mod:SetEncounterID(1794)
mod:SetZone()
mod:SetUsedIcons(1)
mod:SetHotfixNoticeRev(14550)
--mod.respawnTime = 20

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 180008 181288 182051 183331 183329 184239 182392 188693",
	"SPELL_CAST_SUCCESS 184124 190776 183023",
	"SPELL_AURA_APPLIED 182038 182769 182900 184124 188666 189627 190466 184053 183017 180415",
	"SPELL_AURA_APPLIED_DOSE 182038",
	"SPELL_AURA_REMOVED 184124 189627 190466 184053",
	"UNIT_DIED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, Prisons had no workable targetting of any kind during test. Study of logs and even videos showed no valid target scanning, debuff, whisper, nothing. As such, only aoe warning :\
--TODO, voice for reverberatingblow removed since it's instant cast and currently a bit wonky/buggy. Needs further review later.
--TODO, first construct timers after a soul phase
--(ability.id = 183331 or ability.name="Soul Dispersion") and overkill > 0 or ability.id = 190466 or (ability.id = 181288 or ability.id = 182051 or ability.id = 183331 or ability.id = 183329 or ability.id = 188693) and type = "begincast" or (ability.id = 180008 or ability.id = 184124 or ability.id = 190776 or ability.id = 183023) and type = "cast" or (ability.id = 184053 or ability.id = 189627) and (type = "applydebuff" or type = "applybuff")
--Soulbound Construct
local warnFelPrison					= mod:NewTargetAnnounce(183017, 3)
local warnShatteredDefenses			= mod:NewStackAnnounce(182038, 3, nil, "Tank")
local warnVolatileFelOrb			= mod:NewTargetAnnounce(180221, 4)
local warnFelCharge					= mod:NewTargetAnnounce(182051, 3)
--Socrethar
local warnEjectSoul					= mod:NewSpellAnnounce(183023, 2)
--Adds
local warnGhastlyFixation			= mod:NewTargetAnnounce(182769, 3, nil, false)--Spammy
local warnVirulentHaunt				= mod:NewTargetAnnounce(182900, 4, nil, false)--Failed at fixate. Also spammy
local warnGiftoftheManari			= mod:NewTargetAnnounce(184124, 4)
local warnEternalHunger				= mod:NewTargetAnnounce(188666, 3)--Mythic

--Soulbound Construct
local specWarnReverberatingBlow		= mod:NewSpecialWarningCount(180008, "Tank", nil, nil, 1)
local specWarnFelPrison				= mod:NewSpecialWarningDodge(181288, nil, nil, nil, 2, 2)
local specWarnVolatileFelOrb		= mod:NewSpecialWarningRun(180221, nil, nil, nil, 4, 2)
local yellVolatileFelOrb			= mod:NewYell(180221)
local specWarnFelChargeYou			= mod:NewSpecialWarningYou(182051, nil, nil, nil, 1, 2)
local yellCharge					= mod:NewYell(182051)
local specWarnFelCharge				= mod:NewSpecialWarningTarget(182051, "Melee", nil, nil, 2, 2)--Boss will often go through melee most of time, so they still need generic warning.
local specWarnApocalypticFelburst	= mod:NewSpecialWarningCount(188693, nil, nil, nil, 2, 2)--Mythic
local specWarnSoulstalker			= mod:NewSpecialWarningCount("ej11778", nil, nil, nil, 2, 2)
--Socrethar
local specWarnExertDominance		= mod:NewSpecialWarningInterruptCount(183331, "HasInterrupt", nil, 2, 1, 2)
local specWarnApocalypse			= mod:NewSpecialWarningSpell(183329, nil, nil, nil, 2, 2)
--Adds
local specWarnShadowWordAgony		= mod:NewSpecialWarningInterrupt(184239, false, nil, nil, 1, 2)
local specWarnShadowBoltVolley		= mod:NewSpecialWarningInterrupt(182392, "HasInterrupt", nil, 2, 1, 2)
local specWarnSouls					= mod:NewSpecialWarningCount("ej11462", nil, nil, nil, 1)
local specWarnGhastlyFixation		= mod:NewSpecialWarningYou(182769, nil, nil, nil, 1)--You don't run out or kite. you position yourself so ghosts go through fire dropped by construct
local specWarnSargereiDominator		= mod:NewSpecialWarningSwitchCount("ej11456", "-Healer", nil, nil, 3)
local specWarnGiftoftheManari		= mod:NewSpecialWarningYou(184124, nil, nil, nil, 1, 2)
local yellGiftoftheManari			= mod:NewYell(184124)
local specWarnEternalHunger			= mod:NewSpecialWarningRun(188666, nil, nil, nil, 4, 2)--Mythic
local yellEternalHunger				= mod:NewYell(188666, nil, false)

--Soulbound Construct
local timerReverberatingBlowCD		= mod:NewCDCountTimer(17, 180008, nil, "Tank|Healer", 2, 5, nil, DBM_CORE_TANK_ICON)
local timerFelPrisonCD				= mod:NewCDTimer(29, 182994, nil, nil, nil, 3)--29-33
local timerVolatileFelOrbCD			= mod:NewCDTimer(23, 180221, 186532, nil, nil, 3)
local timerFelChargeCD				= mod:NewCDTimer(23, 182051, nil, nil, nil, 3)
local timerApocalypticFelburstCD	= mod:NewCDCountTimer(30, 188693, 206388, nil, nil, 2, nil, DBM_CORE_HEROIC_ICON)
--Socrethar
local timerExertDominanceCD			= mod:NewCDCountTimer(4.5, 183331, nil, "-Healer", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerApocalypseCD				= mod:NewCDTimer(46, 183329, nil, nil, nil, 2)
--Adds
local timerSargereiDominatorCD		= mod:NewNextCountTimer(60, "ej11456", nil, nil, nil, 1, 184053)
local timerHauntingSoulCD			= mod:NewCDCountTimer(29, "ej11462", nil, nil, nil, 1, 182769)
local timerGiftofManariCD			= mod:NewCDTimer(11, 184124, nil, nil, nil, 3)
--Mythic
local timerVoraciousSoulstalkerCD	= mod:NewCDCountTimer(59.5, "ej11778", 151869, nil, nil, 1, 190776, DBM_CORE_HEROIC_ICON)

--local berserkTimer				= mod:NewBerserkTimer(360)

local countdownReverberatingBlow	= mod:NewCountdown(17, 180008, "Tank", nil, 4)--Every 17 seconds now, so count last 4
local countdownCharge				= mod:NewCountdown("Alt23", 182051)
local countdownSouls				= mod:NewCountdown(29, "ej11462")

--Construct
local voiceVolatileFelOrb			= mod:NewVoice(180221)--runout/keepmove
local voiceFelblazeCharge			= mod:NewVoice(182051)--runout/chargemove
local voiceFelPrison				= mod:NewVoice(182994)--watchstep
local voiceFelBurst					= mod:NewVoice(188693)--watchstep
local voiceVoraciousSoulstalker		= mod:NewVoice("ej11778")--watchstep
--Socrethar
local timerTransition				= mod:NewPhaseTimer(6.5)
local voiceExertDominance			= mod:NewVoice(183331, "HasInterrupt")--kickcast
local voiceApocalypse				= mod:NewVoice(183329)--aesoon
--Adds
local voiceShadowWordAgony			= mod:NewVoice(184239, false)--kickcast
local voiceShadowBoltVolley			= mod:NewVoice(182392, "HasInterrupt")--kickcast
--local voiceGhastlyFixation			= mod:NewVoice(182769)--runout/keepmove
local voiceGiftoftheManari			= mod:NewVoice(184124)--scatter
local voiceEternalHunger			= mod:NewVoice(188666)--runout/keepmove

mod:AddRangeFrameOption(10, 184124)
mod:AddHudMapOption("HudMapOnOrb", 180221)
mod:AddHudMapOption("HudMapOnCharge", 182051)
mod:AddSetIconOption("SetIconOnCharge", 182051, true)
mod:AddDropdownOption("InterruptBehavior", {"Count3Resume", "Count3Reset", "Count4Resume", "Count4Reset"}, "Count3Resume", "misc")

mod.vb.ReverberatingBlow = 0
mod.vb.felBurstCount = 0
mod.vb.ManariTargets = 0
mod.vb.mythicAddSpawn = 0
mod.vb.ghostSpawn = 0
mod.vb.kickCount2 = 0
mod.vb.barrierUp = false
mod.vb.dominatorCount = 0
mod.vb.interruptBehavior = "Count3Resume"
local soulsSeen = {}
local playerInConstruct = false
local exertSpellName = GetSpellInfo(183331)
local debuffName = GetSpellInfo(184124)
local UnitDebuff = UnitDebuff
local debuffFilter
do
	debuffFilter = function(uId)
		if UnitDebuff(uId, debuffName) then
			return true
		end
	end
end

local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self.vb.ManariTargets > 0 then
		if UnitDebuff("player", debuffName) then
			DBM.RangeCheck:Show(10)
		else
			DBM.RangeCheck:Show(10, debuffFilter)
		end
	else
		DBM.RangeCheck:Hide()
	end
end

--if this isn't accurate, or isn't as fast as listing to RAID_BOSS_WHISPER sync i'll switch to a RAID_BOSS_WHISPER transcriptor listener
function mod:ChargeTarget(targetname, uId)
	if not targetname then
		specWarnFelCharge:Show(DBM_CORE_UNKNOWN)
		voiceFelblazeCharge:Play("chargemove")
		return
	end
	if targetname == UnitName("player") then
		if self:AntiSpam(2, 3) then
			specWarnFelChargeYou:Show()
			yellCharge:Yell()
			voiceFelblazeCharge:Play("runout")
		end
	elseif self.Options.SpecWarn182051target then
		specWarnFelCharge:Show(targetname)
		voiceFelblazeCharge:Play("chargemove")
	else
		warnFelCharge:Show(targetname)
	end
	if self.Options.HudMapOnCharge then
		local currentTank = self:GetCurrentTank(90296)
		if currentTank then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(182051, "party", targetname, 0.35, 4, nil, nil, nil, 0.5, nil, false):Appear():SetLabel(targetname, nil, nil, nil, nil, nil, 0.8, nil, -13, 8, nil)
			if targetname == UnitName("player") then
				DBMHudMap:AddEdge(1, 1, 0, 0.5, 4, currentTank, targetname, nil, nil, nil, nil, 125)
			else
				DBMHudMap:RegisterRangeMarkerOnPartyMember(182051, "party", UnitName("player"), 0.7, 4, nil, nil, nil, 1, nil, false):Appear()
				DBMHudMap:AddEdge(1, 0, 0, 0.5, 4, currentTank, targetname, nil, nil, nil, nil, 125)
			end
		else--Old school
			DBM:Debug("Tank Detection Failure in HudMapOnCharge", 2)
			DBMHudMap:RegisterRangeMarkerOnPartyMember(182051, "highlight", targetname, 5, 4, 1, 0, 0, 0.5, nil, true, 2):Pulse(0.5, 0.5)
		end
	end
	if self.Options.SetIconOnCharge then
		self:SetIcon(targetname, 1, 4)
	end
end

function mod:OnCombatStart(delay)
	self.vb.interruptBehavior = "Count3Resume"
	self.vb.ReverberatingBlow = 0
	self.vb.ManariTargets = 0
	self.vb.felBurstCount = 0
	self.vb.mythicAddSpawn = 0
	self.vb.ghostSpawn = 0
	self.vb.kickCount2 = 0
	self.vb.dominatorCount = 0
	self.vb.barrierUp = false
	playerInConstruct = false
	table.wipe(soulsSeen)
	timerReverberatingBlowCD:Start(4.3-delay, 1)
	countdownReverberatingBlow:Start(4.3-delay)
	timerVolatileFelOrbCD:Start(12-delay)
	timerFelChargeCD:Start(29-delay)
	countdownCharge:Start(29-delay)
	timerFelPrisonCD:Start(51-delay)--Seems drastically changed. 51 in all newer logs
	if self:IsMythic() then
		timerVoraciousSoulstalkerCD:Start(20-delay, 1)
		timerApocalypticFelburstCD:Start(33.7-delay, 1)
	end
	if UnitIsGroupLeader("player") and not self:IsLFR() then
		if self.Options.InterruptBehavior == "Count3Resume" then
			self:SendSync("Count3Resume")
		elseif self.Options.InterruptBehavior == "Count3Reset" then
			self:SendSync("Count3Reset")
		elseif self.Options.InterruptBehavior == "Count4Resume" then
			self:SendSync("Count4Resume")
		elseif self.Options.InterruptBehavior == "Count4Reset" then
			self:SendSync("Count4Reset")
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnOrb or self.Options.HudMapOnCharge then
		DBMHudMap:Disable()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 180008 then
		self.vb.ReverberatingBlow = self.vb.ReverberatingBlow + 1
		timerReverberatingBlowCD:Start(nil, self.vb.ReverberatingBlow+1)
		countdownReverberatingBlow:Start()
		specWarnReverberatingBlow:Show(self.vb.ReverberatingBlow)
	elseif spellId == 181288 then
		specWarnFelPrison:Show()
		if self:IsNormal() then
			timerFelPrisonCD:Start(46.4)
		else
			timerFelPrisonCD:Start()
		end
		voiceFelPrison:Play("watchstep")
	elseif spellId == 182051 then
		if self:IsNormal() then
			timerFelChargeCD:Start(30)
			countdownCharge:Start(30)
		else
			timerFelChargeCD:Start()
			countdownCharge:Start()
		end
		--Must have delay, to avoid same bug as oregorger. Boss has 2 target scans
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "ChargeTarget", 0.1, 10, true)
	elseif spellId == 183331 then
		if not self.vb.barrierUp then
			self.vb.kickCount2 = self.vb.kickCount2 + 1
			if self:CheckInterruptFilter(args.sourceGUID) and not playerInConstruct then
				specWarnExertDominance:Show(args.sourceName, self.vb.kickCount2)
				if self.vb.kickCount2 == 1 then
					voiceExertDominance:Play("kick1r")
				elseif self.vb.kickCount2 == 2 then
					voiceExertDominance:Play("kick2r")
				elseif self.vb.kickCount2 == 3 then
					voiceExertDominance:Play("kick3r")
				elseif self.vb.kickCount2 == 4 then
					voiceExertDominance:Play("kick4r")
				end
			end
		end
		if (self.vb.interruptBehavior == "Count3Resume" or self.vb.interruptBehavior == "Count3Reset") and self.vb.kickCount2 >= 3 or self.vb.kickCount2 >= 4 then
			self.vb.kickCount2 = 0
		end
		timerExertDominanceCD:Start(nil, self.vb.kickCount2+1)
	elseif spellId == 183329 then
		specWarnApocalypse:Show()
		voiceApocalypse:Play("aesoon")
		if self:IsNormal() then
			timerApocalypseCD:Start(48)--48-49
		else
			timerApocalypseCD:Start()
		end
	elseif spellId == 184239 and self:CheckInterruptFilter(args.sourceGUID) and not playerInConstruct then
		specWarnShadowWordAgony:Show(args.sourceName)
		voiceShadowWordAgony:Play("kickcast")
	elseif spellId == 182392 and self:CheckInterruptFilter(args.sourceGUID) and not playerInConstruct then
		specWarnShadowBoltVolley:Show(args.sourceName)
		voiceShadowBoltVolley:Play("kickcast")
	elseif spellId == 188693 then
		self.vb.felBurstCount = self.vb.felBurstCount + 1
		specWarnApocalypticFelburst:Show(self.vb.felBurstCount)
		timerApocalypticFelburstCD:Start()
		voiceFelBurst:Play("watchstep")
	end
end


function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 184124 then
		if self:IsNormal() then
			timerGiftofManariCD:Start(30, args.sourceGUID)
		else
			timerGiftofManariCD:Start(args.sourceGUID)
		end
	elseif spellId == 190776 then--Voracious Soulstalker Spawning
		self.vb.mythicAddSpawn = self.vb.mythicAddSpawn + 1
		specWarnSoulstalker:Show(self.vb.mythicAddSpawn)
		voiceVoraciousSoulstalker:Play("watchstep")
		timerVoraciousSoulstalkerCD:Start(60, self.vb.mythicAddSpawn+1)
	elseif spellId == 183023 then--Eject Soul
		self.vb.dominatorCount = 0
		self.vb.ghostSpawn = 0
		self.vb.kickCount2 = 0
		warnEjectSoul:Show()
		timerReverberatingBlowCD:Stop()
		countdownReverberatingBlow:Cancel()
		timerFelPrisonCD:Stop()
		timerVolatileFelOrbCD:Stop()
		timerFelChargeCD:Stop()
		timerApocalypticFelburstCD:Stop()
		timerTransition:Start()--Time until boss is attackable
		timerSargereiDominatorCD:Start(23, 1)
		timerHauntingSoulCD:Start(30, 1)--30-33
		countdownSouls:Start(30)
		timerApocalypseCD:Start(53)--53-58
		self:RegisterShortTermEvents(
			"UNIT_TARGETABLE_CHANGED"
		)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 182038 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId, "boss1") then
			local amount = args.amount or 1
			warnShatteredDefenses:Cancel()
			warnShatteredDefenses:Schedule(0.3, args.destName, amount)
		end
	elseif spellId == 182769 then
		warnGhastlyFixation:CombinedShow(2, args.destName)
		if args:IsPlayer() and self:AntiSpam(3, 1) then
			specWarnGhastlyFixation:Show()
--			voiceGhastlyFixation:Play("runout")
--			voiceGhastlyFixation:Schedule(2, "keepmove")
		end
		if not soulsSeen[args.sourceGUID] then
			soulsSeen[args.sourceGUID] = true
			if self:AntiSpam(10, 2) then--Antispam also needed to filter all but first ghost after a fresh spawn
				self.vb.ghostSpawn = self.vb.ghostSpawn + 1
				if self.vb.ghostSpawn % 4 == 0 then--Every portal swap adds 10-11 seconds to next spawn, so 5, 9, 13 etc
					timerHauntingSoulCD:Start(40, self.vb.ghostSpawn+1)
					if playerInConstruct then
						specWarnSouls:Show(self.vb.ghostSpawn)
						countdownSouls:Start(40)
					end
				else
					timerHauntingSoulCD:Start(nil, self.vb.ghostSpawn+1)
					if playerInConstruct then
						specWarnSouls:Show(self.vb.ghostSpawn)
						countdownSouls:Start(29)
					end
				end
			end
		end
	elseif spellId == 188666 and args:IsDestTypePlayer() then
		if args:IsPlayer() then
			specWarnEternalHunger:Show()
			yellEternalHunger:Yell()
			voiceEternalHunger:Play("runout")
			voiceEternalHunger:Schedule(2, "keepmove")
		else
			warnEternalHunger:Show(args.destName)
		end	
	elseif spellId == 182900 then
		warnVirulentHaunt:CombinedShow(0.5, args.destName)
	elseif spellId == 184124 then
		self.vb.ManariTargets = self.vb.ManariTargets + 1
		warnGiftoftheManari:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnGiftoftheManari:Show()
			yellGiftoftheManari:Yell()
			voiceGiftoftheManari:Play("scatter")
		end
		updateRangeFrame(self)
	elseif spellId == 184053 then--Fel Barrior (Boss becomes immune to damage, Sargerei Dominator spawned and must die)
		self.vb.barrierUp = true
		self.vb.dominatorCount = self.vb.dominatorCount + 1
		specWarnSargereiDominator:Show(self.vb.dominatorCount)
		if self:IsMythic() then
			timerSargereiDominatorCD:Start(130, self.vb.dominatorCount+1)
		else
			if self.vb.dominatorCount % 2 == 0 then--Every portal swap adds 10 seconds to next spawn, so 3, 5, 7 etc
				timerSargereiDominatorCD:Start(68.5, self.vb.dominatorCount+1)
			else
				timerSargereiDominatorCD:Start(nil, self.vb.dominatorCount+1)
			end
		end
		timerGiftofManariCD:Start(5, args.sourceGUID)
	elseif spellId == 189627 then
		if self:IsNormal() then
			timerVolatileFelOrbCD:Start(30)
		else
			timerVolatileFelOrbCD:Start()
		end
		if args:IsPlayer() then
			specWarnVolatileFelOrb:Show()
			yellVolatileFelOrb:Yell()
			voiceVolatileFelOrb:Play("runout")
			voiceVolatileFelOrb:Schedule(2, "keepmove")
		else
			warnVolatileFelOrb:Show(args.destName)
		end
		if self.Options.HudMapOnOrb then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(180221, "highlight", args.destName, 5, 20, 1, 1, 0, 0.5, nil, true, 1):Pulse(0.5, 0.5)
		end
	elseif spellId == 190466 then
		if args.sourceGUID == UnitGUID("player") then
			playerInConstruct = true
		else
			--At time this starts, don't know who construct will be
			--So started for all, then canceled for all but player who becomes construct
			countdownSouls:Cancel()
		end
	elseif (spellId == 183017 or spellId == 180415) and self:AntiSpam(5, args.destName) and args:GetDestCreatureID() ~= 91765 then
		warnFelPrison:CombinedShow(0.3, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 184124 then
		self.vb.ManariTargets = self.vb.ManariTargets - 1
		updateRangeFrame(self)
	elseif spellId == 189627 then
		if self.Options.HudMapOnOrb then
			DBMHudMap:FreeEncounterMarkerByTarget(180221, args.destName)
		end
	elseif spellId == 190466 and args.sourceGUID == UnitGUID("player") then
		playerInConstruct = false
	elseif spellId == 184053 then
		self.vb.barrierUp = false
		if self.vb.interruptBehavior == "Count3Reset" or self.vb.interruptBehavior == "Count4Reset" then
			local elapsed, total = timerExertDominanceCD:GetTime(nil, self.vb.kickCount2+1)
			if total > 0 then--Timer exists
				timerExertDominanceCD:Stop()
				timerExertDominanceCD:Update(elapsed, total, 1)--Update timer to show count start over
			end
			self.vb.kickCount2 = 0
		end
		--Check if there is an interruptable cast in progress when barrier drops
		local name, _, _, _, _, endTime = UnitCastingInfo("boss1")
		if not name then return end
		if name == exertSpellName and GetTime() - endTime > 0.5 then--It's still possible to interrupt it
			if self.vb.kickCount2 == 0 then self.vb.kickCount2 = 1 end
			if self:CheckInterruptFilter(args.destGUID) and not playerInConstruct then
				specWarnExertDominance:Show(args.destName, self.vb.kickCount2)
				if self.vb.kickCount2 == 1 then
					voiceExertDominance:Play("kick1r")
				elseif self.vb.kickCount2 == 2 then
					voiceExertDominance:Play("kick2r")
				elseif self.vb.kickCount2 == 3 then
					voiceExertDominance:Play("kick3r")
				elseif self.vb.kickCount2 == 4 then
					voiceExertDominance:Play("kick4r")
				end
			end
			self.vb.kickCount2 = self.vb.kickCount2 + 1
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 92767 then--Sargerei Dominator
		timerGiftofManariCD:Cancel(args.destGUID)
	end
end

--backup, in event of target scan fail.
function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:184247") then--Charge
		if self:AntiSpam(2, 3) then
			specWarnFelChargeYou:Show()
			yellCharge:Yell()
			voiceFelblazeCharge:Play("runout")
		end
	end
end

--"<319.15 14:07:11> [CLEU] SPELL_DAMAGE#Creature-0-2083-1448-3074-92330-00007BAAB0#Soul of Socrethar#Vehicle-0-2083-1448-3074-90296-00007BAAB0#Soulbound Construct#183331#Exert Dominance#1604371#641748",
--"<319.39 14:07:11> [UNIT_TARGETABLE_CHANGED] boss1#false#false#true#Soul of Socrethar#Creature-0-2083-1448-3074-92330-00007BAAB0#elite#68266252", -- [6778]
--"<321.83 14:07:13> [UNIT_SPELLCAST_SUCCEEDED] Soulbound Construct(??) [[boss2:Construct is Evil::0:180257]]", -- [6826]
function mod:UNIT_TARGETABLE_CHANGED(uId)
	local cid = self:GetCIDFromGUID(UnitGUID(uId))
	if (cid == 92330) and not UnitExists(uId) then--Socrethar returning inactive and construct phase beginning again.
		self.vb.felBurstCount = 0
		self.vb.ReverberatingBlow = 0
		timerExertDominanceCD:Stop()
		timerSargereiDominatorCD:Stop()
		timerHauntingSoulCD:Stop()
		countdownSouls:Cancel()
		timerApocalypseCD:Stop()
		self:UnregisterShortTermEvents()
		timerVolatileFelOrbCD:Start(13)
		timerFelChargeCD:Start(30.5)
		countdownCharge:Start(30.5)
		timerFelPrisonCD:Start(50)
		if self:IsMythic() then
			timerReverberatingBlowCD:Start(11, 1)
			countdownReverberatingBlow:Start(11)
			timerVoraciousSoulstalkerCD:Start(20, 1)
			timerApocalypticFelburstCD:Start(nil, 1)
		else
			timerReverberatingBlowCD:Start(8, 1)
			countdownReverberatingBlow:Start(8)
		end
	end
end

function mod:OnSync(msg)
	if self:IsLFR() then return end
	if msg == "Count3Resume" then
		self.vb.interruptBehavior = "Count3Resume"
	elseif msg == "Count3Reset" then
		self.vb.interruptBehavior = "Count3Reset"
	elseif msg == "Count4Resume" then
		self.vb.interruptBehavior = "Count4Resume"
	elseif msg == "Count4Reset" then
		self.vb.interruptBehavior = "Count4Reset"
	end	
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
--]]
