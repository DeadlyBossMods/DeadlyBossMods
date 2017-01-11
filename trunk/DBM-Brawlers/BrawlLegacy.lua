local mod	= DBM:NewMod("BrawlLegacy", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(46265)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 129888 133286 141396 141401",
	"SPELL_AURA_APPLIED_DOSE 141396 141401",
	"SPELL_CAST_START 133398 133650 135621 133346 134743 133286",
	"SPELL_CAST_SUCCESS 133208 140894 140912",
	"UNIT_SPELLCAST_INTERRUPTED target focus",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

--Boss Key
--http://mysticalos.com/images/MoP/new_brawlers/rares1.jpeg
local warnEvilGlare					= mod:NewSpellAnnounce(133208, 4)--Zen'shar
local warnPowerCrystal				= mod:NewSpellAnnounce(133398, 3)--Millhouse Manastorm
local warnDoom						= mod:NewSpellAnnounce(133650, 4)--Millhouse Manastorm
local warnStaticCharge				= mod:NewCastAnnounce(135621, 4)--Disruptron Mk. 3R-Alpha
local warnDarkZone					= mod:NewSpellAnnounce(133346, 4)--Fjoll
local warnCharging					= mod:NewSpellAnnounce(133253, 3)--Crush
local warnEarthSeed					= mod:NewSpellAnnounce(134743, 3)--Leona Earthwind
local warnSolarBeam					= mod:NewSpellAnnounce(129888, 3)--Leona Earthwind
local warnHeatedPokers				= mod:NewSpellAnnounce(133286, 4)--Dungeon Master Vishas
local warnIntensifyingAssault		= mod:NewStackAnnounce(141396, 3)--T440 Dual-Mode Robot
local warnPrecisionArtillery		= mod:NewStackAnnounce(141401, 3)--T440 Dual-Mode Robot
local warnBoomingBoogaloo			= mod:NewSpellAnnounce(140894, 3)--Master Boom Boom 
local warnDeployBoom				= mod:NewSpellAnnounce(140912, 4)--Master Boom Boom 

local specWarnEvilGlare				= mod:NewSpecialWarningMove(133208)--Zen'shar
local specWarnDoom					= mod:NewSpecialWarningSpell(133650, nil, nil, nil, true)--Nothing you can do about this, it means you let him get to 100 stacks and will most likely wipe if you don't have super strong CDs to blow(Millhouse Manastorm)
local specWarnStaticCharge			= mod:NewSpecialWarningInterrupt(135621)--Disruptron Mk. 3R-Alpha
local specWarnDarkZone				= mod:NewSpecialWarningSpell(133346)--Fjoll
local specWarnHeatedPokers			= mod:NewSpecialWarningSpell(133286)--Dungeon Master Vishas
local specWarnIntensifyingAssault	= mod:NewSpecialWarningStack(141396, true, 10)--T440 Dual-Mode Robot
local specWarnPrecisionArtillery	= mod:NewSpecialWarningStack(141401, true, 10)--T440 Dual-Mode Robot
local specWarnBoomingBoogaloo		= mod:NewSpecialWarningSpell(140894, nil, nil, nil, 2)--Master Boom Boom 
local specWarnDeployBoom			= mod:NewSpecialWarningSpell(140912, nil, nil, nil, 3)--Master Boom Boom 

local timerPowerCrystalCD			= mod:NewCDTimer(13, 133398)--Millhouse Manastorm
--local timerStaticChargeCD			= mod:NewCDTimer(24, 135621, nil, nil, nil, 4)--Master Boom Boom
local timerDarkZoneCD				= mod:NewNextTimer(29, 133346)--Fjoll
local timerChargingCD				= mod:NewCDTimer(20, 133253)--Crush
local timerEarthSeedCD				= mod:NewCDTimer(15.5, 134743, nil, nil, nil, 1)--Leona Earthwind
local timerSolarBeamCD				= mod:NewCDTimer(18.5, 129888)--Leona Earthwind
local timerHeatedPokers				= mod:NewBuffActiveTimer(8, 133286)--Dungeon Master Vishas
local timerHeatedPokersCD			= mod:NewCDTimer(29, 133286)--Dungeon Master Vishas

mod:RemoveOption("HealthFrame")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_AURA_APPLIED(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 129888 and self:AntiSpam() then
		warnSolarBeam:Show()
		timerSolarBeamCD:Start()
	elseif args.spellId == 133286 then
		timerHeatedPokers:Start()
	elseif args.spellId == 141396 then
		local amount = args.amount or 1
		if amount % 5 == 0 then
			warnIntensifyingAssault:Show(args.destName, amount)
			if brawlersMod:PlayerFighting() and amount >= 10 then
				specWarnIntensifyingAssault:Show(amount)
			end
		end
	elseif args.spellId == 141401 then
		local amount = args.amount or 1
		if amount % 5 == 0 then
			warnPrecisionArtillery:Show(args.destName, amount)
			if brawlersMod:PlayerFighting() and amount >= 10 then
				specWarnPrecisionArtillery:Show(amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133398 then
		warnPowerCrystal:Show()
		timerPowerCrystalCD:Start()
	elseif args.spellId == 133650 then
		if brawlersMod:PlayerFighting() then
			specWarnDoom:Show()
		else
			warnDoom:Show()
		end
	elseif args.spellId == 135621 then
--		timerStaticChargeCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnStaticCharge:Show(args.sourceName)
		else
			warnStaticCharge:Show()
		end
	elseif args.spellId == 133346 then
		timerDarkZoneCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnDarkZone:Show()
		else
			warnDarkZone:Show()
		end
	elseif args.spellId == 134743 then
		warnEarthSeed:Show()
		timerEarthSeedCD:Start()
	elseif args.spellId == 133286 then
		timerHeatedPokersCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnHeatedPokers:Show()
		else
			warnHeatedPokers:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133208 then
--		timerEvilGlareCD:Start()
		if brawlersMod:PlayerFighting() then
			specWarnEvilGlare:Show()
		else
			warnEvilGlare:Show()
		end
	elseif args.spellId == 140894 then
		if brawlersMod:PlayerFighting() then
			specWarnBoomingBoogaloo:Show()
		else
			warnBoomingBoogaloo:Show()
		end
	elseif args.spellId == 140912 then
		if brawlersMod:PlayerFighting() then
			specWarnDeployBoom:Show()
		else
			warnDeployBoom:Show()
		end
	end
end

function mod:UNIT_SPELLCAST_INTERRUPTED(uId, _, _, _, spellId)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if spellId == 133346 and self:AntiSpam() then
		timerDarkZoneCD:Start(4)--Interrupting dark zone does not put it on cd, he will recast it 4 seconds later
	end
end

--It is however the ONLY event you can detect this spell using.
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if spellId == 133253 and self:AntiSpam() then
		warnCharging:Show()
		timerChargingCD:Start()
	end
end
