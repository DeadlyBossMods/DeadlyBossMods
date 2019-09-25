local mod	= DBM:NewMod(2210, "DBM-Azeroth-BfA", 2, 1028)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(138794)
--mod:SetEncounterID(1880)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 275175 275200 276046",
--	"SPELL_AURA_REMOVED 275200",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--TODO: Which script is right script for Earth spike.
local warnPrimalRage				= mod:NewSpellAnnounce(275200, 3)
local warnShakeLoose				= mod:NewSpellAnnounce(276046, 3)

local specWarnSonicBellow			= mod:NewSpecialWarningDodge(275175, nil, nil, nil, 2, 2)
local specWarnEarthSpike			= mod:NewSpecialWarningDodge(275194, nil, nil, nil, 2, 2)

--local timerSonicBellowCD				= mod:NewAITimer(16, 275175, nil, nil, nil, 3)--6-34?
--local timerEarthSpikeCD				= mod:NewAITimer(16, 275194, nil, nil, nil, 3)
local timerPrimalRageCD					= mod:NewCDTimer(32.7, 275200, nil, nil, nil, 3)
local timerShakeLooseCD					= mod:NewCDTimer(28, 276046, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)--28 seconds, but does it an extra time when he's really low

mod:AddRangeFrameOption(5, 275194)
--mod:AddReadyCheckOption(37460, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerSonicBellowCD:Start(1-delay)
		--timerEarthSpikeCD:Start(1-delay)
		--timerShakeLooseCD:Start(1-delay)
	end
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
		--timerSonicBellowCD:Start()
	elseif spellId == 275200 then
		warnPrimalRage:Show()
		timerPrimalRageCD:Start()
		--timerSonicBellowCD:Stop()
		--timerEarthSpikeCD:Stop()
		--timerSonicBellowCD:Start(5)
		--timerEarthSpikeCD:Start(2)
	elseif spellId == 276046 then
		warnShakeLoose:Show()
		timerShakeLooseCD:Start()
	end
end

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 275200 then--Primal Rage
		--timerSonicBellowCD:Stop()
		--timerEarthSpikeCD:Stop()
		--timerSonicBellowCD:Start(3)
		--timerEarthSpikeCD:Start(3)
	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 275194 and self:AntiSpam(4, 1) then
		specWarnEarthSpike:Show()
		specWarnEarthSpike:Play("watchstep")
	end
end
