local mod = DBM:NewMod("Kronus", "DBM-Party-WotLK", 6)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28923)
mod:SetZone()

mod:RegisterCombat("combat")

local warningNova	= mod:NewSpellAnnounce(52960, 3)
local timerNovaCD	= mod:NewCDTimer(30, 52960)
local timerAchieve	= mod:NewAchievementTimer(120, 1867, "TimerSpeedKill") 

mod:RegisterEvents(
	"SPELL_CAST_START"
)

function mod:OnCombatStart(delay)
	if mod:IsDifficulty("heroic5") then
		timerAchieve:Start(-delay)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 52960 or args.spellId == 59835 then
		warningNova:Show(args.spellName)
		timerNovaCD:Start(args.spellName)
	end
end