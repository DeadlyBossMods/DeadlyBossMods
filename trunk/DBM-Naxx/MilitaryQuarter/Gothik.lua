local mod = DBM:NewMod("Gothik", "DBM-Naxx", 4)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(16060)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"UNIT_DIED"
)

local warnWaveNow		= mod:NewAnnounce("WarningWaveSpawned", 3, nil, false)
local warnWaveSoon		= mod:NewAnnounce("WarningWaveSoon", 1)
local warnRiderDown		= mod:NewAnnounce("WarningRiderDown", 4)
local warnKnightDown	= mod:NewAnnounce("WarningKnightDown", 2)
local warnPhase2		= mod:NewAnnounce("WarningPhase2", 4)

local timerPhase2		= mod:NewTimer(270, "TimerPhase2", 27082) 
local timerWave			= mod:NewTimer(20, "TimerWave", 27082)

local wavesNormal = {
	{2, L.Trainee, next = 20},
	{2, L.Trainee, next = 20},
	{2, L.Trainee, next = 10},
	{1, L.Knight, next = 10},
	{2, L.Trainee, next = 15},
	{1, L.Knight, next = 5},
	{2, L.Trainee, next = 20},
	{1, L.Knight, 2, L.Trainee, next = 10},
	{1, L.Rider, next = 10},
	{2, L.Trainee, next = 5},
	{1, L.Knight, next = 15},
	{2, L.Trainee, 1, L.Rider, next = 10},
	{2, L.Knight, next = 10},
	{2, L.Trainee, next = 10},
	{1, L.Rider, next = 5},
	{1, L.Knight, next = 5},
	{2, L.Trainee, next = 20},
	{1, L.Rider, 1, L.Knight, 2, L.Trainee, next = 15},
	{2, L.Trainee},
}

local wavesHeroic = {
	{3, L.Trainee, next = 20},
	{3, L.Trainee, next = 20},
	{3, L.Trainee, next = 10},
	{2, L.Knight, next = 10},
	{3, L.Trainee, next = 15},
	{2, L.Knight, next = 5},
	{3, L.Trainee, next = 20},
	{3, L.Trainee, 2, L.Knight, next = 10},
	{3, L.Trainee, next = 10},
	{1, L.Rider, next = 5},
	{3, L.Trainee, next = 15},
	{1, L.Rider, next = 10},
	{2, L.Knight, next = 10},
	{1, L.Rider, next = 10},
	{1, L.Rider, 3, L.Trainee, next = 5},
	{1, L.Knight, 3, L.Trainee, next = 5},
	{1, L.Rider, 3, L.Trainee, next = 20},
	{1, L.Rider, 2, L.Knight, 3, L.Trainee},
}


local waves = wavesNormal
local wave = 0

local function getWaveString(wave)
	local waveInfo = waves[wave]
	if #waveInfo == 2 then
		return L.WarningWave1:format(unpack(waveInfo))
	elseif #waveInfo == 4 then
		return L.WarningWave2:format(unpack(waveInfo))
	elseif #waveInfo == 6 then
		return L.WarningWave3:format(unpack(waveInfo))
	end
end

function mod:OnCombatStart(delay)
	if mod:IsDifficulty("heroic25") then
		waves = wavesHeroic
	else
		waves = wavesNormal
	end
	wave = 0
	timerPhase2:Start()
	warnPhase2:Schedule(270)
	timerWave:Start(25, wave + 1)
	warnWaveSoon:Schedule(22, wave + 1, getWaveString(wave + 1))
	self:ScheduleMethod(25, "NextWave")
end

function mod:NextWave()
	wave = wave + 1
	warnWaveNow:Show(wave, getWaveString(wave))
	local next = waves[wave].next
	if next then
		timerWave:Start(next, wave + 1)
		warnWaveSoon:Schedule(next - 3, wave + 1, getWaveString(wave + 1))
		self:ScheduleMethod(next, "NextWave")
	end
end

function mod:UNIT_DIED(args)
	if bit.band(args.destGUID:sub(0, 5), 0x00F) == 3 then
		local guid = tonumber(args.destGUID:sub(9, 12), 16)
		if guid == 16126 then -- Unrelenting Rider
			warnRiderDown:Show()
		elseif guid == 16125 then -- Unrelenting Deathknight
			warnKnightDown:Show()
		end
	end
end

