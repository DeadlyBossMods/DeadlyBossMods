local mod = DBM:NewMod("Syth", "DBM-Party-BC", 9)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7 $"):sub(12, -3))

mod:SetCreatureID(18472)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_SUMMON"
)

local warnSummon   = mod:NewAnnounce("SummonElementals")

local spam = 0
function mod:SPELL_SUMMON(args)
	if args:IsSpellID(33537, 33538, 33539, 33540) and GetTime() - spam > 5 then
		warnSummon:Show()
		spam = GetTime()
	end
end