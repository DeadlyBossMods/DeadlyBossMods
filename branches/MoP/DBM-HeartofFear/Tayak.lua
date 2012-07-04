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
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnTempestSlash					= mod:NewSpellAnnounce(122839, 2)
local warnOverwhelmingAssault			= mod:NewTargetAnnounce(123474, 3, nil, mod:IsTank() or mod:Ishealer())
local warnWindStep						= mod:NewTargetAnnounce(123175, 3)
local warnUnseenStrike					= mod:NewTargetAnnounce(122949, 4)
local warnIntensify						= mod:NewStackAnnounce(123471, 2)
local warnStormUnleashed				= mod:NewSpellAnnounce(123814, 3)--Phase 2

local specWarnUnseenStrike				= mod:NewSpecialWarningTarget(122949)--Everyone needs to know this, and run to this person.
local specWarnOverwhelmingAssault		= mod:NewSpecialWarningStack(123474, mod:IsTank(), 2)
local specWarnOverwhelmingAssaultOther	= mod:NewSpecialWarningTarget(123474, mod:IsTank())
local specWarnStormUnleashed			= mod:NewSpecialWarningSpell(123814, nil, nil, nil, true)

local timerTempestSlashCD				= mod:NewCDTimer(20.5, 122839)
local timerOverwhelmingAssault			= mod:NewTargetTimer(45, 123474, nil, mod:IsTank())
local timerOverwhelmingAssaultCD		= mod:NewCDTimer(20.5, 123474, nil, mod:IsTank() or mod:Ishealer())
local timerWindStepCD					= mod:NewCDTimer(30, 123175)
local timerUnseenStrikeCD				= mod:NewCDTimer(61, 122949)
local timerIntensifyCD					= mod:NewCDTimer(60, 123471)
--local timerStormUnleashedCD			= mod:NewCDTimer(60, 123814)--Timer for switching sides, assuming it's time based and not health based, unsure yet, need more data. Also,the side swap does NOT show in transcriptor or CLEU AT ALL. Will need to use /yell to figure it out.

mod:AddBoolOption("RangeFrame", mod:IsRanged())--For Wind Step
mod:AddBoolOption("UnseenStrikeArrow")

function mod:OnCombatStart(delay)
	timerTempestSlashCD:Start(10-delay)
	timerOverwhelmingAssaultCD:Start(15.5-delay)
	timerWindStepCD:Start(20.5-delay)
	timerUnseenStrikeCD:Start(34.5-delay)
	timerIntensifyCD:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
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
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(123474) then
		timerOverwhelmingAssault:Cancel(args.destName)
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
	if msg == L.UnseenStrike or msg:find(L.UnseenStrike) then--Does not show in combat log except for after it hits. IT does fire a UNIT_SPELLCAST event but has no target info. The only way to get target is emote.
		warnUnseenStrike:Show(target)
		specWarnUnseenStrike:Show(target)
		timerUnseenStrikeCD:Start()
		if self.Options.UnseenStrikeArrow then
			DBM.Arrow:ShowRunTo(target, 5)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 122839 and self:AntiSpam(2, 1) then--Tempest Slash. DO NOT ADD OTHER SPELLID. 122839 is primary cast, 122842 is secondary cast 3 seconds later. We only need to warn for primary and start CD off it and it alone.
		warnTempestSlash:Show()
		timerTempestSlashCD:Start()
	elseif spellId == 123474 and self:AntiSpam(2, 2) then--Do not add other spellids here either. 123474 is only cast once, it starts the channel. everything else is cast every 1-2 seconds as periodic triggers.
		timerTempestSlashCD:Cancel()
		timerOverwhelmingAssaultCD:Cancel()
		timerWindStepCD:Cancel()
		timerUnseenStrikeCD:Cancel()
		timerIntensifyCD:Cancel()
		warnStormUnleashed:Show()
		specWarnStormUnleashed:Show()
--		timerStormUnleashedCD:Show()
	end
end
