local mod	= DBM:NewMod(1139, "DBM-Party-WoD", 6, 537)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(75509)
mod:SetEncounterID(1677)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED"
)

local warnDarkCommunion			= mod:NewSpellAnnounce(153153, 4)
local warnDarkEclipse			= mod:NewSpellAnnounce(164974, 4)

local specWarnDarkCommunion		= mod:NewSpecialWarningSwitch(153153, not mod:IsHealer())--On Test, even tank and healer needed to dps to kill it. I'm going to assume it's an overtuning and at least excempt healer.
local specWarnDarkEclipse		= mod:NewSpecialWarningSpell(164974, nil, nil, nil, 3)

local timerDarkCommunionCD		= mod:NewNextTimer(45.5, 153153)
local timerDarkEclipseCD		= mod:NewNextTimer(45.5, 164974)

function mod:OnCombatStart(delay)
--Need transcriptor log for these. /chatlog seems to no longer log boss yells?
--	timerDarkCommunionCD:Start(7-delay)
--	timerDarkEclipseCD:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 153153 then
		warnDarkCommunion:Show()
		specWarnDarkCommunion:Show()
		timerDarkCommunionCD:Start()
	elseif args.spellId == 164974 then
		specWarnDarkEclipse:Show()
		specWarnDarkEclipse:Show()
		timerDarkEclipseCD:Start()
	end
end

--[[TODO, need transcriptor, or at least non broken combat log. daggerfall didn't show in combat log but needs warning/timer if it has UNIT_ event
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 114086 then
		warnPiercingThrow:Show()
	end
end--]]
