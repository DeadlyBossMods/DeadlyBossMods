if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
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
local warnThrowSpear					= mod:NewSpellAnnounce(134926, 3)--TODO, TEST target scanning here. It's probably touchy as shannox SPELL_SUMMON target scanning so will probably use same code
local warnMoltenOverload				= mod:NewSpellAnnounce(137221, 4)
local warnWindStorm						= mod:NewSpellAnnounce(136577, 4)
local warnLightningStorm				= mod:NewTargetAnnounce(136192, 3)
local warnDeadZone						= mod:NewAnnounce("warnDeadZone", 3, 137229)
local warnFreeze						= mod:NewTargetAnnounce(135145, 3, nil, false)--Spammy, more of a duh type warning I think
local warnRisingAnger					= mod:NewStackAnnounce(136323, 2, nil, false)
local warnFistSmash						= mod:NewSpellAnnounce(136146, 3)
local warnWhirlingWinds					= mod:NewSpellAnnounce(139167, 3)--Heroic Phase 1
local warnFrostSpike					= mod:NewSpellAnnounce(139180, 3)--Heroic Phase 2

local specWarnImpale					= mod:NewSpecialWarningStack(134691, mod:IsTank(), 3)
local specWarnImpaleOther				= mod:NewSpecialWarningTarget(134691, mod:IsTank())
local specWarnThrowSpear				= mod:NewSpecialWarningSpell(134926, nil, nil, nil, 2)
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
local timerWindStormCD					= mod:NewNextTimer(70, 136577)
local timerFreezeCD						= mod:NewCDTimer(7, 135145, nil, false)
local timerDeadZoneCD					= mod:NewCDTimer(15, 137229)
local timerRisingAngerCD				= mod:NewNextTimer(10, 136323, nil, false)
local timerFistSmashCD					= mod:NewNextTimer(20, 136146)
local timerWhirlingWindsCD				= mod:NewCDTimer(30, 139167)--Heroic Phase 1
local timerFrostSpikeCD					= mod:NewCDTimer(12, 139180)--Heroic Phase 2

local berserkTimer						= mod:NewBerserkTimer(720)

mod:AddBoolOption("RangeFrame", true)--One tooltip says 8 yards, other says 10. Confirmed it's 10 during testing though. Ignore the 8 on spellid 134611
mod:AddBoolOption("InfoFrame")

local phase = 1--Not sure this is useful yet, coding it in, in case spear cd is different in different phases
local arcingName = GetSpellInfo(136193)

local function checkArcing()
	local arcingDebuffs = 0
	for i = 1, GetNumGroupMembers() do
		local uId = "raid"..i
		if UnitDebuff(uId, arcingName) then
			arcingDebuffs = arcingDebuffs + 1
		end
	end
	if arcingDebuffs == 0 then
		self:Unschedule(checkArcing)
		if mod.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if mod.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	else
		print("DBM Debug: "..arcingDebuffs.." debuffs remaining.")--To figure out why this isn't working, because i thought the code was pretty solid
		self:Schedule(5, checkArcing)
	end
end

function mod:OnCombatStart(delay)
	phase = 1
	timerThrowSpearCD:Start(-delay)
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
	if args:IsSpellID(134691) then
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
	elseif args:IsSpellID(134647) then
		--Once more strats are formed, maybe insert some rotation stuff here
		if args:IsPlayer() then
			timerScorched:Start()
		end
	elseif args:IsSpellID(137221) then
		warnMoltenOverload:Show()
		specWarnMoltenOverload:Show()
		timerMoltenOverload:Start()
	elseif args:IsSpellID(136192) then
		warnLightningStorm:Show(args.destName)
		if phase == 1 then--Heroic
			timerLightningStormCD:Start(38)
		else
			timerLightningStormCD:Start()
		end
		if args:IsPlayer() then
			specWarnLightningStorm:Show()
			yellLightningStorm:Yell()
		end
	elseif args:IsSpellID(135145) then
		warnFreeze:Show(args.destName)
		if phase == 2 then--Heroic
			timerFreezeCD:Start(36)
		else
			timerFreezeCD:Start()
		end
	elseif args:IsSpellID(136323) then
		warnRisingAnger:Show(args.destName, args.amount or 1)
		timerRisingAngerCD:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(134647) and args:IsPlayer() then
		timerScorched:Cancel()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	--Dead zone IDs, each dead zone has two shields and two openings. Each spellid identifies those openings.
	if args:IsSpellID(137226) then--Front, Right Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_FRONT, DBM_CORE_RIGHT)
		timerDeadZoneCD:Start()
		--Attack left or Behind (maybe add special warning that says where you can attack, for dps?)
	elseif args:IsSpellID(137227) then--Left, Right Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_LEFT, DBM_CORE_RIGHT)
		timerDeadZoneCD:Start()
		--Attack Front or Behind
	elseif args:IsSpellID(137228) then--Left, Front Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_LEFT, DBM_CORE_FRONT)
		timerDeadZoneCD:Start()
		--Attack Right or Behind
	elseif args:IsSpellID(137229) then--Back, Front Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_BACK, DBM_CORE_FRONT)
		timerDeadZoneCD:Start()
		--Attack left or Right
	elseif args:IsSpellID(137230) then--Back, Left Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_BACK, DBM_CORE_LEFT)
		timerDeadZoneCD:Start()
		--Attack Front or Right
	elseif args:IsSpellID(137231) then--Back, Right Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_BACK, DBM_CORE_RIGHT)
		timerDeadZoneCD:Start()
		--Attack Front or Left
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(134926) then
		warnThrowSpear:Show()
		specWarnThrowSpear:Show()
		timerThrowSpearCD:Start()
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
		timerUnleashedFlameCD:Start()
	elseif spellId == 50630 and self:AntiSpam(2, 6) then--Eject All Passengers (heroic phase change trigger)
		local cid = self:GetCIDFromGUID(UnitGUID(uId))
		timerThrowSpearCD:Start(39)--TODO: Verify this is consistent
		if cid == 68079 then--Ro'shak
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10, nil, nil, 1)--Switch range frame back to 1. Range is assumed 10, no spell info
			end
			--Only one log, but i looks like spear cd from phase 1 remains intact
			phase = 2
			timerUnleashedFlameCD:Cancel()
			timerMoltenOverload:Cancel()
			timerWhirlingWindsCD:Cancel()
			if self:IsDifficulty("heroic10", "heroic25") then
				timerFreezeCD:Start(13)
				timerFrostSpikeCD:Start(18)
			end
			timerLightningStormCD:Start()
			warnWindStorm:Schedule(52)
			specWarnWindStorm:Schedule(52)
			timerWindStormCD:Start(52)
			print("DBM: Mod beyond this point is incomplete and most timers will be unavailable")
		elseif cid == 68080 then--Quet'zal
			phase = 3
			timerLightningStormCD:Cancel()
			timerWindStormCD:Cancel()
			timerFrostSpikeCD:Cancel()
			timerDeadZoneCD:Start(8.5)
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
			timerDeadZoneCD:Cancel()
			timerFreezeCD:Cancel()
			timerRisingAngerCD:Start(12.5)
			timerFistSmashCD:Start(25)
			phase = 4
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
		warnWindStorm:Schedule(70)
		specWarnWindStorm:Schedule(70)
		timerWindStormCD:Start()
	elseif spellId == 136146 and self:AntiSpam(2, 5) then
		warnFistSmash:Show()
		specWarnFistSmash:Show()
		timerFistSmashCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 68079 then--Ro'shak
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10, nil, nil, 1)--Switch range frame back to 1. Range is assumed 10, no spell info
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(arcingName)
			DBM.InfoFrame:Show(5, "playerbaddebuff", 136193)
		end
		--Only one log, but i looks like spear cd from phase 1 remains intact
		phase = 2
		timerUnleashedFlameCD:Cancel()
		timerMoltenOverload:Cancel()
		timerLightningStormCD:Start(17)
		warnWindStorm:Schedule(49.5)
		specWarnWindStorm:Schedule(49.5)
		timerWindStormCD:Start(49.5)
	elseif cid == 68080 then--Quet'zal
		phase = 3
		timerLightningStormCD:Cancel()
		warnWindStorm:Cancel()
		specWarnWindStorm:Cancel()
		timerWindStormCD:Cancel()
		timerDeadZoneCD:Start(6)
		checkArcing()
	elseif cid == 68081 then--Dam'ren
		self:UnregisterShortTermEvents()
		timerDeadZoneCD:Cancel()
		timerFreezeCD:Cancel()
		timerRisingAngerCD:Start()
		timerFistSmashCD:Start(22.5)
		phase = 4
	end
end
