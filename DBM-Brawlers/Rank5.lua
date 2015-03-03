local mod	= DBM:NewMod("BrawlRank5", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(6923)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START 133362 135342"
)

local warnPolymorph			= mod:NewSpellAnnounce(133362, 4)--Millie Watt
local warnChomp				= mod:NewSpellAnnounce(135342, 4)--Bruce

local specWarnPolymorph		= mod:NewSpecialWarningSpell(133362)--Millie Watt
local specWarnChomp			= mod:NewSpecialWarningDodge(135342)--Bruce

local timerPolymorphCD		= mod:NewCDTimer(35, 133362)--Millie Watt
local timerChompCD			= mod:NewCDTimer(8, 135342)--Bruce

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133362 then
		timerPolymorphCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnPolymorph:Show()
		else
			warnPolymorph:Show()
		end
	elseif args.spellId == 135342 then
		timerChompCD:Start()--And timers (first one is after 6 seconds)
		if brawlersMod:PlayerFighting() then--Only give special warnings if you're in arena though.
			specWarnChomp:Show()
		else
			warnChomp:Show()--Give reg warnings for spectators
		end
	end
end
