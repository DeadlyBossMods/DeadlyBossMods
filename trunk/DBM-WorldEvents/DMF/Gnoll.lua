local mod	= DBM:NewMod("Gnoll", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnGnoll					= mod:NewAnnounce("warnGnoll", 2, nil, false)
local warnHogger				= mod:NewAnnounce("warnHogger", 4)

local specWarnHogger			= mod:NewSpecialWarning("specWarnHogger")

local timerGame					= mod:NewBuffActiveTimer(60, 101612)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(101612) and args:IsPlayer() then
		timerGame:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(101612) and args:IsPlayer() then
		timerGame:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellID)
	if spellID == 102044 then--Hogger
		warnHogger:Show()
		specWarnHogger:Show()
	elseif spellID == 102036 then--Gnoll
		warnGnoll:Show()
	end
end