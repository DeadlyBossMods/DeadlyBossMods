local mod	= DBM:NewMod(1687, "DBM-Party-Legion", 5, 767)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91007)
mod:SetEncounterID(1793)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 200732 200551 200637 200700",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnCrystalSpikes				= mod:NewSpellAnnounce(200551, 2)

local specWarnMoltenCrash			= mod:NewSpecialWarningSpell(200732, "Tank", nil, nil, 3, 2)
local specWarnLandSlide				= mod:NewSpecialWarningSpell(200700, "Tank", nil, nil, 1, 2)
local specWarnMagmaSculptor			= mod:NewSpecialWarningSwitch(200637, "Dps", nil, nil, 1, 2)
local specWarnMagmaWave				= mod:NewSpecialWarningMoveTo(200637, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(200637), nil, 2, 2)

local timerMoltenCrashCD			= mod:NewCDTimer(16.5, 200732, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--16.5-23
local timerLandSlideCD				= mod:NewCDTimer(16.5, 200700, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--16.5-27
local timerCrystalSpikesCD			= mod:NewCDTimer(21.4, 200551, nil, nil, nil, 3)
local timerMagmaSculptorCD			= mod:NewCDTimer(71, 200551, nil, nil, nil, 1)--Everyone?
local timerMagmaWaveCD				= mod:NewNextTimer(60, 200637, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)

local voiceMoltenCrash				= mod:NewVoice(200732, "Tank")--defensive
local voiceLandSlide				= mod:NewVoice(200700, "Tank")--shockwave
local voiceMagmaSculptor			= mod:NewVoice(200732, "Dps")--killbigmob
local voiceMagmaWave				= mod:NewVoice(200637)--findshelter

function mod:OnCombatStart(delay)
	timerMagmaSculptorCD:Start(7.5-delay)
	timerLandSlideCD:Start(16-delay)
	timerMoltenCrashCD:Start(20-delay)
	timerCrystalSpikesCD:Start(22.2-delay)
	timerMagmaWaveCD:Start(61-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 200732 then
		specWarnMoltenCrash:Show()
		voiceMoltenCrash:Play("defensive")
		timerMoltenCrashCD:Start()
	elseif spellId == 200551 then
		warnCrystalSpikes:Show()
		timerCrystalSpikesCD:Start()
	elseif spellId == 200637 then
		specWarnMagmaSculptor:Show()
		voiceMagmaSculptor:Play("killbigmob")
		timerMagmaSculptorCD:Start()
	elseif spellId == 200700 then
		specWarnLandSlide:Show()
		voiceLandSlide:Play("shockwave")
		timerLandSlideCD:Start()
	end
end

local spikeName = GetSpellInfo(200551)
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 200418 then--Magma Wave (1 second faster than combat log)
		specWarnMagmaWave:Show(spikeName)
		voiceMagmaWave:Play("findshelter")
		timerMagmaWaveCD:Start()
	end
end
