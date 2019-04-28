local mod	= DBM:NewMod(2348, "DBM-Party-BfA", 11, 1178)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(144248)--Head Mechinist Sparkflux
mod:SetEncounterID(2259)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START 285440",
	"SPELL_CAST_SUCCESS 285454 294954",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, can bomb be target scanned?
--TODO, do more with plants and oil and stuff?
--TODO, if plant warning works, localize it to something more friendly
local warnDiscomBomb				= mod:NewSpellAnnounce(285454, 2)
local warnSelfTrimmingHedge			= mod:NewSpellAnnounce(294954, 2)
local warnPlant						= mod:NewSpellAnnounce(294850, 2)

local specWarnFlameCannon			= mod:NewSpecialWarningSpell(285440, nil, nil, nil, 2, 2)
--local yellSwirlingScythe			= mod:NewYell(195254)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

local timerDiscomBombCD				= mod:NewAITimer(31.6, 285454, nil, nil, nil, 3)
local timerFlameCannonCD			= mod:NewAITimer(31.6, 285440, nil, nil, nil, 2)
local timerSelfTrimmingHedgeCD		= mod:NewAITimer(31.6, 294954, nil, nil, nil, 3)
local timerPlantCD					= mod:NewAITimer(31.6, 294850, nil, nil, nil, 1)

--mod:AddRangeFrameOption(5, 194966)

function mod:OnCombatStart(delay)
	timerDiscomBombCD:Start(1-delay)
	timerFlameCannonCD:Start(1-delay)
	timerSelfTrimmingHedgeCD:Start(1-delay)
	timerPlantCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 257777 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 257827 then

	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 285440 then
		specWarnFlameCannon:Show()
		specWarnFlameCannon:Play("aesoon")
		timerFlameCannonCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 285454 then
		warnDiscomBomb:Show()
		timerDiscomBombCD:Start()
	elseif spellId == 294954 then
		warnSelfTrimmingHedge:Show()
		timerSelfTrimmingHedgeCD:Start()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 294850 then--Incomspicous Plant
		warnPlant:Show()
		timerPlantCD:Start()
	end
end
