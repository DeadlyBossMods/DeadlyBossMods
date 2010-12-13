local mod	= DBM:NewMod("HalfusWyrmbreaker", "DBM-BastionTwilight", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(44600)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnFuriousRoar	= mod:NewSpellAnnounce(83710, 3)
local warnCycloneWinds	= mod:NewSpellAnnounce(83612, 3)
local warnTimeDilation	= mod:NewSpellAnnounce(83601, 3)
local warnVengeance	= mod:NewSpellAnnounce(87683, 3)
local warnBarrage	= mod:NewSpellAnnounce(83706, 3)

local timerFuriousRoar	= mod:NewCDTimer(30, 83710)
local timerBarrageCD	= mod:NewCDTimer(32, 83706)
local timerBarrage	= mod:NewBuffActiveTimer(10, 83706)

local berserkTimer	= mod:NewBerserkTimer(360)

local spamFuriousRoar
function mod:OnCombatStart(delay)
	spamFuriousRoar = GetTime()
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(87683) then
		warnVengeance:Show()
	elseif args:IsSpellID(83706) then
		warnBarrage:Show()
		timerBarrage:Start()
		timerBarrageCD:Start()
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(83710, 86169, 86170, 86170) and GetTime() - spamFuriousRoar > 6 then
		warnFuriousRoar:Show()
		timerFuriousRoar:Start()
		spamFuriousRoar = GetTime()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(83612) then--84092?
		warnCycloneWinds:Show()
	elseif args:IsSpellID(83601) then
		warnTimeDilation:Show()
	end
end