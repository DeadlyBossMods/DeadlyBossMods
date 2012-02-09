local mod	= DBM:NewMod("FirelandsTrash", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5756 $"):sub(12, -3))
mod:SetModelID(38765)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_DIED",
	"ZONE_CHANGED_NEW_AREA"
)

local warnMoltenArmor		= mod:NewStackAnnounce(99532, 3, nil, mod:IsTank() or mod:IsHealer())
local warnDruidLeap			= mod:NewTargetAnnounce(99629, 3, nil, false)--Probably spammy, more for debugging timing then anything.
local warnRaiselava			= mod:NewSpellAnnounce(99503, 3)
local warnMoltenBolt		= mod:NewSpellAnnounce(99579, 3)
local warnLavaSpawn			= mod:NewSpellAnnounce(99575, 3)
local warnEarthquake		= mod:NewSpellAnnounce(100724, 3)

local specWarnFieroblast	= mod:NewSpecialWarningInterrupt(100094, false)
local specWarnMoltenArmor	= mod:NewSpecialWarningStack(99532, mod:IsTank(), 4)
local specWarnDruidLeap		= mod:NewSpecialWarningYou(99629)
local yelldruidLeap			= mod:NewYell(99629)
local specWarnDruidLeapNear	= mod:NewSpecialWarningClose(99629)
local specWarnEarthQuake	= mod:NewSpecialWarningCast(100724, mod:IsRanged())
local specWarnLava			= mod:NewSpecialWarningMove(99510)

local timerMoltenArmor		= mod:NewTargetTimer(15, 99532, nil, mod:IsTank() or mod:IsHealer())
local timerRaiseLavaCD		= mod:NewNextTimer(17, 99503)--Every 15 sec + 2 sec cast.
local timerMoltenBoltCD		= mod:NewNextTimer(15.5, 99579)--The worm gyser things that always kill people for not moving.
local timerLavaSpawnCD		= mod:NewNextTimer(16, 99575)--The worm gyser things that always kill people for not moving.

mod:AddBoolOption("TrashRangeFrame", false)--off by default, this was NOT well recieved.

local antiSpam = 0
local surgers = 0
local surgerGUIDs = {}
do
	surgers = 0
	surgerGUIDs = {}	
end

function mod:LeapTarget(sGUID)
	local targetname = nil
	for i=1, GetNumRaidMembers() do
		if UnitGUID("raid"..i.."target") == sGUID then
			targetname = UnitName("raid"..i.."targettarget")
			break
		end
	end
	if not targetname then return end
	warnDruidLeap:Show(targetname)
	if targetname == UnitName("player") then
		specWarnDruidLeap:Show()
		yelldruidLeap:Yell()
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnDruidLeapNear:Show(targetname)
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(99532, 100767) and args:IsDestTypePlayer() then
		warnMoltenArmor:Show(args.destName, args.amount or 1)
		if args:IsPlayer() and (args.amount or 1) >= 4 then
			specWarnMoltenArmor:Show(args.amount)
		end
		timerMoltenArmor:Start(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)	-- BoP or similar can remove the debuff?
	if args:IsSpellID(99532, 100767) then
		timerMoltenArmor:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(100094) then--Trash version of spell used on boss fight.
		if args.sourceGUID == UnitGUID("target") then
			specWarnFieroblast:Show()
		end
	elseif args:IsSpellID(99629) then--Druid of the Flame Leaping
		self:ScheduleMethod(1, "LeapTarget", args.sourceGUID)
	elseif args:IsSpellID(99503) then
		warnRaiselava:Show()
		timerRaiseLavaCD:Start()
	elseif args:IsSpellID(100724) then
		warnEarthquake:Show()
		specWarnEarthQuake:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(100012) and not surgerGUIDs[args.sourceGUID] then
		surgers = surgers + 1
		surgerGUIDs[args.sourceGUID] = 1
		if self.Options.TrashRangeFrame then
			DBM.RangeCheck:Show(10)
		end
	elseif args:IsSpellID(99579) and GetTime() - antiSpam >= 4 then
		antiSpam = GetTime()
		warnMoltenBolt:Show()
		timerMoltenBoltCD:Start()
	elseif args:IsSpellID(99575) then
		warnLavaSpawn:Show()
		timerLavaSpawnCD:Start()
	end
end

function mod:SPELL_DAMAGE(sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId)
	if spellId == 99510 and destGUID == UnitGUID("player") and GetTime() - antiSpam >= 3 then
		specWarnLava:Show()
		antiSpam = GetTime()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
		
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 53141 then
		surgers = surgers - 1
		if surgers <= 0 then 
			surgers = 0
			table.wipe(surgerGUIDs)--Also wipe GUID table
			if self.Options.TrashRangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif cid == 53575 then
		timerRaiseLavaCD:Cancel()
	elseif cid == 53617 then
		timerMoltenBoltCD:Cancel()
	elseif cid == 53616 then
		timerLavaSpawnCD:Cancel()
	elseif cid == 53619 then
		self:UnscheduleMethod("LeapTarget", args.destGUID)
	end	
end

function mod:ZONE_CHANGED_NEW_AREA()
	if surgers ~= 0 then--You probably wiped on trash and don't need the range finder to get stuck open.
		surgers = 0--Reset the surgers.
		table.wipe(surgerGUIDs)--Also wipe GUID table
		if self.Options.TrashRangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end