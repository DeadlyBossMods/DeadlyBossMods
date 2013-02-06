if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
local mod	= DBM:NewMod(828, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(69712)
mod:SetModelID(46675)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START"
)

local warnQuills			= mod:NewSpellAnnounce(134380, 3)

local specWarnQuills		= mod:NewSpecialWarningSpell(134380, nil, nil, nil, true)

local timerQuillsCD			= mod:NewCDTimer(60, 134380)

function mod:OnCombatStart(delay)
	timerQuillsCD:Start(50-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(134380) then
		warnQuills:Show()
		specWarnQuills:Show()
		timerQuillsCD:Start()
	end
end