local mod	= DBM:NewMod(827, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(69465)
mod:SetModelID(47552)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE"
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
local specWarnWaterMove				= mod:NewSpecialWarning("specWarnWaterMove")
local specWarnStorm					= mod:NewSpecialWarningSpell(137313, nil, nil, nil, 2)
local specWarnElectrifiedWaters		= mod:NewSpecialWarningMove(138006)
local specWarnIonization			= mod:NewSpecialWarningSpell(138732, not mod:IsTank(), nil, nil, 2)

local timerFocusedLightningCD		= mod:NewCDTimer(10, 137399)--10-18 second variation, tends to lean toward 11-12 except when delayed by other casts such as throw or storm. Pull one also seems to variate highly
local timerStaticBurstCD			= mod:NewCDTimer(19, 137162, mod:IsTank())
local timerThrowCD					= mod:NewCDTimer(26, 137175)--90-93 variable (26-30 seconds after storm. verified in well over 50 logs)
local timerStorm					= mod:NewBuffActiveTimer(17, 137313)--2 second cast, 15 second duration
local timerStormCD					= mod:NewCDTimer(60.5, 137313)--90-93 variable (60.5~67 seconds after throw)
local timerIonization				= mod:NewBuffFadesTimer(24, 138732)
local timerIonizationCD				= mod:NewNextTimer(61.5, 138732)

local soundFocusedLightning			= mod:NewSound(137422)

local berserkTimer					= mod:NewBerserkTimer(540)

local countdownIonization			= mod:NewCountdown(61.5, 138732)

mod:AddBoolOption("RangeFrame")

local function checkWater(force)
	if UnitDebuff("player", GetSpellInfo(138470)) and not UnitIsDeadOrGhost("player") and (UnitDebuff("player", GetSpellInfo(138732)) or force) then
		specWarnWaterMove:Show()
	end
end

function mod:FocusedLightningTarget(targetname)
	warnFocusedLightning:Show(targetname)
	if targetname == UnitName("player") then
		specWarnFocusedLightning:Show()
		yellFocusedLightning:Yell()
		soundFocusedLightning:Play()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	end
end

function mod:OnCombatStart(delay)
	timerFocusedLightningCD:Start(8-delay)
	timerStaticBurstCD:Start(13-delay)
	timerThrowCD:Start(30-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerIonizationCD:Start(60-delay)
		countdownIonization:Start(-delay)
	end
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 137399 then
		self:BossTargetScanner(69465, "FocusedLightningTarget", 0.025, 12)
		timerFocusedLightningCD:Start()
	elseif args.spellId == 137313 then
		warnStorm:Show()
		specWarnStorm:Show()
		timerStorm:Start()
		timerStaticBurstCD:Start(22.5)--May need tweaking
		timerThrowCD:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerIonizationCD:Start()
			countdownIonization:Start()
		end
	elseif args.spellId == 138732 then
		warnIonization:Show()
		specWarnIonization:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 137162 then
		timerStaticBurstCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 137162 then
		warnStaticBurst:Show(args.destName)
		if args:IsPlayer() then
			specWarnStaticBurst:Show()
		else
			specWarnStaticBurstOther:Show(args.destName)
		end
	elseif args.spellId == 138732 and args:IsPlayer() then
		timerIonization:Start()
		self:Schedule(19, checkWater)--Extremely dangerous. (if conducted, then auto wipe). So check before 5 sec.
		if self.Options.RangeFrame and not UnitDebuff("player", GetSpellInfo(137422)) then--if you have 137422 then you have range 8 open and we don't want to make it 4
			DBM.RangeCheck:Show(4)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 138732 and args:IsPlayer() then
		timerIonization:Cancel()
		self:Unschedule(checkWater)
		if self.Options.RangeFrame and not UnitDebuff("player", GetSpellInfo(137422)) then--if you have 137422 we don't want to hide it either.
			DBM.RangeCheck:Hide()
		end
	elseif args.spellId == 137422 and args:IsPlayer() then
		if self.Options.RangeFrame then
			if UnitDebuff("player", GetSpellInfo(138732)) then--if you have 138732 then switch to 4 yards
				DBM.RangeCheck:Show(4)
			else
				DBM.RangeCheck:Hide()
			end
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
		local target = DBM:GetFullNameByShortName(target)
		warnThrow:Show(target)
		timerStormCD:Start()
		self:Schedule(57.5, checkWater, true)--check before 3 sec.
		if target == UnitName("player") then
			specWarnThrow:Show()
		else
			specWarnThrowOther:Show(target)
		end
	end
end
