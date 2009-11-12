local mod	= DBM:NewMod("Maladaar", "DBM-Party-BC", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))
mod:SetCreatureID(18373)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warningSoul	= mod:NewTargetAnnounce(32346, 2)
local warningAvatar	= mod:NewSpellAnnounce(32424, 3)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(32424) then
		warningAvatar:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(32346) then
		warningSoul:Show(args.destName)
	end
end