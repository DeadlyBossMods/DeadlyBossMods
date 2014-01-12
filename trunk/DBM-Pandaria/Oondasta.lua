local mod	= DBM:NewMod(826, "DBM-Pandaria", nil, 322)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(69161)
mod:SetReCombatTime(20)
mod:SetZone()
mod:SetMinSyncRevision(10466)

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 137457 137505",
	"SPELL_CAST_SUCCESS 137508 137511",
	"SPELL_AURA_APPLIED 137504",
	"SPELL_AURA_APPLIED_DOSE 137504",
	"SPELL_AURA_REMOVED 137504"
)

local warnCrush					= mod:NewStackAnnounce(137504, 2, nil, mod:IsTank() or mod:IsHealer())--Cast every 30 seconds roughly, lasts 1 minute. you need 3 tanks to be able to tank the boss without debuff. 2 tanks CAN do but they will always have 1 stack and take 25% more damage
local warnPiercingRoar			= mod:NewSpellAnnounce(137457, 2)
local warnSpiritfireBeam		= mod:NewTargetAnnounce(137511, 3)
local warnFrillBlast			= mod:NewSpellAnnounce(137505, 4, nil, mod:IsTank() or mod:IsHealer())

local specWarnCrush				= mod:NewSpecialWarningStack(137504, mod:IsTank(), 2)
local specWarnCrushOther		= mod:NewSpecialWarningTarget(137504, mod:IsTank())
local specWarnPiercingRoar		= mod:NewSpecialWarningCast(137457, mod:IsRanged() or mod:IsHealer())
local specWarnFrillBlast		= mod:NewSpecialWarningSpell(137505, nil, nil, nil, 2)

local timerCrush				= mod:NewTargetTimer(60, 137504, nil, mod:IsTank() or mod:IsHealer())
local timerCrushCD				= mod:NewCDTimer(26, 137504)
local timerPiercingRoarCD		= mod:NewCDTimer(25, 137457)--25-60sec variation (i'm going to guess like all the rest of the variations, the timers are all types of fucked up when the boss is running around untanked, which delays casts of crush and frill blast, but makes him cast spitfire twice as often)
local timerFrillBlastCD			= mod:NewCDTimer(25, 137505)--25-30sec variation

mod:AddBoolOption("RangeFrame", true)
mod:AddReadyCheckOption(32519, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then--We know for sure this is an actual pull and not diving into in progress
--		timerCrushCD:Start(-delay)--There was no tank, so he pretty much never cast this, just ran like a wild animal around area while corpse cannoned
		timerPiercingRoarCD:Start(20-delay)
		timerFrillBlastCD:Start(40-delay)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)--range is guessed. spell tooltip and EJ do not save what range is right now.
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 137457 then
		warnPiercingRoar:Show()
		specWarnPiercingRoar:Show()
		timerPiercingRoarCD:Start()
	elseif spellId == 137505 then
		warnFrillBlast:Show()
		specWarnFrillBlast:Show()
		timerFrillBlastCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(137508, 137511) then
		warnSpiritfireBeam:Show(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 137504 then
		warnCrush:Show(args.destName, args.amount or 1)
		timerCrush:Start(args.destName)
		timerCrushCD:Start()
		if args:IsPlayer() and (args.amount or 1) >= 2 then
			specWarnCrush:Show(args.amount)
		else
			if (args.amount or 1) >= 2 and not UnitIsDeadOrGhost("player") or not UnitDebuff("player", GetSpellInfo(137504)) then
				specWarnCrushOther:Show(args.destName)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 137504 then
		timerCrush:Cancel(args.destName)
	end
end
