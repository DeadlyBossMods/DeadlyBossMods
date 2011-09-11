local mod	= DBM:NewMod("Mobus", "DBM-Party-Cataclysm", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(50009)
mod:SetModelID(37338)
mod:SetZone(614, 613)--Abyssal depths, or Vashjir Main map

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warnAlgae				= mod:NewTargetAnnounce(93491, 2, nil, false)--Cast very frequently, spammy so off by default
local warnRam				= mod:NewCastAnnounce(93492, 3)
local warnWake				= mod:NewCastAnnounce(93494, 2)

local specWarnRam			= mod:NewSpecialWarningMove(93492, mod:IsTank())
local specWarnWake			= mod:NewSpecialWarningMove(93494, mod:IsMelee())
local specWarnAlgae			= mod:NewSpecialWarningMove(93490)

local timerAlgaeCD			= mod:NewCDTimer(12, 93490)
local timerRamCD			= mod:NewCDTimer(40, 93492)--40-50 second variations
local timerWakeCD			= mod:NewCDTimer(50, 93494)--50-60 second variations

function mod:AlgaeTarget()
	local targetname = self:GetBossTarget(50009)
	if not targetname then return end
	warnAlgae:Show(targetname)
	if targetname == UnitName("player") then
		specWarnAlgae:Show()
	end
end

function mod:OnCombatStart(delay)
	timerAlgaeCD:Start(10-delay)
	timerRamCD:Start(10-delay)--Not a large pool of logs to compare to.
	timerWakeCD:Start(30-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93492) and self:IsInCombat() then
		warnRam:Show()
		specWarnRam:Show()
		timerRamCD:Start()
	elseif args:IsSpellID(93494) and self:IsInCombat() then
		warnWake:Show()
		specWarnWake:Show()
		timerWakeCD:Start()
	elseif args:IsSpellID(93491) and self:IsInCombat() then
		timerAlgaeCD:Start()
		self:ScheduleMethod(0.2, "AlgaeTarget")
	end
end

function mod:SPELL_AURA_APPLIED(args)--Assumed spell event, might need to use spell damage, or spell periodic damage instead.
	if args:IsSpellID(93490) and args:IsPlayer() then
		specWarnAlgae:Show()
	end
end
