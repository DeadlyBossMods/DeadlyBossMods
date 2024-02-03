local mod	= DBM:NewMod("BrawlRank3", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(28649)
mod:SetUsedIcons(8)

mod:RegisterEvents(
	"SPELL_CAST_START 234489 138845 142621 142583",
--	"SPELL_CAST_SUCCESS 232504",
	"SPELL_AURA_APPLIED_DOSE 138901",
	"SPELL_AURA_REMOVED 138901",
	"SPELL_AURA_REMOVED_DOSE 138901"
)

local warnShotgunRoar				= mod:NewCastAnnounce(234489, 3)--Oso
local warnBulwark					= mod:NewAddsLeftAnnounce(138901, 2)--Ahoo'ru
local warnCharge					= mod:NewCastAnnounce(138845, 1)--Ahoo'ru
local warnCompleteHeal				= mod:NewCastAnnounce(142621, 4)--Ahoo'ru
local warnDivineCircle				= mod:NewSpellAnnounce(142585, 3)--Ahoo'ru

local specWarnShotgunRoar			= mod:NewSpecialWarningDodge(234489)--Oso
local specWarnCharge				= mod:NewSpecialWarningSpell(138845)--Ahoo'ru
local specWarnCompleteHeal			= mod:NewSpecialWarningInterrupt(142621, nil, nil, nil, 3)--Ahoo'ru
local specWarnDivineCircle			= mod:NewSpecialWarningDodge(142585)--Ahoo'ru

local timerShotgunRoarCD			= mod:NewCDTimer(9.9, 234489, nil, nil, nil, 3)--Oso
local timerDivineCircleCD			= mod:NewCDTimer(26.7, 142585)--Insufficent data to say if accurate with certainty --Ahoo'ru

local brawlersMod = DBM:GetModByName("BrawlersGeneral")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 234489 then
		timerShotgunRoarCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnShotgunRoar:Show()
		else
			warnShotgunRoar:Show()
			timerShotgunRoarCD:SetSTFade(true)
		end
	elseif args.spellId == 138845 then
		if brawlersMod:PlayerFighting() then
			specWarnCharge:Show()
		else
			warnCharge:Show()
		end
	elseif args.spellId == 142621 then
		if brawlersMod:PlayerFighting() then
			specWarnCompleteHeal:Show(args.sourceName)
		else
			warnCompleteHeal:Show()
		end
	elseif args.spellId == 142583 then
		timerDivineCircleCD:Start()
		if args:IsPlayer() then
			specWarnDivineCircle:Show()
		else
			warnDivineCircle:Show()
			timerDivineCircleCD:SetSTFade(true)
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 232504 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 138901 then
		warnBulwark:Show(args.amount or 0)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_REMOVED = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_APPLIED
