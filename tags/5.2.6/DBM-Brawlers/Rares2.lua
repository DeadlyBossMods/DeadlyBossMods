local mod	= DBM:NewMod("BrawlRare2", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(60491)
mod:SetModelID(46265)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START"
)

--Boss Key
--http://mysticalos.com/images/MoP/new_brawlers/rares2.jpeg
local warnEightChomps				= mod:NewSpellAnnounce(142788, 4)
local warnBetterStrongerFaster		= mod:NewSpellAnnounce(142795, 2)
local warnStasisBeam				= mod:NewSpellAnnounce(142769, 3)

local specWarnEightChomps			= mod:NewSpecialWarningMove(142788)

local timerEightChompsCD			= mod:NewCDTimer(9.5, 142788)--9-14
local timerBetterStrongerFasterCD	= mod:NewCDTimer(20, 142795)--20-24
local timerStasisBeamCD				= mod:NewCDTimer(20, 142769)--20-24

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local brawlersMod = DBM:GetModByName("Brawlers")

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
	end
end
