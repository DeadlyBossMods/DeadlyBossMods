local mod	= DBM:NewMod(1139, "DBM-Party-WoD", 6, 537)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(75509)
mod:SetEncounterID(1677)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 153240 153153 164974"
)

local warnDaggerFall			= mod:NewSpellAnnounce(153240, 3)
local warnDarkCommunion			= mod:NewSpellAnnounce(153153, 4)
local warnDarkEclipse			= mod:NewSpellAnnounce(164974, 4)

local specWarnDarkCommunion		= mod:NewSpecialWarningSwitch(153153, not mod:IsHealer())--On Test, even tank and healer needed to dps to kill it. I'm going to assume it's an overtuning and at least excempt healer.
local specWarnDarkEclipse		= mod:NewSpecialWarningSpell(164974, nil, nil, nil, 3)

local timerDarkCommunionCD		= mod:NewNextTimer(45.5, 153153)
local timerDarkEclipseCD		= mod:NewNextTimer(45.5, 164974)

local countdownDarkCommunion	= mod:NewCountdown(45.5, 153153)

function mod:OnCombatStart(delay)
	timerDarkCommunionCD:Start(15-delay)
	countdownDarkCommunion:Start(15-delay)
	timerDarkEclipseCD:Start(-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 153240 then
		warnDaggerFall:Show()
	elseif spellId == 153153 then
		warnDarkCommunion:Show()
		specWarnDarkCommunion:Show()
		timerDarkCommunionCD:Start()
		countdownDarkCommunion:Start()
	elseif spellId == 164974 then
		specWarnDarkEclipse:Show()
		specWarnDarkEclipse:Show()
		timerDarkEclipseCD:Start()
	end
end
