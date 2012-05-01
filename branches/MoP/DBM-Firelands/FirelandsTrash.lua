local mod	= DBM:NewMod("FirelandsTrash", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5756 $"):sub(12, -3))
mod:SetModelID(38765)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_DIED"
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

local lavaRunning = false

function mod:LeapTarget(sGUID)
	local targetname = nil
	for i=1, GetNumRaidMembers() do
		if UnitGUID("raid"..i.."target") == sGUID then
			targetname = UnitName("raid"..i.."targettarget")
			break
		end
	end
	if targetname and self:AntiSpam(2, targetname) then--Sometimes mod bugs, multiple leaps too close to same time, and it results in double or even tripple announces on one person (and no announce for 1-2 of the real targets). this will at least filter 1 target spam
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

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(99532, 100767) then
		timerMoltenArmor:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(100094) then--Trash version of Fieroblast, different from boss version
		if args.sourceGUID == UnitGUID("target") then
			specWarnFieroblast:Show(args.sourceName)
		end
	elseif args:IsSpellID(99629) then--Druid of the Flame Leaping
		self:ScheduleMethod(1, "LeapTarget", args.sourceGUID)
	elseif args:IsSpellID(99503) then
		warnRaiselava:Show()
		timerRaiseLavaCD:Start()
		if not lavaRunning then
			self:RegisterShortTermEvents(
				"SPELL_DAMAGE",
				"SPELL_MISSED"
			)
			lavaRunning = true
		end
	elseif args:IsSpellID(100724) then
		warnEarthquake:Show()
		specWarnEarthQuake:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(99579) and self:AntiSpam(4) then
		warnMoltenBolt:Show()
		timerMoltenBoltCD:Start()
	elseif args:IsSpellID(99575) then
		warnLavaSpawn:Show()
		timerLavaSpawnCD:Start()
	end
end

function mod:SPELL_DAMAGE(sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId)
	if spellId == 99510 and destGUID == UnitGUID("player") and self:AntiSpam(3) then
		specWarnLava:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
		
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 53575 then
		timerRaiseLavaCD:Cancel()
		lavaRunning = false
		self:UnregisterShortTermEvents()
	elseif cid == 53617 then
		timerMoltenBoltCD:Cancel()
	elseif cid == 53616 then
		timerLavaSpawnCD:Cancel()
	elseif cid == 53619 then
		self:UnscheduleMethod("LeapTarget", args.destGUID)
	end	
end
