local mod	= DBM:NewMod(1139, "DBM-Party-WoD", 6, 537)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(75509)
mod:SetEncounterID(1677)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 153240 153153 164974",
	"SPELL_AURA_APPLIED 153094"
)

local warnDaggerFall			= mod:NewSpellAnnounce(153240, 3)
local warnWhispers				= mod:NewSpellAnnounce(153094, 2)
local warnDarkCommunion			= mod:NewSpellAnnounce(153153, 4)
local warnDarkEclipse			= mod:NewSpellAnnounce(164974, 4)

local specWarnDarkCommunion		= mod:NewSpecialWarningSwitch(153153, "-Healer", nil, nil, 1, 2)--On Test, even tank and healer needed to dps to kill it. I'm going to assume it's an overtuning and at least excempt healer.
local specWarnWhispers			= mod:NewSpecialWarningSpell(153094, nil, nil, nil, 2)
local specWarnDarkEclipse		= mod:NewSpecialWarningSpell(164974, nil, nil, nil, 3, 2)

local timerDarkCommunionCD		= mod:NewCDTimer(60, 153153, nil, nil, nil, 1, DBM_CORE_DAMAGE_ICON)
local timerDarkEclipseCD		= mod:NewNextTimer(45.5, 164974, nil, nil, nil, 6)--timer seems changed?

local voiceDarkCommunion		= mod:NewVoice(153153, "Dps")
local voiceDarkEclipse			= mod:NewVoice(164974)

--local countdownDarkCommunion	= mod:NewCountdown(45.5, 153153)

function mod:OnCombatStart(delay)
	timerDarkCommunionCD:Start(24-delay)
	--countdownDarkCommunion:Start(15-delay)
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
		--countdownDarkCommunion:Start()
		voiceDarkCommunion:Play("killmob")
	elseif spellId == 164974 then
		specWarnDarkEclipse:Show()
		timerDarkEclipseCD:Start()
		voiceDarkEclipse:Play("164974")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 153094 then
		warnWhispers:Show()
		specWarnWhispers:Show()
	end
end
