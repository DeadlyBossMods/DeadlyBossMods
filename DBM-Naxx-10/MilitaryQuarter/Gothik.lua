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
	{L.Nothing, L.Trainee, L.Trainee}, -- 1
	{L.Nothing, L.Trainee, L.Trainee}, -- 2
	{L.Nothing, L.Trainee, L.Trainee}, -- 3
	{L.Nothing, L.Trainee, L.Trainee}, -- 4
	{L.Nothing, L.Trainee, L.Trainee}, -- 5
	{L.Nothing, L.Trainee, L.Trainee}, -- 6
	{L.Nothing, L.Trainee, L.Trainee}, -- 7
	{L.Nothing, L.Trainee, L.Trainee}, -- 8
	{L.Nothing, L.Trainee, L.Trainee}, -- 9
	{L.Nothing, L.Trainee, L.Trainee}, -- 10
	{L.Nothing, L.Trainee, L.Trainee}, -- 11
	{L.Nothing, L.Trainee, L.Trainee}, -- 12
	{L.Nothing, L.Trainee, L.Trainee}, -- 13
	{L.Nothing, L.Trainee, L.Trainee}, -- 14
	{L.Nothing, L.Trainee, L.Trainee}, -- 15
	{L.Nothing, L.Trainee, L.Trainee}, -- 16
	{L.Nothing, L.Trainee, L.Trainee}, -- 17
	{L.Nothing, L.Trainee, L.Trainee}, -- 18
}

function mod:OnCombatStart(delay)
	wave = 0
	timerPhase2:Start()
	timerWave:Start(28, wave + 1)
	warnWaveSoon:Schedule(30, wave + 1, waves[wave + 1][1], waves[wave + 1][2], waves[wave + 1][3])
end

function mod:NextWave()
	wave = wave + 1
	warnWaveNow:Show(wave, waves[wave][1], waves[wave][2], waves[wave][3])
	if wave < 18 then
		warnWaveSoon:Schedule(17, wave + 1, waves[wave + 1][1], waves[wave + 1][2], waves[wave + 1][3])
		self:ScheduleMethod(20)
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

