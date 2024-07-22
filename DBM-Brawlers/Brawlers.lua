local mod	= DBM:NewMod("BrawlersGeneral", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(60491)
--mod:SetModelID(41448)
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"CHAT_MSG_MONSTER_YELL"
)

local warnQueuePosition		= mod:NewAnnounce("warnQueuePosition2", 2, 132639, true)
local warnOrgPortal			= mod:NewCastAnnounce(135385, 1)--These are rare casts and linked to achievement.
local warnStormPortal		= mod:NewCastAnnounce(135386, 1)--So warn for them being cast

local specWarnOrgPortal		= mod:NewSpecialWarningSpell(135385, nil, nil, nil, 1, 7)
local specWarnStormPortal	= mod:NewSpecialWarningSpell(135386, nil, nil, nil, 1, 7)
local specWarnYourNext		= mod:NewSpecialWarning("specWarnYourNext")
local specWarnYourTurn		= mod:NewSpecialWarning("specWarnYourTurn")
local specWarnRumble		= mod:NewSpecialWarning("specWarnRumble")

local berserkTimer			= mod:NewBerserkTimer(123)--all fights have a 2 min enrage to 134545. some fights have an earlier berserk though.

mod:AddBoolOption("SpectatorMode", true)
mod:AddBoolOption("SpeakOutQueue", true)
mod:AddBoolOption("NormalizeVolume", true, "misc")

local playerIsFighting = false
local currentFighter = nil
local currentZoneID = select(8, GetInstanceInfo())
local modsStopped = false
local eventsRegistered = false
local lastRank = 0

---@param self DBMMod
local function setDialog(self, set)
	if not self.Options.NormalizeVolume then return end
	if set then
		local soundVolume = tonumber(GetCVar("Sound_SFXVolume"))
		self.Options.SoundOption = tonumber(GetCVar("Sound_DialogVolume")) or 1
		DBM:Debug("Setting normalized volume to SFX volume of: "..soundVolume)
		SetCVar("Sound_DialogVolume", soundVolume)
	else
		DBM:Debug("Exiting Brawlers Area, checking Sound")
		if self.Options.SoundOption then
			DBM:Debug("Restoring Dialog volume to saved value of: "..self.Options.SoundOption)
			SetCVar("Sound_DialogVolume", self.Options.SoundOption)
			self.Options.SoundOption = nil
		end
	end
end

--Fix for not registering events on reloadui or login while already inside brawlers guild.
if currentZoneID == 369 or currentZoneID == 1043 then
	eventsRegistered = true
	mod:RegisterShortTermEvents(
		"SPELL_CAST_START 135385 135386",
		"PLAYER_REGEN_ENABLED",
		"UNIT_DIED",
		"UNIT_AURA player"
	)
	mod:Unschedule(setDialog)
	mod:Schedule(1, setDialog, mod, true)
end

function mod:PlayerFighting() -- for external mods
	return playerIsFighting
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 135385 then
		if not playerIsFighting then--Do not distract player in arena with special warning
			specWarnOrgPortal:Show()
			specWarnOrgPortal:Play("newportal")
		else
			warnOrgPortal:Show()
		end
	elseif args.spellId == 135386 then
		if not playerIsFighting then--Do not distract player in arena with special warning
			specWarnStormPortal:Show()
			specWarnStormPortal:Play("newportal")
		else
			warnStormPortal:Show()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
	if npc ~= L.Bizmo and npc ~= L.Bazzelflange then return end
	local isMatchBegin = true
	--Search is for Rank <n> to avoid lines like "x has risen through the ranks" or something else along those lines.
	if msg:find(L.Rank1, 1, true) or msg:find(L.Rank2, 1, true) or msg:find(L.Rank3, 1, true) or msg:find(L.Rank4, 1, true) or msg:find(L.Rank5, 1, true) or msg:find(L.Rank6, 1, true) or msg:find(L.Rank7, 1, true) or msg:find(L.Rank8, 1, true) then -- fix for ruRU clients.
		currentFighter = target
	elseif msg:find(L.Rumbler) then
		--self:SendThrottledSync("MatchEnd")--End any other matches in progress
		--isMatchBegin = false--And start a new match instead?
		specWarnRumble:Show()
	--He's targeting current fighter but it's not a match begin yell, the only other times this happens is on match end and 10 second pre berserk warning.
	--This tries to filter pre berserk warnings then pass match end in a way that will definitely catch them all
	--but might also incorrectly cancel berserk timer at 10 second pre berserk warning if a message filter isn't localized yet
	--But it's still better to cancel berserk 10 seconds early, than to fail to end a match at all.
	elseif currentFighter and (target == currentFighter) and not (msg:find(L.BizmoIgnored) or msg == L.BizmoIgnored or msg:find(L.BizmoIgnored2) or msg == L.BizmoIgnored2 or msg:find(L.BizmoIgnored3) or msg == L.BizmoIgnored3 or msg:find(L.BizmoIgnored4) or msg == L.BizmoIgnored4 or msg:find(L.BizmoIgnored5) or msg == L.BizmoIgnored5 or msg:find(L.BizmoIgnored6) or msg == L.BizmoIgnored6 or msg:find(L.BizmoIgnored7) or msg == L.BizmoIgnored7 or msg:find(L.BazzelIgnored) or msg == L.BazzelIgnored or msg:find(L.BazzelIgnored2) or msg == L.BazzelIgnored2 or msg:find(L.BazzelIgnored3) or msg == L.BazzelIgnored3 or msg:find(L.BazzelIgnored4) or msg == L.BazzelIgnored4 or msg:find(L.BazzelIgnored5) or msg == L.BazzelIgnored5 or msg:find(L.BazzelIgnored6) or msg == L.BazzelIgnored6 or msg:find(L.BazzelIgnored7) or msg == L.BazzelIgnored7) then
		self:SendThrottledSync(3, "MatchEnd")
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
			self:SendThrottledSync(3, "MatchBegin")
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
		self:SendThrottledSync(3, "MatchEnd")
	end
end

function mod:UNIT_DIED(args)
	if not args.destName then return end
	--Another backup for when npc doesn't yell. This is a way to detect a wipe at least.
	if currentFighter and args.destName == currentFighter and args:IsDestTypePlayer() then--They wiped.
		self:SendThrottledSync(3, "MatchEnd")
	end
end

function mod:ZONE_CHANGED_NEW_AREA()
	currentZoneID = select(8, GetInstanceInfo())
	if currentZoneID == 369 or currentZoneID == 1043 then
		playerIsFighting = false
		currentFighter = nil
		lastRank = 0
		modsStopped = false
		eventsRegistered = true
		self:RegisterShortTermEvents(
			"SPELL_CAST_START 135385 135386",
			"PLAYER_REGEN_ENABLED",
			"UNIT_DIED",
			"UNIT_AURA player"
		)
		self:Unschedule(setDialog)
		self:Schedule(1, setDialog, mod, true)
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
	local mod3 = DBM:GetModByName("BrawlChallenges")
	if mod3 then
		mod3:Stop()--Stop all timers and warnings
	end
	local mod4 = DBM:GetModByName("BrawlLegacy")
	if mod4 then
		mod4:Stop()--Stop all timers and warnings
	end
	local mod5 = DBM:GetModByName("BrawlRumble")
	if mod5 then
		mod5:Stop()--Stop all timers and warnings
	end
	setDialog(self)
	modsStopped = true
end

local startCallbacks, endCallbacks = {}, {}

function mod:OnMatchStart(callback)
	table.insert(startCallbacks, callback)
end

function mod:OnMatchEnd(callback)
	table.insert(endCallbacks, callback)
end

local function stopExtraMod(mod)
	if mod then
		mod:Stop()--Stop all timers and warnings
	end
end

--Most group up for this so they can buff eachother for matches. Syncing should greatly improve reliability, especially for match end since the person fighting definitely should detect that (probably missing yells still)
function mod:OnSync(msg)
	if msg == "MatchBegin" then
		if currentZoneID ~= 369 and currentZoneID ~= 1043 then return end
		if not eventsRegistered then
			eventsRegistered = true
			self:RegisterShortTermEvents(
				"SPELL_CAST_START 135385 135386",
				"PLAYER_REGEN_ENABLED",
				"UNIT_DIED",
				"UNIT_AURA player"
			)
		end
		self:Stop()--Sometimes NPC doesn't yell when a match ends too early, if a new match begins we stop on begin before starting new stuff
		berserkTimer:Start()
		for _, v in ipairs(startCallbacks) do
			v()
		end
	elseif msg == "MatchEnd" then
		if currentZoneID ~= 369 and currentZoneID ~= 1043 then return end
		currentFighter = nil
		self:Stop()
		--Boss from any rank can be fought by any rank now, so we just need to always cancel them all
		for _, v in ipairs(endCallbacks) do
			v()
		end
		for i = 1, 7 do
			stopExtraMod(DBM:GetModByName("BrawlRank" .. i))
		end
		stopExtraMod(DBM:GetModByName("BrawlChallenges"))
		stopExtraMod(DBM:GetModByName("BrawlLegacy"))
		stopExtraMod(DBM:GetModByName("BrawlRumble"))
	end
end

do
	local QueuedBuff = DBM:GetSpellName(132639)
	function mod:UNIT_AURA()
		local currentQueueRank = select(16, DBM:UnitBuff("player", QueuedBuff))
		if currentQueueRank and currentQueueRank ~= lastRank then
			lastRank = currentQueueRank
			if currentQueueRank ~= 0 then
				if currentQueueRank == 1 then
					specWarnYourNext:Show()
				else
					warnQueuePosition:Show(currentQueueRank)
				end
			end
			if self.Options.SpeakOutQueue then
				DBM:PlayCountSound(currentQueueRank)
			end
		end
	end
end
