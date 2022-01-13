local mod	= DBM:NewMod(2461, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(184901)
mod:SetEncounterID(2539)
mod:SetUsedIcons(1, 2)
mod:SetHotfixNoticeRev(20220106000000)
mod:SetMinSyncRevision(20211212000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 362601 363130 364652 363088 365257 366001",
	"SPELL_CAST_SUCCESS 363795 363676",
	"SPELL_AURA_APPLIED 362622 366012 363537 363795 363676 364092 364312 363130 361200",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 363537 363795 363676 364312 363130 361200",--362622 366012 (mote Ids maybe?)
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"RAID_BOSS_WHISPER"
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, wait for blizzard to add mote debuffs into combat log, redundant RBW will cover it for now
--TODO, Any add timers? they almost seemed inconsiquential (at least timer wise)
--TODO, announce when cast begins for Reorginate, or when it ends and who it's on?
--[[
(ability.id = 362601 or ability.id = 363130 or ability.id = 364652 or ability.id = 363088) and type = "begincast"
 or (ability.id = 363795 or ability.id = 363676) and type = "cast"
 or ability.id = 361200 or ability.id = 363130
 or ability.id = 365257 and type = "begincast"
--]]
--Boss
local warnUnstableMote							= mod:NewTargetAnnounce(362622, 2)
local warnSynthesize							= mod:NewSpellAnnounce(363130, 3)
--Adds
local warnDegenerate							= mod:NewTargetNoFilterAnnounce(364092, 4, nil, false)--Kinda spammy, but healer might want to opt into it
local warnFormSentry							= mod:NewSpellAnnounce(365257, 2)

--Boss
local specWarnCosmicShift						= mod:NewSpecialWarningSpell(363088, nil, nil, nil, 2, 2)
local specWarnUnstableMote						= mod:NewSpecialWarningYou(362622, nil, nil, nil, 1, 2)
local specWarnProtoformCascade					= mod:NewSpecialWarningDodge(364652, nil, nil, nil, 1, 2)
local specWarnDeconstructingEnergy				= mod:NewSpecialWarningYou(363795, nil, nil, nil, 1, 2)
local specWarnDeconstructingEnergyTaunt			= mod:NewSpecialWarningTaunt(363795, nil, nil, nil, 1, 2)
local yellDeconstructingEnergy					= mod:NewYell(363795)
local yellDeconstructingEnergyFades				= mod:NewShortFadesYell(363795)
--Adds
----Degeneration Automa
local specWarnDegenerate						= mod:NewSpecialWarningYou(364092, nil, nil, nil, 1, 2)
--local specWarnDespair							= mod:NewSpecialWarningInterrupt(357144, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--Boss
--mod:AddTimerLine(BOSS)
local timerUnstableMoteCD						= mod:NewCDTimer(20.6, 362601, nil, nil, nil, 3)
local timerUnstableMote							= mod:NewBuffFadesTimer(5.9, 362601, nil, nil, nil, 5)--1.9+4
local timerProtoformRadiance					= mod:NewBuffActiveTimer(28.8, 363537, nil, nil, nil, 2)
local timerProtoformCascadeCD					= mod:NewCDTimer(20.6, 364652, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerCosmicShiftCD						= mod:NewCDTimer(20.3, 363088, nil, nil, nil, 3)
local timerDeconstructingEnergyCD				= mod:NewCDTimer(26.8, 363795, nil, nil, nil, 3)
local timerSynthesizeCD							= mod:NewCDTimer(20, 363130, nil, nil, nil, 6)
local timerSynthesize							= mod:NewBuffActiveTimer(20, 363130, nil, nil, nil, 6, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerRecharge								= mod:NewBuffActiveTimer(20, 361200, nil, nil, nil, 6)
--Adds

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(328897, true)
mod:AddSetIconOption("SetIconOnDeconstructingEnergy", 363795, true, false, {1, 2})
mod:AddNamePlateOption("NPAuraOnEphemeralBarrier", 364312, true)

mod.vb.energyIcon = 1

function mod:OnCombatStart(delay)
	self.vb.energyIcon = 1
	timerProtoformCascadeCD:Start(5.1-delay)--5-6
	timerUnstableMoteCD:Start(12-delay)
	timerDeconstructingEnergyCD:Start(20.5-delay)
	timerCosmicShiftCD:Start(self:IsMythic() and 27.8 or 25.4-delay)--TODO, is mythic slightly slower or just need more sample data to see a 25?
	timerSynthesizeCD:Start(self:IsMythic() and 31 or 100-delay)
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(328897))
--		DBM.InfoFrame:Show(10, "table", ExsanguinatedStacks, 1)
--	end
	if self.Options.NPAuraOnEphemeralBarrier then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
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
		timerUnstableMoteCD:Start(self:IsMythic() and 32.7 or 20.3)
		timerUnstableMote:Start()
	elseif spellId == 363130 then
		warnSynthesize:Show()
		--stop some boss timers here
		timerUnstableMoteCD:Stop()
		timerProtoformCascadeCD:Stop()
		timerDeconstructingEnergyCD:Stop()
		timerCosmicShiftCD:Stop()
	elseif spellId == 364652 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnProtoformCascade:Show()
			specWarnProtoformCascade:Play("defensive")
		end
		timerProtoformCascadeCD:Start(self:IsMythic() and 10.9 or 20.3)
	elseif spellId == 363088 then
		specWarnCosmicShift:Show()
		specWarnCosmicShift:Play("carefly")
		timerCosmicShiftCD:Start(self:IsMythic() and 32.7 or 20.3)
	elseif spellId == 365257 and self:AntiSpam(5, 1) then
		warnFormSentry:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 363795 or spellId == 363676 then
		self.vb.energyIcon = 1
		timerDeconstructingEnergyCD:Start(self:IsMythic() and 42.5 or 26.8)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if (spellId == 362622 or spellId == 366012) and self:AntiSpam(4, args.destName.."1") then
		if args:IsPlayer() and self:AntiSpam(3, 2) then
			specWarnUnstableMote:Show()
			specWarnUnstableMote:Play("targetyou")
		end
		warnUnstableMote:CombinedShow(0.3, args.destName)
	elseif spellId == 363537 then
		timerProtoformRadiance:Start()
	elseif spellId == 363795 or spellId == 363676 then--363676 goes on tank, 363795 goes on dps
		local icon = self.vb.energyIcon
		if self.Options.SetIconOnDeconstructingEnergy then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnDeconstructingEnergy:Show()
			specWarnDeconstructingEnergy:Play("runout")
			yellDeconstructingEnergy:Yell(icon, icon)
			yellDeconstructingEnergyFades:Countdown(spellId, nil, icon)
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnDeconstructingEnergyTaunt:Show(args.destName)
				specWarnDeconstructingEnergyTaunt:Play("tauntboss")
			end
		end
		self.vb.energyIcon = self.vb.energyIcon + 1
	elseif spellId == 364092 and self:AntiSpam(3, args.destName) then
		warnDegenerate:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnDegenerate:Show()
			specWarnDegenerate:Play("defensive")
		end
	elseif spellId == 364312 and args:IsDestTypeHostile() then
		if self.Options.NPAuraOnEphemeralBarrier then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 363130 then
		timerSynthesize:Start(self:IsMythic() and 15 or 20)
	elseif spellId == 361200 then
		if self:IsMythic() then
			timerRecharge:Start(30)
--			timerDeconstructingEnergyCD:Start(30.5)--NOT started here on mythic
--			timerUnstableMoteCD:Start(30.5)
		else
			timerRecharge:Start(20)
			timerDeconstructingEnergyCD:Start(20.5)--Started here because it's used .5 seconds after recharge ends
			timerUnstableMoteCD:Start(20.5)
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
	elseif spellId == 363130 then
		timerSynthesize:Stop()
	elseif spellId == 361200 then
		timerRecharge:Stop()
		--Restart boss timers
		if self:IsMythic() then
			timerProtoformCascadeCD:Start(6.1)
			timerUnstableMoteCD:Start(12.5)
			timerDeconstructingEnergyCD:Start(22.2)
			timerCosmicShiftCD:Start(28.3)
			timerSynthesizeCD:Start(101.2)
		else
--			timerDeconstructingEnergyCD:Start(1)--Started elsewhere since it's used instantly here
--			timerUnstableMoteCD:Start(2)--Same reason as above
			timerCosmicShiftCD:Start(6.7)
			timerProtoformCascadeCD:Start(15.2)
			timerSynthesizeCD:Start(65)
		end
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("362622") and self:AntiSpam(3, 2) then
		specWarnUnstableMote:Show()
		specWarnUnstableMote:Play("targetyou")
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("362622") and targetName then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName.."1") then
			warnUnstableMote:CombinedShow(0.5, targetName)
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
