local mod	= DBM:NewMod("NerubarPalaceTrash", "DBM-Raids-WarWithin", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod.isTrashMod = true

mod:RegisterEvents(
--	"SPELL_CAST_START",
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
--	"CHAT_MSG_MONSTER_YELL"
)

--local warnShadowflameBomb					= mod:NewTargetAnnounce(425300, 3)

--local specWarnShadowflameBomb				= mod:NewSpecialWarningMoveAway(425300, nil, nil, nil, 1, 2)
--local yellShadowflameBomb					= mod:NewYell(425300)
--local yellShadowflameBombFades			= mod:NewShortFadesYell(425300)
--local specWarnTranquility					= mod:NewSpecialWarningInterrupt(425995, "HasInterrupt", nil, nil, 1, 2)

--local timerFeatherBombCD					= mod:NewAITimer(22.9, 428765, nil, nil, nil, 3)

--local playerName = UnitName("player")

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc
--[[
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 425062 and self:AntiSpam(5, 1) then

	end
end
--]]

--[[
function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 428765 then

--	elseif spellId == 425381 and self:CheckInterruptFilter(args.sourceGUID, false, true) then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
--]]

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 428765 then

	end
end
--]]