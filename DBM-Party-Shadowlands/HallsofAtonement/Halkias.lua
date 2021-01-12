local mod	= DBM:NewMod(2406, "DBM-Party-Shadowlands", 4, 1185)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(165408)
mod:SetEncounterID(2401)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 322936 322711",
	"SPELL_CAST_SUCCESS 322943",
	"SPELL_AURA_APPLIED 322977",
	"SPELL_PERIODIC_DAMAGE 323001",
	"SPELL_PERIODIC_MISSED 323001"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Target scan Heave Debris? it's instant cast, maybe it has an emote?
--Sinlight visions deleted?
--Not entirely convinced refracted sinlight is a timer (and not health based)
--[[
(ability.id = 322936 or ability.id = 322711 or ability.id = 322977) and type = "begincast"
 or (ability.id = 322943) and type = "cast"
 or ability.id = 322977 and type = "applydebuff"
--]]
local warnHeaveDebris				= mod:NewSpellAnnounce(322943, 3)

local specWarnCrumblingSlam			= mod:NewSpecialWarningMove(322936, "Tank", nil, nil, 1, 2)
local specWarnRefractedSinlight		= mod:NewSpecialWarningDodge(322711, nil, nil, nil, 3, 2)
local specWarnSinlightVisions		= mod:NewSpecialWarningDispel(322977, "RemoveMagic", nil, nil, 1, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(323001, nil, nil, nil, 1, 8)

local timerCrumblingSlamCD			= mod:NewCDTimer(12.1, 322936, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)--12.1 except after refracted sinlight
local timerHeaveDebrisCD			= mod:NewCDTimer(12.1, 322943, nil, nil, nil, 3)--12.1 except after refracted sinlight
local timerRefractedSinlightD		= mod:NewCDTimer(45, 322711, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)--45--51
--local timerSinlightVisionsCD		= mod:NewCDTimer(23, 322977, nil, nil, nil, 3, nil, DBM_CORE_L.MAGIC_ICON)--23-27

--"Sinlight Visions-339237-npc:165408 = pull:5.0, 5.0, 20.0, 5.0, 15.0, 20.0

function mod:OnCombatStart(delay)
	timerCrumblingSlamCD:Start(4-delay)
--	timerSinlightVisionsCD:Start(5-delay)--SUCCESS
	timerHeaveDebrisCD:Start(14.6-delay)--SUCCESS
	timerRefractedSinlightD:Start(29.6-delay)--Iffy
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 322936 then
		specWarnCrumblingSlam:Show()
		specWarnCrumblingSlam:Play("moveboss")
--		timerCrumblingSlamCD:Start()
	elseif spellId == 322711 then
		specWarnRefractedSinlight:Show()
		specWarnRefractedSinlight:Play("watchstep")
		timerRefractedSinlightD:Start()
		timerCrumblingSlamCD:Stop()
		timerHeaveDebrisCD:Stop()
		timerHeaveDebrisCD:Start(17)
		timerCrumblingSlamCD:Start(22)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 322943 then
		warnHeaveDebris:Show()
		timerHeaveDebrisCD:Start()
--	elseif spellId == 322977 then
		--timerSinlightVisionsCD:Start()--Unknown, pull too short
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 322977 then
		specWarnSinlightVisions:Show(args.destName)
		specWarnSinlightVisions:Play("helpdispel")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 323001 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
