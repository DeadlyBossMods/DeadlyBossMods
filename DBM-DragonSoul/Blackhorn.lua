local mod	= DBM:NewMod(332, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56598)--56427 is Boss, but engage trigger needs the ship which is 56598
mod:SetMainBossID(56427)
mod:SetModelID(39399)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")
mod:SetMinCombatTime(20)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_SUMMON",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"RAID_BOSS_EMOTE",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnDrakesLeft				= mod:NewAddsLeftAnnounce("ej4192", 2, 61248)
local warnHarpoon					= mod:NewTargetAnnounce(108038, 2)
local warnReloading					= mod:NewCastAnnounce(108039, 2)
local warnTwilightOnslaught			= mod:NewCountAnnounce(108862, 4)
local warnPhase2					= mod:NewPhaseAnnounce(2, 3)
local warnRoar						= mod:NewSpellAnnounce(109228, 2)
local warnTwilightFlames			= mod:NewSpellAnnounce(108051, 3)
local warnShockwave					= mod:NewTargetAnnounce(108046, 4)
local warnSunder					= mod:NewStackAnnounce(108043, 3, nil, mod:IsTank() or mod:IsHealer())
local warnConsumingShroud			= mod:NewTargetAnnounce(110598)

local specWarnHarpoon				= mod:NewSpecialWarningTarget(108038, false)
local specWarnTwilightOnslaught		= mod:NewSpecialWarningSpell(107588, nil, nil, nil, true)
local specWarnDeckFireCast			= mod:NewSpecialWarningSpell(110095, false, nil, nil, true)
local specWarnDeckFire				= mod:NewSpecialWarningMove(110095)
local specWarnElites				= mod:NewSpecialWarning("SpecWarnElites", mod:IsTank())
local specWarnShockwave				= mod:NewSpecialWarningMove(108046)
local specWarnShockwaveOther		= mod:NewSpecialWarningTarget(108046, false)
local yellShockwave					= mod:NewYell(108046)
local specWarnTwilightFlames		= mod:NewSpecialWarningMove(108076)
local specWarnSunder				= mod:NewSpecialWarningStack(108043, mod:IsTank(), 3)
local specWarnSunderOther			= mod:NewSpecialWarningTarget(108043, mod:IsTank())

local timerCombatStart				= mod:NewTimer(20.5, "TimerCombatStart", 2457)
local timerAdd						= mod:NewTimer(61, "TimerAdd", 107752)
local timerHarpoonCD				= mod:NewCDTimer(6.5, 108038, nil, mod:IsDps())--If you fail to kill drake until next drake spawning, timer do not match. So better to use cd timer for now.
local timerHarpoonActive			= mod:NewBuffActiveTimer(20, 108038, nil, mod:IsDps())--Seems to always hold at least 20 seconds, beyond that, RNG, but you always get at least 20 seconds before they "snap" free.
local timerReloadingCast			= mod:NewCastTimer(10, 108039, nil, mod:IsDps())
local timerTwilightOnslaught		= mod:NewCastTimer(7, 107588)
local timerTwilightOnslaughtCD		= mod:NewNextCountTimer(35, 107588)
local timerSapperCD					= mod:NewNextTimer(40, "ej4200", nil, nil, nil, 107752)
local timerDegenerationCD			= mod:NewCDTimer(8.5, 109208, nil, mod:IsTank())--8.5-9.5 variation.
local timerBladeRushCD				= mod:NewCDTimer(15.5, 107595)
local timerBroadsideCD				= mod:NewNextTimer(90, 110153)
local timerRoarCD					= mod:NewCDTimer(19, 109228)--19~24 variables
local timerTwilightFlamesCD			= mod:NewNextTimer(8, 108051)
local timerShockwaveCD				= mod:NewCDTimer(23, 108046)
local timerDevastateCD				= mod:NewCDTimer(8.5, 108042, nil, mod:IsTank())
local timerSunder					= mod:NewTargetTimer(30, 108043, nil, mod:IsTank() or mod:IsHealer())
local timerConsumingShroud			= mod:NewCDTimer(30, 110598)
local timerTwilightBreath			= mod:NewCDTimer(20.5, 110213, nil, mod:IsTank() or mod:IsHealer())

local twilightOnslaughtCountdown	= mod:NewCountdown(35, 107588)
local berserkTimer					= mod:NewBerserkTimer(240)

mod:AddBoolOption("SetTextures", false)--Disable projected textures in phase 1, because no harmful spells use them in phase 1, but friendly spells make the blade rush lines harder to see.

local phase2Started = false
local lastFlames = 0
local addsCount = 0
local drakesCount = 6
local lastHarpoons = 0
local twilightOnslaughtCount = 0
local CVAR = false

local function Phase2Delay()
	mod:UnscheduleMethod("AddsRepeat")
	timerAdd:Cancel()
	timerTwilightOnslaughtCD:Cancel()
	twilightOnslaughtCountdown:Cancel()
	timerBroadsideCD:Cancel()
	timerSapperCD:Cancel()
	timerRoarCD:Start(10)
	timerTwilightFlamesCD:Start(12)
	timerShockwaveCD:Start(13)--13-16 second variation
	if mod:IsDifficulty("heroic10", "heroic25") then
		timerConsumingShroud:Start(45)	-- 45seconds once P2 starts?
	end
	if not mod:IsDifficulty("lfr25") then--Assumed, but i find it unlikely a 4 min berserk timer will be active on LFR
		berserkTimer:Start()
	end
	if mod.Options.SetTextures and not GetCVarBool("projectedTextures") and CVAR then--Confirm we turned them off in phase 1 before messing with anything.
		SetCVar("projectedTextures", 1)--Turn them back on for phase 2 if we're the ones that turned em off on pull.
	end
end

function mod:ShockwaveTarget()
	local targetname = self:GetBossTarget(56427)
	if not targetname then return end
	warnShockwave:Show(targetname)
	if targetname == UnitName("player") then
		specWarnShockwave:Show()
		yellShockwave:Yell()
	else
		specWarnShockwaveOther:Show(targetname)
	end
end

function mod:AddsRepeat() -- it seems to be adds summon only 3 times. needs more review
	if addsCount < 2 then -- fix logical error
		addsCount = addsCount + 1
		specWarnElites:Show()
		timerAdd:Start()
		self:ScheduleMethod(61, "AddsRepeat")
		if addsCount == 1 then
			timerHarpoonCD:Start(18)--20 seconds after first elites (Confirmed). If harpoon bug not happening, it comes 18 sec after first elites.
		else--6-7 seconds after sets 2 and 3.
			timerHarpoonCD:Start()--6-7 second variation.
		end
	end
end

function mod:OnCombatStart(delay)
	phase2Started = false
	lastFlames = 0
	addsCount = 0
	drakesCount = 6
	lastHarpoons = 0
	twilightOnslaughtCount = 0
	CVAR = false
	timerCombatStart:Start(-delay)
	timerAdd:Start(22.8-delay)
	self:ScheduleMethod(22.8-delay, "AddsRepeat")
	timerTwilightOnslaughtCD:Start(48-delay, 1)
	twilightOnslaughtCountdown:Start(48-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerBroadsideCD:Start(57-delay)
	end
	if not self:IsDifficulty("lfr25") then--No sappers in LFR
		timerSapperCD:Start(69-delay)
	end
	if DBM.BossHealth:IsShown() then
		local shipname = EJ_GetSectionInfo(4202)
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(56598, shipname)
	end
	if self.Options.SetTextures and GetCVarBool("projectedTextures") then--This is only true if projected textures were on when we pulled and option to control setting is also on.
		CVAR = true--so set this variable to true, which means we are allowed to mess with users graphics settings
		SetCVar("projectedTextures", 0)
	end
end

function mod:OnCombatEnd()
	if self.Options.SetTextures and not GetCVarBool("projectedTextures") and CVAR then--Only turn them back on if they are off now, but were on when we pulled, and the setting is enabled.
		SetCVar("projectedTextures", 1)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(107588) then
		twilightOnslaughtCount = twilightOnslaughtCount + 1
		warnTwilightOnslaught:Show(twilightOnslaughtCount)
		specWarnTwilightOnslaught:Show()
		timerTwilightOnslaught:Start()
		timerTwilightOnslaughtCD:Start(nil, twilightOnslaughtCount + 1)
		twilightOnslaughtCountdown:Start()
	elseif args:IsSpellID(108046) then
		self:ScheduleMethod(0.2, "ShockwaveTarget")
		timerShockwaveCD:Start()
	elseif args:IsSpellID(110210, 110213) then
		timerTwilightBreath:Start()
	elseif args:IsSpellID(108039) then
		warnReloading:Show()
		timerReloadingCast:Start(args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(108044, 109228, 109229, 109230) then
		warnRoar:Show()
		timerRoarCD:Start()
	elseif args:IsSpellID(108042) then
		timerDevastateCD:Start()
	elseif args:IsSpellID(107558, 108861, 109207, 109208) then
		timerDegenerationCD:Start(args.sourceGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(108043) then
		warnSunder:Show(args.destName, args.amount or 1)
		timerSunder:Start(args.destName)
		if args:IsPlayer() then
			if (args.amount or 1) >= 3 then
				specWarnSunder:Show(args.amount)
			end
		else
			if (args.amount or 1) >= 2 and not UnitDebuff("player", GetSpellInfo(108043)) and not UnitIsDeadOrGhost("player") then--Other tank has 2 or more sunders and you have none.
				specWarnSunderOther:Show(args.destName)--So nudge you to taunt it off other tank already.
			end
		end
	elseif args:IsSpellID(108038) then
		-- Sometimes first harpoon bug is not happens. So always igonre 2 harpoons can be broken on first harpooning.
		-- <not bugged>
		-- 2/24 20:38:43.901  Sky Captain Swayze yells: All ahead full. Everything depends on our speed! We can't let the Destroyer get away. -- combat start message.
		-- 2/24 20:39:21.864  SPELL_CAST_START,0xF150DD69000007FC,"Skyfire Harpoon Gun",0xa18,0x0,0x0000000000000000,nil,0x80000000,0x80000000,108038,"Harpoon",0x1
		-- 2/24 20:39:21.864  SPELL_CAST_START,0xF150DD69000007FC,"Skyfire Harpoon Gun",0xa18,0x0,0x0000000000000000,nil,0x80000000,0x80000000,108038,"Harpoon",0x1
		-- 2/24 20:39:23.779  SPELL_AURA_APPLIED,0xF150DD69000007FC,"Skyfire Harpoon Gun",0xa18,0x0,0xF150DE17000071E9,"Twilight Assault Drake",0xa48,0x0,108038,"Harpoon",0x1,BUFF -- 40 sec (first harpooning. not bugged)
		-- 2/24 20:39:23.779  SPELL_AURA_APPLIED,0xF150DD69000007FC,"Skyfire Harpoon Gun",0xa18,0x0,0xF150DE17000071E9,"Twilight Assault Drake",0xa48,0x0,108038,"Harpoon",0x1,BUFF
		-- <bugged>
		-- 2/24 20:50:11.266  Sky Captain Swayze yells: All ahead full. Everything depends on our speed! We can't let the Destroyer get away. -- combat start message.
		-- 2/24 20:50:51.379  SPELL_CAST_START,0xF150DD69000008E1,"Skyfire Harpoon Gun",0xa18,0x0,0x0000000000000000,nil,0x80000000,0x80000000,108038,"Harpoon",0x1
		-- 2/24 20:50:51.379  SPELL_CAST_START,0xF150DD69000008E1,"Skyfire Harpoon Gun",0xa18,0x0,0x0000000000000000,nil,0x80000000,0x80000000,108038,"Harpoon",0x1
		-- 2/24 20:50:51.780  SPELL_CAST_START,0xF150DD69000007FC,"Skyfire Harpoon Gun",0xa18,0x0,0x0000000000000000,nil,0x80000000,0x80000000,108038,"Harpoon",0x1
		-- 2/24 20:50:51.780  SPELL_CAST_START,0xF150DD69000007FC,"Skyfire Harpoon Gun",0xa18,0x0,0x0000000000000000,nil,0x80000000,0x80000000,108038,"Harpoon",0x1
		-- 2/24 20:50:52.191  SPELL_AURA_REMOVED,0xF150DD69000007FC,"Skyfire Harpoon Gun",0xa18,0x0,0xF150DE17000081F7,"Twilight Assault Drake",0xa48,0x0,108038,"Harpoon",0x1,BUFF
		-- 2/24 20:50:52.191  SPELL_AURA_REMOVED,0xF150DD69000007FC,"Skyfire Harpoon Gun",0xa18,0x0,0xF150DE17000081F7,"Twilight Assault Drake",0xa48,0x0,108038,"Harpoon",0x1,BUFF
		-- 2/24 20:50:52.191  SPELL_CAST_START,0xF150DD69000008E1,"Skyfire Harpoon Gun",0xa18,0x0,0x0000000000000000,nil,0x80000000,0x80000000,108038,"Harpoon",0x1
		-- 2/24 20:50:52.191  SPELL_CAST_START,0xF150DD69000008E1,"Skyfire Harpoon Gun",0xa18,0x0,0x0000000000000000,nil,0x80000000,0x80000000,108038,"Harpoon",0x1
		-- 2/24 20:50:53.530  SPELL_AURA_APPLIED,0xF150DD69000007FC,"Skyfire Harpoon Gun",0xa18,0x0,0xF150DE17000081F7,"Twilight Assault Drake",0xa48,0x0,108038,"Harpoon",0x1,BUFF
		-- 2/24 20:50:53.530  SPELL_AURA_APPLIED,0xF150DD69000007FC,"Skyfire Harpoon Gun",0xa18,0x0,0xF150DE17000081F7,"Twilight Assault Drake",0xa48,0x0,108038,"Harpoon",0x1,BUFF
		-- 2/24 20:50:54.134  SPELL_AURA_APPLIED,0xF150DD69000008E1,"Skyfire Harpoon Gun",0xa18,0x0,0xF150DD0B000081F5,"Twilight Assault Drake",0xa48,0x0,108038,"Harpoon",0x1,BUFF -- 42.8 sec (first harpooning)
		-- 2/24 20:50:54.134  SPELL_AURA_APPLIED,0xF150DD69000008E1,"Skyfire Harpoon Gun",0xa18,0x0,0xF150DD0B000081F5,"Twilight Assault Drake",0xa48,0x0,108038,"Harpoon",0x1,BUFF
		if GetTime() - lastHarpoons > 5 then -- Use time check for harpooning warning. It can be avoid bad casts also.
			warnHarpoon:Show(args.destName)
			specWarnHarpoon:Show(args.destName)
			lastHarpoons = GetTime()
		end
		-- Timer not use time check. 2 harpoons cast same time even not bugged.
		if self:IsDifficulty("heroic10", "heroic25") then
			timerHarpoonActive:Start(nil, args.destGUID)
		elseif self:IsDifficulty("normal10", "normal25") then
			timerHarpoonActive:Start(25, args.destGUID)
		end
	elseif args:IsSpellID(108040) and not phase2Started then--Goriona is being shot by the ships Artillery Barrage (phase 2 trigger)
		self:Schedule(10, Phase2Delay)--It seems you can still get phase 1 crap until blackhorn's yell 10 seconds after this trigger, so we delay canceling timers.
		phase2Started = true
		warnPhase2:Show()--We still warn phase 2 here though to get into position, especially since he can land on deck up to 5 seconds before his yell.
		timerCombatStart:Start(5)--5-8 seems variation, we use shortest.
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:AddBoss(56427, L.name)
		end
	elseif args:IsSpellID(110598, 110214) then
		warnConsumingShroud:Show(args.destName)
		timerConsumingShroud:Start()
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(108051, 109216, 109217, 109218) then
		warnTwilightFlames:Show()
		timerTwilightFlamesCD:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if (spellId == 108076 or spellId == 109222 or spellId == 109223 or spellId == 109224) and destGUID == UnitGUID("player") and GetTime() - lastFlames > 3 then
		specWarnTwilightFlames:Show()
		lastFlames = GetTime()
	elseif spellId == 110095 and destGUID == UnitGUID("player") and GetTime() - lastFlames > 3  then
		specWarnDeckFire:Show()
		lastFlames = GetTime()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.SapperEmote or msg:find(L.SapperEmote) then
		timerSapperCD:Start()
	elseif msg == L.Broadside or msg:find(L.Broadside) then
		timerBroadsideCD:Start()
	elseif msg == L.DeckFire or msg:find(L.DeckFire) then
		specWarnDeckFireCast:Show()
	elseif msg == L.GorionaRetreat or msg:find(L.GorionaRetreat) then
		self:Schedule(1.5, function()
			timerTwilightBreath:Cancel()
			timerConsumingShroud:Cancel()
			timerTwilightFlamesCD:Cancel()
		end)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 56427 then--Blackhorn
		DBM:EndCombat(self)
	elseif cid == 56848 or cid == 56854 then--Humanoids
		timerBladeRushCD:Cancel(args.sourceGUID)
		timerDegenerationCD:Cancel(args.sourceGUID)
	elseif cid == 56855 or cid == 56587 then--Drakes
		drakesCount = drakesCount - 1
		warnDrakesLeft:Show(drakesCount)
		timerHarpoonActive:Cancel(args.sourceGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 107594 then--Blade Rush, cast start is not detectable, only cast finish, can't use target scanning, or pre warn (ie when the lines go out), only able to detect when they actually finish rush
		self:SendSync("BladeRush", UnitGUID(uId))
	end
end

function mod:OnSync(msg, sourceGUID)
	if msg == "BladeRush" then
		if self:IsDifficulty("heroic10", "heroic25") then
			timerBladeRushCD:Start(sourceGUID)
		else
			timerBladeRushCD:Start(20, sourceGUID)--assumed based on LFR, which seemed to have a 20-25 variation, not 15-20
		end
	end
end