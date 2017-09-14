local mod	= DBM:NewMod("SoTTrash", "DBM-Party-Legion", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
--	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED 245510"
)

local warnCorruptingVoid			= mod:NewTargetAnnounce(245510, 3)

local specWarnCorruptingVoid		= mod:NewSpecialWarningYou(245510, nil, nil, nil, 1, 2)
local yellCorruptingVoid			= mod:NewYell(245510)
--local specWarnNightmares			= mod:NewSpecialWarningInterrupt(193069, "HasInterrupt", nil, nil, 1, 2)

local voiceCorruptingVoid			= mod:NewVoice(245510)--targetyou
--local voiceNightmares				= mod:NewVoice(193069, "HasInterrupt")--kickcast

mod:RemoveOption("HealthFrame")

--[[
function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 196799 then

	elseif spellId == 193069 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnNightmares:Show(args.sourceName)
		voiceNightmares:Play("kickcast")
	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 245510 and self:AntiSpam(3, args.destName) then
		if args:IsPlayer() then
			specWarnCorruptingVoid:Show()
			voiceCorruptingVoid:Play("targetyou")
			yellCorruptingVoid:Yell()
		else
			warnCorruptingVoid:Show(args.destName)
		end
	end
end
