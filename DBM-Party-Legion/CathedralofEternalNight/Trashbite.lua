local mod	= DBM:NewMod(1906, "DBM-Party-Legion", 12, 900)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(91005)
--mod:SetEncounterID(1792)
mod:SetZone()

mod:RegisterCombat("combat")

--[[
mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnFixate					= mod:NewTargetAnnounce(209906, 2, nil, false)

local specWarnAdds					= mod:NewSpecialWarningSwitch(199817, "Dps", nil, nil, 1, 2)

local timerSpikedTongueCD			= mod:NewNextTimer(55, 199176, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_TANK_ICON)

local voiceAdds						= mod:NewVoice(199817, "Dps")--mobsoon

--mod:AddRangeFrameOption(5, 153396)

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 209906 then

	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 199176 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 188494 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnRancidMaw:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 199817 then

	end
end

--]]