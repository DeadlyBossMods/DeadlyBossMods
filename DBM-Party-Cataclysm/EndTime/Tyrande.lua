if tonumber((select(4, GetBuildInfo()))) < 40300 then return end

local mod	= DBM:NewMod("EchoTyrande", "DBM-Party-Cataclysm", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(54544)
mod:SetModelID(39617)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START"
)

-- Most that could be added seems to be spammy

local warnGuidance	= mod:NewSpellAnnounce(102472, 3)
local warnGuidanceStack	= mod:NewCountAnnounce(102472, 2, nil, false)

local timerGuidance	= mod:NewNextTimer(20, 102472)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(102472) then
		warnGuidanceStack:Show(args.amount or 1)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(102472) then
		warnGuidance:Show()
		timerGuidance:Start()
	end
end