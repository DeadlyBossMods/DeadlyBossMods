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
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED"
)

--Siegecrafter Blackfuse
local warnLaunchSawblade				= mod:NewTargetAnnounce(143265, 3)
local warnProtectiveFrenzy				= mod:NewTargetAnnounce(145365, 3, nil, mod:IsTank() or mod:IsHealer())
local warnElectroStaticCharge			= mod:NewStackAnnounce(143385, 2, nil, mod:IsTank())
--Automated Shredders
local warnDeathFromAbove				= mod:NewTargetAnnounce(144208, 4)--Player target, not vulnerable shredder target.
--The Assembly Line
local warnShockwaveMissileActivated		= mod:NewSpellAnnounce("ej8204", 3)--Unsure if this will even show in CLEU, may need UNIT event or emote
local warnShockwaveMissile				= mod:NewCountAnnounce(143639, 3)--Trigger ID for actual missiles is 143642
--local warnLaserTurretActivated			= mod:NewSpellAnnounce("ej8208", 3)--Many scripted triggers. gonna need an emote or UNIT_SPELL event for this i'm sure
local warnSuperheated					= mod:NewSpellAnnounce(144040, 3)--Unsure if right ID
local warnMagneticCrush					= mod:NewSpellAnnounce(144466, 3)--Unsure if correct ID, could be 143487 instead
local warnBreakinPeriod					= mod:NewTargetAnnounce(145269, 3)
local warnReadyToGo						= mod:NewTargetAnnounce(145580, 4)

--Siegecrafter Blackfuse
local specWarnLaunchSawblade			= mod:NewSpecialWarningYou(143265)
local yellLaunchSawblade				= mod:NewYell(143265)
local specWarnProtectiveFrenzy			= mod:NewSpecialWarningTarget(145365, mod:IsTank())
--Automated Shredders
--local specWarnAutomatedShredder		= mod:NewSpecialWarningSpell("ej8199", mod:IsTank())--No sense in dps switching when spawn, has damage reduction. This for tank pickup
local specWarnDeathFromAbove			= mod:NewSpecialWarningYou(144208)
local specWarnDeathFromAboveNear		= mod:NewSpecialWarningClose(144208)
local yellDeathFromAbove				= mod:NewYell(144208)
local specWarnAutomatedShredderSwitch	= mod:NewSpecialWarningSwitch("ej8199")--i.e. It's vunerable after Death From Above. This is when everyone else switch.
--The Assembly Line
local specWarnReadyToGo					= mod:NewSpecialWarningTarget(145580)

--Siegecrafter Blackfuse
local timerProtectiveFrenzy				= mod:NewBuffActiveTimer(10, 145365, mod:IsTank() or mod:IsHealer())
local timerElectroStaticCharge			= mod:NewTargetTimer(60, 143385, mod:IsTank())
--Automated Shredders
--local timerAutomatedShredderCD		= mod:NewNextTimer(60, "ej8199")
local timerDeathFromAboveDebuff			= mod:NewTargetTimer(5, 144210, not mod:IsHealer())
--The Assembly Line
local timerPatternRecognition			= mod:NewBuffActiveTimer(60, 144236)
local timerShockwaveMissileActive		= mod:NewBuffActiveTimer(120, 143639)--Assumed from tooltips
local timerShockwaveMissileCD			= mod:NewNextTimer(12, 143639)--1 missile every 12 seconds for 120 seconds, ie 10 missles)
local timerBreakinPeriod				= mod:NewTargetTimer(60, 145269)--How many mines up at once? will this be spammy?

local missileCount = 0

function mod:LaunchSawBladeTarget(targetname, uId)
	if not targetname then
		print("DBM DEBUG: LaunchSawBladeTarget Scan failed")
		return
	end
	warnLaunchSawblade:Show(targetname)
	if targetname == UnitName("player") then
		specWarnLaunchSawblade:Show()
		yellLaunchSawblade:Yell()
	end
end

--[[
function mod:DeathFromAboveTarget(targetname, uId)
	if not targetname then
		print("DBM DEBUG: DeathFromAboveTarget Scan failed")
		return
	end
	warnDeathFromAbove:Show(targetname)
	if targetname == UnitName("player") then
		specWarnDeathFromAbove:Show()
		yellDeathFromAbove:Yell()
	end
end--]]

--May be two up at once so can't use generic boss scanner.
function mod:DeathFromAboveTarget(sGUID)
	local targetname = nil
	for uId in DBM:GetGroupMembers() do
		if UnitGUID(uId.."target") == sGUID then
			targetname = DBM:GetUnitFullName(uId.."targettarget")
			break
		end
	end
	if not targetname then
		print("DBM DEBUG: DeathFromAboveTarget Scan failed")
		return
	end
	warnDeathFromAbove:Show(targetname)
	if targetname == UnitName("player") then
		specWarnDeathFromAbove:Show()
		yellDeathFromAbove:Yell()
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			if inRange then
				specWarnDeathFromAboveNear:Show(targetname)
			end
		end
	end
end

function mod:OnCombatStart(delay)
	missileCount = 0
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	if args.spellId == 143265 then
		self:BossTargetScanner(71504, "LaunchSawBladeTarget", 0.025, 16)
	elseif args.spellId == 144208 then
--		self:BossTargetScanner(71591, "DeathFromAboveTarget", 0.025, 16)
		self:ScheduleMethod(0.2, "DeathFromAboveTarget", args.sourceGUID)
		specWarnAutomatedShredderSwitch:Schedule(3)--Better here then when debuff goes up, give dps 2 seconds rampup time so spells in route when debuff goes up.
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 143639 then--Missile Activation
		warnShockwaveMissileActivated:Show()
		timerShockwaveMissileActive:Start()
		missileCount = 0
	elseif args.spellId == 143642 then--Missile Launching
		missileCount = missileCount + 1
		warnShockwaveMissile:Show(missileCount)
		if missileCount <= 9 then--TODO< verify this
			timerShockwaveMissileCD:Start()
		end
	elseif args.spellId == 144040 then
		warnSuperheated:Show()
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

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 138006 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnElectrifiedWaters:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:137175") then
		local target = DBM:GetFullNameByShortName(target)
		warnThrow:Show(target)
		timerStormCD:Start()
		self:Schedule(55.5, checkWaterStorm)--check before 5 sec.
		if target == UnitName("player") then
			specWarnThrow:Show()
		else
			specWarnThrowOther:Show(target)
		end
	end
end
--]]
