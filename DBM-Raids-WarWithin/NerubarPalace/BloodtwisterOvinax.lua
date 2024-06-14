local mod	= DBM:NewMod(2612, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(214506)
mod:SetEncounterID(2919)
--mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20240614000000)
--mod:SetMinSyncRevision(20230929000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 442526 442432 443003 443005 446700",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 443274 446349 446694 446690 442263 442250 442250",
	"SPELL_AURA_APPLIED_DOSE 443274",
	"SPELL_AURA_REMOVED 446349 446694 446690 442263 442250",
	"SPELL_PERIODIC_DAMAGE 442799",
	"SPELL_PERIODIC_MISSED 442799",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO: At this time, i don't see a practical reason to announce players that only got https://www.wowhead.com/beta/spell=442704/poisoned-blood . It's just non dispelable inactionable damage that goes out to players who didn't get black blood (private aura)
--TODO, ingest code, it seems split between two diff abilities, so probably mid rework. Transfusion might have replaced Violent Discharge (or other way around)
--TODO, is Catalyze Mutation passive effect of ingest or a hard cast?
--TODO, figure out how the nature/shadow combo works for tank mechanic. hard to add taunt warnings right now since they might be bad advice, so for now only warning for casts
--https://www.wowhead.com/beta/spell=443021/volatile-concoction and https://www.wowhead.com/beta/spell=441368/volatile-concoction used too?
--TODO, nameplate timer for https://www.wowhead.com/beta/spell=438847/web-blast ?
--TODO, add https://www.wowhead.com/beta/spell=458212/necrotic-wound stacks?
--TODO, change option keys to match BW for weak aura compatability before live
--[[
(ability.id = 442526 or ability.id = 442432 or ability.id = 443003 or ability.id = 443005 or ability.id = 446700) and type = "begincast"
or ability.id = 446349 and type = "applydebuff"
or ability.id = 442432 and type = "removebuff"
--]]
local warnExperimentalDosage					= mod:NewIncomingAnnounce(442526, 3)
local warnReverberation							= mod:NewStackAnnounce(443274, 2)

local specWarnIngestBlackBlood					= mod:NewSpecialWarningCount(442430, nil, nil, nil, 2, 2)
local specWarnUnstableWeb						= mod:NewSpecialWarningMoveAway(446349, nil, nil, nil, 1, 2)
local yellUnstableWeb							= mod:NewShortYell(446349)
local specWarnVolatileConcoction				= mod:NewSpecialWarningMoveAway(441362, nil, nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(442799, nil, nil, nil, 1, 8)

local timerExperimentalDosageCD					= mod:NewCDCountTimer(50, 442526, nil, nil, nil, 3)
local timerIngestBlackBloodCD					= mod:NewCDCountTimer(170, 442430, nil, nil, nil, 3)
local timerUnstableWebCD						= mod:NewCDCountTimer(30, 446349, nil, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerVolatileConcoctionCD					= mod:NewCDCountTimer(20, 441362, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddPrivateAuraSoundOption(440421, true, 440421, 1)--Black Blood

--Colossal Spider
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28996))
local specWarnPoisonBurst						= mod:NewSpecialWarningInterrupt(446700, "HasInterrupt", nil, nil, 1, 2)

local timerPoisonBurstCD						= mod:NewCDNPTimer(16.7, 446700, nil, nil, nil, 4)--16.7-23.4

mod:AddNamePlateOption("NPAuraOnNecrotic", 446694, true)
--Voracious Worm
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28999))

mod:AddNamePlateOption("NPAuraOnRavenous", 446690, true)
--Blood Parasite
mod:AddTimerLine(DBM:EJ_GetSectionInfo(29003))
local specWarnFixate					= mod:NewSpecialWarningYou(442250, nil, nil, nil, 1, 2)

mod:AddNamePlateOption("NPAuraOnAccelerated", 442263, true)
mod:AddNamePlateOption("NPFixate", 442250, true)

--mod:AddInfoFrameOption(407919, true)
--mod:AddSetIconOption("SetIconOnSinSeeker", 335114, true, 0, {1, 2, 3})
--mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)

mod.vb.dosageCount = 0
mod.vb.ingestCount = 0
mod.vb.webCount = 0
mod.vb.tankCount = 0

function mod:OnCombatStart(delay)
	self.vb.dosageCount = 0
	self.vb.ingestCount = 0
	self.vb.webCount = 0
	self.vb.tankCount = 0
	timerVolatileConcoctionCD:Start(2, 1)
	timerIngestBlackBloodCD:Start(17.5, 1)
	timerExperimentalDosageCD:Start(34, 1)
	if self:IsHard() then
		timerUnstableWebCD:Start(15, 1)
	end
	self:EnablePrivateAuraSound(440421, "movetoegg", 17)
	if self.Options.NPAuraOnNecrotic or self.Options.NPAuraOnRavenous or self.Options.NPAuraOnAccelerated or self.Options.NPFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnNecrotic or self.Options.NPAuraOnRavenous or self.Options.NPAuraOnAccelerated or self.Options.NPFixate then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 442526 then
		self.vb.dosageCount = self.vb.dosageCount + 1
		warnExperimentalDosage:Show(self.vb.dosageCount)
		timerExperimentalDosageCD:Start(nil, self.vb.dosageCount+1)
	elseif spellId == 442432 and self:AntiSpam(5, 1) then
		self.vb.ingestCount = self.vb.ingestCount + 1
		specWarnIngestBlackBlood:Show()
		specWarnIngestBlackBlood:Play("specialsoon")
		timerIngestBlackBloodCD:Start(nil, self.vb.ingestCount+1)
		timerUnstableWebCD:Stop()
		timerVolatileConcoctionCD:Stop()
		timerExperimentalDosageCD:Stop()
		--Timers that restart here
		timerExperimentalDosageCD:Start(16, self.vb.dosageCount+1)
		timerVolatileConcoctionCD:Start(18, self.vb.tankCount+1)
		timerUnstableWebCD:Start(31, self.vb.webCount+1)
--	elseif spellId == 446349 then
--		self.vb.webCount = self.vb.webCount + 1
--		timerUnstableWebCD:Start()
	elseif spellId == 443003 then--Nature (confirmed ID)
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnVolatileConcoction:Show()
			specWarnVolatileConcoction:Play("defensive")
		end
		timerVolatileConcoctionCD:Start(nil, self.vb.tankCount+1)
	elseif spellId == 443005 then--Shadow (unconfirmed it's even used)
		self.vb.tankCount = self.vb.tankCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnVolatileConcoction:Show()
			specWarnVolatileConcoction:Play("defensive")
		end
		timerVolatileConcoctionCD:Start(nil, self.vb.tankCount+1)
	elseif spellId == 446700 then
		timerPoisonBurstCD:Start(nil, args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID, nil, true) then
			specWarnPoisonBurst:Show(args.sourceName)
			specWarnPoisonBurst:Play("kickcast")
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 442430 and self:AntiSpam(5, 1) then
		self.vb.ingestCount = self.vb.ingestCount + 1
		specWarnIngestBlackBlood:Show()
		specWarnIngestBlackBlood:Play("specialsoon")
		timerIngestBlackBloodCD:Start()
	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 443274 then
		warnReverberation:Show(args.destName, args.amount or 1)
	elseif spellId == 446349 then
		if args:IsPlayer() then
			specWarnUnstableWeb:Show()
			specWarnUnstableWeb:Play("runout")
			yellUnstableWeb:Yell()
		end
	elseif spellId == 446694 then
		if self.Options.NPAuraOnNecrotic then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 446690 then
		if self.Options.NPAuraOnRavenous then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 442263 then
		if self.Options.NPAuraOnAccelerated then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 442250 then
		if args:IsPlayer() then
			if self:AntiSpam(3, 2) then
				specWarnFixate:Show()
				specWarnFixate:Play("targetyou")
			end
			if self.Options.NPFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 446694 then
		if self.Options.NPAuraOnNecrotic then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 446690 then
		if self.Options.NPAuraOnRavenous then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 442263 then
		if self.Options.NPAuraOnAccelerated then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 442250 then
		if args:IsPlayer() then
			if self.Options.NPFixate then
				DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
			end
		end
--	elseif spellId == 446349 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 442799 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 219045 then--Colossal Spider
		timerPoisonBurstCD:Stop(args.destGUID)
	--elseif cid == 219046 then--Voracious WOrm

	--elseif cid == 220626 then--Blood Parasite

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 446344 then--Unstable Web
		self.vb.webCount = self.vb.webCount + 1
		timerUnstableWebCD:Start(nil, self.vb.webCount+1)
	end
end
