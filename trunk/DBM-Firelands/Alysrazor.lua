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
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
--	"RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_POWER"
)

local warnMolting		= mod:NewSpellAnnounce(99464, 3)
local warnFirestorm		= mod:NewSpellAnnounce(100744, 3)
local warnCataclysm		= mod:NewCastAnnounce(102111, 4)
local warnPhase			= mod:NewAnnounce("WarnPhase", 3)
local warnNewInitiate	= mod:NewAnnounce("WarnNewInitiate", 3, 61131)

local specWarnFirestorm			= mod:NewSpecialWarningSpell(100744, nil, nil, nil, true)
local specWarnFieroblast		= mod:NewSpecialWarningInterrupt(101223)
local specWarnGushingWoundSelf	= mod:NewSpecialWarningYou(99308, false)
local specWarnTantrum			= mod:NewSpecialWarningSpell(99362, mod:IsTank())
local specWarnGushingWoundOther	= mod:NewSpecialWarningTarget(99308, false)

local timerFieryVortexCD	= mod:NewNextTimer(195, 99794)
local timerMoltingCD		= mod:NewNextTimer(60, 99464)
local timerCataclysm		= mod:NewCastTimer(5, 102111)--Heroic
local timerCataclysmCD		= mod:NewCDTimer(31, 102111)--Heroic
local timerFirestormCD		= mod:NewCDTimer(78, 100744)--Heroic
local timerPhaseChange		= mod:NewTimer(30, "TimerPhaseChange", 99816)
local timerHatchEggs		= mod:NewTimer(50, "TimerHatchEggs", 42471)
local timerNextInitiate		= mod:NewTimer(32, "timerNextInitiate", 61131)

mod:AddBoolOption("InfoFrame", false)--Why is this useful?

local phase = 1
local initiatesSpawned = 0
local CataCast = 0
local eggsHatched = 0
local eggsSpam = 0

--Credits to public WoL http://www.worldoflogs.com/reports/rt-qy30xgzau5w12aae/xe/?enc=bosses&boss=52530&x=spell+%3D+%22Cataclysm%22+or+spell+%3D+%22Burnout%22+or+spell+%3D+%22Firestorm%22+and+%28fulltype+%3D+SPELL_CAST_SUCCESS+or+fulltype+%3D+SPELL_CAST_START+or+fulltype+%3D+SPELL_AURA_APPLIED++or+fulltype+%3D+SPELL_AURA_REMOVED%29
--For heroic information drycodes.

function mod:OnCombatStart(delay)
	if mod:IsDifficulty("heroic10", "heroic25") then
		timerFieryVortexCD:Start(250-delay)--Probably not right.
		timerCataclysmCD:Start(32-delay)
		timerHatchEggs:Start(42-delay)
	else
		timerFieryVortexCD:Start(-delay)
		timerHatchEggs:Start(50-delay)
	end
	timerNextInitiate:Start(27-delay)
	phase = 1
	initiatesSpawned = 0
	CataCast = 0
	eggsHatched = 0
	eggsSpam = 0
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
	if args:IsSpellID(99362) and ((args.sourceGUID == UnitGUID("target") and mod:IsTank()) or not mod:IsTank()) then--Only give tantrum warning if it's mob you're targeting and you're a tank, else, always give tantrum warning regardless of target
		specWarnTantrum:Show()
	elseif args:IsSpellID(99308) then--Gushing Wound
		specWarnGushingWoundOther:Show(args.destName)
		if args:IsPlayer() then
			specWarnGushingWoundSelf:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(100744) then--Firestorm removed from boss. No reason for a heroic check here, this shouldn't happen on normal.
		if CataCast < 3 then
			timerCataclysmCD:Start(10)--10 seconds after first firestorm ends
		else
			timerCataclysmCD:Start(20)--20 seconds after second one ends.
		end
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
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(99464, 100698, 100836, 100837) then	--99464, 100698 confirmed
		if mod:IsDifficulty("normal10", "normal25") then--She does this during firestorm on heroic. So only warn for one of them.
			warnMolting:Show()
			timerMoltingCD:Start()
		end
		if phase ~= 1 then
			phase = 1
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 or msg:find(L.YellPhase2) then
		warnPhase:Show(2)
		timerMoltingCD:Cancel()
		timerPhaseChange:Start(30, 3)
		phase = 2
		initiatesSpawned = 0
	--Yes it's ugly, but it works.
	elseif msg == L.YellInitiate1 or msg:find(L.YellInitiate1) or msg == L.YellInitiate2 or msg:find(L.YellInitiate2) or msg == L.YellInitiate3 or msg:find(L.YellInitiate3) or msg == L.YellInitiate4 or msg:find(L.YellInitiate4) then
		initiatesSpawned = initiatesSpawned + 1
		warnNewInitiate:Show(initiatesSpawned)
		if initiatesSpawned == 6 then return end--All 6 are spawned, lets not create any timers.
		if initiatesSpawned < 3 then
			timerNextInitiate:Start(32)
		else
			timerNextInitiate:Start(20)
		end
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(msg)--This is not conventional but it's required for heroic. on heroic you get 3 sets, not 1, but only the first set does emote. :\
	if mod:IsDifficulty("heroic10", "heroic25") and self:IsInCombat() and GetTime() - eggsSpam > 5 then--Hopefully isincombat is enough to keep this from firing all over the place!
		eggsSpam = GetTime()
		eggsHatched = eggsHatched + 1
		if eggsHatched < 3 then
			timerHatchEggs:Start(35)
		end
	end
end

function mod:UNIT_POWER(uId)
	if uId == "boss1" then
		local p = UnitPower(uId, ALTERNATE_POWER_INDEX) / UnitPowerMax(uId, ALTERNATE_POWER_INDEX) * 100
--"<485.7> [CLEU] SPELL_AURA_APPLIED#false#0xF150CD320000B106#Alysrazor#133704#0#0xF150CD320000B106#Alysrazor#133704#0#99432#Burnout#8#BUFF", -- [81748]
		if p == 0 then		-- Seems to drop instantly from 100 -> 0
			warnPhase:Show(3)
			phase = 3
--"<512.9> [RAID_BOSS_EMOTE] RAID_BOSS_EMOTE#|TInterface\\Icons\\inv_elemental_primal_fire.blp:20|t Alysrazor's firey core |cFFFF0000|Hspell:99922|h[Re-Ignites]|h|r!#Alysrazor#0#false", -- [84882]
		elseif phase == 3 and p >= 50 then
			warnPhase:Show(4)
			phase = 4
--"<539.8> [RAID_BOSS_EMOTE] RAID_BOSS_EMOTE#|TInterface\\Icons\\spell_shaman_improvedfirenova.blp:20|t Alysrazor is at |cFFFF0000|Hspell:99925|h[Full Power]|h|r!#Alysrazor#0#false", -- [89245]
		elseif phase == 4 and p == 100 then
			warnPhase:Show(1)
			phase = 1
			eggsHatched = 0
			if mod:IsDifficulty("heroic10", "heroic25") then
				timerFieryVortexCD:Start(225)--Probably not right.
				timerHatchEggs:Start(31)--Guesswork. No idea what this is in herioc yet. didn't get that far on first pull. But it's going to be shorter for sure.
				timerCataclysmCD:Start(18)
				timerFirestormCD:Start(70)
				CataCast = 0
			else
				timerFieryVortexCD:Start(180)
				timerHatchEggs:Start(39)
			end
		end
	end
end