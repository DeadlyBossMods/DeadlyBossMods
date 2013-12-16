local mod	= DBM:NewMod(659, "DBM-Party-MoP", 7, 246)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(58633, 58664)--58633 is boss, 58664 is Phylactery. We register BOTH to avoid pre mature combat ending cause boss dies twice.
--To re-emphesize again (although it was already spelled out in comments. THE BOSS DIES TWICE, if you only register 58633 then the boss will fire EndCombat at end of phase 1.
--THIS is why we also register 58664, so end combat does not fire until the boss is actually dead
--that said, the way dbm works, registering UNIT_DIED was overkill in original code
--Just adding both CIDs to combat table will suffice, 58633 will be removed in phase 1 sure, but 58664 stays in table until boss actually dies completely so all is good.
mod:SetEncounterID(1426)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
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
	if args.spellId == 111606 then
		warnTouchGrave:Show()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 120037 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
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
