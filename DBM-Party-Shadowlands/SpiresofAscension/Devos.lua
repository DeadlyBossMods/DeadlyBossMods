local mod	= DBM:NewMod(2412, "DBM-Party-Shadowlands", 5, 1186)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(126983)
mod:SetEncounterID(2359)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 322818 323013",
	"SPELL_AURA_REMOVED 323013",
	"SPELL_CAST_START 322814 322999",
	"SPELL_CAST_SUCCESS 322818",
	"SPELL_PERIODIC_DAMAGE 322817",
	"SPELL_PERIODIC_MISSED 322817"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, seed of doubt target scan? it's a .333 second cast
--TODO, finish phase 2 and phase 3 stuff
--Stage 1
local warnSeedofDoubt				= mod:NewSpellAnnounce(322814, 4)
local warnLingeringDoubt			= mod:NewTargetNoFilterAnnounce(322818, 2)
--Stage 2
local warnAnimaShield				= mod:NewTargetNoFilterAnnounce(323013, 3)

--Stage 1
local specWarnLingeringDoubt		= mod:NewSpecialWarningMoveAway(322818, nil, nil, nil, 1, 2)
local yellLingeringDoubt			= mod:NewYell(322818)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(322817, nil, nil, nil, 1, 8)
--Stage 2
local specWarnActivate				= mod:NewSpecialWarningSpell(322999, nil, nil, nil, 2, 2)

--Stage 1
local timerSeedofDoubtCD			= mod:NewAITimer(15.8, 322814, nil, nil, nil, 3)
local timerLingeringDoubtCD			= mod:NewAITimer(13, 322818, nil, nil, nil, 3, nil, DBM_CORE_Translations.MAGIC_ICON..DBM_CORE_Translations.HEALER_ICON)
--Stage 2

mod:AddInfoFrameOption(323013, true)

function mod:OnCombatStart(delay)
	timerSeedofDoubtCD:Start(1-delay)
	timerLingeringDoubtCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 322814 then
		warnSeedofDoubt:Show()
		timerSeedofDoubtCD:Start()
	elseif spellId == 322999 then--Stage 2
		specWarnActivate:Show()
		specWarnActivate:Play("phasechange")
		timerSeedofDoubtCD:Stop()
		timerLingeringDoubtCD:Stop()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 322818 then
		timerLingeringDoubtCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 322818 then
		if args:IsPlayer() then
			specWarnLingeringDoubt:Show()
			specWarnLingeringDoubt:Play("runout")
			yellLingeringDoubt:Yell()
		else
			warnLingeringDoubt:Show(args.destName)
		end
	elseif spellId == 323013 then
		warnAnimaShield:Show(args.destName)
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, "boss1")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 323013 then
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 322817 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
