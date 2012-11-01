local mod	= DBM:NewMod(713, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(63191)--Also has CID 62164. He has 2 CIDs for a single target, wtf? It seems 63191 is one players attack though so i'll try just it.
mod:SetModelID(42368)
mod:SetZone()
mod:SetUsedIcons(1, 2)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED"
)

--[[WoL Reg Expression (you can remove icy touch if you don't have a DK pull bosses, i use it for pull time)
spell = "Furious Swipe" and fulltype = SPELL_CAST_START or (spell = "Pheromones" or spell = "Fury") and (fulltype = SPELL_AURA_APPLIED or fulltype = SPELL_AURA_APPLIED_DOSE) or spell = "Broken Leg" and not (fulltype = SPELL_CAST_SUCCESS or fulltype = SPELL_DAMAGE) or spell = "Mend Leg" or (spell = "Icy Touch" or spell = "Crush") and fulltype = SPELL_CAST_SUCCESS
--]]
local warnFuriousSwipe			= mod:NewSpellAnnounce(122735, 3)
local warnPheromones			= mod:NewTargetAnnounce(122835, 4)
local warnFury					= mod:NewStackAnnounce(122754, 3)
local warnBrokenLeg				= mod:NewStackAnnounce(122786, 2)
local warnMendLeg				= mod:NewSpellAnnounce(123495, 1)
local warnCrush					= mod:NewSpellAnnounce(122774, 3)--On normal, only cast if you do fight wrong (be it on accident or actually on purpose. however, on heroic, this might have a CD)

local specwarnPheromonesTarget	= mod:NewSpecialWarningTarget(122835, false)
local specwarnPheromonesYou		= mod:NewSpecialWarningYou(122835)
local specwarnPheromonesNear	= mod:NewSpecialWarningClose(122835)
local specwarnCrush				= mod:NewSpecialWarningSpell(122774, true, nil, nil, true)--Maybe set to true later, not sure. Some strats on normal involve purposely having tanks rapidly pass debuff and create lots of stomps
local specwarnLeg				= mod:NewSpecialWarningSwitch("ej6270")--If no legs are up (ie all dead), when one respawns, this special warning can be used to alert of a respawned leg and to switch back.
local specwarnPheromoneTrail	= mod:NewSpecialWarningMove(123120)--Because this starts doing damage BEFORE the visual is there.

local timerFuriousSwipeCD		= mod:NewCDTimer(8, 122735)
local timerMendLegCD			= mod:NewNextTimer(30, 123495)
local timerFury					= mod:NewBuffActiveTimer(30, 122754)
local timerPungency				= mod:NewBuffFadesTimer(120, 123081)

local berserkTimer				= mod:NewBerserkTimer(420)

--mod:AddBoolOption("InfoFrame", true)--Not sure how to do yet, i need to see 25 man first to get a real feel for number of people with debuff at once.
mod:AddBoolOption("PheromonesIcon", true)

local madeUpNumber = 0
local PeromonesIcon = 1
local brokenLegs = 0

function mod:OnCombatStart(delay)
	madeUpNumber = 0
	PeromonesIcon = 1
	brokenLegs = 0
	timerFuriousSwipeCD:Start(-delay)--8-11 sec on pull
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(122754) and args:GetDestCreatureID() == 63191 then--It applies to both creatureids, so we antispam it
		warnFury:Show(args.destName, args.amount or 1)
		timerFury:Start()
	elseif args:IsSpellID(122786) and args:GetDestCreatureID() == 63191 then--This one also hits both CIDs, so filter second one here as well.
		madeUpNumber = madeUpNumber + 1
		brokenLegs = (args.amount or 1)
		warnBrokenLeg:Show(args.destName, brokenLegs)
		timerMendLegCD:Start(30, madeUpNumber)--using madeUpNumber jus to serve purpose of making each bar unique entire fight, legs die and rez all fight, there will be many mend leg Cd bars, often at once.
	elseif args:IsSpellID(122835) then
		warnPheromones:Show(args.destName)
		specwarnPheromonesTarget:Show(args.destName)
		if args:IsPlayer() then
			specwarnPheromonesYou:Show()
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				local inRange = DBM.RangeCheck:GetDistance("player", x, y)
				if inRange and inRange < 9 then
					specwarnPheromonesNear:Show(args.destName)
				end
			end
		end
		if self.Options.PheromonesIcon then
			self:SetIcon(args.destName, PeromonesIcon)
			if PeromonesIcon == 1 then	-- 2 will have it at a time on 25 man so we alternate icons.
				PeromonesIcon = 2
			else
				PeromonesIcon = 1
			end
		end
	elseif args:IsSpellID(123081) and args:IsPlayer() then
		timerPungency:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(122786) then
		brokenLegs = (args.amount or 0)
		warnBrokenLeg:Show(brokenLegs)
	elseif args:IsSpellID(122835) then
		if self.Options.PheromonesIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(123081) and args:IsPlayer() then
		timerPungency:Cancel()
	end
end
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(122735) then
		warnFuriousSwipe:Show()
		timerFuriousSwipeCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(122774) then
		warnCrush:Show()
		specwarnCrush:Show()
	elseif args:IsSpellID(123495) then
		warnMendLeg:Show()
		if brokenLegs == 4 then--all his legs were broken when heal was cast, which means dps was on body.
			specwarnLeg:Show()--Warn to switch to respawned leg.
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 123120 and destGUID == UnitGUID("player") and self:AntiSpam(3) then
		specwarnPheromoneTrail:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
