local mod	= DBM:NewMod("Brawlers", "DBM-Brawlers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(60491)
--mod:SetModelID(41448)
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL",
	"PLAYER_REGEN_ENABLED",
	"UNIT_DIED",
	"ZONE_CHANGED_NEW_AREA"
)

local warnOrgPortal			= mod:NewCastAnnounce(135385, 1)--These are rare casts and linked to achievement.
local warnStormPortal		= mod:NewCastAnnounce(135386, 1)--So warn for them being cast

local specWarnOrgPortal		= mod:NewSpecialWarningSpell(135385)
local specWarnStormPortal	= mod:NewSpecialWarningSpell(135386)
local specWarnYourTurn		= mod:NewSpecialWarning("specWarnYourTurn")

local berserkTimer			= mod:NewBerserkTimer(120)--all fights have a 2 min enrage to 134545. some fights have an earlier berserk though.

mod:AddBoolOption("SpectatorMode", true)
mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local playerIsFighting = false
local currentFighter = nil
local currentRank = 0--Used to stop bars for the right sub mod based on dynamic rank detection from pulls
local currentZoneID = 0
local modsStopped = false

function mod:PlayerFighting() -- for external mods
	return playerIsFighting
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 135385 then
		warnOrgPortal:Show()
		if not playerIsFighting then--Do not distract player in arena with special warning
			specWarnOrgPortal:Show()
		end
	elseif args.spellId == 135386 then
		warnStormPortal:Show()
		if not playerIsFighting then--Do not distract player in arena with special warning
			specWarnStormPortal:Show()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
	local isMatchBegin = true
	if msg:find(L.Rank1) then
		currentFighter = target
		currentRank = 1
	elseif msg:find(L.Rank2) then
		currentFighter = target
		currentRank = 2
	elseif msg:find(L.Rank3) then
		currentFighter = target
		currentRank = 3
	elseif msg:find(L.Rank4) then
		currentFighter = target
		currentRank = 4
	elseif msg:find(L.Rank5) then
		currentFighter = target
		currentRank = 5
	elseif msg:find(L.Rank6) then
		currentFighter = target
		currentRank = 6
	elseif msg:find(L.Rank7) then
		currentFighter = target
		currentRank = 7
	elseif msg:find(L.Rank8) then
		currentFighter = target
		currentRank = 8
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
	--Another backup for when npc doesn't yell. This is a way to detect a wipe at least.
	local thingThatDied = string.split("-", args.destName)--currentFighter never has realm name, so we need to strip it from combat log for CRZ support
	if currentFighter and currentFighter == thingThatDied then--They wiped.
		self:SendSync("MatchEnd")
	end
end

function mod:ZONE_CHANGED_NEW_AREA()
	currentZoneID = GetCurrentMapAreaID()
	if currentZoneID == 922 or currentZoneID == 925 then modsStopped = false return end--We returned to arena, reset variable
	if modsStopped then return end--Don't need this to fire every time you change zones after the first.
	self:Stop()
	for i = 1, 8 do
		local mod2 = DBM:GetModByName("BrawlRank" .. i)
		if mod2 then
			mod2:Stop()--Stop all timers and warnings
		end
	end
	modsStopped = true
end

--Most group up for this so they can buff eachother for matches. Syncing should greatly improve reliability, especially for match end since the person fighting definitely should detect that (probably missing yells still)
function mod:OnSync(msg)
	if msg == "MatchBegin" then
		if not (currentZoneID == 0 or currentZoneID == 922 or currentZoneID == 925) then return end
		self:Stop()--Sometimes NPC doesn't yell when a match ends too early, if a new match begins we stop on begin before starting new stuff
		berserkTimer:Start()
	elseif msg == "MatchEnd" then
		if not (currentZoneID == 0 or currentZoneID == 922 or currentZoneID == 925) then return end
		currentFighter = nil
		self:Stop()
		local mod2 = DBM:GetModByName("BrawlRank" .. currentRank)
		if mod2 then
			mod2:Stop()--Stop all timers and warnings
		end
		if currentRank == 0 then--We walked in on an in progress match and didn't capture what rank it is, so lets make sure when match ends we stop ALL mods
			for i = 1, 8 do
				local mod2 = DBM:GetModByName("BrawlRank" .. i)
				if mod2 then
					mod2:Stop()--Stop all timers and warnings
				end
			end
		end
	end
end
