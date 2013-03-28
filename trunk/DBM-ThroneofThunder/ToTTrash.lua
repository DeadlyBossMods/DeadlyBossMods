local mod	= DBM:NewMod("ToTTrash", "DBM-ThroneofThunder")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(39378)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnStormEnergy			= mod:NewTargetAnnounce(139322, 4)
local warnSpiritFire			= mod:NewTargetAnnounce(139895, 3)--This is morchok entryway trash that throws rocks at random poeple.
local warnShadowNova			= mod:NewCastAnnounce(139899, 4)
local warnStormCloud			= mod:NewTargetAnnounce(139900, 4)
local warnFixated				= mod:NewSpellAnnounce(140306, 3)
local warnConductiveShield		= mod:NewTargetAnnounce(140296, 4)

local specWarnStormEnergy		= mod:NewSpecialWarningYou(139322)
local specWarnShadowNova		= mod:NewSpecialWarningSpell(139899, nil, nil, nil, 3)--This hurls you pretty damn far. If you aren't careful you're as good as gone.
local specWarnStormCloud		= mod:NewSpecialWarningYou(139900)
local specWarnSonicScreech		= mod:NewSpecialWarningInterrupt(136751)
local specWarnConductiveShield	= mod:NewSpecialWarningTarget(140296)

local timerSpiritfireCD			= mod:NewCDTimer(12, 139895)
local timerShadowNovaCD			= mod:NewCDTimer(12, 139899)
local timerFixatedCD			= mod:NewNextTimer(15.7, 140306)
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
	if args.spellId == 139895 then
		self:ScheduleMethod(0.2, "SpiritFireTarget", args.sourceGUID)--Untested scan timing (don't even know if scanning works
		timerSpiritfireCD:Start()
		if self.Options.RangeFrame and not DBM.RangeCheck:IsShown() then
			DBM.RangeCheck:Show(3)
		end
	elseif args.spellId == 136751 and (args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus")) then
		specWarnSonicScreech:Show(args.sourceName)
	elseif args.spellId == 139899 then
		warnShadowNova:Show()
		specWarnShadowNova:Show()
		timerShadowNovaCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 139322 then--Or 139559, not sure which
		stormEnergyTargets[#stormEnergyTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnStormEnergy:Show()
		end
		if self.Options.RangeFrame and not DBM.RangeCheck:IsShown() then
			DBM.RangeCheck:Show(10)
		end
		self:Unschedule(warnStormEnergyTargets)
		self:Schedule(1.5, warnStormEnergyTargets)--For some reason debuffs can go out as slow as 1.2, set to 1.5 in case it can get even worse then that
	elseif args.spellId == 139900 then
		stormCloudTargets[#stormCloudTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnStormCloud:Show()
		end
		if self.Options.RangeFrame and not DBM.RangeCheck:IsShown() then
			DBM.RangeCheck:Show(10)
		end
		self:Unschedule(warnStormCloudTargets)
		self:Schedule(0.5, warnStormCloudTargets)
	elseif args.spellId == 140296 then
		warnConductiveShield:Show(args.destName)
		specWarnConductiveShield:Show(args.destName)
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
	elseif cid == 70440 then--Monara
		timerShadowNovaCD:Cancel()
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
	elseif cid == 68220 then--Gastropod
		timerFixatedCD:Cancel(args.destGUID)
	end
end

--"<1.0 17:57:05> [UNIT_SPELLCAST_SUCCEEDED] Gastropod [[target:Fixated::0:140306]]", -- [23]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 140306 and self:AntiSpam() then
		self:SendSync("OMGSnail", UnitGUID(uId))
	end
end

function mod:OnSync(msg, guid)
	if msg == "OMGSnail" and guid  then
		warnFixated:Show()
		timerFixatedCD:Start(nil, guid)
	end
end
