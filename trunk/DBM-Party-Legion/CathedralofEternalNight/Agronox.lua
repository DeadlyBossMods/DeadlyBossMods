local mod	= DBM:NewMod(1905, "DBM-Party-Legion", 12, 900)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(91007)
--mod:SetEncounterID(1793)
mod:SetZone()

mod:RegisterCombat("combat")

--[[
mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnCrystalSpikes				= mod:NewSpellAnnounce(200551, 2)

local specWarnMoltenCrash			= mod:NewSpecialWarningDefensive(200732, "Tank", nil, nil, 3, 2)

local timerMoltenCrashCD			= mod:NewCDTimer(16.5, 200732, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--16.5-23

local countdownMagmaWave			= mod:NewCountdown(60, 200404)

local voiceMoltenCrash				= mod:NewVoice(200732, "Tank")--defensive

function mod:OnCombatStart(delay)

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 200732 then
		specWarnMoltenCrash:Show()
		voiceMoltenCrash:Play("defensive")
		timerMoltenCrashCD:Start()
	end
end

--]]