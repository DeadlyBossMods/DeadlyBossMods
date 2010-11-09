local mod	= DBM:NewMod("Magmaw", "DBM-BlackwingDescent", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(41570)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warnLavaSpew	= mod:NewSpellAnnounce(77689, 3)
local warnPillarFlame	= mod:NewSpellAnnounce(78006, 3)
local warnMoltenTantrum	= mod:NewSpellAnnounce(78403, 4)

local timerLavaSpew	= mod:NewCDTimer(25, 77689)


function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(77689) then
		warnLavaSpew:Show()
		timerLavaSpew:Start()
	elseif args:IsSpellID(78006) then
		warnPillarFlame:Show()
	elseif args:IsSpellID(78403) then
		warnMoltenTantrum:Show()
	end
end