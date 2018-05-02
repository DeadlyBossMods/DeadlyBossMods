local mod	= DBM:NewMod("TolDagorTrash", "DBM-Party-BfA", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 259711",
	"SPELL_AURA_APPLIED 258153"
--	"SPELL_CAST_SUCCESS"
)

--TODO? http://bfa.wowhead.com/spell=258634/fuselighter (trash version not boss)
--TODO? warn if http://bfa.wowhead.com/spell=258313/handcuff is healer or tank?
--local warnSoulEchoes				= mod:NewTargetAnnounce(194966, 2)

--local yellArrowBarrage				= mod:NewYell(200343)
local specWarnLockdown				= mod:NewSpecialWarningDodge(259711, nil, nil, nil, 2, 2)
local specWarnWateryDome			= mod:NewSpecialWarningDispel(258153, "MagicDispeller", nil, nil, 1, 2)
--local specWarnDarkMending			= mod:NewSpecialWarningInterrupt(225573, "HasInterrupt", nil, nil, 1, 2)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 259711 then
		specWarnLockdown:Show()
		specWarnLockdown:Play("watchstep")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 258153 and self:AntiSpam(5, 1) then
		specWarnWateryDome:Show(args.destName)
		specWarnWateryDome:Play("helpdispel")
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 200343 then

	end
end
--]]
