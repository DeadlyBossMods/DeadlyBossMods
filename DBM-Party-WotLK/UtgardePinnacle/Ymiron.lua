local mod	= DBM:NewMod("Ymiron", "DBM-Party-WotLK", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26861)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warningBane		= mod:NewSpellAnnounce(48294, 3)
local warningScreams	= mod:NewSpellAnnounce(51750, 2)

local timerBane			= mod:NewBuffActiveTimer(5, 48294)
local timerScreams		= mod:NewBuffActiveTimer(8, 51750)

function mod:APELL_AURA_APPLIED(args)
	if args:IsSpellID(48294, 59301) then
		warningBane:Show()
		timerBane:Start()
	elseif args:IsSpellID(51750) then
		warningScreams:Show()
		timerScreams:Start()
	end
end