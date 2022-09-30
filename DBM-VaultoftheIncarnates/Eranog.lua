local mod	= DBM:NewMod(2480, "DBM-VaultoftheIncarnates", nil, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(184972)
mod:SetEncounterID(2587)
mod:SetUsedIcons(1, 2, 3, 4, 5)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 370307 390715 394917 370615",
	"SPELL_CAST_SUCCESS 394917",
	"SPELL_AURA_APPLIED 372074 370597 371562 390715 394906",
	"SPELL_AURA_APPLIED_DOSE 394906",
	"SPELL_AURA_REMOVED 372074 370597 371562 390715",
	"SPELL_PERIODIC_DAMAGE 370648",
	"SPELL_PERIODIC_MISSED 370648"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, add marking/tracking? https://www.wowhead.com/beta/npc=187593/collapsing-flame
--TODO, adjust tank debuff check code for tank debuff to match CD and correct stack swap count based on the math
--TODO, track rising heat? it seems tied to tank mechanic, yet is also listed separately?
--TODO, Molten Barrier mechanic might also be deleted
--TODO, Try to find a way to fix leap timer more. Need to figure out why sometimes it's double cast after army and other times it's not (discounting restarted casts)
--likely will NOT do: Add tracking of https://www.wowhead.com/beta/spell=386312/explosive-barrier . I suspect people will prefer WAs
--[[
(ability.id = 370307 or ability.id = 390715 or ability.id = 394917 or ability.id = 370615) and type = "begincast"
 or ability.id = 394917 and type = "cast"
 or ability.id = 370307 and type = "removebuff"
 or ability.id = 390715 and type = "applydebuff"
--]]
--Stage One: Army of Talon
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26001))
local warnFlamerift								= mod:NewTargetNoFilterAnnounce(390715, 2)
local warnLeapingFlames							= mod:NewCountAnnounce(394917, 3)
local warnBurningWound							= mod:NewStackAnnounce(394906, 2, nil, "Tank|Healer")

local specWarnFlamerift							= mod:NewSpecialWarningMoveAway(390715, nil, nil, nil, 1, 2)
local yellFlamerift								= mod:NewShortPosYell(390715)
local yellFlameriftFades						= mod:NewShortFadesYell(390715)
local specWarnMoltenCleave						= mod:NewSpecialWarningDodgeCount(370615, nil, nil, nil, 2, 2)
local specWarnBurningWound						= mod:NewSpecialWarningStack(394906, nil, 6, nil, nil, 1, 6)
local specWarnBurningWoundTaunt					= mod:NewSpecialWarningTaunt(394906, nil, nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(370648, nil, nil, nil, 1, 8)

local timerMoltenCleaveCD						= mod:NewCDCountTimer(30.2, 370615, nil, nil, nil, 3)
local timerFlameriftCD							= mod:NewCDCountTimer(30.2, 390715, nil, nil, nil, 3, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerLeapingFlamesCD						= mod:NewCDCountTimer(30.2, 394917, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddInfoFrameOption(361651, true)
mod:AddRangeFrameOption(5, 390715)
--mod:AddSetIconOption("SetIconOnFlamerift", 390715, true, false, {1, 2, 3, 4, 5})
---Frenzied Tarasek
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26005))
local warnKillOrder								= mod:NewTargetAnnounce(370597, 3)

local specWarnKillOrder							= mod:NewSpecialWarningYou(370597, nil, nil, nil, 1, 2)

mod:AddNamePlateOption("NPAuraOnKillOrder", 370597, true)
mod:AddNamePlateOption("NPAuraOnRampage", 371562, true)
--Stage Two: Army of Flame
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26004))
local specWarnCollapsingArmy					= mod:NewSpecialWarningCount(370307, nil, nil, nil, 3, 2)

local timerCollapsingArmyCD						= mod:NewCDCountTimer(94, 370307, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddNamePlateOption("NPAuraOnMoltenBarrier", 372074, true)--Check if also removed

mod.vb.armyCount = 0
mod.vb.cleaveCount = 0
mod.vb.leapingCount = 0
mod.vb.riftCount = 0
--mod.vb.riftIcon = 1

function mod:OnCombatStart(delay)
	self.vb.armyCount = 0
	self.vb.cleaveCount = 0
	self.vb.leapingCount = 0
	self.vb.riftCount = 0
--	self.vb.riftIcon = 1
	timerLeapingFlamesCD:Start(4.5-delay, 1)
	timerMoltenCleaveCD:Start(9.8-delay, 1)
	timerFlameriftCD:Start(13.8-delay, 1)
	timerCollapsingArmyCD:Start(91.7-delay, 1)
	if self.Options.NPAuraOnMoltenBarrier or self.Options.NPAuraOnKillOrder or self.Options.NPAuraOnRampage then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.NPAuraOnMoltenBarrier or self.Options.NPAuraOnKillOrder or self.Options.NPAuraOnRampage then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 370307 then
		self.vb.armyCount = self.vb.armyCount + 1
		specWarnCollapsingArmy:Show(self.vb.armyCount)
		specWarnCollapsingArmy:Play("specialsoon")
		timerCollapsingArmyCD:Start(nil, self.vb.armyCount+1)
		timerFlameriftCD:Stop()
		timerLeapingFlamesCD:Stop()
		timerMoltenCleaveCD:Stop()
		--These seem to start better from here, they are far less accurate started from army end
		timerMoltenCleaveCD:Start(40.6, self.vb.cleaveCount+1)--40-42 here, started after army, the variation is much bigger there
		timerFlameriftCD:Start(44.5, self.vb.riftCount+1)
	elseif spellId == 390715 then
--		self.vb.riftIcon = 1
		self.vb.riftCount = self.vb.riftCount + 1
		timerFlameriftCD:Start(nil, self.vb.riftCount+1)
	elseif spellId == 394917 then
		warnLeapingFlames:Show(self.vb.leapingCount+1)
	elseif spellId == 370615 then
		self.vb.cleaveCount = self.vb.cleaveCount + 1
		specWarnMoltenCleave:Show(self.vb.cleaveCount)
		specWarnMoltenCleave:Play("shockwave")
		timerMoltenCleaveCD:Start(nil, self.vb.cleaveCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 394917 then--success used to start timer and update count due to stutter step recasts
		self.vb.leapingCount = self.vb.leapingCount + 1
		timerLeapingFlamesCD:Start(nil, self.vb.leapingCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 372074 then
		if self.Options.NPAuraOnMoltenBarrier then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 370597 then
		warnKillOrder:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnKillOrder:Show()
			specWarnKillOrder:Play("targetyou")
			if self.Options.NPAuraOnKillOrder then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 371562 then
		if self.Options.NPAuraOnRampage then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 390715 then
--		local icon = self.vb.riftIcon
--		if self.Options.SetIconOnFlamerift and icon < 9 then
--			self:SetIcon(args.destName, icon)
--		end
		if args:IsPlayer() then
			specWarnFlamerift:Show()
			specWarnFlamerift:Play("range5")
			yellFlamerift:Yell()
			yellFlameriftFades:Countdown(spellId)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
		warnFlamerift:CombinedShow(0.5, args.destName)
--		self.vb.riftIcon = self.vb.riftIcon + 1
	elseif spellId == 394906 then
		local amount = args.amount or 1
		if (amount % 3 == 0) then
			if amount >= 6 then
				if args:IsPlayer() then
					specWarnBurningWound:Show(amount)
					specWarnBurningWound:Play("stackhigh")
				else
					local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					if (not remaining or remaining and remaining < 10.9) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
						specWarnBurningWoundTaunt:Show(args.destName)
						specWarnBurningWoundTaunt:Play("tauntboss")
					else
						warnBurningWound:Show(args.destName, amount)
					end
				end
			else
				warnBurningWound:Show(args.destName, amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 372074 then
		if self.Options.NPAuraOnMoltenBarrier then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 370597 then
		if args:IsPlayer() then
			if self.Options.NPAuraOnKillOrder then
				DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 371562 then
		if self.Options.NPAuraOnRampage then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 390715 then
--		if self.Options.SetIconOnFlamerift then
--			self:SetIcon(args.destName, 0)
--		end
		if args:IsPlayer() then
			yellFlameriftFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 370307 then--Army ending
		--These timers however seems more accurate started from army end than army start
		timerLeapingFlamesCD:Start(6.1, self.vb.leapingCount+1)--6-7 variatio here, started at army start the variation is bigger
		timerCollapsingArmyCD:Start(94, self.vb.armyCount+1)--94-97 here, started at army the variation is bigger
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 370648 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 187638 then--Flaming Tarasek

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]
