local mod	= DBM:NewMod(2440, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(164406)
mod:SetEncounterID(2422)
mod:SetUsedIcons(1, 2, 3, 4)
mod:SetBossHPInfoToHighest()
mod.noBossDeathKill = true--Instructs mod to ignore 158328 deaths, since it dies multiple times
--mod:SetHotfixNoticeRev(20201222000000)
--mod:SetMinSyncRevision(20201222000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 348071 348428 346459 352999 347291 352997 348756 353000 352293 349799 355127 352379 355055 352355 352348",
	"SPELL_CAST_SUCCESS 355136 352293",
	"SPELL_AURA_APPLIED 354198 352530 348978 347292 347518 347454 355948",
	"SPELL_AURA_APPLIED_DOSE 348978",
	"SPELL_AURA_REMOVED 354198 348978 347292 355948",
	"SPELL_SUMMON 352096 352094 352092",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, is blizzard really 20 sec? does it disable bosses other casts?
--TODO, appropriate warning sounds for things
--TODO, verify target scan, maybe switch to unit target scanner or emote if one exists
--TODO, track https://ptr.wowhead.com/spell=354289/necrotic-miasma on infoframe?
--TODO, adds timer in P2 is probably not a timer but continous just like naxxramus
--TODO, not too spammy to warn to interrupt https://ptr.wowhead.com/spell=352144/banshees-cry sometimes?
--TODO, shadow fissure (mythic) have target information?
--TODO, target scan freezing blast?
--TODO, https://ptr.wowhead.com/spell=336047/freezing-blast used?
--TODO, does Glacial winds have a timer after it activates at 33%?
--TODO, figure out how to add https://ptr.wowhead.com/spell=354638/deep-freeze
--https://ptr.wowhead.com/spell=348434/soul-exhaustion used in LFR/normal instead of other one?
--Stage One: Chains and Ice
local warnSoulExhaustion							= mod:NewStackAnnounce(348978, 2, nil, "Tank|Healer")
local warnPiercingWail								= mod:NewCastAnnounce(348428, 2)
local warnOblivionsEcho								= mod:NewTargetNoFilterAnnounce(347292, 2)
local warnFrostBlast								= mod:NewTargetNoFilterAnnounce(348756, 4)
--Stage Two: The Phylactery Opens
local warnFrostboundDevoted							= mod:NewSpellAnnounce("ej23422", 2, 352096, false)
local warnSoulReaver								= mod:NewSpellAnnounce("ej23423", 2, 352094)
local warnAbom										= mod:NewSpellAnnounce("ej23424", 2, 352092)
local warnDemolish									= mod:NewCastAnnounce(349799, 2)
----Remnant of Kel'Thuzad
local warnShadowFissure								= mod:NewSpellAnnounce(355136, 3)
local warnFreezingBlast								= mod:NewCountAnnounce(352379, 3)

--Stage One: Chains and Ice
local specWarnHowlingBlizzard						= mod:NewSpecialWarningDodge(354198, nil, nil, nil, 2, 2)
local specWarnDarkEvocation							= mod:NewSpecialWarningSpell(352530, nil, nil, nil, 2, 2)
local specWarnSoulFracture							= mod:NewSpecialWarningDefensive(348071, nil, nil, nil, 1, 2)
local specWarnGlacialWrath							= mod:NewSpecialWarningSwitch(346459, "Dps", nil, nil, 1, 2)
local specWarnOblivionsEcho							= mod:NewSpecialWarningMoveAway(347292, nil, nil, nil, 1, 2)
local yellOblivionsEcho								= mod:NewShortPosYell(347292)
local specWarnOblivionsEchoNear						= mod:NewSpecialWarningClose(347518, nil, nil, nil, 1, 2)
local specWarnFrostBlast							= mod:NewSpecialWarningMoveTo(348756, nil, nil, nil, 1, 2)
local yellFrostBlast								= mod:NewYell(348756, nil, nil, nil, "YELL")
--local yellFrostBlastFades							= mod:NewShortFadesYell(348756, nil, nil, nil, "YELL")
--Stage Two: The Phylactery Opens
----Remnant of Kel'Thuzad
local specWarnFoulWinds								= mod:NewSpecialWarningSpell(355127, nil, nil, nil, 2, 2, 4)
local specWarnFreezingBlast							= mod:NewSpecialWarningDodge(352379, nil, nil, nil, 2, 2)
local specWarnGlacialWinds							= mod:NewSpecialWarningDodge(355055, nil, nil, nil, 2, 2)
local specWarnNecroticObliteration					= mod:NewSpecialWarningRun(352355, nil, nil, nil, 4, 2)

--local specWarnExsanguinated						= mod:NewSpecialWarningStack(328897, nil, 2, nil, nil, 1, 6)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
--Stage One: Chains and Ice
local timerHowlingBlizzardCD						= mod:NewAITimer(23, 354198, nil, nil, nil, 2)
local timerHowlingBlizzard							= mod:NewBuffActiveTimer(23, 354198, nil, nil, nil, 5)
local timerDarkEvocationCD							= mod:NewAITimer(23, 352530, nil, nil, nil, 3)
local timerSoulFractureCD							= mod:NewAITimer(17.8, 348071, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerGlacialWrathCD							= mod:NewAITimer(17.8, 346459, nil, nil, nil, 3, nil, DBM_CORE_L.DAMAGE_ICON)
local timerOblivionsEchoCD							= mod:NewAITimer(23, 347291, nil, nil, nil, 3)
local timerFrostBlastCD								= mod:NewAITimer(23, 348756, nil, nil, nil, 3, nil, DBM_CORE_L.MAGIC_ICON)
--Stage Two: The Phylactery Opens
local timerNecoticDestruction						= mod:NewCastTimer(23, 352293, nil, nil, nil, 6)
--local timerMarchoftheForsakenCD					= mod:NewAITimer(23, 352090, nil, nil, nil, 1)
----Remnant of Kel'Thuzad
local timerFoulWindsCD								= mod:NewAITimer(23, 355127, nil, nil, nil, 2, nil, DBM_CORE_L.MYTHIC_ICON)
local timerShadowFissureCD							= mod:NewAITimer(23, 355136, nil, nil, nil, 3, nil, DBM_CORE_L.MYTHIC_ICON)
local timerFreezingBlastCD							= mod:NewAITimer(23, 352379, nil, nil, nil, 3)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(354206, true)
mod:AddSetIconOption("SetIconOnEcho", 347291, true, false, {1, 2, 3, 4})
mod:AddNamePlateOption("NPAuraOnNecroticEmpowerment", 355948)

mod.vb.echoIcon = 1
mod.vb.phase = 1
mod.vb.freezingBlastCount = 0

function mod:FrostBlast(targetname, uId, bossuid, scanningTime)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnFrostBlast:Show(DBM_CORE_L.ALLIES)
		specWarnFrostBlast:Play("gathershare")
		yellFrostBlast:Yell()
	else
		warnFrostBlast:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.echoIcon = 1
	self.vb.phase = 1
	self.vb.freezingBlastCount = 0
	timerHowlingBlizzardCD:Start(1-delay)
	timerDarkEvocationCD:Start(1-delay)
	timerSoulFractureCD:Start(1-delay)
	timerGlacialWrathCD:Start(1-delay)
	timerOblivionsEchoCD:Start(1-delay)
	timerFrostBlastCD:Start(1-delay)
--	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_L.INFOFRAME_POWER)
		DBM.InfoFrame:Show(3, "enemypower", 2)
	end
	if self.Options.NPAuraOnNecroticEmpowerment then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnNecroticEmpowerment then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 348071 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnSoulFracture:Show()
			specWarnSoulFracture:Play("carefly")
		end
		timerSoulFractureCD:Start()
	elseif spellId == 348428 and self:AntiSpam(3, 1) then
		warnPiercingWail:Show()
	elseif spellId == 352999 or spellId == 346459 then
		timerGlacialWrathCD:Start()
	elseif spellId == 347291 or spellId == 352997 then
		self.vb.echoIcon = 1
		timerOblivionsEchoCD:Start()
	elseif spellId == 348756 or spellId == 353000 then
		timerFrostBlastCD:Start()
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "FrostBlast", 0.1, 8, true)
	elseif spellId == 352293 then--Necrotic Destruction
		--Stop KT timers
		self.vb.phase = 2
		self.vb.freezingBlastCount = 0
		timerHowlingBlizzardCD:Stop()
		timerDarkEvocationCD:Stop()
		timerSoulFractureCD:Stop()
		timerGlacialWrathCD:Stop()
		timerOblivionsEchoCD:Stop()
		timerFrostBlastCD:Stop()
		--Start KTs destruction cast timer
		timerNecoticDestruction:Start()
		--Start Remnant timers (may not start here but when he's actually engaged/attacked after entering zone
--		timerMarchoftheForsakenCD:Start(2)--Probably not a timer in itself
		timerFreezingBlastCD:Start(2)
		if self:IsMythic() then
			timerFoulWindsCD:Start(2)
			timerShadowFissureCD:Start(2)
		end
	elseif spellId == 349799 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			warnDemolish:Show()
		end
	elseif spellId == 355127 then
		specWarnFoulWinds:Show()
		specWarnFoulWinds:Play("keepmove")
		timerFoulWindsCD:Start()
	elseif spellId == 352379 then
		self.vb.freezingBlastCount = self.vb.freezingBlastCount + 1
		if self.vb.freezingBlastCount == 1 then
			specWarnFreezingBlast:Show()
			specWarnFreezingBlast:Play("shockwave")
		else
			warnFreezingBlast:Show(self.vb.freezingBlastCount)
		end
		timerFreezingBlastCD:Start()
	elseif spellId == 355055 then
		specWarnGlacialWinds:Show()
		specWarnGlacialWinds:Play("watchstep")
	elseif spellId == 352355 then
		specWarnNecroticObliteration:Show()
		specWarnNecroticObliteration:Play("justrun")
	elseif spellId == 352348 then--Onsalught of the Damned
		self.vb.phase = 3
		--Stop P2 stuff that may have carried over
		timerHowlingBlizzardCD:Stop()
		timerDarkEvocationCD:Stop()
		timerSoulFractureCD:Stop()
		timerGlacialWrathCD:Stop()
		timerOblivionsEchoCD:Stop()
		timerFrostBlastCD:Stop()
		timerOblivionsEchoCD:Start(3)
		timerFrostBlastCD:Start(3)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 355136 then
		warnShadowFissure:Show()
		timerShadowFissureCD:Start()
	elseif spellId == 352293 then--Necrotic Destruction ended (assumed phase trigger to return to active KT engagement)
		--Start KT timers
		self.vb.phase = 1
		timerHowlingBlizzardCD:Start(2)
		timerDarkEvocationCD:Start(2)
		timerSoulFractureCD:Start(2)
		timerGlacialWrathCD:Start(2)
		timerOblivionsEchoCD:Start(2)
		timerFrostBlastCD:Start(2)
		--Stop Remnant timers (may not stop here)
--		timerMarchoftheForsakenCD:Stop()--Probably not a timer in itself
		timerFreezingBlastCD:Stop()
		timerFoulWindsCD:Stop()
		timerShadowFissureCD:Stop()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	--https://ptr.wowhead.com/npc=176703/frostbound-devoted / https://ptr.wowhead.com/npc=176974/soul-reaver / https://ptr.wowhead.com/npc=176973/unstoppable-abomination
	if spellId == 352096 or spellId == 352094 or spellId == 352092 then
		if spellId == 252096 and self:AntiSpam(3, 3) then
			warnFrostboundDevoted:Show()
		elseif spellId == 352094 and self:AntiSpam(3, 4) then
			warnSoulReaver:Show()
		elseif spellId == 352092 and self:AntiSpam(3, 5) then
			warnAbom:Show()
		end
		--timerMarchoftheForsakenCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 354198 then
		specWarnHowlingBlizzard:Show()
		specWarnHowlingBlizzard:Play("watchstep")
		timerHowlingBlizzardCD:Start()
		timerHowlingBlizzard:Start()
	elseif spellId == 352530 then
		specWarnDarkEvocation:Show()
		specWarnDarkEvocation:Play("specialsoon")
		timerDarkEvocationCD:Start()
	elseif spellId == 348978 then
		local amount = args.amount or 1
		warnSoulExhaustion:Cancel()
		warnSoulExhaustion:Schedule(1, args.destName, amount)
--		if amount >= 3 then
--			if args:IsPlayer() then
--				specWarnUnendingStrike:Show(amount)
--				specWarnUnendingStrike:Play("stackhigh")
--			else
--				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
--					specWarnUnendingStrikeTaunt:Show(args.destName)
--					specWarnUnendingStrikeTaunt:Play("tauntboss")
--				else
--					warnUnendingStrike:Show(args.destName, amount)
--				end
--			end
--		else
--			warnUnendingStrike:Show(args.destName, amount)
--		end
	elseif spellId == 347292 then
		local icon = self.vb.echoIcon
		if self.Options.SetIconOnEcho then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnOblivionsEcho:Show()
			specWarnOblivionsEcho:Play("runout")
			yellOblivionsEcho:Yell(icon, icon)
		end
		warnOblivionsEcho:CombinedShow(0.3, args.destName)
		self.vb.echoIcon = self.vb.echoIcon + 1
	elseif (spellId == 347518 or spellId == 347454) and args:IsPlayer() and not DBM:UnitDebuff("player", 347292) then--Walked into someone elses silence field
		specWarnOblivionsEchoNear:Show(args.sourceName)
		specWarnOblivionsEchoNear:Play("runaway")
	elseif spellId == 355948 then
		if self.Options.NPAuraOnNecroticEmpowerment then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 354198 then
		timerHowlingBlizzard:Stop()
	elseif spellId == 347292 then
		if self.Options.SetIconOnEcho then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 355948 then
		if self.Options.NPAuraOnNecroticEmpowerment then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 176929 then--remnant-of-kelthuzad
		timerFreezingBlastCD:Stop()
		timerFoulWindsCD:Stop()
		timerShadowFissureCD:Stop()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 342074 then

	end
end
--]]
