local mod	= DBM:NewMod("Altairus", "DBM-Party-Cataclysm", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43873)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warnBreath		= mod:NewTargetAnnounce(88308, 3)

local specWarnBreath	= mod:NewSpecialWarningMove(88308) --Phase 2+ Ability

local timerBreath		= mod:NewCastTimer(2, 88308)
local timerBreathCD		= mod:NewCDTimer(12, 88308)

mod:AddBoolOption("BreathIcon")

function mod:BreathTarget()
	local targetname = self:GetBossTarget(43873)
	if not targetname then return end
		warnBreath:Show(targetname)
		if self.Options.BreathIcon then
			self:SetIcon(targetname, 8, 10)
		end
	if targetname == UnitName("player") then
		specWarnBreath:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(88308, 93989) then
		self:ScheduleMethod(0.2, "BreathTarget")
		timerBreath:Start()
		timerBreathCD:Start()
	end
end