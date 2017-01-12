local mod	= DBM:NewMod("Brawlers", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(60491)
--mod:SetModelID(41448)
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"CHAT_MSG_MONSTER_YELL"
)

local warnQueuePosition		= mod:NewAnnounce("warnQueuePosition", 2, 132639, false)
local warnOrgPortal			= mod:NewCastAnnounce(135385, 1)--These are rare casts and linked to achievement.
local warnStormPortal		= mod:NewCastAnnounce(135386, 1)--So warn for them being cast

local specWarnOrgPortal		= mod:NewSpecialWarningSpell(135385)
local specWarnStormPortal	= mod:NewSpecialWarningSpell(135386)
local specWarnYourNext		= mod:NewSpecialWarning("specWarnYourNext")
local specWarnYourTurn		= mod:NewSpecialWarning("specWarnYourTurn")

local berserkTimer			= mod:NewBerserkTimer(120)--all fights have a 2 min enrage to 134545. some fights have an earlier berserk though.

mod:AddBoolOption("SpectatorMode", true)
mod:AddBoolOption("SpeakOutQueue", true)
mod:AddBoolOption("NormalizeVolume", true, "misc")
mod:RemoveOption("HealthFrame")

local playerIsFighting = false
local currentFighter = nil
local currentRank = 0--Used to stop bars for the right sub mod based on dynamic rank detection from pulls
local currentZoneID = select(8, GetInstanceInfo())
local modsStopped = false
local eventsRegistered = false
local lastRank = 0
--Fix for not registering events on reloadui or login while already inside brawlers guild.
if currentZoneID == 369 or currentZoneID == 1043 then
	eventsRegistered = true
	mod:RegisterShortTermEvents(
		"SPELL_CAST_START 135385 135386",
		"PLAYER_REGEN_ENABLED",
		"UNIT_DIED",
		"UNIT_AURA player"
	)
	if mod.Options.NormalizeVolume then
		local soundVolume = tonumber(GetCVar("Sound_SFXVolume"))
		mod.Options.SoundOption = tonumber(GetCVar("Sound_DialogVolume")) or 1
		DBM:Debug("Setting normalized volume to SFX volume of: "..soundVolume)
		SetCVar("Sound_DialogVolume", soundVolume)
	end
end

function mod:PlayerFighting() -- for external mods
	return playerIsFighting
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 135385 then
		if not playerIsFighting then--Do not distract player in arena with special warning
			specWarnOrgPortal:Show()
		else
			warnOrgPortal:Show()
		end
	elseif args.spellId == 135386 then
		if not playerIsFighting then--Do not distract player in arena with special warning
			specWarnStormPortal:Show()
		else
			warnStormPortal:Show()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
	if npc ~= L.Bizmo and npc ~= L.Bazzelflange then return end
	local isMatchBegin = true
	if msg:find(L.Rank1, 1, true) then -- fix for ruRU clients.
		currentFighter = target
		currentRank = 1
	elseif msg:find(L.Rank2, 1, true) then
		currentFighter = target
		currentRank = 2
	elseif msg:find(L.Rank3, 1, true) then
		currentFighter = target
		currentRank = 3
	elseif msg:find(L.Rank4, 1, true) then
		currentFighter = target
		currentRank = 4
	elseif msg:find(L.Rank5, 1, true) then
		currentFighter = target
		currentRank = 5
	elseif msg:find(L.Rank6, 1, true) then
		currentFighter = target
		currentRank = 6
	elseif msg:find(L.Rank7, 1, true) then
		currentFighter = target
		currentRank = 7
	elseif msg:find(L.Rank8, 1, true) then
		currentFighter = target
		currentRank = 8
	elseif msg:find(L.Rank9, 1, true) then
		currentFighter = target
		currentRank = 9
	elseif msg:find(L.Rank10, 1, true) then
		currentFighter = target
		currentRank = 10
	elseif currentFighter and target == currentFighter and (npc == L.Bizmo or npc == L.Bazzelflange) then--He's targeting current fighter but it's not a match begin yell, the only other time this happens is on match end.
		self:SendSync("MatchEnd")
		isMatchBegin = false
	else
		isMatchBegin = false
	end
	if isMatchBegin then
		if target == UnitName("player") then
			specWarnYourTurn:Show()
			playerIsFighting = true
		end
		if self:LatencyCheck() or not IsInGroup() then--If not in group always send sync regardless of latency, better to start match late then never start it at all.
			self:SendSync("MatchBegin")
		end
	end
	--Only boss with a custom berserk timer. His is 1 minute, but starts at different yell than 2 min berserk, so it's not actually 60 sec shorter but more like 50-55 sec shorter
	--Need the yells for meatball too i guess? he has a 1 minute berserk as well?
	if msg == L.Proboskus or msg:find(L.Proboskus) or msg == L.Proboskus2 or msg:find(L.Proboskus2) then
		self:Schedule(2, function()
			berserkTimer:Cancel()
			berserkTimer:Start(58)
		end)
	end
end

--TODO: Maybe add a PLAYE_REGEN_DISABLED event that checks current target for deciding what special bars to start on engage.
function mod:PLAYER_REGEN_ENABLED()
	--Backup for failed match end detection. this only works if you're grouped with the fighter. This is for when npc doesn't yell on victory or wipe.
	if playerIsFighting then--We check playerIsFighting to filter bar brawls, this should only be true if we were ported into ring.
		playerIsFighting = false
		self:SendSync("MatchEnd")
	end
end

function mod:UNIT_DIED(args)
	if not args.destName then return end
	--Another backup for when npc doesn't yell. This is a way to detect a wipe at least.
	if currentFighter and args.destName == currentFighter and args:IsDestTypePlayer() then--They wiped. Fix match ends when mage's mirror image died. 
		self:SendSync("MatchEnd")
	end
end

function mod:ZONE_CHANGED_NEW_AREA()
	currentZoneID = select(8, GetInstanceInfo())
	if currentZoneID == 369 or currentZoneID == 1043 then
		playerIsFighting = false
		currentFighter = nil
		currentRank = 0
		lastRank = 0
		modsStopped = false
		eventsRegistered = true
		self:RegisterShortTermEvents(
			"SPELL_CAST_START",
			"PLAYER_REGEN_ENABLED",
			"UNIT_DIED",
			"UNIT_AURA player"
		)
		if self.Options.NormalizeVolume then
			local soundVolume = tonumber(GetCVar("Sound_SFXVolume"))
			self.Options.SoundOption = tonumber(GetCVar("Sound_DialogVolume")) or 1
			DBM:Debug("Setting normalized volume to SFX volume of: "..soundVolume)
			SetCVar("Sound_DialogVolume", soundVolume)
		end
		return
	end--We returned to arena, reset variable
	if modsStopped then return end--Don't need this to fire every time you change zones after the first.
	self:Stop()
	self:UnregisterShortTermEvents()
	eventsRegistered = false
	for i = 1, 7 do
		local mod2 = DBM:GetModByName("BrawlRank" .. i)
		if mod2 then
			mod2:Stop()--Stop all timers and warnings
		end
	end
	local mod2 = DBM:GetModByName("BrawlChallenges")
	if mod2 then
		mod2:Stop()--Stop all timers and warnings
	end
	local mod2 = DBM:GetModByName("BrawlLegacy")
	if mod2 then
		mod2:Stop()--Stop all timers and warnings
	end
	local mod2 = DBM:GetModByName("BrawlRumble")
	if mod2 then
		mod2:Stop()--Stop all timers and warnings
	end
	if self.Options.NormalizeVolume then
		if self.Options.SoundOption then
			DBM:Debug("Restoring Dialog volume to saved value of: "..self.Options.SoundOption)
			SetCVar("Sound_DialogVolume", self.Options.SoundOption)
			self.Options.SoundOption = nil
		end
	end
	modsStopped = true
end

local startCallbacks, endCallbacks = {}, {}

function mod:OnMatchStart(callback)
	table.insert(startCallbacks, callback)
end

function mod:OnMatchEnd(callback)
	table.insert(endCallbacks, callback)
end

--Most group up for this so they can buff eachother for matches. Syncing should greatly improve reliability, especially for match end since the person fighting definitely should detect that (probably missing yells still)
function mod:OnSync(msg)
	if msg == "MatchBegin" then
		if not eventsRegistered then
			eventsRegistered = true
			self:RegisterShortTermEvents(
				"SPELL_CAST_START",
				"PLAYER_REGEN_ENABLED",
				"UNIT_DIED",
				"UNIT_AURA player"
			)
		end
		if not (currentZoneID == 369 or currentZoneID == 1043) then return end
		self:Stop()--Sometimes NPC doesn't yell when a match ends too early, if a new match begins we stop on begin before starting new stuff
		berserkTimer:Start()
		for i, v in ipairs(startCallbacks) do
			v()
		end
	elseif msg == "MatchEnd" then
		if not (currentZoneID == 369 or currentZoneID == 1043) then return end
		currentFighter = nil
		self:Stop()
		--Boss from any rank can be fought by any rank now, so we just need to always cancel them all
		for i, v in ipairs(endCallbacks) do
			v()
		end
		for i = 1, 7 do
			local mod2 = DBM:GetModByName("BrawlRank" .. i)
			if mod2 then
				mod2:Stop()--Stop all timers and warnings
			end
		end
		local mod2 = DBM:GetModByName("BrawlChallenges")
		if mod2 then
			mod2:Stop()--Stop all timers and warnings
		end
		local mod2 = DBM:GetModByName("BrawlLegacy")
		if mod2 then
			mod2:Stop()--Stop all timers and warnings
		end
		local mod2 = DBM:GetModByName("BrawlRumble")
		if mod2 then
			mod2:Stop()--Stop all timers and warnings
		end
	end
end

do
	local QueuedBuff = GetSpellInfo(132639)
	function mod:UNIT_AURA(uId)
		local currentQueueRank = select(17, UnitBuff("player", QueuedBuff))
		if currentQueueRank and currentQueueRank ~= lastRank then
			lastRank = currentQueueRank
			warnQueuePosition:Show(currentQueueRank)
			if currentQueueRank == 1 then
				specWarnYourNext:Show()
			end
			if self.Options.SpeakOutQueue then
				DBM:PlayCountSound(currentQueueRank)
			end
		end
	end
end
