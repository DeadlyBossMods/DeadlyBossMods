local mod	= DBM:NewMod(709, "DBM-TerraceofEndlessSpring", nil, 320)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(60999)--61042 Cheng Kang, 61046 Jinlun Kun, 61038 Yang Guoshi, 61034 Terror Spawn
mod:SetModelID(41772)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

-- Normal and heroic Phase 1
local warnThrash						= mod:NewSpellAnnounce(131996, 4, nil, mod:IsTank() or mod:IsHealer())
--local warnConjureTerrorSpawns			= mod:NewSpellAnnounce(119108, 3)
local warnBreathOfFearSoon				= mod:NewPreWarnAnnounce(119414, 10, 3)
local warnBreathOfFear					= mod:NewSpellAnnounce(119414, 4)
local warnOminousCackle					= mod:NewTargetAnnounce(129147, 3)--129147 is debuff, 119693 is cast. We do not reg warn cast cause we reg warn the actual targets instead. We special warn cast to give a little advanced heads up though.
local warnDreadSpray					= mod:NewSpellAnnounce(120047, 2)
-- Heroic Phase 2
local warnDreadThrash					= mod:NewSpellAnnounce(132007, 4, nil, mod:IsTank() or mod:IsHealer())
local warnNakedAndAfraid				= mod:NewTargetAnnounce(120669, 2, nil, mod:IsTank())
local warnWaterspout					= mod:NewTargetAnnounce(120519, 3)
local warnHuddleInTerror				= mod:NewTargetAnnounce(120629, 3)
local warnImplacableStrike				= mod:NewTargetAnnounce(120672, 3)
local warnChampionOfTheLight			= mod:NewTargetAnnounce(120268, 4)
local warnSubmerge						= mod:NewSpellAnnounce(120455)
local warnEmerge						= mod:NewSpellAnnounce(120458)

-- Normal and heroic Phase 1
local specWarnThrash					= mod:NewSpecialWarningSpell(131996, mod:IsTank())
--local specWarnOminousCackle				= mod:NewSpecialWarningSpell(119693, nil, nil, nil, true)--Cast, warns the entire raid.
local specWarnOminousCackleYou			= mod:NewSpecialWarningYou(129147)--You have debuff, just warns you.
--local specWarnTerrorSpawn				= mod:NewSpecialWarningSwitch("ej6088",  mod:IsDps())
local specWarnDreadSpray				= mod:NewSpecialWarningSpell(120047, nil, nil, nil, true)--Platform ability, particularly nasty damage, and fear.
local specWarnDeathBlossom				= mod:NewSpecialWarningSpell(119888, nil, nil, nil, true)--Cast, warns the entire raid.
-- Heroic Phase 2
local specWarnDreadThrash				= mod:NewSpecialWarningSpell(132007, mod:IsTank())
local specWarnNakedAndAfraidOther		= mod:NewSpecialWarningTarget(120669, mod:IsTank())
local specWarnWaterspout				= mod:NewSpecialWarningYou(120519)
local yellWaterspout					= mod:NewYell(120519)
local specWarnImplacableStrike			= mod:NewSpecialWarningSpell(120672)
local specWarnChampionOfTheLight		= mod:NewSpecialWarningYou(120268)
local specWarnSubmerge					= mod:NewSpecialWarningSpell(120455, nil, nil, nil, true)

-- Normal and heroic Phase 1
local timerThrashCD						= mod:NewCDTimer(9, 131996, nil, mod:IsTank() or mod:IsHealer())--Every 9-12 seconds.
local timerBreathOfFearCD				= mod:NewNextTimer(33.3, 119414)--Based off bosses energy, he casts at 100 energy, and gains about 3 energy per second, so every 33-34 seconds is a breath.
local timerOminousCackleCD				= mod:NewNextTimer(45.5, 119693)
local timerDreadSpray					= mod:NewBuffActiveTimer(8, 120047)
local timerDreadSprayCD					= mod:NewNextTimer(20.5, 120047)
--local timerTerrorSpawnCD				= mod:NewNextTimer(60, 119108)--every 60 or so seconds, maybe a little more maybe a little less, not sure. this is just based on instinct after seeing where 30 fit.
local timerFearless						= mod:NewBuffFadesTimer(30, 118977)
-- Heroic Phase 2
local timerDreadTrashCD					= mod:NewCDTimer(9, 132007)--Share Trash CD.
local timerNakedAndAfraid				= mod:NewTargetTimer(25, 120669)-- EJ says that debuff duration 25 sec.
--local timerNakedAndAfraidCD				= mod:NewCDTimer(25, 120669)-- unconfirmed.
--local timerWaterspoutCD					= mod:NewCDTimer(30, 120519)--unconfirmed.
--local timerHuddleInTerrorCD				= mod:NewCDTimer(30, 120629)--unconfirmed.
--local timerImplacableStrikeCD			= mod:NewCDTimer(30, 120672)--unconfirmed.
local timerSubmergeCD					= mod:NewCDTimer(50, 120455)--guessed (by video).

local berserkTimer						= mod:NewBerserkTimer(900)

local countdownBreathOfFear			= mod:NewCountdown(33.3, 119414, nil, nil, 10)

mod:AddBoolOption("RangeFrame")--For Eerie Skull (2 yards)

local ominousCackleTargets = {}
local platformGUIDs = {}
local waterspoutTargets = {}
local huddleInTerrorTargets = {}
local onPlatform = false--Used to determine when YOU are sent to a platform, so we know to activate platformMob on next shoot
local platformMob = nil--Use this so we can filter platform events and show you only ones for YOUR platform while ignoring other platforms events.
local phase2 = false
local thrashCount = 0

local function warnOminousCackleTargets()
	warnOminousCackle:Show(table.concat(ominousCackleTargets, "<, >"))
	table.wipe(ominousCackleTargets)
end

local function warnWaterspoutTargets()
	warnWaterspout:Show(table.concat(waterspoutTargets, "<, >"))
	table.wipe(waterspoutTargets)
end

local function warnHuddleInTerrorTargets()
	warnHuddleInTerror:Show(table.concat(huddleInTerrorTargets, "<, >"))
	table.wipe(huddleInTerrorTargets)
end

function mod:OnCombatStart(delay)
	if self:IsDifficulty("normal10", "heroic10", "lfr25") then
		timerOminousCackleCD:Start(40-delay)
	else
		timerOminousCackleCD:Start(25.5-delay)
	end
--	timerTerrorSpawnCD:Start(25.5-delay)--still not perfect, it's hard to do yells when you're always the tank sent out of range of them. I need someone else to do /yell when they spawn and give me timing
--	self:ScheduleMethod(25.5-delay, "TerrorSpawns")
	warnBreathOfFearSoon:Schedule(23.3-delay)
	timerBreathOfFearCD:Start(-delay)
	countdownBreathOfFear:Start(33.3-delay)
	onPlatform = false
	platformMob = nil
	phase2 = false
	thrashCount = 0
	table.wipe(ominousCackleTargets)
	table.wipe(platformGUIDs)
	table.wipe(waterspoutTargets)
	table.wipe(huddleInTerrorTargets)
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(2)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

--This may now be depricated, i think blizz synced these up to omninous cackle.
--[[function mod:TerrorSpawns()
	if self:IsInCombat() then
		timerTerrorSpawnCD:Start()
		self:UnscheduleMethod("TerrorSpawns")
		self:ScheduleMethod(60, "TerrorSpawns")
	end
end--]]

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(119414) and self:AntiSpam(5, 1) then--using this with antispam is still better then registering SPELL_CAST_SUCCESS for a single event when we don't have to. Less cpu cause mod won't have to check every SPELL_CAST_SUCCESS event.
		warnBreathOfFear:Show()
		if not onPlatform then--not in middle, not your problem
			timerBreathOfFearCD:Start()
			countdownBreathOfFear:Start(33.3)
		end
		warnBreathOfFearSoon:Schedule(23.3)
	elseif args:IsSpellID(129147) then
		ominousCackleTargets[#ominousCackleTargets + 1] = args.destName
		if args:IsPlayer() then
			onPlatform = true
			specWarnOminousCackleYou:Show()
			countdownBreathOfFear:Cancel()
			timerBreathOfFearCD:Cancel()
		end
		self:Unschedule(warnOminousCackleTargets)
		self:Schedule(2, warnOminousCackleTargets)--this actually staggers a bit, so wait the full 2 seconds to get em all in one table
		--"<76.6> [CLEU] SPELL_AURA_APPLIED#false#0x0100000000181B61#Lycanx#1298#0#0x0100000000181B61#Lycanx#1298#0#129147#Ominous Cackle#32#DEBUFF", -- [12143]
		--"<78.3> [CLEU] SPELL_AURA_APPLIED#false#0x0100000000011E0F#Derevka#1300#0#0x0100000000011E0F#Derevka#1300#0#129147#Ominous Cackle#32#DEBUFF", -- [12440]
	elseif args:IsSpellID(120047) and platformMob and args.sourceName == platformMob  then--might change
		warnDreadSpray:Show()
		timerDreadSpray:Start()
		timerDreadSprayCD:Start()
	elseif args:IsSpellID(118977) and args:IsPlayer() then--Fearless, you're leaving platform
		onPlatform = false
		platformMob = nil
		timerFearless:Start()
		--Breath of fear timer recovery
		local shaPower = UnitPower("boss1") --Get Boss Power
		shaPower = shaPower / 3 --Divide it by 3 (cause he gains 3 power per second and we need to know how many seconds to subtrack from fear CD)
		if shaPower < 28 then--Don't bother recovery if breath is in 5 or less seconds, we'll get a new one when it's cast.
			timerBreathOfFearCD:Start(33.3-shaPower)
			countdownBreathOfFear:Start(33.3-shaPower)
		end
	elseif args:IsSpellID(131996) and not onPlatform then
		warnThrash:Show()
		specWarnThrash:Show()
		if phase2 then
			thrashCount = thrashCount + 1
			if thrashCount == 3 then
				timerDreadTrashCD:Start()
			else
				timerThrashCD:Start()
			end
		else
			timerThrashCD:Start()
		end
	elseif args:IsSpellID(132007) then
		thrashCount = 0
		warnDreadThrash:Show()
		specWarnDreadThrash:Show()
		timerThrashCD:Start()
	elseif args:IsSpellID(120669) then
		warnNakedAndAfraid:Show(args.destName)
		specWarnNakedAndAfraidOther:Show(args.destName)
		timerNakedAndAfraid:Start(args.destName)
		--timerNakedAndAfraidCD:Start()--unconfirmed yet.
	elseif args:IsSpellID(120519) then--Waterspout
		if self:AntiSpam(3, 2) then
			--timerWaterspoutCD:Start()
		end
		waterspoutTargets[#waterspoutTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnWaterspout:Show()
			yellWaterspout:Yell()
		end
		self:Unschedule(warnWaterspoutTargets)
		self:Schedule(0.3, warnWaterspoutTargets)--guessed.
	elseif args:IsSpellID(120629) then-- Huddle In Terror
		if self:AntiSpam(3, 2) then
			--timerHuddleInTerrorCD:Start()
		end
		huddleInTerrorTargets[#huddleInTerrorTargets + 1] = args.destName
		self:Unschedule(warnHuddleInTerrorTargets)
		self:Schedule(0.3, warnHuddleInTerrorTargets)--guessed.
	elseif args:IsSpellID(120268) then -- Champion Of The Light
		warnChampionOfTheLight:Show(args.destName)
		if args:IsPlayer() then
			specWarnChampionOfTheLight:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(120047) then
		timerDreadSpray:Cancel(args.sourceGUID)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(119593, 119692, 119693) then--This seems to have multiple spellids, depending on which platform he's going to send you to. TODO, figure out which is which platform and add additional warnings
--		specWarnOminousCackle:Show()
		if self:IsDifficulty("normal10", "heroic10", "lfr25") then
			timerOminousCackleCD:Start(90.5)--Far less often on LFR
		else
			timerOminousCackleCD:Start()
		end
--		if not onPlatform then--Can't switch to them if you aren't in middle.
--			specWarnTerrorSpawn:Show()
--		end
--		warnConjureTerrorSpawns:Show()
	elseif args:IsSpellID(119862) and onPlatform and not platformGUIDs[args.sourceGUID] then--Best way to track engaging one of the side adds, they cast this instantly.
		platformGUIDs[args.sourceGUID] = true
		platformMob = args.sourceName--Get name of your platform mob so we can determine which mob you have engaged
		timerDreadSprayCD:Start(10.5, args.sourceGUID)--We can accurately start perfectly accurate spray cd bar off their first shoot cast.
	elseif args:IsSpellID(119888) and platformMob and args.sourceName == platformMob then
		specWarnDeathBlossom:Show()
	elseif args:IsSpellID(120672) then -- Implacable Strike
		warnImplacableStrike:Show()
		specWarnImplacableStrike:Show()
		--timerImplacableStrikeCD:Start()
	elseif args:IsSpellID(120455) then
		warnSubmerge:Show()
		specWarnSubmerge:Show()
		timerSubmergeCD:Start()
	elseif args:IsSpellID(120458) then
		warnEmerge:Show()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 61042 or cid == 61046 or cid == 61038 then
		timerDreadSpray:Cancel(args.destGUID)
		timerDreadSprayCD:Cancel(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 114936 then--Heroic Phase 2
		phase2 = true
		onPlatform = false
		timerThrashCD:Cancel()
		timerBreathOfFearCD:Cancel()
		timerOminousCackleCD:Cancel()
		timerDreadSpray:Cancel()
		timerDreadSprayCD:Cancel()
		berserkTimer:Cancel() -- berserk timer seems restarts on heroic phase 2.
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end