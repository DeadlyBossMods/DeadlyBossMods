local mod	= DBM:NewMod("BrawlLegacy", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(48465)--Blind Hero
mod:SetZone()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 129888 133286 141396 141401 39945 134789",
	"SPELL_AURA_APPLIED_DOSE 141396 141401 126209 134789 133015 133018",
	"SPELL_AURA_REMOVED 126209",
	"SPELL_CAST_START 134740 133607 134777 135621 133346 134743 133286 141104 124860 124935 134795 125212 133465 133017 138845 142621 142583 142795 142788 142769 141189 141190 141192",
	"SPELL_CAST_SUCCESS 133208 140894 140912",
	"UNIT_SPELLCAST_INTERRUPTED target focus",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

--Basicly a mod of retired bosses that are no longer in use, but kept preserved in legacy mod in case they exist SOMEWHERE or return
local warnShadowStrikes			= mod:NewSpellAnnounce(126209, 3)--Akama
local warnChainLightning		= mod:NewSpellAnnounce(39945, 3)--Akama
local warnVolatileFlames		= mod:NewSpellAnnounce(134740, 3)--Vian the Volatile
local warnFireLine				= mod:NewCastAnnounce(133607, 4, 2)--Vian the Volatile
local warnDevastatingThrust		= mod:NewSpellAnnounce(134777, 4)--Ixx
local warnFallenKin				= mod:NewStackAnnounce(134789, 3)--Yikkan Izu
local warnDisorientingShriek	= mod:NewSpellAnnounce(134795, 3)--Yikkan Izu
local warnHammerFist			= mod:NewCastAnnounce(141104, 4)--Doctor FIST
local warnRainDance				= mod:NewSpellAnnounce(124860, 4)--Proboskus
local warnTorrent				= mod:NewSpellAnnounce(124935, 4)--Proboskus
local warnShadowbolt			= mod:NewSpellAnnounce(125212, 3)--Dark Summoner
local warnGhost					= mod:NewSpellAnnounce(133465, 4)--Dark Summoner
local warnMines					= mod:NewCountAnnounce(133018, 3)--Battletron
local warnMinesSpawning			= mod:NewSpellAnnounce(133015, 4)--Battletron
local warnEightChomps				= mod:NewSpellAnnounce(142788, 4)--Mecha-Bruce
local warnBetterStrongerFaster		= mod:NewSpellAnnounce(142795, 2)--Mecha-Bruce
local warnStasisBeam				= mod:NewSpellAnnounce(142769, 3)--Mecha-Bruce
local warnBlindStrike				= mod:NewSpellAnnounce(141189, 3)--Blind Hero
local warnSwiftStrike				= mod:NewCountAnnounce(141190, 3)--Blind Hero
local warnBlindCleave				= mod:NewSpellAnnounce(141192, 4)--Blind Hero
local warnBoomingBoogaloo			= mod:NewSpellAnnounce(140894, 3)--Master Boom Boom
local warnDeployBoom				= mod:NewSpellAnnounce(140912, 4)--Master Boom Boom
local warnEvilGlare					= mod:NewSpellAnnounce(133208, 4)--Zen'shar
local warnStaticCharge				= mod:NewCastAnnounce(135621, 4)--Disruptron Mk. 3R-Alpha
local warnDarkZone					= mod:NewSpellAnnounce(133346, 4)--Fjoll
local warnCharging					= mod:NewSpellAnnounce(133253, 3)--Crush
local warnEarthSeed					= mod:NewSpellAnnounce(134743, 3)--Leona Earthwind
local warnSolarBeam					= mod:NewSpellAnnounce(129888, 3)--Leona Earthwind
local warnHeatedPokers				= mod:NewSpellAnnounce(133286, 4)--Dungeon Master Vishas
local warnIntensifyingAssault		= mod:NewStackAnnounce(141396, 3)--T440 Dual-Mode Robot
local warnPrecisionArtillery		= mod:NewStackAnnounce(141401, 3)--T440 Dual-Mode Robot

local specWarnShadowStrikes		= mod:NewSpecialWarningDispel(126209, "MagicDispeller")--Akama
local specWarnChainLightning	= mod:NewSpecialWarningInterrupt(39945)--Akama
local specWarnFireLine			= mod:NewSpecialWarningDodge(133607)--Vian the Volatile
local specWarnDevastatingThrust	= mod:NewSpecialWarningDodge(134777)--Ixx
local specWarnDisorientingShriek= mod:NewSpecialWarningInterrupt(134795)--Yikkan Izu
local specWarnHammerFist		= mod:NewSpecialWarningRun(141104, nil, nil, nil, 3)--Doctor FIST
local specWarnRainDance			= mod:NewSpecialWarningSpell(124860, nil, nil, nil, 2)--Proboskus
local specWarnTorrent			= mod:NewSpecialWarningInterrupt(124935)--Proboskus
local specWarnShadowbolt		= mod:NewSpecialWarningSpell(125212, false)--Let you choose which one is important to warn for(Dark Summoner)
local specWarnGhost				= mod:NewSpecialWarningSpell(133465, false)--Dark Summoner
local specWarnMinesSpawning		= mod:NewSpecialWarningSpell(133015)--Battletron
local specWarnEightChomps			= mod:NewSpecialWarningDodge(142788)--Mecha-Bruce
local specWarnBlindCleave			= mod:NewSpecialWarningRun(141192, nil, nil, 2, 4)--Blind Hero
local specWarnBoomingBoogaloo		= mod:NewSpecialWarningSpell(140894, nil, nil, nil, 2)--Master Boom Boom
local specWarnDeployBoom			= mod:NewSpecialWarningSpell(140912, nil, nil, nil, 3)--Master Boom Boom
local specWarnEvilGlare				= mod:NewSpecialWarningMove(133208)--Zen'shar
local specWarnStaticCharge			= mod:NewSpecialWarningInterrupt(135621)--Disruptron Mk. 3R-Alpha
local specWarnDarkZone				= mod:NewSpecialWarningSpell(133346)--Fjoll
local specWarnHeatedPokers			= mod:NewSpecialWarningSpell(133286)--Dungeon Master Vishas
local specWarnIntensifyingAssault	= mod:NewSpecialWarningStack(141396, true, 10)--T440 Dual-Mode Robot
local specWarnPrecisionArtillery	= mod:NewSpecialWarningStack(141401, true, 10)--T440 Dual-Mode Robot

local timerShadowStrikes		= mod:NewBuffActiveTimer(15, 126209)--Akama
local timerChainLightningCD		= mod:NewCDTimer(17, 39945, nil, nil, nil, 4)--Akama
local timerVolatileFlamesCD		= mod:NewCDTimer(11, 134740)--Vian the Volatile
local timerFireLineCD			= mod:NewCDTimer(15, 133607, nil, nil, nil, 3)--Vian the Volatile
local timerDevastatingThrustCD	= mod:NewCDTimer(12, 134777, nil, nil, nil, 3)--Ixx
local timerFallenKin			= mod:NewBuffActiveTimer(2, 134789)--Yikkan Izu
local timerRainDanceCD			= mod:NewCDTimer(18, 124860, nil, nil, nil, 2)--Proboskus
local timerTorrentCD			= mod:NewCDTimer(18, 124935, nil, nil, nil, 4)--Proboskus
local timerShriekCD				= mod:NewCDTimer(23, 134795)
local timerShadowboltCD			= mod:NewCDTimer(12, 125212, nil, nil, nil, 4)--Dark Summoner
local timerGhostCD				= mod:NewNextTimer(13, 133465, nil, nil, nil, 1)--Dark Summoner
local timerEightChompsCD			= mod:NewCDTimer(9.5, 142788, nil, nil, nil, 3)--Mecha-Bruce
local timerBetterStrongerFasterCD	= mod:NewCDTimer(20, 142795)--Mecha-Bruce
local timerStasisBeamCD				= mod:NewCDTimer(20, 142769, nil, nil, nil, 3)--Mecha-Bruce
local timerBlindStrikeCD			= mod:NewNextTimer(2.5, 141189)--Blind Hero
local timerSwiftStrikeCD			= mod:NewNextTimer(2.4, 141190, nil, false)--May help some but off by default so it doesn't detour focus from the most important one, blind cleave(Blind Hero)
local timerBlindCleaveD				= mod:NewNextTimer(13, 141192)--Blind Hero
--local timerStaticChargeCD			= mod:NewCDTimer(24, 135621, nil, nil, nil, 4)--Master Boom Boom
local timerDarkZoneCD				= mod:NewNextTimer(29, 133346)--Fjoll
local timerChargingCD				= mod:NewCDTimer(20, 133253)--Crush
local timerEarthSeedCD				= mod:NewCDTimer(15.5, 134743, nil, nil, nil, 1)--Leona Earthwind
local timerSolarBeamCD				= mod:NewCDTimer(18.5, 129888)--Leona Earthwind
local timerHeatedPokers				= mod:NewBuffActiveTimer(8, 133286)--Dungeon Master Vishas
local timerHeatedPokersCD			= mod:NewCDTimer(29, 133286)--Dungeon Master Vishas

mod:RemoveOption("HealthFrame")
mod:AddBoolOption("SpeakOutStrikes", true)--Blind Hero

local brawlersMod = DBM:GetModByName("Brawlers")
local remainingMines = 8
local swiftStrike = 0

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 134740 then
		warnVolatileFlames:Show()
		timerVolatileFlamesCD:Start()
	elseif args.spellId == 133607 then
		timerFireLineCD:Start()--First one is 9-10 seconds after combat start
		if brawlersMod:PlayerFighting() then
			specWarnFireLine:Show()
		else
			warnFireLine:Show()
		end
	elseif args.spellId == 134777 then
		timerDevastatingThrustCD:Start()--First one is 7-8 seconds after combat start
		if brawlersMod:PlayerFighting() then
			specWarnDevastatingThrust:Show()
		else
			warnDevastatingThrust:Show()
		end
	elseif args.spellId == 135621 then
--		timerStaticChargeCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnStaticCharge:Show(args.sourceName)
		else
			warnStaticCharge:Show()
		end
	elseif args.spellId == 133346 then
		timerDarkZoneCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnDarkZone:Show()
		else
			warnDarkZone:Show()
		end
	elseif args.spellId == 134743 then
		warnEarthSeed:Show()
		timerEarthSeedCD:Start()
	elseif args.spellId == 133286 then
		timerHeatedPokersCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnHeatedPokers:Show()
		else
			warnHeatedPokers:Show()
		end
	elseif args.spellId == 39945 then
		timerChainLightningCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnChainLightning:Show(args.sourceName)
		else
			warnChainLightning:Show()
		end
	elseif args.spellId == 141104 then
		if brawlersMod:PlayerFighting() then
			specWarnHammerFist:Show()
		else
			warnHammerFist:Show()
		end
	elseif args.spellId == 124860 then
		timerRainDanceCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnRainDance:Show()
		else
			warnRainDance:Show()
		end
	elseif args.spellId == 124935 then
		timerTorrentCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnTorrent:Show(args.sourceName)
		else
			warnTorrent:Show()
		end
	elseif args.spellId == 134795 then
		timerShriekCD:Start()
		if brawlersMod:PlayerFighting() then
			warnDisorientingShriek:Show(args.sourceName)
		else
			warnDisorientingShriek:Show()
		end
	elseif args.spellId == 125212 then
		timerShadowboltCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnShadowbolt:Show()
		else
			warnShadowbolt:Show()
		end
	elseif args.spellId == 133465 then
		timerGhostCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnGhost:Show()
		else
			warnGhost:Show()
		end
	elseif args.spellId == 133017 then
		remainingMines = remainingMines - 1
		warnMines:Show(remainingMines)
	elseif args.spellId == 142795 then
		warnBetterStrongerFaster:Show()
		timerBetterStrongerFasterCD:Start()
	elseif args.spellId == 142788 then
		timerEightChompsCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnEightChomps:Show()
		else
			warnEightChomps:Show()
		end
	elseif args.spellId == 142769 then
		warnStasisBeam:Show()
		timerStasisBeamCD:Start()
	elseif args.spellId == 141189 then
		swiftStrike = 0--Start of a combo. A combo is Blind strike, swift strike x 4, blind cleave. This repeats over and over
		warnBlindStrike:Show()
		timerSwiftStrikeCD:Start()
		timerBlindCleaveD:Start()
	elseif args.spellId == 141190 then
		swiftStrike = swiftStrike + 1
		warnSwiftStrike:Show(swiftStrike)
		if swiftStrike < 4 then
			timerSwiftStrikeCD:Start()
		else
			if brawlersMod:PlayerFighting() then
				specWarnBlindCleave:Show()
			end
		end
		if brawlersMod:PlayerFighting() and self.Options.SpeakOutStrikes then
			DBM:PlayCountSound(swiftStrike)
		end
	elseif args.spellId == 141192 then
		warnBlindCleave:Show()
		timerBlindStrikeCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133208 then
--		timerEvilGlareCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnEvilGlare:Show()
		else
			warnEvilGlare:Show()
		end
	elseif args.spellId == 140894 then
		if brawlersMod:PlayerFighting() then
			specWarnBoomingBoogaloo:Show()
		else
			warnBoomingBoogaloo:Show()
		end
	elseif args.spellId == 140912 then
		if brawlersMod:PlayerFighting() then
			specWarnDeployBoom:Show()
		else
			warnDeployBoom:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 129888 and self:AntiSpam() then
		warnSolarBeam:Show()
		timerSolarBeamCD:Start()
	elseif args.spellId == 133286 then
		timerHeatedPokers:Start()
	elseif args.spellId == 141396 then
		local amount = args.amount or 1
		if amount % 5 == 0 then
			warnIntensifyingAssault:Show(args.destName, amount)
			if brawlersMod:PlayerFighting() and amount >= 10 then
				specWarnIntensifyingAssault:Show(amount)
			end
		end
	elseif args.spellId == 141401 then
		local amount = args.amount or 1
		if amount % 5 == 0 then
			warnPrecisionArtillery:Show(args.destName, amount)
			if brawlersMod:PlayerFighting() and amount >= 10 then
				specWarnPrecisionArtillery:Show(amount)
			end
		end
	elseif args.spellId == 126209 then
		timerShadowStrikes:Start()
		if brawlersMod:PlayerFighting() then
			specWarnShadowStrikes:Show(args.destName)
		else
			warnShadowStrikes:Show()
		end
	elseif args.spellId == 134789 then
		warnFallenKin:Cancel()
		warnFallenKin:Schedule(0.5, args.destName, args.amount or 1)
		timerFallenKin:Start()
	elseif args.spellId == 133015 then
		if brawlersMod:PlayerFighting() then
			specWarnMinesSpawning:Show()
		else
			warnMinesSpawning:Show()
		end
	elseif args.spellId == 133018 then
		remainingMines = 8
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 126209 then
		timerShadowStrikes:Cancel()
	end
end

function mod:UNIT_SPELLCAST_INTERRUPTED(uId, _, _, _, spellId)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if spellId == 133346 and self:AntiSpam() then
		timerDarkZoneCD:Start(4)--Interrupting dark zone does not put it on cd, he will recast it 4 seconds later
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
