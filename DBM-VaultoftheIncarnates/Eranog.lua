local mod	= DBM:NewMod(2480, "DBM-VaultoftheIncarnates", nil, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(184972)
mod:SetEncounterID(2587)
mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 370307 370534 373053 370659 370615",
	"SPELL_CAST_SUCCESS 370649",
	"SPELL_AURA_APPLIED 372074 370597 371562 370640 371059",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 372074 370597 371562 370640",
	"SPELL_PERIODIC_DAMAGE 370648",
	"SPELL_PERIODIC_MISSED 370648"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, add marking/tracking? https://www.wowhead.com/beta/npc=187593/collapsing-flame
--TODO, spell summon and auto marking with https://www.wowhead.com/beta/spell=371580/primal-forces ?
--TODO, adjust smart debuff check code for Melting Armor to match CD
--TODO, track rising heat? it seems tied to tank mechanic, yet is also listed separately?
--likely will NOT do: Add tracking of https://www.wowhead.com/beta/spell=386312/explosive-barrier . I suspect people will prefer WAs
local warnPrimalFlow							= mod:NewSpellAnnounce(370649, 2)
local warnPrimalForces							= mod:NewSpellAnnounce(370534, 3)
local warnKillOrder								= mod:NewTargetAnnounce(370597, 3)
local warnBlazingBrand							= mod:NewTargetNoFilterAnnounce(370659, 2)

local specWarnCollapsingArmy					= mod:NewSpecialWarningCount(376811, nil, nil, nil, 3, 2)
local specWarnKillOrder							= mod:NewSpecialWarningYou(370597, nil, nil, nil, 1, 2)
local specWarnBlazingBrand						= mod:NewSpecialWarningYouPos(370659, nil, nil, nil, 1, 2, 3)--Heroic/Mythic
local yellBlazingBrand							= mod:NewShortPosYell(370659)
local yellBlazingBrandFades						= mod:NewIconFadesYell(370659)
local specWarnMoltenSwing						= mod:NewSpecialWarningDefensive(370615, nil, nil, nil, 1, 2)
local specWarnMeltingArmor						= mod:NewSpecialWarningTaunt(371059, nil, nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(370648, nil, nil, nil, 1, 8)

local timerCollapsingArmyCD						= mod:NewAITimer(35, 376811, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerPrimalFlowCD							= mod:NewAITimer(35, 370649, nil, nil, nil, 3)
local timerPrimalForcesCD						= mod:NewAITimer(35, 370534, nil, nil, nil, 1)
local timerBlazingBrandCD						= mod:NewAITimer(35, 370659, nil, nil, nil, 3)
local timerMoltenSwingCD						= mod:NewAITimer(35, 370615, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(361651, true)
mod:AddSetIconOption("SetIconOnBrand", 370659, true, false, {1, 2, 3})
mod:AddNamePlateOption("NPAuraOnMoltenBarrier", 372074, true)
mod:AddNamePlateOption("NPAuraOnFixate", 370597, true)
mod:AddNamePlateOption("NPAuraOnRampage", 371562, true)

mod:GroupSpells(370615, 371059)--Molten Swing with Melting Armor

mod.vb.armyCount = 0
mod.vb.brandIcon = 1

function mod:OnCombatStart(delay)
	self.vb.armyCount = 0
	timerCollapsingArmyCD:Start(1-delay)
	timerPrimalFlowCD:Start(1-delay)
	timerPrimalForcesCD:Start(1-delay)
	timerBlazingBrandCD:Start(1-delay)
	if self.Options.NPAuraOnBurdenofDestiny or self.Options.NPAuraOnFixate or self.Options.NPAuraOnRampage then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.NPAuraOnBurdenofDestiny or self.Options.NPAuraOnFixate or self.Options.NPAuraOnRampage then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 370307 then
		self.vb.armyCount = self.vb.armyCount + 1
		specWarnCollapsingArmy:Show(self.vb.armyCount)
		specWarnCollapsingArmy:Play("specialsoon")
		timerCollapsingArmyCD:Start()
	elseif spellId == 370534 then
		warnPrimalForces:Show()
		timerPrimalForcesCD:Start()
	elseif args:IsSpellID(373053, 370659) then--373053 Easy, 370659 Hard
		self.vb.brandIcon = 1
		timerBlazingBrandCD:Start()
	elseif spellId == 370615 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnFreezingBreath:Show()
			specWarnFreezingBreath:Play("defensive")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 370649 then
		warnPrimalFlow:Show()
		timerPrimalFlowCD:Start()
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
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 371562 then
		if self.Options.NPAuraOnRampage then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 370640 then
		local icon = self.vb.brandIcon
		if self.Options.SetIconOnBrand then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnBlazingBrand:Show(self:IconNumToTexture(icon))
			specWarnBlazingBrand:Play("mm"..icon)
			yellBlazingBrand:Yell(icon, icon)
			yellBlazingBrandFades:Countdown(spellId, nil, icon)
		end
		warnBlazingBrand:CombinedShow(0.5, args.destName)
		self.vb.brandIcon = self.vb.brandIcon + 1
	elseif spellId == 371059 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) and not args:IsPlayer() then
			local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
			local remaining
			if expireTime then
				remaining = expireTime-GetTime()
			end
			if (not remaining or remaining and remaining < 10.9) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
				specWarnMeltingArmor:Show(args.destName)
				specWarnMeltingArmor:Play("tauntboss")
			end
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 372074 then
		if self.Options.NPAuraOnMoltenBarrier then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 370597 then
		if args:IsPlayer() then
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 371562 then
		if self.Options.NPAuraOnRampage then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 370640 then
		if self.Options.SetIconOnBrand then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellBlazingBrandFades:Cancel()
		end
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
