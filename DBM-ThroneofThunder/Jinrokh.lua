if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
local mod	= DBM:NewMod(827, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(69465)
mod:SetModelID(47552)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER"
)

local warnFocusedLightning			= mod:NewTargetAnnounce(137399, 4)
local warnThrow						= mod:NewTargetAnnounce(137175, 2)
local warnStorm						= mod:NewSpellAnnounce(137313, 3)

local specWarnFocusedLightning		= mod:NewSpecialWarningYou(137399)
local yellFocusedLightning			= mod:NewYell(137399)
local specWarnThrow					= mod:NewSpecialWarningYou(137175, mod:IsTank())
local specWarnThrowOther			= mod:NewSpecialWarningTarget(137175, mod:IsTank())
local specWarnStorm					= mod:NewSpecialWarningSpell(137313, nil, nil, nil, true)
local specWarnElectrifiedWaters		= mod:NewSpecialWarningMove(138006)

local timerFocusedLightningCD		= mod:NewCDTimer(10, 137399)--10-18 second variation, tends to lean toward 11-12 except when delayed by other casts such as throw or storm. Pull one also seems to variate highly
local timerThrowCD					= mod:NewCDTimer(30, 137175)--90-93 variable (but always 30-33 seconds after storm)
local timerStormCD					= mod:NewNextTimer(60, 137313)--90-93 variable (but ALWAYS 60 seconds after throw, so we use throw as trigger point)

local scansDone = 0

local function isTank(unit)
	-- 1. check blizzard tanks first
	-- 2. check blizzard roles second
	-- 3. check boss1's highest threat target
	if GetPartyAssignment("MAINTANK", unit, 1) then
		return true
	end
	if UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	if UnitExists("boss1target") and UnitDetailedThreatSituation(unit, "boss1") then
		return true
	end
	return false
end

function mod:TargetScanner(Force)
	scansDone = scansDone + 1
	local targetname, uId = self:GetBossTarget(69465)
	if UnitExists(targetname) then
		if isTank(uId) and not Force then
			if scansDone < 12 then
				self:ScheduleMethod(0.025, "TargetScanner")
			else
				self:TargetScanner(true)
			end
		else
			warnFocusedLightning:Show(targetname)
		end
	else
		if scansDone < 12 then
			self:ScheduleMethod(0.025, "TargetScanner")
		end
	end
end

function mod:OnCombatStart(delay)
	timerFocusedLightningCD:Start(-delay)
	timerThrowCD:Start(30-delay)--30-33 variable
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(137399) then
		scansDone = 0
		self:TargetScanner()
		timerFocusedLightningCD:Start()
	elseif args:IsSpellID(137313) then
		warnStorm:Show()
		specWarnStorm:Show()
		timerThrowCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 138006 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnElectrifiedWaters:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:137175") then
		warnThrow:Show(target)
		timerStormCD:Start()
		if target == UnitName("player") then
			specWarnThrow:Show()
		else
			specWarnThrowOther:Show(target)
		end
	end
end

--"<294.8 20:14:02> [RAID_BOSS_WHISPER] RAID_BOSS_WHISPER#|TInterface\\Icons\\ability_vehicle_electrocharge:20|t%s's |cFFFF0000|Hspell:137422|h[Focused Lightning]|h|r fixates on you. Run!#Jin'rokh the Breaker#0#false", -- [12425]
function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:137422") then--In case target scanning fails, personal warnings still always go off. Target scanning is just so everyone else in raid knows who it's on (since only target sees this emote)
		specWarnFocusedLightning:Show()
		yellFocusedLightning:Yell()
	end
end
