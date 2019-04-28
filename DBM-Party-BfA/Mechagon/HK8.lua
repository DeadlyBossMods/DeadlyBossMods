local mod	= DBM:NewMod(2355, "DBM-Party-BfA", 11, 1178)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(127484)--FIND CID
mod:SetEncounterID(2291)--VERIFY
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 294195 296080",
	"SPELL_AURA_REMOVED 296080",
	"SPELL_CAST_START 295536 296464 295445 296522 295939",
--	"SPELL_CAST_SUCCESS"
	"UNIT_DIED"
)

--TODO, can tank dodge wreck?
--TODO, additional warnings/timers for platform stuff?
--TODO, nameplate auras worth cpu usage of energy trackrs on Walkie Shockie x1?
--TODO, what CID is boss health/win for this fight?
local warnReinforcementRelay		= mod:NewSpellAnnounce(296464, 2)
local warnSelfDestruct				= mod:NewCastAnnounce(296522, 4)
local warnHaywire					= mod:NewTargetNoFilterAnnounce(296080, 1)

local specWarnCannonBlast			= mod:NewSpecialWarningDodge(295536, nil, nil, nil, 2, 2)
local specWarnWreck					= mod:NewSpecialWarningDefensive(295445, "Tank", nil, nil, 1, 2)
local specWarnArcingZap				= mod:NewSpecialWarningDispel(294195, "Healer", nil, nil, 1, 2)
local specWarnAnnihilationRay		= mod:NewSpecialWarningSpell(295939, nil, nil, nil, 2, 2)
--local specWarnHowlingFear			= mod:NewSpecialWarningInterrupt(257791, "HasInterrupt", nil, nil, 1, 2)
--local yellSwirlingScythe			= mod:NewYell(195254)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

local timerCannonBlastCD			= mod:NewAITimer(31.6, 295536, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerReinforcementRelayCD		= mod:NewAITimer(31.6, 296464, nil, nil, nil, 1)
local timerWreckCD					= mod:NewAITimer(31.6, 295445, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerAnnihilationRayCD		= mod:NewAITimer(31.6, 295939, nil, nil, nil, 6)
local timerHaywire					= mod:NewBuffActiveTimer(30, 296080, nil, nil, nil, 6)
--local timerHowlingFearCD			= mod:NewAITimer(13.4, 257791, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)

--mod:AddRangeFrameOption(5, 194966)

function mod:OnCombatStart(delay)
	timerCannonBlastCD:Start(1-delay)
	timerReinforcementRelayCD:Start(1-delay)
	timerAnnihilationRayCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 294195 then
		if self:CheckDispelFilter() then
			specWarnArcingZap:Show(args.destName)
			specWarnArcingZap:Play("helpdispel")
		end
	elseif spellId == 296080 then
		warnHaywire:Show(args.destName)
		timerHaywire:Start()
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 296080 then--Haywire
		timerHaywire:Stop()
		timerAnnihilationRayCD:Start(2)--Assumed
		timerReinforcementRelayCD:Start(2)--Assumed
		timerCannonBlastCD:Start(2)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 295536 then
		specWarnCannonBlast:Show()
		specWarnCannonBlast:Play("farfromline")
		timerCannonBlastCD:Start()
	elseif spellId == 296464 then
		warnReinforcementRelay:Show()
		timerReinforcementRelayCD:Start()
	elseif spellId == 295445 then
		specWarnWreck:Show()
		specWarnWreck:Play("defensive")
		timerWreckCD:Start(nil, args.sourceGUID)
	elseif spellId == 296522 then
		warnSelfDestruct:Show()
	elseif spellId == 295939 then
		specWarnAnnihilationRay:Show()
		specWarnAnnihilationRay:Play("phasechange")
		--timerAnnihilationRayCD:Start()
		timerReinforcementRelayCD:Stop()--Assumed
		timerCannonBlastCD:Stop()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 257777 then

	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 150295 then--tank-buster-mk1
		timerWreckCD:Stop(args.destGUID)
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
