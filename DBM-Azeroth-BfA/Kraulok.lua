local mod	= DBM:NewMod(2210, "DBM-Azeroth-BfA", nil, 1028)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(138794)
--mod:SetEncounterID(1880)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 275175 275200 276046",
	"SPELL_AURA_REMOVED 275200"
)

--TODO: Can Sonic Bellow be dodged by tank?
--TODO: Which script is right script for Earth spike.
local warnPrimalRage				= mod:NewSpellAnnounce(275200, 3)

local specWarnSonicBellow			= mod:NewSpecialWarningDodge(275175, nil, nil, nil, 2, 2)
local specWarnShakeLoose			= mod:NewSpecialWarningSwitch(276046, nil, nil, nil, 1, 2)
--local specWarnClutch				= mod:NewSpecialWarningYou(261509, nil, nil, nil, 1, 2)
--local yellClutch					= mod:NewYell(261509)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

local timerSonicBellowCD				= mod:NewAITimer(16, 275175, nil, nil, nil, 3)
--local timerEarthSpikeCD				= mod:NewAITimer(16, 275194, nil, nil, nil, 3)
local timerShakeLooseCD					= mod:NewAITimer(16, 276046, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)

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
		timerSonicBellowCD:Start()
	elseif spellId == 275200 then
		warnPrimalRage:Show()
		timerSonicBellowCD:Stop()
		--timerEarthSpikeCD:Stop()
		timerSonicBellowCD:Start(2)
		--timerEarthSpikeCD:Start(2)
	elseif spellId == 276046 then
		specWarnShakeLoose:Show()
		specWarnShakeLoose:Play("killmob")
		timerShakeLooseCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 275200 then--Primal Rage
		timerSonicBellowCD:Stop()
		--timerEarthSpikeCD:Stop()
		timerSonicBellowCD:Start(3)
		--timerEarthSpikeCD:Start(3)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then
		
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
