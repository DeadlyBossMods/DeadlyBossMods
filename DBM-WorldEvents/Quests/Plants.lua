local mod	= DBM:NewMod("PlantsVsZombies", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(string.sub("@file-date-integer@", 1, -5))
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"UNIT_SPELLCAST_SUCCEEDED player",
	"RAID_BOSS_WHISPER"
)
mod.noStatistics = true

--Note, mod writen and tested in ENdless mode only. The actual quests are unverified
--Endless mode is only unlockable via unofficial means.
local warnZombie				= mod:NewSpellAnnounce(91739, 2, nil, false)--Likely Spammy
local warnGhoul					= mod:NewSpellAnnounce(91834, 2, nil, false)--Possibly Spammy
local warnAberration			= mod:NewSpellAnnounce(92228, 3)
local warnAbomination			= mod:NewSpellAnnounce(92606, 4)
local warnTotalAdds				= mod:NewAnnounce("warnTotalAdds", 2)

local specWarnWave				= mod:NewSpecialWarning("specWarnWave", nil, nil, nil, 2, 2)

local wave = 0
local addCount = 0

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 92816 then--Create Battery (Game Start)
		wave = 0
		addCount = 0
	elseif spellId == 91739 then--Zombie
		addCount = addCount + 1
		warnZombie:Show()
	elseif spellId == 91834 then--Ghoul
		addCount = addCount + 1
		warnGhoul:Show()
	elseif spellId == 92228 then--Aberration
		addCount = addCount + 1
		warnAberration:Show()
	elseif spellId == 92606 then--Abomination
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
		specWarnWave:Play("mobsoon")
	end
end
