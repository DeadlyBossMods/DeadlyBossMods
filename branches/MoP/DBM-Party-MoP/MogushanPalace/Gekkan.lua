local mod	= DBM:NewMod(690, "DBM-Party-MoP", 5, 321)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(61243)--61243 (Gekkan), 61337 (Glintrok Ironhide), 61338 (Glintrok Skulker), 61339 (Glintrok Oracle), 61340 (Glintrok Hexxer)
mod:SetModelID(41920)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_DIED"
)


local warnRecklessInspiration	= mod:NewTargetAnnounce(118988, 3)--Tooltip says it stacks, but i've never seen it used that way. Its CD is also it's duration.
local warnShank					= mod:NewTargetAnnounce(118963, 4, nil, false)--Rogue ability that stuns tank for 5 seconds, it can be particularly nasty for burst damage, a healer may want
local warnHexCast				= mod:NewCastAnnounce(118903, 3)--Interruptable
local warnHex					= mod:NewTargetAnnounce(118903, 4, nil, mod:IsHealer())--Dispelable

local specwarnHexDispel			= mod:NewSpecialWarningDispel(118903, mod:IsHealer())
local specwarnShank				= mod:NewSpecialWarningTarget(118903, false)
local specwarnHexInterrupt		= mod:NewSpecialWarningInterrupt(118903, false)

local timerInspiriationCD		= mod:NewNextTimer(22.5, 118988)
local timerHexCD				= mod:NewNextTimer(10, 118903)
local timerHex					= mod:NewTargetTimer(20, 118903, nil, mod:IsHealer())

local AddsLeft = 4

function mod:OnCombatStart(delay)
	AddsLeft = 4
	timerInspiriationCD:Start(19-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(118988) then
		warnRecklessInspiration:Show(args.destName)
		if AddsLeft >= 1 then
			timerInspiriationCD:Start()
		end
	elseif args:IsSpellID(118903) then
		warnHex:Show(args.destName)
		specwarnHexDispel:Show(args.destName)
		timerHex:Start(args.destName)
	elseif args:IsSpellID(118963) then
		warnShank:Show(args.destName)
		specwarnShank:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(118903) then
		timerHex:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(118903) then
		warnHexCast:Show()
		specwarnHexInterrupt:Show(args.sourceName)
		timerHexCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 61337 or cid == 61338 or cid == 61339 and self:IsInCombat() then--Combine these 3 since we do nothing special for them individually.
		AddsLeft = AddsLeft - 1
		if AddsLeft == 0 then
			timerInspiriationCD:Cancel()
		end
	elseif cid == 61340 and self:IsInCombat() then--Seperate statement for Glintrok Hexxer since we actually need to cancel a cd bar.
		AddsLeft = AddsLeft - 1
		timerHexCD:Cancel()
		if AddsLeft == 0 then
			timerInspiriationCD:Cancel()
		end
	end
end
