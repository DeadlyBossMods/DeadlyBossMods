local mod	= DBM:NewMod(690, "DBM-Party-MoP", 5, 321)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(61243, 61337, 61338, 61339, 61340)--61243 (Gekkan), 61337 (Glintrok Ironhide), 61338 (Glintrok Skulker), 61339 (Glintrok Oracle), 61340 (Glintrok Hexxer)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_DIED"
)

local warnRecklessInspiration	= mod:NewStackAnnounce(118988, 3)
local warnIronProtector			= mod:NewTargetAnnounce(118958, 2)
local warnShank					= mod:NewCastAnnounce(118963, 4)--Interruptable
local warnCleansingFlame		= mod:NewCastAnnounce(118940, 3)
local warnHexCast				= mod:NewCastAnnounce(118903, 3)--Interruptable
local warnHex					= mod:NewTargetAnnounce(118903, 4, nil, mod:IsHealer())--Dispelable

local specWarnShank				= mod:NewSpecialWarningInterrupt(118963, false)--specWarns can be spam. Default value is off. Use this manually.
local specWarnCleansingFlame	= mod:NewSpecialWarningInterrupt(118940, false)
local specWarnHexInterrupt		= mod:NewSpecialWarningInterrupt(118903, false)
local specWarnHexDispel			= mod:NewSpecialWarningDispel(118903, false)

local timerInspiriation			= mod:NewTargetTimer(20, 118988)
local timerIronProtector		= mod:NewTargetTimer(15, 118958)
local timerHexCD				= mod:NewCDTimer(9, 118903)
local timerHex					= mod:NewTargetTimer(20, 118903, nil, mod:IsHealer())

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(118988, 129262) then
		warnRecklessInspiration:Show(args.destName, 1)
		timerInspiriation:Start(20, args.destName)
	elseif args.spellId == 118958 then
		warnIronProtector:Show(args.destName)
		timerIronProtector:Start(args.destName)
	elseif args.spellId == 118903 then
		warnHex:Show(args.destName)
		specWarnHexDispel:Show(args.destName)
		timerHex:Start(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args.spellId == 129262 then
		warnRecklessInspiration:Show(args.destName, args.amount or 1)
		timerInspiriation:Start(21, args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(118988, 129262) then
		timerInspiriation:Cancel(args.destName)
	elseif args.spellId == 118903 then
		timerHex:Cancel(args.destName)
	elseif args.spellId == 118958 then
		timerIronProtector:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 118903 then
		warnHexCast:Show()
		specWarnHexInterrupt:Show(args.sourceName)
		timerHexCD:Start()
	elseif args.spellId == 118963 then
		warnShank:Show()
		specWarnShank:Show(args.sourceName)
	elseif args.spellId == 118940 then
		warnCleansingFlame:Show()
		specWarnCleansingFlame:Show(args.sourceName)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 61340 and self:IsInCombat() then--Seperate statement for Glintrok Hexxer since we actually need to cancel a cd bar.
		timerHexCD:Cancel()
	end
end
