local mod	= DBM:NewMod(1878, "DBM-Party-Legion", 12, 900)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(91003)
--mod:SetEncounterID(1790)
mod:SetZone()

mod:RegisterCombat("combat")

--[[
mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED"
)

local warnShatter					= mod:NewSpellAnnounce(188114, 2)

local specWarnRazorShards			= mod:NewSpecialWarningSpell(188169, "Tank", nil, nil, 1, 2)

local timerShatterCD				= mod:NewCDTimer(24.2, 188114, nil, nil, nil, 2)

local voiceRazorShards				= mod:NewVoice(188169, "Tank")--shockwave

function mod:OnCombatStart(delay)

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 188169 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 192800 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 1) then
		specWarnGas:Show()
		voiceGas:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--]]