local mod = DBM:NewMod("PortalTimers", "DBM-Party-WotLK", 12)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(30658)
mod:SetZone()

mod:RegisterEvents(
	"UPDATE_WORLD_STATES",
	"UNIT_DIED"
)

local warningPortalNow	= mod:NewAnnounce("WarningPortalNow", 2, 57687)
local warningPortalSoon	= mod:NewAnnounce("WarningPortalSoon", 1, 57687)
local warningBossNow	= mod:NewAnnounce("WarningBossNow", 4, 33341)

local timerPortalIn	= mod:NewTimer(97, "TimerPortalIn", 57687)

mod:AddBoolOption("ShowAllPortalWarnings", false, "announce")

mod:RemoveOption("HealthFrame")

local lastwave = 0

function mod:UPDATE_WORLD_STATES(args)
	local text = select(3, GetWorldStateUIInfo(2))
	if not text then return end
	local _, _, wave = string.find(text, L.WavePortal)
	if not wave then
		wave = 0
	end
	wave = tonumber(wave)
	lastwave = tonumber(lastwave)
	if wave > lastwave or wave == 1 then
		warningPortalSoon:Cancel()
		timerPortalIn:Cancel()
		if wave == 6 or wave == 12 or wave == 18 then
			warningBossNow:Show()
		elseif self.Options.ShowAllPortalWarnings then
			timerPortalIn:Start(95, lastwave + 1)
			warningPortalNow:Show(wave)
		end
		lastwave = wave
	elseif wave == 0 then
		timerPortalIn:Cancel()
		warningPortalSoon:Cancel()
	end
end

function mod:UNIT_DIED(args)
	if bit.band(args.destGUID:sub(0, 5), 0x00F) == 3 then
		local z = tonumber(args.destGUID:sub(9, 12), 16)
		if z == 29266 or z == 29312 or z == 29313 or z == 29314 or z == 29315 or z == 29316  		-- bosses
		or z == 32226 or z == 32230 or z == 32231 or z == 32234 or z == 32235 or z == 32237 then 	-- boss spirits (in case you wipe)
			timerPortalIn:Start(97, lastwave + 1)
			warningPortalSoon:Schedule(87)
		end
	end
end
