local mod	= DBM:NewMod("BrawlRank6", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(39166)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START 142788 142795 142769 282081",
	"SPELL_CAST_SUCCESS 141013",
	"SPELL_AURA_APPLIED 236155",
	"SPELL_AURA_APPLIED_DOSE 236155"
)

--Get real dino dash timer, and add Ogrewatch when better idea of mechanics

local warnSpitAcid					= mod:NewSpellAnnounce(141013, 4)--Nibbleh
local warnEightChomps				= mod:NewSpellAnnounce(142788, 4, nil, false, 2)--Mecha-Bruce
local warnBetterStrongerFaster		= mod:NewSpellAnnounce(142795, 2)--Mecha-Bruce
local warnStasisBeam				= mod:NewSpellAnnounce(142769, 3)--Mecha-Bruce

local specWarnSpitAcid				= mod:NewSpecialWarningSpell(141013, nil, nil, nil, 1, 2)--Nibbleh
local specWarnAuraofRot				= mod:NewSpecialWarningStack(236155, nil, 8, nil, nil, 1, 6)--Stiches
local specWarnEightChomps			= mod:NewSpecialWarningDodge(142788, nil, nil, nil, 1, 2)--Mecha-Bruce
local specWarnDisrobingStrike		= mod:NewSpecialWarningInterrupt(282081, nil, nil, nil, 1, 2)--Robe-Robber Robert

local timerSpitAcidCD				= mod:NewNextTimer(20, 141013)--Nibbleh
local timerEightChompsCD			= mod:NewCDTimer(8.5, 142788, nil, nil, nil, 3)--Mecha-Bruce
local timerBetterStrongerFasterCD	= mod:NewCDTimer(20, 142795)--Mecha-Bruce
local timerStasisBeamCD				= mod:NewCDTimer(19.4, 142769, nil, nil, nil, 3)--Mecha-Bruce
local timerDisrobingStrikeCD		= mod:NewCDTimer(8.4, 282081, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)--Robe-Robber Robert

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 142788 then
		timerEightChompsCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnEightChomps:Show()
			specWarnEightChomps:Play("shockwave")
		else
			warnEightChomps:Show()
		end
	elseif args.spellId == 142795 then
		warnBetterStrongerFaster:Show()
		timerBetterStrongerFasterCD:Start()
	elseif args.spellId == 142769 then
		warnStasisBeam:Show()
		timerStasisBeamCD:Start()
	elseif args.spellId == 282081 then
		timerDisrobingStrikeCD:Start()
		if brawlersMod:PlayerFighting() and self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnDisrobingStrike:Show(args.sourceName)
			specWarnDisrobingStrike:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 141013 then
		timerSpitAcidCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnSpitAcid:Show()
			specWarnSpitAcid:Play("watchstep")
		else
			warnSpitAcid:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 236155 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 8 then
			specWarnAuraofRot:Show(amount)
			specWarnAuraofRot:Play("stackhigh")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
