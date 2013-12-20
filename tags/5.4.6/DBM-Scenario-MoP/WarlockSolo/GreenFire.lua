if select(2, UnitClass("player")) ~= "WARLOCK" then return end
local mod	= DBM:NewMod("d594", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 1112)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

--Essence of Order
local warnSpellFlame			= mod:NewSpellAnnounce(134234, 3)
local warnHellfire				= mod:NewSpellAnnounce(134225, 3)
--Kanrethad Ebonlocke
local warnSummonPitLord			= mod:NewCastAnnounce(138789, 4, 10)
local warnSummonImpSwarm		= mod:NewCastAnnounce(138685, 3, 10)
local warnSummonDoomlord		= mod:NewCastAnnounce(138755, 3, 10)
local warnSummonFelhunter		= mod:NewCastAnnounce(138751, 3, 10)

--Essence of Order
local specWarnSpellFlame		= mod:NewSpecialWarningMove(134234)
local specWarnHellfire			= mod:NewSpecialWarningInterrupt(134225)
local specWarnLostSouls			= mod:NewSpecialWarning("specWarnLostSouls", nil, nil, nil, 2)
--Kanrethad Ebonlocke
local specWarnEnslavePitLord	= mod:NewSpecialWarning("specWarnEnslavePitLord")
local specWarnCataclysm			= mod:NewSpecialWarningInterrupt(138564)
local specWarnRainOfFire		= mod:NewSpecialWarningMove(138561)
local specWarnChaosBolt			= mod:NewSpecialWarningInterrupt(138559, nil, nil, nil, 3)

--Essence of Order
--Todo, maybe register COMBAT_REGEN_DISABLED and check warlocks target (basically what dbm core normally does) for combat start timers?
local timerSpellFlameCD			= mod:NewNextTimer(11, 134234)--(6 seconds after engage)
local timerHellfireCD			= mod:NewNextTimer(33, 134225)--(15 after engage)
local timerLostSoulsCD			= mod:NewTimer(43, "timerLostSoulsCD", 51788)--43-50 second variation. (engage is same as cd, 43)
--Kanrethad Ebonlocke
local timerCombatStarts			= mod:NewCombatTimer(33)--Honestly i'm tired of localizing this, but last time i tried to add a generic "NewCombatTimer" it didn't work, at all. Maybe someone else can do this, since we have about 20 mods that could use it
local timerPitLordCast			= mod:NewCastTimer(10, 138789)
local timerSummonImpSwarmCast 	= mod:NewCastTimer(10, 138685)
local timerSummonFelhunterCast	= mod:NewCastTimer(9, 138751)
local timerSummonDoomlordCast	= mod:NewCastTimer(10, 138755)
local timerEnslaveDemon			= mod:NewTargetTimer(300, 1098)
local timerDoom					= mod:NewBuffFadesTimer(419, 138558)

local countdownDoom				= mod:NewCountdownFades(419, 138558, nil, nil, 10)

mod:RemoveOption("HealthFrame")

local kanrathadAlive = true--So we don't warn to enslave pit lord when he dies and enslave fades.

function mod:SPELL_CAST_START(args)
	if args.spellId == 134234 then
		warnSpellFlame:Show()
		specWarnSpellFlame:Show()
		timerSpellFlameCD:Start()
	elseif args.spellId == 134225 then
		warnHellfire:Show()
		specWarnHellfire:Show(args.sourceName)
		timerHellfireCD:Start()
	elseif args.spellId == 138559 then
		specWarnChaosBolt:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 138680 then
		timerCombatStarts:Start()
		kanrathadAlive = true--Reset this here
	elseif args.spellId == 138789 then
		warnSummonPitLord:Show()
		timerPitLordCast:Start()
		specWarnEnslavePitLord:Schedule(10)
	elseif args.spellId == 138685 then
		warnSummonImpSwarm:Show()
		timerSummonImpSwarmCast:Start()
	elseif args.spellId == 138755 then
		warnSummonDoomlord:Show()
		timerSummonDoomlordCast:Start()
	elseif args.spellId == 138751 then
		warnSummonFelhunter:Show()
		timerSummonFelhunterCast:Start()
	elseif args.spellId == 138564 then
		specWarnCataclysm:Show(args.sourceName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 1098 and args:GetDestCreatureID() == 70075 then
		timerEnslaveDemon:Start(args.destName)
	elseif args.spellId == 138558 then
		timerDoom:Start()
		countdownDoom:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 1098 and args:GetDestCreatureID() == 70075 and kanrathadAlive then
		timerEnslaveDemon:Cancel(args.destName)
		specWarnEnslavePitLord:Show()
	elseif args.spellId == 138558 then
		timerDoom:Cancel()
		countdownDoom:Cancel()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 138561 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnRainOfFire:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.LostSouls then
		specWarnLostSouls:Show()
		timerLostSoulsCD:Start()
	end
end

function mod:UNIT_DIED(args)
	if args.destGUID == UnitGUID("player") then--Solo scenario, a player death is a wipe
		timerSpellFlameCD:Cancel()
		timerHellfireCD:Cancel()
		timerLostSoulsCD:Cancel()
		timerEnslaveDemon:Cancel()
		timerPitLordCast:Cancel()
		timerSummonImpSwarmCast:Cancel()
		timerSummonFelhunterCast:Cancel()
		timerSummonDoomlordCast:Cancel()
	end
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 68151 then--Essence of Order
		timerSpellFlameCD:Cancel()
		timerHellfireCD:Cancel()
		timerLostSoulsCD:Cancel()
	elseif cid == 69964 then--Kanrethad Ebonlocke
		timerEnslaveDemon:Cancel()
		kanrathadAlive = false
	end
end
