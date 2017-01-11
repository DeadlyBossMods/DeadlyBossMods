local mod	= DBM:NewMod("BrawlRank1", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(46327)--Last Boss of Rank 1
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START 234489"
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED"
)

local warnShotgunRoar			= mod:NewCastAnnounce(234489, 3)--Oso

local specWarnShotgunRoar		= mod:NewSpecialWarningDodge(234489)--Oso

local timerShotgunRoarCD		= mod:NewAITimer(17, 234489, nil, nil, nil, 3)--Oso

mod:RemoveOption("HealthFrame")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 234489 then
		timerShotgunRoarCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnShotgunRoar:Show()
		else
			warnShotgunRoar:Show()
		end
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 126209 then

	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 126209 then

	end
end
--]]
