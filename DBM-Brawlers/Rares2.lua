local mod	= DBM:NewMod("BrawlRare2", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(60491)
mod:SetModelID(46265)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

--Boss Key
--http://mysticalos.com/images/MoP/new_brawlers/rares2.jpeg
local warnEightChomps				= mod:NewSpellAnnounce(142788, 4)
local warnBetterStrongerFaster		= mod:NewSpellAnnounce(142795, 2)
local warnStasisBeam				= mod:NewSpellAnnounce(142769, 3)
local warnRockPaperScissors			= mod:NewSpellAnnounce(141206, 3)
local warnBlindStrike				= mod:NewSpellAnnounce(141189, 3)
local warnSwiftStrike				= mod:NewCountAnnounce(141190, 3)
local warnBlindCleave				= mod:NewSpellAnnounce(141192, 4)

local specWarnEightChomps			= mod:NewSpecialWarningMove(142788)
local specWarnBlindCleave			= mod:NewSpecialWarningRun(141192)

local timerEightChompsCD			= mod:NewCDTimer(9.5, 142788)--9-14
local timerBetterStrongerFasterCD	= mod:NewCDTimer(20, 142795)--20-24
local timerStasisBeamCD				= mod:NewCDTimer(20, 142769)--20-24
local timerRockpaperScissorsCD		= mod:NewCDTimer(42, 141206)--Not a large enough sample size, maybe shorter
local timerBlindStrikeCD			= mod:NewNextTimer(5, 141189)
local timerSwiftStrikeCD			= mod:NewNextTimer(2.4, 141190, nil, false)--May help some but off by default so it doesn't detour focus from the most important one, blind cleave
local timerBlindCleaveD				= mod:NewNextTimer(13, 141192)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")
mod:AddBoolOption("SpeakOutStrikes", true)

local brawlersMod = DBM:GetModByName("Brawlers")
local swiftStrike = 0

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 141206 then
		warnRockPaperScissors:Show()
		timerRockpaperScissorsCD:Start()
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
		end
		if brawlersMod:PlayerFighting() and self.Options.SpeakOutStrikes then
			DBM:PlayCountSound(swiftStrike)
		end
	elseif args.spellId == 141192 then
		warnBlindCleave:Show()
		timerBlindStrikeCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnBlindCleave:Show()
		end
	end
end
