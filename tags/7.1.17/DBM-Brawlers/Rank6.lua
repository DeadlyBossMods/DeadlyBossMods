local mod	= DBM:NewMod("BrawlRank6", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(39166)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START 133362 232252"
)

--Get real dino dash timer, and add Ogrewatch when better idea of mechanics
local warnPolymorph			= mod:NewSpellAnnounce(133362, 4)--Millie Watt
local warnDinoDash			= mod:NewSpellAnnounce(232252, 4)--Topps

local specWarnPolymorph		= mod:NewSpecialWarningSpell(133362)--Millie Watt
local specWarnDinoDash		= mod:NewSpecialWarningDodge(232252)--Millie Watt

local timerPolymorphCD		= mod:NewCDTimer(35, 133362, nil, nil, nil, 3)--Millie Watt

mod:RemoveOption("HealthFrame")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133362 then
		timerPolymorphCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnPolymorph:Show()
		else
			warnPolymorph:Show()
		end
	elseif args.spellId == 232252 then
		if brawlersMod:PlayerFighting() then
			specWarnDinoDash:Show()
		else
			warnDinoDash:Show()
		end
	end
end
