local mod	= DBM:NewMod("Alysrazor", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52530)
mod:SetModelID(38446) -- Temporary till real modelID is known  (this 1 taken from wowhead)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)


local warnMolting		= mod:NewSpellAnnounce(99464, 3)

local timerMoltingCD		= mod:NewNextTimer(60, 99464)

mod:AddBoolOption("InfoFrame")

function mod:OnCombatStart(delay)
	timerMoltingCD:Start(10-delay)

	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(L.PowerLevel)
		DBM.InfoFrame:Show(5, "playerpower", 10, ALTERNATE_POWER_INDEX)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(99464) then
		warnMolting:Show()
		timerMoltingCD:Start()
	end
end