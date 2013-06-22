if GetBuildInfo() ~= "5.4.0" then return end
local mod	= DBM:NewMod(857, "DBM-Pandaria", nil, 322)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(72462)
--mod:SetQuestID(32519)--Note, this is currently bugged and returns nalak's answer (ie, yes if nalak has been killed no if nalak hasn't, it doesn't reference oondasta at all until blizzard fixes it)
mod:SetZone()

mod:RegisterCombat("combat")
--[[
mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local warnCrush					= mod:NewStackAnnounce(137504, 2, nil, mod:IsTank() or mod:IsHealer())--Cast every 30 seconds roughly, lasts 1 minute. you need 3 tanks to be able to tank the boss without debuff. 2 tanks CAN do but they will always have 1 stack and take 25% more damage
local warnPiercingRoar			= mod:NewSpellAnnounce(137457, 2, nil)
local warnSpiritfireBeam		= mod:NewTargetAnnounce(137511, 3)
local warnFrillBlast			= mod:NewSpellAnnounce(137505, 4)--While this SHOULD be a tank only warning, thanks to terrible blizzard design, this fight is anything but a tanked fight, so it's now an everyone warning since god knows what fucking way the boss will be facing when he casts this

local specWarnCrush				= mod:NewSpecialWarningStack(137504, mod:IsTank(), 2)
local specWarnCrushOther		= mod:NewSpecialWarningTarget(137504, mod:IsTank())--This should not go over 1 stack so don't need stack warning just a "taunt the boss" warning
local specWarnPiercingRoar		= mod:NewSpecialWarningCast(137457, mod:IsRanged() or mod:IsHealer())
local specWarnFrillBlast		= mod:NewSpecialWarningSpell(137505, nil, nil, nil, 2)

local timerCrush				= mod:NewTargetTimer(60, 137504, nil, mod:IsTank() or mod:IsHealer())
local timerCrushCD				= mod:NewCDTimer(26, 137504)
local timerPiercingRoarCD		= mod:NewCDTimer(25, 137457)--25-60sec variation (i'm going to guess like all the rest of the variations, the timers are all types of fucked up when the boss is running around untanked, which delays casts of crush and frill blast, but makes him cast spitfire twice as often)
--local timerSpiritfireBeamCD		= mod:NewCDTimer(25, 137511)--25-30sec variation (disabled because he also seems to spam it far more often if there is no tank, making it difficult to find an ACTUAL cd when fight is done incorrectly
local timerFrillBlastCD			= mod:NewCDTimer(25, 137505)--25-30sec variation

mod:AddBoolOption("RangeFrame", true)

local yellTriggered = false

function mod:OnCombatStart(delay)
	if yellTriggered then--We know for sure this is an actual pull and not diving into in progress
--		timerCrushCD:Start(-delay)--There was no tank, so he pretty much never cast this, just ran like a wild animal around area while corpse cannoned
--		timerSpiritfireBeamCD:Start(15-delay)
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
	yellTriggered = false
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 137457 then
		warnPiercingRoar:Show()
		specWarnPiercingRoar:Show()
		timerPiercingRoarCD:Start()
	elseif args.spellId == 137505 then
		warnFrillBlast:Show()
		specWarnFrillBlast:Show()
		timerFrillBlastCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(137508, 137511) then
		warnSpiritfireBeam:Show(args.destName)
--		timerSpiritfireBeamCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 137504 then
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
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED--<--if this happens you're doing fight wrong. But we announce it anyways to identify the problem

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 137504 then
		timerCrush:Cancel(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Pull and not self:IsInCombat() then
		if self:GetCIDFromGUID(UnitGUID("target")) == 69161 or self:GetCIDFromGUID(UnitGUID("targettarget")) == 69161 then--Whole zone gets yell, so lets not engage combat off yell unless he is our target (or the target of our target for healers)
			yellTriggered = true
			DBM:StartCombat(self, 0)
		end
	end
end
--]]
