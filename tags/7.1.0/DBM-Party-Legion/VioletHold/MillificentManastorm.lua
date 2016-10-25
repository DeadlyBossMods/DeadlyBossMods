local mod	= DBM:NewMod(1688, "DBM-Party-Legion", 9, 777)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(101976)
mod:SetEncounterID(1847)
mod:SetZone()

mod.imaspecialsnowflake = true

mod:RegisterCombat("combat")

--[[
mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"SPELL_SUMMON",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--local warnCurtainOfFlame			= mod:NewTargetAnnounce(153396, 4)

--local specWarnCurtainOfFlame		= mod:NewSpecialWarningMoveAway(153396)

--local timerCurtainOfFlameCD			= mod:NewNextTimer(20, 153396, nil, nil, nil, 3)

--local voiceCurtainOfFlame			= mod:NewVoice(153392)

--mod:AddRangeFrameOption(5, 153396)

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 153396 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 153392 then

	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 153392 then

	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 153764 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 153616 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then

	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 153500 then

	end
end
--]]