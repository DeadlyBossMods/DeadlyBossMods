local mod	= DBM:NewMod(729, "DBM-TerraceofEndlessSpring", nil, 320)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62983)--62995 Animated Protector
mod:SetModelID(42811)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Victory)--Kill detection is aweful. No death, no special cast. yell is like 40 seconds AFTER victory. terrible.
mod:SetUsedIcons(8, 7, 6, 5, 4)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"CHAT_MSG_TARGETICONS",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnProtect						= mod:NewSpellAnnounce(123250, 2)
local warnHide							= mod:NewSpellAnnounce(123244, 3)
local warnHideOver						= mod:NewAnnounce("warnHideOver", 2, 123244)--Because we can. with creativeness, the boss returning is detectable a full 1-2 seconds before even visible. A good signal to stop aoe and get ready to return norm DPS
local warnGetAway						= mod:NewSpellAnnounce(123461, 3)
local warnSpray							= mod:NewStackAnnounce(123121, 3, nil, mod:IsTank() or mod:IsHealer())

local specWarnAnimatedProtector			= mod:NewSpecialWarningSwitch("ej6224", not mod:IsHealer())
local specWarnHide						= mod:NewSpecialWarningSpell(123244, nil, nil, nil, true)
local specWarnGetAway					= mod:NewSpecialWarningSpell(123461, nil, nil, nil, true)
local specWarnSpray						= mod:NewSpecialWarningStack(123121, mod:IsTank(), 6)
local specWarnSprayOther				= mod:NewSpecialWarningTarget(123121, mod:IsTank())

local timerSpecialCD					= mod:NewTimer(49.5, "timerSpecialCD", 123250)--Variable, 49.5-55 seconds
local timerSpray						= mod:NewTargetTimer(10, 123121, nil, mod:IsTank() or mod:IsHealer())
local timerGetAway						= mod:NewBuffActiveTimer(30, 123461)

local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddBoolOption("RangeFrame", true)
mod:AddBoolOption("SetIconOnGuard", false)--Still giving problems. hopefully new sync features work to prevent users reusing icons that are already up.

local hideActive = false
local lastProtect = 0
local specialRemaining = 0
local guards = {}
local guardActivated = 0
local iconsSet = {[1] = false, [2] = false, [3] = false, [4] = false, [5] = false, [6] = false, [7] = false, [8] = false}

local function resetguardstate()
	table.wipe(guards)
	iconsSet = {[1] = false, [2] = false, [3] = false, [4] = false, [5] = false, [6] = false, [7] = false, [8] = false}
end

local function getAvailableIcons()
	for i = 8, 1, -1 do
		if not iconsSet[i] then
			return i
		end
	end
	return 8
end

local function isTank(unit)
	-- 1. check blizzard tanks first
	-- 2. check blizzard roles second
	-- 3. check boss1's highest threat target
	if GetPartyAssignment("MAINTANK", unit, 1) then
		return true
	end
	if UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	if UnitExists("boss1target") and UnitDetailedThreatSituation(unit, "boss1") then
		return true
	end
	return false
end

local bossTank
do
	bossTank = function(uId)
		return isTank(uId)
	end
end

function mod:OnCombatStart(delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(3, bossTank)
	end
	resetguardstate()
	hideActive = false
	lastProtect = 0
	specialRemaining = 0
	timerSpecialCD:Start(32.5-delay)--Variable, 32.5-37 (or aborted if 80% protect happens first)
	if self:IsDifficulty("heroic10", "heroic25") then
		berserkTimer:Start(420-delay)
	else
		berserkTimer:Start(-delay)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(123250) then
		local elapsed, total = timerSpecialCD:GetTime()
		specialRemaining = total - elapsed
		lastProtect = GetTime()
		timerSpecialCD:Cancel()
		warnProtect:Show()
		specWarnAnimatedProtector:Show()
	elseif args:IsSpellID(123505) and self.Options.SetIconOnGuard then
		if guardActivated == 0 then
			resetguardstate()
		end
		guardActivated = guardActivated + 1
		if not guards[args.sourceGUID] then
			guards[args.destGUID] = true
		end
	elseif args:IsSpellID(123461) then
		warnGetAway:Show()
		specWarnGetAway:Show()
		timerGetAway:Start()
		timerSpecialCD:Start()
	elseif args:IsSpellID(123121) then
		local uId = DBM:GetRaidUnitId(args.destName)
		if isTank(uId) then--Only want sprays that are on tanks, not bads standing on tanks.
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
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(123250) then
		local protectElapsed = GetTime() - lastProtect
		local specialCD = specialRemaining - protectElapsed
		if specialCD < 5 then
			timerSpecialCD:Start(5)
		else
			timerSpecialCD:Start(specialCD)
		end
		if self.Options.SetIconOnGuard then
			guardActivated = 0
		end
	elseif args:IsSpellID(123121) then
		timerSpray:Cancel(args.destName)
	elseif args:IsSpellID(123461) then
		timerGetAway:Cancel()
	end
end

mod:RegisterOnUpdateHandler(function(self)
	if self.Options.SetIconOnGuard and guardActivated > 0 and DBM:GetRaidRank() > 0 then
		for i = 1, DBM:GetGroupMembers() do
			local uId = "raid"..i.."target"
			local guid = UnitGUID(uId)
			if guards[guid] then
				local existingIcons = GetRaidTargetIndex(uId)
				if not existingIcons then
					local icon = getAvailableIcons()
					SetRaidTarget(uId, icon)
					iconsSet[icon] = true
					self:SendSync("iconSet", icon)
				elseif existingIcons then
					iconsSet[existingIcons] = true
				end
				guards[guid] = nil
			end
		end
		local guid2 = UnitGUID("mouseover")
		if guards[guid2] then
			local existingIcons = GetRaidTargetIndex("mouseover")
			if not existingIcons then
				local icon = getAvailableIcons()
				SetRaidTarget("mouseover", icon)
				iconsSet[icon] = true
				self:SendSync("iconSet", icon)
			elseif existingIcons then
				iconsSet[existingIcons] = true
			end
			guards[guid2] = nil
		end
	end
end, 0.05)

function mod:OnSync(msg, icon)
	if msg == "iconSet" and icon then
		iconsSet[icon] = true
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(123244) then
		hideActive = true
		warnHide:Show()
		specWarnHide:Show()
		timerSpecialCD:Start()
		self:RegisterShortTermEvents(
			"INSTANCE_ENCOUNTER_ENGAGE_UNIT"--We register on hide, because it also fires just before hide, every time and don't want to trigger "hide over" at same time as hide.
		)
	end
end

function mod:CHAT_MSG_TARGETICONS(msg)
	--TARGET_ICON_SET = "|Hplayer:%s|h[%s]|h sets |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t on %s.";
	--if msg == TARGET_ICON_SET then
		--Insert fancy code that pulls icon number out of here somehow
		--iconsSet[icon] = true--Then sets it to true
	--end
	local icon = tonumber(string.sub(string.match(msg, "RaidTargetingIcon_%d"), -1))
	if icon then
		iconsSet[icon] = true
	end
end

--Fires twice when boss returns, once BEFORE visible (and before we can detect unitID, so it flags unknown), then once a 2nd time after visible
--"<233.9> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#nil#nil#Unknown#0xF130F6070000006C#normal#0#nil#nil#nil#nil#normal#0#nil#nil#nil#nil#normal#0#nil#nil#nil#nil#normal#0#Real Args:", -- [14168]
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	hideActive = false
	self:UnregisterShortTermEvents()--Once boss appears, unregister event, so we ignore the next two that will happen, which will be 2nd time after reappear, and right before next Hide.
	warnHideOver:Show(GetSpellInfo(123244))
--	timerSpecialCD:Start()--Probably wrong so disabled. i still can't find this fights true pattern since it's all over the place and never matches up.
end
