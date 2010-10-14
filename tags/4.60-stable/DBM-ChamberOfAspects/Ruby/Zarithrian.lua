local mod	= DBM:NewMod("Zarithrian", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39746)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"CHAT_MSG_MONSTER_YELL"
)

local warningAdds				= mod:NewAnnounce("WarnAdds", 3)
local warnCleaveArmor			= mod:NewAnnounce("warnCleaveArmor", 2, 74367, mod:IsTank() or mod:IsHealer())
local warningFear				= mod:NewSpellAnnounce(74384, 3)

local specWarnCleaveArmor		= mod:NewSpecialWarningStack(74367, nil, 2)--ability lasts 30 seconds, has a 15 second cd, so tanks should trade at 2 stacks.

local timerAddsCD				= mod:NewTimer(45.5, "TimerAdds")
local timerCleaveArmor			= mod:NewTargetTimer(30, 74367, nil, mod:IsTank() or mod:IsHealer())
local timerFearCD				= mod:NewCDTimer(33, 74384)--anywhere from 33-40 seconds in between fears.

function mod:OnCombatStart(delay)
	timerFearCD:Start(14-delay)--need more pulls to verify consistency
	timerAddsCD:Start(15.5-delay)--need more pulls to verify consistency
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(74384) then
		warningFear:Show()
		timerFearCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(74367) then
		warnCleaveArmor:Show(args.spellName, args.destName, args.amount or 1)
		timerCleaveArmor:Start(args.destName)
		if args:IsPlayer() and (args.amount or 1) >= 2 then
			specWarnCleaveArmor:Show(args.amount)
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.SummonMinions or msg:match(L.SummonMinions) then
		warningFear:Show()
		timerAddsCD:Start()
	end
end