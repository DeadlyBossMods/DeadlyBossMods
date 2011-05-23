local mod	= DBM:NewMod("Bethtilac", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52498)
mod:SetModelID(38227)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnSmolderingDevastation		= mod:NewCastAnnounce(99052, 4)
local warnWidowKiss					= mod:NewStackAnnounce(99476, 3, nil, mod:IsTank() or mod:IsHealer())
local warnPhase2Soon				= mod:NewPrePhaseAnnounce(2, 3)

--local specWarnTouchWidowKiss		= mod:NewSpecialWarningStack(99476, nil, 5)--How many stacks? does it differ 10/25 or heroic?

local timerSpinners 				= mod:NewTimer(15, "TimerSpinners") -- 15secs after Smoldering cast start
local timerSpiderlings				= mod:NewTimer(30, "TimerSpiderlings")
local timerDrone					= mod:NewTimer(60, "TimerDrone")
local timerSmolderingDevastationCD	= mod:NewNextTimer(90, 99052)
local timerSmolderingDevastation	= mod:NewCastTimer(8, 99052)
local timerWidowKiss				= mod:NewTargetTimer(20, 99476, nil, mod:IsTank() or mod:IsHealer())

local smolderingCount = 0

--mod:AddBoolOption("RangeFrame")--Maybe needed for widows kiss aoe effect?

function mod:repeatSpiderlings()
	timerSpiderlings:Start()
	self:ScheduleMethod(30, "repeatSpiderlings")
end

function mod:repeatDrone()
	timerDrone:Start()
	self:ScheduleMethod(60, "repeatDrone")
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(99476, 99506) then
		timerWidowKiss:Start(args.destName)
		if args.amount % 5 == 0 then		-- warn every 5th stack. not sure what's going to be relevent yet
			warnWidowKiss:Show(args.destName, args.amount)
		end
--[[	if args:IsPlayer() then
			if (args.amount or 1) >= 5 then
				specWarnTouchWidowKiss:Show(args.amount)
			end
			if self.Options.RangeFrame and not DBM.RangeCheck:IsShown() then
				DBM.RangeCheck:Show(10)
			end
		end--]]
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(99476, 99506) then
		timerWidowKiss:Cancel(args.destName)
--[[	if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end--]]
	end
end

function mod:OnCombatStart(delay)
	timerSmolderingDevastationCD:Start(-delay)
	timerSpinners:Start(12-delay)
	timerSpiderlings:Start(12.5-delay)
	self:ScheduleMethod(11-delay , "repeatSpiderlings")
	timerDrone:Start(45-delay)
	self:ScheduleMethod(45-delay, "repeatDrone")
	smolderingCount = 0
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(99052) then		-- only being cast in P1?
		warnSmolderingDevastation:Show()
		timerSmolderingDevastation:Start()
		timerSmolderingDevastationCD:Start()
		timerSpinners:Start()		-- Only spawn in P1?
		
		smolderingCount = smolderingCount + 1
		if smolderingCount == 3 then	-- 3rd cast = start P2
			warnPhase2Soon:Show()
			self:UnscheduleMethod("repeatSpiderlings")
			self:UnscheduleMethod("repeatDrone")
			timerSpiderlings:Cancel()
			timerDrone:Cancel()
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.EmoteSpiderlings then
		self:UnscheduleMethod("repeatSpiderlings")	-- in case it is off
		self:repeatSpiderlings()
	end
end
