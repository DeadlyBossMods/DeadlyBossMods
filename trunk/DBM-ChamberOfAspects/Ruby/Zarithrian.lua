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
local warnCleaveArmor			= mod:NewAnnounce("warnCleaveArmor", 2, 74367)
local warningFear				= mod:NewSpellAnnounce(74384, 3)

local specWarnCleaveArmor		= mod:NewSpecialWarningStack(74367, nil, 2)

local timerAddsCD				= mod:NewTimer(45.5, "TimerAdds")
local timerCleaveArmor			= mod:NewTimer(30, 74367)
local timerFearCD				= mod:NewCDTimer(33, 74384)--typically every 40 seconds but soemtimes earlier.

function mod:OnCombatStart(delay)
	timerFearCD:Start(15-delay)
	timerAddsCD:Start(15-delay)
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
	if msg:match(L.SummonMinions) and mod:LatencyCheck() then
		self:SendSync("SummonMinions")
	end
end

function mod:OnSync(msg)
	if msg == "SummonMinions" then
		warningFear:Show()
		timerAddsCD:Start()
	end
end