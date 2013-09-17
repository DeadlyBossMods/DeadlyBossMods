local mod	= DBM:NewMod("PlantsVsZombies", "DBM-WorldEvents", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"UNIT_SPELLCAST_SUCCEEDED player",
--	"UNIT_EXITED_VEHICLE player",
	"RAID_BOSS_WHISPER"
)

--Note, mod writen and tested in ENdless mode only. The actual quests are unverified
--Endless mode is only unlockable via unofficial means.
local warnZombie				= mod:NewSpellAnnounce(91739, 2, nil, false)--Likely Spammy
local warnGhoul					= mod:NewSpellAnnounce(91834, 2, nil, false)--Possibly Spammy
local warnAberration			= mod:NewSpellAnnounce(92228, 3)
local warnAbomination			= mod:NewSpellAnnounce(92606, 4)
local warnTotalAdds				= mod:NewAnnounce("warnTotalAdds", 2)

local specWarnWave				= mod:NewSpecialWarning("specWarnWave", nil, nil, nil, true)

--local timerWave					= mod:NewTimer(170, "timerWave")

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local wave = 0
local addCount = 0

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellID)
	if spellID == 92816 then--Create Battery (Game Start)
--		timerWave:Start(285)
		wave = 0
		addCount = 0
	elseif spellID == 91739 then--Zombie
		addCount = addCount + 1
		warnZombie:Show()
	elseif spellID == 91834 then--Ghoul
		addCount = addCount + 1
		warnGhoul:Show()
	elseif spellID == 92228 then--Aberration
		addCount = addCount + 1
		warnAberration:Show()
	elseif spellID == 92606 then--Abomination
		addCount = addCount + 1
		warnAbomination:Show()
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg == L.MassiveWave or msg:find(L.MassiveWave) then
		wave = wave + 1
		warnTotalAdds:Show(addCount)
		addCount = 0
		specWarnWave:Show()
		--Need more data to confirm this, timing may be based off something else more accurate
--[[		if wave == 1 then
			timerWave:Start(298)
		elseif wave == 2 then
			timerWave:Start(230)
		elseif wave == 3 then
			timerWave:Start(240)
		elseif wave == 4 then
			timerWave:Start(170)
		elseif wave == 5 then
			timerWave:Start(198)
		end	-]]
	end
end

function mod:UNIT_EXITED_VEHICLE(uId)
--	timerWave:Cancel()
end

