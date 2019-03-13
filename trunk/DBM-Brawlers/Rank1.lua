local mod	= DBM:NewMod("BrawlRank1", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(46327)--Last Boss of Rank 1
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START 135342"
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED"
)

local warnChomp					= mod:NewSpellAnnounce(135342, 4)--Bruce

local specWarnChomp				= mod:NewSpecialWarningDodge(135342)--Bruce

local timerChompCD				= mod:NewCDTimer(8, 135342)--Bruce

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 135342 then
		timerChompCD:Start()--And timers (first one is after 6 seconds)
		if brawlersMod:PlayerFighting() then--Only give special warnings if you're in arena though.
			specWarnChomp:Show()
		else
			warnChomp:Show()--Give reg warnings for spectators
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
