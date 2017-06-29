local mod	= DBM:NewMod("SoTTrash", "DBM-Party-Legion", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

--[[
mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warnTorment				= mod:NewTargetAnnounce(202615, 3)

local specWarnUnleashedFury		= mod:NewSpecialWarningSpell(196799, nil, nil, nil, 1, 2)
local specWarnNightmares		= mod:NewSpecialWarningInterrupt(193069, "HasInterrupt", nil, nil, 1, 2)
local yellNightmares			= mod:NewYell(193069)

local voiceUnleashedFury		= mod:NewVoice(196799)--aesoon
local voiceNightmares			= mod:NewVoice(193069, "HasInterrupt")--kickcast

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 196799 then

	elseif spellId == 193069 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnNightmares:Show(args.sourceName)
		voiceNightmares:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 202615 then

	end
end

--]]