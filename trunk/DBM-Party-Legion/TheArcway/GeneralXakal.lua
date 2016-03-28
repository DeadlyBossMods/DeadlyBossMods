local mod	= DBM:NewMod(1499, "DBM-Party-Legion", 6, 726)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(98206)
mod:SetEncounterID(1828)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 197776 212030 197810",
	"CHAT_MSG_MONSTER_YELL"
)

local specWarnBat					= mod:NewSpecialWarningSwitch("ej12489", "Tank", nil, nil, 1, 2)
local specWarnFissure				= mod:NewSpecialWarningDodge(197776, nil, nil, nil, 2, 2)
local specWarnSlash					= mod:NewSpecialWarningSpell(212030, nil, nil, nil, 2, 2)
local specWarnSlam					= mod:NewSpecialWarningSpell(197810, nil, nil, nil, 3, 2)

local timerBatCD					= mod:NewNextTimer(20, "ej12489", nil, nil, nil, 1, 183219)--Independant from boss and always 20-20.5
--Both 13 unless delayed by other interactions. Seems similar to archimondes timer code with a hard ICD mechanic.
local timerFissureCD				= mod:NewCDTimer(13.2, 197776, nil, nil, nil, 3)
local timerSlashCD					= mod:NewCDTimer(13.2, 212030, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerSlamCD					= mod:NewCDTimer(47, 197810, nil, nil, nil, 2)--Possibly 40 but delayed by ICD triggering

local voiceBat						= mod:NewVoice("ej12489", "Tank")--mobsoon
local voiceFissure					= mod:NewVoice(197776)--watchstep
local voiceSlash					= mod:NewVoice(212030)--watchwave
local voiceSlam						= mod:NewVoice(197810)--carefly

--Boss seems to have intenal 6 second ICD and cannot cast any two spells within 6 seconds of another (minus summon bats)
local function updateAlltimers(ICD)
	if timerFissureCD:GetRemaining() < ICD then
		local elapsed, total = timerFissureCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerFissureCD extended by: "..extend, 2)
		timerFissureCD:Cancel()
		timerFissureCD:Update(elapsed, total+extend)
	end
	if timerSlashCD:GetRemaining() < ICD then
		local elapsed, total = timerSlashCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerSlashCD extended by: "..extend, 2)
		timerSlashCD:Cancel()
		timerSlashCD:Update(elapsed, total+extend)
	end
	if timerSlamCD:GetRemaining() < ICD then
		local elapsed, total = timerSlamCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerSlamCD extended by: "..extend, 2)
		timerSlamCD:Cancel()
		timerSlamCD:Update(elapsed, total+extend)
	end
end

function mod:OnCombatStart(delay)
	timerFissureCD:Start(5-delay)
	timerBatCD:Start(10-delay)
	timerSlashCD:Start(13-delay)
	timerSlamCD:Start(39.8-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 197776 then
		specWarnFissure:Show()
		voiceFissure:Play("watchstep")
		timerFissureCD:Start()
		updateAlltimers(6)
	elseif spellId == 212030 then
		specWarnSlash:Show()
		voiceSlash:Play("watchwave")
		timerSlashCD:Start()
		updateAlltimers(6)
	elseif spellId == 197810 then
		specWarnSlam:Show()
		voiceSlam:Play("carefly")
		timerSlamCD:Start()
		updateAlltimers(7)--Verify is actually 7 and not 6 like others
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.batSpawn then
		self:SendSync("summonBat")
	end
end

function mod:OnSync(msg)
	if msg == "summonBat" then
		specWarnBat:Show()
		voiceBat:Play("mobsoon")
		timerBatCD:Start()
	end
end
