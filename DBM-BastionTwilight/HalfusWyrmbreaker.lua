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

local warnShadowNova	= mod:NewSpellAnnounce(83703, 3)
local warnCycloneWinds	= mod:NewSpellAnnounce(83612, 3)
local warnTimeDilation	= mod:NewSpellAnnounce(83601, 3)
local warnVengeance	= mod:NewSpellAnnounce(87683, 3)
local warnBarrage	= mod:NewSpellAnnounce(83706, 3)

local timerBarrageCD	= mod:NewCDTimer(32, 83706)
local timerBarrage	= mod:NewBuffActiveTimer(10, 83706)

function mod:OnCombatStart(delay)
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
	if args:IsSpellID(83703) then
		warnShadowNova:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(83612) then
		warnCycloneWinds:Show()
	elseif args:IsSpellID(83601) then
		warnTimeDilation:Show()
	end
end