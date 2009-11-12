local mod	= DBM:NewMod("PT", "DBM-Party-BC", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))

mod:RegisterEvents(
	"UPDATE_WORLD_STATES",
	"UNIT_DIED"
)

mod:RemoveOption("HealthFrame")

-- Portals
local warnWavePortalSoon	= mod:NewAnnounce("WarnWavePortalSoon", 2)
local warnWavePortal		= mod:NewAnnounce("WarnWavePortal", 3)
local warnBossPortalSoon	= mod:NewAnnounce("WarnBossPortalSoon", 3)
local warnBossPortal		= mod:NewAnnounce("WarnBossPortal", 4)
local timerNextPortal		= mod:NewTimer(120, "TimerNextPortal")


local lastPortal = 0

function mod:PortalSoon()
	if lastPortal == 5 or lastPortal == 11 or lastPortal == 17 then	
		warnBossPortalSoon:Show()
	else
		warnWavePortalSoon:Show()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 17879 or cid == 17880 then
		timerNextPortal:Start(140)
		self:ScheduleMethod(110, "PortalSoon")
	end
end

function mod:UPDATE_WORLD_STATES()
	local text = select(3, GetWorldStateUIInfo(2))
	if not text then return end
	local _, _, currentPortal = string.find(text, L.PortalCheck)
	if not currentPortal then 
		currentPortal = 0 
	end
currentPortal = tonumber(currentPortal)
	if currentPortal > lastPortal then
		self:UnscheduleMethod("PortalSoon")
		timerNextPortal:Cancel()
		if currentPortal == 6 or currentPortal == 12 or currentPortal == 18 then
			warnBossPortal:Show()
		else
			timerNextPortal:Start(currentPortal)
			self:ScheduleMethod(110, "PortalSoon")
			warnWavePortal:Show(currentPortal)
		end
		lastPortal = currentPortal
	elseif currentPortal < lastPortal then
		lastPortal = 0
	end
end