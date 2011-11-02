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
local specWarnFadingLight			= mod:NewSpecialWarningYou(110080)

local timerHourofTwilightCD			= mod:NewNextTimer(45, 109416)
local timerTwilightEruptionCD		= mod:NewNextTimer(360, 106388)--Berserk timer more or less.
local timerTwilightEruption			= mod:NewCastTimer(5, 106388)
local timerFadingLightCD			= mod:NewNextTimer(10, 109416)

local fadingLightCount = 0

function mod:OnCombatStart(delay)
	fadingLightCount = 0
	timerTwilightEruptionCD:Start(-delay)
	timerHourofTwilightCD:Start(-delay)
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(106371, 109415, 109416, 109417) then
		fadingLightCount = 0
		specWarnHourofTwilight:Show()
		timerHourofTwilightCD:Start()
	elseif args:IsSpellID(106388) then
		specWarnTwilightEruption:Show()
		timerTwilightEruption:Start()
	end
end


function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(106371, 109415, 109416, 109417) then
		timerFadingLightCD:Start()--Start first fading light Cd here when buff is actually gained, that way we don't have to account for normal/heroic having variable cast lengths in SPELL_CAST_START event
	elseif args:IsSpellID(110068, 110069, 110078, 110079) then--Damage taken IDs, tank specific debuffs.
		fadingLightCount = fadingLightCount + 1
		if fadingLightCount < 3 then--It's cast 3 times during hour of twilight buff duration on ultraxion. 20 secomds remaining, 10 seconds remaining, and at 0 seconds remainings.
			timerFadingLightCD:Start()
		end
		if args:IsPlayer() then
			specWarnFadingLight:Show()
		end
	elseif args:IsSpellID(105925, 109075, 110070, 110080) then--Damage done IDs, dps/healer debuffs
		if args:IsPlayer() then
			specWarnFadingLight:Show()
		end	
	end
end
