local mod	= DBM:NewMod("GunshipBattle", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
local AddsIcon
if UnitFactionGroup("player") == "Alliance" then
	mod:RegisterCombat("yell", L.PullAlliance)
	mod:RegisterKill("yell", L.KillAlliance)
	mod:SetCreatureID(37215)	-- Orgrim's Hammer
	AddsIcon = 23334
else
	mod:RegisterCombat("yell", L.PullHorde)
	mod:RegisterKill("yell", L.KillHorde)
	mod:SetCreatureID(37540)	-- The Skybreaker
	AddsIcon = 23336
end
mod:SetMinCombatTime(50)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL"
)

local warnBelowZero			= mod:NewSpellAnnounce(69705, 4)
local warnExperienced		= mod:NewTargetAnnounce(71188, 1, nil, false)		-- might be spammy
local warnVeteran			= mod:NewTargetAnnounce(71193, 2, nil, false)		-- might be spammy
local warnElite				= mod:NewTargetAnnounce(71195, 3, nil, false)		-- might be spammy
local warnBattleFury		= mod:NewAnnounce("WarnBattleFury", 2, 72306, mod:IsTank())
local warnBladestorm		= mod:NewSpellAnnounce(69652, 3, nil, mod:IsMelee())
local warnWoundingStrike	= mod:NewTargetAnnounce(69651, 2)
local warnAddsSoon			= mod:NewAnnounce("WarnAddsSoon", 2, AddsIcon)

local timerCombatStart		= mod:NewTimer(45, "TimerCombatStart", 2457)
local timerBelowZeroCD		= mod:NewNextTimer(37.5, 69705)
local timerBattleFuryActive	= mod:NewBuffActiveTimer(17, 72306, nil, mod:IsTank() or mod:IsHealer())
local timerAdds				= mod:NewTimer(60, "TimerAdds", AddsIcon)

mod:RemoveOption("HealthFrame")

local firstMage = false

function mod:Adds()
	timerAdds:Start()
	warnAddsSoon:Cancel()
	warnAddsSoon:Schedule(55)
	self:UnscheduleMethod("Adds")
	self:ScheduleMethod(60, "Adds")
end

function mod:OnCombatStart(delay)
	DBM.BossHealth:Clear()
	timerCombatStart:Show(-delay)
	timerAdds:Start(60-delay)--First adds might come early or late so timer should be taken as a proximity only.
	warnAddsSoon:Schedule(55)
	self:ScheduleMethod(60, "Adds")
	firstMage = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(71195) then
		warnElite:Show(args.destName)
	elseif args:IsSpellID(71193) then
		warnVeteran:Show(args.destName)
	elseif args:IsSpellID(71188) then
		warnExperienced:Show(args.destName)
	elseif args:IsSpellID(69652) then
		warnBladestorm:Show()			
	elseif args:IsSpellID(69651) then
		warnWoundingStrike:Show(args.destName)
	elseif args:IsSpellID(72306, 69638) and ((UnitFactionGroup("player") == "Alliance" and mod:GetCIDFromGUID(args.destGUID) == 36939) or (UnitFactionGroup("player") == "Horde" and mod:GetCIDFromGUID(args.destGUID) == 37200)) then
		timerBattleFuryActive:Start()		-- only a timer for 1st stack
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(72306, 69638) and ((UnitFactionGroup("player") == "Alliance" and mod:GetCIDFromGUID(args.destGUID) == 36939) or (UnitFactionGroup("player") == "Horde" and mod:GetCIDFromGUID(args.destGUID) == 37200)) then
		if args.amount % 10 == 0 or (args.amount >= 20 and args.amount % 5 == 0) then		-- warn every 10th stack and every 5th stack if more than 20
			warnBattleFury:Show(GetSpellInfo(72306), args.amount or 1)
		end
		timerBattleFuryActive:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(69705) then
		timerBelowZeroCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69705) then
		warnBelowZero:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if ((msg == L.AddsAlliance or msg:find(L.AddsAlliance)) or (msg == L.AddsHorde or msg:find(L.AddsHorde))) and self:IsInCombat() then
		self:Adds()
	elseif ((msg == L.MageAlliance or msg:find(L.MageAlliance)) or (msg == L.MageHorde or msg:find(L.MageHorde))) and self:IsInCombat() then
		if not firstMage then
			timerBelowZeroCD:Start(6)
			firstMage = true
		else
			timerBelowZeroCD:Update(29, 35)--Update the below zero timer to correct it with yells since it tends to be off depending on how bad your cannon operators are.
		end
	end
end
