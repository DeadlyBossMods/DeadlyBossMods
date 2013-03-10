local mod	= DBM:NewMod("ToTTrash", "DBM-ThroneofThunder")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(39378)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"UNIT_DIED"
)

local warnStormEnergy			= mod:NewTargetAnnounce(139322, 4)
local warnSpiritFire			= mod:NewTargetAnnounce(139895, 3)--This is morchok entryway trash that throws rocks at random poeple.
local warnStormCloud			= mod:NewTargetAnnounce(139900, 4)
local warnConductiveShield		= mod:NewTargetAnnounce(140296, 4)

local specWarnStormEnergy		= mod:NewSpecialWarningYou(139322)
local specWarnStormCloud		= mod:NewSpecialWarningYou(139900)
local specWarnConductiveShield	= mod:NewSpecialWarningTarget(140296)

local timerSpiritfireCD			= mod:NewCDTimer(12, 139895)
local timerConductiveShieldCD	= mod:NewNextSourceTimer(20, 140296)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")
mod:AddBoolOption("RangeFrame")

local stormEnergyTargets = {}
local stormCloudTargets = {}

local function warnStormEnergyTargets()
	warnStormEnergy:Show(table.concat(stormEnergyTargets, "<, >"))
	table.wipe(stormEnergyTargets)
end

local function warnStormCloudTargets()
	warnStormCloud:Show(table.concat(stormCloudTargets, "<, >"))
	table.wipe(stormCloudTargets)
end

function mod:SpiritFireTarget(sGUID)
	local targetname = nil
	for i=1, DBM:GetNumGroupMembers() do
		if UnitGUID("raid"..i.."target") == sGUID then
			targetname = DBM:GetUnitFullName("raid"..i.."targettarget")
			break
		end
	end
	if targetname and self:AntiSpam(2, targetname) then--Anti spam using targetname as an identifier, will prevent same target being announced double/tripple but NOT prevent multiple targets being announced at once :)
		warnSpiritFire:Show(targetname)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(139895) then
		self:ScheduleMethod(0.2, "SpiritFireTarget", args.sourceGUID)--Untested scan timing (don't even know if scanning works
		timerSpiritfireCD:Start()
		if self.Options.RangeFrame and not DBM.RangeCheck:IsShown() then
			DBM.RangeCheck:Show(3)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(139322) then--Or 139559, not sure which
		stormEnergyTargets[#stormEnergyTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnStormEnergy:Show()
		end
		if self.Options.RangeFrame and not DBM.RangeCheck:IsShown() then
			DBM.RangeCheck:Show(10)
		end
		self:Unschedule(warnStormEnergyTargets)
		self:Schedule(0.3, warnStormEnergyTargets)
	elseif args:IsSpellID(139900) then
		stormCloudTargets[#stormCloudTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnStormCloud:Show()
		end
		if self.Options.RangeFrame and not DBM.RangeCheck:IsShown() then
			DBM.RangeCheck:Show(10)
		end
		self:Unschedule(warnStormCloudTargets)
		self:Schedule(0.3, warnStormCloudTargets)
	elseif args:IsSpellID(140296) then
		warnConductiveShield:Show(args.destName)
		specWarnConductiveShield:Show(args.destname)
		timerConductiveShieldCD:Start(20, args.destName, args.sourceGUID)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 70308 then--Soul-Fed Construct
		timerSpiritfireCD:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif cid == 70236 then--Zandalari Storm-Caller
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif cid == 70445 then--Stormbringer Draz'kil
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif cid == 69834 or cid == 69821 then
		timerConductiveShieldCD:Cancel(args.destName, args.destGUID)
	end
end
