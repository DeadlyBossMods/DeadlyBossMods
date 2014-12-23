local mod	= DBM:NewMod("BrawlRank2", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(46712)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START 133308 135234",
	"SPELL_CAST_SUCCESS 133227 132670",
	"UNIT_DIED"
)

local warnSummonTwister			= mod:NewSpellAnnounce(132670, 3)--Kirrawk
local warnStormCloud			= mod:NewSpellAnnounce(135234, 3)--Kirrawk
local warnThrowNet				= mod:NewSpellAnnounce(133308, 3)--Fran and Riddoh
local warnGoblinDevice			= mod:NewSpellAnnounce(133227, 4)--Fran and Riddoh

local specWarnStormCloud		= mod:NewSpecialWarningInterrupt(135234)--Kirrawk
local specWarnGoblinDevice		= mod:NewSpecialWarningSpell(133227)--Fran and Riddoh

local timerSummonTwisterCD		= mod:NewCDTimer(15, 132670)--Kirrawk
local timerThrowNetCD			= mod:NewCDTimer(20, 133308)--Fran and Riddoh
local timerGoblinDeviceCD		= mod:NewCDTimer(22, 133227)--Fran and Riddoh

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local brawlersMod = DBM:GetModByName("Brawlers")

function mod:SPELL_CAST_START(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end--Spectator mode is disabled, do nothing.
	if args.spellId == 133308 then
		warnThrowNet:Show()
		timerThrowNetCD:Start()
	elseif args.spellId == 135234 then
		warnStormCloud:Show()
		--CD seems to be 32 seconds usually but sometimes only 16? no timer for now
		if brawlersMod:PlayerFighting() then
			specWarnStormCloud:Show(args.sourceName)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not brawlersMod.Options.SpectatorMode and not brawlersMod:PlayerFighting() then return end
	if args.spellId == 133227 then
		warnGoblinDevice:Show()
		timerGoblinDeviceCD:Start()--6 seconds after combat start, if i do that kind of detection later
		if brawlersMod:PlayerFighting() then--Only give special warnings if you're in arena though.
			specWarnGoblinDevice:Show()
		end
	elseif args.spellId == 132670 then
		warnSummonTwister:Show()
		timerSummonTwisterCD:Start()--22 seconds after combat start?
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 67524 then--These 2 have a 1 min 50 second berserk
		timerThrowNetCD:Cancel()
	elseif cid == 67525 then--These 2 have a 1 min 50 second berserk
		timerGoblinDeviceCD:Cancel()
	end
end
