if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
local mod	= DBM:NewMod(829, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68905, 68904)--Lu'lin 68905, Suen 68904
mod:SetModelID(46975)--Lu'lin, 46974 Suen

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnNight							= mod:NewSpellAnnounce("ej7641", 2, 108558)
local warnDay							= mod:NewSpellAnnounce("ej7645", 2, 122789)

local timerNightCD						= mod:NewNextTimer(184, "ej7641", nil, nil, nil, 130013)
local timerDayCD						= mod:NewNextTimer(184, "ej7645", nil, nil, nil, 122789)--Probably just need localizing, no short text version.

function mod:OnCombatStart(delay)

end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 137105 and self:AntiSpam(2, 1) then--Suen POrts away (Night Phase)
		warnNight:Show()
		timerDayCD:Start()
	elseif spellId == 137187 and self:AntiSpam(2, 2) then--Lu'lin Ports away (Day Phase)
		warnDay:Show()
		timerNightCD:Start()
	end
end