local mod	= DBM:NewMod("Zarithrian", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39746)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL"
)

local warningAdds					= mod:NewAnnounce("WarnAdds", 3)
local warningFear					= mod:NewSpellAnnounce(74384, 3)

local timerAddsCD					= mod:NewNextTimer(45.5, "TimerAdds")
local timerFearCD					= mod:NewNextTimer(35, 74384)

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

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg:match(L.SummonMinions) then
		self:SendSync("SummonMinions")
	end
end

function mod:OnSync(msg)
	if msg == "SummonMinions" then
		warningFear:Show()
		timerAddsCD:Start()
	end
end