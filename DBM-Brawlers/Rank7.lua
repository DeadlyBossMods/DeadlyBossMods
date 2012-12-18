local mod	= DBM:NewMod("BrawlRank7", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(60491)
mod:SetModelID(46798)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warnRockets				= mod:NewCastAnnounce(133212, 4)

local timerRockets				= mod:NewBuffActiveTimer(9, 133212)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args:IsSpellID(133212) then
		warnRockets:Show()
		timerRockets:Start()--First one is 5 seconds after combat start
	end
end