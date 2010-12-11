local mod	= DBM:NewMod("FoeReaper", "DBM-Party-Cataclysm", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43778)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnOverdrive		= mod:NewSpellAnnounce(88481, 3)
local warnHarvest		= mod:NewSpellAnnounce(88495, 3)
local warnEnrage		= mod:NewSpellAnnounce(91720, 4)
local warnSpiritStrike		= mod:NewSpellAnnounce(59304, 3)

local timerOverdrive		= mod:NewBuffActiveTimer(10, 88481)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(88481) then
		warnOverdrive:Show()
		timerOverdrive:Start()
	elseif args:IsSpellID(88495) then
		warnHarvest:Show()
	elseif args:IsSpellID(91720) then
		warnEnrage:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(59304) and mod:IsInCombat() then
		warnSpiritStrike:Show()
	end
end