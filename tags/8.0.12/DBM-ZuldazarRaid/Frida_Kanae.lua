local dungeonID, creatureID
if UnitFactionGroup("player") == "Alliance" then
	dungeonID, creatureID = 2344, 144683--Ra'wani Kanae
else--Horde
	dungeonID, creatureID = 2333, 144680--Frida Ironbellows
end
local mod	= DBM:NewMod(dungeonID, "DBM-ZuldazarRaid", 1, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(creatureID)
mod:SetEncounterID(2265)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 8)
--mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 283598 284474 283662 284578 283628 283626 283650",
	"SPELL_CAST_SUCCESS 283573",
	"SPELL_AURA_APPLIED 284468 283619 283573 284469 283933 284436 282113",
	"SPELL_AURA_APPLIED_DOSE 283573",
	"SPELL_AURA_REMOVED 283619 284468 284469 283933 284436",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, swap count for Sacred Blade
--TODO, target scanning Wave of Light working?
--TODO, Reckoning cast event?
--TODO, waves of Judgment: Recokoning dodgable?
--local warnXorothPortal				= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
--Stage One: The Forces of Blood
--local warnPoolofDarkness				= mod:NewCountAnnounce(273361, 4)
local warnWaveofLight					= mod:NewTargetAnnounce(283598, 1)
local warnSacredBlade					= mod:NewStackAnnounce(283573, 2, nil, "Tank")
local warnSealofRet						= mod:NewTargetNoFilterAnnounce(283573, 2)
local warnJudgmentRighteousness			= mod:NewTargetNoFilterAnnounce(283933, 4)
local warnSealofReckoning				= mod:NewTargetNoFilterAnnounce(284436, 2)
local warnAvengingWrath					= mod:NewTargetNoFilterAnnounce(282113, 3)

local specWarnSacredBlade				= mod:NewSpecialWarningStack(283573, nil, 3, nil, nil, 1, 6)
local specWarnSacredBladeTaunt			= mod:NewSpecialWarningTaunt(283573, nil, nil, nil, 1, 2)
local specWarnWaveofLight				= mod:NewSpecialWarningTarget(283598, "Tank", nil, nil, 3, 2)
local specWarnWaveofLightYou			= mod:NewSpecialWarningYou(283598, nil, nil, nil, 1, 2)
local yellWaveofLight					= mod:NewYell(283598)
local specWarnWaveofLightGeneral		= mod:NewSpecialWarningDodge(283598, nil, nil, nil, 2, 2)
local specWarnWaveofLightDispel			= mod:NewSpecialWarningDispel(283598, "MagicDispeller", nil, nil, 1, 2)
local specWarnJudgmentReckoning			= mod:NewSpecialWarningSpell(284474, nil, nil, nil, 2, 2)
local specWarnCalltoArms				= mod:NewSpecialWarningSwitch(283662, "-Healer", nil, nil, 1, 2)
--local yellDarkRevolationFades			= mod:NewIconFadesYell(273365)
local specWarnPenance					= mod:NewSpecialWarningInterrupt(284578, "HasInterrupt", nil, nil, 1, 2)
local specWarnHeal						= mod:NewSpecialWarningInterrupt(283628, "HasInterrupt", nil, nil, 1, 2)
local specWarnDivineBurst				= mod:NewSpecialWarningInterrupt(283626, "HasInterrupt", nil, nil, 1, 2)
local specWarnBlindingFaith				= mod:NewSpecialWarningLookAway(283650, nil, nil, nil, 3, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
local timerSacredBladeCD				= mod:NewAITimer(14.1, 283573, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerWaveofLightCD				= mod:NewAITimer(14.1, 283598, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
local timerJudgmentRightCD				= mod:NewAITimer(55, 283933, nil, nil, nil, 3)
local timerJudgmentReckoningCD			= mod:NewAITimer(55, 284474, nil, nil, nil, 2)
local timerCallToArmsCD					= mod:NewAITimer(55, 284474, nil, nil, nil, 1)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddSetIconOption("SetIconGift", 255594, true)
--mod:AddRangeFrameOption("8/10")
--mod:AddInfoFrameOption(258040, true)
mod:AddNamePlateOption("NPAuraOnRet", 284468)
mod:AddNamePlateOption("NPAuraOnWave", 283619)
mod:AddNamePlateOption("NPAuraOnJudgment", 283933)
--mod:AddSetIconOption("SetIconDarkRev", 273365, true)

--mod.vb.phase = 1

function mod:WaveofLightTarget(targetname, uId)
	if uId then
		if not UnitIsFriend("player", uId) then--Boss targetting one of adds
			if UnitIsUnit("target", uId) then
				specWarnWaveofLight:Show(targetname)
				specWarnWaveofLight:Play("moveboss")
			else
				warnWaveofLight:Show(targetname)
			end
		else
			if targetname == UnitName("player") and self:AntiSpam(5, 5) then
				specWarnWaveofLightYou:Show()
				specWarnWaveofLightYou:Play("targetyou")
				yellWaveofLight:Yell()
			else
				warnWaveofLight:Show(targetname)
				specWarnWaveofLightGeneral:Show()
				specWarnWaveofLightGeneral:Play("watchwave")
			end
		end
	else
		specWarnWaveofLightGeneral:Show()
		specWarnWaveofLightGeneral:Play("watchwave")
	end
end

function mod:OnCombatStart(delay)
	timerSacredBladeCD:Start(1-delay)
	timerWaveofLightCD:Start(1-delay)
	timerCallToArmsCD:Start(1-delay)
	if self.Options.NPAuraOnRet or self.Options.NPAuraOnWave or self.Options.NPAuraOnJudgment then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.NPAuraOnRet or self.Options.NPAuraOnWave or self.Options.NPAuraOnJudgment then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 273316 then
		timerWaveofLightCD:Start()
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "WaveofLightTarget", 0.1, 8, true, nil, nil, nil, true)--cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, isFinalScan, targetFilter, tankFilter
	elseif spellId == 284474 then
		specWarnJudgmentReckoning:Show()
		specWarnJudgmentReckoning:Play("aesoon")
	elseif spellId == 283662 then
		specWarnCalltoArms:Show()
		specWarnCalltoArms:Play("killmob")
		timerCallToArmsCD:Start()
	elseif spellId == 284578 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnPenance:Show(args.sourceName)
		specWarnPenance:Play("kickcast")
	elseif spellId == 283628 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHeal:Show(args.sourceName)
		specWarnHeal:Play("kickcast")
	elseif spellId == 283626 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDivineBurst:Show(args.sourceName)
		specWarnDivineBurst:Play("kickcast")
	elseif spellId == 283650 and self:AntiSpam(3, 1) then
		specWarnBlindingFaith:Show(args.sourceName)
		specWarnBlindingFaith:Play("turnaway")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 283573 then
		timerSacredBladeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 283573 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnSacredBlade:Show(amount)
					specWarnSacredBlade:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off, period.
						specWarnSacredBladeTaunt:Show(args.destName)
						specWarnSacredBladeTaunt:Play("tauntboss")
					else
						warnSacredBlade:Show(args.destName, amount)
					end
				end
			else
				warnSacredBlade:Show(args.destName, amount)
			end
		end
	elseif spellId == 283619 then
		specWarnWaveofLightDispel:CombinedShow(0.5, args.destName)
		specWarnWaveofLightDispel:ScheduleVoice(0.5, "helpdispel")
		if self.Options.NPAuraOnWave then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 7)
		end
	elseif spellId == 284468 then
		if self.Options.NPAuraOnRet then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 284469 then--Seal of Retribution
		warnSealofRet:Show(args.destName)
		timerJudgmentRightCD:Start(2)
	elseif spellId == 284436 then--Seal of Reckoning
		warnSealofReckoning:Show(args.destName)
		timerJudgmentReckoningCD:Start(2)
	elseif spellId == 283933 then
		warnJudgmentRighteousness:Show(args.destName)
		if self.Options.NPAuraOnJudgment then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 282113 then
		warnAvengingWrath:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 283619 then
		if self.Options.NPAuraOnWave then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 284468 then
		if self.Options.NPAuraOnRet then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 283933 then
		if self.Options.NPAuraOnJudgment then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 284469 then--Seal of Retribution
		timerJudgmentRightCD:Stop()
	elseif spellId == 284436 then--Seal of Reckoning
		timerJudgmentReckoningCD:Stop()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 147895 or cid == 145898 then--Rezani Disciple/Anointed Disciple
	
	elseif cid == 147896 or cid == 145903 then--Zandalari Crusader/Darkforged Crusader

	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 274315 then

	end
end
--]]
