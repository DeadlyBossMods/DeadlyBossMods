local mod	= DBM:NewMod("Sinestra", "DBM-BastionTwilight")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(45213)
mod:SetZone()
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_MONSTER_YELL",
	"SWING_DAMAGE",
	"SWING_MISSED",
	"SPELL_DAMAGE",
	"UNIT_DIED"
)

local warnBreath		= mod:NewSpellAnnounce(92944, 3)
local warnSlicerSoon	= mod:NewAnnounce("WarnSlicerSoon", 2, 92954) -- yeah, this stuff can be very spammy, but in Sinestra, Twilight Slicer is very very very important, so on it by default.
local warnWrack			= mod:NewTargetAnnounce(92955, 4)
local warnWrackJump		= mod:NewAnnounce("warnWrackJump", 3, 92955, false)--Not spammy at all (unless you're dispellers are retarded and make it spammy). Useful for a raid leader to coordinate quicker, especially on 10 man with low wiggle room.
local WarnWrackCount5s	= mod:NewAnnounce("WarnWrackCount5s", 2, 92955, false)--Support the common 10 man strat of 20 15 15 10 (or 25 if they do it same way)
local warnDragon		= mod:NewAnnounce("WarnDragon", 3, 69002)
local warnEggWeaken		= mod:NewAnnounce("WarnEggWeaken", 4, 61357)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnIndomitable	= mod:NewSpellAnnounce(92946, 3)
local warnExtinction	= mod:NewSpellAnnounce(86227, 4)
local warnEggShield		= mod:NewSpellAnnounce(87654, 3)
local warnPhase3		= mod:NewPhaseAnnounce(3)
local warnRedEssence	= mod:NewSpellAnnounce(87946, 3)
local warnOrbs			= mod:NewTargetAnnounce(92954)

local specWarnSlicer	= mod:NewSpecialWarning("SpecWarnSlicer")
local specWarnDispel	= mod:NewSpecialWarning("SpecWarnDispel", false) -- this can be personal stuff, but Warck dispel also important In sinestra. adjust appropriately. (Maybe add support for common 10 man variation with if/else rules?)
local specWarnBreath	= mod:NewSpecialWarningSpell(92944, false, nil, nil, true)
local specWarnEggShield	= mod:NewSpecialWarning("SpecWarnEggShield", mod:IsRanged())
local specWarnEggWeaken	= mod:NewSpecialWarning("SpecWarnEggWeaken", mod:IsRanged())
local specWarnOrb		= mod:NewSpecialWarningYou(92954)

local timerBreathCD		= mod:NewCDTimer(21, 92944)
local timerSlicer		= mod:NewNextTimer(28, 92954)
local timerWrack		= mod:NewBuffActiveTimer(60, 92955)
local timerExtinction	= mod:NewCastTimer(16, 86227)
local timerEggWeakening	= mod:NewTimer(4, "TimerEggWeakening", 61357)
local timerEggWeaken	= mod:NewTimer(30, "TimerEggWeaken", 61357)
local timerDragon		= mod:NewTimer(50, "TimerDragon", 69002)
local timerRedEssence	= mod:NewBuffActiveTimer(180, 87946)

mod:AddBoolOption("HealthFrame", true)
mod:AddBoolOption("SetIconOnOrbs", true)

local eggDown = 0
local eggSpam = 0
local lastDispeled = 0
local newWrackTime = 0
local oldWrackTime = 0
local newWrackCount = 0
local oldWrackCount = 0
local eggRemoved = false
local wrackWarned2 = false
local wrackWarned4 = false
local redSpam = 0
local calenGUID = 0
local orbList = {}
local orbWarned = nil
local playerInList = nil
local whelpGUIDs = {}
local wrackTargets = {}

local function isTank(unit)
	-- 1. check blizzard tanks first
	-- 2. check blizzard roles second
	if GetPartyAssignment("MAINTANK", unit, 1) then
		return true
	end
	if UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	return false
end

local function isTargetableByOrb(unit)
	-- check tanks
	if isTank(unit) then return false end
	-- check sinestra's target too
	if UnitIsUnit("boss1target", unit) then return false end
	-- and maybe do a check for whelp targets
	-- not 100% sure if whelp "tanks" can be targeted by the orb or not
	for k, v in pairs(whelpGUIDs) do
		local whelp = mod:GetUnitIdByGUID(k)
		if whelp then
			if UnitIsUnit(whelp.."target", unit) then return false end
		end
	end
	return true
end

local function populateOrbList()
	wipe(orbList)
	for i = 1, GetNumRaidMembers() do
		-- do some checks for 25/10 man raid size so we don't warn for ppl who are not in the instance
		if GetInstanceDifficulty() == 3 and i > 10 then return end
		if GetInstanceDifficulty() == 4 and i > 25 then return end
		local n = GetRaidRosterInfo(i)
		-- Tanking something, but not a tank (aka not tanking Sinestra or Whelps)
		if UnitThreatSituation(n) == 3 and isTargetableByOrb(n) then
			if UnitIsUnit(n, "player") then playerInList = true end
			orbList[#orbList + 1] = n
		end
	end
end

local function wipeWhelpList(resetWarning)
	if resetWarning then orbWarned = nil end
	playerInList = nil
	wipe(whelpGUIDs)
end

local function orbWarning(source)
	if playerInList then specWarnOrb:Show() end
	if mod.Options.SetIconOnOrbs then
		if orbList[1] then mod:SetIcon(orbList[1], 8) end
		if orbList[2] then mod:SetIcon(orbList[2], 7) end
	end

	if source == "spawn" then
		if #orbList > 0 then
			warnOrbs:Show(table.concat(orbList, "<, >"))
			-- if we could guess orb targets lets wipe the whelpGUIDs in 5 sec
			-- if not then we might as well just save them for next time
			mod:ScheduleTimer(wipeWhelpList, 5) -- might need to adjust this
		else
			specWarnSlicer:Show()--If orb list works, then the whole raid doesn't need a special warning (just ones with orbs do), but if it failed then special warn everyone!
		end
	elseif source == "damage" then
		warnOrbs:Show(table.concat(orbList, "<, >"))
		mod:ScheduleTimer(wipeWhelpList, 10, true) -- might need to adjust this
	end
end

function mod:SlicerRepeat()
	timerSlicer:Start()
	if self.Options.WarnSlicerSoon then
		warnSlicerSoon:Schedule(23, 5)
		warnSlicerSoon:Schedule(24, 4)
		warnSlicerSoon:Schedule(25, 3)
		warnSlicerSoon:Schedule(26, 2)
		warnSlicerSoon:Schedule(27, 1)
	end
	self:ScheduleMethod(28, "SlicerRepeat")
	populateOrbList()
	orbWarning("spawn")
end

local function showWrackWarning()
	warnWrackJump:Show(args.spellName, table.concat(wrackTargets, "<, >"))
	table.wipe(wrackTargets)
end

function mod:OnCombatStart(delay)
	eggDown = 0
	eggSpam = 0
	lastDispeled = 0
	newWrackTime = 0
	oldWrackTime = 0
	newWrackCount = 0
	wrackWarned2 = false
	wrackWarned4 = false
	eggRemoved = false
	redSpam = 0
	calenGUID = 0
	timerDragon:Start(16-delay)
	timerBreathCD:Start(21-delay)
	timerSlicer:Start(29-delay)
	wipe(whelpGUIDs)
	wipe(orbList)
	orbWarned = nil
	playerInList = nil
	table.wipe(wrackTargets)
	if self.Options.WarnSlicerSoon then
		warnSlicerSoon:Schedule(24, 5)
		warnSlicerSoon:Schedule(25, 4)
		warnSlicerSoon:Schedule(26, 3)
		warnSlicerSoon:Schedule(27, 2)
		warnSlicerSoon:Schedule(28, 1)
	end
	self:ScheduleMethod(29-delay, "SlicerRepeat")
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(90125, 92944) then
		warnBreath:Show()
		specWarnBreath:Show()
		timerBreathCD:Start()
	elseif args:IsSpellID(86227) then
		warnExtinction:Show()
		timerExtinction:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(90045, 92946) then
		warnIndomitable:Show()
	elseif args:IsSpellID(89421, 92955) then--Cast wracks (10,25)
		warnWrack:Show(args.destName)
		timerWrack:Start()
		if oldWrackTime == 0 then
			oldWrackTime = GetTime()
		else
			oldWrackTime = newWrackTime
		end
		newWrackTime = GetTime()
		newWrackCount = 1
		lastDispeled = 0
		wrackWarned4 = false
		wrackWarned2 = false
		WarnWrackCount5s:Schedule(10, 10)
		WarnWrackCount5s:Schedule(15, 15)
		WarnWrackCount5s:Schedule(20, 20)
		specWarnDispel:Schedule(18, 18)
		self:Schedule(60, function()
			specWarnDispel:Cancel()
			WarnWrackCount5s:Cancel()
		end)
	elseif args:IsSpellID(89435, 92956) and (GetTime() - oldWrackTime < 60 or GetTime() - newWrackTime > 12) then -- jumped wracks (10,25)
		newWrackCount = newWrackCount + 1
		wrackTargets[#wrackTargets + 1] = args.destName
		self:Unschedule(showWrackWarning)
		self:Schedule(0.3, showWrackWarning)
		if newWrackCount > 3 and GetTime() - lastDispeled < 5 and GetTime() - newWrackTime < 60 and not wrackWarned4 then
			specWarnDispel:Cancel()
			WarnWrackCount5s:Cancel()
			WarnWrackCount5s:Schedule(10, 10)
			WarnWrackCount5s:Schedule(15, 15)
			WarnWrackCount5s:Schedule(20, 20)
			specWarnDispel:Schedule(12, 12)
			wrackWarned4 = true
		elseif newWrackCount > 1 and GetTime() - lastDispeled < 5 and GetTime() - newWrackTime < 60 and not wrackWarned2 then
			specWarnDispel:Cancel()
			WarnWrackCount5s:Cancel()
			WarnWrackCount5s:Schedule(10, 10)
			WarnWrackCount5s:Schedule(15, 15)
			WarnWrackCount5s:Schedule(20, 20)
			specWarnDispel:Schedule(17, 17)
			wrackWarned2 = true
		end
	elseif args:IsSpellID(87299) then
		eggDown = 0
		warnPhase2:Show()
		timerBreathCD:Cancel()
		timerSlicer:Cancel()
		if self.Options.WarnSlicerSoon then
			warnSlicerSoon:Cancel()
		end
		self:UnscheduleMethod("SlicerRepeat")
	elseif args:IsSpellID(87231) and not args:IsDestTypePlayer() then
		if not DBM.BossHealth:HasBoss(args.sourceGUID) then
			DBM.BossHealth:AddBoss(args.sourceGUID, args.sourceName)
			calenGUID = args.sourceGUID
		end
	elseif args:IsSpellID(87654) then
		if not DBM.BossHealth:HasBoss(args.sourceGUID) then
			DBM.BossHealth:AddBoss(args.sourceGUID, args.sourceName)
		end
		if GetTime() - eggSpam >= 3 then
			eggSpam = GetTime()
			warnEggShield:Show()
			timerDragon:Cancel()
			if eggRemoved then
				specWarnEggShield:Show()
			end
		end
	elseif args:IsSpellID(87946) and GetTime() - redSpam >= 4 then
		warnRedEssence:Show()
		timerRedEssence:Start()
		redSpam = GetTime()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(87654) and GetTime() - eggSpam >= 3 then
		eggSpam = GetTime()
		warnEggWeaken:Show()
		timerEggWeaken:Show()
		specWarnEggWeaken:Show()
		eggRemoved = true
	elseif args:IsSpellID(89421, 89435, 92955, 92956) then
		if GetTime() - oldWrackTime < 60 or GetTime() - newWrackTime > 12 then
			newWrackCount = newWrackCount - 1
			if GetTime() - lastDispeled > 5 then
				lastDispeled = GetTime()
			end
		end
	end
end
--[[
do
	local whelpIds = {
		47265,
		48047,
		48048,
		48049,
		48050,
	}
	function mod:WhelpWatcher(...)
		local sGUID = select(11, ...)
		local mobId = tonumber(sGUID:sub(7, 10), 16)
		for i, v in next, whelpIds do
			if mobId == v then whelpGUIDs[sGUID] = true end
		end
	end
end--]]
--An attempt to do same as above only in a way i know how
function mod:SWING_DAMAGE(args)
	if args:GetSrcCreatureID() == 47265 or args:GetSrcCreatureID() == 48047 or args:GetSrcCreatureID() == 48048 or args:GetSrcCreatureID() == 48049 or args:GetSrcCreatureID() == 48050 then
		whelpGUIDs[args.sourceGUID] = true
	end
end

mod.SWING_DAMAGE = mod.SWING_MISSED

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(92954, 92959) then
		populateOrbList()
		if orbWarned then return end
		orbWarned = true
		orbWarning("damage")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellDragon or msg:find(L.YellDragon) then
		warnDragon:Show()
		timerDragon:Start()
	elseif msg == L.YellEgg or msg:find(L.YellEgg) then
		timerEggWeakening:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 46842 then
		DBM.BossHealth:RemoveBoss(args.destGUID)
		eggDown = eggDown + 1
		if eggDown >= 2 then
			DBM.BossHealth:RemoveBoss(calenGUID)
			timerEggWeaken:Cancel()
			warnPhase3:Show()
			timerBreathCD:Start()
			timerSlicer:Start(30)
			timerDragon:Start()
			if self.Options.WarnSlicerSoon then
				warnSlicerSoon:Schedule(24, 5)
				warnSlicerSoon:Schedule(25, 4)
				warnSlicerSoon:Schedule(26, 3)
				warnSlicerSoon:Schedule(27, 2)
				warnSlicerSoon:Schedule(28, 1)
			end
			self:ScheduleMethod(30, "SlicerRepeat")
		end
	end
end