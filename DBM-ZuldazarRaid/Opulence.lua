local mod	= DBM:NewMod(2342, "DBM-ZuldazarRaid", 2, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(145261)
mod:SetEncounterID(2271)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 8)
mod:SetHotfixNoticeRev(18355)
mod:SetMinSyncRevision(18175)
--mod.respawnTime = 35

mod:RegisterCombat("combat")
mod:SetWipeTime(30)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 282939 287659 287070 285995 284941 283947 283606 289906 289155",
	"SPELL_CAST_SUCCESS 283507 287648 284470 287072 285014 287037 285505 286541",
	"SPELL_AURA_APPLIED 284798 283507 287648 284470 287072 285014 287037 284105 287424 289776 284664 284814 284881 284527 289383",
	"SPELL_AURA_APPLIED_DOSE 284664",
	"SPELL_AURA_REFRESH 284470",
	"SPELL_AURA_REMOVED 284798 283507 287648 284470 287072 285014 287424 289776 284664 284527 289383",
	"SPELL_AURA_REMOVED_DOSE 284664",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_START boss1 boss2 boss3"
)

--[[
(ability.id = 282939 or ability.id = 287659 or ability.id = 287070 or ability.id = 285995 or ability.id = 284941 or ability.id = 283947 or ability.id = 283606 or ability.id = 289906 or ability.id = 289155) and type = "begincast"
 or (ability.id = 283507 or ability.id = 287648 or ability.id = 284470 or ability.id = 287072 or ability.id = 285014 or ability.id = 287037 or ability.id = 285505 or ability.id = 286541) and type = "cast"
--]]
--TODO, work on boss and bar behaviors when soloing this raid one day (assuming blizzard makes it so one boss running out of their tunnel across to other tunnel doesn't auto reset boss, because that will happen when soloing
--The Zandalari Crown Jewels
local warnGrosslyIncandescent			= mod:NewTargetNoFilterAnnounce(284798, 1)
local warnChaoticDisplacement			= mod:NewTargetAnnounce(289383, 3)
--Stage One: Raiding The Vault
----The Hand of In'zashi
local warnVolatileCharge				= mod:NewTargetAnnounce(283507, 2)
----Traps
local warnFlameJet						= mod:NewSpellAnnounce(285479, 3)
local warnRubyBeam						= mod:NewSpellAnnounce(284081, 3)
local warnHexofLethargy					= mod:NewTargetAnnounce(284470, 2)
--Stage Two: Toppling the Guardian
local warnPhase2						= mod:NewPhaseAnnounce(2, 2)
local warnLiquidGold					= mod:NewTargetAnnounce(287072, 2)

--The Zandalari Crown Jewels
local specWarnGrosslyIncandescent		= mod:NewSpecialWarningYou(284798, nil, nil, nil, 1, 2)
local yellGrosslyIncandescent			= mod:NewYell(284798)
--Stage One: Raiding The Vault
----General
local specWarnCrush						= mod:NewSpecialWarningDodge(283606, nil, nil, nil, 2, 2)
local specWarnChaoticDisplacement		= mod:NewSpecialWarningYou(289383, nil, nil, nil, 3, 2, 4)
local yellChaoticDisplacement			= mod:NewYell(289383, nil, false)
----The Hand of In'zashi
local specWarnVolatileCharge			= mod:NewSpecialWarningMoveAway(283507, nil, nil, nil, 1, 2)
local yellVolatileCharge				= mod:NewYell(283507)
local yellVolatileChargeFade			= mod:NewFadesYell(283507)
----Yalat's Bulwark
local specWarnFlamesofPunishment		= mod:NewSpecialWarningDodge(282939, nil, nil, nil, 2, 8)
----Traps
local specWarnHexofLethargy				= mod:NewSpecialWarningYou(284470, nil, nil, nil, 1, 2)
local yellHexofLethargy					= mod:NewYell(284470)
local yellHexofLethargyFade				= mod:NewFadesYell(284470)
--Stage Two: Toppling the Guardian
local specWarnLiquidGold				= mod:NewSpecialWarningMoveAway(287072, nil, nil, nil, 1, 2)
local yellLiquidGold					= mod:NewYell(287072)
local yellLiquidGoldFade				= mod:NewFadesYell(287072)
local specWarnSpiritsofGold				= mod:NewSpecialWarningSwitch(285995, "Dps", nil, nil, 1, 2)
local specWarnCoinShower				= mod:NewSpecialWarningMoveTo(285014, "-Tank", nil, 2, 1, 2)
local yellCoinShower					= mod:NewYell(285014, nil, nil, nil, "YELL")
local yellCoinShowerFade				= mod:NewFadesYell(285014, nil, nil, nil, "YELL")
local specWarnWailofGreed				= mod:NewSpecialWarningCount(284941, nil, nil, nil, 2, 2)
local specWarnCoinSweep					= mod:NewSpecialWarningTaunt(287037, nil, nil, nil, 1, 2)
local specWarnSurgingGold				= mod:NewSpecialWarningDodge(289155, nil, nil, nil, 2, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

--General
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19495))
local timerThiefsBane					= mod:NewBuffFadesTimer(30, 287424, nil, nil, nil, 3)
--Stage One: Raiding The Vault
local timerCrushCD						= mod:NewCDSourceTimer(55, 283604, nil, nil, nil, 3)--Both
local timerChaoticDisplacementCD		= mod:NewCDTimer(30.3, 289383, nil, nil, nil, 3, nil, DBM_CORE_MYTHIC_ICON)--Mythic
----The Hand of In'zashi
local timerVolatileChargeCD				= mod:NewCDTimer(12.1, 283507, nil, nil, nil, 3)
----Yalat's Bulwark
local timerFlamesofPunishmentCD			= mod:NewCDTimer(23, 282939, nil, nil, nil, 3)
----Traps
local timerRubyBeam						= mod:NewBuffActiveTimer(8, 284081, nil, nil, nil, 3)
local timerHexofLethargyCD					= mod:NewCDTimer(21.8, 284470, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
--Stage Two: Toppling the Guardian
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19496))
local timerDrawPower					= mod:NewCastTimer(5, 282939, nil, nil, nil, 6)
local timerLiquidGoldCD					= mod:NewCDTimer(15.6, 287072, nil, nil, nil, 3)
local timerSpiritsofGoldCD				= mod:NewCDTimer(65.6, 285995, nil, nil, nil, 1)
local timerCoinShowerCD					= mod:NewCDTimer(30.3, 285014, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON)
local timerWailofGreedCD				= mod:NewCDTimer(71, 284941, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)--71-75
local timerCoinSweepCD					= mod:NewCDTimer(10.9, 287037, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerSurgingGoldCD				= mod:NewCDTimer(42.5, 289155, nil, nil, nil, 3)--Real timer needed, using AI tech for now

--local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddNamePlateOption("NPAuraOnGoldenRadiance", 289776)
--mod:AddRangeFrameOption("8/10")
mod:AddInfoFrameOption(284664, true)

mod.vb.phase = 1
mod.vb.wailCast = 0
mod.vb.bulwarkCrush = 0
local incandescentStacks = {}
local grosslyIncandescentTargets = {}
local diamondTargets = {}
local trackedGemBuff = nil

local updateInfoFrame
do
	local Incan, grosslyIncan = DBM:GetSpellInfo(284664), DBM:GetSpellInfo(284798)
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		--The Zandalari Crown Jewels Helper
		--Diamond Absorb Checks
		for uId in DBM:GetGroupMembers() do
			local unitName = DBM:GetUnitFullName(uId)
			local absorb = diamondTargets[unitName]
			if absorb then
				local absorbAmount = select(16, DBM:UnitDebuff(uId, 284527)) or 0
				addLine(unitName, DBM_CORE_SHIELD.."--"..math.floor(absorbAmount))
			end
		end
		--Incandescent Stacks
		for uId in DBM:GetGroupMembers() do
			local unitName = DBM:GetUnitFullName(uId)
			local count = incandescentStacks[unitName]
			if count then
				addLine(unitName, Incan.."-"..count)
			end
		end
		--Incandescent Full
		for i=1, #grosslyIncandescentTargets do
			local name = grosslyIncandescentTargets[i]
			local uId = DBM:GetRaidUnitId(name)
			if not uId then break end
			local spellName, _, _, _, _, expireTime = DBM:UnitDebuff(uId, 284798)
			if expireTime then
				local remaining = expireTime-GetTime()
				addLine(name, grosslyIncan.."-"..math.floor(remaining))
			end
		end
		--Player personal checks (Always Tracked)
		local spellName2, _, currentStack2, _, _, expireTime2 = DBM:UnitDebuff("player", 284573)
		if spellName2 and currentStack2 and expireTime2 then--Personal Tailwinds count
			local remaining2 = expireTime2-GetTime()
			addLine(spellName2.." ("..currentStack2..")", math.floor(remaining2))
		end
		--Player personal checks (Checked if you have that gem)
		if trackedGemBuff then
			local spellName3, _, currentStack3 = DBM:UnitDebuff("player", 284817, 284883)
			if spellName3 and currentStack3 then--Personal Earthen Roots/Unleashed Rage count
				addLine(spellName3.." ("..currentStack3..")", "")
			end
		end
		--Other Considerations
		--[[local spellName6, _, _, _, _, expireTime4 = DBM:UnitDebuff("player", 284519)
		if spellName6 and expireTime4 then--Personal Quickened Pulse remaining
			local remaining = expireTime4-GetTime()
			addLine(spellName6, math.floor(remaining))
		end--]]
		return lines, sortedLines
	end
end

--Single check, assume that if not near one boss you are near the other
local function updatePlayerTimers(self)
	self:Unschedule(updatePlayerTimers)
	if self:CheckBossDistance(145273, true) then--The Hand of In'zashi
		timerFlamesofPunishmentCD:SetFade(true)
		timerCrushCD:SetSTFade(false, L.Hand)
		timerCrushCD:SetSTFade(true, L.Bulwark)
	else--145274 Yalat's Bulwark
		timerFlamesofPunishmentCD:SetFade(false)
		timerCrushCD:SetSTFade(true, L.Hand)
		timerCrushCD:SetSTFade(false, L.Bulwark)
	end
end

function mod:OnCombatStart(delay)
	table.wipe(incandescentStacks)
	table.wipe(grosslyIncandescentTargets)
	table.wipe(diamondTargets)
	trackedGemBuff = nil
	self.vb.phase = 1
	self.vb.wailCast = 0
	self.vb.bulwarkCrush = 0
	timerVolatileChargeCD:Start(6-delay)
	timerFlamesofPunishmentCD:Start(17-delay)
	if self:IsMythic() then
		timerChaoticDisplacementCD:Start(30.3-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
	if self.Options.NPAuraOnGoldenRadiance then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	self:Schedule(1, updatePlayerTimers, self)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnGoldenRadiance then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 282939 or spellId == 287659 then
		if self:CheckBossDistance(args.sourceGUID, true) then
			specWarnFlamesofPunishment:Show()
			specWarnFlamesofPunishment:Play("behindboss")
			specWarnFlamesofPunishment:ScheduleVoice(1.5, "keepmove")
			timerFlamesofPunishmentCD:SetFade(false)
		else
			timerFlamesofPunishmentCD:SetFade(true)
		end
		timerFlamesofPunishmentCD:Start()
	elseif spellId == 287070 then
		self.vb.phase = 2
		self.vb.wailCast = 0
		--Do these stop?
		timerHexofLethargyCD:Stop()
		timerChaoticDisplacementCD:Stop()
		warnPhase2:Show()
		timerDrawPower:Start()
		--Normal Mode, may differ elsewhere
		timerLiquidGoldCD:Start(14.5)
		timerCoinSweepCD:Start(16.3)
		timerSpiritsofGoldCD:Start(26.7)
		timerWailofGreedCD:Start(60.7)
		if not self:IsLFR() then
			timerCoinShowerCD:Start(17)
			if self:IsMythic() then
				timerSurgingGoldCD:Start(46.2)
			end
		end
	elseif spellId == 285995 then
		specWarnSpiritsofGold:Show()
		specWarnSpiritsofGold:Play("killmob")
		timerSpiritsofGoldCD:Start()
	elseif spellId == 284941 then
		self.vb.wailCast = self.vb.wailCast + 1
		specWarnWailofGreed:Show(self.vb.wailCast)
		specWarnWailofGreed:Play("aesoon")
		--timerWailofGreedCD:Start()
	elseif spellId == 283947 and self:AntiSpam(5, 1) then--Flame Jet
		warnFlameJet:Show()
	elseif spellId == 283606 then
		timerCrushCD:Start(15.8, L.Hand)--7.1, 30.5, 26.7, 15.8, 26.7, 15.8, 25.6, 15.8, 15.8, 18.2, 15.8, 15.8
		if self:CheckBossDistance(args.sourceGUID, true) then
			specWarnCrush:Show()
			specWarnCrush:Play("watchstep")
		else
			timerCrushCD:SetSTFade(true, L.Hand)
		end
	elseif spellId == 289906 then
		timerCrushCD:Start(20.6, L.Bulwark)--7.7, 21.9, 31.6, 21.8, 20.6, 20.7, 18.2, 21.8
		if self:CheckBossDistance(args.sourceGUID, true) then
			specWarnCrush:Show()
			specWarnCrush:Play("watchstep")
		else
			timerCrushCD:SetSTFade(true, L.Bulwark)
		end
	elseif spellId == 289155 then
		specWarnSurgingGold:Show()
		specWarnSurgingGold:Play("watchstep")
		timerSurgingGoldCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 283507 or spellId == 287648 then
		timerVolatileChargeCD:Start()
	elseif spellId == 284470 then
		timerHexofLethargyCD:Start(21.8, args.sourceGUID)
	elseif spellId == 287072 then
		if self:IsMythic() then
			timerLiquidGoldCD:Start(5)
		else
			timerLiquidGoldCD:Start()--15.6
		end
	elseif spellId == 285014 then
		timerCoinShowerCD:Start()
	elseif spellId == 287037 then
		timerCoinSweepCD:Start()
	elseif spellId == 285505 then--Arcane Amethyst Visual
		timerHexofLethargyCD:Start(5.5, args.sourceGUID)
	elseif spellId == 286541 then--Consuming Flame
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 145273 then--The Hand of In'zashi
			timerVolatileChargeCD:Stop()
			timerCrushCD:Stop(L.Hand)
			timerVolatileChargeCD:Start(14.2)--Success
			timerCrushCD:Start(14.5, L.Hand)
		elseif cid == 145274 then--Yalat's Bulwark
			timerFlamesofPunishmentCD:Stop()
			timerCrushCD:Stop(L.Bulwark)
			timerCrushCD:Start(14.5, L.Bulwark)
			timerFlamesofPunishmentCD:Start(24.2)
		end
		updatePlayerTimers(self)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 287037 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			if args:IsPlayer() then
				--specWarnRupturingBlood:Show()
				--specWarnRupturingBlood:Play("defensive")
			else
				--if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off, period.
					specWarnCoinSweep:Show(args.destName)
					specWarnCoinSweep:Play("tauntboss")
				--end
			end
		end
	elseif spellId == 284798 then
		if args:IsPlayer() then
			specWarnGrosslyIncandescent:Show()
			specWarnGrosslyIncandescent:Play("targetyou")
			yellGrosslyIncandescent:Yell()
		else
			warnGrosslyIncandescent:Show(args.destName)
		end
		if not tContains(grosslyIncandescentTargets, args.destName) then
			table.insert(grosslyIncandescentTargets, args.destName)
		end
	elseif spellId == 283507 or spellId == 287648 then
		if args:IsPlayer() then
			specWarnVolatileCharge:Show()
			specWarnVolatileCharge:Play("runout")
			yellVolatileCharge:Yell()
			yellVolatileChargeFade:Countdown(spellId)
		else
			warnVolatileCharge:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 284470 then
		if args:IsPlayer() then
			specWarnHexofLethargy:Show()
			specWarnHexofLethargy:Play("stopmove")
			yellHexofLethargy:Yell()
			yellHexofLethargyFade:Cancel()
			yellHexofLethargyFade:Countdown(spellId)
		else
			warnHexofLethargy:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 287072 then
		if args:IsPlayer() then
			specWarnLiquidGold:Show()
			specWarnLiquidGold:Play("runout")
			yellLiquidGold:Yell()
			yellLiquidGoldFade:Countdown(spellId)
		else
			warnLiquidGold:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 285014 then
		if args:IsPlayer() then
			specWarnCoinShower:Show(GROUP)
			yellCoinShower:Yell()
			yellCoinShowerFade:Countdown(spellId)
		elseif not self:IsTank() then--Exclude only tanks
			specWarnCoinShower:Show(args.destName)
		end
		specWarnCoinShower:Play("gathershare")
	elseif spellId == 284105 and self:AntiSpam(5, 2) then
		warnRubyBeam:Show()
		timerRubyBeam:Start(8)
	elseif spellId == 287424 and args:IsPlayer() then
		timerThiefsBane:Start()
	elseif spellId == 289776 then
		if self.Options.NPAuraOnGoldenRadiance then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 284664 then
		local amount = args.amount or 1
		incandescentStacks[args.destName] = amount
	elseif (spellId == 284814 or spellId == 284881) and args:IsPlayer() then
		trackedGemBuff = true
	elseif spellId == 284527 then--Diamond
		diamondTargets[args.destName] = true
	elseif spellId == 289383 then--Chaotic Displaecment
		warnChaoticDisplacement:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnChaoticDisplacement:Show()
			specWarnChaoticDisplacement:Play("targetyou")
			yellChaoticDisplacement:Yell()
		end
		if self:AntiSpam(10, 3) then
			timerChaoticDisplacementCD:Start()
		end
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	if spellId == 284664 then
		incandescentStacks[args.destName] = args.amount
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 284798 then
		tDeleteItem(grosslyIncandescentTargets, args.destName)
	elseif spellId == 283507 or spellId == 287648 then
		if args:IsPlayer() then
			yellVolatileChargeFade:Cancel()
		end
	elseif spellId == 284470 then
		if args:IsPlayer() then
			yellHexofLethargyFade:Cancel()
		end
	elseif spellId == 287072 then
		if args:IsPlayer() then
			yellLiquidGoldFade:Cancel()
		end
	elseif spellId == 285014 then
		if args:IsPlayer() then
			yellCoinShowerFade:Cancel()
		end
	elseif spellId == 287424 and args:IsPlayer() then
		timerThiefsBane:Stop()
	elseif spellId == 289776 then
		if self.Options.NPAuraOnGoldenRadiance then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 284664 then
		incandescentStacks[args.destName] = nil
	elseif spellId == 284527 then--Diamond
		diamondTargets[args.destName] = nil
	elseif spellId == 289383 then--Chaotic Displaecment
		if args:IsPlayer() then
			self:Schedule(1, updatePlayerTimers, self)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 284664 then
		incandescentStacks[args.destName] = args.amount or 1
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 145273 then--The Hand of In'zashi
		timerVolatileChargeCD:Stop()
		timerCrushCD:Stop(L.Hand)
	elseif cid == 145274 then--Yalat's Bulwark
		timerFlamesofPunishmentCD:Stop()
		timerCrushCD:Stop(L.Bulwark)
	--elseif cid == 147218 then--Spirit of Gold

	end
end

--[[
function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 283947 and self:AntiSpam(5, 1) then--Flame Jet

	end
end
--]]
