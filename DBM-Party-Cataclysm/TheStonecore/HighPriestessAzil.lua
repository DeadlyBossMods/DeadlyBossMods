local mod	= DBM:NewMod("HighPriestessAzil", "DBM-Party-Cataclysm", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(42333)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnShield	= mod:NewSpellAnnounce(82858, 2)
local warnGrip		= mod:NewTargetAnnounce(79351, 3)
local warnCurse		= mod:NewTargetAnnounce(79345, 3)
local warnWell		= mod:NewSpellAnnounce(79340, 2)
local warnShard		= mod:NewSpellAnnounce(79002, 2)

local timerGrip		= mod:NewTargetTimer(5, 79351)
local timerCurse	= mod:NewTargetTimer(15, 79345)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(79351) and args:IsDestTypePlayer() then
		warnGrip:Show(args.destName)
		timerGrip:Start(args.destName)
	elseif args:IsSpellID(79345, 92663) then
		warnCurse:Show(args.destName)
		timerCurse:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(79345, 92663) then
		timerCurse:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(82858, 92667) then
		warnShield:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(79340) then
		warnWell:Show()
	elseif args:IsSpellID(79002) then
		warnShard:Show()
	end
end