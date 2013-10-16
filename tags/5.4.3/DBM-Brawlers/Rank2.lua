local mod	= DBM:NewMod("BrawlRank2", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(46712)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_DIED"
)

local warnSummonTwister			= mod:NewSpellAnnounce(132670, 3)
local warnStormCloud			= mod:NewSpellAnnounce(135234, 3)--Can be interrupted
local warnThrowNet				= mod:NewSpellAnnounce(133308, 3)--Pretty dangerous but probably no need for special warning.
local warnGoblinDevice			= mod:NewSpellAnnounce(133227, 4)

local specWarnStormCloud		= mod:NewSpecialWarningInterrupt(135234)
local specWarnGoblinDevice		= mod:NewSpecialWarningSpell(133227)--This is debuff cast, it makes YOU drop mines 3-4 seconds later. you can drop these where you want.

local timerSummonTwisterCD		= mod:NewCDTimer(15, 132670)--15-17 sec variation
local timerThrowNetCD			= mod:NewCDTimer(20, 133308)
local timerGoblinDeviceCD		= mod:NewCDTimer(22, 133227)

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
