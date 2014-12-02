local mod	= DBM:NewMod("BrawlRank7", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(46798)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START 133212 125212 133465 133017 138845 142621 142583",
	"SPELL_AURA_APPLIED 133015 133018",
	"SPELL_AURA_APPLIED_DOSE 138901",
	"SPELL_AURA_REMOVED_DOSE 138901",
	"SPELL_AURA_REMOVED 138901"
)

local warnRockets				= mod:NewCastAnnounce(133212, 4)--Max Megablast
local warnShadowbolt			= mod:NewSpellAnnounce(125212, 3)--Dark Summoner
local warnGhost					= mod:NewSpellAnnounce(133465, 4)--Dark Summoner
local warnMines					= mod:NewCountAnnounce(133018, 3)--Battletron
local warnMinesSpawning			= mod:NewSpellAnnounce(133015, 4)--Battletron
local warnBulwark				= mod:NewAddsLeftAnnounce(138901, 2)--Ahoo'ru
local warnCharge				= mod:NewCastAnnounce(138845, 1)--Ahoo'ru
local warnCompleteHeal			= mod:NewCastAnnounce(142621, 4)--Ahoo'ru
local warnDivineCircle			= mod:NewSpellAnnounce(142585, 3)--Ahoo'ru

local specWarnShadowbolt		= mod:NewSpecialWarningSpell(125212, false)--Let you choose which one is important to warn for(Dark Summoner)
local specWarnGhost				= mod:NewSpecialWarningSpell(133465, false)--Dark Summoner
local specWarnMinesSpawning		= mod:NewSpecialWarningSpell(133015)--Battletron
local specWarnCharge			= mod:NewSpecialWarningSpell(138845)--Ahoo'ru
local specWarnCompleteHeal		= mod:NewSpecialWarningInterrupt(142621, nil, nil, nil, 3)--Ahoo'ru
local specWarnDivineCircle		= mod:NewSpecialWarningMove(142585)--Ahoo'ru

local timerRockets				= mod:NewBuffActiveTimer(9, 133212)--Max Megablast
local timerShadowboltCD			= mod:NewCDTimer(12, 125212)--Dark Summoner
local timerGhostCD				= mod:NewNextTimer(13, 133465)--Battletron
local timerDivineCircleCD		= mod:NewCDTimer(35, 142585)--Insufficent data to say if accurate with certainty

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local brawlersMod = DBM:GetModByName("Brawlers")
local remainingMines = 8

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133212 then
		warnRockets:Show()
		timerRockets:Schedule(4)
	elseif args.spellId == 125212 then
		warnShadowbolt:Show()
		timerShadowboltCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnShadowbolt:Show()
		end
	elseif args.spellId == 133465 then
		warnGhost:Show()
		timerGhostCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnGhost:Show()
		end
	elseif args.spellId == 133017 then
		remainingMines = remainingMines - 1
		warnMines:Show(remainingMines)
	elseif args.spellId == 138845 then
		warnCharge:Show()
		if brawlersMod:PlayerFighting() then
			specWarnCharge:Show()
		end
	elseif args.spellId == 142621 then
		warnCompleteHeal:Show()
		if brawlersMod:PlayerFighting() then
			specWarnCompleteHeal:Show(args.sourceName)
		end
	elseif args.spellId == 142583 then
		warnDivineCircle:Show()
		timerDivineCircleCD:Start()
		if args:IsPlayer() then
			specWarnDivineCircle:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 133015 then
--		remainingMines = 8
		warnMinesSpawning:Show()
		if brawlersMod:PlayerFighting() then
			specWarnMinesSpawning:Show()
		end
	elseif args.spellId == 133018 then
		remainingMines = 8
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 138901 then
		warnBulwark:Show(args.amount or 0)
	end
end
mod.SPELL_AURA_REMOVED = mod.SPELL_AURA_APPLIED_DOSE
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_APPLIED_DOSE
