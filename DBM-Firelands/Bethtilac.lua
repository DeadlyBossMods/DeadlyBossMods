local mod	= DBM:NewMod(192, "DBM-Firelands", nil, 78)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52498)
mod:SetModelID(38227)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"RAID_BOSS_EMOTE"
)

local warnSmolderingDevastation		= mod:NewCountAnnounce(99052, 4)--Use count announce, cast time is pretty obvious from the bar, but it's useful to keep track how many of these have been cast.
local warnWidowKiss					= mod:NewTargetAnnounce(99476, 3, nil, mod:IsTank() or mod:IsHealer())
local warnPhase2Soon				= mod:NewPrePhaseAnnounce(2, 3)
local warnFixate					= mod:NewTargetAnnounce(99526, 4)--Heroic ability

local specWarnFixate				= mod:NewSpecialWarningYou(99526)
local specWarnTouchWidowKiss		= mod:NewSpecialWarningYou(99476)
local specWarnSmolderingDevastation	= mod:NewSpecialWarningSpell(99052)
local specWarnVolatilePoison		= mod:NewSpecialWarningMove(99278)--Heroic ability
local specWarnTouchWidowKissOther	= mod:NewSpecialWarningTarget(99476, mod:IsTank())

local timerSpinners 				= mod:NewNextTimer(15, "ej2770", nil, nil, nil, 97370) -- 15secs after Smoldering cast start
local timerSpiderlings				= mod:NewNextTimer(30, "ej2778", nil, nil, nil, 72106)
local timerDrone					= mod:NewNextTimer(60, "ej2773", nil, nil, nil, 28866)
local timerSmolderingDevastationCD	= mod:NewNextCountTimer(90, 99052)
local timerEmberFlareCD				= mod:NewNextTimer(6, 98934)
local timerSmolderingDevastation	= mod:NewCastTimer(8, 99052)
local timerFixate					= mod:NewTargetTimer(10, 99526)
local timerWidowsKissCD				= mod:NewCDTimer(32, 99476, nil, mod:IsTank() or mod:IsHealer())
local timerWidowKiss				= mod:NewTargetTimer(23, 99476, nil, mod:IsTank() or mod:IsHealer())

local smolderingCount = 0

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
	timerSmolderingDevastationCD:Start(82-delay, 1)
	timerSpinners:Start(12-delay)
	timerSpiderlings:Start(12.5-delay)
	self:ScheduleMethod(11-delay , "repeatSpiderlings")
	timerDrone:Start(45-delay)
	self:ScheduleMethod(45-delay, "repeatDrone")
	smolderingCount = 0
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(99506) then--Applied debuff after cast. Used to announce special warnings and start target timer, only after application confirmed and not missed.
		timerWidowKiss:Start(args.destName)
	elseif args:IsSpellID(99526, 99559) and args:IsDestTypePlayer() then--99526 is on player, 99559 is on drone, leaving both for now with a filter, may remove 99559 and filter later.
		warnFixate:Show(args.destName)
		timerFixate:Start(args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(99506) then
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
		if self:GetUnitCreatureId("target") == 52498 or self:GetBossTarget(52498) == DBM:GetUnitFullName("target") then--If spider is you're target or it's tank is, you're up top.
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
			timerWidowsKissCD:Start(47)--47-50sec variation for first, probably based on her movement into position.
		else
			timerSmolderingDevastationCD:Start(90, smolderingCount+1)
			timerSpinners:Start()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(99476) then--Cast debuff only, don't add other spellid. (99476 spellid uses on SPELL_CAST_START, NOT SPELL_AURA_APPLIED), 
		warnWidowKiss:Show(args.destName)
		timerWidowsKissCD:Start()
		if self.Options.RangeFrame and not DBM.RangeCheck:IsShown() and self:IsTank() then
			DBM.RangeCheck:Show(10)
		end
		if args:IsPlayer() then
			specWarnTouchWidowKiss:Show()
		else
			specWarnTouchWidowKissOther:Show(args.destName)
		end
	--Phase 1 ember flares. Only show for people who are actually up top.
	elseif args:IsSpellID(98934, 100648, 100834, 100835) and (self:GetUnitCreatureId("target") == 52498 or self:GetBossTarget(52498) == DBM:GetUnitFullName("target")) then
		timerEmberFlareCD:Start()
	--Phase 2 ember flares. Show for everyone
	elseif args:IsSpellID(99859, 100649, 100935, 100936) then
		timerEmberFlareCD:Start()
	end
end

function mod:SPELL_DAMAGE(sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId)
	if (spellId == 99278 or spellId == 101133) and destGUID == UnitGUID("player") and self:AntiSpam(3) then
		specWarnVolatilePoison:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.EmoteSpiderlings then
		self:UnscheduleMethod("repeatSpiderlings")	-- in case it is off
		self:repeatSpiderlings()
	end
end
