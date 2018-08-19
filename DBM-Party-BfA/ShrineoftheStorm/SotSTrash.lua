local mod	= DBM:NewMod("SotSTrash", "DBM-Party-BfA", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 268030 267973 268391 268239 268214 268309",
	"SPELL_AURA_APPLIED 268375 268322"
--	"SPELL_CAST_SUCCESS"
)

--TODO, still missing that buff on ground from trash
--TODO, Colossal Slam-268348? START
--TODO, Tempest-274437-npc:139800 target scan (START)
--TODO, tank defensive/kite warning for "Lesser Blessing of Ironsides-274631-npc:139799 ?
--Find slicing hurricane
--add enforcers deep slash (watch step)
--local warnSoulEchoes				= mod:NewTargetAnnounce(194966, 2)

--local yellArrowBarrage				= mod:NewYell(200343)
local specWarnWashAway				= mod:NewSpecialWarningDodge(267973, nil, nil, nil, 2, 2)
local specWarnMentalAssault			= mod:NewSpecialWarningDodge(268391, nil, nil, nil, 1, 2)
local specWarnShipbreakerStorm		= mod:NewSpecialWarningSpell(268239, nil, nil, nil, 2, 2)--Can be interrupted by stuns, but not interrupts
local specWarnDetectThoughts		= mod:NewSpecialWarningDispel(268375, "MagicDispeller", nil, nil, 1, 2)
local specWarnTouchofDrowned		= mod:NewSpecialWarningDispel(268375, "Healer", nil, nil, 1, 2)
local specWarnMendingRapids			= mod:NewSpecialWarningInterrupt(268030, "HasInterrupt", nil, nil, 1, 2)
local specWarnUnendingDarkness		= mod:NewSpecialWarningInterrupt(268309, "HasInterrupt", nil, nil, 1, 2)
local specWarnCarveFlesh			= mod:NewSpecialWarningDodge(268214, nil, nil, nil, 2, 2)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 268030 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnMendingRapids:Show(args.sourceName)
		specWarnMendingRapids:Play("kickcast")
	elseif spellId == 268309 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnUnendingDarkness:Show(args.sourceName)
		specWarnUnendingDarkness:Play("kickcast")
	elseif spellId == 267973 and self:AntiSpam(5, 1) then
		specWarnWashAway:Show()
		specWarnWashAway:Play("watchstep")
	elseif spellId == 268391 and self:AntiSpam(4, 2) then
		specWarnMentalAssault:Show()
		specWarnMentalAssault:Play("shockwave")
	elseif spellId == 268239 and self:AntiSpam(5, 4) then
		specWarnShipbreakerStorm:Show()
		specWarnShipbreakerStorm:Play("aesoon")
	elseif spellId == 268214 and self:AntiSpam(4, 5) then
		specWarnCarveFlesh:Show()
		specWarnCarveFlesh:Play("findshelter")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 268375 and self:AntiSpam(2, args.destName) then
		specWarnDetectThoughts:Show(args.destName)
		specWarnDetectThoughts:Play("helpdispel")
	elseif spellId == 268322 and self:AntiSpam(2, 3) then
		specWarnTouchofDrowned:Show(args.destName)
		specWarnTouchofDrowned:Play("helpdispel")
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
