local mod	= DBM:NewMod(2359, "DBM-EternalPalace", nil, 1179)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(152852, 152853)--Pashmar 152852, Silivaz 152853
mod:SetEncounterID(2311)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 4)
mod:SetHotfixNoticeRev(20190807000000)--2019, 8, 7
--mod:SetMinSyncRevision(16950)
mod.respawnTime = 20

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 300088 301807 297325 301947 299915 300395",
	"SPELL_CAST_SUCCESS 296850",
	"SPELL_AURA_APPLIED 296704 301244 297656 297585 301828 299914 296851 304409",
	"SPELL_AURA_APPLIED_DOSE 301828",
	"SPELL_AURA_REMOVED 296704 301244 297656 299914 296851",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, better detection of when player is standing still too long with sentence, and re-show keep move warning if they aren't moving enough
--TODO, Frenetic Charge soak priority
--[[
(ability.id = 300088 or ability.id = 301807 or ability.id = 297325 or ability.id = 301947 or ability.id = 299915) and type = "begincast"
 or (ability.id = 296850) and type = "cast"
 or source.name = "Queen Azshara" and type = "applydebuff"
--]]
--General
local warnDesperateMeasures				= mod:NewCastAnnounce(300088, 4)
--Queen Azshara
local warnRepeatPerformance				= mod:NewTargetNoFilterAnnounce(301244, 3, nil, "Tank|Healer")--Important to tanks healers, if one of targets is tank or healer
local warnRepeatPerformanceOver			= mod:NewFadesAnnounce(301244, 1)--Personal fades warning
local warnStandAlone					= mod:NewTargetAnnounce(297656, 2)
local warnStandAloneOver				= mod:NewFadesAnnounce(297656, 1)--Personal fades warning
local warnDeferredSentence				= mod:NewSpellAnnounce(297566, 2)
--Silivaz the Zealous
local warnSilivazTouch					= mod:NewStackAnnounce(244899, 2, nil, "Tank")
local warnFreneticCharge				= mod:NewTargetNoFilterAnnounce(299914, 4)
--Pashmar the Fanatical
local warnPashmarsTouch					= mod:NewStackAnnounce(245518, 2, nil, "Tank")
local warnPotentSpark					= mod:NewSpellAnnounce(301947, 3)
local warnFanaticalVerdict				= mod:NewTargetAnnounce(296851, 2)

--Queen Azshara
local specWarnFormRanks					= mod:NewSpecialWarningMoveTo(298050, "-Tank", nil, 2, 1, 2)
local specWarnRepeatPerformance			= mod:NewSpecialWarningYou(301244, nil, nil, nil, 1, 2)
local specWarnStandAlone				= mod:NewSpecialWarningMoveAway(297656, nil, nil, nil, 1, 2)
local yellStandAlone					= mod:NewYell(297656)
local specWarnObeyorSuffer				= mod:NewSpecialWarningDefensive(297585, nil, nil, nil, 1, 2)
local specWarnObeyorSufferTaunt			= mod:NewSpecialWarningTaunt(297585, false, nil, 2, 1, 2)
--Silivaz the Zealous
local specWarnSilivazTouch				= mod:NewSpecialWarningStack(301828, nil, 7, nil, nil, 1, 6)
--local specWarnSilivazTouchOther		= mod:NewSpecialWarningTaunt(301828, false, nil, 2, 1, 2)
local specWarnFreneticCharge			= mod:NewSpecialWarningMoveTo(299914, nil, nil, nil, 1, 2)
local yellFreneticCharge				= mod:NewYell(299914, nil, nil, nil, "YELL")
local yellFreneticChargeFades			= mod:NewShortFadesYell(299914, nil, nil, nil, "YELL")
local specWarnZealousEruption			= mod:NewSpecialWarningMoveTo(301807, nil, nil, nil, 3, 2)
--Pashmar the Fanatical
local specWarnPashmarsTouch				= mod:NewSpecialWarningStack(301830, nil, 7, nil, nil, 1, 6)
--local specWarnPashmarsTouchOther		= mod:NewSpecialWarningTaunt(301830, false, nil, 2, 1, 2)
local specWarnFanaticalVerdict			= mod:NewSpecialWarningMoveAway(296851, nil, nil, nil, 1, 2)
local yellFanaticalVerdict				= mod:NewYell(296851)
local yellFanaticalVerdictFades			= mod:NewShortFadesYell(296851)
local specWarnViolentOutburst			= mod:NewSpecialWarningRun(297325, nil, nil, nil, 4, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

--General
local timerDesperateMeasures			= mod:NewCastTimer(10, 300088, nil, nil, nil, 5)
--Queen Azshara
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20258))
local timerFormRanksCD					= mod:NewNextTimer(40, 298050, nil, nil, nil, 3, nil, nil, nil, 1, 4)
local timerRepeatPerformanceCD			= mod:NewNextTimer(40, 301244, nil, nil, nil, 3, nil, nil, nil, 1, 4)
local timerStandAloneCD					= mod:NewNextTimer(40, 297656, nil, nil, nil, 3, nil, nil, nil, 1, 4)
local timerDeferredSentenceCD			= mod:NewNextTimer(40, 297566, nil, nil, nil, 3, nil, nil, nil, 1, 4)
local timerObeyorSufferCD				= mod:NewNextTimer(40, 297585, nil, nil, nil, 3, nil, nil, nil, 1, 4)
--Silivaz the Zealous
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20231))
local timerFreneticChargeCD				= mod:NewNextTimer(40, 299914, nil, nil, nil, 3, nil, nil, nil, not mod:IsTank() and 2, 4)
local timerZealousEruptionCD			= mod:NewNextTimer(104.4, 301807, nil, nil, nil, 2)
--Pashmar the Fanatical
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20235))
local timerFerventBoltCD				= mod:NewCDTimer(11.3, 300395, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerFanaticalVerdictCD			= mod:NewNextTimer(26.7, 296850, nil, nil, nil, 3)
local timerViolentOutburstCD			= mod:NewNextTimer(104.4, 297325, nil, nil, nil, 2)
local timerPotentSparkCD				= mod:NewCDTimer(92.2, 301947, nil, nil, nil, 1)

local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddNamePlateOption("NPAuraOnSoP", 296704)
mod:AddSetIconOption("SetIconFreneticCharge", 299914, true, false, {4})
mod:AddSetIconOption("SetIconSparks", 301947, true, true, {1, 2, 3})

mod.vb.sparkIcon = 1
mod.vb.decreeTimer = 90

function mod:OnCombatStart(delay)
	self.vb.sparkIcon = 1
	--Timers that are same across board
	--ass-shara
	timerFormRanksCD:Start(30-delay)
	--Pashmar
	timerFerventBoltCD:Start(5.1-delay)
	timerFanaticalVerdictCD:Start(37.3-delay)
	timerViolentOutburstCD:Start(100.1-delay)
	--Timers that differ by difficulty
	if self:IsMythic() then
		--Silivaz
		timerFreneticChargeCD:Start(30-delay)
		timerZealousEruptionCD:Start(50-delay)
		--Pashmar
		timerPotentSparkCD:Start(20.2-delay)
		berserkTimer:Start(450-delay)
		self.vb.decreeTimer = 30
	else
		--Silivaz
		timerZealousEruptionCD:Start(60.5-delay)
		timerFreneticChargeCD:Start(75-delay)
		--Pashmar
		timerPotentSparkCD:Start(15.8-delay)
		if self:IsHeroic() then
			self.vb.decreeTimer = 40
		elseif self:IsLFR() then
			self.vb.decreeTimer = 90
		else
			self.vb.decreeTimer = 60
		end
	end
	if self.Options.NPAuraOnSoP then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnSoP then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 300088 then
		if self:AntiSpam(1.5, 1) then
			warnDesperateMeasures:Show()
		end
		timerDesperateMeasures:Start(10, args.sourceGUID)
	elseif spellId == 301807 then
		specWarnZealousEruption:Show(BOSS)
		specWarnZealousEruption:Play("runin")
		timerZealousEruptionCD:Start()
	elseif spellId == 297325 then
		specWarnViolentOutburst:Show()
		specWarnViolentOutburst:Play("justrun")
		timerViolentOutburstCD:Start(self:IsMythic() and 106 or 104.4)
	elseif spellId == 301947 then
		self.vb.sparkIcon = 1
		warnPotentSpark:Show()
		timerPotentSparkCD:Start()
	elseif spellId == 299915 then
		timerFreneticChargeCD:Start(40)
	elseif spellId == 300395 then
		timerFerventBoltCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 296850 then
		timerFanaticalVerdictCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 296704 then
		if self.Options.NPAuraOnSoP then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 301244 or spellId == 304409 then
		warnRepeatPerformance:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnRepeatPerformance:Show()
			specWarnRepeatPerformance:Play("targetyou")
		end
	elseif spellId == 297656 then
		warnStandAlone:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnStandAlone:Show()
			specWarnStandAlone:Play("runout")
			yellStandAlone:Yell()
		end
	elseif spellId == 297585 then
		if args:IsPlayer() then
			specWarnObeyorSuffer:Show()
			specWarnObeyorSuffer:Play("defensive")
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnObeyorSufferTaunt:Show(args.destName)
				specWarnObeyorSufferTaunt:Play("tauntboss")
			end
		end
	elseif spellId == 301828 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			--local tauntStack = 3
			--if self:IsMythic() and self.Options.TauntBehavior == "TwoMythicThreeNon" or self.Options.TauntBehavior == "TwoAlways" then
			--	tauntStack = 2
			--end
			if amount >= 7 then--Lasts 20 seconds, unknown reapplication rate, fine tune!
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnSilivazTouch:Show(amount)
					specWarnSilivazTouch:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					--[[local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					--if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 9.6) then
					if not UnitIsDeadOrGhost("player") and not remaining  then
						specWarnSilivazTouchOther:Show(args.destName)
						specWarnSilivazTouchOther:Play("tauntboss")
					else--]]
						warnSilivazTouch:Show(args.destName, amount)
					--end
				end
			else
				warnSilivazTouch:Show(args.destName, amount)
			end
		end
	elseif spellId == 301830 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			--local tauntStack = 3
			--if self:IsMythic() and self.Options.TauntBehavior == "TwoMythicThreeNon" or self.Options.TauntBehavior == "TwoAlways" then
			--	tauntStack = 2
			--end
			if amount >= 7 then--Lasts 20 seconds, unknown reapplication rate, fine tune!
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnPashmarsTouch:Show(amount)
					specWarnPashmarsTouch:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					--[[local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					--if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 9.6) then
					if not UnitIsDeadOrGhost("player") and not remaining  then
						specWarnPashmarsTouchOther:Show(args.destName)
						specWarnPashmarsTouchOther:Play("tauntboss")
					else--]]
						warnPashmarsTouch:Show(args.destName, amount)
					--end
				end
			else
				warnPashmarsTouch:Show(args.destName, amount)
			end
		end
	elseif spellId == 299914 then
		if args:IsPlayer() then
			specWarnFreneticCharge:Show(GROUP)
			specWarnFreneticCharge:Play("gathershare")
			yellFreneticCharge:Yell()
			yellFreneticChargeFades:Countdown(spellId)
		elseif not DBM:UnitDebuff("player", 297656, 303188, 297585) and not self:IsTank() then--Not tank, or affected by decrees that'd conflict with soaking
			specWarnFreneticCharge:Show(args.destName)
			specWarnFreneticCharge:Play("gathershare")
		else
			warnFreneticCharge:Show(args.destName)
		end
		if self.Options.SetIconFreneticCharge then
			self:SetIcon(args.destName, 4)
		end
	elseif spellId == 296851 then
		warnFanaticalVerdict:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFanaticalVerdict:Show()
			specWarnFanaticalVerdict:Play("runout")
			yellFanaticalVerdict:Yell()
			yellFanaticalVerdictFades:Countdown(spellId)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 296704 then
		if self.Options.NPAuraOnSoP then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 301244 then
		if args:IsPlayer() then
			warnRepeatPerformanceOver:Show()
		end
	elseif spellId == 297656 then
		if args:IsPlayer() then
			warnStandAloneOver:Show()
		end
	elseif spellId == 299914 then
		if args:IsPlayer() then
			yellFreneticChargeFades:Cancel()
		end
		if self.Options.SetIconFreneticCharge then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 296851 then
		if args:IsPlayer() then--If you have form ranks, do NOT run out
			yellFanaticalVerdictFades:Cancel()
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:298050") then--Form Ranks (Repeat Performance is next)
		specWarnFormRanks:Show(L.Circles)
		specWarnFormRanks:Play("gathershare")
		timerRepeatPerformanceCD:Start(self.vb.decreeTimer)
	elseif msg:find("spell:301244") then--Repeat Performance (Stand Alone is next)
		timerStandAloneCD:Start(self.vb.decreeTimer)
	elseif msg:find("spell:297656") then--Stand Alone (Sentence is next)
		if self:IsLFR() then--In LFR, it returns to form ranks, obey and differred aren't used in LFR
			timerFormRanksCD:Start(self.vb.decreeTimer)
		else
			timerDeferredSentenceCD:Start(self.vb.decreeTimer)
		end
	elseif msg:find("spell:297566") then--Defferred Sentence (Obey is next)
		warnDeferredSentence:Show()
		timerObeyorSufferCD:Start(self.vb.decreeTimer)
	elseif msg:find("spell:297585") then--Obey or Suffer (loops back to form ranks after)
		timerFormRanksCD:Start(self.vb.decreeTimer)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 297851 then--Potent Spark have boss unit Ids and they cast this right after IEEU as well
		if not GetRaidTargetIndex(uId) then--Not already marked
			if self.Options.SetIconSparks then
				SetRaidTarget(uId, self.vb.sparkIcon)
			end
			self.vb.sparkIcon = self.vb.sparkIcon + 1
		end
	end
end
