local mod	= DBM:NewMod("BrawlRare2", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(60491)
mod:SetModelID(48465)
mod:SetZone()

mod:RegisterEvents(
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_AURA_APPLIED 141206 142400 141371 141388",
	"SPELL_CAST_START 142795 142788 142769 141189 141190 141192 140868 140862 140886",
	"SPELL_CAST_SUCCESS 140894 140912"
)

--Boss Key
--http://mysticalos.com/images/MoP/new_brawlers/rares2.jpeg
local warnEightChomps				= mod:NewSpellAnnounce(142788, 4)--Mecha-Bruce
local warnBetterStrongerFaster		= mod:NewSpellAnnounce(142795, 2)--Mecha-Bruce
local warnStasisBeam				= mod:NewSpellAnnounce(142769, 3)--Mecha-Bruce
local warnRockPaperScissors			= mod:NewSpellAnnounce(141206, 3)--Ro-Shambo
local warnBlindStrike				= mod:NewSpellAnnounce(141189, 3)--Blind Hero
local warnSwiftStrike				= mod:NewCountAnnounce(141190, 3)--Blind Hero
local warnBlindCleave				= mod:NewSpellAnnounce(141192, 4)--Blind Hero
local warnBoomingBoogaloo			= mod:NewSpellAnnounce(140894, 3)--Master Boom Boom
local warnDeployBoom				= mod:NewSpellAnnounce(140912, 4)--Master Boom Boom
local warnSmolderingHeat			= mod:NewTargetAnnounce(142400, 4)--Anthracite
local warnCooled					= mod:NewTargetAnnounce(141371, 1)--Anthracite
local warnOnFire					= mod:NewTargetAnnounce(141388, 4)--Anthracite

local specWarnRPS					= mod:NewSpecialWarning("specWarnRPS")--Ro-Shambo
local specWarnEightChomps			= mod:NewSpecialWarningMove(142788)--Mecha-Bruce
local specWarnBlindCleave			= mod:NewSpecialWarningRun("OptionVersion2", 141192, nil, nil, nil, 4)--Blind Hero
local specWarnBoomingBoogaloo		= mod:NewSpecialWarningSpell(140894, nil, nil, nil, 2)--Master Boom Boom
local specWarnDeployBoom			= mod:NewSpecialWarningSpell(140912, nil, nil, nil, 3)--Master Boom Boom
local specWarnSmolderingHeat		= mod:NewSpecialWarningYou(142400)--Anthracite

local timerEightChompsCD			= mod:NewCDTimer(9.5, 142788)--Mecha-Bruce
local timerBetterStrongerFasterCD	= mod:NewCDTimer(20, 142795)--Mecha-Bruce
local timerStasisBeamCD				= mod:NewCDTimer(20, 142769)--Mecha-Bruce
local timerRockpaperScissorsCD		= mod:NewCDTimer(42, 141206)--Ro-Shambo
local timerBlindStrikeCD			= mod:NewNextTimer(2.5, 141189)--Blind Hero
local timerSwiftStrikeCD			= mod:NewNextTimer(2.4, 141190, nil, false)--May help some but off by default so it doesn't detour focus from the most important one, blind cleave(Blind Hero)
local timerBlindCleaveD				= mod:NewNextTimer(13, 141192)--Blind Hero
local timerSmolderingHeatCD			= mod:NewCDTimer(20, 142400)--Anthracite
local timerCooled					= mod:NewTargetTimer(20, 141371)--Anthracite

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")
mod:AddBoolOption("SpeakOutStrikes", true)--Blind Hero
mod:AddBoolOption("ArrowOnBoxing")--Ro-Shambo

local brawlersMod = DBM:GetModByName("Brawlers")
local swiftStrike = 0
local lastRPS = DBM_CORE_UNKNOWN

--"<39.8 01:37:33> [CHAT_MSG_RAID_BOSS_EMOTE] CHAT_MSG_RAID_BOSS_EMOTE#|TInterface\\Icons\\inv_inscription_scroll.blp:20|t %s Chooses |cFFFF0000Paper|r! You |cFF00FF00Win|r!#Ro-Shambo
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find(L.rock) then
		lastRPS = L.rock
	elseif msg:find(L.paper) then
		lastRPS = L.paper
	elseif msg:find(L.scissors) then
		lastRPS = L.scissors
	end
end

brawlersMod:OnMatchStart(function()
	lastRPS = DBM_CORE_UNKNOWN
end)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 142400 then
		warnSmolderingHeat:CombinedShow(0.5, args.destName)
		timerSmolderingHeatCD:Start()
		if args:IsPlayer() then
			specWarnSmolderingHeat:Show()
		end
	end
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 141206 then
		warnRockPaperScissors:Show()
		timerRockpaperScissorsCD:Start()
		if brawlersMod:PlayerFighting() then
			if lastRPS == L.rock then--he's using paper this time
				specWarnRPS:Show(L.scissors)
			elseif lastRPS == L.paper then--He's using scissors this time
				specWarnRPS:Show(L.rock)
			elseif lastRPS == L.scissors then--he's using rock this time
				specWarnRPS:Show(L.paper)
			end
		end
	elseif args.spellId == 141371 then
		warnCooled:Show(args.destName)
		timerCooled:Start(args.destName)
	elseif args.spellId == 141388 then
		warnOnFire:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 142795 then
		warnBetterStrongerFaster:Show()
		timerBetterStrongerFasterCD:Start()
	elseif args.spellId == 142788 then
		warnEightChomps:Show()
		timerEightChompsCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnEightChomps:Show()
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
	elseif args.spellId == 140868 and self.Options.ArrowOnBoxing and brawlersMod:PlayerFighting() then--Left Hook
		DBM.Arrow:ShowStatic(270, 3)
	elseif args.spellId == 140862 and self.Options.ArrowOnBoxing and brawlersMod:PlayerFighting() then--Right Hook
		DBM.Arrow:ShowStatic(90, 3)
	elseif args.spellId == 140886 and self.Options.ArrowOnBoxing and brawlersMod:PlayerFighting() then--Right Hook
		DBM.Arrow:ShowStatic(180, 3)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 140894 then
		warnBoomingBoogaloo:Show()
		if brawlersMod:PlayerFighting() then
			specWarnBoomingBoogaloo:Show()
		end
	elseif args.spellId == 140912 then
		warnDeployBoom:Show()
		if brawlersMod:PlayerFighting() then
			specWarnDeployBoom:Show()
		end
	end
end
