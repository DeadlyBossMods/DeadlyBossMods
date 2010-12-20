local mod	= DBM:NewMod("Corborus", "DBM-Party-Cataclysm", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43438)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warnCrystalBarrage	= mod:NewSpellAnnounce(81634, 2)
local warnDampening		= mod:NewSpellAnnounce(82415, 2)
--local warnSubmerge		= mod:NewAnnounce("WarnSubmerge", 2)
--local warnEmerge		= mod:NewAnnounce("WarnEmerge", 2)

local timerDampening		= mod:NewCDTimer(10, 82415)
--local timerSubmerge		= mod:NewTimer(35, "TimerSubmerge")
--local timerEmerge		= mod:NewTimer(25, "TimerEmerge")

local specWarnCrystalBarrage	= mod:NewSpecialWarningSpell(81634) --, mod:IsMelee())

-- Dampening CD timer cancels when he goes under ground

function mod:OnCombatStart(delay)
--	timerSubmerge:Start(-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(81634) then
		specWarnCrystalBarrage:Show()
		warnCrystalBarrage:Show()
	elseif args:IsSpellID(82415) then
		warnDampening:Show()
		timerDampening:Start()
	end
end