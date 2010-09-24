local mod	= DBM:NewMod("DrahgaShadowburner", "DBM-Party-Cataclysm", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(40319)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_SUMMON"
)

local warnFlame		= mod:NewSpellAnnounce(75321, 3)
local warnShredding	= mod:NewSpellAnnounce(75271, 3)

local timerFlame	= mod:NewCDTimer(27, 75321)
local timerShredding	= mod:NewBuffActiveTimer(20, 75271)

-- Dragon inc warning?   (Yell = "Dragon, you will do as I command! Catch me!" )

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(75321, 90973) then
		warnFlame:Show()
		timerFlame:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(75271, 90966) then
		warnShredding:Show()
		timerShredding:Start()
	end
end