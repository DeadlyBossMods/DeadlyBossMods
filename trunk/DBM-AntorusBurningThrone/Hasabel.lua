local mod	= DBM:NewMod(1985, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(122104)
mod:SetEncounterID(2064)
mod:DisableESCombatDetection()--Remove if blizz fixes clicking portals causing this event to fire (even though boss isn't engaged)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
mod:SetHotfixNoticeRev(16950)
mod:SetMinSyncRevision(16950)
mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 243983 244709 245504 244607 244915 246805 244689 244000",
	"SPELL_CAST_SUCCESS 245050 244073 244112 244136 244138 244146 244145 244598 244016",
	"SPELL_AURA_APPLIED 244016 244383 244613 244949 244849 245050 245118",
	"SPELL_AURA_APPLIED_DOSE 244016",
	"SPELL_AURA_REFRESH 244016",
	"SPELL_AURA_REMOVED 244383 244613 244849 245118",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, interrupt rotation helper for Flames of Xoroth?
--TODO, find a workable cast ID for corrupt and enable interrupt warning
--TODO, an overview info frame showing the needs of portal worlds (how many shields up, how much fel miasma, how many fires in dark realm if possible)
--[[
(ability.id = 243983 or ability.id = 244689 or ability.id = 244000) and type = "begincast"
 or ability.id = 244016 and type = "cast"
 or (ability.id = 245504 or ability.id = 244607 or ability.id = 246316 or ability.id = 244915  or ability.id = 246805) and type = "begincast"
 or (ability.id = 245050 or ability.id = 244598) and type = "cast"
 --]]
--Platform: Nexus
local warnRealityTear					= mod:NewStackAnnounce(244016, 2, nil, "Tank")
--Platform: Xoroth
local warnXorothPortal					= mod:NewSpellAnnounce(244318, 2)
local warnAegisofFlames					= mod:NewTargetAnnounce(244383, 3, nil, nil, nil, nil, nil, nil, true)
local warnAegisofFlamesEnded			= mod:NewEndAnnounce(244383, 1)
local warnEverburningFlames				= mod:NewTargetAnnounce(244613, 2, nil, false)
--Platform: Rancora
local warnRancoraPortal					= mod:NewSpellAnnounce(246082, 2)
local warnCausticSlime					= mod:NewTargetAnnounce(244849, 2, nil, false)
--Platform: Nathreza
local warnNathrezaPortal				= mod:NewSpellAnnounce(246157, 2)
local warnDelusions						= mod:NewTargetAnnounce(245050, 2, nil, "Healer")
local warnCloyingShadows				= mod:NewTargetAnnounce(245118, 2, nil, false)
local warnHungeringGloom				= mod:NewTargetAnnounce(245075, 2, nil, false)

--Platform: Nexus
local specWarnRealityTear				= mod:NewSpecialWarningStack(244016, nil, 2, nil, nil, 1, 6)
local specWarnRealityTearOther			= mod:NewSpecialWarningTaunt(244016, nil, nil, nil, 1, 2)
local specWarnTransportPortal			= mod:NewSpecialWarningSwitch(244677, "-Healer", nil, 2, 1, 2)
local specWarnCollapsingWorld			= mod:NewSpecialWarningSpell(243983, nil, nil, nil, 2, 2)
local specWarnFelstormBarrage			= mod:NewSpecialWarningDodge(244000, nil, nil, nil, 2, 2)
local specWarnFieryDetonation			= mod:NewSpecialWarningInterrupt(244709, "HasInterrupt", nil, 2, 1, 2)
local specWarnHowlingShadows			= mod:NewSpecialWarningInterrupt(245504, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Platform: Xoroth
local specWarnFlamesofXoroth			= mod:NewSpecialWarningInterrupt(244607, "HasInterrupt", nil, nil, 1, 2)
local specWarnSupernova					= mod:NewSpecialWarningDodge(244598, nil, nil, nil, 2, 2)
local specWarnEverburningFlames			= mod:NewSpecialWarningMoveTo(244613, nil, nil, nil, 1)--No voice yet
local yellEverburningFlames				= mod:NewFadesYell(244613)
--Platform: Rancora
local specWarnFelSilkWrap				= mod:NewSpecialWarningYou(244949, nil, nil, nil, 1, 2)
local yellFelSilkWrap					= mod:NewYell(244949)
local specWarnFelSilkWrapOther			= mod:NewSpecialWarningSwitch(244949, "Dps", nil, nil, 1, 2)
local specWarnLeechEssence				= mod:NewSpecialWarningSpell(244915, nil, nil, nil, 1, 2)--Don't know what to do for voice yet til strat divised
local specWarnCausticSlime				= mod:NewSpecialWarningMoveTo(244849, nil, nil, nil, 1)--No voice yet
local specWarnCausticSlimeLFR			= mod:NewSpecialWarningMoveAway(244849, nil, nil, nil, 1)--No voice yet
local yellCausticSlime					= mod:NewFadesYell(244849)
--Platform: Nathreza
local specWarnDelusions					= mod:NewSpecialWarningYou(245050, nil, nil, nil, 1, 2)
--local specWarnCorrupt					= mod:NewSpecialWarningInterrupt(245040, "HasInterrupt", nil, nil, 1, 2)
local specWarnCloyingShadows			= mod:NewSpecialWarningYou(245118, nil, nil, nil, 1)--No voice yet (you warning for now, since it's secondary debuff you move to fel miasma)
local yellCloyingShadows				= mod:NewFadesYell(245118)
local specWarnHungeringGloom			= mod:NewSpecialWarningMoveTo(245075, nil, nil, nil, 1)--No voice yet

--Platform: Nexus
local timerRealityTearCD				= mod:NewCDTimer(12.1, 244016, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerCollapsingWorldCD			= mod:NewCDTimer(32.9, 243983, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)--32.9-41
local timerFelstormBarrageCD			= mod:NewCDTimer(32.2, 244000, nil, nil, nil, 3)--32.9-41
local timerTransportPortalCD			= mod:NewCDTimer(41.2, 244677, nil, nil, nil, 1)--41.2-60. most of time 42 on nose.
--Platform: Xoroth
--local timerSupernovaCD					= mod:NewCDTimer(6.1, 244598, nil, nil, nil, 3)
local timerFlamesofXorothCD				= mod:NewCDTimer(6.9, 244607, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--Platform: Rancora
local timerFelSilkWrapCD				= mod:NewCDTimer(16.6, 244949, nil, nil, nil, 3)
local timerPoisonEssenceCD				= mod:NewCDTimer(9.4, 246316, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
local timerLeechEssenceCD				= mod:NewCDTimer(9.4, 244915, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
--Platform: Nathreza
local timerDelusionsCD					= mod:NewCDTimer(14.6, 245050, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON..DBM_CORE_MAGIC_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--Platform: Nexus
local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, nil, nil, 3)
local countdownRealityTear				= mod:NewCountdown("Alt12", 244016, "Tank")
local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)
--Platform: Xoroth
--Platform: Rancora

--Platform: Nexus
local voiceTransportPortal				= mod:NewVoice(244677)--killmob

--mod:AddSetIconOption("SetIconOnFocusedDread", 238502, true)
--mod:AddInfoFrameOption(239154, true)
mod:AddRangeFrameOption("8/10")
mod:AddBoolOption("ShowAllPlatforms", false)

mod.vb.shieldsActive = false
mod.vb.felBarrageCast = 0
mod.vb.firstPortal = false
local playerPlatform = 1--1 Nexus, 2 Xoroth, 3 Rancora, 4 Nathreza
local mindFog, aegisFlames, felMiasma = GetSpellInfo(245099), GetSpellInfo(244383), GetSpellInfo(244826)
local nexusPlatform, xorothPlatform, rancoraPlatform, nathrezaPlatform = {}, {}, {}, {}

local updateRangeFrame
do
	local everBurningFlames, causticSlime, CloyingShadows, hungeringGloom = GetSpellInfo(244613), GetSpellInfo(244849), GetSpellInfo(245118), GetSpellInfo(245075)
	local UnitDebuff = UnitDebuff
	local function debuffFilter(uId)
		if UnitDebuff(uId, everBurningFlames) or UnitDebuff(uId, hungeringGloom) or UnitDebuff(uId, causticSlime) then
			return true
		end
	end
	updateRangeFrame = function(self)
		if not self.Options.RangeFrame then return end
		if UnitDebuff("player", causticSlime) then
			DBM.RangeCheck:Show(10)
		elseif UnitDebuff("player", everBurningFlames) or UnitDebuff("player", CloyingShadows) or UnitDebuff("player", hungeringGloom) then
			DBM.RangeCheck:Show(8)
		else
			DBM.RangeCheck:Show(10, debuffFilter)
		end
	end
end

local function updateAllTimers(self, ICD)
	DBM:Debug("updateAllTimers running", 3)
	if timerCollapsingWorldCD:GetRemaining() < ICD then
		local elapsed, total = timerCollapsingWorldCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerCollapsingWorldCD extended by: "..extend, 2)
		timerCollapsingWorldCD:Stop()
		timerCollapsingWorldCD:Update(elapsed, total+extend)
		countdownCollapsingWorld:Cancel()
		countdownCollapsingWorld:Start(ICD)
	end
	if timerFelstormBarrageCD:GetRemaining() < ICD then
		local elapsed, total = timerFelstormBarrageCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerFelstormBarrageCD extended by: "..extend, 2)
		timerFelstormBarrageCD:Stop()
		timerFelstormBarrageCD:Update(elapsed, total+extend)
		countdownFelstormBarrage:Cancel()
		countdownFelstormBarrage:Start(ICD)
	end
	if self.vb.firstPortal and timerTransportPortalCD:GetRemaining() < ICD then
		local elapsed, total = timerTransportPortalCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerTransportPortalCD extended by: "..extend, 2)
		timerTransportPortalCD:Stop()
		timerTransportPortalCD:Update(elapsed, total+extend)
	end
end

function mod:OnCombatStart(delay)
	self.vb.shieldsActive = false
	self.vb.firstPortal = false
	self.vb.felBarrageCast = 0
	playerPlatform = 1--Nexus
	table.wipe(nexusPlatform)
	table.wipe(xorothPlatform)
	table.wipe(rancoraPlatform)
	table.wipe(nathrezaPlatform)
	timerRealityTearCD:Start(6.2-delay)
	countdownRealityTear:Start(6.2-delay)
	timerCollapsingWorldCD:Start(10.5-delay)--Still variable, 10.5-18
	countdownCollapsingWorld:Start(10.5-delay)
	timerFelstormBarrageCD:Start(25.2-delay)
	countdownFelstormBarrage:Start(25.2-delay)
	for uId in DBM:GetGroupMembers() do
		local name = DBM:GetUnitFullName(uId)
		nexusPlatform[#nexusPlatform+1] = name
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 243983 then
		if self:IsEasy() then
			timerCollapsingWorldCD:Start(37.7)--37-43, mostly 42 but have to use 37
			countdownCollapsingWorld:Start(37.8)
		elseif self:IsMythic() then
			timerCollapsingWorldCD:Start(27.1)
			countdownCollapsingWorld:Start(27.1)
		else
			timerCollapsingWorldCD:Start()
			countdownCollapsingWorld:Start(31.9)
		end
		if self.Options.ShowAllPlatforms or playerPlatform == 1 then--Actually on nexus platform
			specWarnCollapsingWorld:Show()
			specWarnCollapsingWorld:Play("watchstep")
		end
		updateAllTimers(self, 9.7)
	elseif spellId == 244709 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnFieryDetonation:Show(args.sourceName)
		specWarnFieryDetonation:Play("kickcast")
	elseif spellId == 245504 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnHowlingShadows:Show(args.sourceName)
		specWarnHowlingShadows:Play("kickcast")
	elseif spellId == 244607 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnFlamesofXoroth:Show(args.sourceName)
		specWarnFlamesofXoroth:Play("kickcast")
		timerFlamesofXorothCD:Start()
	elseif spellId == 246316 then--Rancora platform
		timerPoisonEssenceCD:Start()
	elseif spellId == 244915 or spellId == 246805 then
		if self.Options.ShowAllPlatforms or playerPlatform == 3 then--Actually on Rancora platform
			timerLeechEssenceCD:Start()
			specWarnLeechEssence:Show()
		end
	elseif spellId == 244689 then
		if self:IsMythic() then
			timerTransportPortalCD:Start(36.5)
		else
			timerTransportPortalCD:Start()
		end
		if self.Options.ShowAllPlatforms or playerPlatform == 1 then--Actually on nexus platform
			specWarnTransportPortal:Show()
			specWarnTransportPortal:Play("killmob")
		end
		updateAllTimers(self, 8.5)
	elseif spellId == 244000 then--Felstorm Barrage
		self.vb.felBarrageCast = self.vb.felBarrageCast + 1
		if self:IsEasy() then
			timerFelstormBarrageCD:Start(37.8)--37.8-43.8
			countdownFelstormBarrage:Start(37.8)
		elseif self:IsMythic() then
			timerFelstormBarrageCD:Start(27.1)
			countdownFelstormBarrage:Start(27.1)
		else
			timerFelstormBarrageCD:Start()--32.9-41
			countdownFelstormBarrage:Start(32.2)
		end
		if self.Options.ShowAllPlatforms or playerPlatform == 1 then--Actually on nexus platform
			specWarnFelstormBarrage:Show()
			specWarnFelstormBarrage:Play("farfromline")
		end
		updateAllTimers(self, 9.7)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 245050 then--Delusions
		timerDelusionsCD:Start()
	elseif spellId == 244073 then--Gateway: Xoroth (Entering)
		xorothPlatform[#xorothPlatform+1] = args.sourceName
		tDeleteItem(nexusPlatform, args.sourceName)
		if args:IsPlayerSource() then
			playerPlatform = 2--1 Nexus, 2 Xoroth, 3 Rancora, 4 Nathreza
		end
	elseif spellId == 244112 then--Gateway: Xoroth (Leaving)
		nexusPlatform[#nexusPlatform+1] = args.sourceName
		tDeleteItem(xorothPlatform, args.sourceName)
		if args:IsPlayerSource() then
			playerPlatform = 1--1 Nexus, 2 Xoroth, 3 Rancora, 4 Nathreza
		end
	elseif spellId == 244136 then--Gateway: Rancora (Entering)
		rancoraPlatform[#rancoraPlatform+1] = args.sourceName
		tDeleteItem(nexusPlatform, args.sourceName)
		if args:IsPlayerSource() then
			playerPlatform = 3--1 Nexus, 2 Xoroth, 3 Rancora, 4 Nathreza
		end
	elseif spellId == 244138 then--Gateway: Rancora (Leaving)
		nexusPlatform[#nexusPlatform+1] = args.sourceName
		tDeleteItem(rancoraPlatform, args.sourceName)
		if args:IsPlayerSource() then
			playerPlatform = 1--1 Nexus, 2 Xoroth, 3 Rancora, 4 Nathreza
		end
	elseif spellId == 244146 then--Gateway: Nathreza (Entering)
		nathrezaPlatform[#nathrezaPlatform+1] = args.sourceName
		tDeleteItem(nexusPlatform, args.sourceName)
		if args:IsPlayerSource() then
			playerPlatform = 4--1 Nexus, 2 Xoroth, 3 Rancora, 4 Nathreza
		end
	elseif spellId == 244145 then--Gateway: Nathreza (Leaving)
		nexusPlatform[#nexusPlatform+1] = args.sourceName
		tDeleteItem(nathrezaPlatform, args.sourceName)
		if args:IsPlayerSource() then
			playerPlatform = 1--1 Nexus, 2 Xoroth, 3 Rancora, 4 Nathreza
		end
	elseif spellId == 244598 and self:AntiSpam(5, 1) then--Supernova
		if self.Options.ShowAllPlatforms or playerPlatform == 2 then--Actually on Xoroth platform
			specWarnSupernova:Show()
			specWarnSupernova:Play("watchstep")
		end
	elseif spellId == 244016 then
		timerRealityTearCD:Start()
		countdownRealityTear:Start(12.2)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 244016 then
		local uId = DBM:GetRaidUnitId(args.destName)
--		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnRealityTear:Show(amount)
					specWarnRealityTear:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					local _, _, _, _, _, _, expireTime = UnitDebuff("player", args.spellName)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 12) then
						specWarnRealityTearOther:Show(args.destName)
						specWarnRealityTearOther:Play("tauntboss")
					else
						warnRealityTear:Show(args.destName, amount)
					end
				end
			else
				warnRealityTear:Show(args.destName, amount)
			end
--		end
	elseif spellId == 244383 and self:AntiSpam(2, args.destName) then--Aegis of Flames
		self.vb.shieldsActive = true
		warnAegisofFlames:Show(args.destName)
	elseif spellId == 244613 then--Everburning Flames
		warnEverburningFlames:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnEverburningFlames:Show(mindFog)
			yellEverburningFlames:Countdown(10)
			updateRangeFrame(self)
		end
	elseif spellId == 244849 then--Caustic Slime
		warnCausticSlime:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			if self.vb.shieldsActive then--Show moveto message
				specWarnCausticSlime:Show(aegisFlames)
			else--Show LFR/You message
				specWarnCausticSlimeLFR:Show()
			end
			yellCausticSlime:Countdown(20)
			updateRangeFrame(self)
		end
	elseif spellId == 245118 then--Cloying Shadows
		warnCloyingShadows:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnCloyingShadows:Show()
			yellCloyingShadows:Countdown(30)
			updateRangeFrame(self)
		end
	elseif spellId == 245075 then
		warnHungeringGloom:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnHungeringGloom:Show(felMiasma)
			updateRangeFrame(self)
		end
	elseif spellId == 244949 then--Felsilk Wrap
		if args:IsPlayer() then
			specWarnFelSilkWrap:Show()
			specWarnRealityTearOther:Play("targetyou")
			yellFelSilkWrap:Yell()
		else
			if self.Options.ShowAllPlatforms or playerPlatform == 3 then--Actually on Rancora platform
				timerFelSilkWrapCD:Start()
				specWarnFelSilkWrapOther:Show()
				if self.Options.SpecWarn244949switch then
					specWarnFelSilkWrapOther:Play("changetarget")
				end
			end
		end
	elseif spellId == 245050 then--Delusions
		warnDelusions:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDelusions:Show()
			specWarnDelusions:Play("targetyou")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 244383 then--Aegis of Flames
		self.vb.shieldsActive = false
		warnAegisofFlamesEnded:Show()
	elseif spellId == 244613 then--Everburning Flames
		if args:IsPlayer() then
			yellEverburningFlames:Cancel()
			updateRangeFrame(self)
		end
	elseif spellId == 244849 then--Caustic Slime
		if args:IsPlayer() then
			yellCausticSlime:Cancel()
			updateRangeFrame(self)
		end
	elseif spellId == 245118 then--Cloying Shadows
		if args:IsPlayer() then
			yellCloyingShadows:Cancel()
			--updateRangeFrame(self)
		end
	elseif spellId == 245075 then--Hungering Gloom
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then--Baron Vulcanar (Platform: Xoroth)
		--timerSupernovaCD:Stop()
		timerFlamesofXorothCD:Stop()
	elseif cid == 124395 then--Lady Dacidion (Platform: Rancora)
		timerFelSilkWrapCD:Stop()
		timerLeechEssenceCD:Stop()--Add appropriate boss filter when mythic add support added
	elseif cid == 124394 then--Lord Eilgar (Platform: Nathreza)
		timerDelusionsCD:Stop()--Add appropriate boss filter when mythic add support added
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 257939 then
		self.vb.firstPortal = true
		warnXorothPortal:Show()
		voiceTransportPortal:Play("newportal")
	elseif spellId == 257941 then
		warnRancoraPortal:Show()
		voiceTransportPortal:Play("newportal")
	elseif spellId == 257942 then
		warnNathrezaPortal:Show()
		voiceTransportPortal:Play("newportal")
	end
end
