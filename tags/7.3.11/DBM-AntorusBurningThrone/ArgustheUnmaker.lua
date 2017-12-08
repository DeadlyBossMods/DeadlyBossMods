local mod	= DBM:NewMod(2031, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(124828)
mod:SetEncounterID(2092)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7)
mod:SetHotfixNoticeRev(16895)
mod:SetMinSyncRevision(16895)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 248165 248317 257296 255594 257645 252516 256542 255648 257619 255935",
	"SPELL_CAST_SUCCESS 248499 258039 252729 252616 256388",
	"SPELL_AURA_APPLIED 248499 248396 250669 251570 255199 253021 255496 255496 255478 252729 252616 255433 255430 255429 255425 255422 255419 255418 258647 258646",
	"SPELL_AURA_APPLIED_DOSE 248499 258039",
	"SPELL_AURA_REMOVED 250669 251570 255199 253021 255496 255496 255478 252616 255433 255430 255429 255425 255422 255419 255418 258039",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, death fog GTFO
--TODO, custom warning to combine soulburst and bomb into single message instead of two messages, while still separating targets
--TODO, interrupt warnings for Designates if not affected by Inevitability?
--TODO, taunt warning and icon setting when adds get blades, to help tank pickup?
--TODO, info frame for stage 4 (and other stages maybe) to show realms, and other stats, energy of boss and eonar's aid
--TODO, warnings when eonar transitions from gift to withering. other titan stuff?
--[[
(ability.id = 256544 or ability.id = 255826 or ability.id = 248165 or ability.id = 248317 or ability.id = 257296 or ability.id = 255594 or ability.id = 252516 or ability.id = 255648 or ability.id = 257645 or ability.id = 256542 or ability.id = 257619 or ability.id = 255935) and type = "begincast"
 or (ability.id = 248499 or ability.id = 258039 or ability.id = 252729 or ability.id = 252616 or ability.id = 256388) and type = "cast"
 or (ability.id = 250669 or ability.id = 251570 or ability.id = 255199) and type = "applydebuff" or type = "interrupt" and target.id = 124828
--]]
--Stage One: Storm and Sky
local warnTorturedRage				= mod:NewCountAnnounce(257296, 2)
local warnSweepingScythe			= mod:NewStackAnnounce(248499, 2, nil, "Tank")
local warnBlightOrb					= mod:NewSpellAnnounce(248317, 2)
local warnSoulblight				= mod:NewTargetAnnounce(248396, 2, nil, false, 2)
local warnSkyandSea					= mod:NewTargetAnnounce(255594, 1)
--Stage Two: The Protector Redeemed
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnSoulburst					= mod:NewTargetAnnounce(250669, 2)
local warnSoulbomb					= mod:NewTargetAnnounce(251570, 3)
local warnAvatarofAggra				= mod:NewTargetAnnounce(255199, 1)
--Stage Three: The Arcane Masters
local warnPhase3					= mod:NewPhaseAnnounce(3, 2)
local warnCosmicRay					= mod:NewTargetAnnounce(252729, 3)
local warnCosmicBeacon				= mod:NewTargetAnnounce(252616, 2)
local warnDiscsofNorg				= mod:NewCastAnnounce(252516, 1)
--Stage Four: The Gift of Life, The Forge of Loss (Non Mythic)
local warnGiftOfLifebinder			= mod:NewCastAnnounce(257619, 1)
local warnPhase4					= mod:NewPhaseAnnounce(4, 2)
local warnDeadlyScythe				= mod:NewStackAnnounce(258039, 2, nil, "Tank")

--Stage One: Storm and Sky
--local specWarnTorturedRage			= mod:NewSpecialWarningCount(257296, nil, nil, nil, 2, 2)
local specWarnSweepingScythe		= mod:NewSpecialWarningStack(248499, nil, 3, nil, nil, 1, 6)
local specWarnSweepingScytheTaunt	= mod:NewSpecialWarningTaunt(248499, nil, nil, nil, 1, 2)
local specWarnConeofDeath			= mod:NewSpecialWarningDodge(248165, nil, nil, nil, 1, 2)
local specWarnSoulblight			= mod:NewSpecialWarningMoveAway(248396, nil, nil, nil, 1, 2)
local yellSoulblight				= mod:NewYell(248396)
local specWarnGiftofSea				= mod:NewSpecialWarningYou(258647, nil, nil, nil, 1, 2)
local yellGiftofSea					= mod:NewYell(258647)
local specWarnGiftofSky				= mod:NewSpecialWarningYou(258646, nil, nil, nil, 1, 2)
local yellGiftofSky					= mod:NewYell(258646)
--local yellBurstingDreadflame		= mod:NewPosYell(238430, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
--local specWarnMalignantAnguish		= mod:NewSpecialWarningInterrupt(236597, "HasInterrupt")
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Stage Two: The Protector Redeemed
local specWarnSoulburst				= mod:NewSpecialWarningMoveAway(250669, nil, nil, nil, 1, 2)
local yellSoulburst					= mod:NewPosYell(250669)
local yellSoulburstFades			= mod:NewIconFadesYell(250669)
local specWarnSoulbomb				= mod:NewSpecialWarningYou(251570, nil, nil, nil, 1, 2)
local specWarnSoulbombMoveTo		= mod:NewSpecialWarningMoveTo(251570, nil, nil, nil, 1, 7)
local yellSoulbomb					= mod:NewYell(251570)
local yellSoulbombFades				= mod:NewFadesYell(251570)
local specWarnEdgeofObliteration	= mod:NewSpecialWarningSpell(255826, nil, nil, nil, 2, 2)
local specWarnAvatarofAggra			= mod:NewSpecialWarningYou(255199, nil, nil, nil, 1, 2)
--Stage Three: The Arcane Masters
local specWarnCosmicRay				= mod:NewSpecialWarningYou(252729, nil, nil, nil, 1, 2)
local yellCosmicRay					= mod:NewYell(252729)
local specWarnCosmicBeacon			= mod:NewSpecialWarningMoveAway(252616, nil, nil, nil, 1, 2)
local yellCosmicBeacon				= mod:NewYell(252616)
local yellCosmicBeaconFades			= mod:NewShortFadesYell(252616)
--Stage Four: The Gift of Life, The Forge of Loss (Non Mythic)
local specWarnEmberofRage			= mod:NewSpecialWarningDodge(257299, nil, nil, nil, 2, 2)
local specWarnDeadlyScythe			= mod:NewSpecialWarningStack(258039, nil, 2, nil, nil, 1, 2)
local specWarnDeadlyScytheTaunt		= mod:NewSpecialWarningTaunt(258039, nil, nil, nil, 1, 2)
local specWarnReorgModule			= mod:NewSpecialWarningSwitch(256389, "RangedDps", nil, nil, 1, 2)--Ranged only?

local timerNextPhase				= mod:NewPhaseTimer(74)
--Stage One: Storm and Sky
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerSweepingScytheCD			= mod:NewCDTimer(5.6, 248499, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--5.6-15.7
local timerConeofDeathCD			= mod:NewCDTimer(19.6, 248165, nil, nil, nil, 3)--19.6-24
local timerBlightOrbCD				= mod:NewCDTimer(22, 248317, nil, nil, nil, 3)--22-32
local timerTorturedRageCD			= mod:NewCDTimer(13, 257296, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)--13-16
local timerSkyandSeaCD				= mod:NewCDTimer(25.6, 255594, nil, nil, nil, 5)--25.6-27.8
--Stage Two: The Protector Redeemed
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerSoulBombCD				= mod:NewCDTimer(42, 251570, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON)
local timerSoulBurstCD				= mod:NewCDCountTimer("d42", 250669, nil, nil, nil, 3)
local timerEdgeofObliterationCD		= mod:NewCDTimer(30.5, 255826, nil, nil, nil, 2)
local timerAvatarofAggraCD			= mod:NewCDTimer(59.9, 255199, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
--Stage Three: The Arcane Masters
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerCosmicRayCD				= mod:NewCDTimer(19.9, 252729, nil, nil, nil, 3)--All adds seem to cast it at same time, so one timer for all
local timerCosmicBeaconCD			= mod:NewCDTimer(19.9, 252616, nil, nil, nil, 3)--All adds seem to cast it at same time, so one timer for all
--local timerCosmicPowerCD			= mod:NewCDTimer(19.9, 255935, nil, nil, nil, 3)--All adds seem to cast it at same time, so one timer for all
local timerDiscsofNorgCD			= mod:NewCDTimer(12, 252516, nil, nil, nil, 6)
local timerDiscsofNorg				= mod:NewCastTimer(12, 252516, nil, nil, nil, 6)
--Stage Four: The Gift of Life, The Forge of Loss (Non Mythic)
mod:AddTimerLine(SCENARIO_STAGE:format(4))
local timerDeadlyScytheCD			= mod:NewCDTimer(5.5, 258039, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerReorgModuleCD			= mod:NewCDTimer(48.1, 256389, nil, nil, nil, 1)

--local berserkTimer				= mod:NewBerserkTimer(600)

--Stage One: Storm and Sky
local countdownSoulbomb				= mod:NewCountdown(50, 251570)
--Stage Two: The Protector Redeemed

--Stage Four
local countdownDeadlyScythe			= mod:NewCountdown("Alt5", 258039, false, nil, 3)--Off by default since it'd be almost non stop, so users can elect into this one
local countdownReorgModule			= mod:NewCountdown("AltTwo48", 256389, "-Tank")

--Stage One: Storm and Sky
local voiceSweepingScythe			= mod:NewVoice(248499)--tauntboss
local voiceConeofDeath				= mod:NewVoice(248165)--aesoon
--local voiceTorturedRage				= mod:NewVoice(257296)--aesoon
local voiceSoulblight				= mod:NewVoice(248396)--runout
local voiceGiftofSea				= mod:NewVoice(258647)--targetyou
local voiceGiftofSky				= mod:NewVoice(258646)--targetyou
--local voiceMalignantAnguish		= mod:NewVoice(236597, "HasInterrupt")--kickcast
--local voiceGTFO					= mod:NewVoice(238028, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway
--Stage Two: The Protector Redeemed
local voiceSoulburst				= mod:NewVoice(250669)--targetyou/runout (on delay)
local voiceSoulbomb					= mod:NewVoice(251570)--targetyou/movetotank (on delay)
local voiceEdgeofObliteration		= mod:NewVoice(255826)--watchstep
local voiceAvatarofAgrra			= mod:NewVoice(255199)--targetyou
--Stage Three: The Arcane Masters
local voiceCosmicRay				= mod:NewVoice(252729)--targetyou
local voiceCosmicBeacon				= mod:NewVoice(252616)--runout
--Stage Four: The Gift of Life, The Forge of Loss (Non Mythic)
local voiceEmberofRage				= mod:NewVoice(257299)--watchstep
local voiceDeadlyScythe				= mod:NewVoice(258039)--tauntboss
local voiceReorgModule				= mod:NewVoice(256389)--killmob


mod:AddSetIconOption("SetIconOnAvatar", 255199, true)--4
mod:AddSetIconOption("SetIconOnSoulBomb", 251570, true)--3 and 7
mod:AddSetIconOption("SetIconOnSoulBurst", 250669, true)--2
mod:AddSetIconOption("SetIconOnVulnerability", 255418, true, true)--1-7
mod:AddInfoFrameOption(258040, true)--Change to EJ entry since spell not localized
mod:AddNamePlateOption("NPAuraOnInevitability", 253021)
mod:AddNamePlateOption("NPAuraOnCosmosSword", 255496)
mod:AddNamePlateOption("NPAuraOnEternalBlades", 255478)
mod:AddNamePlateOption("NPAuraOnVulnerability", 255418)
--mod:AddRangeFrameOption("5/10")

local avatarOfAggramar, aggramarsBoon = GetSpellInfo(255199), GetSpellInfo(255200)
local playerAvatar = false
mod.vb.phase = 1
mod.vb.TorturedRage = 0
mod.vb.soulBurstIcon = 3

--[[
local debuffFilter
local UnitDebuff = UnitDebuff
local playerDebuff = nil
do
	local spellName = GetSpellInfo(231311)
	debuffFilter = function(uId)
		if not playerDebuff then return true end
		if not select(11, UnitDebuff(uId, spellName)) == playerDebuff then
			return true
		end
	end
end

local expelLight, stormOfJustice = GetSpellInfo(228028), GetSpellInfo(227807)
local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self.vb.brandActive then
		DBM.RangeCheck:Show(15, debuffFilter)--There are no 15 yard items that are actually 15 yard, this will round to 18 :\
	elseif UnitDebuff("player", expelLight) or UnitDebuff("player", stormOfJustice) then
		DBM.RangeCheck:Show(8)
	elseif self.vb.hornCasting then--Spread for Horn of Valor
		DBM.RangeCheck:Show(5)
	else
		DBM.RangeCheck:Hide()
	end
end
--]]

local function delayedBoonCheck(self, stage4)
	if not UnitBuff("player", aggramarsBoon) then
		if stage4 then
			specWarnSoulbombMoveTo:Show(DBM_CORE_ROOM_EDGE)
			voiceSoulbomb:Play("runtoedge")
		else
			specWarnSoulbombMoveTo:Show(avatarOfAggramar)
			voiceSoulbomb:Play("movetotank")
		end
	end
end

function mod:OnCombatStart(delay)
	playerAvatar = false
	self.vb.phase = 1
	self.vb.TorturedRage = 0
	self.vb.soulBurstIcon = 3
	timerSweepingScytheCD:Start(5.8-delay)
	timerSkyandSeaCD:Start(10.8-delay)
	timerTorturedRageCD:Start(12-delay)
	timerConeofDeathCD:Start(30.3-delay)
	timerBlightOrbCD:Start(35.2-delay)
	--berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(_G["7.3_ARGUS_RAID_DEATH_TITAN_ENERGY"])--Validator won't accept this global so disabled for now
		DBM.InfoFrame:Show(2, "enemypower", 2)
		--DBM.InfoFrame:Show(7, "function", updateInfoFrame, false, false)
	end
	if self.Options.NPAuraOnInevitability or self.Options.NPAuraOnCosmosSword or self.Options.NPAuraOnEternalBlades or self.Options.NPAuraOnVulnerability then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnInevitability or self.Options.NPAuraOnCosmosSword or self.Options.NPAuraOnEternalBlades or self.Options.NPAuraOnVulnerability then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
	if self:IsMythic() then
		DBM:AddMsg(DBM_CORE_NEED_LOGS)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 248165 then
		specWarnConeofDeath:Show()
		voiceConeofDeath:Play("shockwave")
		timerConeofDeathCD:Start()
	elseif spellId == 248317 then
		warnBlightOrb:Show()
		timerBlightOrbCD:Start()
	elseif spellId == 257296 then
		self.vb.TorturedRage = self.vb.TorturedRage + 1
		warnTorturedRage:Show(self.vb.TorturedRage)
		--voiceTorturedRage:Play("aesoon")
		timerTorturedRageCD:Start()
	elseif spellId == 255594 then
		timerSkyandSeaCD:Start()
	elseif spellId == 252516 then
		warnDiscsofNorg:Show()
		timerDiscsofNorg:Start()
	elseif spellId == 255648 then--Golganneth's Wrath
		self.vb.phase = 2
		warnPhase2:Show()
		timerConeofDeathCD:Stop()
		timerBlightOrbCD:Stop()
		timerTorturedRageCD:Stop()
		timerSweepingScytheCD:Stop()
		timerSkyandSeaCD:Stop()
		timerNextPhase:Start(16)
		timerSweepingScytheCD:Start(17.3)
		--timerTorturedRageCD:Start(2)--No longer used in P2?
		timerAvatarofAggraCD:Start(20.9)
		timerEdgeofObliterationCD:Start(21)
		timerSoulBombCD:Start(30.8)
		countdownSoulbomb:Start(30.8)
		timerSoulBurstCD:Start(30.8, 1)
	elseif spellId == 257645 then--Temporal Blast (Stage 3)
		self.vb.phase = 3
		warnPhase3:Show()
		timerSweepingScytheCD:Stop()
		timerTorturedRageCD:Stop()
		timerSoulBombCD:Stop()
		countdownSoulbomb:Cancel()
		timerSoulBurstCD:Stop()
		timerEdgeofObliterationCD:Stop()
		timerAvatarofAggraCD:Stop()
		timerDiscsofNorgCD:Start(15)
		timerCosmicRayCD:Start(30)
		--timerCosmicPowerCD:Start(36.5)
		timerCosmicBeaconCD:Start(40)
	elseif spellId == 256542 then--Reap Soul
		self.vb.phase = 4
		warnPhase4:Show()
		timerCosmicRayCD:Stop()
		--timerCosmicPowerCD:Stop()
		timerCosmicBeaconCD:Stop()
		timerDiscsofNorg:Stop()
		timerDiscsofNorgCD:Stop()
		timerNextPhase:Start(35)--or 53.8
	elseif spellId == 257619 then--Gift of the Lifebinder (p4)
		warnGiftOfLifebinder:Show()
	elseif spellId == 255935 then
		--timerCosmicPowerCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 248499 then
		timerSweepingScytheCD:Start()
	elseif spellId == 258039 then
		timerDeadlyScytheCD:Start()
		countdownDeadlyScythe:Start(5.5)
	elseif spellId == 255826 then
		specWarnEdgeofObliteration:Show()
		voiceEdgeofObliteration:Play("watchstep")
		timerEdgeofObliterationCD:Start()
	elseif spellId == 252729 and self:AntiSpam(5, 3) then
		timerCosmicRayCD:Start()
	elseif spellId == 252616 and self:AntiSpam(5, 4) then
		timerCosmicBeaconCD:Start()
	elseif spellId == 256388 and self:AntiSpam(5, 5) then--Initialization Sequence
		specWarnReorgModule:Show()
		voiceReorgModule:Play("killmob")
		timerReorgModuleCD:Start()
		countdownReorgModule:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 248499 then--Heroic/non mythic
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnSweepingScythe:Show(amount)
					voiceSweepingScythe:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitIsDeadOrGhost("player") and not UnitDebuff("player", args.spellName) then
						specWarnSweepingScytheTaunt:Show(args.destName)
						voiceSweepingScythe:Play("tauntboss")
					else
						warnSweepingScythe:Show(args.destName, amount)
					end
				end
			else
				warnSweepingScythe:Show(args.destName, amount)
			end
		end
	elseif spellId == 258039 then--Heroic/Mythic?
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnDeadlyScythe:Show(amount)
					voiceDeadlyScythe:Play("stackhigh")
				else
					warnDeadlyScythe:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 248396 then
		warnSoulblight:Show(args.destName)
		if args:IsPlayer() then
			specWarnSoulblight:Show()
			voiceSoulblight:Play("runout")
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
			voiceSoulburst:Play("targetyou")
			voiceSoulburst:Schedule(10, "runout")
			yellSoulburst:Yell(icon, icon, icon)
			yellSoulburstFades:Countdown(15, nil, icon)
		end
		if self.Options.SetIconOnSoulBurst then
			self:SetIcon(args.destName, icon)
		end
		self.vb.soulBurstIcon = self.vb.soulBurstIcon + 4--Icons 3 and 7 used to match BW
	elseif spellId == 251570 then
		if args:IsPlayer() then
			specWarnSoulbomb:Show()
			voiceSoulbomb:Play("targetyou")
			self:Schedule(7, delayedBoonCheck, self)
			yellSoulbomb:Yell()
			yellSoulbombFades:Countdown(15)
		elseif playerAvatar then
			specWarnSoulbombMoveTo:Show(args.destName)
			voiceSoulbomb:Play("helpsoak")
		else
			warnSoulbomb:Show(args.destName)
		end
		if self.Options.SetIconOnSoulBomb then
			self:SetIcon(args.destName, 2)
		end
		if self.vb.phase == 4 then
			timerSoulBurstCD:Start(50, 2)
			timerSoulBombCD:Start(100)
			countdownSoulbomb:Start(100)
			timerSoulBurstCD:Start(100, 1)
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
			voiceAvatarofAgrra:Play("targetyou")
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
			voiceCosmicRay:Play("targetyou")
			yellCosmicRay:Yell()
		else
			warnCosmicRay:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 252616 then
		if args:IsPlayer() then
			specWarnCosmicBeacon:Show()
			voiceCosmicBeacon:Play("runout")
			yellCosmicBeacon:Yell()
			yellCosmicBeaconFades:Countdown(8)
		else
			warnCosmicBeacon:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 258647 then--Gift of Sea
		warnSkyandSea:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnGiftofSea:Show()
			voiceGiftofSea:Play("targetyou")
			yellGiftofSea:Yell()
		end
	elseif spellId == 258646 then--Gift of Sky
		warnSkyandSea:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnGiftofSky:Show()
			voiceGiftofSky:Play("targetyou")
			yellGiftofSky:Yell()
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
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 250669 then
		if args:IsPlayer() then
			yellSoulburstFades:Cancel()
			voiceSoulburst:Cancel()
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
	elseif spellId == 252616 then
		if args:IsPlayer() then
			yellCosmicBeaconFades:Cancel()
		end
	elseif spellId == 258039 then--Heroic/Mythic?
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId and self:IsTanking(uId) then
			if not args:IsPlayer() then--Removed from tank that's not you (only time it's removed is on death)
				specWarnDeadlyScytheTaunt:Show(args.destName)
				voiceDeadlyScythe:Play("tauntboss")
			end
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 5) then
		specWarnGTFO:Show()
		voiceGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:238502") then

	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 121193 then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellId)
	if spellId == 257300 and self:AntiSpam(5, 1) then--Ember of Rage
		specWarnEmberofRage:Show()
		voiceEmberofRage:Play("watchstep")
	--elseif spellId == 256389 and self:AntiSpam(5, 2) then--Reorgination Module
		--specWarnReorgModule:Show()
		--voiceReorgModule:Play("killmob")
		--timerReorgModuleCD:Start()
	elseif spellId == 258042 then--Argus P2 Energy Controller (16 seconds after Fury)
		--Alternate and valid timer start point
		--timerAvatarofAggraCD:Start(5)
		--timerEdgeofObliterationCD:Start(6.2)
		--timerSoulBombCD:Start(20.8)
		--timerSoulBurstCD:Start(20.8, 1)
	--elseif spellId == 34098 then--ClearAllDebuffs (12 before Tempoeral Blast)
	
	elseif spellId == 258044 then--Argus P4 Energy Controller (54 seconds after Reap Soul, 27 seconds after Gift of the Lifebinder)
		--timerDiscsofNorgCD:Stop()
		if not self:IsHeroic() then
			timerSweepingScytheCD:Start(5)
		else
			timerDeadlyScytheCD:Start(5)
		end
		local currentPowerPercent = UnitPower("boss1")/UnitPowerMax("boss1")
		local remainingPercent
		if currentPowerPercent then
			remainingPercent = 1.0 - currentPowerPercent
		end
		if remainingPercent then
			timerReorgModuleCD:Start(48.1*remainingPercent)
			countdownReorgModule:Start(48.1*remainingPercent)
			--timerTorturedRageCD:Start(13*remainingPercent)
		end
		timerTorturedRageCD:Start(10)
		timerSoulBurstCD:Start(50.4, 1)--First one is only burst, afterwards it's bomb and burst then burst only again
		timerSoulBombCD:Start(100.7)
		countdownSoulbomb:Start(100.7)
	elseif spellId == 258104 then--Argus Mythic Transform
		
	end
end
