local mod	= DBM:NewMod(192, "DBM-Firelands", nil, 78)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52498)
mod:SetModelID(38227)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"RAID_BOSS_EMOTE"
--	"UNIT_DIED"
)

local warnSmolderingDevastation		= mod:NewCountAnnounce(99052, 4)--Use count announce, cast time is pretty obvious from the bar, but it's useful to keep track how many of these have been cast.
local warnWidowKiss					= mod:NewTargetAnnounce(99476, 3, nil, mod:IsTank() or mod:IsHealer())
local warnPhase2Soon				= mod:NewPrePhaseAnnounce(2, 3)
local warnFixate					= mod:NewTargetAnnounce(99559, 4)--Heroic ability

local specWarnFixate				= mod:NewSpecialWarningYou(99559)
local specWarnTouchWidowKiss		= mod:NewSpecialWarningYou(99476)
local specWarnSmolderingDevastation	= mod:NewSpecialWarningSpell(99052)
local specWarnVolatilePoison		= mod:NewSpecialWarningMove(101133)--Heroic ability
local specWarnTouchWidowKissOther	= mod:NewSpecialWarningTarget(99476, mod:IsTank())

local timerSpinners 				= mod:NewTimer(15, "TimerSpinners", 97370) -- 15secs after Smoldering cast start
local timerSpiderlings				= mod:NewTimer(30, "TimerSpiderlings", 72106)
local timerDrone					= mod:NewTimer(60, "TimerDrone", 28866)
local timerSmolderingDevastationCD	= mod:NewNextCountTimer(90, 99052)
local timerEmberFlareCD				= mod:NewNextTimer(6, 98934)
local timerSmolderingDevastation	= mod:NewCastTimer(8, 99052)
--local timerFixateCD					= mod:NewCDTimer(35, 99559)--Prooved erratic and new logs didn't show same results as first ones so commenting out for now.
local timerFixate					= mod:NewTargetTimer(10, 99559)
local timerWidowKiss				= mod:NewTargetTimer(20, 99476, nil, mod:IsTank() or mod:IsHealer())

local smolderingCount = 0
local lastPoison = 0

mod:AddBoolOption("RangeFrame")

function mod:repeatSpiderlings()
	timerSpiderlings:Start()
	self:ScheduleMethod(30, "repeatSpiderlings")
end

function mod:repeatDrone()
	timerDrone:Start()
	self:ScheduleMethod(60, "repeatDrone")
end

function mod:OnCombatStart(delay)
	timerSmolderingDevastationCD:Start(-delay, 1)
	timerSpinners:Start(12-delay)
	timerSpiderlings:Start(12.5-delay)
	self:ScheduleMethod(11-delay , "repeatSpiderlings")
	timerDrone:Start(45-delay)
	self:ScheduleMethod(45-delay, "repeatDrone")
	smolderingCount = 0
	lastPoison = 0
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(99476, 99506) then
		warnWidowKiss:Show(args.destName)
		timerWidowKiss:Start(args.destName)
		if args:IsPlayer() then
			specWarnTouchWidowKiss:Show()
			if self.Options.RangeFrame and not DBM.RangeCheck:IsShown() then
				DBM.RangeCheck:Show(10)
			end
		else
			specWarnTouchWidowKissOther:Show(args.destName)
			if self.Options.RangeFrame and not DBM.RangeCheck:IsShown() and self:IsTank() then
				DBM.RangeCheck:Show(10)
			end
		end
	elseif args:IsSpellID(99526, 99559) and args:IsDestTypePlayer() then--99526 is on player, 99559 is on drone, leaving both for now with a filter, may remove 99559 and filter later.
		warnFixate:Show(args.destName)
		timerFixate:Start(args.destName)
--		timerFixateCD:Start()
		if args:IsPlayer() then
			specWarnFixate:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(99476, 99506) then
		timerWidowKiss:Cancel(args.destName)
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(99052) then
		smolderingCount = smolderingCount + 1
		warnSmolderingDevastation:Show(smolderingCount)
		if self:GetUnitCreatureId("target") == 52498 or self:GetBossTarget(52498) == UnitName("target") then--If spider is you're target or it's tank is, you're up top.
			specWarnSmolderingDevastation:Show()
		end
		timerSmolderingDevastation:Start()
		timerEmberFlareCD:Cancel()--Cast immediately after Devastation, so don't need to really need to update timer, just cancel last one since it won't be cast during dev
		if smolderingCount == 3 then	-- 3rd cast = start P2
			warnPhase2Soon:Show()
			self:UnscheduleMethod("repeatSpiderlings")
			self:UnscheduleMethod("repeatDrone")
			timerSpiderlings:Cancel()
			timerDrone:Cancel()
		else
			timerSmolderingDevastationCD:Start(90, smolderingCount+1)
			timerSpinners:Start()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(98934) then--Only show timer if you are up top until 3rd dev then show for everyone.
		if smolderingCount < 3 and (self:GetUnitCreatureId("target") == 52498 or self:GetBossTarget(52498) == UnitName("target")) or smolderingCount == 3 then
			timerEmberFlareCD:Start()
		end
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(99278, 101133) and args:IsPlayer() and GetTime() - lastPoison > 3 then
		if args:IsPlayer() and GetTime() - lastPoison > 3  then
			specWarnVolatilePoison:Show()
			lastPoison = GetTime()
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.EmoteSpiderlings then
		self:UnscheduleMethod("repeatSpiderlings")	-- in case it is off
		self:repeatSpiderlings()
	end
end

--[[
function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 52581 then--Drone
		timerFixateCD:Cancel()
	end
end--]]