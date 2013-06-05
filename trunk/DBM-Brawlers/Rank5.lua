local mod	= DBM:NewMod("BrawlRank5", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(6923)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START",
	"UNIT_SPELLCAST_INTERRUPTED target focus"
)

local warnPolymorph			= mod:NewSpellAnnounce(133362, 4)
local warnDarkZone			= mod:NewSpellAnnounce(133346, 4)
local warnRainDance			= mod:NewSpellAnnounce(124860, 4)
local warnTorrent			= mod:NewSpellAnnounce(124935, 4)

local specWarnPolymorph		= mod:NewSpecialWarningSpell(133362)
local specWarnDarkZone		= mod:NewSpecialWarningSpell(133346)
local specWarnRainDance		= mod:NewSpecialWarningSpell(124860, nil, nil, nil, true)
local specWarnTorrent		= mod:NewSpecialWarningInterrupt(124935)

local timerPolymorphCD		= mod:NewCDTimer(35, 133362)--Small sample size, may need tweaking.
local timerDarkZoneCD		= mod:NewNextTimer(29, 133346)
local timerRainDanceCD		= mod:NewCDTimer(18, 124860)--18-25 sec variation
local timerTorrentCD		= mod:NewCDTimer(18, 124935)--18-22 sec variation

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133362 then
		warnPolymorph:Show()
		timerPolymorphCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnPolymorph:Show()
		end
	elseif args.spellId == 133346 then
		warnDarkZone:Show()
		timerDarkZoneCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnDarkZone:Show()
		end
	elseif args.spellId == 124860 then
		warnRainDance:Show()
		timerRainDanceCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnRainDance:Show()
		end
	elseif args.spellId == 124935 then
		warnTorrent:Show()
		timerTorrentCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnTorrent:Show(args.sourceName)
		end
	end
end

function mod:UNIT_SPELLCAST_INTERRUPTED(uId, _, _, _, spellId)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if spellId == 133346 and self:AntiSpam() then
		timerDarkZoneCD:Start(4)--Interrupting dark zone does not put it on cd, he will recast it 4 seconds later
	end
end
