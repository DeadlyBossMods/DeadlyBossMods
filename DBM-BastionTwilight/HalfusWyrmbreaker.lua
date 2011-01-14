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

local warnBreath			= mod:NewSpellAnnounce(83710, 3)
local warnFuriousRoar		= mod:NewSpellAnnounce(83710, 3)
local warnCycloneWinds		= mod:NewSpellAnnounce(83612, 3)
local warnTimeDilation		= mod:NewSpellAnnounce(83601, 3)
local warnVengeance			= mod:NewSpellAnnounce(87683, 3)
local warnShadowNova		= mod:NewSpellAnnounce(87683, 3)
--local warnBarrage			= mod:NewSpellAnnounce(83706, 3)--This is not showing in combat log, no cast, or aura, only damage, but i don't think it's that important anyways.

local specWarnShadowNova	= mod:NewSpecialWarningInterrupt(83703, false)

local timerFuriousRoar		= mod:NewCDTimer(30, 83710)
--local timerBarrageCD		= mod:NewCDTimer(32, 83706)
local timerBreathCD			= mod:NewCDTimer(20, 83707)--every 20-25 seconds.
--local timerBarrage			= mod:NewBuffActiveTimer(10, 83706)

local berserkTimer			= mod:NewBerserkTimer(360)

local spamFuriousRoar = 0

function mod:OnCombatStart(delay)
	spamFuriousRoar = 0
	berserkTimer:Start(-delay)
	timerBreathCD:Start(10-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(87683) then
		warnVengeance:Show()
--[[	elseif args:IsSpellID(83706) then
		warnBarrage:Show()
		timerBarrage:Start()
		timerBarrageCD:Start()--]]
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(83710, 86169, 86170, 86171) and GetTime() - spamFuriousRoar > 6 then
		warnFuriousRoar:Show()
		timerFuriousRoar:Start()
		spamFuriousRoar = GetTime()
	elseif args:IsSpellID(83707) then
		warnBreath:Show()
		timerBreathCD:Start()
	elseif args:IsSpellID(83703, 86166, 86167, 86168) then
		warnShadowNova:Show()
		if self:GetUnitCreatureId("target") == 44600 or self:GetUnitCreatureId("focus") == 44600 then--Don't annoy tanks or dps or healers with this nonsense when they aren't targeting halfus.
			specWarnShadowNova:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(83612) then--84092?
		warnCycloneWinds:Show()
	elseif args:IsSpellID(83601) then
		warnTimeDilation:Show()
	end
end