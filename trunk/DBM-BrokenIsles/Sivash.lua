local wowTOC, testBuild = DBM:GetTOC()
if not testBuild and wowTOC < 70200 then return end
local mod	= DBM:NewMod(1885, "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(117470)
--mod:SetEncounterID(1880)--Bosses don't fire BOSS_KILL or have encounter IDs at time of this update
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 233996",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnSummonHonorGuard			= mod:NewSpellAnnounce(233968, 3)

local specWarnTidalWave				= mod:NewSpecialWarningDodge(233996, nil, nil, nil, 2, 2)
local specWarnSubmerge				= mod:NewSpecialWarningDodge(241433, nil, nil, nil, 2, 2)

local timerTidalWaveCD				= mod:NewCDTimer(20.6, 233996, nil, nil, nil, 3)--20.6-24.7
local timerSummonHonorGuardCD		= mod:NewCDTimer(24, 233968, nil, nil, nil, 1)--24-25
local timerSubmergeCD				= mod:NewCDTimer(13.3, 241433, nil, nil, nil, 3)--13.3-15.9

local voiceTidalWave				= mod:NewVoice(233996)--watchwave
local voiceSubmerge					= mod:NewVoice(241433)--watchstep

--mod:AddReadyCheckOption(37460, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 233996 then
		specWarnTidalWave:Show()
		voiceTidalWave:Play("watchwave")
		timerTidalWaveCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 233968 and self:AntiSpam(4, 1) then--Summon Honor Guard
		warnSummonHonorGuard:Show()
		timerSummonHonorGuardCD:Start()
	elseif spellId == 241433 and self:AntiSpam(4, 2) then
		specWarnSubmerge:Show()
		voiceSubmerge:Play("watchstep")
		timerSubmergeCD:Start()
	end
end
