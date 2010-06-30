local mod	= DBM:NewMod("Saviana", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39747)
mod:SetUsedIcons(8, 7, 6, 5, 4)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warningWarnBeacon		= mod:NewTargetAnnounce(74453, 4)--Will change to a target announce if possible. need to do encounter
local warningWarnEnrage		= mod:NewSpellAnnounce(78722, 3)
local warningWarnBreath		= mod:NewSpellAnnounce(74404, 3)

local specWarnBeacon		= mod:NewSpecialWarningYou(74453)--Target scanning may not even work since i haven't done encounter yet it's just a guess.
local specWarnTranq			= mod:NewSpecialWarning("SpecialWarningTranq", mod:CanRemoveEnrage())

local timerBeacon			= mod:NewBuffActiveTimer(5, 74453)
local timerConflag			= mod:NewBuffActiveTimer(5, 74456)
local timerConflagCD		= mod:NewNextTimer(35, 74452)
local timerBreath			= mod:NewNextTimer(35, 74404)
local timerEnrage			= mod:NewBuffActiveTimer(10, 78722)

mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("BeaconIcon")

local beaconTargets = {}
local beaconIcon 	= 8

local function warnConflagTargets()
	warningWarnBeacon:Show(table.concat(beaconTargets, "<, >"))
	table.wipe(beaconTargets)
	beaconIcon = 8
end

function mod:OnCombatStart(delay)
	timerConflagCD:Start(33-delay)
	timerBreath:Start(45-delay)
	table.wipe(beaconTargets)
	beaconIcon = 8
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(74403, 74404) then
		warningWarnBreath:Show()
		timerBreath:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(78722) then
		warningWarnEnrage:Show()
		specWarnTranq:Show()
		timerEnrage:Start()
	elseif args:IsSpellID(74453) then
		beaconTargets[#beaconTargets + 1] = args.destName
		timerConflagCD:Start()
		timerBeacon:Start()
		timerConflag:Schedule(5)
		if args:IsPlayer() then
			specWarnBeacon:Show()
		end
		if self.Options.BeaconIcon then
			self:SetIcon(args.destName, beaconIcon, 11)
			beaconIcon = beaconIcon - 1
		end
		self:Unschedule(warnConflagTargets)
		self:Schedule(0.3, warnConflagTargets)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(78722) then
		timerEnrage:Cancel()
	end
end