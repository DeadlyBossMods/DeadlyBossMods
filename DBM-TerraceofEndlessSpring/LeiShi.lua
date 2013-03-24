local mod	= DBM:NewMod(729, "DBM-TerraceofEndlessSpring", nil, 320)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62983)--62995 Animated Protector
mod:SetModelID(42811)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Victory)--Kill detection is aweful. No death, no special cast. yell is like 40 seconds AFTER victory. terrible.
mod:SetUsedIcons(8, 7, 6, 5, 4, 3) -- on 25 heroic 6 guards spawn.

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_HEALTH",--UNIT_HEALTH_FREQUENT maybe not needed. It's too high cpu usage.
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnProtect						= mod:NewSpellAnnounce(123250, 2)
local warnHide							= mod:NewCountAnnounce(123244, 3)
local warnHideProgress					= mod:NewAnnounce("warnHideProgress", 1, 123244)--Probably not perm, but less spammy debug solution
local warnHideOver						= mod:NewAnnounce("warnHideOver", 2, 123244)--Because we can. with creativeness, the boss returning is detectable a full 1-2 seconds before even visible. A good signal to stop aoe and get ready to return norm DPS
local warnGetAway						= mod:NewCountAnnounce(123461, 3)
local warnSpray							= mod:NewStackAnnounce(123121, 3, nil, mod:IsTank() or mod:IsHealer())

local specWarnAnimatedProtector			= mod:NewSpecialWarningSwitch("ej6224", not mod:IsHealer())
local specWarnHide						= mod:NewSpecialWarningSpell(123244, nil, nil, nil, 2)
local specWarnGetAway					= mod:NewSpecialWarningSpell(123461, nil, nil, nil, 2)
local specWarnSpray						= mod:NewSpecialWarningStack(123121, mod:IsTank(), 6)
local specWarnSprayOther				= mod:NewSpecialWarningTarget(123121, mod:IsTank())

local timerSpecialCD					= mod:NewTimer(50, "timerSpecialCD", 123250)--Variable, 49.5-55 seconds
local timerSpray						= mod:NewTargetTimer(10, 123121, nil, mod:IsTank() or mod:IsHealer())
local timerGetAway						= mod:NewBuffActiveTimer(30, 123461)
local timerScaryFogCD					= mod:NewNextTimer(10, 123705)

local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddBoolOption("HealthFrame", true)
mod:AddBoolOption("GWHealthFrame", true)
mod:AddBoolOption("RangeFrame", true)
if GetLocale() == "koKR" then
	mod:AddBoolOption("SetIconOnProtector", false)
else
	mod:AddBoolOption("SetIconOnProtector", true)
end

local getAwayHP = 0 -- because max health is different between Asian and US 25-man encounter. Calculate manually.
local specialsCast = 0
local hideActive = false
local lastProtect = 0
local specialRemaining = 0
local AddIcon = 8
local iconsSet = 0
local guards = {}
local guardActivated = 0
local lostHealth = 0
local prevlostHealth = 0
local hideDebug = 0
local damageDebug = 0
local timeDebug = 0
local hideTime = 0
local highestVersion = 0
local hasHighestVersion = false

local bossTank
do
	bossTank = function(uId)
		return mod:IsTanking(uId, "boss1")
	end
end

local showDamagedHealthBar, hideDamagedHealthBar
do
	local frame = CreateFrame("Frame") -- using a separate frame avoids the overhead of the DBM event handlers which are not meant to be used with frequently occuring events like all damage events...
	local damagedMob
	local hpRemaining = 0
	local maxhp = 0
	local function getDamagedHP()
		return math.max(1, math.floor(hpRemaining / maxhp * 100))
	end
	frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	frame:SetScript("OnEvent", function(self, event, timestamp, subEvent, _, _, _, _, _, destGUID, _, _, _, ...)
		if damagedMob == destGUID then
			local damage
			if subEvent == "SWING_DAMAGE" then 
				damage = select( 1, ... ) 
			elseif subEvent == "RANGE_DAMAGE" or subEvent == "SPELL_DAMAGE" or subEvent == "SPELL_PERIODIC_DAMAGE" then 
				damage = select( 4, ... )
			end
			if damage then
				hpRemaining = hpRemaining - damage
			end
		end
	end)
	
	function showDamagedHealthBar(self, mob, spellName, health)
		damagedMob = mob
		hpRemaining = health
		maxhp = health
		DBM.BossHealth:RemoveBoss(getDamagedHP)
		DBM.BossHealth:AddBoss(getDamagedHP, spellName)
	end
	
	function hideDamagedHealthBar()
		DBM.BossHealth:RemoveBoss(getDamagedHP)
	end
end

function mod:ScaryFogRepeat()
	timerScaryFogCD:Cancel()
	self:UnscheduleMethod("ScaryFogRepeat")
	local interval = 10 * (1/(1+lostHealth))--Seems that Scray Fog interval reduced by her casting speed. / EJ lies? seems on heroic, her casting speed increases by 1% per 1% health lost. (lfr: 0.8, normal: 0.9, heroic: 1.0?)
	timerScaryFogCD:Start(interval)
	self:ScheduleMethod(interval, "ScaryFogRepeat")
end

function mod:OnCombatStart(delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(3, bossTank)
	end
	hideDebug = 0
	damageDebug = 0
	timeDebug = 0
	hideTime = 0
	getAwayHP = 0
	specialsCast = 0
	hideActive = false
	lastProtect = 0
	table.wipe(guards)
	AddIcon = 8
	guardActivated = 0
	specialRemaining = 0
	lostHealth = 0
	prevlostHealth = 0
	timerSpecialCD:Start(30.5-delay, 1)--Variable, 30.5-37 (or aborted if 80% protect happens first)
	if self:IsDifficulty("heroic10", "heroic25") then
		berserkTimer:Start(420-delay)
	else
		berserkTimer:Start(-delay)
	end
	if DBM:GetRaidRank() > 0 and self.Options.SetIconOnProtector then--You can set marks and you have icons turned on
		self:SendSync("IconCheck", UnitGUID("player"), tostring(DBM.Revision))
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

local function resetguardstate()
	table.wipe(guards)
	AddIcon = 8
	iconsSet = 0
	guardActivated = 0
end
	
mod:RegisterOnUpdateHandler(function(self)
	if hasHighestVersion and not iconsSet == guardActivated then
		for i = 1, DBM:GetNumGroupMembers() do
			local uId = "raid"..i.."target"
			local guid = UnitGUID(uId)
			if guards[guid] then
				SetRaidTarget(uId, guards[guid])
				iconsSet = iconsSet + 1
				guards[guid] = nil
			end
			local guid2 = UnitGUID("mouseover")
			if guards[guid2] then
				SetRaidTarget(uId, guards[guid2])
				iconsSet = iconsSet + 1
				guards[guid2] = nil
			end
		end
	end
end, 0.05)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 123250 then
		local elapsed, total = timerSpecialCD:GetTime(specialsCast+1)
		specialRemaining = total - elapsed
		lastProtect = GetTime()	
		warnProtect:Show()
		specWarnAnimatedProtector:Show()
		self:Schedule(0.2, function()
			timerSpecialCD:Cancel()
		end)
	elseif args.spellId == 123505 and hasHighestVersion then
		guards[args.destGUID] = AddIcon
		AddIcon = AddIcon - 1
		guardActivated = guardActivated + 1
	elseif args.spellId == 123461 then
		specialsCast = specialsCast + 1
		warnGetAway:Show(specialsCast)
		specWarnGetAway:Show()
		timerSpecialCD:Start(nil, specialsCast+1)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerGetAway:Start(45)
		else
			timerGetAway:Start()
		end
		if (self.Options.HealthFrame or DBM.Options.AlwaysShowHealthFrame) and self.Options.GWHealthFrame then
			local getAwayHealth = math.floor(UnitHealthMax("boss1") * 0.04)
			showDamagedHealthBar(self, args.sourceGUID, args.spellName, getAwayHealth)
		end
	elseif args.spellId == 123121 and args:IsDestTypePlayer() then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") then--Only want sprays that are on tanks, not bads standing on tanks.
			timerSpray:Start(args.destName)
			if (args.amount or 1) % 3 == 0 then
				warnSpray:Show(args.destName, args.amount)
				if args.amount >= 6 and args:IsPlayer() then
					specWarnSpray:Show(args.amount)
				else
					if args.amount >= 6 and not UnitDebuff("player", GetSpellInfo(123121)) and not UnitIsDeadOrGhost("player") then
						specWarnSprayOther:Show(args.destName)
					end
				end
			end
		end
	elseif args.spellId == 123705 and self:AntiSpam(2.5, 1) then
		self:ScaryFogRepeat()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 123250 then
		if hasHighestVersion then
			resetguardstate()
		end
		if timerSpecialCD:GetTime(specialsCast+1) == 0 then -- failsafe. (i.e : 79.8% hide -> protect... bar remains)
			local protectElapsed = GetTime() - lastProtect
			local specialCD = specialRemaining - protectElapsed
			if specialCD < 5 then 
				timerSpecialCD:Start(5, specialsCast+1)
			else
				timerSpecialCD:Start(specialCD, specialsCast+1)
			end
		end
	elseif args.spellId == 123121 then
		timerSpray:Cancel(args.destName)
	elseif args.spellId == 123461 then
		timerGetAway:Cancel()
		if (self.Options.HealthFrame or DBM.Options.AlwaysShowHealthFrame) and self.Options.GWHealthFrame then
			hideDamagedHealthBar()
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 123244 then
		hideDebug = 0
		damageDebug = 0
		hideTime = GetTime()
		specialsCast = specialsCast + 1
		hideActive = true
		timerScaryFogCD:Cancel()
		self:UnscheduleMethod("ScaryFogRepeat")
		warnHide:Show(specialsCast)
		specWarnHide:Show()
		timerSpecialCD:Start(nil, specialsCast+1)
		self:SetWipeTime(60)--If she hides at 1.6% or below, she will be killed during hide. In this situration, yell fires very slowly. This hack can prevent recording as wipe.
		self:RegisterShortTermEvents(
			"INSTANCE_ENCOUNTER_ENGAGE_UNIT",--We register on hide, because it also fires just before hide, every time and don't want to trigger "hide over" at same time as hide.
			"SPELL_DAMAGE",
			"SPELL_PERIODIC_DAMAGE",
			"RANGE_DAMAGE"
		)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(3)--Show everyone during hide
		end
	elseif args.spellId == 123705 then
		self:ScaryFogRepeat()
	end
end

function mod:UNIT_HEALTH(uId)
	if uId == "boss1" then
		local currentHealth = 1 - (UnitHealth(uId) / UnitHealthMax(uId))
		if currentHealth and currentHealth < 1 and currentHealth > prevlostHealth then -- Failsafe.
			lostHealth = currentHealth
			prevlostHealth = currentHealth
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 127524 then
		DBM:EndCombat(self)
	end	
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId, _, _, spellDamage)
	local cid = self:GetCIDFromGUID(destGUID)
	if cid == 63099 then--Custom CID lei shi only uses while hiding
		if type(spellDamage) == "number" then--Fix a rare error when spellDamage is a string? In 200 debug prints it only happened once but better safe than sorry
			damageDebug = damageDebug + spellDamage--To see if it's amount of damage
		end
		hideDebug = hideDebug + 1--To see if it's number of hits
		timeDebug = GetTime() - hideTime
	end
end
mod.SPELL_PERIODIC_DAMAGE = mod.SPELL_DAMAGE
mod.RANGE_DAMAGE = mod.SPELL_DAMAGE

--Fires twice when boss returns, once BEFORE visible (and before we can detect unitID, so it flags unknown), then once a 2nd time after visible
--"<233.9> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#nil#nil#Unknown#0xF130F6070000006C#normal#0#nil#nil#nil#nil#normal#0#nil#nil#nil#nil#normal#0#nil#nil#nil#nil#normal#0#Real Args:", -- [14168]
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	hideActive = false
	self:SetWipeTime(3)
	self:UnregisterShortTermEvents()--Once boss appears, unregister event, so we ignore the next two that will happen, which will be 2nd time after reappear, and right before next Hide.
	warnHideOver:Show(GetSpellInfo(123244))
	warnHideProgress:Cancel()
	warnHideProgress:Show(hideDebug, damageDebug, tostring(format("%.1f", timeDebug)))--Show right away instead of waiting out the schedule
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(3, bossTank)--Go back to showing only tanks
	end
end

local function FindFastestHighestVersion()
	DBM:SendSync("FastestPerson", UnitGUID("player"))
end

function mod:OnSync(msg, guid, ver)
	if msg == "IconCheck" and guid and ver then
		if tonumber(ver) > highestVersion then
			highestVersion = tonumber(ver)--Keep bumping highest version to highest we recieve from the icon setters
			if guid == UnitGUID("player") then--Check if that highest version was from ourself
				hasHighestVersion = true
				self:Unschedule(FindFastestHighestVersion)
				self:Schedule(5, FindFastestHighestVersion)
			else--Not from self, it means someone with a higher version than us probably sent it
				self:Unschedule(FindFastestHighestVersion)
				hasHighestVersion = false
			end
		end
	elseif msg == "FastestPerson" and guid and self:AntiSpam(10, 2) then--Whoever sends this sync first wins all. They have highest version and fastest computer
		self:Unschedule(FindFastestHighestVersion)
		if guid == UnitGUID("player") then
			hasHighestVersion = true
			print("DBM Debug: You have highest DBM version with icons enabled and fastest computer. You designated icon setter.")
		else
			hasHighestVersion = false
			print("DBM Debug: You will not be setting icons since your DBM version is out of date or your computer is slower")
		end
	end
end
