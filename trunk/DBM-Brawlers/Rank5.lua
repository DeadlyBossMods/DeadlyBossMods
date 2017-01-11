local mod	= DBM:NewMod("BrawlRank5", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(6923)
mod:SetZone()

mod:RegisterEvents(
--	"SPELL_CAST_START"
)

--TODO, do stuff?

mod:RemoveOption("HealthFrame")

local brawlersMod = DBM:GetModByName("Brawlers")

--[[
function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133362 then

	end
end

--]]