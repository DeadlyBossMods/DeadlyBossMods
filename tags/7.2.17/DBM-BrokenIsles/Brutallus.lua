local wowTOC, testBuild = DBM:GetTOC()
if not testBuild and wowTOC < 70200 then return end
local mod	= DBM:NewMod(1883, "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(117239)
--mod:SetEncounterID(1880)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 233484 233566",
	"SPELL_CAST_SUCCESS 233515"
)

--NOTE, rupture and Embers can target scan but only give 1 of multiple targets, so for time being it's being omitted
local specWarnMeteorSlash		= mod:NewSpecialWarningSpell(233484, nil, nil, nil, 2, 2)
local specWarnCrashingEmbers	= mod:NewSpecialWarningDodge(233515, nil, nil, nil, 2, 2)
local specWarnRupture			= mod:NewSpecialWarningDodge(233566, nil, nil, nil, 2, 2)

local timerMeteorSlashCD		= mod:NewCDTimer(18.3, 233484, nil, nil, nil, 5)--18.3-19.6 (might also be 17.2)
local timerCrashingEmbersCD		= mod:NewCDTimer(17.2, 233515, nil, nil, nil, 3)--17.2-19.6
local timerRuptureCD			= mod:NewCDTimer(18.3, 233566, nil, nil, nil, 3)--18.3-19.6 (might also be 17.2)

local voiceMeteorSlash			= mod:NewVoice(233484)--gathershare
local voiceCrashingEmbers		= mod:NewVoice(233515)--watchstep
local voiceRupture				= mod:NewVoice(233566)--watchstep

--mod:AddReadyCheckOption(37460, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 233484 then
		specWarnMeteorSlash:Show()
		voiceMeteorSlash:Play("gathershare")
		timerMeteorSlashCD:Start()
	elseif spellId == 233566 then
		specWarnRupture:Show()
		voiceRupture:Play("watchstep")
		timerRuptureCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 233515 then
		specWarnCrashingEmbers:Show()
		voiceCrashingEmbers:Play("watchstep")
		timerCrashingEmbersCD:Start()
	end
end
