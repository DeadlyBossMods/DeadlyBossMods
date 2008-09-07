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
--[[
DBM.Schedule(27 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 1);
DBM.Schedule(47 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 2); 20
DBM.Schedule(67 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 3); 20
DBM.Schedule(77 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 4); 10
DBM.Schedule(87 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 5); 10
DBM.Schedule(102 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 6); 5
DBM.Schedule(107 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 7); 5
DBM.Schedule(127 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 8); 20
DBM.Schedule(137 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 9); 10
DBM.Schedule(147 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 10); 10
DBM.Schedule(152 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 11); 5
DBM.Schedule(167 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 12); 15
DBM.Schedule(177 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 13); 10
DBM.Schedule(187 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 14); 10
DBM.Schedule(197 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 15); 10
DBM.Schedule(202 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 16); 5
DBM.Schedule(207 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 17); 5
DBM.Schedule(227 - 3, "DBM.AddOns.Gothik.OnEvent", "WaveIncWarning", 18); 20
]]--
local waves = {
	{2, L.Trainee, next = 20},
	{2, L.Trainee, next = 20},
	{2, L.Trainee, next = 10},
	{1, L.Knight, next = 10},
	{1, L.Knight, next = 5},
	{1, L.Knight, next = 5},
	{1, L.Knight, next = 20},
	{1, L.Knight, next = 10},
	{1, L.Knight, next = 10},
	{1, L.Knight, next = 5},
	{1, L.Knight, next = 15},
	{1, L.Knight, next = 10},
	{1, L.Knight, next = 10},
	{1, L.Knight, next = 10},
	{1, L.Knight, next = 5},
	{1, L.Knight, next = 5},
	{1, L.Knight, next = 20},
	{1, L.Knight},
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
	timerWave:Start(24.5, wave + 1)
	warnWaveSoon:Schedule(21.5, wave + 1, getWaveString(wave + 1))
	self:ScheduleMethod(24.5, "NextWave")
end

function mod:NextWave()
	wave = wave + 1
	warnWaveNow:Show(wave, getWaveString(wave))
	local next = waves[wave].next
	if next then
		timerWave:Start(nil, wave + 1)
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

