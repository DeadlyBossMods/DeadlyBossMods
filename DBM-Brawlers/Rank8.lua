local mod	= DBM:NewMod("BrawlRank8", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(60491)
--mod:SetModelID(46265)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)

--Boss Key
--http://mysticalos.com/images/MoP/new_brawlers/rank8.jpeg
local warnAssaultMode				= mod:NewSpellAnnounce(141395, 2)
local warnIntensifyingAssault		= mod:NewStackAnnounce(141396, 3)
local warnArtilleryMode				= mod:NewSpellAnnounce(141400, 2)
local warnPrecisionArtillery		= mod:NewStackAnnounce(141401, 3)
local warnSmolderingHeat			= mod:NewTargetAnnounce(142400, 4)--A real cute troll, Anthracite (rank 8) debuffs random players in audience, this will KILL YOU if you do not get heals
local warnCooled					= mod:NewTargetAnnounce(141371, 1)
local warnOnFire					= mod:NewTargetAnnounce(141388, 4)

local specWarnIntensifyingAssault	= mod:NewSpecialWarningStack(141396, true, 30)--Maybe tweak stack amount some
local specWarnPrecisionArtillery	= mod:NewSpecialWarningStack(141401, true, 30)
local specWarnSmolderingHeat		= mod:NewSpecialWarningYou(142400)

local timerSmolderingHeatCD			= mod:NewCDTimer(20, 142400)--20-23sec variation
local timerCooled					= mod:NewTargetTimer(20, 141371)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local brawlersMod = DBM:GetModByName("Brawlers")

local smolderingHeaTargets = {}

local function warnSmolderingHeatTargets()
	warnSmolderingHeat:Show(table.concat(smolderingHeaTargets, "<, >"))
	table.wipe(smolderingHeaTargets)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 142400 then
		smolderingHeaTargets[#smolderingHeaTargets + 1] = args.destName
		timerSmolderingHeatCD:Start()
		if args:IsPlayer() then
			specWarnSmolderingHeat:Show()
		end
		self:Unschedule(warnSmolderingHeatTargets)
		self:Schedule(0.5, warnSmolderingHeatTargets)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Excluding above ability for now until that ability stops affecting audience
	elseif args.spellId == 141396 then
		local amount = args.amount or 1
		if amount % 5 == 0 then
			warnIntensifyingAssault:Show(args.destName, amount)
			if amount >= 30 then
				specWarnIntensifyingAssault:Show(amount)
			end
		end
	elseif args.spellId == 141401 then
		local amount = args.amount or 1
		if amount % 5 == 0 then
			warnPrecisionArtillery:Show(args.destName, amount)
			if amount >= 30 then
				specWarnPrecisionArtillery:Show(amount)
			end
		end
	elseif args.spellId == 141371 then
		warnCooled:Show(args.destName)
		timerCooled:Start(args.destName)
	elseif args.spellId == 141388 then
		warnOnFire:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
