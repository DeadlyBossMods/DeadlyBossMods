local mod	= DBM:NewMod(2464, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(180990)--Or 181411
mod:SetEncounterID(2537)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
--mod:SetHotfixNoticeRev(20210902000000)
--mod:SetMinSyncRevision(20210706000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 362028 366022 363893 365436 360279 363179",
	"SPELL_CAST_SUCCESS 362631 362192",
	"SPELL_SUMMON 363175",
	"SPELL_AURA_APPLIED 362631 363886 362401 360281 360180",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 362401 360281 360180",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)


--TODO, add mythic stuff later
--TODO, is tyranny warning appropriate? maybe track debuff for mythic?
--TODO, chains may have a pre target spellId, look for it
--TODO, honestly what do for tank combo? most of it is instant casts, misery timing to root is pure guess right now
--TODO, verify phase changes
--TODO, verify add marking
--TODO, https://ptr.wowhead.com/spell=360099/calibrations-of-oblivion have a pre warning/cast? If so, add timer/warn
--Stage One: Origin of Domination
local warnTyranny								= mod:NewCastAnnounce(366022, 3)
local warnChainsofOppression					= mod:NewTargetNoFilterAnnounce(362631, 3)
local warnImprisonment							= mod:NewTargetCountAnnounce(362631, 4, nil, nil, nil, nil, nil, nil, true)
local warnRuneofDamnation						= mod:NewTargetCountAnnounce(360281, 3, nil, nil, nil, nil, nil, nil, true)
--Intermission: Machine of Origination
local warnAddsRemaining							= mod:NewAddsLeftAnnounce("ej24334", 1, 363175)
--Stage Two: Unholy Attunement

--Stage One: Origin of Domination
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
--Stage Two: Unholy Attunement
--local specWarnDespair							= mod:NewSpecialWarningInterrupt(357144, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
--Stage One: Origin of Domination
local timerUnrelentingDominationCD				= mod:NewAITimer(28.8, 362028, nil, nil, nil, 2)
local timerChainsofOppressionCD					= mod:NewAITimer(28.8, 362631, nil, nil, nil, 3)
local timerMartyrdomCD							= mod:NewAITimer(28.8, 363893, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerTormentCD							= mod:NewAITimer(28.8, 365436, nil, nil, nil, 2)
local timerRuneofDamnationCD					= mod:NewAITimer(28.8, 360279, nil, nil, nil, 3)
--Intermission: Machine of Origination
local timerOblivion								= mod:NewBuffActiveTimer(45, 360180, nil, nil, nil, 6)
--Stage Two: Unholy Attunement
--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption("6")
--mod:AddInfoFrameOption(328897, true)
mod:AddSetIconOption("SetIconOnImprisonment", 363886, true, false, {4})
mod:AddSetIconOption("SetIconOnDamnation", 360281, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnCallofOblivion", 363175, true, true, {3, 4, 5, 6, 7, 8})
--mod:AddNamePlateOption("NPAuraOnBurdenofDestiny", 353432, true)

--P1
mod.vb.comboCount = 0
mod.vb.damnationCount = 0
mod.vb.damnationIcon = 1
--P1.5
mod.vb.addsLeft = 0
mod.vb.addIcon = 8
local castsPerGUID = {}

function mod:OnCombatStart(delay)
	self.vb.comboCount = 0
	self.vb.damnationCount = 0
	self.vb.addsLeft = 0
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
	table.wipe(castsPerGUID)
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
		self.vb.damnationCount = self.vb.damnationCount + 1
		self.vb.damnationIcon = 1
		timerRuneofDamnationCD:Start()
	elseif spellId == 363179 then--Cries of the Damned
		if not castsPerGUID[args.sourceGUID] then--This should have been set in summon event
			--But if that failed, do it again here and scan for mobs again here too
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnCallofOblivion then
				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnCallofOblivion")
			end
			self.vb.addIcon = self.vb.addIcon - 1
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		--Some announce stuff to add here?
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 362631 then
		timerChainsofOppressionCD:Start()
	end
end

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
	elseif spellId == 360281 then
		local icon = self.vb.damnationIcon
		if self.Options.SetIconOnDamnation then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnRuneofDamnation:Show()
			specWarnRuneofDamnation:Play("runout")
			yellRuneofDamnation:Yell(icon, icon)
			yellRuneofDamnationFades:Countdown(spellId, nil, icon)
		end
		warnRuneofDamnation:CombinedShow(0.5, self.vb.damnationCount, args.destName)
		self.vb.damnationIcon = self.vb.damnationIcon + 1
	elseif spellId == 360180 then--Oblivion
		self:SetStage(1.5)
		self.vb.addsLeft = 0
		self.vb.addIcon = 8
		timerUnrelentingDominationCD:Stop()
		timerChainsofOppressionCD:Stop()
		timerMartyrdomCD:Stop()
		timerTormentCD:Stop()
		timerRuneofDamnationCD:Stop()
		timerOblivion:Start()
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
	elseif spellId == 360180 then--Oblivion
		self:SetStage(2)
		timerOblivion:Stop()
	end
end

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

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]
