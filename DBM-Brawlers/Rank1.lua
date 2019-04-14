local mod	= DBM:NewMod("BrawlRank1", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(46327)--Last Boss of Rank 1
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START 135342 290486 140983"
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED"
)

local warnChomp					= mod:NewSpellAnnounce(135342, 4, nil, false, 2)--Bruce
local warnDaFifHammer			= mod:NewSpellAnnounce(290486, 3)--Thog Hammerspace
local warnCantataofFlooting		= mod:NewSpellAnnounce(140983, 3)

local specWarnChomp				= mod:NewSpecialWarningDodge(135342, nil, nil, nil, 3, 2)--Bruce
local specWarnDaFifHammer		= mod:NewSpecialWarningDodge(290486, nil, nil, nil, 1, 2)--Thog Hammerspace
local specWarnCantataofFlooting	= mod:NewSpecialWarningInterrupt(140983, "HasInterrupt", nil, nil, 1, 2)--Grandpa Grumplefloot

local timerChompCD				= mod:NewCDTimer(8, 135342, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)--Bruce
local timerDaFifHammerCD		= mod:NewCDTimer(22.6, 290486, nil, nil, nil, 3)--Thog Hammerspace
--local timerCantataofFlootingCD	= mod:NewCDTimer(8, 140983, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	local spellId = args.spellId
	if spellId == 135342 then
		timerChompCD:Start()--And timers (first one is after 6 seconds)
		if brawlersMod:PlayerFighting() then--Only give special warnings if you're in arena though.
			specWarnChomp:Show()
			specWarnChomp:Play("shockwave")
		else
			warnChomp:Show()--Give reg warnings for spectators
		end
	elseif spellId == 290486 then
		timerDaFifHammerCD:Start()
		if brawlersMod:PlayerFighting() then--Only give special warnings if you're in arena though.
			specWarnDaFifHammer:Show()
			specWarnDaFifHammer:Play("shockwave")
		else
			warnDaFifHammer:Show()--Give reg warnings for spectators
		end
	elseif spellId == 140983 then
		--timerCantataofFlootingCD:Start()
		if brawlersMod:PlayerFighting() then--Only give special warnings if you're in arena though.
			specWarnCantataofFlooting:Show(args.sourceName)
			specWarnCantataofFlooting:Play("kickcast")
		else
			warnCantataofFlooting:Show()--Give reg warnings for spectators
		end
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 126209 then

	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 126209 then

	end
end
--]]
