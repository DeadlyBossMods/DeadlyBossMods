local mod	= DBM:NewMod("BrawlRank8", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(60491)
--mod:SetModelID(46265)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

--Boss Key
--http://mysticalos.com/images/MoP/new_brawlers/rank8.jpeg
local warnSmolderingHeat			= mod:NewTargetAnnounce(142400, 4)--A real cute troll, Anthracite (rank 8) debuffs random players in audience, this will KILL YOU if you do not get heals

local specWarnSmolderingHeat		= mod:NewSpecialWarningYou(142400)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local brawlersMod = DBM:GetModByName("Brawlers")

local smolderingHeaTargets = {}

local function warnSmolderingHeatTargets()
	warnSmolderingHeat:Show(table.concat(smolderingHeaTargets, "<, >"))
	table.wipe(smolderingHeaTargets)
end

function mod:SPELL_AURA_APPLIED(args)
--	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Commented out for now to see if blizzard keeps the rank 8 boss that attacks spectators
	if args.spellId == 142400 then
		smolderingHeaTargets[#smolderingHeaTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnSmolderingHeat:Show()
		end
		self:Unschedule(warnSmolderingHeatTargets)
		self:Schedule(0.5, warnSmolderingHeatTargets)
	end
end
