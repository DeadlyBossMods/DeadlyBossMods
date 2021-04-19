local mod	= DBM:NewMod(2444, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(164406)--https://ptr.wowhead.com/npc=163523/animated-armor probably
mod:SetEncounterID(2432)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20201222000000)
--mod:SetMinSyncRevision(20201222000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 350518 349889 349891 353332 350096 350691",
	"SPELL_CAST_SUCCESS 350469",
	"SPELL_SUMMON 349908",
	"SPELL_AURA_APPLIED 350075 350469 349890 350097",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 350075 350469 350097",
	"SPELL_PERIODIC_DAMAGE 350489",
	"SPELL_PERIODIC_MISSED 350489"
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--https://ptr.wowhead.com/npc=177268/helm-of-blight / https://ptr.wowhead.com/npc=177287/malicious-gauntlet
--TODO, more tank stuff with suffering and blight like finding target, marking, swapping, etc
--TODO, https://ptr.wowhead.com/spell=350337/blight?
--TODO, detect phase/armor changes
local warnOrbofTorment							= mod:NewCountAnnounce(349908, 2)
local warnEternalTorment						= mod:NewFadesAnnounce(350075, 1)
local warnUnrelentingTorment					= mod:NewCountAnnounce(341684, 4)
local warnMalevolence							= mod:NewTargetNoFilterAnnounce(350469, 3)
--Helm of Blight
--local warnBlight								= mod:NewTargetNoFilterAnnounce(349890, 3)
--Pauldrons of Agony
local warnAgony									= mod:NewTargetAnnounce(350097, 3)

local specWarnMalevolence						= mod:NewSpecialWarningYouPos(350469, nil, nil, nil, 1, 2)
local yellMalevolence							= mod:NewShortPosYell(350469)
local yellMalevolenceFades						= mod:NewIconFadesYell(350469)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(350489, nil, nil, nil, 1, 8)
--Helm of Blight
----Tank warnings and shit
--Malicious Gauntlets
local specWarnGraspofMalice						= mod:NewSpecialWarningDodge(353332, nil, nil, nil, 2, 2)
--Pauldrons of Agony
local specWarnAgony								= mod:NewSpecialWarningMoveAway(350097, nil, nil, nil, 1, 2)
local yellAgony									= mod:NewYell(350097)
local yellAgonyFades							= mod:NewFadesYell(350097)

--mod:AddTimerLine(BOSS)
local timerOrbofTormentCD						= mod:NewAITimer(23, 349908, nil, nil, nil, 1)
local timerCurseofMalevolenceCD					= mod:NewAITimer(17.8, 350469, nil, nil, nil, 3, nil, DBM_CORE_L.CURSE_ICON)
local timerSufferingCD							= mod:NewAITimer(17.8, 349889, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
--Helm of Blight
local timerBlightCD								= mod:NewAITimer(17.8, 349891, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON, nil, 1, 3)
--Malicious Gauntlets
local timerGraspofMaliceCD						= mod:NewAITimer(23, 353332, nil, nil, nil, 3)
--Pauldrons of Agony
local timerBurstofAgonyCD						= mod:NewAITimer(23, 350096, nil, nil, nil, 3)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(349890, true)
mod:AddSetIconOption("SetIconOnMalevolence", 350469, true, false, {1, 2, 3})
mod:AddNamePlateOption("NPAuraOnEternalTorment", 350075)

mod.vb.orbCount = 0
mod.vb.unrelentingCount = 0
mod.vb.malevolenceCount = 0
mod.vb.malevolenceIcon = 1

function mod:OnCombatStart(delay)
	self.vb.orbCount = 0
	self.vb.unrelentingCount = 0
	self.vb.malevolenceCount = 0
	timerOrbofTormentCD:Start(1-delay)
	timerCurseofMalevolenceCD:Start(1-delay)
	timerSufferingCD:Start(1-delay)
	timerBlightCD:start(1-delay)
	timerGraspofMaliceCD:Start(1-delay)--Probably doesn't start here
	timerBurstofAgonyCD:Start(1-delay)--probably doesn't start here
--	berserkTimer:Start(-delay)
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(328897))
--		DBM.InfoFrame:Show(10, "table", ExsanguinatedStacks, 1)
--	end
	if self.Options.NPAuraOnEternalTorment then
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
	if self.Options.NPAuraOnEternalTorment then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 350518 then
		self.vb.unrelentingCount = self.vb.unrelentingCount + 1
		warnUnrelentingTorment:Show(self.vb.unrelentingCount)
	elseif spellId == 349889 then
		timerSufferingCD:Start()
	elseif spellId == 349891 then--or 350894
		timerBlightCD:Start()
	elseif spellId == 353332 then
		specWarnGraspofMalice:Show()
		specWarnGraspofMalice:Play("watchstep")
		timerGraspofMaliceCD:Start()
	elseif spellId == 350096 or spellId == 350691 then--Mythic/Heroic likely and normal/LFR likely
		timerBurstofAgonyCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 350469 then
		self.vb.malevolenceIcon = 1
		self.vb.malevolenceCount = self.vb.malevolenceCount + 1
		timerCurseofMalevolenceCD:Start()
	end
end

function mod:SPELL_CAST_SUMMON(args)
	local spellId = args.spellId
	if spellId == 349908 and self:AntiSpam(3, 1) then
		self.vb.orbCount = self.vb.orbCount + 1
		warnOrbofTorment:Show(self.vb.orbCount)
		timerOrbofTormentCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 350075 then
		if self.Options.NPAuraOnEternalTorment then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 350469 then
		local icon = self.vb.MalevolenceIcon
		if self.Options.SetIconOnMalevolence then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnMalevolence:Show(self:IconNumToTexture(icon))
			specWarnMalevolence:Play("mm"..icon)
			yellMalevolence:Yell(icon, icon)
			yellMalevolenceFades:Countdown(spellId, nil, icon)
		end
		warnMalevolence:CombinedShow(0.3, args.destName)
		self.vb.MalevolenceIcon = self.vb.MalevolenceIcon + 1
--	elseif spellId == 349890 then
--		warnBlight:Show(args.destName)
	elseif spellId == 350097 then
		warnAgony:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnAgony:Show()
			specWarnAgony:Play("runout")
			yellAgony:Yell()
			yellAgonyFades:Countdown(spellId)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 350075 then
		if self.Options.NPAuraOnEternalTorment then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
		if self:AntiSpam(3, 2) then
			warnEternalTorment:Show()
		end
	elseif spellId == 350469 then
		if args:IsPlayer() then
			yellMalevolenceFades:Cancel()
		end
		if self.Options.SetIconOnMalevolence then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 350097 then
		if args:IsPlayer() then
			yellAgonyFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 350489 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 342074 then

	end
end
--]]
