local mod	= DBM:NewMod(744, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62543)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnTempestSlash					= mod:NewSpellAnnounce(125692, 2)
local warnOverwhelmingAssault			= mod:NewStackAnnounce(123474, 3, nil, mod:IsTank() or mod:IsHealer())
local warnWindStep						= mod:NewTargetAnnounce(123175, 3)
local warnUnseenStrike					= mod:NewTargetAnnounce(122949, 4, 123017)
local warnIntensify						= mod:NewStackAnnounce(123471, 2)
local warnBladeTempest					= mod:NewCastAnnounce(125310, 4)--Phase 1 heroic
local warnStormUnleashed				= mod:NewSpellAnnounce(123815, 3)--Phase 2

local specWarnUnseenStrike				= mod:NewSpecialWarningYou(122949)
local specWarnUnseenStrikeOther			= mod:NewSpecialWarningTarget(122949)--Everyone needs to know this, and run to this person.
local yellUnseenStrike					= mod:NewYell(122949)
local specWarnOverwhelmingAssault		= mod:NewSpecialWarningStack(123474, mod:IsTank(), 2)
local specWarnOverwhelmingAssaultOther	= mod:NewSpecialWarningTarget(123474, mod:IsTank())
local specWarnBladeTempest				= mod:NewSpecialWarningRun(125310, true)
local specWarnStormUnleashed			= mod:NewSpecialWarningSpell(123814, nil, nil, nil, true)

local timerTempestSlashCD				= mod:NewNextTimer(15.5, 125692)
local timerOverwhelmingAssault			= mod:NewTargetTimer(45, 123474, nil, mod:IsTank())
local timerOverwhelmingAssaultCD		= mod:NewCDTimer(20.5, 123474, nil, mod:IsTank() or mod:IsHealer())--Only ability with a variation in 2 pulls so far. He will use every 20.5 seconds unless he's casting something else, then it can be delayed as much as an extra 15-20 seconds. TODO: See if there is a way to detect when variation is going to occur and call update timer.
local timerWindStepCD					= mod:NewCDTimer(25, 123175)
local timerUnseenStrike					= mod:NewCastTimer(4.8, 123017)
local timerUnseenStrikeCD				= mod:NewCDTimer(53, 123017) -- 53~61 cd.
local timerIntensifyCD					= mod:NewNextTimer(60, 123471)
local timerBladeTempest					= mod:NewBuffActiveTimer(9, 125310)
local timerBladeTempestCD				= mod:NewNextTimer(60, 125310)--Always cast after immediately intensify since they essencially have same CD

local countdownTempest					= mod:NewCountdown(60, 125310)
local berserkTimer						= mod:NewBerserkTimer(490)

local soundBladeTempest					= mod:NewSound(125310)

mod:AddBoolOption("RangeFrame", mod:IsRanged())--For Wind Step
mod:AddBoolOption("UnseenStrikeArrow")

local intensifyCD = 60
local phase2 = false

function mod:OnCombatStart(delay)
	intensifyCD = 60
	phase2 = false
	timerTempestSlashCD:Start(10-delay)
	timerOverwhelmingAssaultCD:Start(15.5-delay)--Possibly wrong, the cd was shortened since beta, need better log with engage timestamp
	timerWindStepCD:Start(20.5-delay)
	timerUnseenStrikeCD:Start(30.5-delay)
	timerIntensifyCD:Start(intensifyCD-delay)
	if not self:IsDifficulty("lfr25") then
		berserkTimer:Start(-delay)
	end
	if self:IsDifficulty("heroic10", "heroic25") then
		timerBladeTempestCD:Start(-delay)
		countdownTempest:Start(-delay)
	end
	if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.UnseenStrikeArrow then
		DBM.Arrow:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 123474 then
		warnOverwhelmingAssault:Show(args.destName, args.amount or 1)
		timerOverwhelmingAssault:Start(args.destName)
		if args:IsPlayer() then
			if (args.amount or 1) >= 2 then
				specWarnOverwhelmingAssault:Show(args.amount)
			end
		else
			if (args.amount or 1) >= 1 and not UnitDebuff("player", GetSpellInfo(123474)) and not UnitIsDeadOrGhost("player") then--Other tank has at least one stack and you have none
				specWarnOverwhelmingAssaultOther:Show(args.destName)--So nudge you to taunt it off other tank already.
			end
		end
	elseif args.spellId == 123471 then
		if phase2 and (args.amount or 1) % 3 == 0 or not phase2 then
			warnIntensify:Show(args.destName, args.amount or 1)
		end
		timerIntensifyCD:Start(intensifyCD)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 123474 then
		timerOverwhelmingAssault:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 125310 then
		warnBladeTempest:Show()
		specWarnBladeTempest:Show()
		soundBladeTempest:Play()
		timerBladeTempest:Start()
		timerBladeTempestCD:Start()
		countdownTempest:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 123474 then
		timerOverwhelmingAssaultCD:Start()--Start CD here, since this might miss.
	elseif args.spellId == 123175 then
		warnWindStep:Show(args.destName)
		if self:IsDifficulty("lfr25") then
			timerWindStepCD:Start(30)
		else
			timerWindStepCD:Start()
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:122949") then--Does not show in combat log except for after it hits. IT does fire a UNIT_SPELLCAST event but has no target info. You can get target 1 sec faster with UNIT_AURA but it's more cpu and not worth the trivial gain IMO
		local target = DBM:GetFullNameByShortName(target)
		warnUnseenStrike:Show(target)
		timerUnseenStrike:Start()
		timerUnseenStrikeCD:Start()
		if target == UnitName("player") then
			specWarnUnseenStrike:Show()
			yellUnseenStrike:Yell()
		else
			specWarnUnseenStrikeOther:Show(target)
			if self.Options.UnseenStrikeArrow then
				DBM.Arrow:ShowRunTo(target, 3, 3, 5)
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 122839 then--Tempest Slash. DO NOT ADD OTHER SPELLID. 122839 is primary cast, 122842 is secondary cast 3 seconds later. We only need to warn for primary and start CD off it and it alone.
		warnTempestSlash:Show()
		if self:IsDifficulty("lfr25") then
			timerTempestSlashCD:Start(20)
		else
			timerTempestSlashCD:Start()
		end
	elseif spellId == 123814 then--Do not add other spellids here either. 123814 is only cast once, it starts the channel. everything else is cast every 1-2 seconds as periodic triggers.
		phase2 = true
		intensifyCD = 10
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		timerTempestSlashCD:Cancel()
		timerOverwhelmingAssaultCD:Cancel()
		timerWindStepCD:Cancel()
		timerUnseenStrikeCD:Cancel()
		timerIntensifyCD:Cancel()
		timerBladeTempestCD:Cancel()
		countdownTempest:Cancel()
		warnStormUnleashed:Show()
		specWarnStormUnleashed:Show()
	end
end
