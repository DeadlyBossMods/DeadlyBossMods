local mod	= DBM:NewMod("BrawlRank7", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(46798)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START 133262",
	"SPELL_CAST_SUCCESS 133250 141013",
	"SPELL_AURA_APPLIED_DOSE 138901",
	"SPELL_AURA_REMOVED_DOSE 138901",
	"SPELL_AURA_REMOVED 138901"
)

local warnSpitAcid				= mod:NewSpellAnnounce(141013, 4)--Nibbleh
local warnBlueCrush				= mod:NewSpellAnnounce(133262, 4)--Epicus Maximus
local warnDestructolaser		= mod:NewSpellAnnounce(133250, 4)--Epicus Maximus

local specWarnSpitAcid			= mod:NewSpecialWarningSpell(141013)--Nibbleh
local specWarnBlueCrush			= mod:NewSpecialWarningInterrupt(133262)--Epicus Maximus
local specWarnDestructolaser	= mod:NewSpecialWarningMove(133250)--Epicus Maximus

local timerSpitAcidCD			= mod:NewNextTimer(20, 141013)--Nibbleh
local timerBlueCrushCD			= mod:NewNextTimer(29.1, 133262, nil, nil, nil, 4)--Epicus Maximus
local timerDestructolaserCD		= mod:NewNextTimer(30, 133250, nil, nil, nil, 3)--Epicus Maximus

mod:RemoveOption("HealthFrame")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133262 then
		timerBlueCrushCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnBlueCrush:Show(args.sourceName)
		else
			warnBlueCrush:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133250 then
		timerDestructolaserCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnDestructolaser:Show()
		else
			warnDestructolaser:Show()
		end
	elseif args.spellId == 141013 then
		timerSpitAcidCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnSpitAcid:Show()
		else
			warnSpitAcid:Show()
		end
	end
end
