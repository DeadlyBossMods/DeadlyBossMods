local Arenas = DBM:NewMod("Arenas", "DBM-Battlegrounds")

Arenas:RemoveOption("HealthFrame")

Arenas:RegisterEvents("CHAT_MSG_BG_SYSTEM_NEUTRAL")

local timerStart	= Arenas:NewTimer(62, "TimerStart")

function Arenas:CHAT_MSG_BG_SYSTEM_NEUTRAL(args)
	if args == DBM_BGMOD_LANG.ARENA_BEGIN then
		timerStart:Start()
	elseif args == DBM_BGMOD_LANG.ARENA_BEGIN30 then
		if timerStart:GetTime() == 0 then
			timerStart:Start()
		end
		timerStart:Update(31, 62)
	elseif args == DBM_BGMOD_LANG.ARENA_BEGIN15 then
		if timerStart:GetTime() == 0 then
			timerStart:Start()
		end
		timerStart:Update(46, 62)
	end
end
