local mod = DBM:NewMod("Gothik 10", "DBM-Naxx-10", 4)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 84 $"):sub(12, -3))
mod:SetCreatureID(16060)
mod:SetZone(GetAddOnMetadata("DBM-Naxx-10", "X-DBM-Mod-LoadZone"))

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"UNIT_DIED"
)

local warnWaveNow		= mod:NewAnnounce("WarningWaveNow", 3)
local warnWaveSoon		= mod:NewAnnounce("WarningWaveSoon", 1)
local warnRiderDown		= mod:NewAnnounce("WarningRiderDown", 4)
local warnKnightDown	= mod:NewAnnounce("WarningKnightDown", 2)

local timerPhase2		= mod:NewTimer(270, "TimerPhase2", 27082) 
local timerWave			= mod:NewTimer(20, "TimerWave", 27082)

local wave = 0
local waves = {
	{2, L.Trainee}, -- 1
	{2, L.Trainee}, -- 2
	{2, L.Trainee}, -- 3
	{2, L.Trainee}, -- 4
	{2, L.Trainee}, -- 5
	{2, L.Trainee}, -- 6
	{2, L.Trainee}, -- 7
	{2, L.Trainee}, -- 8
	{2, L.Trainee}, -- 9
	{2, L.Trainee}, -- 10
	{2, L.Trainee}, -- 11
	{2, L.Trainee}, -- 12
	{2, L.Trainee}, -- 13
	{2, L.Trainee}, -- 14
	{2, L.Trainee}, -- 15
	{2, L.Trainee}, -- 16
	{2, L.Trainee}, -- 17
	{2, L.Trainee}, -- 18
}
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
	wave = 0
	timerPhase2:Start()
	timerWave:Start(24, wave + 1)
	warnWaveSoon:Schedule(21, wave + 1, getWaveString(wave + 1))
	self:ScheduleMethod(24, "NextWave")
end

function mod:NextWave()
	wave = wave + 1
	warnWaveNow:Show(wave, getWaveString(wave))
	if wave < 18 then
		timerWave:Start(nil, wave + 1)
		warnWaveSoon:Schedule(17, wave + 1, getWaveString(wave + 1))
		self:ScheduleMethod(20, "NextWave")
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

