local mod	= DBM:NewMod("StratWaves", "DBM-Party-WotLK", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))

mod:RegisterEvents(
	"UPDATE_WORLD_STATES",
	"UNIT_DIED",
	"MONSTER_SAY"
)

local warningWaveNow	= mod:NewAnnounce("WarningWaveNow", 3)
local timerWaveIn		= mod:NewTimer(60, "TimerWaveIn")
local timerRollplay		= mod:NewTimer(160, "TimerRollplay")

local wavesNormal = {
	{2, L.Devouring},
	{2, L.Devouring},
	{2, L.Devouring},
	{2, L.Devouring},
	{L.Meathook},
	{2, L.Devouring},
	{2, L.Devouring},
	{2, L.Devouring},
	{2, L.Devouring},
	{L.Salramm},
}

local wavesHeroic = {
	{3, L.Devouring},
	{1, L.Devouring, 1, L.Enraged, 1, L.Necro},
	{1, L.Devouring, 1, L.Enraged, 1, L.Necro, 1, L.Friend},
	{1, L.Necro, 3, L.Acolyte, 1, L.Friend},
	{L.Meathook},
	{1, L.Devouring, 1, L.Necro, 1, Friend, 1, L.Stalker},
	{1, L.Devouring, 2, L.Enraged, 1, L.Abom},
	{1, L.Devouring, 1, L.Enraged, 1, L.Necro, 1, L.Abom},
	{1, L.Devouring, 1, L.Necro, 1, L.Friend, 1, L.Abom},
	{L.Salramm},
}

local waves		= wavesNormal
local lastwave	= 0
local wave

local function getWaveString(wave)
	local waveInfo = waves[wave]
	if #waveInfo == 1 then
		return L.WaveBoss:format(unpack(waveInfo))
	elseif #waveInfo == 2 then
		return L.Wave1:format(unpack(waveInfo))
	elseif #waveInfo == 4 then
		return L.Wave2:format(unpack(waveInfo))
	elseif #waveInfo == 6 then
		return L.Wave3:format(unpack(waveInfo))
	elseif #waveInfo == 8 then
		return L.Wave4:format(unpack(waveInfo))
	end
end

function mod:UPDATE_WORLD_STATES(args)
	if mod:IsDifficulty("heroic5") then 
		waves = wavesHeroic 
	else 
		waves = wavesNormal 
	end
	local text = select(3, GetWorldStateUIInfo(3))
	if not text then return end
	local _, _, wave = string.find(text, L.WaveCheck)
	if not wave then
		wave = 0
	end
	wave = tonumber(wave)
	lastwave = tonumber(lastwave)
	if wave > lastwave or wave == 1 then
		warningWaveNow:Show(wave, getWaveString(wave))
		lastwave = wave
	end
end

function mod:UNIT_DIED(args)
	if bit.band(args.destGUID:sub(0, 5), 0x00F) == 3 then
		local z = tonumber(args.destGUID:sub(9, 12), 16)
		if z == 26529 then
			timerWaveIn:Start()
		end
	end
end

function mod:MONSTER_SAY(msg)
	if msg == L.Rollplay or msg:find(L.Rollplay) then
		self:SendSync("Rollplay")
	end
end

function mod:OnSync(msg, arg)
	if msg == "Rollplay" then
		timerRollplay:Start()
	end
end