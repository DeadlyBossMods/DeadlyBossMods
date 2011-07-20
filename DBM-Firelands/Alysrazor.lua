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

local specWarnFirestorm			= mod:NewSpecialWarningSpell(100744, nil, nil, nil, true)
local specWarnFieroblast		= mod:NewSpecialWarningInterrupt(101223)
local specWarnGushingWoundSelf	= mod:NewSpecialWarningYou(99308, false)
local specWarnTantrum			= mod:NewSpecialWarningSpell(99362, mod:IsTank())
local specWarnGushingWoundOther	= mod:NewSpecialWarningTarget(99308, false)

local timerCombatStart		= mod:NewTimer(36, "TimerCombatStart", 2457)
local timerFieryVortexCD	= mod:NewNextTimer(195, 99794)
local timerMoltingCD		= mod:NewNextTimer(60, 99464)
local timerCataclysm		= mod:NewCastTimer(5, 102111)--Heroic
local timerCataclysmCD		= mod:NewCDTimer(31, 102111)--Heroic
local timerFirestormCD		= mod:NewCDTimer(83, 100744)--Heroic
local timerPhaseChange		= mod:NewTimer(30, "TimerPhaseChange", 99816)
local timerHatchEggs		= mod:NewTimer(50, "TimerHatchEggs", 42471)
local timerNextInitiate		= mod:NewTimer(32, "timerNextInitiate", 61131)
local timerWingsofFlame		= mod:NewBuffActiveTimer(20, 98619)

mod:AddBoolOption("InfoFrame", false)--Why is this useful?

local initiatesSpawned = 0
local CataCast = 0

--Credits to public WoL http://www.worldoflogs.com/reports/rt-qy30xgzau5w12aae/xe/?enc=bosses&boss=52530&x=spell+%3D+%22Cataclysm%22+or+spell+%3D+%22Burnout%22+or+spell+%3D+%22Firestorm%22+and+%28fulltype+%3D+SPELL_CAST_SUCCESS+or+fulltype+%3D+SPELL_CAST_START+or+fulltype+%3D+SPELL_AURA_APPLIED++or+fulltype+%3D+SPELL_AURA_REMOVED%29
--For heroic information drycodes.

function mod:OnCombatStart(delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerFieryVortexCD:Start(243-delay)--Probably not right.
		timerCataclysmCD:Start(32-delay)
		timerHatchEggs:Start(42-delay)
		timerFirestormCD:Start(94-delay)
		warnFirestormSoon:Schedule(84-delay)
		timerHatchEggs:Start(37-delay)
	else
		timerFieryVortexCD:Start(-delay)
		timerHatchEggs:Start(47-delay)
	end
	timerNextInitiate:Start(27-delay)--First one is same on both difficulties.
	initiatesSpawned = 0
	CataCast = 0
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
	if args:IsSpellID(99362) and ((args.sourceGUID == UnitGUID("target") and self:IsTank()) or not self:IsTank()) then--Only give tantrum warning if it's mob you're targeting and you're a tank, else, always give tantrum warning regardless of target
		specWarnTantrum:Show()
	elseif args:IsSpellID(99308) then--Gushing Wound
		specWarnGushingWoundOther:Show(args.destName)
		if args:IsPlayer() then
			specWarnGushingWoundSelf:Show()
		end
	elseif args:IsSpellID(99432) then--Burnout applied (0 energy)
		warnPhase:Show(3)
	elseif args:IsSpellID(98619) and args:IsPlayer() then
		timerWingsofFlame:Start()
	end
end

function mod:SPELL_AURA_REFRESH(args)
	if args:IsSpellID(98619) and args:IsPlayer() then
		timerWingsofFlame:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(100744) then--Firestorm removed from boss. No reason for a heroic check here, this shouldn't happen on normal.
		timerHatchEggs:Start(16.5)
		if CataCast < 3 then
			timerCataclysmCD:Start(10)--10 seconds after first firestorm ends
		else
			timerCataclysmCD:Start(20)--20 seconds after second one ends. (or so i thought, my new logs show only 4 cataclysms not 5. wtf. I hate inconsistencies
		end
	elseif args:IsSpellID(99432) then--Burnout removed (50 energy)
		warnPhase:Show(4)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(101223, 101294, 101295, 101296) then
		if args.sourceGUID == UnitGUID("target") then
			specWarnFieroblast:Show()
		end
	elseif args:IsSpellID(102111, 100761) then
		CataCast = CataCast + 1
		warnCataclysm:Show()
		timerCataclysm:Start()
		if CataCast == 1 or CataCast == 3 then--Cataclysm is cast 5 times, but there is a firestorm in middle them affecting CD on 2nd and 4th, so you only want to start 30 sec bar after first and third
			timerCataclysmCD:Start()
		end
	elseif args:IsSpellID(100744) then
		warnFirestorm:Show()
		specWarnFirestorm:Show()
		if CataCast < 3 then--Firestorm is only cast 2 times per phase. This essencially makes cd bar only start once.
			timerFirestormCD:Start()
			warnFirestormSoon:Cancel()--Just in case it's wrong. WoL may not be perfect, i'll have full transcriptor logs soon.
			warnFirestormSoon:Schedule(73)
		end
	elseif args:IsSpellID(100559) then--Roots from the first pull RP
		timerCombatStart:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(99464, 100698, 100836, 100837) then	--99464, 100698 confirmed
		if self:IsDifficulty("normal10", "normal25") then--She does this during firestorm on heroic. So only warn for one of them.
			warnMolting:Show()
			timerMoltingCD:Start()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 or msg:find(L.YellPhase2) then--Basically the pre warn to feiry vortex
		warnPhase:Show(2)
		timerMoltingCD:Cancel()
		timerPhaseChange:Start(30, 3)
		initiatesSpawned = 0
	--Yes it's ugly, but it works.
	elseif msg == L.YellInitiate1 or msg:find(L.YellInitiate1) or msg == L.YellInitiate2 or msg:find(L.YellInitiate2) or msg == L.YellInitiate3 or msg:find(L.YellInitiate3) or msg == L.YellInitiate4 or msg:find(L.YellInitiate4) then
		initiatesSpawned = initiatesSpawned + 1
		warnNewInitiate:Show(initiatesSpawned)
		if self:IsDifficulty("heroic10", "heroic25") then
			if initiatesSpawned == 1 then
				timerNextInitiate:Start(22)
			elseif initiatesSpawned == 2 then
				timerNextInitiate:Start(63)
			elseif initiatesSpawned == 3 then
				timerNextInitiate:Start(42)
			elseif initiatesSpawned == 4 then
				timerNextInitiate:Start(40)
			end
		else
			if initiatesSpawned == 6 then return end--All 6 are spawned, lets not create any timers.
			if initiatesSpawned < 3 then
				timerNextInitiate:Start(32)
			else
				timerNextInitiate:Start(20)
			end	
		end
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.FullPower or msg:find(L.FullPower) then
		warnPhase:Show(1)
		timerNextInitiate:Start(13.5)--Seems same on both.
		if self:IsDifficulty("heroic10", "heroic25") then
			timerFieryVortexCD:Start(225)--Probably not right.
			timerHatchEggs:Start(22)
			timerCataclysmCD:Start(18)
			timerFirestormCD:Start(70)
			warnFirestormSoon:Schedule(60)
			CataCast = 0
		else
			timerFieryVortexCD:Start(178)
			timerHatchEggs:Start(32)
		end
	end
end
