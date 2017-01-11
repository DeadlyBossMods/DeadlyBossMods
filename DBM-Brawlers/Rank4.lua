local mod	= DBM:NewMod("BrawlRank4", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(28115)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS 141013",
	"SPELL_AURA_APPLIED 133129 228981",
	"SPELL_AURA_REMOVED 228981",
	"PLAYER_TARGET_CHANGED"
)

local warnSpitAcid				= mod:NewSpellAnnounce(141013, 4)--Nibbleh
local warnWaterShield			= mod:NewTargetAnnounce(228981, 1)--Burnstachio

local specWarnSpitAcid			= mod:NewSpecialWarningSpell(141013)--Nibbleh

local timerSpitAcidCD			= mod:NewNextTimer(20, 141013)--Nibbleh
local timerWaterShield			= mod:NewTargetTimer(15, 228981)--Burnstachio

local countdownWaterShield		= mod:NewCountdownFades(15, 228981)

mod:RemoveOption("HealthFrame")
mod:AddBoolOption("SetIconOnDominika", true)--Dominika the Illusionist 

local brawlersMod = DBM:GetModByName("Brawlers")
local DominikaGUID = 0

function mod:SPELL_CAST_SUCCESS(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 141013 then
		timerSpitAcidCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnSpitAcid:Show()
		else
			warnSpitAcid:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133129 then
		DominikaGUID = args.destGUID
	elseif args.spellId == 228981 then
		timerWaterShield:Start(args.destName)
		if brawlersMod:PlayerFighting() then
			countdownWaterShield:Start()
		else
			warnWaterShield:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 228981 then
		timerWaterShield:Stop(args.destName)
		if brawlersMod:PlayerFighting() then
			countdownWaterShield:Cancel()
		end
	end
end

function mod:PLAYER_TARGET_CHANGED()
	if self.Options.SetIconOnDominika and not DBM.Options.DontSetIcons and UnitGUID("target") == DominikaGUID and GetRaidTargetIndex("target") ~= 8 then
		SetRaidTarget("target", 8)
	end
end
