local mod	= DBM:NewMod(2464, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(180990)--Or 181411
mod:SetEncounterID(2537)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6)--, 7, 8
mod:SetHotfixNoticeRev(20211207000000)
mod:SetMinSyncRevision(20211207000000)
--mod.respawnTime = 29
mod.NoSortAnnounce = true--Disables DBM automatically sorting announce objects by diff announce types

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 362028 366022 363893 365436 360279 360373 359856 366284 364942 360562 364488 365033 365147 365212 365169",--363179
	"SPELL_CAST_SUCCESS 362631 362192",
--	"SPELL_SUMMON 363175",
	"SPELL_AURA_APPLIED 362631 363886 362401 360281 366285 365150 365153 362075 365219 365222",--362024 360180
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 362401 360281 366285 365150 365153 365222",--360180
	"SPELL_PERIODIC_DAMAGE 360425 365174",
	"SPELL_PERIODIC_MISSED 360425 365174",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_START boss1",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)


--TODO, add mythic stuff later
--TODO, is tyranny warning appropriate? maybe track debuff for mythic?
--TODO, chains may have a pre target spellId, look for it
--TODO, honestly what do for tank combo? most of it is instant casts, misery timing to root is pure guess right now
--TODO, verify phase changes
--TODO, verify add marking
--TODO, https://ptr.wowhead.com/spell=360099/calibrations-of-oblivion have a pre warning/cast? If so, add timer/warn
--TODO, what type of warning for Unholy Attunement
--TODO, shattering blast random target or tank?
--TODO, verify decimator target scan, or find emote for it's targeting
--TODO, fix unrelenting domination in p1 and P3 probably)
--TODO, https://ptr.wowhead.com/spell=363748/death-sentence / https://ptr.wowhead.com/spell=363772/death-sentence ?
--TODO, auto mark https://ptr.wowhead.com/spell=365419/incarnation-of-torment ? Is Apocalypse Bolt interruptable or is it like painsmith?
--TODO, stage 1.5 (intermission) seems to have been scrapped, at least from journal, confirm on live and if so finish deleting those events
--General
--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption("6")
--mod:AddInfoFrameOption(328897, true)

--Stage One: Origin of Domination
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24087))
local warnTyranny								= mod:NewCastAnnounce(366022, 3)
local warnChainsofOppression					= mod:NewTargetNoFilterAnnounce(362631, 3)
local warnImprisonment							= mod:NewTargetCountAnnounce(363886, 4, nil, nil, nil, nil, nil, nil, true)
local warnRuneofDamnation						= mod:NewTargetCountAnnounce(360281, 3, nil, nil, nil, nil, nil, nil, true)

local specWarnUnrelentingDomination				= mod:NewSpecialWarningMoveTo(362028, nil, nil, nil, 1, 2)
local specWarnChainsofOppression				= mod:NewSpecialWarningYou(362631, nil, nil, nil, 1, 2)
local specWarnMartyrdom							= mod:NewSpecialWarningDefensive(363893, nil, nil, nil, 1, 2)
local yellImprisonment							= mod:NewYell(363886, nil, nil, nil, "YELL")--rooted target = stack target for misery very likely
local yellImprisonmentFades						= mod:NewShortFadesYell(363886, nil, nil, nil, "YELL")
local specWarnMisery							= mod:NewSpecialWarningTaunt(363886, nil, nil, nil, 1, 2)
local specWarnTorment							= mod:NewSpecialWarningMoveAway(365436, nil, nil, nil, 1, 2)
local specWarnRuneofDamnation					= mod:NewSpecialWarningYou(360281, nil, nil, nil, 1, 2)
local yellRuneofDamnation						= mod:NewShortPosYell(360281)
local yellRuneofDamnationFades					= mod:NewIconFadesYell(360281)

local timerUnrelentingDominationCD				= mod:NewAITimer(28.8, 360281, nil, nil, nil, 2)
local timerChainsofOppressionCD					= mod:NewAITimer(28.8, 362631, nil, nil, nil, 3)
local timerMartyrdomCD							= mod:NewAITimer(28.8, 363893, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerTormentCD							= mod:NewAITimer(28.8, 365436, nil, nil, nil, 2)
local timerRuneofDamnationCD					= mod:NewAITimer(28.8, 360279, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnImprisonment", 363886, true, false, {4})
mod:AddSetIconOption("SetIconOnDamnation", 360281, true, false, {1, 2, 3})

--Intermission: Machine of Origination
--mod:AddTimerLine(P15Info)
--local warnAddsRemaining							= mod:NewAddsLeftAnnounce("ej24334", 1, 363175)

--local timerOblivion							= mod:NewBuffActiveTimer(45, 360180, nil, nil, nil, 6)

--mod:AddSetIconOption("SetIconOnCallofOblivion", 363175, true, true, {3, 4, 5, 6, 7, 8})

--Stage Two: Unholy Attunement
mod:AddTimerLine(DBM:EJ_GetSectionInfo(23925))
local warnUnholyAttunement						= mod:NewCountAnnounce(360373, 3)
local warnRuneofCompulsion						= mod:NewTargetCountAnnounce(366285, 3, nil, nil, nil, nil, nil, nil, true)
local warnDecimator								= mod:NewTargetCountAnnounce(364942, 3, nil, nil, nil, nil, nil, nil, true)

--local specWarnDespair							= mod:NewSpecialWarningInterrupt(357144, "HasInterrupt", nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(360425, nil, nil, nil, 1, 8)
local specWarnShatteringBlast					= mod:NewSpecialWarningMoveTo(359856, nil, nil, nil, 1, 2)
local specWarnRuneofCompulsion					= mod:NewSpecialWarningYou(366285, nil, nil, nil, 1, 2)
local yellRuneofCompulsion						= mod:NewShortPosYell(366285)
local yellRuneofCompulsionFades					= mod:NewIconFadesYell(366285)
local specWarnDecimator							= mod:NewSpecialWarningMoveAway(364942, nil, nil, nil, 1, 2)
local yellDecimator								= mod:NewYell(364942)
local yellDecimatorFades						= mod:NewShortFadesYell(364942)
local specWarnTormentingEcho					= mod:NewSpecialWarningDodge(365371, nil, nil, nil, 2, 2)

local timerUnholyAttunementCD					= mod:NewAITimer(28.8, 360373, nil, nil, nil, 3)
local timerShatteringBlastCD					= mod:NewAITimer(28.8, 359856, nil, nil, nil, 5)
local timerRuneofCompulsionCD					= mod:NewAITimer(28.8, 366285, nil, nil, nil, 3)
local timerDecimatorCD							= mod:NewAITimer(28.8, 364942, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnCopulsion", 366285, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnDecimator", 364942, true, false, {7})--7 to ensure no conflict in P3 either

--Stage Three: Eternity's End
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24252))
local warnRuneofDomination						= mod:NewTargetCountAnnounce(365150, 3, nil, nil, nil, nil, nil, nil, true)
local warnDomination							= mod:NewTargetNoFilterAnnounce(362075, 4)
local warnChainsofAnguishLink					= mod:NewTargetNoFilterAnnounce(365222, 3)
local warnDefile								= mod:NewTargetNoFilterAnnounce(365169, 4)

local specWarnDesolation						= mod:NewSpecialWarningCount(365033, nil, nil, nil, 2, 2)
local specWarnRuneofDomination					= mod:NewSpecialWarningYou(365150, nil, nil, nil, 1, 2)
local yellRuneofDomination						= mod:NewShortPosYell(365150)
local yellRuneofDominationFades					= mod:NewIconFadesYell(365150)
local specWarnChainsofAnguish					= mod:NewSpecialWarningDefensive(365219, nil, nil, nil, 1, 2)
local specWarnChainsofAnguishTaunt				= mod:NewSpecialWarningTaunt(365219, nil, nil, nil, 1, 2)
local specWarnChainsofAnguishLink				= mod:NewSpecialWarningYou(365219, nil, nil, nil, 1, 2)
local yellChainsofAnguishLink					= mod:NewShortPosYell(365219)
local specWarnDefile							= mod:NewSpecialWarningMoveAway(365169, nil, nil, nil, 3, 2)
local yellDefile								= mod:NewYell(365169)
local specWarnDefileNear						= mod:NewSpecialWarningClose(365169, nil, nil, nil, 1, 2)

local timerDesolationCD							= mod:NewAITimer(28.8, 365033, nil, nil, nil, 3)
local timerRuneofDominationCD					= mod:NewAITimer(28.8, 365150, nil, nil, nil, 3)
local timerChainsofAnguishCD					= mod:NewAITimer(28.8, 365219, nil, nil, nil, 5)
local timerRuneofDefileCD						= mod:NewAITimer(28.8, 365169, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddSetIconOption("SetIconOnDomination", 365150, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnChainsofAnguish", 365219, true, false, {4, 5, 6})
mod:AddSetIconOption("SetIconOnDefile", 365169, true, false, {8})
--mod:AddNamePlateOption("NPAuraOnBurdenofDestiny", 353432, true)

--General
--local castsPerGUID = {}
mod.vb.debuffCount = 0
mod.vb.debuffIcon = 1--Used in all 3 rune types
--P1
mod.vb.comboCount = 0
--P1.5
--mod.vb.addsLeft = 0
--mod.vb.addIcon = 8
--P2
mod.vb.unholyAttuneCast = 0
mod.vb.decimatorCount = 0
--P3
mod.vb.desolationCast = 0
mod.vb.willCount = 0
mod.vb.chainsIcon = 4

function mod:OnCombatStart(delay)
	self.vb.comboCount = 0
	self.vb.debuffCount = 0
--	self.vb.addsLeft = 0
	self.vb.unholyAttuneCast = 0
	self.vb.decimatorCount = 0
	self.vb.desolationCast = 0
	self.vb.willCount = 0
	self.vb.chainsIcon = 4
	self:SetStage(1)
	timerUnrelentingDominationCD:Start(1-delay)
	timerChainsofOppressionCD:Start(1-delay)
	timerMartyrdomCD:Start(1-delay)
	timerTormentCD:Start(1-delay)
	timerRuneofDamnationCD:Start(1-delay)
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(328897))
--		DBM.InfoFrame:Show(10, "table", ExsanguinatedStacks, 1)
--	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
--	table.wipe(castsPerGUID)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

--[[
function mod:OnTimerRecovery()

end
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 362028 then
		specWarnUnrelentingDomination:Show(DBM_COMMON_L.BREAK_LOS)
		specWarnUnrelentingDomination:Play("findshelter")
		timerUnrelentingDominationCD:Start()
	elseif spellId == 366022 then
		warnTyranny:Show()
	elseif spellId == 363893 then
		self.vb.comboCount = self.vb.comboCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnMartyrdom:Show()
			specWarnMartyrdom:Play("defensive")
		end
		timerMartyrdomCD:Start()
	elseif spellId == 365436 then
		timerTormentCD:Start()
	elseif spellId == 360279 then
		self.vb.debuffCount = self.vb.debuffCount + 1
		self.vb.debuffIcon = 1
		timerRuneofDamnationCD:Start()
	elseif spellId == 366284 then
		self.vb.debuffCount = self.vb.debuffCount + 1
		self.vb.debuffIcon = 1
		timerRuneofCompulsionCD:Start()
	elseif spellId == 365147 then
		self.vb.debuffCount = self.vb.debuffCount + 1
		self.vb.debuffIcon = 1
		timerRuneofDominationCD:Start()
--	elseif spellId == 363179 then--Cries of the Damned
--		if not castsPerGUID[args.sourceGUID] then--This should have been set in summon event
--			--But if that failed, do it again here and scan for mobs again here too
--			castsPerGUID[args.sourceGUID] = 0
--			if self.Options.SetIconOnCallofOblivion then
--				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnCallofOblivion")
--			end
--			self.vb.addIcon = self.vb.addIcon - 1
--		end
--		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		--Some announce stuff to add here?
	elseif spellId == 360373 then
		if self.vb.phase == 1 then--TEMP. need new stage 2 event
			self:SetStage(2)
			self.vb.debuffCount = 0
--			timerOblivion:Stop()
			timerUnrelentingDominationCD:Stop()
			timerChainsofOppressionCD:Stop()
			timerMartyrdomCD:Stop()
			timerTormentCD:Stop()
			timerRuneofDamnationCD:Stop()
--			timerUnholyAttunementCD:Start(2)
			timerShatteringBlastCD:Start(2)
			timerRuneofCompulsionCD:Start(2)
			timerDecimatorCD:Start(2)
			timerTormentCD:Start(2)
		end
		self.vb.unholyAttuneCast = self.vb.unholyAttuneCast + 1
		warnUnholyAttunement:Show(self.vb.unholyAttuneCast)
		timerUnholyAttunementCD:Start()
	elseif spellId == 359856 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnShatteringBlast:Show(L.Pylon)
			specWarnShatteringBlast:Play("findshelter")--Kind of a crappy voice for it but don't have a valid one that sounds better
		end
		timerShatteringBlastCD:Start()
	elseif args:IsSpellID(364942, 360562, 364488) then--All deciminator casts with a cast time
		timerDecimatorCD:Start()
	elseif spellId == 365033 then
		self.vb.desolationCast = self.vb.desolationCast + 1
		specWarnDesolation:Show(self.vb.desolationCast)
		specWarnDesolation:Play("specialsoon")
		timerDesolationCD:Start()
	elseif spellId == 365212 then
		self.vb.chainsIcon = 4
		timerChainsofAnguishCD:Start()
	elseif spellId == 365169 then
		timerRuneofDefileCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 362631 then
		timerChainsofOppressionCD:Start()
	end
end

--[[
function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 363175 then
		self.vb.addsLeft = self.vb.addsLeft + 1
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
		end
		if self.Options.SetIconOnCallofOblivion then
			self:ScanForMobs(args.destGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnCallofOblivion")
		end
		self.vb.addIcon = self.vb.addIcon - 1
	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 362631 then
		warnChainsofOppression:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnChainsofOppression:Show()
			specWarnChainsofOppression:Play("targetyou")
		end
	elseif spellId == 363886 then
		if args:IsPlayer() then
			yellImprisonment:Yell()
			yellImprisonmentFades:Countdown(spellId)
--		elseif self:IsTank() then--You need to move away from it, to avoid physical damage taken debuff
			--Maybe a tauntboss warning? depends on if it screws with targetting or not
		else
			warnImprisonment:Show(self.vb.comboCount, args.destName)
		end
		if self.Options.SetIconOnImprisonment then
			self:SetIcon(args.destName, 4)
		end
	elseif spellId == 362192 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) and not args:IsPlayer() and not DBM:UnitDebuff("player", spellId) then
			specWarnMisery:Show(args.destName)
			specWarnMisery:Play("tauntboss")
		end
	elseif spellId == 362401 and args:IsPlayer() then
		specWarnTorment:Show()
		specWarnTorment:Play("scatter")
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)
		end
		if self.vb.phase >= 2 then
			specWarnTormentingEcho:Schedule(6)
			specWarnTormentingEcho:ScheduleVoice(6, "watchstep")
		end
	elseif spellId == 360281 then
		local icon = self.vb.debuffIcon
		if self.Options.SetIconOnDamnation then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnRuneofDamnation:Show()
			specWarnRuneofDamnation:Play("runout")
			yellRuneofDamnation:Yell(icon, icon)
			yellRuneofDamnationFades:Countdown(spellId, nil, icon)
		end
		warnRuneofDamnation:CombinedShow(0.5, self.vb.debuffCount, args.destName)
		self.vb.debuffIcon = self.vb.debuffIcon + 1
	elseif spellId == 366285 then
		local icon = self.vb.debuffIcon
		if self.Options.SetIconOnCopulsion then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnRuneofCompulsion:Show()
			specWarnRuneofCompulsion:Play("runout")
			yellRuneofCompulsion:Yell(icon, icon)
			yellRuneofCompulsionFades:Countdown(spellId, nil, icon)
		end
		warnRuneofCompulsion:CombinedShow(0.5, self.vb.debuffCount, args.destName)
		self.vb.debuffIcon = self.vb.debuffIcon + 1
	elseif spellId == 365150 then
		local icon = self.vb.debuffIcon
		if self.Options.SetIconOnDomination then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnRuneofDomination:Show()
			specWarnRuneofDomination:Play("runout")
			yellRuneofDomination:Yell(icon, icon)
			yellRuneofDominationFades:Countdown(spellId, nil, icon)
		end
		warnRuneofDomination:CombinedShow(0.5, self.vb.debuffCount, args.destName)
		self.vb.debuffIcon = self.vb.debuffIcon + 1
	elseif spellId == 365222 then
		local icon = self.vb.chainsIcon
		if self.Options.SetIconOnChainsofAnguish then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnChainsofAnguishLink:Show()
			specWarnChainsofAnguishLink:Play("targetyou")
			yellChainsofAnguishLink:Yell(icon, icon-3)--minus 3 so debuff count is still 1 2 and 3 when using icons 4 5 and 6
		end
		warnChainsofAnguishLink:CombinedShow(0.5, args.destName)
		self.vb.chainsIcon = self.vb.chainsIcon + 1
--	elseif spellId == 360180 then--Oblivion
--		self:SetStage(1.5)
--		self.vb.addsLeft = 0
--		self.vb.addIcon = 8
--		timerUnrelentingDominationCD:Stop()
--		timerChainsofOppressionCD:Stop()
--		timerMartyrdomCD:Stop()
--		timerTormentCD:Stop()
--		timerRuneofDamnationCD:Stop()
--		timerOblivion:Start()
	elseif spellId == 365153 then--Imposing Will
		self.vb.willCount = self.vb.willCount + 1
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(20, "playerabsorb", spellId)
		end
--	elseif spellId == 362024 then
--		if args:IsPlayer() then
--			specWarnUnrelentingDomination:Show(DBM_COMMON_L.BREAK_LOS)
--			specWarnUnrelentingDomination:Play("findshelter")
--		end
	elseif spellId == 362075 then
		warnDomination:CombinedShow(1, args.destName)
	elseif spellId == 365219 then
		if args:IsPlayer() then
			specWarnChainsofAnguish:Show()
			specWarnChainsofAnguish:Play("defensive")
		else
			specWarnChainsofAnguishTaunt:Show(args.destName)
			specWarnChainsofAnguishTaunt:Play("tauntboss")
		end
		warnChainsofAnguishLink:CombinedShow(0.5, args.destName)--Combine into the linked targets table
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 363886 then
--		if args:IsPlayer() then
--			yellImprisonmentFades:Cancel()--Don't cancel yet, freedom might dispel it, but misery is still coming?
--		end
		if self.Options.SetIconOnImprisonment then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 362401 and args:IsPlayer() then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 360281 then
		if self.Options.SetIconOnDamnation then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellRuneofDamnationFades:Cancel()
		end
	elseif spellId == 366285 then
		if self.Options.SetIconOnCopulsion then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellRuneofCompulsionFades:Cancel()
		end
	elseif spellId == 365150 then
		if self.Options.SetIconOnDomination then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellRuneofDominationFades:Cancel()
		end
--	elseif spellId == 360180 then--Oblivion

	elseif spellId == 365153 then--Imposing Will
		self.vb.willCount = self.vb.willCount - 1
		if self.Options.InfoFrame and self.vb.willCount == 0 then
			DBM.InfoFrame:Hide()
		end
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 183787 then--harbinger-of-oblivion
		self.vb.addsLeft = self.vb.addsLeft - 1
		castsPerGUID[args.destGUID] = nil
		--Throttle add deaths to every 3 seconds except for last one
		if self.vb.addsLeft == 0 or self:AntiSpam(3, 1) then
			warnAddsRemaining:Show(self.vb.addsLeft)
		end
	end
end
--]]

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 360425 or spellId == 365174) and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

do
	function mod:DecimatorTarget(targetname, uId)
		if not targetname then return end
		if self.Options.SetIconOnDecimator then
			self:SetIcon(targetname, 7, 4)--So icon clears 1 second after
		end
		if targetname == UnitName("player") then
			specWarnDecimator:Show()
			specWarnDecimator:Play("runout")
			yellDecimator:Yell()
			yellDecimatorFades:Countdown(2.97)--This scan method doesn't support scanningTime, but should be about right
		else
			warnDecimator:Show(self.vb.decimatorCount, targetname)
		end
	end

	function mod:DefileTarget(targetname, uId)
		if not targetname then return end
		if self.Options.SetIconOnDecimator then
			self:SetIcon(targetname, 8, 3)--So icon clears 1 second after
		end
		if targetname == UnitName("player") then
			specWarnDefile:Show()
			specWarnDefile:Play("runout")
			yellDefile:Yell()
		elseif self:CheckNearby(10, targetname) then
			specWarnDefileNear:Show(targetname)
			specWarnDefileNear:Play("runaway")
		else
			warnDefile:Show(targetname)
		end
	end

	function mod:UNIT_SPELLCAST_START(uId, _, spellId)
		if spellId == 364942 or spellId == 360562 or spellId == 364488 then
			self.vb.decimatorCount = self.vb.decimatorCount + 1--This event may be before CLEU event so just make sure count updated before target scan
			self:BossUnitTargetScanner(uId, "DecimatorTarget", 3)
		elseif spellId == 365169 then
			self:BossUnitTargetScanner(uId, "DefileTarget", 3)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 360507 then--Trigger Azeroth Visibility (may not be reliable for mythic, replace with diff P3 trigger if possible)
		self:SetStage(3)
		timerUnholyAttunementCD:Stop()
		timerShatteringBlastCD:Stop()
		timerRuneofCompulsionCD:Stop()
		timerDecimatorCD:Stop()
		timerDesolationCD:Start(3)
		timerRuneofDominationCD:Start(3)
		timerChainsofAnguishCD:Start(3)
		timerTormentCD:Start(3)
		timerDecimatorCD:Start(3)
		timerRuneofDefileCD:Start(3)
	end
end
