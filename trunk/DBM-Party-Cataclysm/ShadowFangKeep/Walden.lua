local mod	= DBM:NewMod("Walden", "DBM-Party-Cataclysm", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(46963)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warnFrostMix	= mod:NewSpellAnnounce(93702, 3)
local warnPoisonMix	= mod:NewSpellAnnounce(93704, 3)
local warnIceShards	= mod:NewSpellAnnounce(93527, 3)

local timerIceShards	= mod:NewBuffActiveTimer(5, 93527)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(93527) then
		warnIceShards:Show()
		timerIceShards:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93702) then
		warnFrostMix:Show()
	elseif args:IsSpellID(93704) then
		warnPoisonMix:Show()
	end
end