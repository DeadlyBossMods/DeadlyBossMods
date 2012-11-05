local mod	= DBM:NewMod(744, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62543)
mod:SetModelID(43141)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnTempestSlash					= mod:NewSpellAnnounce(125692, 2)
local warnOverwhelmingAssault			= mod:NewStackAnnounce(123474, 3, nil, mod:IsTank() or mod:IsHealer())
local warnWindStep						= mod:NewTargetAnnounce(123175, 3)
local warnUnseenStrike					= mod:NewTargetAnnounce(123017, 4)
local warnIntensify						= mod:NewStackAnnounce(123471, 2)
local warnBladeTempest					= mod:NewCastAnnounce(125310, 4)--Phase 1 heroic
local warnStormUnleashed				= mod:NewSpellAnnounce(123815, 3)--Phase 2

local specWarnUnseenStrike				= mod:NewSpecialWarningTarget(122949)--Everyone needs to know this, and run to this person.
local yellUnseenStrike					= mod:NewYell(122949)
local specWarnOverwhelmingAssault		= mod:NewSpecialWarningStack(123474, mod:IsTank(), 2)
local specWarnOverwhelmingAssaultOther	= mod:NewSpecialWarningTarget(123474, mod:IsTank())
local specWarnBladeTempest				= mod:NewSpecialWarningRun(125310, true)
local specWarnStormUnleashed			= mod:NewSpecialWarningSpell(123814, nil, nil, nil, true)

local timerTempestSlashCD				= mod:NewNextTimer(15.5, 125692)
local timerOverwhelmingAssault			= mod:NewTargetTimer(45, 123474, nil, mod:IsTank())
local timerOverwhelmingAssaultCD		= mod:NewCDTimer(20.5, 123474, nil, mod:IsTank() or mod:IsHealer())--Only ability with a variation in 2 pulls so far. He will use every 20.5 seconds unless he's casting something else, then it can be delayed as much as an extra 15-20 seconds. TODO: See if there is a way to detect when variation is going to occur and call update timer.
local timerWindStepCD					= mod:NewCDTimer(25, 123175)
local timerUnseenStrike					= mod:NewCastTimer(5, 123017)
local timerUnseenStrikeCD				= mod:NewCDTimer(55, 123017) -- this spell seems to have 2 cooldowns. some fight 55, some  61. 
local timerIntensifyCD					= mod:NewNextTimer(60, 123471)
local timerBladeTempest					= mod:NewBuffActiveTimer(9, 125310)
local timerBladeTempestCD				= mod:NewNextTimer(60, 125310)--Always cast after immediately intensify since they essencially have same CD

local berserkTimer						= mod:NewBerserkTimer(480)

local soundBladeTempest					= mod:NewSound(125310)

mod:AddBoolOption("RangeFrame", mod:IsRanged())--For Wind Step
mod:AddBoolOption("UnseenStrikeArrow")

local emoteFired = false
local intensifyCD = 60

local function checkUnseenEmote()
	if not emoteFired then
		warnUnseenStrike = mod:NewSpellAnnounce(123017, 4)
		specWarnUnseenStrike = mod:NewSpecialWarningSpell(122949)
		warnUnseenStrike:Show()
		specWarnUnseenStrike:Show()
		timerUnseenStrike:Start(4.2)
		timerUnseenStrikeCD:Start(54.2)
		-- recover Unseen Strike Target Warning
		warnUnseenStrike = mod:NewTargetAnnounce(123017, 4)
		specWarnUnseenStrike = mod:NewSpecialWarningTarget(122949)
	end
end

function mod:OnCombatStart(delay)
	emoteFired = false
	intensifyCD = 60
	timerTempestSlashCD:Start(10-delay)
	timerOverwhelmingAssaultCD:Start(15.5-delay)--Possibly wrong, the cd was shortened since beta, need better log with engage timestamp
	timerWindStepCD:Start(20.5-delay)
	timerUnseenStrikeCD:Start(30.5-delay)
	timerIntensifyCD:Start(intensifyCD-delay)
	berserkTimer:Start(-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerBladeTempestCD:Start(-delay)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
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
	if args:IsSpellID(123474) then
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
	elseif args:IsSpellID(123471) then
		warnIntensify:Show(args.destName, args.amount or 1)
		timerIntensifyCD:Start(intensifyCD)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(123474) then
		timerOverwhelmingAssault:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(125310) then
		warnBladeTempest:Show()
		specWarnBladeTempest:Show()
		soundBladeTempest:Play()
		timerBladeTempest:Start()
		timerBladeTempestCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(123474) then
		timerOverwhelmingAssaultCD:Start()--Start CD here, since this might miss.
	elseif args:IsSpellID(123175) then
		warnWindStep:Show(args.destName)
		timerWindStepCD:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:122949") then--Does not show in combat log except for after it hits. IT does fire a UNIT_SPELLCAST event but has no target info. The only way to get target is emote.
		emoteFired = true
		warnUnseenStrike:Show(target)
		specWarnUnseenStrike:Show(target)
		timerUnseenStrike:Start()
		timerUnseenStrikeCD:Start()
		if target == UnitName("player") then
			yellUnseenStrike:Yell()
		end
		if self.Options.UnseenStrikeArrow then
			DBM.Arrow:ShowRunTo(target, 5)
		end
		self:Schedule(5, function()
			emoteFired = false
		end)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 122839 and self:AntiSpam(2, 1) then--Tempest Slash. DO NOT ADD OTHER SPELLID. 122839 is primary cast, 122842 is secondary cast 3 seconds later. We only need to warn for primary and start CD off it and it alone.
		warnTempestSlash:Show()
		timerTempestSlashCD:Start()
	elseif spellId == 122949 and self:AntiSpam(2, 3) then-- sometimes Unseen Strike emote not fires. bliz bug.
		self:Schedule(0.8, checkUnseenEmote)
	elseif spellId == 123814 and self:AntiSpam(2, 2) then--Do not add other spellids here either. 123814 is only cast once, it starts the channel. everything else is cast every 1-2 seconds as periodic triggers.
		intensifyCD = 10
		timerTempestSlashCD:Cancel()
		timerOverwhelmingAssaultCD:Cancel()
		timerWindStepCD:Cancel()
		timerUnseenStrikeCD:Cancel()
		timerIntensifyCD:Cancel()
		timerBladeTempestCD:Cancel()
		warnStormUnleashed:Show()
		specWarnStormUnleashed:Show()
	end
end
