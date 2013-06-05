local mod	= DBM:NewMod("BrawlRank9", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(47854)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

--Boss Key
--http://mysticalos.com/images/MoP/new_brawlers/rank9.jpeg
local warnSpitAcid				= mod:NewSpellAnnounce(141013, 4)
local warnCompleteHeal			= mod:NewCastAnnounce(142621, 4)
local warnDivineCircle			= mod:NewTargetAnnounce(142585, 3)

local specWarnSpitAcid			= mod:NewSpecialWarningSpell(141013)
local specWarnCompleteHeal		= mod:NewSpecialWarningInterrupt(142621, nil, nil, nil, 3)--Not interrupting even once is a complete wipe
local specWarnDivineCircle		= mod:NewSpecialWarningMove(142585)

local timerSpitAcidCD			= mod:NewNextTimer(20, 141013)
local timerDivineCircleCD		= mod:NewCDTimer(35, 142585)--Insufficent data to say if accurate with certainty

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 141013 then
		warnCompleteHeal:Show()
		if brawlersMod:PlayerFighting() then
			specWarnCompleteHeal:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 141013 then
		warnSpitAcid:Show()
		timerSpitAcidCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnSpitAcid:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 142585 then
		warnDivineCircle:Show(args.destName)
		timerDivineCircleCD:Start()
		if args:IsPlayer() then
			specWarnDivineCircle:Show()
		end
	end
end
