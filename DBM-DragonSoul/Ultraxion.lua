if tonumber((select(2, GetBuildInfo()))) <= 14545 then return end

local mod	= DBM:NewMod(331, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(55294)
mod:SetModelID(39099)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local specWarnHourofTwilight		= mod:NewSpecialWarningSpell(109416, nil, nil, nil, true)
local specWarnTwilightEruption		= mod:NewSpecialWarningSpell(106388, nil, nil, nil, true)--Berserk, you have 5 seconds to finish off the boss ;)
--local specWarnFadingLightTaken	= mod:NewSpecialWarningYou(110069)--I just don't understand this mechanic, the writen guides suck balls, and it has so many versions of spell i just can't reliably warn for this without understanding it
--local specWarnFadingLightDone		= mod:NewSpecialWarningYou(110080)--If both special warnings end up being needed then generics won't be usuable do to having the same spell name(ie option name). Will have to use localized text.

local timerHourofTwilightCD			= mod:NewNextTimer(45, 109416)
local timerTwilightEruptionCD		= mod:NewNextTimer(360, 106388)--Berserk timer more or less.
local timerTwilightEruption			= mod:NewCastTimer(5, 106388)
--local timerFadingLight				= mod:NewBuffActiveTimer(10, 109416)--Maybe right? I don't even know, tooltips don't match anything i read about the fight.

function mod:OnCombatStart(delay)
	timerTwilightEruptionCD:Start(-delay)
	timerHourofTwilightCD:Start(-delay)
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(106371, 109415, 109416, 109417) then
		specWarnHourofTwilight:Show()
		timerHourofTwilightCD:Start()
	elseif args:IsSpellID(106388) then
		specWarnTwilightEruption:Show()
		timerTwilightEruption:Start()
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(110068, 110069, 110078, 110079) then
		if args:IsPlayer() then
			specWarnFadingLightTaken:Show()
			timerFadingLight:Show()
		end
	elseif args:IsSpellID(105925, 109075, 110070, 110080) then
		if args:IsPlayer() then
			specWarnFadingLightDone:Show()
			timerFadingLight:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(110068, 110069, 110078, 110079) then
		if args:IsPlayer() then
			timerFadingLight:Cancel()
		end
	elseif args:IsSpellID(105925, 109075, 110070, 110080) then
		if args:IsPlayer() then
			timerFadingLight:Cancel()
		end
	end
end
--]]