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
	"UNIT_DIED"
)

local warnConjureTerrorSpawns			= mod:NewSpellAnnounce(119108, 3)
local warnBreathOfFearSoon				= mod:NewPreWarnAnnounce(119414, 3, 10)
local warnBreathOfFear					= mod:NewSpellAnnounce(119414, 3)
local warnOminousCrackle				= mod:NewTargetAnnounce(129147, 4)--129147 is debuff, 119693 is cast. We do not reg warn cast cause we reg warn the actual targets instead. We special warn cast to give a little advanced heads up though.

local specWarnBreathOfFear				= mod:NewSpecialWarningSpell(119414, nil, nil, nil, true)
local specWarnOminousCrackle			= mod:NewSpecialWarningSpell(119693, nil, nil, nil, true)--Cast, warns the entire raid.
local specWarnOminousCrackleYou			= mod:NewSpecialWarningYou(129147)--You have debuff, just warns you.
local specWarnTerrorSpawn				= mod:NewSpecialWarningSwitch("ej6088",  mod:IsDps())
local specWarnDreadSpray				= mod:NewSpecialWarningSpell(120047, nil, nil, nil, true)--Platform ability, particularly nasty damage, and fear.

local timerBreathOfFearCD				= mod:NewNextTimer(33.5, 119414)--Based off bosses energy, he casts at 100 energy, and gains about 3 energy per second, so every 33-34 seconds is a breath.
local timerOminousCrackleCD				= mod:NewNextTimer(91.5, 119693)
local timerDreadSpray					= mod:NewBuffActiveTimer(8, 120047)
local timerDreadSprayCD					= mod:NewNextTimer(20.5, 120047)

local onPlatform = false--you're on one of side platforms. WARNING: do to no one in the test actually successfully LEAVING platform, we currently don't accurately depict when you leave a platform, only assume it.
local ominousCrackleTargets = {}
local platformGUIDs = {}

local function warnOminousCrackleTargets()
	warnOminousCrackle:Show(table.concat(ominousCrackleTargets, "<, >"))
	table.wipe(ominousCrackleTargets)
end

function mod:OnCombatStart(delay)
	self:TerrorSpawns()
	warnBreathOfFearSoon:Schedule(23.4-delay)
	timerBreathOfFearCD:Start(-delay)
	timerOminousCackleCD:Start(45.5-delay)
	onPlatform = false
	table.wipe(ominousCrackleTargets)
	table.wipe(platformGUIDs)
end

--Does not show in chat log, combat log, or trigger transcriptor event(besides initial pull when it triggers 119108)
--This is completely untested and based solely off wowhead tooltip, could be wrong if blizz has changed timing since making that tooltip (they did hotfix fight some during testing).
function mod:TerrorSpawns()
	if self:IsInCombat() then
		if not onPlatform then--Can't switch to them if you aren't in middle.
			specWarnTerrorSpawn:Show()
		end
		warnConjureTerrorSpawns:Show()
		timerTerrorSpawnCD:Start()
		self:UnscheduleMethod("TerrorSpawns")
		self:ScheduleMethod(30, "TerrorSpawns")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(119414) then
		warnBreathOfFear:Show()
		if not onPlatform then--not in middle, not your problem
			specWarnBreathOfFear:Show()
		end
		warnBreathOfFearSoon:Schedule(23.4)
		timerBreathOfFearCD:Start()--we still start this for EVERYONE though because you can't blindly leave platform and walk into a breath cause you didn't know it was soon.
	elseif args:IsSpellID(129147) then
		ominousCrackleTargets[#ominousCrackleTargets + 1] = args.destName
		if args:IsPlayer() then
			onPlatform = true
			specWarnOminousCrackleYou:Show()
		end
		self:Unschedule(warnOminousCrackleTargets)
		self:Schedule(0.3, warnOminousCrackleTargets)
	elseif args:IsSpellID(120047) and onPlatform then
		timerDreadSpray:Start(args.sourceGUID)--args.sourceGUID in case you screw up and have 2 platforms at same time (probably a wipe at that point)
		timerDreadSprayCD:Start(args.sourceGUID)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(120047) then
		timerDreadSpray:Cancel(args.sourceGUID)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(119693) then
		specWarnOminousCrackle:Show()
		timerOminousCrackleCD:Start()
	elseif args:IsSpellID(119862) and onPlatform and not platformGUIDs[args.sourceGUID] then--Best way to track engaging one of the side adds, they cast this instantly.
		platformGUIDs[args.sourceGUID] = true
		timerDreadSprayCD:Start(10, args.sourceGUID)--We can accurately start perfectly accurate spray cd bar off their first shoot cast.
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 61042 or cid == 61046 or cid == 61038 then
		onPlatform = false--hack for time being, until we have a way to ACCURATELY detect when YOU leave a platform, just assume when any platform mob dies, that you're leaving a platform.
		timerDreadSpray:Cancel(args.destGUID)
		timerDreadSprayCD:Cancel(args.destGUID)
	end
end
