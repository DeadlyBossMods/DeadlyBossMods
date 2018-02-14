local mod	= DBM:NewMod(2083, "DBM-Party-BfA", 1, 968)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(122963)
mod:SetEncounterID(2086)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 257407",
	"SPELL_CAST_START 255371 257407",
	"SPELL_CAST_SUCCESS 255434"
)

--TODO, relog fight, when logging fight doesn't cause client to crash, then use real timers not AI timers
--TODO, try to warn pursuit faster is possible
local warnPursuit				= mod:NewTargetAnnounce(257407, 2)

local specWarnTeeth				= mod:NewSpecialWarningDefensive(255434, "Tank", nil, nil, 1, 2)
local specWarnFear				= mod:NewSpecialWarningDodge(255371, nil, nil, nil, 3, 2)--Dodge warning on purpose, you dodge it by LOS behind pillar
local yellPursuit				= mod:NewYell(257407)
local specWarnPursuit			= mod:NewSpecialWarningRun(257407, nil, nil, nil, 4, 2)

local timerTeethCD				 mod:NewAITimer(13, 255434, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerFearCD				 mod:NewAITimer(13, 255371, nil, nil, nil, 2)
local timerPursuitCD			 mod:NewAITimer(13, 257407, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerTeethCD:Start(1)
	timerFearCD:Start(1)
	timerPursuitCD:Start(1)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 257407 then
		if args:IsPlayer() then
			specWarnPursuit:Show()
			specWarnPursuit:Play("justrun")
			yellPursuit:Yell()
		else
			warnPursuit:Show(args.destName)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 255371 then
		specWarnFear:Show()
		specWarnFear:Play("findshelter")
		timerFearCD:Start()
	elseif spellId == 257407 then
		timerPursuitCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 255434 then
		specWarnTeeth:Show()
		specWarnTeeth:Play("defensive")
		timerTeethCD:Start()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 257939 then
	end
end
--]]
