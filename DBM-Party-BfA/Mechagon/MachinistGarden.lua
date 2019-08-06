local mod	= DBM:NewMod(2348, "DBM-Party-BfA", 11, 1178)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(144248)--Head Mechinist Sparkflux
mod:SetEncounterID(2259)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 285440",
	"SPELL_CAST_SUCCESS 285454",
	"SPELL_AURA_APPLIED 285460",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, can bomb be target scanned?
--TODO, do more with plants and oil and stuff?
--TODO, if plant warning works, localize it to something more friendly
--TODO, add Blossom Blast if it's not spammy
--[[
ability.id = 285440 and type = "begincast"
 or (ability.id = 285454 or ability.id = 294855) and type = "cast"
--]]
local warnDiscomBomb				= mod:NewSpellAnnounce(285454, 2)
local warnSelfTrimmingHedge			= mod:NewSpellAnnounce(294954, 2)
local warnPlant						= mod:NewSpellAnnounce(294853, 2)

local specWarnFlameCannon			= mod:NewSpecialWarningSpell(285440, nil, nil, nil, 2, 2)
local specWarnDiscomBomb			= mod:NewSpecialWarningDispel(285460, "RemoveMagic", nil, nil, 2, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

local timerDiscomBombCD				= mod:NewNextTimer(18.2, 285454, nil, nil, nil, 3)
local timerFlameCannonCD			= mod:NewCDTimer(47.4, 285440, nil, nil, nil, 2)
local timerSelfTrimmingHedgeCD		= mod:NewCDTimer(25.5, 294954, nil, nil, nil, 3)
local timerPlantCD					= mod:NewCDTimer(46, 294853, nil, nil, nil, 1)

function mod:OnCombatStart(delay)
	timerSelfTrimmingHedgeCD:Start(3.4-delay)
	timerPlantCD:Start(5.9-delay)
	timerDiscomBombCD:Start(8.3-delay)
	timerFlameCannonCD:Start(13.1-delay)
end

--function mod:OnCombatEnd()

--end

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
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 285460 and self:CheckDispelFilter() then
		specWarnDiscomBomb:Show(args.destName)
		specWarnDiscomBomb:Play("helpdispel")
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
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 294853 then--Activate Plant
		warnPlant:Show()
		timerPlantCD:Start()
	elseif spellId == 292332 then--Self-Trimming Hedge
		warnSelfTrimmingHedge:Show()
		timerSelfTrimmingHedgeCD:Start()
	end
end
