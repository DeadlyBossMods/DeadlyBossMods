local mod	= DBM:NewMod("z2664", "DBM-Delves-WarWithin")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")

mod:RegisterCombat("scenario", 2664)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 415492 415406 425315",
--	"SPELL_CAST_SUCCESS",
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"UNIT_DIED",
	"ENCOUNTER_START",
	"ENCOUNTER_END"
)

local warnFungalCharge						= mod:NewSpellAnnounce(415492, 2)

local specWarnFungalStorm					= mod:NewSpecialWarningRun(415406, nil, nil, nil, 4, 2)--MoveTo if I confirm the mushrooms do in fact stun/stop it
local specWarnFungsplosion					= mod:NewSpecialWarningDodge(425319, nil, nil, nil, 2, 2)

local timerFungalChargeCD					= mod:NewCDTimer(29.9, 415492, nil, nil, nil, 5)
local timerFungalStormCD					= mod:NewCDTimer(30.3, 415406, nil, nil, nil, 3)
local timerFungsplosionCD					= mod:NewCDTimer(30.3, 425319, nil, nil, nil, 3)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc, 7 off interrupt

--local Mushrooms = DBM:GetSpellName(415495)

function mod:SPELL_CAST_START(args)
	if args.spellId == 415492 then
		warnFungalCharge:Show()
		timerFungalChargeCD:Start()
	elseif args.spellId == 415406 then
		specWarnFungalStorm:Show()
		specWarnFungalStorm:Play("whirlwind")
		timerFungalStormCD:Start()
	elseif args.spellId == 425315 then
		specWarnFungsplosion:Show()
		specWarnFungsplosion:Play("watchstep")
		timerFungsplosionCD:Start()
	end
end

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
	if eID == 2831 then--Spinshroom
		--Start some timers
		timerFungalStormCD:Start(5.8)
		timerFungalChargeCD:Start(20.3)
		timerFungsplosionCD:Start(26.4)
	end
end

function mod:ENCOUNTER_END(eID, _, _, _, success)
	if eID == 2831 then--Spinshroom
		if success then
			DBM:EndCombat(self)
		else
			--Stop Timers manually
			timerFungalStormCD:Stop()
			timerFungalChargeCD:Stop()
			timerFungsplosionCD:Stop()
		end
	end
end
