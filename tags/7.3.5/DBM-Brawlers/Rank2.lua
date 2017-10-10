local mod	= DBM:NewMod("BrawlRank2", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(46712)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START 132666 33975 136334",
	"SPELL_AURA_APPLIED 229884",
	"SPELL_AURA_REMOVED 229884",
	"SPELL_SUMMON 236458"
)

--TODO, boom broom timer
local warnPyroblast				= mod:NewCastAnnounce(33975, 3)--Sanoriak
local warnFireWall				= mod:NewSpellAnnounce(132666, 4)--Sanoriak
local warnBoomBroom				= mod:NewSpellAnnounce(236458, 4)--Bill the Janitor
local warnZenOrb				= mod:NewTargetAnnounce(229884, 1)--Master Paku

local specWarnFireWall			= mod:NewSpecialWarningSpell(132666)--Sanoriak
local specWarnBoomBroom			= mod:NewSpecialWarningRun(236458, nil, nil, nil, 4)--Bill the Janitor

local timerFirewallCD			= mod:NewCDTimer(17, 132666)--Sanoriak
local timerBoomBoomCD			= mod:NewAITimer(17, 236458)--Bill the Janitor
local timerZenOrb				= mod:NewTargetTimer(15, 229884)--Master Paku

local countdownZenOrb			= mod:NewCountdown(15, 229884)

mod:RemoveOption("HealthFrame")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args:IsSpellID(33975, 136334) then--Spellid is used by 5 diff mobs in game, but SetZone sould filter the other 4 mobs.
		warnPyroblast:Show()
	elseif args.spellId == 132666 then
		timerFirewallCD:Start()--First one is 5 seconds after combat start
		if brawlersMod:PlayerFighting() then
			specWarnFireWall:Show()
		else
			warnFireWall:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 229884 then
		timerZenOrb:Start(args.destName)
		if brawlersMod:PlayerFighting() then
			countdownZenOrb:Start()
		else
			warnZenOrb:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 229884 then
		timerZenOrb:Stop(args.destName)
		if brawlersMod:PlayerFighting() then
			countdownZenOrb:Cancel()
		end
	end
end

function mod:SPELL_SUMMON(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 236458 then
		timerBoomBoomCD:Start()
		if brawlersMod:PlayerFighting() then--Only give special warnings if you're in arena though.
			specWarnBoomBroom:Show()
		else
			warnBoomBroom:Show()
		end
	end
end
