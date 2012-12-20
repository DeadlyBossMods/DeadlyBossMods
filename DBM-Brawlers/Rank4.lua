local mod	= DBM:NewMod("BrawlRank4", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(60491)
mod:SetModelID(28115)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnCharging				= mod:NewSpellAnnounce(133253, 3)
local warnEarthSeed				= mod:NewSpellAnnounce(134743, 3)
local warnSolarBeam				= mod:NewSpellAnnounce(129888, 3)

local timerChargingCD			= mod:NewCDTimer(20, 133253)--20-24 sec variation.
local timerEarthSeedCD			= mod:NewNextTimer(15.5, 134743)
local timerSolarBeamCD			= mod:NewCDTimer(18.5, 129888)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args:IsSpellID(134743) then
		warnEarthSeed:Show()
		timerEarthSeedCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args:IsSpellID(129888) and self:AntiSpam() then
		warnSolarBeam:Show()
		timerSolarBeamCD:Start()
	end
end

--It is however the ONLY event you can detect this spell using.
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if spellId == 133253 and self:AntiSpam() then
		warnCharging:Show()
		timerChargingCD:Start()
	end
end