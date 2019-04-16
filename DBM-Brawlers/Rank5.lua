local mod	= DBM:NewMod("BrawlRank5", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(6923)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START 133362"
)

local warnPolymorph			= mod:NewSpellAnnounce(133362, 4)--Millie Watt

local specWarnPolymorph		= mod:NewSpecialWarningSpell(133362, nil, nil, nil, 1, 2)--Millie Watt

local timerPolymorphCD		= mod:NewCDTimer(35, 133362, nil, nil, nil, 3)--Millie Watt

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133362 then
		timerPolymorphCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnPolymorph:Show()
			specWarnPolymorph:Play("targetyou")
		else
			warnPolymorph:Show()
		end
	end
end