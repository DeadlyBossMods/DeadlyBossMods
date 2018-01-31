local mod	= DBM:NewMod("TrialofValorTrash", "DBM-TrialofValor")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 228845 228371 228395"
)

local specWarnShatterboneShield		= mod:NewSpecialWarningReflect(228845, nil, nil, nil, 1, 2)
local specWarnBreathOfDread			= mod:NewSpecialWarningMove(228371, nil, nil, nil, 1, 2)
local specWarnBindSpirit			= mod:NewSpecialWarningDispel(228395, "MagicDispeller", nil, nil, 1, 2)

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 228845 and self:AntiSpam(3, 1) then
		specWarnShatterboneShield:Show(args.destName)
		specWarnShatterboneShield:Play("stopattack")
	elseif spellId == 228371 and args:IsPlayer() and self:AntiSpam(2.5, 1) then
		specWarnBreathOfDread:Show(args.destName)
		specWarnBreathOfDread:Play("runaway")
	elseif spellId == 228395 and self:AntiSpam(2.5, 2) then
		specWarnBindSpirit:Show(args.destName)
		specWarnBindSpirit:Play("dispelnow")
	end
end
