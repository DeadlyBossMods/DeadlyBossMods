if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
local mod	= DBM:NewMod(816, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(69078, 69132, 69134, 69131)--69078 Sul the Sandcrawler, 69132 High Prestess Mar'li, 69131 Frost King Malakk, 69134 Kazra'jin --Adds: 69548 Shadowed Loa Spirit,
mod:SetModelID(47229)--Kazra'jin, 47505 Sul the Sandcrawler, 47506 Frost King Malakk, 47730 High Priestes Mar'li

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--All
local warnPossessed					= mod:NewStackAnnounce(136442, 2, nil, nil, "warnPossessed")
--local warnSoulFragment				= mod:NewTargetAnnounce(137359, 3)--Could find no spellid in either wowhead or wowdb, so i'll need logs

--Sul the Sandcrawler
local warnSandBolt					= mod:NewStackAnnounce(136189, 3, nil, false, "warnSandBolt")--Spammy but important for heroic (and even normal if very melee heavy)
local warnQuicksand					= mod:NewSpellAnnounce(136521, 2)
local warnSandstorm					= mod:NewSpellAnnounce(136894, 3)
--High Prestess Mar'li
local warnBlessedLoaSpirit			= mod:NewSpellAnnounce(137203, 4)
local warnShadowedLoaSpirit			= mod:NewSpellAnnounce(137350, 4)
local warnMarkedSoul				= mod:NewTargetAnnounce(137359, 4)--Shadowed Loa Spirit fixate target, no need to warn for Shadowed Loa Spirit AND this, so we just warn for this
local warnTwistedSoul				= mod:NewTargetAnnounce(137891, 4)--Heroic Only
--Frost King Malak
local warnBitingCold				= mod:NewTargetAnnounce(136992, 3)--136917 is cast ID version, 136992 is player debuff
local warnFrostBite					= mod:NewTargetAnnounce(136922, 4)--136990 is cast ID version, 136922 is player debuff
local warnFrigidAssault				= mod:NewStackAnnounce(136903, 3, nil, mod:IsTank() or mod:IsHealer())
--Kazra'jin
local warnRecklessCharge			= mod:NewCastAnnounce(137122, 3, 2)

--All
local specWarnPossessed				= mod:NewSpecialWarningSwitch(136442, mod:IsDps())
--Sul the Sandcrawler
local specWarnSandBolt				= mod:NewSpecialWarningInterrupt(136189, false)--When it's targeting a melee, damage is pretty big. More important to interrupt than ones targeting ranged that SHOULD be spread out. Maybe add a bool menu option to choose ALL or melee only for heroic
local specWarnSandStorm				= mod:NewSpecialWarningSpell(136894, nil, nil, nil, 2)
local specWarnQuickSand				= mod:NewSpecialWarningMove(136860)
--High Prestess Mar'li
local specWarnBlessedLoaSpirit		= mod:NewSpecialWarningSwitch(137203, mod:IsRanged())--Ranged should handle this, melee chasing it around is huge dps loss for possessed. On 10 man 2 ranged was enough. If you do not have 2 ranged, 1 or 2 melee will have to help and probably turn this on manually
local specWarnShadowedLoaSpirit		= mod:NewSpecialWarningSwitch(137350, mod:IsRanged())
local specWarnMarkedSoul			= mod:NewSpecialWarningRun(137359)
local specWarnTwistedSoul			= mod:NewSpecialWarningYou(137891)
--Frost King Malak
local specWarnBitingCold			= mod:NewSpecialWarningYou(136992)
local yellBitingCold				= mod:NewYell(136992)--This one you just avoid so chat bubble is useful
local specWarnFrostBite				= mod:NewSpecialWarningYou(136922)--This one you do not avoid you clear it hugging people so no chat bubble
local specWarnFrigidAssault			= mod:NewSpecialWarningStack(136903, mod:IsTank(), 8)
local specWarnFrigidAssaultOther	= mod:NewSpecialWarningTarget(136903, mod:IsTank())
local specWarnChilled				= mod:NewSpecialWarningYou(137085, false)--Heroic
--Kazra'jin
local timerRecklessChargeCD			= mod:NewCDTimer(6, 137122)
--Sul the Sandcrawler
local timerQuickSandCD				= mod:NewCDTimer(35, 136521)
--local timerSandStormCD			= mod:NewCDTimer(35, 136894)--insufficent data to determine CD. it does not seem to be tied to quick sand though. on contrary he casts this first time the instant he's possessed.
--High Prestess Mar'li
local timerBlessedLoaSpiritCD		= mod:NewNextTimer(34, 137203)
local timerShadowedLoaSpiritCD		= mod:NewNextTimer(34, 137350)
local timerMarkedSoul				= mod:NewTargetTimer(20, 137359)
--local timerTwistedSoulCD			= mod:NewCDTimer(30, 137891)
--Frost King Malak
local timerBitingColdCD				= mod:NewCDTimer(45, 136917)--10 man Cds (and probably LFR), i have no doubt on 25 man this will either have a shorter cd or affect 3 targets with same CD. Watch for timer diffs though
local timerFrostBiteCD				= mod:NewCDTimer(45, 136990)--^same comment as above
local timerFrigidAssault			= mod:NewTargetTimer(15, 136903)
local timerFrigidAssaultCD			= mod:NewCDTimer(30, 136904)--30 seconds after last one ended (maybe even a next timer, i'll change it with more logs.)
--Kazra'jin

local soundMarkedSoul				= mod:NewSound(137359)

--local berserkTimer				= mod:NewBerserkTimer(490)

mod:AddBoolOption("RangeFrame")--For Sand Bolt and charge

local SulsName = EJ_GetSectionInfo(7049)
local boltCasts = 0
local scansDone = 0
local kazraPossessed = false
local possessesDone = 0
local twistedSoulTargets = {}

local function warnTwistedSoulTargets()
	warnTwistedSoul:Show(table.concat(twistedSoulTargets, "<, >"))
	table.wipe(twistedSoulTargets)
end

local function isTank(unit)
	if GetPartyAssignment("MAINTANK", unit, 1) then
		return true
	end
	if UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	local uId = DBM:GetBossUnitId()
	if uId and UnitExists(uId.."target") and UnitDetailedThreatSituation(unit, uId) then
		return true
	end
	return false
end

function mod:BoltTarget()
	scansDone = scansDone + 1
	local targetname, uId = self:GetBossTarget(69078)
	if targetname and uId then
		if isTank(uId) and scansDone < 15 then--Make sure no infinite loop.
			self:ScheduleMethod(0.1, "BoltTarget")--Check multiple times to find a target that isn't a player.
		else
			warnSandBolt:Show(targetname, boltCasts)
			local targetedClass = UnitClass(uId)
			--Todo, add hybrid melee class checks somehow? Inspect throttling won't allow that here though, too often. Maybe on pull inspect just those classes and cache their specs?
			if targetedClass == "WARRIOR" or targetedClass == "DEATHKNIGHT" or targetedClass == "MONK" or targetedClass == "ROGUE" then--This bolt is targeting a melee, it is a priority interrupt
				specWarnSandBolt:Show(SulsName)
			end
		end
	else--target was nil, lets schedule a rescan here too.
		if scansDone < 15 then--Make sure not to infinite loop here as well.
			self:ScheduleMethod(0.1, "BoltTarget")
		end
	end
end

function mod:OnCombatStart(delay)
	table.wipe(twistedSoulTargets)
	kazraPossessed = false
	possessesDone = 0
	boltCasts = 0
	timerQuickSandCD:Start(8-delay)
	timerRecklessChargeCD:Start(10-delay)--the trigger is 6 seconds from pull, charge will happen at 10. I like timer ending at cast finish for this one though vs tryng to have TWO timers for something that literally only has 6 second cd
	timerBitingColdCD:Start(15-delay)--15 seconds until debuff, 13 til cast.
	timerBlessedLoaSpiritCD:Start(25-delay)
	if self.Options.RangeFrame and self:IsRanged() then--Melee don't need it right now(maybe on heroic melee will use i anyways and split into 2 groups to reduce sand bolt damage, but is suspect most will use an interrupt strategy.
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(136189) then
		scansDone = 0
		if boltCasts == 3 then boltCasts = 0 end
		boltCasts = boltCasts + 1
		self:BoltTarget()
	elseif args:IsSpellID(136521) and args:GetSrcCreatureID() == 69078 then--Filter the ones cast by adds dying.
		warnQuicksand:Show()
		timerQuickSandCD:Start()
	elseif args:IsSpellID(136894) then
		warnSandstorm:Show()
		specWarnSandStorm:Show()
--		timerSandStormCD:Start()
	elseif args:IsSpellID(137203) then
		warnBlessedLoaSpirit:Show()
		specWarnBlessedLoaSpirit:Show()
		timerBlessedLoaSpiritCD:Start()
	elseif args:IsSpellID(137350) then
		warnShadowedLoaSpirit:Show()
		specWarnShadowedLoaSpirit:Show()
		timerShadowedLoaSpiritCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(136442) then--Possessed
		possessesDone = possessesDone + 1
		warnPossessed:Show(args.destName, possessesDone)
		specWarnPossessed:Show(args.destName)
		if args:GetDestCreatureID() == 69078 then--Sul the Sandcrawler
			--Do nothing. He just casts sand storm right away and continues his quicksand cd as usual
			self:UnregisterShortTermEvents()
		elseif args:GetDestCreatureID() == 69132 then--High Prestess Mar'li
			--Swap timers. While possessed 
			local elapsed, total = timerBlessedLoaSpiritCD:GetTime()
			timerBlessedLoaSpiritCD:Cancel()
			if elapsed and total then--If for some reason it was nil, like it JUST came off cd, do nothing, she should cast loa spirit right away.
				timerShadowedLoaSpiritCD:Update(elapsed, total)
			end
			self:UnregisterShortTermEvents()
		elseif args:GetDestCreatureID() == 69131 then--Frost King Malakk
			--Swap timers. While possessed 
			local elapsed, total = timerBitingColdCD:GetTime()
			timerBitingColdCD:Cancel()
			if elapsed and total then--If for some reason it was nil, like it JUST came off cd, do nothing, he should cast frost bite right away.
				timerFrostBiteCD:Update(elapsed, total)
			end
			self:RegisterShortTermEvents(
				"UNIT_AURA"
			)
		elseif args:GetDestCreatureID() == 69134 then--Kazra'jin
			kazraPossessed = true
			self:UnregisterShortTermEvents()
		end
	elseif args:IsSpellID(136903) then--Player Debuff version, not cast version
		timerFrigidAssault:Start(args.destName)
		if self:AntiSpam(3, 1) then--Might need to adjust slightly to 2 or 4.
			warnFrigidAssault:Show(args.destName, args.amount or 1)
			if args:IsPlayer() then
				if (args.amount or 1) >= 8 then
					specWarnFrigidAssault:Show(args.amount)
				end
			else
				if (args.amount or 1) >= 8 and not UnitDebuff("player", GetSpellInfo(136903)) and not UnitIsDeadOrGhost("player") then
					specWarnFrigidAssaultOther:Show(args.destName)
				end
			end
		end
	elseif args:IsSpellID(136992) then--Player Debuff version, not cast version
		warnBitingCold:Show(args.destName)
		timerBitingColdCD:Start()
		if args:IsPlayer() then
			specWarnBitingCold:Show()
			yellBitingCold:Yell()
			if self.Options.RangeFrame and self:IsMelee() then--Ranged are already spreading range 5 for sand bolt so no reason to change their frame.
				DBM.RangeCheck:Show(4)--To be honest i'm not even sure this CAN target melee, code is here just in case.
			end
		end
	elseif args:IsSpellID(136922) then--Player Debuff version, not cast version
		warnFrostBite:Show(args.destName)
		timerFrostBiteCD:Start()
		if args:IsPlayer() then
			specWarnFrostBite:Show()
		end
	elseif args:IsSpellID(136860, 136878) and args:IsPlayer() and self:AntiSpam(2, 3) then--Trigger off initial quicksand debuff and ensnared stacks. much less cpu them registering damage events and just as effective.
		specWarnQuickSand:Show()
	elseif args:IsSpellID(137359) then
		warnMarkedSoul:Show(args.destName)
		timerMarkedSoul:Start(args.destName)
		if args:IsPlayer() then
			specWarnMarkedSoul:Show()
			soundMarkedSoul:Play()
		end
	elseif args:IsSpellID(137891) then--DRYCODE, it may not be right spellid, there are MANY
		twistedSoulTargets[#twistedSoulTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnTwistedSoul:Show()
		end
		self:Unschedule(warnTwistedSoulTargets)
		self:Schedule(0.3, warnTwistedSoulTargets)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(136442) then--Possessed
		if args:GetDestCreatureID() == 69078 then--Sul the Sandcrawler
--			timerSandStormCD:Cancel()
		elseif args:GetDestCreatureID() == 69132 then--High Prestess Mar'li
			--Swap timer back
			local elapsed, total  = timerShadowedLoaSpiritCD:GetTime()
			timerShadowedLoaSpiritCD:Cancel()
			if elapsed and total then
				timerBlessedLoaSpiritCD:Update(elapsed, total)
			end
		elseif args:GetDestCreatureID() == 69131 then--Frost King Malakk
			--Swap timer back
			local elapsed, total  = timerFrostBiteCD:GetTime()
			timerFrostBiteCD:Cancel()
			if elapsed and total then
				timerBitingColdCD:Update(elapsed, total)
			end
		elseif args:GetDestCreatureID() == 69134 then--Kazra'jin
			kazraPossessed = false
			timerRecklessChargeCD:Cancel()--Because it's not going to be 25 sec anymore. It'll go back to 6 seconds. He'll probably do it right away since more than likely it'll be off CD
		end
	elseif args:IsSpellID(136903) then
		timerFrigidAssault:Cancel(args.destName)
	elseif args:IsSpellID(136904) then
		timerFrigidAssaultCD:Start()
	elseif args:IsSpellID(136992) and args:IsPlayer() then--Player Debuff version, not cast version
		if self.Options.RangeFrame and self:IsMelee() then--Ranged want to keep frame open
			DBM.RangeCheck:Hide()
		end
	elseif args:IsSpellID(137359) then
		timerMarkedSoul:Cancel(args.destName)
	end
end

function mod:UNIT_AURA(uId)
	if uId ~= "player" then return end
	if UnitDebuff("player", chilldedDebuff) and not chilledWarned then
		specWarnChilled:Show()
		chilledWarned = true
	elseif not UnitDebuff("player", meteorTarget) and chilledWarned then
		chilledWarned = false
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 137107 and self:AntiSpam(2, 2) then--Pre cast trigger. there are other later spellids but they aren't consistent, only this one is.
		warnRecklessCharge:Schedule(2)--warning 4 seconds early on something cast every 6 seconds seems silly. Lets warn 2 seconds early.
		if kazraPossessed then--While possessed he gains "Overload" which will make his charge cd way different.
			timerRecklessChargeCD:Schedule(4, 25)--Will have timer actualy sync up to the cast finish so it also kind serves as a cast bar.
		else
			timerRecklessChargeCD:Schedule(4)--Will have timer actualy sync up to the cast finish so it also kind serves as a cast bar.
		end
	end
end
