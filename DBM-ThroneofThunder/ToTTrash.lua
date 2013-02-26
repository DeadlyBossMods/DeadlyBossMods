local mod	= DBM:NewMod("ToTTrash", "DBM-ThroneofThunder")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(39378)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START",
	"UNIT_DIED"
)

local warnSpiritFire		= mod:NewTargetAnnounce(139895, 3)--This is morchok entryway trash that throws rocks at random poeple.

local timerSpiritfireCD		= mod:NewCDTimer(12, 139895)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

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
			DBM.RangeCheck:Show(10)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 70308 then--Soul-Fed Construct
		timerSpiritfireCD:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end
