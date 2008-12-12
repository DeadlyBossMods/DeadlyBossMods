local mod = DBM:NewMod("Sartharion", "DBM-ChamberOfAspects")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28860)
mod:SetZone()

mod:RegisterCombat("yell", L.Pull)

mod:EnableModel()

mod:RegisterEvents(
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

local warningWallSoon		= mod:NewAnnounce("WarningWallSoon", 3, 43113)
local warningAdd		= mod:NewAnnounce("WarningAdd", 4, 59571)
local timerAdd			= mod:NewTimer(15, "TimerAdd", 59571)  	
local timerWall			= mod:NewTimer(30, "TimerWall", 43113)		

local vesperon = 1
local shadron = 1
local tenebron = 1

function mod:OnCombatStart(delay)
	if vesperon then timerAdd:Start(30 - delay, "Vesperon") end
	if shadron then timerAdd:Start(90 - delay, "Shadron") end
	if tenebron then timerAdd:Start(120 - delay, "Tenebron") end
	timerWall:Start(30 - delay)
	warningWallSoon:Schedule(28 - delay)
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, sender)
	if sender == L.name then
		warningWallSoon:Unschedule()
		timerWall:Stop()
		warningWallSoon:Schedule(28)
		timerWall:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, sender)
	if msg:find(L.Vesperon) then
		warningAdd:Show("Vesperon")
	elseif msg:find(L.Shadron) then
		warningAdd:Show("Shadron")
	elseif msg:find(L.Tenebron) then
		warningAdd:Show("Tenebron")
	end
end

function mod:UNIT_DIED(args)
	if bit.band(args.destGUID:sub(0, 5), 0x00F) == 3 then
		local z = tonumber(args.destGUID:sub(9, 12), 16)
		if z == 30449 then
			vesperon = nil
		elseif z == 30451 then
			shadron = nil
		elseif z == 30452 then
			tenebron = nil
		end
	end
end