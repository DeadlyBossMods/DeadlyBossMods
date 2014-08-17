local mod	= DBM:NewMod(817, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68078, 68079, 68080, 68081)--Ro'shak 68079, Quet'zal 68080, Dam'ren 68081, Iron Qon 68078
mod:SetEncounterID(1559)
mod:SetMainBossID(68078)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 134691 134647 137221 136192 135145 136323",
	"SPELL_AURA_APPLIED_DOSE 134691 134647 135145 136323",
	"SPELL_AURA_REMOVED 134647 136192",
	"SPELL_CAST_SUCCESS 134664 137226 137227 137228 137229 137230 137231",
	"SPELL_SUMMON 134926",
	"SPELL_DAMAGE 137668 137669 136520 137764",
	"SPELL_MISSED 137668 137669 136520 137764",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4",
	"UNIT_DIED"
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

local specWarnImpale					= mod:NewSpecialWarningStack(134691, nil, 2)
local specWarnImpaleOther				= mod:NewSpecialWarningTaunt(134691)
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

local timerImpale						= mod:NewTargetTimer(40, 134691, nil, mod:IsTank() or mod:IsHealer())
local timerImpaleCD						= mod:NewCDTimer(20, 134691, nil, mod:IsTank() or mod:IsHealer())
local timerThrowSpearCD					= mod:NewCDTimer(30, 134926)--30-42 second variation observed
local timerUnleashedFlameCD				= mod:NewCDTimer(6, 134611, nil, false)--CD for the periodic trigger, not when he'll actually be at 30 energy and use it.
local timerScorched						= mod:NewBuffFadesTimer(30, 134647)
local timerMoltenOverload				= mod:NewBuffActiveTimer(10, 137221)
local timerLightningStormCD				= mod:NewCDTimer(20, 136192)
local timerWindStorm					= mod:NewBuffActiveTimer(19.8, 136577)--19.8~21.7sec variables
local timerWindStormCD					= mod:NewNextTimer(70, 136577)
local timerFreezeCD						= mod:NewCDTimer(7, 135145, nil, false)
local timerDeadZoneCD					= mod:NewCDTimer(15, 137229)
local timerRisingAngerCD				= mod:NewNextTimer(15, 136323, nil, false)
local timerFistSmash					= mod:NewBuffActiveTimer(8, 136146)
local timerFistSmashCD					= mod:NewCDCountTimer(20, 136146)
local timerWhirlingWindsCD				= mod:NewCDTimer(30, 139167)--Heroic Phase 1
local timerFrostSpikeCD					= mod:NewCDTimer(11, 139180)--Heroic Phase 2

local berserkTimer						= mod:NewBerserkTimer(720)

mod:AddBoolOption("SetIconOnLightningStorm")
mod:AddBoolOption("RangeFrame", true)--One tooltip says 8 yards, other says 10. Confirmed it's 10 during testing though. Ignore the 8 on spellid 134611
mod:AddBoolOption("InfoFrame")

local Roshak = select(2, EJ_GetCreatureInfo(2, 817))
local Quetzal = select(2, EJ_GetCreatureInfo(3, 817))
local Damren = select(2, EJ_GetCreatureInfo(4, 817))
local arcingName = GetSpellInfo(136193)
mod.vb.phase = 1
mod.vb.fistSmashCount = 0
local spearSpecWarnFired = false
--Spear/arcing methods called VERY often, so cache these globals locally
local UnitDetailedThreatSituation, UnitExists, UnitClass, UnitDebuff = UnitDetailedThreatSituation, UnitExists, UnitClass, UnitDebuff

local function updateHealthFrame()
	if DBM.BossHealth:IsShown() then
		DBM.BossHealth:Clear()
		if mod.vb.phase == 1 then
			DBM.BossHealth:AddBoss(68079, Roshak)
		elseif mod.vb.phase == 2 then
			DBM.BossHealth:AddBoss(68080, Quetzal)
		elseif mod.vb.phase == 3 then
			DBM.BossHealth:AddBoss(68081, Damren)
		elseif mod.vb.phase == 4 then
			DBM.BossHealth:AddBoss(68078, L.name)
			if mod:IsHeroic() then
				DBM.BossHealth:AddBoss(68081, Damren)
				DBM.BossHealth:AddBoss(68080, Quetzal)
				DBM.BossHealth:AddBoss(68079, Roshak)
			end
		end
	end
end

--Custom, don't use IsTanking prototype here
local function notEligable(unit)
	-- 1. check blizzard tanks first
	-- 2. check blizzard roles second
	-- 3. check boss' highest threat target
	-- 4. Check monks
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
	--He CAN spear monks that are not in melee (I seen our mistweaver get many spears at ranged).
	--However, if he targets a monk that IS in melee, he switches to a different target (again, i've seen him target our mistweaver in melee range, then instantly switched to ANOTHER target because the mistweaver was in melee).
	--We assume any monk within 15 yards of tank is in melee range, may be wrong once in a blue moon.
	--Should fairly accurately allow the mod to announce spears on monks outside melee range while ignoring monk targets in melee range
	if (select(2, UnitClass(unit)) == "MONK") and (DBM.RangeCheck:GetDistance(unit, "boss2target") <= 15) then
		return true
	end
	return false
end

--Spear target happens BEFORE cast, so we have to pre schedule scan it to grab target
--This will fail if the spear target actually IS his highest threat
--In that case the aoe failsafe warning will just be used, so 1/10 or 1/25 odds in phase 1.
local function checkSpear()
	if UnitExists("boss1target") and not notEligable("boss1target") then--Boss 1 is looking at someone that isn't his highest threat or a tank (have to filter tanks cause he looks at them to cast impale, have to filter his highest threat in case it's not a tank, ie a healer)
		spearSpecWarnFired = true
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
			elseif mod:AntiSpam(15, 6) then--Smart way to do a failsafe in case we never get a valid target
				specWarnThrowSpear:Show()--not spear target or near spear target, generic aoe warning (for the lines and stuff)
			end
		end
	else
		mod:Schedule(0.25, checkSpear)
	end
end

local function checkArcing()
	local arcingDebuffs = 0
	for uId in DBM:GetGroupMembers() do
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
	self.vb.phase = 1
	self.vb.fistSmashCount = 0
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
		timerWhirlingWindsCD:Start(15-delay)
		timerLightningStormCD:Start(22-delay)
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(GetSpellInfo(136193))
			DBM.InfoFrame:Show(5, "playerbaddebuff", 136193)
		end
	end
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 134691 then
		local amount = args.amount or 1
		warnImpale:Show(args.destName, amount)
		timerImpaleCD:Start()
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnImpale:Show(args.amount)
			else
				specWarnImpaleOther:Show(args.destName)
			end
		end
	elseif spellId == 134647 and args:IsPlayer() then
		local amount = args.amount or 1
		if self:IsDifficulty("lfr25") then
			timerScorched:Start(15)
		else
			timerScorched:Start()
		end
		if amount > 2 then
			specWarnScorched:Show(amount)
		end
	elseif spellId == 137221 then
		warnMoltenOverload:Show()
		specWarnMoltenOverload:Show()
		timerMoltenOverload:Start()
	elseif spellId == 136192 then
		warnLightningStorm:Show(args.destName)
		if self.vb.phase == 2 then
			timerLightningStormCD:Start()
		else--Heroic phase 1 or 4
			timerLightningStormCD:Start(37.5)
		end
		if self.Options.SetIconOnLightningStorm and not self:IsDifficulty("lfr25") then
			self:SetIcon(args.destName, 8)
		end
		if args:IsPlayer() then
			specWarnLightningStorm:Show()
			yellLightningStorm:Yell()
		end
	elseif spellId == 135145 then
		warnFreeze:Show(args.destName)
		if self.vb.phase == 3 then
			timerFreezeCD:Start()
		else--Heroic phase 2 or 4
			timerFreezeCD:Start(36)
		end
	elseif spellId == 136323 then
		warnRisingAnger:Show(args.destName, args.amount or 1)
		timerRisingAngerCD:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 134647 and args:IsPlayer() then
		timerScorched:Cancel()
	elseif spellId == 136192 and self.Options.SetIconOnLightningStorm and not self:IsDifficulty("lfr25") then
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 134664 then
		warnMoltenInferno:Show()
	--Dead zone IDs, each dead zone has two shields and two openings. Each spellid identifies those openings.
	elseif spellId == 137226 then--Front, Right Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_FRONT, DBM_CORE_RIGHT)
		timerDeadZoneCD:Start()
		--Attack left or Behind (maybe add special warning that says where you can attack, for dps?)
	elseif spellId == 137227 then--Left, Right Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_LEFT, DBM_CORE_RIGHT)
		timerDeadZoneCD:Start()
		--Attack Front or Behind
	elseif spellId == 137228 then--Left, Front Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_LEFT, DBM_CORE_FRONT)
		timerDeadZoneCD:Start()
		--Attack Right or Behind
	elseif spellId == 137229 then--Back, Front Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_BACK, DBM_CORE_FRONT)
		timerDeadZoneCD:Start()
		--Attack left or Right
	elseif spellId == 137230 then--Back, Left Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_BACK, DBM_CORE_LEFT)
		timerDeadZoneCD:Start()
		--Attack Front or Right
	elseif spellId == 137231 then--Back, Right Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_BACK, DBM_CORE_RIGHT)
		timerDeadZoneCD:Start()
		--Attack Front or Left
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 134926 and self.vb.phase < 4 then
		if self:AntiSpam(15, 6) and not spearSpecWarnFired then--Basically, if the target scanning failed, we do an aoe warning on the actual summon.
			specWarnThrowSpear:Show()
		end
		spearSpecWarnFired = false
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
	elseif (spellId == 136520 or spellId == 137764) and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnFrozenBlood:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 134611 then--Unleashed Flame internal CD. He cannot use more often than every 6 seconds. 137991 is ability activation on pull, before 137991 is cast, he can't use ability at all
		warnUnleashedFlame:Show()
		timerUnleashedFlameCD:Start()
		--NOTE, on heroic phase 3-4, trigger still fires every 6 seconds but energy gain is slower so it won't actually go off often like it does in phase 1.
		--None the less, this timer is accurate on heroic as 6 seconds as it indicates when the next POSSIBLE cast is. in other words, if he reaches enough energy during this cd, he won't cast it until 6 second cd ends
		--This cast is the periodic trigger that checks whether or not boss has 30 energy, nothing more.
	elseif spellId == 50630 then--Eject All Passengers (heroic phase change trigger)
		local cid = self:GetCIDFromGUID(UnitGUID(uId))
		self:Unschedule(checkSpear)
		timerThrowSpearCD:Start()
		if cid == 68079 then--Ro'shak
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10, nil, nil, 1)--Switch range frame back to 1. Range is assumed 10, no spell info
			end
			--Only one log, but i looks like spear cd from phase 1 remains intact
			self.vb.phase = 2
			updateHealthFrame()
			timerUnleashedFlameCD:Cancel()
			timerMoltenOverload:Cancel()
			timerWhirlingWindsCD:Cancel()
			timerImpaleCD:Cancel()
			warnPhase2:Show()
			self:Schedule(25, checkSpear)
			if self:IsHeroic() then
				timerFreezeCD:Start(13)
				timerFrostSpikeCD:Start(15)
			end
			timerLightningStormCD:Start()
			warnWindStorm:Schedule(52)
			specWarnWindStorm:Schedule(52)
			timerWindStorm:Schedule(52)
			timerWindStormCD:Start(52)
		elseif cid == 68080 then--Quet'zal
			self.vb.phase = 3
			updateHealthFrame()
			timerLightningStormCD:Cancel()
			timerWindStorm:Cancel()
			timerWindStormCD:Cancel()
			warnWindStorm:Cancel()
			specWarnWindStorm:Cancel()
			timerFrostSpikeCD:Cancel()
			timerImpaleCD:Cancel()
			warnPhase3:Show()
			self:Schedule(25, checkSpear)
			timerDeadZoneCD:Start(8.5)
			checkArcing()
		elseif cid == 68081 then--Dam'ren
			--confirmed, dam'ren's abilities do NOT reset in phase 4, cds from phase 3 carry over.
			self.vb.phase = 4
			updateHealthFrame()
			timerImpaleCD:Cancel()
			warnPhase4:Show()
			timerRisingAngerCD:Start(15)
			timerFistSmashCD:Start(62, 1)
			self:Unschedule(checkArcing)--Phase 4, new arcings start going out again so no need to do waste time on this check until  quet'zal dies
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10, nil, nil, 1)--Switch range frame back to 1. Range is assumed 10, no spell info
			end
			if self.Options.InfoFrame then
				DBM.InfoFrame:SetHeader(arcingName)
				DBM.InfoFrame:Show(5, "playerbaddebuff", 136193)
			end
		end
	elseif spellId == 139172 then--Whirling Winds (Phase 1 Heroic).
		warnWhirlingWinds:Show()
		timerWhirlingWindsCD:Start()
	elseif spellId == 139181 then--Frost Spike (Phase 2 Heroic)
		warnFrostSpike:Show()
		timerFrostSpikeCD:Start()
	elseif spellId == 137656 and self.vb.phase == 2 and self:AntiSpam(2, 1) then--Rushing Winds (Wind Storm end trigger). ANTISPAM still needed, multiple get cast
		warnWindStorm:Cancel()
		specWarnWindStorm:Cancel()
		warnWindStormEnd:Show()
		warnWindStorm:Schedule(70)
		specWarnWindStorm:Schedule(70)
		timerWindStorm:Schedule(70)
		timerWindStormCD:Start()
	elseif spellId == 136146 and self:AntiSpam(2, 5) then
		if self.vb.phase < 4 then--Shit broke, which happens sometimes
			self.vb.phase = 4
			timerThrowSpearCD:Cancel()
			self:Unschedule(checkSpear)
		end
		self.vb.fistSmashCount = self.vb.fistSmashCount + 1
		warnFistSmash:Show(self.vb.fistSmashCount)
		specWarnFistSmash:Show()
		timerFistSmash:Start()
		if self:IsHeroic() then
			timerFistSmashCD:Start(28, self.vb.fistSmashCount+1) -- heroic cd longer.
		else
			timerFistSmashCD:Start(nil, self.vb.fistSmashCount+1)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 68079 then--Ro'shak
		timerUnleashedFlameCD:Cancel()
		timerMoltenOverload:Cancel()
		if self:IsHeroic() and DBM.BossHealth:IsShown() then--In heroic, all mounts die in phase 4.
			DBM.BossHealth:RemoveBoss(cid)
		else
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10, nil, nil, 1)--Switch range frame back to 1. Range is assumed 10, no spell info
			end
			if self.Options.InfoFrame and not self:IsDifficulty("lfr25") then
				DBM.InfoFrame:SetHeader(arcingName)
				DBM.InfoFrame:Show(5, "playerbaddebuff", 136193)
			end
			self.vb.phase = 2
			updateHealthFrame()
			timerImpaleCD:Cancel()
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
		if not self:IsDifficulty("lfr25") then--LFR has no concept of clearing arcing, they certainly don't use info/range frames
			checkArcing()
		else--So just hide range frame when quet'zal dies
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
		if self:IsHeroic() and DBM.BossHealth:IsShown() then--In heroic, all mounts die in phase 4.
			DBM.BossHealth:RemoveBoss(cid)
		else
			self.vb.phase = 3
			updateHealthFrame()
			timerImpaleCD:Cancel()
			warnPhase3:Show()
			timerDeadZoneCD:Start(6)
			self:Unschedule(checkSpear)
			self:Schedule(25, checkSpear)
			timerThrowSpearCD:Start()
		end
	elseif cid == 68081 then--Dam'ren
		timerDeadZoneCD:Cancel()
		timerFreezeCD:Cancel()
		if self:IsHeroic() and DBM.BossHealth:IsShown() then--In heroic, all mounts die in phase 4.
			DBM.BossHealth:RemoveBoss(cid)
		else
			self.vb.phase = 4
			updateHealthFrame()
			timerImpaleCD:Cancel()
			timerThrowSpearCD:Cancel()
			self:Unschedule(checkSpear)
			self:UnregisterShortTermEvents()
			warnPhase4:Show()
			timerRisingAngerCD:Start()
			timerFistSmashCD:Start(22.5, 1)--fist smash cd is random. (22.5 or 31.5)
		end
	end
end
