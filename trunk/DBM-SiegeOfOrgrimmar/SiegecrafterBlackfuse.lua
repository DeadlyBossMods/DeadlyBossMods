local mod	= DBM:NewMod(865, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71504)--71591 Automated Shredder
--mod:SetQuestID(32744)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER"
)

--Siegecrafter Blackfuse
local warnLaunchSawblade				= mod:NewTargetAnnounce(143265, 3)
local warnProtectiveFrenzy				= mod:NewTargetAnnounce(145365, 3, nil, mod:IsTank() or mod:IsHealer())
local warnElectroStaticCharge			= mod:NewStackAnnounce(143385, 2, nil, mod:IsTank())
local warnOvercharge					= mod:NewTargetAnnounce(145774, 4)--Heroic. Probably doesn't show in combat log and will require emotes i'm sure.
--Automated Shredders
local warnDeathFromAbove				= mod:NewTargetAnnounce(144208, 4)--Player target, not vulnerable shredder target. (should always be cast on highest threat target, but i like it still being a "target" warning)
--The Assembly Line
local warnShockwaveMissileActivated		= mod:NewSpellAnnounce("ej8204", 3, 143639)--Unsure if this will even show in CLEU, may need UNIT event or emote
local warnShockwaveMissile				= mod:NewCountAnnounce(143641, 3)
local warnLaserTurretActivated			= mod:NewSpellAnnounce("ej8208", 3, 143867, false)--Many scripted triggers. gonna need an emote or UNIT_SPELL event for this i'm sure
local warnLaserFixate					= mod:NewTargetAnnounce(143828, 3, 143867)--Not in combat log, needs more debugging to find a way around blizz fail
local warnMagneticCrush					= mod:NewSpellAnnounce(144466, 3)--Unsure if correct ID, could be 143487 instead
local warnBreakinPeriod					= mod:NewTargetAnnounce(145269, 3)--Crawler Mine Spawning
local warnReadyToGo						= mod:NewTargetAnnounce(145580, 4)--Crawler mine not dead fast enough

--Siegecrafter Blackfuse
local specWarnLaunchSawblade			= mod:NewSpecialWarningYou(143265)
local yellLaunchSawblade				= mod:NewYell(143265)
local specWarnProtectiveFrenzy			= mod:NewSpecialWarningTarget(145365, mod:IsTank())
--Automated Shredders
local specWarnAutomatedShredder			= mod:NewSpecialWarningSpell("ej8199", mod:IsTank())--No sense in dps switching when spawn, has damage reduction. This for tank pickup
local specWarnDeathFromAbove			= mod:NewSpecialWarningYou(144208)
local specWarnAutomatedShredderSwitch	= mod:NewSpecialWarningSwitch("ej8199")--i.e. It's vunerable after Death From Above. This is when everyone else switch.
--The Assembly Line
local specWarnAssemblyLine				= mod:NewSpecialWarningSpell("ej8199", mod:IsDps())
local specWarnShockwaveMissileActive	= mod:NewSpecialWarningSpell("ej8204", nil, nil, nil, 2)
local specWarnReadyToGo					= mod:NewSpecialWarningTarget(145580)
local specWarnLaserFixate				= mod:NewSpecialWarningRun(143828)
local yellLaserFixate					= mod:NewYell(143828)
local specWarnSuperheated				= mod:NewSpecialWarningMove(143856)--From lasers. Hard to see, this warning will help a ton
local specWarnMagneticCrush				= mod:NewSpecialWarningSpell(144466, nil, nil, nil, 2)
local specWarnCrawlerMineFixate			= mod:NewSpecialWarningRun(144010)
local yellCrawlerMineFixate				= mod:NewYell(144010, nil, false)

--Siegecrafter Blackfuse
local timerProtectiveFrenzy				= mod:NewBuffActiveTimer(10, 145365, nil, mod:IsTank() or mod:IsHealer())
local timerElectroStaticCharge			= mod:NewTargetTimer(60, 143385, nil, mod:IsTank())
local timerElectroStaticChargeCD		= mod:NewCDTimer(17, 143385, nil, mod:IsTank())--17-22 second variation
local timerLaunchSawbladeCD				= mod:NewCDTimer(10, 143265)--10-15sec cd
--Automated Shredders
local timerAutomatedShredderCD			= mod:NewNextTimer(60, "ej8199", nil, nil, nil, 85914)--Don't know true cd yet, just timing or first
local timerDeathFromAboveDebuff			= mod:NewTargetTimer(5, 144210, nil, not mod:IsHealer())
local timerDeathFromAboveCD				= mod:NewNextTimer(40, 144208, nil, not mod:IsHealer())
--The Assembly Line
local timerAssemblyLineCD				= mod:NewNextTimer(40, "ej8199", nil, nil, nil, 59193)
local timerPatternRecognition			= mod:NewBuffActiveTimer(60, 144236)
local timerDisintegrationLaserCD		= mod:NewNextCountTimer(10, 143867)
local timerShockwaveMissileActive		= mod:NewBuffActiveTimer(30, 143639)
local timerShockwaveMissileCD			= mod:NewNextCountTimer(12, 143641)--1 missile every 12 seconds for 120 seconds, ie 10 missles)
local timerBreakinPeriod				= mod:NewTargetTimer(60, 145269)--How many mines up at once? will this be spammy?

local missileCount = 0
local laserCount = 0--Fires 3 times i think
local activeWeaponsGUIDS = {}

function mod:LaunchSawBladeTarget(targetname, uId)
	warnLaunchSawblade:Show(targetname)
end

--May be two up at once so can't use generic boss scanner.
function mod:DeathFromAboveTarget(sGUID)
	local targetname = nil
	for uId in DBM:GetGroupMembers() do
		if UnitGUID(uId.."target") == sGUID then
			targetname = DBM:GetUnitFullName(uId.."targettarget")
			break
		end
	end
	warnDeathFromAbove:Show(targetname)
	if targetname == UnitName("player") then
		specWarnDeathFromAbove:Show()
	end
end

--like many important debuffs last tier and now this tier, APPLIED & REMOVED SPELL_CAST events are disabled, so we have to waste cpu to find them.
local spellName = GetSpellInfo(143828)
local function findLaser()
	for uId in DBM:GetGroupMembers() do
		local name = DBM:GetUnitFullName(uId)
		if UnitDebuff(uId, spellName) then
			print("DBM DEBUG: Possible match to laser targeting using "..spellName)
			warnLaserFixate:Show(name)
			if name == UnitName("player") then
				specWarnLaserFixate:Show()
				yellLaserFixate:Yell()
			end
			return
		end
	end
	mod:Schedule(0.1, findLaser)
end

function mod:OnCombatStart(delay)
	table.wipe(activeWeaponsGUIDS)
	missileCount = 0
	laserCount = 0
	timerAutomatedShredderCD:Start(35-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 143265 then
		timerLaunchSawbladeCD:Start()
		self:BossTargetScanner(71504, "LaunchSawBladeTarget", 0.1, 16)
	elseif args.spellId == 144208 then
		timerDeathFromAboveCD:Start(args.sourceGUID)
		self:ScheduleMethod(0.2, "DeathFromAboveTarget", args.sourceGUID)--Always targets tank, so 1 scan all needed
		specWarnAutomatedShredderSwitch:Schedule(3)--Better here then when debuff goes up, give dps 2 seconds rampup time so spells in route when debuff goes up.
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 143639 then--Missile Activation
		warnShockwaveMissileActivated:Show()
		specWarnShockwaveMissileActive:Show()
		timerShockwaveMissileActive:Start()
		missileCount = 0
		timerShockwaveMissileCD:Start(3, 1)
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 143641 then--Missile Launching
		missileCount = missileCount + 1
		warnShockwaveMissile:Show(missileCount)
		if missileCount < 3 then
			timerShockwaveMissileCD:Start(nil, missileCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 145365 then
		warnProtectiveFrenzy:Show(args.destName)
		specWarnProtectiveFrenzy:Show(args.destName)
		timerProtectiveFrenzy:Start()
	elseif args.spellId == 143385 then
		local amount = args.amount or 1
		warnElectroStaticCharge:Show(args.destName, amount)
		timerElectroStaticCharge:Start(args.destName)
		timerElectroStaticChargeCD:Start()
	elseif args.spellId == 144210 and not args:IsDestTypePlayer() then
		timerDeathFromAboveDebuff:Start(args.destName)
	elseif args.spellId == 144236 and args:IsPlayer() then
		timerPatternRecognition:Start()
	elseif args.spellId == 145269 then
		warnBreakinPeriod:Show(args.destName)
		timerBreakinPeriod:Start(args.destName, args.destGUID)
	elseif args.spellId == 145580 then
		warnReadyToGo:Show(args.destName)
		specWarnReadyToGo:Show(args.destName)
	elseif args.spellId == 143867 then
		if not activeWeaponsGUIDS[args.sourceGUID] then
			activeWeaponsGUIDS[args.sourceGUID] = true
			laserCount = 0
			warnLaserTurretActivated:Show()
		end
		laserCount = laserCount + 1
		if laserCount < 3 then--Seems each laser construction casts 3 times, then disapears.
			timerDisintegrationLaserCD:Start(nil, laserCount+1)
		end
		self:Unschedule(findLaser)
		findLaser()
	elseif args.spellId == 144466 and self:AntiSpam(15, 1) then--Only way i see to detect magnet activation, antispam is so it doesn't break if a player dies during it.
		warnMagneticCrush:Show()
		specWarnMagneticCrush:Show()
	elseif args.spellId == 145774 then
		warnOvercharge:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 143385 then
		timerElectroStaticCharge:Cancel(args.destName)
	elseif args.spellId == 144236 and args:IsPlayer() then
		timerPatternRecognition:Cancel()
	elseif args.spellId == 145269 then
		timerBreakinPeriod:Cancel(args.destName, args.destGUID)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 143856 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnSuperheated:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71591 then
		timerDeathFromAboveCD:Cancel(args.destGUID)
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:143266") then--Target scanning works on this one, but is about 1 second slower than emote. emote is .2 seconds after SPELL_CAST_START, but target scanning can't grab right target until like 1.0 or 1.2 sec into cast
		specWarnLaunchSawblade:Show()
		yellLaunchSawblade:Yell()
	--"<55.7 18:31:39> [RAID_BOSS_WHISPER] RAID_BOSS_WHISPER#|TInterface\\Icons\\Ability_Siege_Engineer_Detonate.blp:20|tA Crawler Mine has targeted you!#Crawler Mine#0#true", -- [4345]
	elseif msg:find("Ability_Siege_Engineer_Detonate") then--Doesn't show in combat log at all (what else is new)
		specWarnCrawlerMineFixate:Show()
		yellCrawlerMineFixate:Yell()
	elseif msg:find("Ability_Siege_Engineer_Superheated") then
		specWarnLaserFixate:Show()
		yellLaserFixate:Yell()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg == L.newWeapons or msg:find(L.newWeapons) then
		specWarnAssemblyLine:Show()
		timerAssemblyLineCD:Start()
	elseif msg == L.newShredder or msg:find(L.newShredder) then
		specWarnAutomatedShredder:Show()
		timerDeathFromAboveCD:Start(17)
--		timerAutomatedShredderCD:Start()
	elseif msg:find("spell:145774") then
		print("DBM Debug: Drycoded Fallback, in case Overcharge is hidden from combat log", npc or "noNPC", target or "noTarget")
	end
end
