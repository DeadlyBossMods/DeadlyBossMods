local mod	= DBM:NewMod(332, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56598)--56427 is Boss, but engage trigger needs the ship which is 56598
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

local warnHarpoon					= mod:NewTargetAnnounce(108038, 2)
local warnTwilightOnslaught			= mod:NewCountAnnounce(108862, 4)
local warnPhase2					= mod:NewPhaseAnnounce(2, 3)
local warnRoar						= mod:NewSpellAnnounce(109228, 2)
local warnTwilightFlames			= mod:NewSpellAnnounce(108051, 3)
local warnShockwave					= mod:NewTargetAnnounce(108046, 4)
local warnSunder					= mod:NewStackAnnounce(108043, 3, nil, mod:IsTank() or mod:IsHealer())
local warnConsumingShroud			= mod:NewTargetAnnounce(110598)

local specWarnHarpoon				= mod:NewSpecialWarningTarget(108038, false)
local specWarnTwilightOnslaught		= mod:NewSpecialWarningSpell(107588, nil, nil, nil, true)
local specWarnDeckFire				= mod:NewSpecialWarningSpell(110095, false, nil, nil, true)
local specWarnElites				= mod:NewSpecialWarning("SpecWarnElites", mod:IsTank())
local specWarnShockwave				= mod:NewSpecialWarningMove(108046)
local specWarnShockwaveOther		= mod:NewSpecialWarningTarget(108046, false)
local yellShockwave					= mod:NewYell(108046)
local specWarnTwilightFlames		= mod:NewSpecialWarningMove(108076)
local specWarnSunder				= mod:NewSpecialWarningStack(108043, mod:IsTank(), 3)

local timerCombatStart				= mod:NewTimer(20.5, "TimerCombatStart", 2457)
local timerAdd						= mod:NewTimer(61, "TimerAdd", 107752)
local timerTwilightOnslaught		= mod:NewCastTimer(7, 107588)
local timerTwilightOnslaughtCD		= mod:NewNextCountTimer(35, 107588)
local timerSapperCD					= mod:NewNextTimer(40, "ej4200", nil, nil, nil, 107752)
local timerBladeRushCD				= mod:NewCDTimer(17, 107594)--Experiment, 17sec seemed common for heroic, LFR was a variatable 20-25sec? Just need more data, a lot more.
local timerBroadsideCD				= mod:NewNextTimer(90, 110153)
local timerRoarCD					= mod:NewCDTimer(19, 109228)--19~22 variables (i haven't seen any logs where this wasn't always 21.5, are 19s on WoL somewhere?)
local timerTwilightFlamesCD			= mod:NewNextTimer(8, 108051)
local timerShockwaveCD				= mod:NewCDTimer(23, 108046)
local timerSunder					= mod:NewTargetTimer(30, 108043, nil, mod:IsTank() or mod:IsHealer())
local timerConsumingShroud			= mod:NewCDTimer(30, 110598)
local timerTwilightBreath			= mod:NewCDTimer(20.5, 110213, nil, mod:IsTank() or mod:IsHealer())

local twilightOnslaughtCountdown	= mod:NewCountdown(35, 107588)
local berserkTimer					= mod:NewBerserkTimer(240)

local phase2Started = false
local lastFlames = 0
local addsCount = 0
local twilightOnslaughtCount = 0

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
	timerConsumingShroud:Start(45)	-- 45seconds once P2 starts?
	if not mod:IsDifficulty("lfr25") then--Assumed, but i find it unlikely a 4 min berserk timer will be active on LFR
		berserkTimer:Start()
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
	end
end

function mod:OnCombatStart(delay)
	phase2Started = false
	lastFlames = 0
	addsCount = 0
	twilightOnslaughtCount = 0
	timerCombatStart:Start(-delay)
	timerAdd:Start(24-delay)
	self:ScheduleMethod(24-delay, "AddsRepeat")
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
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(108044, 109228, 109229, 109230) then -- 108044 is 10 man / 109228 lfr. other drycoded.
		warnRoar:Show()
		timerRoarCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(108043) then
		warnSunder:Show(args.destName, args.amount or 1)
		timerSunder:Start(args.destName)
		if (args.amount or 0) >= 3 and args:IsPlayer() then
			specWarnSunder:Show(args.amount)
		end
	elseif args:IsSpellID(108038) then
		warnHarpoon:Show(args.destName)
		specWarnHarpoon:Show(args.destName)
	--"<2059.6> [CLEU] SPELL_AURA_APPLIED#false#0xF150DFAC0000253E#Skyfire Cannon#2584#0#0xF150DFAC0000253E#Skyfire Cannon#2584#0#108040#Artillery Barrage#5#BUFF", -- [61321]
	--"<2067.7> [CAST_SUCCEEDED] Goriona:Possible Target<nil>:target:Eject Passenger 1::0:60603", -- [61429]
	--"<2069.5> [MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Looks like I'm doing this myself. Good!#Warmaster Blackhorn###Goriona##0#0##0#564##0#false", -- [61454]
	elseif args:IsSpellID(108040) and not phase2Started then--Goriona is being shot by the ships Artillery Barrage (phase 2 trigger)
		self:Schedule(10, Phase2Delay)--It seems you can still get phase 1 crap until blackhorn is on the deck itself(ie his yell 10 seconds after this trigger) so we delay canceling timers.
		phase2Started = true
		warnPhase2:Show()--We still warn phase 2 here though to get into position, especially since he can land on deck up to 5 seconds before his yell.
		timerCombatStart:Start(5)--5-8 seems variation, we use shortest.
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:Clear()
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
		warnTwilightFlames:Show()--Target scanning? will need to put drake on focus and see
		timerTwilightFlamesCD:Start()
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(108076, 109222, 109223, 109224) then
		if args:IsPlayer() and GetTime() - lastFlames > 3  then
			specWarnTwilightFlames:Show()
			lastFlames = GetTime()
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.SapperEmote or msg:find(L.SapperEmote) then
		timerSapperCD:Start()
	elseif msg == L.Broadside or msg:find(L.Broadside) then
		timerBroadsideCD:Start()
	elseif msg == L.DeckFire or msg:find(L.DeckFire) then
		specWarnDeckFire:Show()
	elseif msg == L.GorionaRetreat or msg:find(L.GorionaRetreat) then
		timerTwilightBreath:Cancel()
		timerConsumingShroud:Cancel()
		timerTwilightFlamesCD:Cancel()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 56427 then
		DBM:EndCombat(self)
	elseif cid == 56781 then
		timerTwilightFlamesCD:Cancel()
	elseif cid == 56848 or cid == 56854 then
		timerBladeRushCD:Cancel(args.sourceGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if spellName == GetSpellInfo(107594) then--Blade Rush, cast start is not detectable, only cast finish, can't use target scanning, or pre warn (ie when the lines go out), only able to detect when they actually finish rush
		self:SendSync("BladeRush", UnitGUID(uId))
	end
end

function mod:OnSync(msg, sourceGUID)
	if msg == "BladeRush" then
		timerBladeRushCD:Start(sourceGUID)
	end
end