local mod	= DBM:NewMod("GrandVizierErtan", "DBM-Party-Cataclysm", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43878)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warnSummonTempest		= mod:NewSpellAnnounce(86340, 2)

local timerSummonTempest	= mod:NewCDTimer(19, 86340)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(86340) then
		warnSummonTempest:Show()
		timerSummonTempest:Start()
	end
end


-- Lightning Bolt + Cyclone Shield in combatlog (86331 + 86292)
-- emote:  Grand Vizier Ertan retracts his cyclone shield!
-- Summon Tempest: didnt see anything being spawned :S