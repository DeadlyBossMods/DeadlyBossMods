local mod	= DBM:NewMod(2484, "DBM-Party-Dragonflight", 2, 1197)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(184124)
mod:SetEncounterID(2557)
mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 372719 372600 372623 372701",
	"SPELL_CAST_SUCCESS 372718",
	"SPELL_AURA_APPLIED 382071",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 382071"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, proper detection of enery resets (Inexorable) to make sure timer update code for titanic empowerment is correct
--TODO, proper timer updates for when boss is stunned or reset
local warnInexorable							= mod:NewSpellAnnounce(372600, 2)
local warnResonatingOrb							= mod:NewTargetNoFilterAnnounce(382071, 3)
local warnEarthenShards							= mod:NewTargetNoFilterAnnounce(372718, 3, nil, "Healer")

-local specWarnTitanicEmpowerment				= mod:NewSpecialWarningSpell(372719, nil, nil, nil, 3, 2)
local specWarnResonatingOrb						= mod:NewSpecialWarningYouPos(382071, nil, nil, nil, 1, 2)
local yellResonatingOrb							= mod:NewShortPosYell(382071)
local yellResonatingOrbFades					= mod:NewIconFadesYell(382071)
local specWarnCrushingStomp						= mod:NewSpecialWarningSpell(372701, nil, nil, nil, 2, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

local timerTitanicEmpowermentCD					= mod:NewAITimer(35, 372719, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerResonatingOrbCD						= mod:NewAITimer(35, 382071, nil, nil, nil, 3)
local timerCrushingStompCD						= mod:NewAITimer(35, 372701, nil, nil, nil, 2)
local timerEarthenShardsCD						= mod:NewAITimer(35, 372718, nil, nil, nil, 3, nil, DBM_COMMON_L.BLEED_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(361651, true)
mod:AddSetIconOption("SetIconOnOrb", 382071, true, false, {1, 2, 3})

mod.vb.orbIcon = 1

function mod:OnCombatStart(delay)
	timerTitanicEmpowermentCD:Start(1-delay)
	timerResonatingOrbCD:Start(1-delay)
	timerCrushingStompCD:Start(1-delay)
	timerEarthenShardsCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 372719 then
		specWarnTitanicEmpowerment:Show()
		specWarnTitanicEmpowerment:Play("specialsoon")
	elseif spellId == 372600 then
		warnInexorable:Show()
		timerTitanicEmpowermentCD:Stop()
		timerTitanicEmpowermentCD:Start(2)
	elseif spellId == 372623 then
		self.vb.orbIcon = 1
	elseif spellId == 372701 then
		specWarnCrushingStomp:Show()
		specWarnCrushingStomp:Play("carefly")
		timerCrushingStompCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 372718 then
		timerEarthenShardsCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 382071 then
		local icon = self.vb.orbIcon
		if self.Options.SetIconOnOrb then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnResonatingOrb:Show(self:IconNumToTexture(icon))
			specWarnResonatingOrb:Play("mm"..icon)
			yellResonatingOrb:Yell(icon, icon)
			yellResonatingOrbFades:Countdown(spellId, nil, icon)
		end
		warnResonatingOrb:CombinedShow(0.5, args.destName)
		self.vb.orbIcon = self.vb.orbIcon + 1
	elseif spellId == 372718 then
		warnEarthenShards:CombinedShow(0.3, args.destName)--TODO: Don't combo if it's never more than 1
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 382071 then
		if self.Options.SetIconOnOrb then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellResonatingOrbFades:Cancel()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
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
