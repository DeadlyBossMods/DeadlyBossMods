local mod	= DBM:NewMod("TrialofValorTrash", "DBM-TrialofValor")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 228845"
)

local specWarnShatterboneShield		= mod:NewSpecialWarningReflect(228845, nil, nil, nil, 1, 2)

local voiceShatterboneShield		= mod:NewVoice(228845)--stopattack

mod:RemoveOption("HealthFrame")

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 228845 and self:AntiSpam(3, 1) then
		specWarnShatterboneShield:Show(args.destName)
		voiceShatterboneShield:Play("stopattack")
	end
end
