local mod	= DBM:NewMod(2210, "DBM-Azeroth-BfA", 2, 1028)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(138794)
--mod:SetEncounterID(1880)
mod:SetReCombatTime(20)
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 275175 275200 276046",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--TODO: Which script is right script for Earth spike.
local warnPrimalRage				= mod:NewSpellAnnounce(275200, 3)
local warnShakeLoose				= mod:NewSpellAnnounce(276046, 3)

local specWarnSonicBellow			= mod:NewSpecialWarningDodge(275175, nil, nil, nil, 2, 2)
local specWarnEarthSpike			= mod:NewSpecialWarningDodge(275194, nil, nil, nil, 2, 2)

local timerPrimalRageCD					= mod:NewCDTimer(32.7, 275200, nil, nil, nil, 3)
local timerShakeLooseCD					= mod:NewCDTimer(28, 276046, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)--28 seconds, but does it an extra time when he's really low

mod:AddRangeFrameOption(5, 275194)
--mod:AddReadyCheckOption(37460, false)

function mod:OnCombatStart(_, yellTriggered)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 275175 then
		specWarnSonicBellow:Show()
		specWarnSonicBellow:Play("shockwave")
	elseif spellId == 275200 then
		warnPrimalRage:Show()
		timerPrimalRageCD:Start()
	elseif spellId == 276046 then
		warnShakeLoose:Show()
		timerShakeLooseCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, spellId)
	if spellId == 275194 and self:AntiSpam(4, 1) then
		specWarnEarthSpike:Show()
		specWarnEarthSpike:Play("watchstep")
	end
end
