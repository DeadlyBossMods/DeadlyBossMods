local mod	= DBM:NewMod("z2682", "DBM-Delves-WarWithin")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")

mod:RegisterCombat("scenario", 2682)

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START ",
--	"SPELL_CAST_SUCCESS",
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"UNIT_DIED",
	"ENCOUNTER_START",
	"ENCOUNTER_END"
)

--local warnDrones							= mod:NewSpellAnnounce(449072, 2)

--local specWarnFearfulShriek				= mod:NewSpecialWarningDodge(433410, nil, nil, nil, 2, 2)

--local timerShadowsofStrifeCD				= mod:NewCDNPTimer(12.4, 449318, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
--local timerBurrowingTremorsCD				= mod:NewCDTimer(31.5, 448644, nil, nil, nil, 5)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc, 7 off interrupt

--[[
function mod:SPELL_CAST_START(args)
	if args.spellId == 449318 then

	end
end
--]]

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 138680 then

	end
end
--]]

--[[
function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 1098 then

	end
end
--]]

--[[
function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 1098 then

	end
end
--]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 138561 and destGUID == UnitGUID("player") and self:AntiSpam() then

	end
end
--]]

--[[
function mod:UNIT_DIED(args)
	--if args.destGUID == UnitGUID("player") then--Solo scenario, a player death is a wipe

	--end
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 208242 then
	end
end
--]]

function mod:ENCOUNTER_START(eID)
	if eID == 2985 or eID == 2987 then--Zekvir
		--Start some timers
	end
end

function mod:ENCOUNTER_END(eID, _, _, _, success)
	if eID == 2985 or eID == 2987 then--Zekvir
		if success then
			DBM:EndCombat(self)
		else
			--Stop Timers manually
		end
	end
end
