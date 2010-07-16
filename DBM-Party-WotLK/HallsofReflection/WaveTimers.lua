local mod = DBM:NewMod("HoRWaveTimer", "DBM-Party-WotLK", 16)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2153 $"):sub(12, -3))
mod:SetCreatureID(30658)
mod:SetZone()

mod:RegisterEvents(
	"UPDATE_WORLD_STATES",
	"UNIT_DIED"
)

local warnNewWaveSoon	= mod:NewAnnounce("WarnNewWaveSoon", 2)
local warnNewWave	= mod:NewAnnounce("WarnNewWave", 3)
local timerNextWave	= mod:NewTimer(150, "TimerNextWave")

mod:AddBoolOption("ShowAllWaveWarnings", true, "announce")
mod:AddBoolOption("ShowAllWaveTimers", false, "timer")

mod:RemoveOption("HealthFrame")

local lastWave = 0
local FalricDead = false

function mod:UPDATE_WORLD_STATES(args)
	local text = select(3, GetWorldStateUIInfo(1))
	if not text then return end
	local _, _, wave = string.find(text, L.WaveCheck)
	if not wave then
		wave = 0
	end
	wave = tonumber(wave)
	lastWave = tonumber(lastWave)
	if wave < lastWave then
		lastWave = 0
	end
	if wave > lastWave then
		warnNewWaveSoon:Cancel()
		timerNextWave:Cancel()
		if (wave == 5 and not FalricDead) or wave == 10 then
			warnNewWave:Show("Boss")
		elseif wave > 0 then
			if wave < 5 then
				FalricDead = false
			end
			if self.Options.ShowAllWaveWarnings then
				warnNewWave:Show("Wave")
			end
			if self.Options.ShowAllWaveTimers then
				timerNextWave:Start()
				warnNewWaveSoon:Schedule(140)
			end
		end
	elseif wave == 0 then
		warnNewWaveSoon:Cancel()
		timerNextWave:Cancel()
	end
	lastWave = wave
end

function mod:UNIT_DIED(args)
	if args.sourceName == L.Falric then
		timerNextWave:Start(60)
		warnNewWaveSoon:Schedule(50)
		FalricDead = true
	end
end