local dungeonID, creatureID
if UnitFactionGroup("player") == "Alliance" then
	dungeonID, creatureID = 2344, 144683--Ra'wani Kanae
else--Horde
	dungeonID, creatureID = 2333, 144680--Frida Ironbellows
end
local mod	= DBM:NewMod(dungeonID, "DBM-ZuldazarRaid", 1, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(creatureID)
mod:SetEncounterID(2265)
mod:SetZone()
--mod:SetHotfixNoticeRev(17775)
mod.respawnTime = 17--Ish, from stream watching.

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 283598 284474 283662 284578 283628 283626 283650 283933 287469 287419",
	"SPELL_INTERRUPT",
	"SPELL_AURA_APPLIED 284468 283619 283573 284469 283933 284436 282113 283582",
	"SPELL_AURA_APPLIED_DOSE 283573",
	"SPELL_AURA_REMOVED 283619 284468 284469 283933 284436",
	"UNIT_DIED"
)

--[[
(ability.id = 284469 or ability.id = 284436 or ability.id = 287469 or ability.id = 283598 or ability.id = 283662) and type = "begincast"
 or (ability.id = 284469 or ability.id = 284436) and (type = "applybuff" or type = "removebuff")
--]]
--TODO, swap count for Sacred Blade? Should it be a force swap in LFR?
--TODO, maybe a custom huge interrupt icon for the nameplate cast icon for angelic?
local warnWaveofLight					= mod:NewTargetNoFilterAnnounce(283598, 1)
local warnSacredBlade					= mod:NewStackAnnounce(283573, 2, nil, "Tank")
local warnSealofRet						= mod:NewSpellAnnounce(283573, 2)
local warnJudgmentRighteousness			= mod:NewTargetNoFilterAnnounce(283933, 4)
local warnSealofReckoning				= mod:NewSpellAnnounce(284436, 2)
local warnAvengingWrath					= mod:NewTargetNoFilterAnnounce(282113, 3)

local specWarnTargetChange				= mod:NewSpecialWarningTargetChange(283662, nil, nil, nil, 1, 2)
local specWarnSacredBlade				= mod:NewSpecialWarningStack(283573, nil, 5, nil, nil, 1, 6)
local specWarnSacredBladeTaunt			= mod:NewSpecialWarningTaunt(283573, false, nil, 2, 1, 2)
local specWarnWaveofLight				= mod:NewSpecialWarningTarget(283598, false, nil, 2, 1, 2)
local specWarnWaveofLightYou			= mod:NewSpecialWarningYou(283598, nil, nil, nil, 1, 2)
local yellWaveofLight					= mod:NewYell(283598)
--local specWarnWaveofLightGeneral		= mod:NewSpecialWarningDodge(283598, nil, nil, nil, 2, 2)
local specWarnWaveofLightDispel			= mod:NewSpecialWarningDispel(283598, false, nil, 2, 1, 2)
local specWarnJudgmentReckoning			= mod:NewSpecialWarningSoon(284474, nil, nil, nil, 2, 2)
local specWarnCalltoArms				= mod:NewSpecialWarningSwitch(283662, "Tank", nil, 2, 1, 2)
local specWarnPenance					= mod:NewSpecialWarningInterrupt(284578, "HasInterrupt", nil, nil, 1, 2)
local specWarnHeal						= mod:NewSpecialWarningInterrupt(283628, "HasInterrupt", nil, nil, 1, 2)
local specWarnDivineBurst				= mod:NewSpecialWarningInterrupt(283626, false, nil, 2, 1, 2)
local specWarnBlindingFaith				= mod:NewSpecialWarningLookAway(283650, nil, nil, nil, 3, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(283582, nil, nil, nil, 1, 8)
local specWarnPrayerfortheFallen		= mod:NewSpecialWarningSpell(287469, nil, nil, nil, 3, 2, 4)--Mythic

mod:AddTimerLine(DBM_BOSS)
local timerWaveofLightCD				= mod:NewCDTimer(10.5, 283598, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
local timerJudgmentRetCD				= mod:NewNextTimer(50.3, 283933, nil, nil, nil, 3, nil, nil, nil, 1, 5)
local timerJudgmentReckoningCD			= mod:NewNextTimer(50.3, 284474, nil, nil, nil, 2, nil, nil, nil, 1, 5)
--local timerCallToArmsCD					= mod:NewCDTimer(104.6, 283662, nil, nil, nil, 1)--Adds come with phase change, redundant
local timerPrayerfortheFallenCD			= mod:NewCDTimer(50.2, 287469, nil, nil, nil, 2, nil, DBM_CORE_MYTHIC_ICON, nil, 2, 4)
mod:AddTimerLine(DBM_ADDS)
local timerBlindingFaithCD				= mod:NewCDTimer(13.4, 284474, nil, nil, nil, 2)

--local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddNamePlateOption("NPAuraOnRet2", 284468, false)--off by default since it's basically on the mobs half the fight
mod:AddNamePlateOption("NPAuraOnWave", 283619)
mod:AddNamePlateOption("NPAuraOnJudgment", 283933)
mod:AddNamePlateOption("NPAuraOnBlindingFaith", 283650)
mod:AddNamePlateOption("NPAuraOnAngelicRenewal", 287419)

function mod:WaveofLightTarget(targetname, uId)
	if uId then
		if not UnitIsFriend("player", uId) then--Boss targetting one of adds
			if UnitIsUnit("target", uId) and self.Options.SpecWarn283598target2 then
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
			end
		end
	end
end

function mod:OnCombatStart(delay)
	warnSealofRet:Show()
	timerWaveofLightCD:Start(13.1-delay)
	timerJudgmentRetCD:Start(50.7-delay)
	specWarnJudgmentReckoning:Schedule(45.7-delay)
	specWarnJudgmentReckoning:ScheduleVoice(45.7, "aesoon")
	if self:IsMythic() then
		timerPrayerfortheFallenCD:Start(25.5-delay)
	end
	if self.Options.NPAuraOnRet2 or self.Options.NPAuraOnWave or self.Options.NPAuraOnJudgment or self.Options.NPAuraOnBlindingFaith or self.Options.NPAuraOnAngelicRenewal then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnRet2 or self.Options.NPAuraOnWave or self.Options.NPAuraOnJudgment or self.Options.NPAuraOnBlindingFaith or self.Options.NPAuraOnAngelicRenewal then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 283598 then
		timerWaveofLightCD:Start()
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "WaveofLightTarget", 0.1, 8, true, nil, nil, nil, true)--cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, isFinalScan, targetFilter, tankFilter
	elseif spellId == 283933 then--Judgment: Righteousness
		specWarnTargetChange:Show(DBM_ADDS)
		specWarnTargetChange:Play("targetchange")
	elseif spellId == 284474 then--Judgment: Reckoning
		specWarnTargetChange:Show(DBM_BOSS)
		specWarnTargetChange:Play("targetchange")
	elseif spellId == 283662 then
		specWarnCalltoArms:Show()
		specWarnCalltoArms:Play("mobsoon")
	elseif spellId == 284578 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnPenance:Show(args.sourceName)
		specWarnPenance:Play("kickcast")
	elseif spellId == 283628 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHeal:Show(args.sourceName)
		specWarnHeal:Play("kickcast")
	elseif spellId == 283626 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDivineBurst:Show(args.sourceName)
		specWarnDivineBurst:Play("kickcast")
	elseif spellId == 283650 then
		timerBlindingFaithCD:Start(13.4, args.sourceGUID)
		if self:AntiSpam(3.5, 1) then
			specWarnBlindingFaith:Show(args.sourceName)
			specWarnBlindingFaith:Play("turnaway")
		end
		if self.Options.NPAuraOnBlindingFaith then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 4)
		end
	elseif spellId == 287469 then
		specWarnPrayerfortheFallen:Show()
		specWarnPrayerfortheFallen:Play("specialsoon")
		timerPrayerfortheFallenCD:Start(50.2)
	elseif spellId == 287419 then
		if self.Options.NPAuraOnAngelicRenewal then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 8)
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 287419 then
		if self.Options.NPAuraOnAngelicRenewal then
			DBM.Nameplate:Hide(true, args.destGUID)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 283573 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 5 then
				if args:IsPlayer() then
					specWarnSacredBlade:Show(amount)
					specWarnSacredBlade:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) and self.Options.SpecWarn283573taunt2 then--Can't taunt less you've dropped yours off, period.
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
		if self.Options.NPAuraOnRet2 then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 284469 then--Seal of Retribution
		warnSealofRet:Show()
		timerJudgmentRetCD:Start(52.3)--50.6?
		specWarnJudgmentReckoning:Schedule(47.3)
		specWarnJudgmentReckoning:ScheduleVoice(47.3, "aesoon")
	elseif spellId == 284436 then--Seal of Reckoning
		--Blizz changed it that if all adds die, seal of reck is recast right away instead of maintaining seal of ret
		timerJudgmentRetCD:Stop()
		warnSealofReckoning:Show()
		timerJudgmentReckoningCD:Start(52.3)
	elseif spellId == 283933 then
		warnJudgmentRighteousness:Show(args.destName)
		if self.Options.NPAuraOnJudgment then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 282113 then
		warnAvengingWrath:Show(args.destName)
	elseif spellId == 283582 and args:IsPlayer() and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
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
		if self.Options.NPAuraOnRet2 then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 283933 then
		if self.Options.NPAuraOnJudgment then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 284469 then--Seal of Retribution
		timerJudgmentRetCD:Stop()
	elseif spellId == 284436 then--Seal of Reckoning
		timerJudgmentReckoningCD:Stop()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 283582 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 147895 or cid == 145898 then--Rezani Disciple/Anointed Disciple

	elseif cid == 147896 or cid == 145903 then--Zandalari Crusader/Darkforged Crusader
		timerBlindingFaithCD:Stop(args.destGUID)
		if self.Options.NPAuraOnBlindingFaith then
			DBM.Nameplate:Hide(true, args.destGUID, 283650)
		end
	end
end
