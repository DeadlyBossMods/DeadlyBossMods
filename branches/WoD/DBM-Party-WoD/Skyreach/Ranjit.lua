local mod	= DBM:NewMod(965, "DBM-Party-WoD", 7, 476)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(75964)
mod:SetEncounterID(1698)
mod:SetZone()

mod:RegisterCombat("combat")
--[[
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
	elseif spellId == 111669 and self:AntiSpam(2, 3) then
		warnPhase2:Show()
		timerFrigidGrasp:Cancel()
		timerBerserk:Cancel()
	end
end--]]
