local mod	= DBM:NewMod(194, "DBM-Firelands", nil, 78)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52530)
mod:SetModelID(38446)
mod:SetZone()
mod:SetUsedIcons()
mod:SetModelSound("Sound\\Creature\\ALYSRAZOR\\VO_FL_ALYSRAZOR_AGGRO.wav", "Sound\\Creature\\ALYSRAZOR\\VO_FL_ALYSRAZOR_TRANSITION_02.wav")
--Long: I serve a new master now, mortals!
--Short: Reborn in Flame!

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL"
)

local warnMolting		= mod:NewSpellAnnounce(99464, 3)
local warnFirestormSoon	= mod:NewPreWarnAnnounce(100744, 10, 3)
local warnFirestorm		= mod:NewSpellAnnounce(100744, 4)
local warnCataclysm		= mod:NewCastAnnounce(102111, 3)
local warnPhase			= mod:NewAnnounce("WarnPhase", 3, "Interface\\Icons\\Spell_Nature_WispSplode")
local warnNewInitiate	= mod:NewAnnounce("WarnNewInitiate", 3, 61131)
local warnBlazingClaw	= mod:NewCountAnnounce(101731, 3)

local specWarnFirestorm			= mod:NewSpecialWarningSpell(100744, nil, nil, nil, true)
local specWarnFieroblast		= mod:NewSpecialWarningInterrupt(101223)
local specWarnGushingWoundSelf	= mod:NewSpecialWarningYou(99308, false)
local specWarnTantrum			= mod:NewSpecialWarningSpell(99362, mod:IsTank())
local specWarnGushingWoundOther	= mod:NewSpecialWarningTarget(99308, false)

local timerCombatStart		= mod:NewTimer(35.5, "TimerCombatStart", 2457)
local timerFieryVortexCD	= mod:NewNextTimer(179, 99794)
local timerMoltingCD		= mod:NewNextTimer(60, 99464)
local timerCataclysm		= mod:NewCastTimer(5, 102111)--Heroic
local timerCataclysmCD		= mod:NewCDTimer(31, 102111)--Heroic
local timerFirestormCD		= mod:NewCDTimer(83, 100744)--Heroic
local timerPhaseChange		= mod:NewTimer(33, "TimerPhaseChange", 99816)
local timerHatchEggs		= mod:NewTimer(50, "TimerHatchEggs", 42471)
local timerNextInitiate		= mod:NewTimer(32, "timerNextInitiate", 61131)
local timerWingsofFlame		= mod:NewBuffActiveTimer(20, 98619)
local timerTantrum			= mod:NewBuffActiveTimer(10, 99362, nil, mod:IsTank())
local timerSatiated			= mod:NewBuffActiveTimer(15, 100852, nil, mod:IsTank())
local timerBlazingClaw		= mod:NewTargetTimer(15, 101731, nil, false)

local FirestormCountdown	= mod:NewCountdown(83, 100744)

mod:AddBoolOption("InfoFrame", false)--Why is this useful?

local initiatesSpawned = 0
local cataCast = 0
local clawCast = 0
local spamClaw = 0

local initiateSpawns = {
	[1] = L.Both,
	[2] = L.Both,
	[3] = L.East,
	[4] = L.West,
	[5] = L.East,
	[6] = L.West
}

--Credits to public WoL http://www.worldoflogs.com/reports/rt-qy30xgzau5w12aae/xe/?enc=bosses&boss=52530&x=spell+%3D+%22Cataclysm%22+or+spell+%3D+%22Burnout%22+or+spell+%3D+%22Firestorm%22+and+%28fulltype+%3D+SPELL_CAST_SUCCESS+or+fulltype+%3D+SPELL_CAST_START+or+fulltype+%3D+SPELL_AURA_APPLIED++or+fulltype+%3D+SPELL_AURA_REMOVED%29
--For heroic information drycodes.

function mod:OnCombatStart(delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerFieryVortexCD:Start(243-delay)--Probably not right.
		timerCataclysmCD:Start(32-delay)
		timerHatchEggs:Start(42-delay)
		timerFirestormCD:Start(94-delay)
		FirestormCountdown:Start(94-delay)--Perhaps some tuning.
		warnFirestormSoon:Schedule(84-delay)
		timerHatchEggs:Start(37-delay)
	else
		timerFieryVortexCD:Start(196-delay)
		timerHatchEggs:Start(47-delay)
	end
	timerNextInitiate:Start(27-delay, L.Both)--First one is same on both difficulties.
	initiatesSpawned = 0
	cataCast = 0
	clawCast = 0
	spamClaw = 0
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(L.PowerLevel)
		DBM.InfoFrame:Show(5, "playerpower", 10, ALTERNATE_POWER_INDEX)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end 

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(99362) and ((args.sourceGUID == UnitGUID("target") and self:IsTank()) or not self:IsTank() and args.sourceGUID == UnitGUID("targettarget")) then--Only give warning if it's mob you're targeting and you're a tank, or you're targeting the tank it's on and he's targeting the bird.
		specWarnTantrum:Show()
		timerTantrum:Show()
	elseif args:IsSpellID(99359, 100850, 100851, 100852) and ((args.sourceGUID == UnitGUID("target") and self:IsTank()) or not self:IsTank() and args.sourceGUID == UnitGUID("targettarget")) then--^^ Same as above only with diff spell
		if self:IsDifficulty("heroic10", "heroic25") then
			timerSatiated:Start(10)
		else
			timerSatiated:Start()
		end
	elseif args:IsSpellID(99308) then--Gushing Wound
		specWarnGushingWoundOther:Show(args.destName)
		if args:IsPlayer() then
			specWarnGushingWoundSelf:Show()
		end
	elseif args:IsSpellID(99432) then--Burnout applied (0 energy)
		warnPhase:Show(3)
	elseif args:IsSpellID(98619) and args:IsPlayer() then
		timerWingsofFlame:Start()
	elseif args:IsSpellID(99844, 101729, 101730, 101731) then
		timerBlazingClaw:Start(args.destName)
		if GetTime() - spamClaw > 1 then--Prevent count from increasing from more then 1 target being hit by it at same time (ie someone is in wrong place)
			spamClaw = GetTime()
			clawCast = clawCast + 1
			if clawCast % 3 == 0 then--Warn every 3
				warnBlazingClaw:Show(clawCast)--We warn for cast count not spell aura applied count, cause there could be two diff people with two diff stack counts
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(101731) then
		timerBlazingClaw:Start(args.destName)
		if GetTime() - spamClaw > 1 then
			spamClaw = GetTime()
			clawCast = clawCast + 1
			if clawCast % 3 == 0 then--Warn every 3
				warnBlazingClaw:Show(clawCast)
			end
		end
	end
end

function mod:SPELL_AURA_REFRESH(args)
	if args:IsSpellID(98619) and args:IsPlayer() then
		timerWingsofFlame:Start()
	elseif args:IsSpellID(99359, 100850, 100851, 100852) and ((args.sourceGUID == UnitGUID("target") and self:IsTank()) or not self:IsTank() and args.sourceGUID == UnitGUID("targettarget")) then--^^ Same as above only with diff spell
		if self:IsDifficulty("heroic10", "heroic25") then
			timerSatiated:Start(10)
		else
			timerSatiated:Start()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(100744) then--Firestorm removed from boss. No reason for a heroic check here, this shouldn't happen on normal.
		timerHatchEggs:Start(16)
		if cataCast < 3 then
			timerCataclysmCD:Start(10)--10 seconds after first firestorm ends
		else
			timerCataclysmCD:Start(20)--20 seconds after second one ends. (or so i thought, my new logs show only 4 cataclysms not 5. wtf. I hate inconsistencies
		end
	elseif args:IsSpellID(99432) and self:IsInCombat() then--Burnout removed (50 energy)
		warnPhase:Show(4)
	elseif args:IsSpellID(99362) and ((args.sourceGUID == UnitGUID("target") and self:IsTank()) or not self:IsTank() and args.sourceGUID == UnitGUID("targettarget")) then
		timerTantrum:Cancel()
	elseif args:IsSpellID(99359, 100850, 100851, 100852) and ((args.sourceGUID == UnitGUID("target") and self:IsTank()) or not self:IsTank() and args.sourceGUID == UnitGUID("targettarget")) then--^^ Same as above only with diff spell
		timerSatiated:Cancel()
	elseif args:IsSpellID(101731) then
		timerBlazingClaw:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(101223, 101294, 101295, 101296) then
		if args.sourceGUID == UnitGUID("target") then
			specWarnFieroblast:Show()
		end
	elseif args:IsSpellID(102111, 100761) then
		cataCast = cataCast + 1
		warnCataclysm:Show()
		timerCataclysm:Start()
		if cataCast == 1 or cataCast == 3 then--Cataclysm is cast 5 times, but there is a firestorm in middle them affecting CD on 2nd and 4th, so you only want to start 30 sec bar after first and third
			timerCataclysmCD:Start()
		end
	elseif args:IsSpellID(100744) then
		warnFirestorm:Show()
		specWarnFirestorm:Show()
		if cataCast < 3 then--Firestorm is only cast 2 times per phase. This essencially makes cd bar only start once.
			timerFirestormCD:Start()
			FirestormCountdown:Start(83)--Perhaps some tuning.
			warnFirestormSoon:Cancel()--Just in case it's wrong. WoL may not be perfect, i'll have full transcriptor logs soon.
			warnFirestormSoon:Schedule(73)
		end
	elseif args:IsSpellID(100559) then--Roots from the first pull RP
		timerCombatStart:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(99464, 100698, 100836, 100837) and self:IsDifficulty("normal10", "normal25") then	--99464, 100698 confirmed
		warnMolting:Show()
		timerMoltingCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 or msg:find(L.YellPhase2) then--Basically the pre warn to feiry vortex
		warnPhase:Show(2)
		timerMoltingCD:Cancel()
		timerPhaseChange:Start(33, 3)
		initiatesSpawned = 0
	--Yes it's ugly, but it works.
	elseif msg == L.YellInitiate1 or msg:find(L.YellInitiate1) or msg == L.YellInitiate2 or msg:find(L.YellInitiate2) or msg == L.YellInitiate3 or msg:find(L.YellInitiate3) or msg == L.YellInitiate4 or msg:find(L.YellInitiate4) then
		initiatesSpawned = initiatesSpawned + 1
		warnNewInitiate:Show(initiateSpawns[initiatesSpawned])
		if initiatesSpawned == 6 then return end--All 6 are spawned, lets not create any timers.
		if self:IsDifficulty("heroic10", "heroic25") then
		--East: 2 adds, firestorm, 2 adds, firestorm, no adds.
		--West: 2 adds, firestorm, 1 add, firestorm, 1 add.
			if initiatesSpawned == 1 then--First on Both sides
				timerNextInitiate:Start(22, L.Both)--Next will be on both sides
			elseif initiatesSpawned == 2 then
				timerNextInitiate:Start(63, L.East)--Next will spawn on east only
			elseif initiatesSpawned == 3 then
				timerNextInitiate:Start(21, L.West)--Next will spawn west only
			elseif initiatesSpawned == 4 then
				timerNextInitiate:Start(21, L.East)--Next will spawn east only, just before fire storm
			elseif initiatesSpawned == 5 then
				timerNextInitiate:Start(40, L.West)--Last will be on west, after a fire storm
			end
		else
			--Using averages, 30-32 and 20-22 are variations.
			if initiatesSpawned == 1 then--First on Both sides
				timerNextInitiate:Start(31, L.Both)--Next will be on both sides
			elseif initiatesSpawned == 2 then
				timerNextInitiate:Start(31, L.East)--Next will spawn on east only
			elseif initiatesSpawned == 3 then
				timerNextInitiate:Start(21, L.West)--Next will spawn west only
			elseif initiatesSpawned == 4 then
				timerNextInitiate:Start(21, L.East)--Next will spawn east only
			elseif initiatesSpawned == 5 then
				timerNextInitiate:Start(21, L.West)--Last will be on west
			end
		end
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.FullPower or msg:find(L.FullPower) then
		warnPhase:Show(1)
		timerNextInitiate:Start(13.5, L.Both)--Seems same on both.
		if self:IsDifficulty("heroic10", "heroic25") then
			timerFieryVortexCD:Start(225)--Probably not right.
			timerHatchEggs:Start(22)
			timerCataclysmCD:Start(18)
			timerFirestormCD:Start(70)--Needs verification.
			FirestormCountdown:Start(70)--Perhaps some tuning.
			warnFirestormSoon:Schedule(60)--Needs verification.
			cataCast = 0
			clawCast = 0
		else
			timerFieryVortexCD:Start()
			timerHatchEggs:Start(32)
		end
	end
end
