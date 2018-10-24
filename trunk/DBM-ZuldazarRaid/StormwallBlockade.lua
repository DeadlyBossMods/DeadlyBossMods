local mod	= DBM:NewMod(2337, "DBM-ZuldazarRaid", 3, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(146251, 146253, 146256)--Sister Katherine 146251, Brother Joseph 146253, Laminaria 146256
mod:SetEncounterID(2280)
--mod:DisableESCombatDetection()
mod:SetZone()
mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 8)
--mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 284262 284106 284393 284383 285118 285017 284362",
	"SPELL_CAST_SUCCESS 285350 285426",
	"SPELL_AURA_APPLIED 286558 284405 285000 285382 285350 285426",
	"SPELL_AURA_REFRESH 285000 285382",
	"SPELL_AURA_APPLIED_DOSE 285000 285382",
	"SPELL_AURA_REMOVED 286558 285000 285382 285350 285426",
	"SPELL_PERIODIC_DAMAGE 285075",
	"SPELL_PERIODIC_MISSED 285075",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, ability to detect what ship one is on, and filter warnings from other ship/dock
--TODO, P2 detection. UNIT_DIED probably not used for sister and brother since they stay active in some capacity
--TODO, target scan or emote for Crackling Lightning location?
--TODO, switch to custom hybrid frame to show both shields and boss energy and storm's Wail
--TODO, add Tidal/Jolting Volleys? Just seems like general consistent aoe damage so not worth warning yet
--TODO, add range frame show on P2 when P2 is detectable
--TODO, icons and stuff for storm's wail
--TODO, add "watch wave" warning for Energized wake on mythic
--local warnXorothPortal				= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
--Stage One: Storm the Ships
----General
local warnTranslocate					= mod:NewTargetNoFilterAnnounce(284393, 2)
----Sister Katherine
local warnCracklingLightning			= mod:NewCastAnnounce(284106, 3)
----Brother Joseph
local warnTemptingSong					= mod:NewTargetAnnounce(284405, 2)
--Stage Two: Laminaria
local warnKelpWrapped					= mod:NewStackAnnounce(285000, 2, nil, "Tank")
local warnStormsWail					= mod:NewTargetNoFilterAnnounce(285350, 3)

--Stage One: Storm the Ships
----General
local specWarnTidalShroud				= mod:NewSpecialWarningSwitch(286558, nil, nil, nil, 3, 2)
local specWarnTidalEmpowerment			= mod:NewSpecialWarningInterrupt(284765, "HasInterrupt", nil, nil, 1, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(285075, nil, nil, nil, 1, 8)
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
--local specWarnEnergizedStorm			= mod:NewSpecialWarningSwitch("ej19312", "Tank", nil, nil, 1, 2)
--local specWarnKepWrappedTaunt			= mod:NewSpecialWarningTaunt(285000, nil, nil, nil, 1, 2)
local yellKepWrapped					= mod:NewFadesYell(285000)
local specWarnSeaSwell					= mod:NewSpecialWarningDodge(285118, nil, nil, nil, 2, 2)
local specWarnIreoftheDeep				= mod:NewSpecialWarningSoak(285017, "-Tank", nil, nil, 1, 2)
local specWarnStormsWail				= mod:NewSpecialWarningMoveTo(285350, nil, nil, nil, 1, 2)
local yellStormsWail					= mod:NewYell(285350)
local yellStormsWailFades				= mod:NewShortFadesYell(285350)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
--Stage One: Storm the Ships
----General
local timerTidalShroudCD				= mod:NewCDTimer(31.5, 286558, nil, nil, nil, 4, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_INTERRUPT_ICON)--Might be series timer, 37 then 31
----Sister Katherine
local timerVoltaicFlashCD				= mod:NewCDTimer(17, 284262, nil, nil, nil, 3)
local timerCracklingLightningCD			= mod:NewCDTimer(18.2, 284106, nil, nil, nil, 3)
--local timerThunderousBoomCD			= mod:NewCastTimer(55, 284120, nil, nil, nil, 2)--After timing is figured out after crackling
--local timerBloodyCleaveCD				= mod:NewAITimer(14.1, 273316, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
----Brother Joseph
local timerSeaStormCD					= mod:NewCDTimer(17, 284360, nil, nil, nil, 3)
local timerSeasTemptationCD				= mod:NewCDTimer(26.7, 284383, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)--Might be 36.1 before teleport and 26.7 after teleport
--Stage Two: Laminaria
local timerSeaSwellCD					= mod:NewCDTimer(22.4, 285118, nil, nil, nil, 3)
local timerIreoftheDeepCD				= mod:NewCDTimer(27.9, 285017, nil, nil, nil, 5)
local timerStormsWailCD					= mod:NewCDTimer(53.5, 285350, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddSetIconOption("SetIconGift", 255594, true)
mod:AddRangeFrameOption(5, 285118)
mod:AddInfoFrameOption(284760, true)
mod:AddNamePlateOption("NPAuraOnKepWrapping", 285382)
--mod:AddSetIconOption("SetIconDarkRev", 273365, true)

mod.vb.phase = 1
mod.vb.shieldsActive = 0
mod.vb.bossesDied = 0
mod.vb.firstCast = false
local freezingTidePod = DBM:GetSpellInfo(285075)

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.shieldsActive = 0
	self.vb.bossesDied = 0
	self.vb.firstCast = false
	--Sister
	timerCracklingLightningCD:Start(10.6-delay)
	timerTidalShroudCD:Start(17.3-delay)
	timerVoltaicFlashCD:Start(22.7-delay)
	--Brother
	timerSeaStormCD:Start(1-delay)
	timerSeasTemptationCD:Start(11.3-delay)
	if self.Options.NPAuraOnKepWrapping then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
		DBM.InfoFrame:Show(4, "enemypower", 2)
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

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 284262 then
		if self:CheckTankDistance(args.sourceGUID, 43) then
			specWarnVoltaicFlash:Show()
			specWarnVoltaicFlash:Play("farfromline")
		end
		timerVoltaicFlashCD:Start()
	elseif spellId == 284106 then
		if self:CheckTankDistance(args.sourceGUID, 43) then
			warnCracklingLightning:Show()
		end
		timerCracklingLightningCD:Start()
	elseif spellId == 284393 then
		warnTranslocate:Show(args.sourceName)
	elseif spellId == 284383 then
		if self:CheckTankDistance(args.sourceGUID, 43) then
			specWarnSeasTemptation:Show()
			specWarnSeasTemptation:Play("killmob")
		end
		timerSeasTemptationCD:Start()
	elseif spellId == 285118 then
		specWarnSeaSwell:Show()
		specWarnSeaSwell:Play("watchstep")
		timerSeaSwellCD:Start()
		--Shitty P2 trigger, do better later
		if not self.vb.firstCast then
			self.vb.firstCast = true
			timerIreoftheDeepCD:Start(5)
			timerStormsWailCD:Start(14)
		end
	elseif spellId == 285017 then
		specWarnIreoftheDeep:Show()
		specWarnIreoftheDeep:Play("gathershare")
		timerIreoftheDeepCD:Start()
	elseif spellId == 284362 then
		if self:CheckTankDistance(args.sourceGUID, 43) then
			specWarnSeaStorm:Show()
			specWarnSeaStorm:Play("watchstep")
		end
		timerSeaStormCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if (spellId == 285350 or spellId == 285426) and args:GetSrcCreatureID() == 146256 then
		timerStormsWailCD:Start()
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
					yellKepWrapped:Countdown(15)
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
		self.vb.shieldsActive = self.vb.shieldsActive + 1
		specWarnTidalShroud:Show()
		specWarnTidalShroud:Play("targetchange")
		if self:AntiSpam(5, 1) then
			timerTidalShroudCD:Start()
		end
		if self.Options.InfoFrame and self.vb.shieldsActive == 1 then--Only trigger on first shield going up, info frame itself should scan all bosses automatically
			for i = 1, 3 do
				local bossUnitID = "boss"..i
				if UnitGUID(bossUnitID) == args.sourceGUID then--Identify correct unit ID
					DBM.InfoFrame:SetHeader(args.spellName)
					DBM.InfoFrame:Show(2, "enemyabsorb", nil, UnitGetTotalAbsorbs(bossUnitID))
					break
				end
			end
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
			specWarnStormsWail:Play("targetyou")
			yellStormsWail:Yell()
			yellStormsWailFades:Countdown(10)
		else
			warnStormsWail:Show(args.destName)
		end
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 286558 then
		self.vb.shieldsActive = self.vb.shieldsActive - 1
		if self:CheckInterruptFilter(args.destGUID, false, true) then
			specWarnTidalEmpowerment:Show(args.destName)
			specWarnTidalEmpowerment:Play("kickcast")
		end
		if self.Options.InfoFrame and self.vb.shieldsActive == 0 then
			DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
			DBM.InfoFrame:Show(4, "enemypower", 2)
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
		--specWarnEnergizedStorm:Show()
		--specWarnEnergizedStorm:Play("targetchange")
		if args:IsPlayer() then
			yellStormsWailFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 285075 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 146251 then--Sister
		timerVoltaicFlashCD:Stop()
		timerCracklingLightningCD:Stop()
		self.vb.bossesDied = self.vb.bossesDied + 1
		if self.vb.bossesDied == 2 then
			timerTidalShroudCD:Stop()
		end
	elseif cid == 146251 then--Brother
		timerSeaStormCD:Stop()
		timerSeasTemptationCD:Stop()
		self.vb.bossesDied = self.vb.bossesDied + 1
		if self.vb.bossesDied == 2 then
			timerTidalShroudCD:Stop()
		end
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 274315 then

	end
end
--]]
