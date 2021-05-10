local mod	= DBM:NewMod(2444, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175729)
mod:SetEncounterID(2432)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20201222000000)
--mod:SetMinSyncRevision(20201222000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 349889 355123 351066 351067 351073 350469",--350096 350691 350518
--	"SPELL_CAST_SUCCESS",
--	"SPELL_SUMMON 349908",
	"SPELL_AURA_APPLIED 350337 350469 349890 349889",--350097
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 350337 350469 349889",--350097
	"SPELL_PERIODIC_DAMAGE 350489",
	"SPELL_PERIODIC_MISSED 350489",
--	"UNIT_DIED"
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Fix timers if possible, right now they are near useless since they are all HIGHLY variable with no pattern as to why (no evidence shows shatter affects them)
--TODO, Orb of Torment's Unrelenting Torment cast removed? Same with Burst of Agony?
--[[
(ability.id = 349889 or ability.id = 355123 or ability.id = 351066 or ability.id = 351067 or ability.id = 351073 or ability.id = 350469) and type = "begincast"
 or (source.type = "NPC" and source.firstSeen = timestamp) or (target.type = "NPC" and target.firstSeen = timestamp)
--]]
local warnOrbofTorment							= mod:NewCountAnnounce(349908, 2)
local warnOrbSuffering							= mod:NewFadesAnnounce(350337, 1)
--local warnUnrelentingTorment					= mod:NewCountAnnounce(350518, 4)
local warnMalevolence							= mod:NewTargetNoFilterAnnounce(350469, 3)
--local warnBlight								= mod:NewTargetNoFilterAnnounce(349890, 3)
--local warnAgony								= mod:NewTargetAnnounce(350097, 3)
local warnShatter								= mod:NewCountAnnounce(351066, 1)

local specWarnMalevolence						= mod:NewSpecialWarningYouPos(350469, nil, nil, nil, 1, 2)
local yellMalevolence							= mod:NewShortPosYell(350469)
local yellMalevolenceFades						= mod:NewIconFadesYell(350469)
local specWarnBlight							= mod:NewSpecialWarningMoveTo(349889, nil, nil, nil, 1, 2)
local yellBlight								= mod:NewYell(349889, nil, false)--Not as useful as fades
local yellBlightFades							= mod:NewFadesYell(349889)
local specWarnBlightSwap						= mod:NewSpecialWarningTaunt(349889, nil, nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(350489, nil, nil, nil, 1, 8)
local specWarnGraspofMalice						= mod:NewSpecialWarningDodge(355123, nil, nil, nil, 2, 2)--Malicious Gauntlet
--local specWarnAgony							= mod:NewSpecialWarningMoveAway(350097, nil, nil, nil, 1, 2)
--local yellAgony								= mod:NewYell(350097)
--local yellAgonyFades							= mod:NewFadesYell(350097)

--mod:AddTimerLine(BOSS)
local timerOrbofTormentCD						= mod:NewCDTimer(31.7, 349908, nil, nil, nil, 1)--31-60, kind of worthless timer
local timerMalevolenceCD						= mod:NewCDTimer(21.2, 350469, nil, nil, nil, 3, nil, DBM_CORE_L.CURSE_ICON)--Rattlecage of Agony
local timerBlightCD								= mod:NewCDTimer(15.8, 349889, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON, nil, mod:IsTank() and 2, 3)--Helm of Suffering (casts suffering not blight technically)
local timerGraspofMaliceCD						= mod:NewCDTimer(20.7, 355123, nil, nil, nil, 3)--Malicious Gauntlet
--local timerBurstofAgonyCD						= mod:NewAITimer(23, 350096, nil, nil, nil, 3)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(349890, true)
mod:AddSetIconOption("SetIconOnMalevolence", 350469, true, false, {1, 2, 3})
mod:AddNamePlateOption("NPAuraOnOrbSuffering", 350337)

mod.vb.orbCount = 0
mod.vb.unrelentingCount = 0
mod.vb.malevolenceCount = 0
mod.vb.malevolenceIcon = 1
mod.vb.shatterCount = 0

function mod:OnCombatStart(delay)
	self.vb.orbCount = 0
	self.vb.unrelentingCount = 0
	self.vb.malevolenceCount = 0
	self.vb.shatterCount = 0
	timerOrbofTormentCD:Start(12-delay)
	timerGraspofMaliceCD:Start(21.3-delay)--Probably doesn't start here
	timerMalevolenceCD:Start(36.5-delay)
	timerBlightCD:start(37.7-delay)
--	timerBurstofAgonyCD:Start(1-delay)--probably doesn't start here
--	berserkTimer:Start(-delay)
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(328897))
--		DBM.InfoFrame:Show(10, "table", ExsanguinatedStacks, 1)
--	end
	if self.Options.NPAuraOnOrbSuffering then
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
	if self.Options.NPAuraOnOrbSuffering then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 349889 then--or 350894
		timerBlightCD:Start()
	elseif spellId == 355123 then
		specWarnGraspofMalice:Show()
		specWarnGraspofMalice:Play("watchstep")
		timerGraspofMaliceCD:Start()
--	elseif spellId == 350096 or spellId == 350691 then--Mythic/Heroic likely and normal/LFR likely
--		timerBurstofAgonyCD:Start()
	elseif spellId == 351066 or spellId == 351067 or spellId == 351073 then--Shatter (Helm of Suffering, Malicious Gauntlets, Rattlecage of Agony)
		self.vb.shatterCount = self.vb.shatterCount + 1
		warnShatter:Show(self.vb.shatterCount)
	elseif spellId == 350469 then
		self.vb.malevolenceIcon = 1
		self.vb.malevolenceCount = self.vb.malevolenceCount + 1
		timerMalevolenceCD:Start()
--	elseif spellId == 350518 then
--		self.vb.unrelentingCount = self.vb.unrelentingCount + 1
--		warnUnrelentingTorment:Show(self.vb.unrelentingCount)
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 350469 then
		self.vb.malevolenceIcon = 1
		self.vb.malevolenceCount = self.vb.malevolenceCount + 1
		timerMalevolenceCD:Start()
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
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 350337 then
		if self.Options.NPAuraOnOrbSuffering then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 20)
		end
	elseif spellId == 350469 then
		local icon = self.vb.malevolenceIcon
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
		self.vb.malevolenceIcon = self.vb.malevolenceIcon + 1
--	elseif spellId == 349890 then
--		warnBlight:Show(args.destName)
--[[	elseif spellId == 350097 then
		warnAgony:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnAgony:Show()
			specWarnAgony:Play("runout")
			yellAgony:Yell()
			yellAgonyFades:Countdown(spellId)
		end--]]
	elseif spellId == 349889 then
		if args:IsPlayer() then
			specWarnBlight:Show(DBM_CORE_L.ORB)
			specWarnBlight:Play("targetyou")--or orbrun.ogg?
			yellBlight:Yell()
			yellBlightFades:Countdown(spellId)
		else
			specWarnBlightSwap:Show(args.destName)
			specWarnBlightSwap:Play("tauntboss")
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 350337 then
		if self.Options.NPAuraOnOrbSuffering then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
		if self:AntiSpam(3, 2) then
			warnOrbSuffering:Show()
		end
	elseif spellId == 350469 then
		if args:IsPlayer() then
			yellMalevolenceFades:Cancel()
		end
		if self.Options.SetIconOnMalevolence then
			self:SetIcon(args.destName, 0)
		end
--	elseif spellId == 350097 then
--		if args:IsPlayer() then
--			yellAgonyFades:Cancel()
--		end
	elseif spellId == 349889 then
		if args:IsPlayer() then
			yellBlightFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 350489 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 177289 then--https://ptr.wowhead.com/npc=177289/rattlecage-of-agony

	elseif cid == 177268 then--https://ptr.wowhead.com/npc=177268/helm-of-suffering

	elseif cid == 177287 then--https://ptr.wowhead.com/npc=177287/malicious-gauntlet

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 350676 then--Orb of Torment
		self.vb.orbCount = self.vb.orbCount + 1
		warnOrbofTorment:Show(self.vb.orbCount)
		timerOrbofTormentCD:Start()
	end
end

