local mod	= DBM:NewMod(2390, "DBM-Party-Shadowlands", 6, 1187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162329)
mod:SetEncounterID(2366)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 320644 317231 320729",
	"SPELL_CAST_SUCCESS 320050 320102",
	"SPELL_AURA_APPLIED 317685 320102"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, figure out correct Might of Maldraxxus trigger, and not leave all 3 in mod
local warnCrushingSlam				= mod:NewCountAnnounce(317231, 4)
local warnMassiveCleave				= mod:NewCountAnnounce(320729, 4)
local warnBloodandGlory				= mod:NewTargetNoFilterAnnounce(320102, 2)

local specWarnBrutalCombo			= mod:NewSpecialWarningDefensive(320644, "Tank", nil, nil, 1, 2)
local specWarnMightofMaldraxxus		= mod:NewSpecialWarningDodge(320050, nil, nil, nil, 3, 2)
--local yellBlackPowder				= mod:NewYell(257314)
local specWarnBloodandGlory			= mod:NewSpecialWarningYou(320102, nil, nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerBrutalComboCD			= mod:NewAITimer(13, 320644, nil, nil, nil, 1, nil, DBM_CORE_Translations.TANK_ICON)
local timerMightofMaldraxxusCD		= mod:NewAITimer(15.8, 320050, nil, nil, nil, 6, nil, DBM_CORE_Translations.DEADLY_ICON)
local timerBloodandGloryCD			= mod:NewAITimer(15.8, 320102, nil, nil, nil, 3, nil, DBM_CORE_Translations.DAMAGE_ICON)

mod.vb.MightCount = 0

function mod:OnCombatStart(delay)
	self.vb.MightCount = 0
	timerBrutalComboCD:Start(1-delay)
	timerMightofMaldraxxusCD:Start(1-delay)
	timerBloodandGloryCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 320644 then
		specWarnBrutalCombo:Show()
		specWarnBrutalCombo:Play("defensive")
		timerBrutalComboCD:Start()
	elseif spellId == 317231 then
		self.vb.MightCount = self.vb.MightCount + 1
		warnCrushingSlam:Show(self.vb.MightCount)
	elseif spellId == 320729 then
		self.vb.MightCount = self.vb.MightCount + 1
		warnMassiveCleave:Show(self.vb.MightCount)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 320050 and self:AntiSpam(10, 1) then
		self.vb.MightCount = 0
		specWarnMightofMaldraxxus:Show()
		specWarnMightofMaldraxxus:Play("watchstep")
		timerMightofMaldraxxusCD:Start()
	elseif spellId == 320102 and self:AntiSpam(5, 2) then
		timerBloodandGloryCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 317685 and self:AntiSpam(10, 1) then
		self.vb.MightCount = 0
		specWarnMightofMaldraxxus:Show()
		specWarnMightofMaldraxxus:Play("watchstep")
		timerMightofMaldraxxusCD:Start()
	elseif spellId == 320102 then
		warnBloodandGlory:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnBloodandGlory:Show()
			specWarnBloodandGlory:Play("targetyou")
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 309991 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 325863 and self:AntiSpam(10, 1) then--Might of Maldraxxus
		self.vb.MightCount = 0
		specWarnMightofMaldraxxus:Show()
		specWarnMightofMaldraxxus:Play("watchstep")
		timerMightofMaldraxxusCD:Start()
	end
end
