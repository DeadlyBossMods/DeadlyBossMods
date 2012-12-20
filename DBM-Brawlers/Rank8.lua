local mod	= DBM:NewMod("BrawlRank8", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(60491)
mod:SetModelID(46265)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnEvilGlare				= mod:NewSpellAnnounce(133208, 4)
local warnPowerCrystal			= mod:NewSpellAnnounce(133398, 3)
local warnDoom					= mod:NewSpellAnnounce(133650, 4)
local warnBlueCrush				= mod:NewSpellAnnounce(133262, 4)
local warnDestructolaser		= mod:NewSpellAnnounce(133250, 4)
local warnStaticCharge			= mod:NewCastAnnounce(135621, 4)

local specWarnEvilGlare			= mod:NewSpecialWarningMove(133208)
local specWarnDoom				= mod:NewSpecialWarningSpell(133650, nil, nil, nil, true)--Nothing you can do about this, it means you let him get to 100 stacks and will most likely wipe if you don't have super strong CDs to blow
local specWarnBlueCrush			= mod:NewSpecialWarningInterrupt(133262)
local specWarnDestructolaser	= mod:NewSpecialWarningMove(133250)
local specWarnStaticCharge		= mod:NewSpecialWarningInterrupt(135621)

local timerEvilGlareCD			= mod:NewNextTimer(6, 133208)
local timerPowerCrystalCD		= mod:NewCDTimer(13, 133398)--13-17 second variation
local timerBlueCrushCD			= mod:NewNextTimer(30, 133262)
local timerDestructolaserCD		= mod:NewNextTimer(30, 133250)
local timerStaticChargeCD		= mod:NewCDTimer(24, 135621)--24-33 second variation (maybe health based?)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args:IsSpellID(133398) then
		warnPowerCrystal:Show()
		timerPowerCrystalCD:Start()
	elseif args:IsSpellID(133650) then
		warnDoom:Show()
		if brawlersMod:PlayerFighting() then
			specWarnDoom:Show()
		end
	elseif args:IsSpellID(133262) then
		warnBlueCrush:Show()
		timerBlueCrushCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnBlueCrush:Show(args.sourceName)
		end
	elseif args:IsSpellID(135621) then
		warnStaticCharge:Show()
		timerStaticChargeCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnStaticCharge:Show(args.sourceName)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args:IsSpellID(133208) then
		warnEvilGlare:Show()
		timerEvilGlareCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnEvilGlare:Show()
		end
	elseif args:IsSpellID(133250) then
		warnDestructolaser:Show()
		timerDestructolaserCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnDestructolaser:Show()
		end
	end
end
