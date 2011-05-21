local mod	= DBM:NewMod("Baleroc", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(53494)
mod:SetModelID(38621) -- Temporary till real modelID is known
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warnDecimationBlade	= mod:NewSpellAnnounce(99352, 3)
local warnInfernoBlade		= mod:NewSpellAnnounce(99350, 3)
local warnShardsTorment		= mod:NewSpellAnnounce(99259, 3)

local timerBladeActive		= mod:NewTimer(15, "TimerBladeActive")
local timerBladeNext		= mod:NewTimer(30, "TimerBladeNext")	-- either Decimation Blade or Inferno Blade
local timerShardsTorment	= mod:NewCDTimer(33, 99259)


function mod:OnCombatStart(delay)
	timerBladeNext:Start(-delay)
	timerShardsTorment:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(99352) then
		warnDecimationBlade:Show()
		timerBladeActive:Start(args.spellName)
		timerBladeNext:Start()
	elseif args:IsSpellID(99350) then
		warnInfernoBlade:Show()
		timerBladeActive:Start(args.spellName)
		timerBladeNext:Start()
	end
end