local mod	= DBM:NewMod("DrahgaShadowburner", "DBM-Party-Cataclysm", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(40319)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_SUMMON",
	"CHAT_MSG_MONSTER_YELL"
)

local warnFlame		= mod:NewSpellAnnounce(75321, 3)
local warnDevouring	= mod:NewSpellAnnounce(90950, 3)
local warnShredding	= mod:NewSpellAnnounce(75271, 3)

local timerFlame	= mod:NewCDTimer(27, 75321)
local timerDevouring	= mod:NewBuffActiveTimer(5, 90950)
local timerShredding	= mod:NewBuffActiveTimer(20, 75271)

local specWarnFlamingFixate	= mod:NewSpecialWarningYou(82850)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(82850) and args:IsPlayer() then
		specWarnFlamingFixate:Show()
	elseif args:IsSpellID(75328) then
		DBM.BossHealth:RemoveBoss(40320)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(75321, 90973) then
		warnFlame:Show()
		timerFlame:Start()
	elseif args:IsSpellID(90950) then
		warnDevouring:Show()
		timerDevouring:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(75271, 90966) then
		warnShredding:Show()
		timerShredding:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.ValionaYell then
		DBM.BossHealth:AddBoss(40320, L.Valiona)
	end
end