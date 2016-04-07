local mod	= DBM:NewMod(1686, "DBM-Party-Legion", 9, 777)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(101950)
mod:SetEncounterID(1846)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 201146",
	"SPELL_CAST_START 201920 201153 201148"
)

--TODO< review timers for hysteria and Doom later, right now they are all over place and unreliable
local warnShadowCrash				= mod:NewSpellAnnounce(201920, 3)

local specWarnDoom					= mod:NewSpecialWarningDefensive(201148, "Tank", nil, nil, 1, 2)
local specWarnHysteria				= mod:NewSpecialWarningDispel(201146, "Healer", nil, nil, 1, 2)
local specWarnEternalDarkness		= mod:NewSpecialWarningSwitch(201153, "-Healer", nil, nil, 3, 2)

local timerShadowCrashCD			= mod:NewCDTimer(12, 201920, nil, nil, nil, 3)
local timerEternalDarknessCD		= mod:NewCDTimer(37.5, 201153, nil, nil, nil, 1)

local voiceDoom						= mod:NewVoice(201148, "Tank")--defensive
local voiceHysteria					= mod:NewVoice(201146, "Healer")--dispelnow
local voiceEternalDarkness			= mod:NewVoice(201146, "-Healer")--mobkill

function mod:OnCombatStart(delay)
	timerEternalDarknessCD:Start(30-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 201146 then
		specWarnHysteria:Show(args.destName)
		voiceHysteria:Play("dispelnow")
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 201920 then
		warnShadowCrash:Show()
		timerShadowCrashCD:Start()
	elseif spellId == 201153 then
		specWarnEternalDarkness:Show()
		voiceEternalDarkness:Play("mobkill")
		timerEternalDarknessCD:Start()
	elseif spellId == 201148 then
		specWarnDoom:Show()
		voiceDoom:Play("defensive")
	end
end
