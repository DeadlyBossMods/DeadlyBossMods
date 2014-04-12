local mod	= DBM:NewMod(713, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(63191)--Also has CID 62164. He has 2 CIDs for a single target, wtf? It seems 63191 is one players attack though so i'll try just it.
mod:SetEncounterID(1463)
mod:SetZone()
mod:SetUsedIcons(2)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 122754 122786 122835 123081",
	"SPELL_AURA_APPLIED_DOSE 122754 122835 123081",
	"SPELL_AURA_REMOVED 122786 122835 123081",
	"SPELL_AURA_REMOVED_DOSE 122786 122835 123081",
	"SPELL_CAST_START 122735",
	"SPELL_CAST_SUCCESS 123495",
	"SPELL_DAMAGE 123120",
	"SPELL_MISSED 123120",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--[[WoL Reg Expression (you can remove icy touch if you don't have a DK pull bosses, i use it for pull time)
spell = "Furious Swipe" and fulltype = SPELL_CAST_START or (spell = "Pheromones" or spell = "Fury") and (fulltype = SPELL_AURA_APPLIED or fulltype = SPELL_AURA_APPLIED_DOSE) or spell = "Broken Leg" and not (fulltype = SPELL_CAST_SUCCESS or fulltype = SPELL_DAMAGE) or spell = "Mend Leg" or (spell = "Icy Touch" or spell = "Crush") and fulltype = SPELL_CAST_SUCCESS
--]]
local warnFuriousSwipe			= mod:NewSpellAnnounce(122735, 3)
local warnPheromones			= mod:NewTargetAnnounce(122835, 4)
local warnFury					= mod:NewStackAnnounce(122754, 3)
local warnBrokenLeg				= mod:NewStackAnnounce(122786, 2)
local warnMendLeg				= mod:NewSpellAnnounce(123495, 1)
local warnCrush					= mod:NewAnnounce("warnCrush", 3, 122774)
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnPungency				= mod:NewStackAnnounce(123081, 4)

local specwarnUnder				= mod:NewSpecialWarning("specwarnUnder")
local specwarnPheromonesTarget	= mod:NewSpecialWarningTarget(122835, false)
local specwarnPheromonesYou		= mod:NewSpecialWarningYou(122835)
local yellPheromones			= mod:NewYell(122835)
local specwarnPheromonesNear	= mod:NewSpecialWarningClose(122835)
local specwarnCrush				= mod:NewSpecialWarningSpell(122774, true, nil, nil, true)--Maybe set to true later, not sure. Some strats on normal involve purposely having tanks rapidly pass debuff and create lots of stomps
local specwarnLeg				= mod:NewSpecialWarningSwitch("ej6270", mod:IsMelee())--If no legs are up (ie all dead), when one respawns, this special warning can be used to alert of a respawned leg and to switch back.
local specwarnPheromoneTrail	= mod:NewSpecialWarningMove(123120)--Because this starts doing damage BEFORE the visual is there.

local timerCrush				= mod:NewCastTimer(3.5, 122774)--Was 3 second, hotfix went live after my kill log, don't know what new hotfixed cast time is, 3.5, 4? Needs verification.
local timerCrushCD				= mod:NewNextCountTimer(37, 122774)
local timerFuriousSwipeCD		= mod:NewCDTimer(8, 122735)
local timerMendLegCD			= mod:NewCDTimer(30, 123495)
local timerFury					= mod:NewBuffActiveTimer(30, 122754)
local timerPungency				= mod:NewBuffFadesTimer(120, 123081)

local countdownCrush			= mod:NewCountdown(37, 122774, nil, L.countdownCrush)
local berserkTimer				= mod:NewBerserkTimer(420)

--mod:AddBoolOption("InfoFrame", true)--Not sure how to do yet, i need to see 25 man first to get a real feel for number of people with debuff at once.
mod:AddBoolOption("PheromonesIcon", true)

local crushWarnText = GetSpellInfo(122774)
local crushCountWarnText = GetSpellInfo(122774).." (%d)"
local brokenLegs = 0
local crushCount = 0

function mod:OnCombatStart(delay)
	brokenLegs = 0
	timerFuriousSwipeCD:Start(-delay)--8-11 sec on pull
	if self:IsHeroic() then
		crushCount = 0
		timerCrushCD:Start(25.5-delay, 1)
		countdownCrush:Start(25.5-delay)
		berserkTimer:Start(-delay)
	else
		berserkTimer:Start(720-delay)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 122754 and args:GetDestCreatureID() == 63191 then--It applies to both creatureids, so we antispam it
		warnFury:Show(args.destName, args.amount or 1)
		if self:IsDifficulty("lfr25") then
			timerFury:Start(15)
		else
			timerFury:Start()
		end
	elseif spellId == 122786 and args:GetDestCreatureID() == 63191 then--This one also hits both the leg and the boss, so filter second one here as well.
		-- this warn seems not works? needs review.
		warnBrokenLeg:Show(args.destName, args.amount or 1)
	elseif spellId == 122835 then
		warnPheromones:Show(args.destName)
		specwarnPheromonesTarget:Show(args.destName)
		if args:IsPlayer() then
			specwarnPheromonesYou:Show()
			yellPheromones:Yell()
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
			self:SetIcon(args.destName, 2)
		end
	elseif spellId == 123081 and not self:IsDifficulty("lfr25") then
		local amount = args.amount or 1
		if amount >= 9 and amount % 3 == 0 then
			warnPungency:Show(args.destName, amount)
		end
		if args:IsPlayer() then
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
			timerPungency:Start(expires-GetTime())
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 122786 and args:GetDestCreatureID() == 63191 then
		brokenLegs = (args.amount or 0)
		warnBrokenLeg:Show(args.destName, brokenLegs)
	elseif spellId == 122835 then
		if self.Options.PheromonesIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 123081 and args:IsPlayer() then
		timerPungency:Cancel()
	end
end
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 122735 then
		warnFuriousSwipe:Show()
		timerFuriousSwipeCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 123495 then
		warnMendLeg:Show()
		timerMendLegCD:Start()
		if brokenLegs == 4 then--all his legs were broken when heal was cast, which means dps was on body.
			specwarnLeg:Show()--Warn to switch to respawned leg.
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 123120 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specwarnPheromoneTrail:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:122774") then
		timerCrush:Start()
		if self:IsHeroic() and not msg:find(L.UnderHim) then
			crushCount = crushCount + 1
			warnCrush:Show(crushCountWarnText:format(crushCount))
			specwarnCrush:Show()
			timerCrushCD:Start(nil, crushCount+1)
			countdownCrush:Start()
		elseif self:AntiSpam(3, 2) then
			warnCrush:Show(crushWarnText)
			specwarnCrush:Show()
		end
		if msg:find(L.UnderHim) and target == UnitName("player") then
			specwarnUnder:Show()--it's a bit of a too little too late warning, but hopefully it'll help people in LFR understand it's not place to be and less likely to repeat it, eventually thining out LFR failure rate to this.
		end
	elseif msg:find(L.Phase2) then
		timerCrushCD:Cancel()
		countdownCrush:Cancel()
		warnPhase2:Show()
	end
end
