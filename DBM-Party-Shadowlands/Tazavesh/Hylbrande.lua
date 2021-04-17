local mod	= DBM:NewMod(2448, "DBM-Party-Shadowlands", 9, 1194)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(162689)
mod:SetEncounterID(2426)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START",
--	"SPELL_CAST_SUCCESS",
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--local warnSummonCreation			= mod:NewSpellAnnounce(320358, 2)

--local specWarnEmbalmingIchor		= mod:NewSpecialWarningMoveAway(327664, nil, nil, nil, 1, 2)
--local yellEmbalmingIchor			= mod:NewYell(327664)
--local specWarnHealingBalm			= mod:NewSpecialWarningInterrupt(257397, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(320366, nil, nil, nil, 1, 8)

--local timerMutilateCD				= mod:NewCDTimer(11, 320376, nil, nil, nil, 3)
--local timerStichNeedleCD			= mod:NewCDTimer(15.8, 320200, nil, nil, nil, 5, nil, DBM_CORE_L.HEALER_ICON)--Basically spammed

function mod:OnCombatStart(delay)

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 320358 then

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 320359 then
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 320200 then

	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 322681 then

	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 320366 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 164578 then

	end
end


function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
