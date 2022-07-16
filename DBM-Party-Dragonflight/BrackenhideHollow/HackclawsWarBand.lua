local mod	= DBM:NewMod(2471, "DBM-Party-Dragonflight", 1, 1196)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(181224)
mod:SetEncounterID(2570)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 381694 378029 381470 377950",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 381461 377827 381835 377844 381387 381379 378229 381466"
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED 361966 361018 361651"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, which ID for Rira's Bladestorm targetting, it has two targetting debuffs, or just buff on boss (377827), for now it's using generic target alert
--TODO, two version of decayed senses, which used? Both?
--TODO, move marked for butchery timer start
--TODO, add https://www.wowhead.com/beta/spell=378155/earth-bolt ?
--TODO, add npc ids, they don't exist yet
--Rira Hackclaw
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24732))
local warnSavageCharge							= mod:NewTargetNoFilterAnnounce(381461, 4)--Not special waring for now, since it is 14 sec cast time
local warnBladestorm							= mod:NewTargetNoFilterAnnounce(377827, 3)

local specWarnSavageCharge						= mod:NewSpecialWarningYou(381461, nil, nil, nil, 1, 2)
local yellSavageCharge							= mod:NewYell(381461)

local timerSavageChargeCD						= mod:NewAITimer(35, 381461, nil, nil, nil, 3, nil, DBM_COMMON_L.TANK_ICON)
local timerBladestormCD							= mod:NewAITimer(35, 377827, nil, nil, nil, 3)
--Gashtooth
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24733))
local warnMarkedforButchery						= mod:NewTargetNoFilterAnnounce(378229, 3, nil, "Healer")

local specWarnDecayedSenses						= mod:NewSpecialWarningDispel(381379, "RemoveMagic", nil, nil, 1, 2)
local specWarnGashFrenzy						= mod:NewSpecialWarningSpell(378029, "Healer", nil, nil, 2, 2)
local specWarnMarkedforButchery					= mod:NewSpecialWarningDefensive(378229, nil, nil, nil, 1, 2)

local timerDecayedSensesCD						= mod:NewAITimer(35, 381379, nil, nil, nil, 3)
local timerGashFrenzyCD							= mod:NewAITimer(35, 378029, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.BLEED_ICON)
local timerMarkedforButcheryCD					= mod:NewAITimer(35, 378229, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)
--Tricktotem
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24734))
local warnHextrick								= mod:NewTargetNoFilterAnnounce(381466, 3)

local specWarnHextrickTotem						= mod:NewSpecialWarningSwitch(381470, "-Healer", nil, nil, 1, 2)
local specWarnGreaterHealingRapids				= mod:NewSpecialWarningInterrupt(377950, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

local timerHexrickTotemCD						= mod:NewAITimer(35, 381470, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerGreaterHealingRapidsCD				= mod:NewAITimer(35, 381470, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(361651, true)
--mod:AddSetIconOption("SetIconOnStaggeringBarrage", 361018, true, false, {1, 2, 3})

function mod:OnCombatStart(delay)
	--Rira Hackclaw
	timerSavageChargeCD:Start(1-delay)
	timerBladestormCD:Start(1-delay)
	--Gashtooth
	timerDecayedSensesCD:Start(1-delay)
	timerGashFrenzyCD:Start(1-delay)
	timerMarkedforButcheryCD:Start(1-delay)
	--Tricktotem
	timerHexrickTotemCD:Start(1-delay)
	timerGreaterHealingRapidsCD:Start(1-delay)
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 381694 then
		timerDecayedSensesCD:Start()
	elseif spellId == 378029 then
		specWarnGashFrenzy:Show()
		specWarnGashFrenzy:Play("healfull")
		timerGashFrenzyCD:Start()
	elseif spellId == 381470 then
		specWarnHextrickTotem:Show()
		specWarnHextrickTotem:Play("attacktotem")
		timerHexrickTotemCD:Start()
	elseif spellId == 377950 then
		timerGreaterHealingRapidsCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnGreaterHealingRapids:Show(args.sourceName)
			specWarnGreaterHealingRapids:Play("kickcast")
		end
	end
end
--
--function mod:SPELL_CAST_SUCCESS(args)
--	local spellId = args.spellId
--	if spellId == 362805 then
--
--	end
--end
--
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 381461 then
		if args:IsPlayer() then
			specWarnSavageCharge:Show()
			specWarnSavageCharge:Play("targetyou")
			yellSavageCharge:Yell()
		else
			warnSavageCharge:Show(args.destName)
		end
	elseif spellId == 377827 then
		timerBladestormCD:Start()
	elseif args:IsSpellID(381835, 377844) then
		warnBladestorm:Show(args.destName)
	elseif args:IsSpellID(381387, 381379) and self:CheckDispelFilter() then
		specWarnDecayedSenses:Show(args.destName)
		specWarnDecayedSenses:Play("helpdispel")
	elseif spellId == 378229 then
		timerMarkedforButcheryCD:Start()--Move to success to start as appropriate
		if args:IsPlayer() then
			specWarnMarkedforButchery:Show()
			specWarnMarkedforButchery:Play("defensive")
		else
			warnMarkedforButchery:Show(args.destName)
		end
	elseif spellId == 381466 then
		warnHextrick:Show(args.destName)
	end
end
----mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
--
--function mod:SPELL_AURA_REMOVED(args)
--	local spellId = args.spellId
--	if spellId == 361966 then
--
--	end
--end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 999999 then--Rira Hackclaw
		timerSavageChargeCD:Stop()
		timerBladestormCD:Stop()
	elseif cid == 999999 then--Gashtooth
		timerDecayedSensesCD:Stop()
		timerGashFrenzyCD:Stop()
		timerMarkedforButcheryCD:Stop()
	elseif cid == 999999 then--Tricktotem
		timerHexrickTotemCD:Stop()
		timerGreaterHealingRapidsCD:Stop()
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
