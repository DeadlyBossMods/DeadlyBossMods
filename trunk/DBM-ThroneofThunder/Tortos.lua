local mod	= DBM:NewMod(825, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(67977)
mod:SetModelID(46559)
mod:SetUsedIcons(8, 7, 6, 5, 4, 3)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_TARGETICONS",
	"UNIT_AURA"
)

local warnBite						= mod:NewSpellAnnounce(135251, 3, nil, mod:IsTank())
local warnRockfall					= mod:NewSpellAnnounce(134476, 2)
local warnCallofTortos				= mod:NewSpellAnnounce(136294, 3)
local warnQuakeStomp				= mod:NewCountAnnounce(134920, 3)
local warnKickShell					= mod:NewAnnounce("warnKickShell", 2, 134031)
local warnStoneBreath				= mod:NewCastAnnounce(133939, 4)
local warnShellConcussion			= mod:NewTargetAnnounce(136431, 1)

local specWarnCallofTortos			= mod:NewSpecialWarningSpell(136294)
local specWarnQuakeStomp			= mod:NewSpecialWarningSpell(134920, nil, nil, nil, 2)
local specWarnRockfall				= mod:NewSpecialWarningSpell(134476, false, nil, nil, 2)
local specWarnStoneBreath			= mod:NewSpecialWarningInterrupt(133939)
local specWarnCrystalShell			= mod:NewSpecialWarning("specWarnCrystalShell", false)

local timerBiteCD					= mod:NewCDTimer(8, 135251, nil, mod:IsTank())
local timerRockfallCD				= mod:NewCDTimer(10, 134476)
local timerCallTortosCD				= mod:NewNextTimer(60.5, 136294)
local timerStompCD					= mod:NewNextCountTimer(49, 134920)
local timerBreathCD					= mod:NewNextTimer(47, 133939)
local timerStompActive				= mod:NewBuffActiveTimer(10.8, 134920)--Duration f the rapid caveins??
local timerShellConcussion			= mod:NewBuffFadesTimer(20, 136431)

local berserkTimer					= mod:NewBerserkTimer(780)

mod:AddBoolOption("InfoFrame")
mod:AddBoolOption("SetIconOnTurtles", false)

local shelldName = GetSpellInfo(137633)
local shellConcussion = GetSpellInfo(136431)
local stompActive = false
local stompCount = 0
local firstRockfall = false--First rockfall after a stomp
local shellsRemaining = 0
local lastConcussion = 0
local kickedShells = {}
local addsActivated = 0
local checkIcons = false
local alternateSet = false
local adds = {}
local iconsSet = {[1] = false, [2] = false, [3] = false, [4] = false, [5] = false, [6] = false, [7] = false, [8] = false}

local function resetaddstate()
	table.wipe(adds)
	iconsSet = {[1] = false, [2] = false, [3] = false, [4] = false, [5] = false, [6] = false, [7] = false, [8] = false}
	if addsActivated >= 1 then--at least one add is up, we'll alternate between skull x and square and other 3 icons.
		if alternateSet then--We will set icons 8 7 and 6 in use and use alternate icons for this set
			iconsSet[8] = true
			iconsSet[7] = true
			iconsSet[6] = true
			alternateSet = false
		else--Not an alternet set so we set next set to alternate set
			alternateSet = true
		end
	else--No adds are up, we're going to start with skull anyways and set next as an alternate set, even if it wasn't originally going to be one.
		alternateSet = true
	end
end

local function resetIconcheck()
	checkIcons = false
end

local function getAvailableIcons()
	for i = 8, 1, -1 do
		if not iconsSet[i] then
			return i
		end
	end
	return 8
end

mod:RegisterOnUpdateHandler(function(self)
	if self.Options.SetIconOnTurtles and checkIcons and DBM:GetRaidRank() > 0 then
		for i = 1, DBM:GetNumGroupMembers() do
			local uId = "raid"..i.."target"
			local guid = UnitGUID(uId)
			if adds[guid] then
				local existingIcons = GetRaidTargetIndex(uId)
				if not existingIcons then
					local icon = getAvailableIcons()
					SetRaidTarget(uId, icon)
					iconsSet[icon] = true
					self:SendSync("iconSet", icon)
				elseif existingIcons then
					iconsSet[existingIcons] = true
				end
				adds[guid] = nil
			end
		end
		local guid2 = UnitGUID("mouseover")
		if adds[guid2] then
			local existingIcons = GetRaidTargetIndex("mouseover")
			if not existingIcons then
				local icon = getAvailableIcons()
				SetRaidTarget("mouseover", icon)
				iconsSet[icon] = true
				self:SendSync("iconSet", icon)
			elseif existingIcons then
				iconsSet[existingIcons] = true
			end
			adds[guid2] = nil
		end
	end
end, 1)

function mod:OnSync(msg, icon)
	if msg == "iconSet" and icon then
		iconsSet[icon] = true
	end
end

local function clearStomp()
	stompActive = false
	firstRockfall = false--First rockfall after a stomp
	if mod:AntiSpam(9, 1) then--prevent double warn.
		warnRockfall:Show()
		specWarnRockfall:Show()
		timerRockfallCD:Start()--Resume normal CDs, first should be 5 seconds after stomp spammed ones
	end
end

function mod:OnCombatStart(delay)
	stompActive = false
	stompCount = 0
	firstRockfall = false--First rockfall after a stomp
	shellsRemaining = 0
	lastConcussion = 0
	addsActivated = 0
	alternateSet = false
	table.wipe(adds)
	table.wipe(kickedShells)
	timerRockfallCD:Start(15-delay)
	timerCallTortosCD:Start(21-delay)
	timerStompCD:Start(29-delay, 1)
	timerBreathCD:Start(-delay)
	berserkTimer:Start(-delay)
	if self.Options.InfoFrame and self:IsDifficulty("heroic10", "heroic25") then
		DBM.InfoFrame:SetHeader(L.WrongDebuff:format(shelldName))
		DBM.InfoFrame:Show(5, "playergooddebuff", 137633)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 133939 then
		warnStoneBreath:Show()
		specWarnStoneBreath:Show(args.sourceName)
		timerBreathCD:Start()
	elseif args.spellId == 136294 then
		warnCallofTortos:Show()
		specWarnCallofTortos:Show()
		if self:AntiSpam(59, 3) then -- On below 10%, he casts Call of Tortos always. This cast ignores cooldown, so filter below 10% cast.
			timerCallTortosCD:Start()
		end
	elseif args.spellId == 135251 then
		warnBite:Show()
		timerBiteCD:Start()
	elseif args.spellId == 134920 then
		stompActive = true
		stompCount = stompCount + 1
		warnQuakeStomp:Show(stompCount)
		specWarnQuakeStomp:Show()
		timerStompActive:Start()
		timerRockfallCD:Start(7.4)--When the spam of rockfalls start
		timerStompCD:Start(49, stompCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 133971 then--Shell Block (turtles dying and becoming kickable)
		shellsRemaining = shellsRemaining + 1
		addsActivated = addsActivated - 1
	elseif args.spellId == 133974 and self.Options.SetIconOnTurtles then--Spinning Shell
		if self:AntiSpam(5, 2) then
			checkIcons = true
			resetaddstate()
			self:Schedule(8, resetIconcheck)
		end
		addsActivated = addsActivated + 1
		if not adds[args.sourceGUID] then
			adds[args.sourceGUID] = true
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 137633 and args:IsPlayer() then
		specWarnCrystalShell:Show(shelldName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 134476 then
		if stompActive then--10 second cd normally, but cd is disabled when stomp active
			if not firstRockfall then--Announce first one only and ignore the next ones spammed for about 9-10 seconds
				firstRockfall = true
				warnRockfall:Show()
				specWarnRockfall:Show()--To warn of massive incoming for the 9 back to back rockfalls that are incoming
				self:Schedule(10, clearStomp)
			end
		else
			if self:AntiSpam(9, 1) then--sometimes clearstomp doesn't work? i can't find reason cause all logs match this system exactly.
				warnRockfall:Show()
				specWarnRockfall:Show()
				timerRockfallCD:Start()
			end
		end
	elseif args.spellId == 134031 and not kickedShells[args.destGUID] then--Kick Shell
		kickedShells[args.destGUID] = true
		shellsRemaining = shellsRemaining - 1
		warnKickShell:Show(args.spellName, args.sourceName, shellsRemaining)
	end
end

function mod:CHAT_MSG_TARGETICONS(msg)
	--TARGET_ICON_SET = "|Hplayer:%s|h[%s]|h sets |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t on %s.";
	local icon = tonumber(string.sub(string.match(msg, "RaidTargetingIcon_%d"), -1))
	if icon then
		iconsSet[icon] = true
		local additionalIcons = 8 - icon--Lets say we get a chat message a user used icon 6. we already set 6 to true, but now we do 8-6 to find out there are two other icons above 6 that we should also set to true (just in case)
		if additionalIcons > 0 then--Icon used by someone else is less than 8 which which means we should assume the icons above this number are also already used
			for i = 1, additionalIcons do--So now we take those 2 remaining icons, adds + 1, set that to true, do it one more time, set that to true.
				icon = icon + 1
				iconsSet[icon] = true--Now 6 7 and 8 should all be true if the chat icon sent was 6. This should make sure even after a DC icon setters SHOULD in theory be on same page
			end
		end
	end
end

function mod:UNIT_AURA(uId)
	if uId ~= "boss1" then return end
	local _, _, _, _, _, duration, expires = UnitDebuff(uId, shellConcussion)
	if expires and lastConcussion ~= expires then
		lastConcussion = expires
		timerShellConcussion:Start()
		if self:AntiSpam(3, 2) then
			warnShellConcussion:Show(L.name)
		end
	end
end
