local mod	= DBM:NewMod("Volazj", "DBM-Party-WotLK", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(29311)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warningInsanity	= mod:NewCastAnnounce(57496, 3)--Not currently working, no CLEU for it
local timerInsanity		= mod:NewCastTimer(5, 57496)--Not currently working, no CLEU for it
local timerAchieve		= mod:NewAchievementTimer(120, 1862, "TimerSpeedKill") 

function mod:OnCombatStart(delay)
	if mod:IsDifficulty("heroic5") then
		timerAchieve:Start(-delay)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(57496) then
		warningInsanity:Show()
		timerInsanity:Start()
	end
end