local mod	= DBM:NewMod(659, "DBM-Party-MoP", 7, 246)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(58633)--58633 is boss, 58664 is Phylactery. UNIT_DIED event fires when Phylactery kills. (both 58633, 58644). so we can use 58633 only.
--mod:SetModelID(40301)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnTouchGrave	= mod:NewSpellAnnounce(111606, 4)
local warnFrigidGrasp	= mod:NewSpellAnnounce(111209, 3)
local warnPhase2		= mod:NewPhaseAnnounce(2)

local specWarnIceWave	= mod:NewSpecialWarningMove(120037)--The wave slowly approaches group from back wall, if you choose a bad place to stand, this will tell you to move your ass to a better spot before you die

local timerFrigidGrasp	= mod:NewNextTimer(10.5, 111209)
local timerBerserk		= mod:NewBerserkTimer(134)--not a physical berserk but rathor how long until icewall consumes entire room.

function mod:OnCombatStart(delay)
	timerFrigidGrasp:Start(-delay)
	timerBerserk:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(111606) then
		warnTouchGrave:Show()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)--120037 is a weak version of same spell by exit points, 115219 is the 50k per second icewall that will most definitely wipe your group if it consumes the room cause you're dps sucks.
	if (spellId == 120037 or spellId == 115219) and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnIceWave:Show()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 111209 and self:AntiSpam(2, 2) then
		warnFrigidGrasp:Show()
		timerFrigidGrasp:Start()
--	"<330.7> Phylactery [[boss2:Summon Books::0:111669]]"
	elseif spellId == 111669 and self:AntiSpam(2, 3) then
		warnPhase2:Show()
		timerFrigidGrasp:Cancel()
		timerBerserk:Cancel()
	end
end
