local mod = DBM:NewMod("Zereketh", "DBM-Party-BC", 15)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))

mod:SetCreatureID(20870)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnNova      = mod:NewSpellAnnounce(39005)
local warnVoid      = mod:NewSpellAnnounce(36119)
local warnSoC       = mod:NewTargetAnnounce(39367)
local timerSoC      = mod:NewTargetTimer(18, 39367)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(36127, 39005) then
		warnNova:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(36119, 30533) then
		warnVoid:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(39367, 32863) then
		warnSoC:Show(args.destName)
		timerSoC:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(39367, 32863) then
		timerSoC:Cancel(args.destName)
	end
end