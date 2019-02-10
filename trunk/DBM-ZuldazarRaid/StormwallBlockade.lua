local mod	= DBM:NewMod(2337, "DBM-ZuldazarRaid", 3, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(146251, 146253, 146256)--Sister Katherine 146251, Brother Joseph 146253, Laminaria 146256
mod:SetEncounterID(2280)
--mod:DisableESCombatDetection()
mod:SetZone()
mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 8)
mod:SetHotfixNoticeRev(18175)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 284262 284106 284393 284383 285017 284362 288696 288941",
	"SPELL_CAST_SUCCESS 285350 285426 285118 290694 289795",
	"SPELL_AURA_APPLIED 286558 284405 285000 285382 285350 285426 287995",
	"SPELL_AURA_REFRESH 285000 285382",
	"SPELL_AURA_APPLIED_DOSE 285000 285382",
	"SPELL_AURA_REMOVED 286558 285000 285382 285350 285426 287995",
	"SPELL_INTERRUPT",
--	"SPELL_PERIODIC_DAMAGE 285075",
--	"SPELL_PERIODIC_MISSED 285075",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, switch to custom hybrid frame to show both shields and boss energy and storm's Wail
--TODO, add Tidal/Jolting Volleys? Just seems like general consistent aoe damage so not worth warning yet
--TODO, icons and stuff for storm's wail
--TODO, add "watch wave" warning for Energized wake on mythic
--[[
(ability.id = 284262 or ability.id = 284106 or ability.id = 284393 or ability.id = 284383 or ability.id = 285017 or ability.id = 284362 or ability.id = 288696 or ability.id = 288941) and type = "begincast"
 or (ability.id = 285350 or ability.id = 285426 or ability.id = 285118 or ability.id = 290694 or ability.id = 289795) and type = "cast"
 or type = "interrupt"
 or ability.id = 284405 and type = "applydebuff"
--]]
--Stage One: Storm the Ships
----General
local warnTranslocate					= mod:NewTargetNoFilterAnnounce(284393, 2)
----Sister Katherine
local warnCracklingLightning			= mod:NewCastAnnounce(284106, 3)
local warnElecShroud					= mod:NewTargetAnnounce(287995, 4)
----Brother Joseph
local warnTemptingSong					= mod:NewTargetAnnounce(284405, 2)
local warnTidalShroud					= mod:NewTargetAnnounce(286558, 4)
--Stage Two: Laminaria
local warnCataTides						= mod:NewCastAnnounce(288696, 3)
local warnKelpWrapped					= mod:NewStackAnnounce(285000, 2, nil, "Tank")
local warnStormsWail					= mod:NewTargetNoFilterAnnounce(285350, 3)

--Stage One: Storm the Ships
----General
local specWarnTidalEmpowerment			= mod:NewSpecialWarningInterrupt(284765, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(285075, false, nil, 2, 1, 8)
----Sister Katherine
local specWarnVoltaicFlash				= mod:NewSpecialWarningDodge(284262, nil, nil, nil, 2, 2)
--local yellDarkRevolation				= mod:NewPosYell(273365)
--local yellDarkRevolationFades			= mod:NewIconFadesYell(273365
----Brother Joseph
local specWarnSeaStorm					= mod:NewSpecialWarningDodge(284360, nil, nil, nil, 2, 2)
local specWarnSeasTemptation			= mod:NewSpecialWarningSwitch(284383, "RangedDps", nil, nil, 1, 2)--Ranged assumed for now, melee stay out until temping song goes out
local specWarnTemptingSong				= mod:NewSpecialWarningRun(284405, nil, nil, nil, 4, 2)
local yellTemptingSong					= mod:NewYell(284405)
--Stage Two: Laminaria
local specWarnEnergizedStorm			= mod:NewSpecialWarningSwitch("ej19312", "RangedDps", nil, nil, 1, 2)
local yellKepWrapped					= mod:NewFadesYell(285000)
local specWarnSeaSwell					= mod:NewSpecialWarningDodge(285118, nil, nil, nil, 2, 2)
local specWarnIreoftheDeep				= mod:NewSpecialWarningSoak(285017, "-Tank", nil, nil, 1, 2)
local specWarnStormsWail				= mod:NewSpecialWarningMoveTo(285350, nil, nil, 2, 3, 2)
local yellStormsWail					= mod:NewYell(285350)
local yellStormsWailFades				= mod:NewShortFadesYell(285350)

--Stage One: Storm the Ships
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19257))
----Sister Katherine
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19261))
local timerVoltaicFlashCD				= mod:NewCDTimer(17, 284262, nil, nil, nil, 3)--17-35 wtf?
local timerCracklingLightningCD			= mod:NewCDTimer(12.1, 284106, nil, nil, nil, 3)--12.1 and 22 alternating
--local timerThunderousBoomCD			= mod:NewCastTimer(55, 284120, nil, nil, nil, 2)--After timing is figured out after crackling
local timerElecShroudCD					= mod:NewCDTimer(34, 287995, nil, nil, nil, 4, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_INTERRUPT_ICON)--34-41, maybe health based?
----Brother Joseph
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19262))
local timerSeaStormCD					= mod:NewCDTimer(10.9, 284360, nil, nil, nil, 3)
local timerSeasTemptationCD				= mod:NewCDCountTimer(34, 284383, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)--Might be health based
local timerTidalShroudCD				= mod:NewCDTimer(36.5, 286558, nil, nil, nil, 4, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_INTERRUPT_ICON)--Probalby health based
--Stage Two: Laminaria
mod:AddTimerLine(DBM:EJ_GetSectionInfo(19258))
local timerCataTides					= mod:NewCastTimer(15, 288696, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerSeaSwellCD					= mod:NewCDTimer(20.6, 285118, nil, nil, nil, 3)
local timerIreoftheDeepCD				= mod:NewCDTimer(32.8, 285017, nil, nil, nil, 5)
local timerStormsWailCD					= mod:NewCDTimer(120.5, 285350, nil, nil, nil, 3)
local timerStormsWail					= mod:NewTargetTimer(12, 285350, nil, nil, nil, 5)

--local berserkTimer					= mod:NewBerserkTimer(600)

local countdownSeaSwell					= mod:NewCountdown(20.6, 285118, true, 3, 3)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

mod:AddNamePlateOption("NPAuraOnKepWrapping", 285382)
--mod:AddSetIconOption("SetIconDarkRev", 273365, true)
mod:AddRangeFrameOption(5, 285118)
mod:AddInfoFrameOption(284760, true)

mod.vb.phase = 1
mod.vb.bossesDied = 0
mod.vb.cracklingCast = 0
mod.vb.sirenCount = 0
local freezingTidePod = DBM:GetSpellInfo(285075)
local stormTargets = {}

local updateInfoFrame
do
	local stormsWail = DBM:GetSpellInfo(285350)
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
		--Big Guys Power
		local currentPower, maxPower = UnitPower("boss1"), UnitPowerMax("boss1")
		if maxPower and maxPower ~= 0 then
			if currentPower / maxPower * 100 >= 1 then
				addLine(UnitName("boss1"), currentPower)
			end
		end
		--[[for i = 1, 3 do
			local unitID = "boss"..i
			local cid = mod:GetUnitCreatureId(unitID) or 0
			if cid == 146256 then
				local currentPower, maxPower = UnitPower(unitID), UnitPowerMax(unitID)
				if maxPower and maxPower ~= 0 then
					if currentPower / maxPower * 100 >= 1 then
						addLine(UnitName(unitID), currentPower)
					end
				end
			end
		end--]]
		--Scan raid for notable debuffs and add them
		if #stormTargets > 0 then
			--addLine("", "")
			for i=1, #stormTargets do
				local name = stormTargets[i]
				local uId = DBM:GetRaidUnitId(name)
				local spellName, _, _, _, _, expireTime = DBM:UnitDebuff(uId, 285350, 285426)
				if spellName and expireTime then--Personal Dark Bargain
					local remaining = expireTime-GetTime()
					addLine(name, math.floor(remaining))
				end
			end
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	table.wipe(stormTargets)
	self.vb.phase = 1
	self.vb.bossesDied = 0
	self.vb.cracklingCast = 0
	self.vb.sirenCount = 0
	--Sister
	timerCracklingLightningCD:Start(3.9-delay)--3.9-8.8
	timerElecShroudCD:Start(30-delay)
	timerVoltaicFlashCD:Start(8.8-delay)
	--Brother
	--timerSeaStormCD:Start(7.6-delay)--0.3-8
	timerSeasTemptationCD:Start(15.5-delay, 1)--Might be health based
	timerTidalShroudCD:Start(30.1-delay)--30-32
	if self:IsMythic() then
		timerSeaSwellCD:Start(19.8-delay)
		countdownSeaSwell:Start(19.8-delay)
	end
	if self.Options.NPAuraOnKepWrapping then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnKepWrapping then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:OnTimerRecovery()
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 284262 then
		timerVoltaicFlashCD:Start()
		if self:CheckTankDistance(args.sourceGUID, 43) then
			specWarnVoltaicFlash:Show()
			specWarnVoltaicFlash:Play("watchorb")
			timerVoltaicFlashCD:SetFade(false)
		else
			timerVoltaicFlashCD:SetFade(true)
		end
	elseif spellId == 288941 and self:AntiSpam(20, 2) then--AntiSpam must be at least 15 here, 20 for good measure
		specWarnVoltaicFlash:Show()
		specWarnVoltaicFlash:Play("watchorb")
		timerVoltaicFlashCD:Start(42.5)
	elseif spellId == 284106 then
		self.vb.cracklingCast = self.vb.cracklingCast + 1
		if self.vb.cracklingCast % 2 == 0 then
			timerCracklingLightningCD:Start(21.9)--21.9 (usually 23.1 but I have one log showing 21.9)
		else
			timerCracklingLightningCD:Start(12.1)
		end
		if self:CheckTankDistance(args.sourceGUID, 43) then
			warnCracklingLightning:Show()
			timerCracklingLightningCD:SetFade(false)
		else
			timerCracklingLightningCD:SetFade(true)
		end
	elseif spellId == 284393 then
		warnTranslocate:Show(args.sourceName)
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 146251 then--Sister
			self.vb.cracklingCast = 0
			timerVoltaicFlashCD:Stop()
			timerCracklingLightningCD:Stop()
			timerElecShroudCD:Stop()
			
			--This may be more complicated than this, like maybe a pause/resume more so than this
			timerCracklingLightningCD:Start(12)
			timerVoltaicFlashCD:Start(17)
			timerElecShroudCD:Start(36.4)
			--Set all to false on teleport til we can refresh tank distance
			timerCracklingLightningCD:SetFade(false)
			timerVoltaicFlashCD:SetFade(false)
			timerElecShroudCD:SetFade(false)
		elseif cid == 146251 then--Brother
			timerSeaStormCD:Stop()
			timerSeasTemptationCD:Stop()
			timerTidalShroudCD:Stop()
			
			--This may be more complicated than this, like maybe a pause/resume more so than this
			timerSeaStormCD:Start(12.1)
			timerSeasTemptationCD:Start(26.7, self.vb.sirenCount+1)--Even less sure about this one
			timerTidalShroudCD:Start(37.7)
			--Set all to false on teleport til we can refresh tank distance
			timerSeaStormCD:SetFade(false)
			timerSeasTemptationCD:SetFade(false, self.vb.sirenCount+1)
			timerTidalShroudCD:SetFade(false)
		end
	elseif spellId == 284383 then
		self.vb.sirenCount = self.vb.sirenCount + 1
		timerSeasTemptationCD:Start(nil, self.vb.sirenCount+1)
		if self:CheckTankDistance(args.sourceGUID, 43) then
			specWarnSeasTemptation:Show()
			specWarnSeasTemptation:Play("killmob")
			timerSeasTemptationCD:SetFade(false, self.vb.sirenCount+1)
		else
			timerSeasTemptationCD:SetFade(true, self.vb.sirenCount+1)
		end
	elseif spellId == 285017 then
		specWarnIreoftheDeep:Show()
		specWarnIreoftheDeep:Play("helpsoak")
		timerIreoftheDeepCD:Start()
	elseif spellId == 284362 then
		if self:IsMythic() then
			timerSeaStormCD:Start(9.7)
		else
			timerSeaStormCD:Start()--10.9
		end
		if self:CheckTankDistance(args.sourceGUID, 43) then
			specWarnSeaStorm:Show()
			specWarnSeaStorm:Play("watchstep")
			timerSeaStormCD:SetFade(false)
		else
			timerSeaStormCD:SetFade(true)
		end
	elseif spellId == 288696 then
		warnCataTides:Show()
		timerCataTides:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if (spellId == 285350 or spellId == 285426) and args:GetSrcCreatureID() == 146256 then
		timerStormsWailCD:Start()
	elseif spellId == 285118 then--All P2 Sea Swell
		specWarnSeaSwell:Show()
		specWarnSeaSwell:Play("watchstep")
		if self:IsMythic() then
			timerSeaSwellCD:Start(17)
			countdownSeaSwell:Start(17)
		else
			timerSeaSwellCD:Start()
			countdownSeaSwell:Start(20.6)
		end
	elseif spellId == 290694 and self:AntiSpam(5, 2) then--Mythic P1 Sea Swell
		specWarnSeaSwell:Show()
		specWarnSeaSwell:Play("watchstep")
		timerSeaSwellCD:Start(20)
		countdownSeaSwell:Start(20)
	elseif spellId == 289795 and self.vb.phase == 2 then--Zuldazar Reuse Spell 06 (P2 sirens spawning)
		self.vb.sirenCount = self.vb.sirenCount + 1
		if self:AntiSpam(8, 8) then
			specWarnSeasTemptation:Show()
			specWarnSeasTemptation:Play("killmob")
		end
		if self.vb.sirenCount % 2 == 0 then
			timerSeasTemptationCD:Start(36.3, self.vb.sirenCount+1)
		else
			timerSeasTemptationCD:Start(5, self.vb.sirenCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 285000 then
		local uId = DBM:GetRaidUnitId(args.destName)
		--if self:IsTanking(uId) then
			local amount = args.amount or 1
			--if amount >= 2 then
				if args:IsPlayer() then
					--specWarnRupturingBlood:Show(amount)
					--specWarnRupturingBlood:Play("stackhigh")
					yellKepWrapped:Cancel()
					yellKepWrapped:Countdown(18)
				--else
					--if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off, period.
						--specWarnRupturingBloodTaunt:Show(args.destName)
						--specWarnRupturingBloodTaunt:Play("tauntboss")
					--else
						--warnKelpWrapped:Show(args.destName, amount)
					--end
				end
			--else
				warnKelpWrapped:Show(args.destName, amount)
			--end
		--end
	elseif spellId == 286558 then
		timerTidalShroudCD:Start()
		if self:CheckTankDistance(args.destGUID, 43) then
			warnTidalShroud:Show(args.destName)
			timerTidalShroudCD:SetFade(false)
		else
			timerTidalShroudCD:SetFade(true)
		end
	elseif spellId == 287995 then
		timerElecShroudCD:Start()
		if self:CheckTankDistance(args.destGUID, 43) then
			warnElecShroud:Show(args.destName)
			timerElecShroudCD:SetFade(false)
		else
			timerElecShroudCD:SetFade(true)
		end
	elseif spellId == 284405 then
		if args:IsPlayer() then
			specWarnTemptingSong:Show()
			specWarnTemptingSong:Play("justrun")
			yellTemptingSong:Yell()
		else
			warnTemptingSong:Show(args.destName)
		end
	elseif spellId == 285382 then
		if self.Options.NPAuraOnKepWrapping then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 10)
		end
	elseif spellId == 285350 or spellId == 285426 then
		if args:IsPlayer() then
			specWarnStormsWail:Show(freezingTidePod)
			local timer = self:IsEasy() and 13 or 10
			specWarnStormsWail:Schedule(timer-4.5, DBM_CORE_BACK)
			specWarnStormsWail:Play("targetyou")
			yellStormsWail:Yell()
			yellStormsWailFades:Countdown(timer)
		else
			warnStormsWail:Show(args.destName)
		end
		timerStormsWail:Start(12, args.destName)
		if not tContains(stormTargets, args.destName) then
			table.insert(stormTargets, args.destName)
		end
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 286558 then
		if self:CheckInterruptFilter(args.destGUID, false, true) then
			specWarnTidalEmpowerment:Show(args.destName)
			specWarnTidalEmpowerment:Play("kickcast")
		end
	elseif spellId == 285000 then
		if args:IsPlayer() then
			yellKepWrapped:Cancel()
		end
	elseif spellId == 285382 then
		if self.Options.NPAuraOnKepWrapping then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 285350 or spellId == 285426 then
		if self:AntiSpam(5, 1) then
			specWarnEnergizedStorm:Show()
			specWarnEnergizedStorm:Play("targetchange")
		end
		if args:IsPlayer() then
			yellStormsWailFades:Cancel()
			specWarnStormsWail:Cancel()
		end
		timerStormsWail:Stop(12, args.destName)
		tDeleteItem(stormTargets, args.destName)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 285075 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 288696 then
		self.vb.phase = 2
		self.vb.sirenCount = 0
		timerSeaSwellCD:Stop()
		countdownSeaSwell:Cancel()
		--Same on all difficulties but some variation because they can actually come in different orders. in reality probably all start with same timer then randomized order by spell queue
		timerIreoftheDeepCD:Start(3.2)--17.4
		timerStormsWailCD:Start(6.6)--22.3
		timerSeaSwellCD:Start(7.2)--21.9
		countdownSeaSwell:Start(7.2)
		if self:IsMythic() then
			timerVoltaicFlashCD:Start(18.7)
			timerVoltaicFlashCD:SetFade(false)
			timerSeasTemptationCD:Start(38.7, 1)
			timerSeasTemptationCD:SetFade(false, 1)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 146251 then--Sister
		timerVoltaicFlashCD:Stop()
		timerCracklingLightningCD:Stop()
		self.vb.bossesDied = self.vb.bossesDied + 1
		timerElecShroudCD:Stop()
	elseif cid == 146251 then--Brother
		timerSeaStormCD:Stop()
		timerSeasTemptationCD:Stop()
		self.vb.bossesDied = self.vb.bossesDied + 1
		timerTidalShroudCD:Stop()
	end
end
