local mod	= DBM:NewMod(659, "DBM-Party-MoP", 7, 246)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(58633, 58664)--58633 is boss, 58664 is Phylactery. We register 58664 to avoid pre mature combat ending cause boss dies twice.
--mod:SetModelID(40301)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_DAMAGE",
	"UNIT_DIED"
)

local specwarnIceWave	= mod:NewSpecialWarningMove(115219)--The wave slowly approaches group from back wall, if you choose a bad place to stand, this will tell you to move your ass to a better spot before you die

local berserkTimer		= mod:NewBerserkTimer(134)--not a physical berserk but rathor how long until icewall consumes entire room.

local bossDiedOnce = false

function mod:OnCombatStart(delay)
	bossDiedOnce = false
	timerBerserk:Start(-delay)
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)--120037 is a weak version of same spell by exit points, 115219 is the 50k per second icewall that will most definitely wipe your group if it consumes the room cause you're dps sucks.
	if (spellId == 120037 or spellId == 115219) and destGUID == UnitGUID("player") and self:AntiSpam() then
		specwarnIceWave:Show()
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 58633 and not bossDiedOnce then--Phase 2
		bossDiedOnce = true
		berserkTimer:Cancel()
	elseif self:GetCIDFromGUID(args.destGUID) == 58664 then
		DBM:EndCombat(self)
	end
end
