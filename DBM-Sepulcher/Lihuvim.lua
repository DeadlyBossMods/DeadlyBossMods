local mod	= DBM:NewMod(2461, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(184901)
mod:SetEncounterID(2539)
mod:SetUsedIcons(1, 2)
mod:SetHotfixNoticeRev(20211209000000)
mod:SetMinSyncRevision(20211209000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 362601 363130 364652 363088 365257",
	"SPELL_CAST_SUCCESS 363681 363795 363676",
	"SPELL_AURA_APPLIED 363681 362622 366012 363537 363795 363676 364092 364312",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 363537 363795 363676 364312"--362622 366012 (mote Ids maybe?)
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, figure all kinds of shit out, what boss uses and when, when to start timers stop timers etc.
--TODO, very mote Ids
--TODO, what timers used by adds that need to be GUID based and stop on deaths
--TODO, add https://ptr.wowhead.com/spell=365257/form-sentry-automa ??
--Uncatigorized abilities or abilities listed in two categories (ie journal data being fucked up)
local warnUnstableMote							= mod:NewTargetNoFilterAnnounce(362622, 2)
local warnDegenerate							= mod:NewTargetNoFilterAnnounce(364092, 4, nil, false)
local warnSynthesize							= mod:NewCastAnnounce(363130, 4)
--Automa, Prime
local warnCosmicShift							= mod:NewCastAnnounce(363088, 2)
--Automa, Attendant
local warnFormSentry							= mod:NewSpellAnnounce(365257, 2)

--Uncatigorized abilities (ie journal data being fucked up messes up parsing it correctly)
local specWarnDeconstructingBlast				= mod:NewSpecialWarningTaunt(363681, nil, nil, nil, 1, 2)
local specWarnUnstableMote						= mod:NewSpecialWarningYou(362622, nil, nil, nil, 1, 2)
local specWarnProtoformCascade					= mod:NewSpecialWarningDodge(364652, nil, nil, nil, 1, 2)
--Automa, Prime
local specWarnDeconstructingEnergy				= mod:NewSpecialWarningYou(363795, nil, nil, nil, 1, 2)
local yellDeconstructingEnergy					= mod:NewYell(363795)
local yellDeconstructingEnergyFades				= mod:NewShortFadesYell(363795)
--Automa, Attendant
----Degeneration Automa
local specWarnDegenerate						= mod:NewSpecialWarningYou(364092, nil, nil, nil, 1, 2)
--local specWarnDespair							= mod:NewSpecialWarningInterrupt(357144, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
--Uncatigorized abilities (ie journal data being fucked up messes up parsing it correctly)
local timerDeconstructingBlastCD				= mod:NewAITimer(28.8, 363681, nil, nil, nil, 3)
local timerUnstableMoteCD						= mod:NewAITimer(28.8, 362601, nil, nil, nil, 3)
local timerProtoformRadiance					= mod:NewBuffActiveTimer(28.8, 363537, nil, nil, nil, 2)
local timerProtoformCascadeCD					= mod:NewAITimer(28.8, 364652, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Automa, Prime
local timerCosmicShiftCD						= mod:NewAITimer(28.8, 363088, nil, nil, nil, 3)
local timerDeconstructingEnergyCD				= mod:NewAITimer(28.8, 363795, nil, nil, nil, 3)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(328897, true)
mod:AddSetIconOption("SetIconOnDeconstructingEnergy", 363795, true, false, {1, 2})--Scrap icon option if it's not ever 2 or more
mod:AddNamePlateOption("NPAuraOnEphemeralBarrier", 364312, true)

mod.vb.energyIcon = 1

function mod:OnCombatStart(delay)
	self.vb.energyIcon = 1
	timerDeconstructingBlastCD:Start(1-delay)
	timerUnstableMoteCD:Start(1-delay)
	timerProtoformCascadeCD:Start(1-delay)
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(328897))
--		DBM.InfoFrame:Show(10, "table", ExsanguinatedStacks, 1)
--	end
	if self.Options.NPAuraOnEphemeralBarrier then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	DBM:AddMsg("Journal was broken and unclear. Sorry in advance for this mods drycode")
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.NPAuraOnEphemeralBarrier then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

--[[
function mod:OnTimerRecovery()

end
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 362601 then
		timerUnstableMoteCD:Start()
	elseif spellId == 363130 then
		warnSynthesize:Show()
		--Probably stop some boss timers here
--		timerDeconstructingBlastCD:Stop()
--		timerUnstableMoteCD:Stop()
--		timerProtoformCascadeCD:Stop()
	elseif spellId == 364652 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnProtoformCascade:Show()
			specWarnProtoformCascade:Play("defensive")
		end
		timerProtoformCascadeCD:Start()
	elseif spellId == 363088 then
		warnCosmicShift:Show()
		timerCosmicShiftCD:Start()
	elseif spellId == 365257 and self:AntiSpam(5, 1) then
		warnFormSentry:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 363681 then
		timerDeconstructingBlastCD:Start()
	elseif spellId == 363795 or spellId == 363676 then
		self.vb.energyIcon = 1
		timerDeconstructingEnergyCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 363681 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) and not args:IsPlayer() and not DBM:UnitDebuff("player", spellId) then
			specWarnDeconstructingBlast:Show(args.destName)
			specWarnDeconstructingBlast:Play("tauntboss")
		end
	elseif spellId == 362622 or spellId == 366012 then
		if args:IsPlayer() then
			specWarnUnstableMote:Show()
			specWarnUnstableMote:Play("targetyou")
		end
		if not self:IsMythic() then--Mythic targets everyone but tanks, no need to spam that
			warnUnstableMote:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 363537 then
		timerProtoformRadiance:Start()
	elseif spellId == 363795 or spellId == 363676 then
		local icon = self.vb.energyIcon
		if self.Options.SetIconOnDeconstructingEnergy then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnDeconstructingEnergy:Show()
			specWarnDeconstructingEnergy:Play("runout")
			yellDeconstructingEnergy:Yell(icon, icon)
			yellDeconstructingEnergyFades:Countdown(spellId, nil, icon)
		end
		self.vb.energyIcon = self.vb.energyIcon + 1
	elseif spellId == 364092 and self:AntiSpam(3, args.destName) then
		warnDegeneerate:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnDegenerate:Show()
			specWarnDegenerate:Play("defensive")
		end
	elseif spellId == 364312 and args:IsDestTypeHostile() then
		if self.Options.NPAuraOnEphemeralBarrier then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 363537 then
		timerProtoformRadiance:Stop()
		--Probably resume/start timers
--		timerDeconstructingBlastCD:Start(2)
--		timerUnstableMoteCD:Start(2)
--		timerProtoformCascadeCD:Start(2)
	elseif spellId == 363795 or spellId == 363676 then
		if self.Options.SetIconOnDeconstructingEnergy then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellDeconstructingEnergyFades:Cancel()
		end
	elseif spellId == 364312 and args:IsDestTypeHostile() then
		if self.Options.NPAuraOnEphemeralBarrier then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 184735 or cid == 182053 or cid == 182197 then--degeneration-automa

	elseif cid == 184737 or cid == 182074 then--acquisitions-automa

	elseif cid == 182071 or cid == 184738 or cid == 182285 then--guardian-automa

	elseif cid == 184126 or cid == 184135 then--defense-matrix-automa

	end
end
-]]

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
