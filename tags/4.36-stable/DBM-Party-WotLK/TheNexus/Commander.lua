local mod = DBM:NewMod("Commander", "DBM-Party-WotLK", 8)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))

if UnitFactionGroup("player") == "Alliance" then
	mod:SetCreatureID(26798)
else
	mod:SetCreatureID(26796)
end

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_CAST_START"
)

local warningFear		= mod:NewSpellAnnounce(19134, 3)
local warningWhirlwind	= mod:NewSpellAnnounce(38619, 3)
local timerFearCD		= mod:NewCDTimer(20, 19134)
local timerWhirlwindCD	= mod:NewCDTimer(15, 38619)


function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(19134) and self:IsInCombat() then
		warningFear:Show()
		timerFearCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(38619, 38618) and self:IsInCombat() then
		warningWhirlwind:Show()
		timerWhirlwindCD:Start()
	end
end