local mod	= DBM:NewMod(827, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(69465)
mod:SetModelID(47552)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER"
)

local warnFocusedLightning			= mod:NewTargetAnnounce(137399, 4)
local warnStaticBurst				= mod:NewTargetAnnounce(137162, 3, nil, mod:IsTank() or mod:IsHealer())
local warnThrow						= mod:NewTargetAnnounce(137175, 2)
local warnStorm						= mod:NewSpellAnnounce(137313, 3)
local warnIonization				= mod:NewSpellAnnounce(138732, 4)

local specWarnFocusedLightning		= mod:NewSpecialWarningRun(137422)
local yellFocusedLightning			= mod:NewYell(137422)
local specWarnStaticBurst			= mod:NewSpecialWarningYou(137162, mod:IsTank())
local specWarnStaticBurstOther		= mod:NewSpecialWarningTarget(137162, mod:IsTank())
local specWarnThrow					= mod:NewSpecialWarningYou(137175, mod:IsTank())
local specWarnThrowOther			= mod:NewSpecialWarningTarget(137175, mod:IsTank())
local specWarnStorm					= mod:NewSpecialWarningSpell(137313, nil, nil, nil, 2)
local specWarnElectrifiedWaters		= mod:NewSpecialWarningMove(138006)
local specWarnIonization			= mod:NewSpecialWarningSpell(138732, not mod:IsTank(), nil, nil, 2)

local timerFocusedLightningCD		= mod:NewCDTimer(10, 137399)--10-18 second variation, tends to lean toward 11-12 except when delayed by other casts such as throw or storm. Pull one also seems to variate highly
local timerStaticBurstCD			= mod:NewCDTimer(19, 137162, mod:IsTank())
local timerThrowCD					= mod:NewCDTimer(26, 137175)--90-93 variable (26~27 seconds after storm. needs more logs.)
local timerStorm					= mod:NewBuffActiveTimer(15, 137313)
local timerStormCD					= mod:NewCDTimer(63, 137313)--90-93 variable (63~67 seconds after throw)
local timerIonizationCD				= mod:NewNextTimer(60, 138732)

local soundFocusedLightning			= mod:NewSound(137422)

local berserkTimer					= mod:NewBerserkTimer(540)

local countdownIonization			= mod:NewCountdown(60, 138732)

mod:AddBoolOption("RangeFrame")

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
	timerStaticBurstCD:Start(13-delay)
	timerThrowCD:Start(30-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerIonizationCD:Start(60-delay)
		countdownIonization:Start(60-delay)
	end
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(137399) then
		scansDone = 0
		self:TargetScanner()
		timerFocusedLightningCD:Start()
	elseif args:IsSpellID(137313) then
		warnStorm:Show()
		specWarnStorm:Show()
		timerStorm:Start()
		timerStaticBurstCD:Start(22.5)--May need tweaking
		timerThrowCD:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerIonizationCD:Start(61.5)
			countdownIonization:Start(61.5)
		end
	elseif args:IsSpellID(138732) then
		warnIonization:Show()
		specWarnIonization:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(137162) then
		warnStaticBurst:Show(args.destName)
		timerStaticBurstCD:Start()
		if args:IsPlayer() then
			specWarnStaticBurst:Show()
		else
			specWarnStaticBurstOther:Show(args.destName)
		end
	elseif args:IsSpellID(138732) and args:IsPlayer() then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(4)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(138732) and args:IsPlayer() then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif args:IsSpellID(137422) and args:IsPlayer() then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
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
		soundFocusedLightning:Play()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	end
end
