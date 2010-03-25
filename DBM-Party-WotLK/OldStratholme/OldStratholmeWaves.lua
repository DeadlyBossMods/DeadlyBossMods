local mod	= DBM:NewMod("StratWaves", "DBM-Party-WotLK", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))

mod:RegisterEvents(
	"UPDATE_WORLD_STATES",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_SAY"
)

local warningWaveNow	= mod:NewAnnounce("WarningWaveNow", 3)
local timerWaveIn		= mod:NewTimer(30, "TimerWaveIn")
local timerRoleplay		= mod:NewTimer(162, "TimerRoleplay")

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
	{1, L.Devouring, 1, L.Enraged, 1, L.Necro, 1, L.Fiend},
	{1, L.Necro, 4, L.Acolyte, 1, L.Fiend},
	{L.Meathook},
	{1, L.Devouring, 1, L.Necro, 1, L.Fiend, 1, L.Stalker},
	{1, L.Devouring, 2, L.Enraged, 1, L.Abom},
	{1, L.Devouring, 1, L.Enraged, 1, L.Necro, 1, L.Abom},
	{1, L.Devouring, 1, L.Necro, 1, L.Fiend, 1, L.Abom},
	{L.Salramm},
}

local waves		= wavesNormal
local lastWave	= 0

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
	local text = select(3, GetWorldStateUIInfo(2))
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
		warningWaveNow:Show(wave, getWaveString(wave))
		lastWave = wave
	end
end

function mod:UNIT_DIED(args)
	if bit.band(args.destGUID:sub(0, 5), 0x00F) == 3 then
		local z = mod:GetCIDFromGUID(args.destGUID)
		if z == 26529 then
			timerWaveIn:Start()
		end
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.Roleplay or msg:find(L.Roleplay) then
		timerRoleplay:Start()--Arthas preaches to uther and jaina
	elseif msg == L.Roleplay2 or msg:find(L.Roleplay2) then
		timerRoleplay:Start(106)--Arthas prances around blabbing with malganis
	end
end