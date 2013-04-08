local mod	= DBM:NewMod(817, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68078, 68079, 68080, 68081)--Ro'shak 68079, Quet'zal 68080, Dam'ren 68081, Iron Qon 68078
mod:SetMainBossID(68078)
mod:SetModelID(46627) -- Iron Qon, 46628 Ro'shak, 46629 Quet'zal, 46630 Dam'ren

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnImpale						= mod:NewStackAnnounce(134691, 2, nil, mod:IsTank() or mod:IsHealer())
local warnThrowSpear					= mod:NewTargetAnnounce(134926, 3)--Target scanning does not work for this.
local warnPhase1						= mod:NewPhaseAnnounce(1)
local warnMoltenInferno					= mod:NewSpellAnnounce(134664, 2, nil, false)--highly variables cd, also can be spammy. disbled by default.
local warnUnleashedFlame				= mod:NewSpellAnnounce(134611, 3, nil, false)--Spammy and unnesssary. Every 6 seconds is too often for a non important warning. people can turn it on if they want.
local warnMoltenOverload				= mod:NewSpellAnnounce(137221, 4)
local warnWhirlingWinds					= mod:NewSpellAnnounce(139167, 3)--Heroic Phase 1
local warnPhase2						= mod:NewPhaseAnnounce(2)
local warnWindStorm						= mod:NewSpellAnnounce(136577, 4)
local warnWindStormEnd					= mod:NewEndAnnounce(136577, 4)
local warnLightningStorm				= mod:NewTargetAnnounce(136192, 3)
local warnFrostSpike					= mod:NewSpellAnnounce(139180, 3)--Heroic Phase 2
local warnPhase3						= mod:NewPhaseAnnounce(3)
local warnDeadZone						= mod:NewAnnounce("warnDeadZone", 3, 137229)
local warnFreeze						= mod:NewTargetAnnounce(135145, 3, nil, false)--Spammy, more of a duh type warning I think
local warnPhase4						= mod:NewPhaseAnnounce(4)
local warnRisingAnger					= mod:NewStackAnnounce(136323, 2, nil, false)
local warnFistSmash						= mod:NewCountAnnounce(136146, 3)

local specWarnImpale					= mod:NewSpecialWarningStack(134691, mod:IsTank(), 3)
local specWarnImpaleOther				= mod:NewSpecialWarningTarget(134691, mod:IsTank())
local specWarnThrowSpear				= mod:NewSpecialWarningSpell(134926, nil, nil, nil, 2)
local specWarnThrowSpearYou				= mod:NewSpecialWarningYou(134926)
local specWarnThrowSpearNear			= mod:NewSpecialWarningClose(134926)
local yellThrowSpear					= mod:NewYell(134926)
local specWarnScorched					= mod:NewSpecialWarningStack(134647, false, 3)--We do a 4 and 2 strat (4 melee 2 ranged). 3 is not an everyone strat.
local specWarnBurningCinders			= mod:NewSpecialWarningMove(137668)
local specWarnMoltenOverload			= mod:NewSpecialWarningSpell(137221, nil, nil, nil, 2)
local specWarnWindStorm					= mod:NewSpecialWarningSpell(136577, nil, nil, nil, 2)
local specWarnStormCloud				= mod:NewSpecialWarningMove(137669)
local specWarnLightningStorm			= mod:NewSpecialWarningYou(136192)
local yellLightningStorm				= mod:NewYell(136192)
local specWarnFrozenBlood				= mod:NewSpecialWarningMove(136520)
local specWarnFistSmash					= mod:NewSpecialWarningSpell(136146, nil, nil, nil, 2)

local timerImpale						= mod:NewTargetTimer(40, 134691, mod:IsTank() or mod:IsHealer())
local timerImpaleCD						= mod:NewCDTimer(20, 134691, mod:IsTank() or mod:IsHealer())
local timerThrowSpearCD					= mod:NewCDTimer(30, 134926)--30-36 second variation observed (at last in phase 1)
local timerUnleashedFlameCD				= mod:NewCDTimer(6, 134611)
local timerScorched						= mod:NewBuffFadesTimer(30, 134647)
local timerMoltenOverload				= mod:NewBuffActiveTimer(10, 137221)
local timerLightningStormCD				= mod:NewCDTimer(20, 136192)
local timerWindStorm					= mod:NewBuffActiveTimer(19.8, 136577)--19.8~21.7sec variables
local timerWindStormCD					= mod:NewNextTimer(70, 136577)
local timerFreezeCD						= mod:NewCDTimer(7, 135145, nil, false)
local timerDeadZoneCD					= mod:NewCDTimer(15, 137229)
local timerRisingAngerCD				= mod:NewNextTimer(15, 136323, nil, false)
local timerFistSmash					= mod:NewBuffActiveTimer(8, 136146)
local timerFistSmashCD					= mod:NewNextCountTimer(20, 136146)
local timerWhirlingWindsCD				= mod:NewCDTimer(30, 139167)--Heroic Phase 1
local timerFrostSpikeCD					= mod:NewCDTimer(12, 139180)--Heroic Phase 2

local berserkTimer						= mod:NewBerserkTimer(720)

mod:AddBoolOption("RangeFrame", true)--One tooltip says 8 yards, other says 10. Confirmed it's 10 during testing though. Ignore the 8 on spellid 134611
mod:AddBoolOption("InfoFrame")

local Roshak = select(2, EJ_GetCreatureInfo(2, 817))
local Quetzal = select(2, EJ_GetCreatureInfo(3, 817))
local Damren = select(2, EJ_GetCreatureInfo(4, 817))
local arcingName = GetSpellInfo(136193)
local phase = 1--Not sure this is useful yet, coding it in, in case spear cd is different in different phases
local fistSmashCount = 0

local function updateHealthFrame()
	if DBM.BossHealth:IsShown() then
		DBM.BossHealth:Clear()
		if phase == 1 then
			DBM.BossHealth:AddBoss(68079, Roshak)
		elseif phase == 2 then
			DBM.BossHealth:AddBoss(68080, Quetzal)
		elseif phase == 3 then
			DBM.BossHealth:AddBoss(68081, Damren)
		elseif phase == 4 then
			DBM.BossHealth:AddBoss(68078, L.name)
			if mod:IsDifficulty("heroic10", "heroic25") then
				DBM.BossHealth:AddBoss(68081, Damren)
				DBM.BossHealth:AddBoss(68080, Quetzal)
				DBM.BossHealth:AddBoss(68079, Roshak)
			end
		end
	end
end

local function isTank(unit)
	-- 1. check blizzard tanks first
	-- 2. check blizzard roles second
	-- 3. check boss' highest threat target
	if GetPartyAssignment("MAINTANK", unit, 1) then
		return true
	end
	if UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	if UnitDetailedThreatSituation(unit, "boss1") then
		return true
	end
	if UnitExists("boss2target") and UnitDetailedThreatSituation(unit, "boss2") then
		return true
	end
	return false
end

--Spear target happens BEFORE cast, so we have to pre schedule scan it to grab target
--This will fail if the spear target actually IS his highest threat
--In that case the aoe failsafe warning will just be used, so 1/10 or 1/25 odds in phase 1.
local function checkSpear()
	if UnitExists("boss1target") and not isTank("boss1target") then--Boss 1 is looking at someone that isn't his highest threat or a tank (have to filter tanks cause he looks at them to cast impale, have to filter his highest threat in case it's not a tank, ie a healer)
		mod:Unschedule(checkSpear)
		local targetname = DBM:GetUnitFullName("boss1target")
		warnThrowSpear:Show(targetname)
		if UnitIsUnit("boss1target", "player") then--you are spear target
			specWarnThrowSpearYou:Show()
			yellThrowSpear:Yell()
		else--Not spear target
			local x, y = GetPlayerMapPosition("boss1target")
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition("boss1target")
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange < 10 then
				specWarnThrowSpearNear:Show(targetname)--Near spear target
			elseif mod:AntiSpam(15, 8) then--Smart way to do a failsafe in case we never get a valid target
				specWarnThrowSpear:Show()--not spear target or near spear target, generic aoe warning (for the lines and stuff)
			end
		end
	else
		mod:Schedule(0.2, checkSpear)
	end
end

local function checkArcing()
	local arcingDebuffs = 0
	for i = 1, GetNumGroupMembers() do
		local uId = "raid"..i
		if UnitDebuff(uId, arcingName) then
			arcingDebuffs = arcingDebuffs + 1
		end
	end
	if arcingDebuffs == 0 then
		mod:Unschedule(checkArcing)
		if mod.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if mod.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	else
		mod:Schedule(5, checkArcing)
	end
end

function mod:OnCombatStart(delay)
	phase = 1
	fistSmashCount = 0
	updateHealthFrame()
	warnPhase1:Show()
	timerThrowSpearCD:Start(-delay)
	self:Schedule(25, checkSpear)
	if self.Options.RangeFrame then
		if self:IsDifficulty("normal10", "heroic10") then
			DBM.RangeCheck:Show(10, nil, nil, 2)
		else
			DBM.RangeCheck:Show(10, nil, nil, 4)
		end
	end
	if self:IsDifficulty("heroic10", "heroic25") then
		timerWhirlingWindsCD:Start(20-delay)
		timerLightningStormCD:Start(22-delay)
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(GetSpellInfo(136193))
			DBM.InfoFrame:Show(5, "playerbaddebuff", 136193)
		end
	else
		self:RegisterShortTermEvents(
			"UNIT_DIED"--Alternate phase detection for normal (not sure if needed, but just in case, i deleted my normal mode log and don't remember if they fired "eject all passengers" there.
		)
	end
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 134691 then
		warnImpale:Show(args.destName, args.amount or 1)
		timerImpaleCD:Start()
		if args:IsPlayer() then
			if (args.amount or 1) >= 3 then
				specWarnImpale:Show(args.amount)
			end
		else
			if (args.amount or 1) >= 2 and not UnitDebuff("player", GetSpellInfo(134691)) and not UnitIsDeadOrGhost("player") then
				specWarnImpaleOther:Show(args.destName)
			end
		end
	elseif args.spellId == 134647 and args:IsPlayer() then
		timerScorched:Start()
		if (args.amount or 1) > 2 then
			specWarnScorched:Show(args.amount or 1)
		end
	elseif args.spellId == 137221 then
		warnMoltenOverload:Show()
		specWarnMoltenOverload:Show()
		timerMoltenOverload:Start()
	elseif args.spellId == 136192 then
		warnLightningStorm:Show(args.destName)
		if phase == 2 then
			timerLightningStormCD:Start()
		else--Heroic phase 1 or 4
			timerLightningStormCD:Start(38)
		end
		if args:IsPlayer() then
			specWarnLightningStorm:Show()
			yellLightningStorm:Yell()
		end
	elseif args.spellId == 135145 then
		warnFreeze:Show(args.destName)
		if phase == 3 then
			timerFreezeCD:Start()
		else--Heroic phase 2 or 4
			timerFreezeCD:Start(36)
		end
	elseif args.spellId == 136323 then
		warnRisingAnger:Show(args.destName, args.amount or 1)
		timerRisingAngerCD:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 134647 and args:IsPlayer() then
		timerScorched:Cancel()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 134664 then
		warnMoltenInferno:Show()
	--Dead zone IDs, each dead zone has two shields and two openings. Each spellid identifies those openings.
	elseif args.spellId == 137226 then--Front, Right Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_FRONT, DBM_CORE_RIGHT)
		timerDeadZoneCD:Start()
		--Attack left or Behind (maybe add special warning that says where you can attack, for dps?)
	elseif args.spellId == 137227 then--Left, Right Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_LEFT, DBM_CORE_RIGHT)
		timerDeadZoneCD:Start()
		--Attack Front or Behind
	elseif args.spellId == 137228 then--Left, Front Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_LEFT, DBM_CORE_FRONT)
		timerDeadZoneCD:Start()
		--Attack Right or Behind
	elseif args.spellId == 137229 then--Back, Front Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_BACK, DBM_CORE_FRONT)
		timerDeadZoneCD:Start()
		--Attack left or Right
	elseif args.spellId == 137230 then--Back, Left Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_BACK, DBM_CORE_LEFT)
		timerDeadZoneCD:Start()
		--Attack Front or Right
	elseif args.spellId == 137231 then--Back, Right Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_BACK, DBM_CORE_RIGHT)
		timerDeadZoneCD:Start()
		--Attack Front or Left
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 134926 and phase < 4 then
--		warnThrowSpear:Show()
		if self:AntiSpam(15, 8) then--Basically, if the target scanning failed, we do an aoe warning on the actual summon.
			specWarnThrowSpear:Show()
		end
		timerThrowSpearCD:Start()
		self:Unschedule(checkSpear)
		self:Schedule(25, checkSpear)--Timing adjust to reduce cpu usage when we know for sure the best time to check target. spear cd is variable, minimum though is 30, 25 is probably too early to start scanning but a good place to start.
	end
end

--[[
--One of these is standing in fire and you need to move,other is dot you can't do anything about cause you stood in it too long. I'm not sure which is which so mod may be backwards, if it is, swap the damage events
"<54.8 20:15:39> [CLEU] SPELL_PERIODIC_DAMAGE#true##nil#1297#2#0x0100000000001E03#Omegal#1297#2#137668#Burning Cinders#4#15972#-1#4#nil#nil#nil#nil#nil#nil#nil", -- [3846]
"<55.4 20:15:39> [CLEU] SPELL_DAMAGE#true##nil#1298#8#0x01000000000036C3#Ixila#1298#8#137668#Burning Cinders#4#8896#-1#4#nil#nil#17562#nil#nil#nil#nil", -- [3905]
--]]
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 137668 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnBurningCinders:Show()
	elseif spellId == 137669 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnStormCloud:Show()
	elseif spellId == 136520 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnFrozenBlood:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 134611 and self:AntiSpam(2, 5) then--Unleashed Flame internal CD. He cannot use more often than every 6 seconds. 137991 is ability activation on pull, before 137991 is cast, he can't use ability at all
		warnUnleashedFlame:Show()
		if phase == 1 then
			timerUnleashedFlameCD:Start()
		else--heroic phase 3 or 4
			timerUnleashedFlameCD:Start(30)--30-33 second variation
		end
	elseif spellId == 50630 and self:AntiSpam(2, 6) then--Eject All Passengers (heroic phase change trigger)
		local cid = self:GetCIDFromGUID(UnitGUID(uId))
		self:Unschedule(checkSpear)
		self:Schedule(25, checkSpear)
		timerThrowSpearCD:Start()
		if cid == 68079 then--Ro'shak
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10, nil, nil, 1)--Switch range frame back to 1. Range is assumed 10, no spell info
			end
			--Only one log, but i looks like spear cd from phase 1 remains intact
			phase = 2
			updateHealthFrame()
			timerUnleashedFlameCD:Cancel()
			timerMoltenOverload:Cancel()
			timerWhirlingWindsCD:Cancel()
			warnPhase2:Show()
			if self:IsDifficulty("heroic10", "heroic25") then
				timerFreezeCD:Start(13)
				timerFrostSpikeCD:Start(15)
			end
			timerLightningStormCD:Start()
			warnWindStorm:Schedule(52)
			specWarnWindStorm:Schedule(52)
			timerWindStorm:Schedule(52)
			timerWindStormCD:Start(52)
		elseif cid == 68080 then--Quet'zal
			phase = 3
			updateHealthFrame()
			timerLightningStormCD:Cancel()
			timerWindStorm:Cancel()
			timerWindStormCD:Cancel()
			timerFrostSpikeCD:Cancel()
			warnPhase3:Show()
			timerDeadZoneCD:Start(8.5)
			--Maybe remove this range frame. in heroic phase 3-4, he only targets melee and no one else, and cd is 31 so ALL melee just soak entire phase and never move for it. does mindless need a range checker?
			if self:IsDifficulty("heroic10", "heroic25") then--On heroic, the fire guy returns and attacks clumps again
				if self.Options.RangeFrame then--So on heroic we need to restore the grouping range frame
					if self:IsDifficulty("heroic25") then
						DBM.RangeCheck:Show(10, nil, nil, 4)--You can have 1 person in range safely. Frame goes red at 4
					else
						DBM.RangeCheck:Show(10, nil, nil, 2)--You can have 1 person in range safely. Frame goes red at 2
					end
				end
			end
			checkArcing()
		elseif cid == 68081 then--Dam'ren
			phase = 4
			updateHealthFrame()
			timerDeadZoneCD:Cancel()--Todo, find out what they change to in phase 4 since Dam'ren still casts them
			timerFreezeCD:Cancel()--Todo, find out what they change to in phase 4 since Dam'ren still casts them
			warnPhase4:Show()
			timerRisingAngerCD:Start(15)
			timerFistSmashCD:Start(62, 1)
		end
	elseif spellId == 139172 and self:AntiSpam(2, 7) then--Whirling Winds (Phase 1 Heroic)
		warnWhirlingWinds:Show()
		timerWhirlingWindsCD:Start()
	elseif spellId == 139181 and self:AntiSpam(2, 7) then--Frost Spike (Phase 2 Heroic)
		warnFrostSpike:Show()
		timerFrostSpikeCD:Start()
	--"<168.1 19:53:31> [UNIT_SPELLCAST_SUCCEEDED] Quet'zal [[boss3:Rushing Winds::0:137656]]", -- [13876]
	--"<170.1 19:29:36> [CLEU] SPELL_MISSED#true##nil#2632#0#0x010000000003A244#Oxey#1300#8#136577#Wind Storm#8#MISS#nil", -- [11314]
	elseif spellId == 137656 and self:AntiSpam(2, 1) then--Rushing Winds (Wind Storm pre trigger)
		warnWindStorm:Cancel()
		specWarnWindStorm:Cancel()
		warnWindStormEnd:Show()
		warnWindStorm:Schedule(70)
		specWarnWindStorm:Schedule(70)
		timerWindStorm:Schedule(70)
		timerWindStormCD:Start()
	elseif spellId == 136146 and self:AntiSpam(2, 5) then
		fistSmashCount = fistSmashCount + 1
		warnFistSmash:Show(fistSmashCount)
		specWarnFistSmash:Show()
		timerFistSmash:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerFistSmashCD:Start(30, fistSmashCount+1) -- heroic cd longer.
		else
			timerFistSmashCD:Start(nil, fistSmashCount+1)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 68079 then--Ro'shak
		timerUnleashedFlameCD:Cancel()
		timerMoltenOverload:Cancel()
		if self:IsDifficulty("heroic10", "heroic25") then--In heroic, all mounts die in phase 4.
			DBM.BossHealth:RemoveBoss(cid)
		else
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10, nil, nil, 1)--Switch range frame back to 1. Range is assumed 10, no spell info
			end
			if self.Options.InfoFrame then
				DBM.InfoFrame:SetHeader(arcingName)
				DBM.InfoFrame:Show(5, "playerbaddebuff", 136193)
			end
			--Only one log, but i looks like spear cd from phase 1 remains intact
			phase = 2
			updateHealthFrame()
			timerLightningStormCD:Start(17)
			self:Unschedule(checkSpear)
			self:Schedule(25, checkSpear)
			timerThrowSpearCD:Start()
			warnPhase2:Show()
			warnWindStorm:Schedule(49.5)
			specWarnWindStorm:Schedule(49.5)
			timerWindStorm:Schedule(49.5)
			timerWindStormCD:Start(49.5)
		end
	elseif cid == 68080 then--Quet'zal
		timerLightningStormCD:Cancel()
		timerWindStormCD:Cancel()
		warnWindStorm:Cancel()
		specWarnWindStorm:Cancel()
		timerWindStorm:Cancel()
		if self:IsDifficulty("heroic10", "heroic25") then--In heroic, all mounts die in phase 4.
			DBM.BossHealth:RemoveBoss(cid)
		else
			phase = 3
			updateHealthFrame()
			warnPhase3:Show()
			timerDeadZoneCD:Start(6)
			self:Unschedule(checkSpear)
			self:Schedule(25, checkSpear)
			timerThrowSpearCD:Start()
			checkArcing()
		end
	elseif cid == 68081 then--Dam'ren
		timerDeadZoneCD:Cancel()
		timerFreezeCD:Cancel()
		if self:IsDifficulty("heroic10", "heroic25") then--In heroic, all mounts die in phase 4.
			DBM.BossHealth:RemoveBoss(cid)
		else
			phase = 4
			updateHealthFrame()
			self:Unschedule(checkSpear)
			timerThrowSpearCD:Cancel()
			self:UnregisterShortTermEvents()
			warnPhase4:Show()
			timerRisingAngerCD:Start()
			timerFistSmashCD:Start(22.5, 1)--fist smash cd is random. (22.5 or 31.5)
		end
	end
end
