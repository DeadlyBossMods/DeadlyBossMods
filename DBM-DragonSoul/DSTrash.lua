local mod	= DBM:NewMod("DSTrash", "DBM-DragonSoul")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetModelID(39378)
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL",
--	"CHAT_MSG_MONSTER_SAY",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnBoulder			= mod:NewTargetAnnounce(107597, 3)--This is morchok entryway trash that throws rocks at random poeple.
local warnDrakesLeft		= mod:NewAnnounce("DrakesLeft", 2, 61248)

local specWarnBoulder		= mod:NewSpecialWarningMove(107597)
local specWarnBoulderNear	= mod:NewSpecialWarningClose(107597)
local yellBoulder			= mod:NewYell(107597)
local specWarnFlames		= mod:NewSpecialWarningMove(105579)

--local timerEoE				= mod:NewCastTimer(80, 46811, nil, nil, nil, 84358)
local timerDrakes			= mod:NewTimer(253, "TimerDrakes", 61248)
--Leave this timer for now, I think this is the same.
--it still seems timed, just ends earlier if you kill 15 drakes.
--No one knew it ended at 24 drakes before hotfix because timer always expired before any raid hit 24, so we often just saw the hard capped event limit.
--I suspect some shitty LFR group is still gonna hit timer limit before 15 drakes, so we'll see

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local antiSpam = 0
--local syncTime = 0
local drakeRunning = false
local drakesCount = 15
local drakeguid = {}

local function drakeDied(GUID)
	if not drakeguid[GUID] then
		drakeguid[GUID] = true
		drakesCount = drakesCount - 1
		if drakesCount >= 0 then
			warnDrakesLeft:Show(drakesCount)
		end
		if drakesCount == 0 then
			mod:SendSync("SkyrimEnded")
		end
	end
end

function mod:BoulderTarget(sGUID)
	local targetname, realm = nil
	for i=1, GetNumRaidMembers() do
		if UnitGUID("raid"..i.."target") == sGUID then
			targetname, realm = UnitName("raid"..i.."targettarget")
			break
		end
	end
	if not targetname then return end
	if realm then targetname = targetname.."-"..realm end
	warnBoulder:Show(targetname)
	if targetname == UnitName("player") then
		specWarnBoulder:Show()
		yellBoulder:Yell()
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange < 6 then--Guessed, unknown, spelltip isn't informative.
				specWarnBoulderNear:Show(targetname)
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(107597) then -- Spell cast 3 sec. Seems to location sets before cast completion. I tested 2.5 and good worked.
		self:ScheduleMethod(2.5, "BoulderTarget", args.sourceGUID)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, _, _, _, overkill)
	if spellId == 105579 and destGUID == UnitGUID("player") and GetTime() - antiSpam >= 3 then
		specWarnFlames:Show()
		antiSpam = GetTime()
	elseif (overkill or 0) > 0 then -- prevent to waste cpu. only pharse cid when event have overkill parameter.
		local cid = self:GetCIDFromGUID(destGUID)
		if (cid == 56249 or cid == 56250 or cid == 56251 or cid == 56252 or cid == 57281 or cid == 57795) then--Hack for mobs that don't fire UNIT_DIED event.
			drakeDied(destGUID)
		end
	end
end
mod.SPELL_PERIODIC_DAMAGE = mod.SPELL_DAMAGE
mod.RANGE_DAMAGE = mod.SPELL_DAMAGE

function mod:SPELL_MISSED(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 105579 and destGUID == UnitGUID("player") and GetTime() - antiSpam >= 3 then
		specWarnFlames:Show()
		antiSpam = GetTime()
	end
end

--Very shitty performance way of doing it, but it's only way that works. they have about a 1/3 chance to NOT fire UNIT_DIED, sigh. But they do always fire an overkill. Confirmed in my logs.
function mod:SWING_DAMAGE(_, _, _, _, destGUID, _, _, _, _, overkill)
	if (overkill or 0) > 0 then -- prevent to waste cpu. only pharse cid when event have overkill parameter.
		local cid = self:GetCIDFromGUID(destGUID)
		if (cid == 56249 or cid == 56250 or cid == 56251 or cid == 56252 or cid == 57281 or cid == 57795) then--Hack for mobs that don't fire UNIT_DIED event.
			drakeDied(destGUID)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 56249 or cid == 56250 or cid == 56251 or cid == 56252 or cid == 57281 or cid == 57795 then
		drakeDied(args.destGUID)
	end
end

--	"<18.7> CHAT_MSG_MONSTER_YELL#It is good to see you again, Alexstrasza. I have been busy in my absence.#Deathwing###Notarget##0#0##0#3731##0#false", -- [1]
--	"<271.9> [UNIT_SPELLCAST_SUCCEEDED] Twilight Assaulter:Possible Target<nil>:target:Twilight Escape::0:109904", -- [11926]
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.UltraxionTrash or msg:find(L.UltraxionTrash) then
		if not drakeRunning then
			self:RegisterEventsPartly(
				"SPELL_DAMAGE",
				"SPELL_MISSED",
				"SWING_DAMAGE",
				"SPELL_PERIODIC_DAMAGE",
				"RANGE_DAMAGE",
				"UNIT_DIED"
			)
			drakeRunning = true
			print ("event registered")
		end
		table.wipe(drakeguid)
		drakesCount = 15--Reset drakes here still in case no one running current dbm is targeting thrall
		timerDrakes:Start(253, GetSpellInfo(109904))--^^
	-- timer still remains even combat starts. so, cancels manually. (Probably for someone who wasn't present for first drake dying.
	elseif msg == L.UltraxionTrashEnded or msg:find(L.UltraxionTrashEnded) then
		self:SendSync("SkyrimEnded")
	end
end

--[[
function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.EoEEvent or msg:find(L.EoEEvent) then
		self:SendSync("EoEPortal")--because SAY has a much smaller range then YELL, we sync it.
	end
end--]]

--	"<101.5> CHAT_MSG_MONSTER_YELL#It is good to see you again, Alexstrasza. I have been busy in my absence.#Deathwing###Vounelli##0#0##0#3093##0#false", -- [1]
--	"<133.3> [UNIT_SPELLCAST_SUCCEEDED] Thrall:Possible Target<nil>:target:Ward of Earth::0:108161", -- [875]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if spellName == GetSpellInfo(108161) then--Thrall starting drake event, comes much later then yell but is only event that triggers after a wipe to this trash.
		self:SendSync("Skyrim")
	elseif spellName == GetSpellInfo(109904) then
		self:SendSync("SkyrimEnded")
	end
end

function mod:OnSync(msg, GUID)
	if msg == "Skyrim" then
		if not drakeRunning then
			self:RegisterEventsPartly(
				"SPELL_DAMAGE",
				"SPELL_MISSED",
				"SWING_DAMAGE",
				"SPELL_PERIODIC_DAMAGE",
				"RANGE_DAMAGE",
				"UNIT_DIED"
			)
			drakeRunning = true
		end
		table.wipe(drakeguid)
		drakesCount = 15--Reset drakes here too soo they stay accurate after wipes.
		timerDrakes:Start(231, GetSpellInfo(109904))
	elseif msg == "SkyrimEnded" then
		drakeRunning = false
		self:UnregisterPartlyEvents()
		timerDrakes:Cancel()
--[[	elseif msg == "EoEPortal" and GetTime() - syncTime > 300 then -- Sometimes event starts already portal opened (timer expires). So ignore sync for 5 min. I hopefully fixed all problems from this method...
		syncTime = GetTime()
		timerEoE:Start()--]]
	end
end
