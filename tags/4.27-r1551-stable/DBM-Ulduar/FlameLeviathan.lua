local mod = DBM:NewMod("FlameLeviathan", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))

mod:SetCreatureID(33113)

--mod:RegisterCombat("combat")
mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_AURA_REMOVED",
	"SPELL_AURA_APPLIED",	
	"CHAT_MSG_RAID_BOSS_EMOTE"
)


local timerSystemOverload	= mod:NewBuffActiveTimer(20, 62475)
local timerFlameVents		= mod:NewCastTimer(10, 62396)
local timerPursued		= mod:NewTargetTimer(30, 62374)
local warnSystemOverload	= mod:NewSpecialWarning("SystemOverload")

local pursueSpecWarn		= mod:NewSpecialWarning("SpecialPursueWarnYou")
local pursueTargetWarn		= mod:NewAnnounce("PursueWarn", 2)
local warnNextPursueSoon	= mod:NewAnnounce("warnNextPursueSoon", 3)


--local stats = {}
local guids = {}
local function buildGuidTable()
	table.wipe(guids)
	for i = 1, GetNumRaidMembers() do
		guids[UnitGUID("raid"..i.."pet") or ""] = UnitName("raid"..i)
	end
end

function mod:OnCombatStart(delay)
	buildGuidTable()
--	table.wipe(stats)
end


function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62396 then		-- Flame Vents
		timerFlameVents:Start()

	elseif args.spellId == 62475 then	-- Systems Shutdown / Overload
		timerSystemOverload:Start()
		warnSystemOverload:Show()

	elseif args.spellId == 62374 then	-- Pursued
		local player = guids[args.destGUID]
		warnNextPursueSoon:Schedule(25)
		timerPursued:Start(player)
		pursueTargetWarn:Show(player)

		if player == UnitName("player") then
			pursueSpecWarn:Show()
		end
	end

end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 62396 then
		timerFlameVents:Stop()
	end
end

--[[
function mod:OnCombatEnd()
--	mod:PrintStats()
end

function mod:SPELL_CAST_SUCCESS(args)
	local player = guids[args.sourceGUID]
	if player and args.spellId == 62359 then
		if not stats[player] then
			stats[player] = {kills = 0, hits = 0, casts = 0, player = player}
		end
		stats[player].casts = stats[player].casts + 1
	end
end

function mod:SPELL_DAMAGE(args)
	local player = guids[args.sourceGUID]
--	print(args.destGUID, self:GetCIDFromGUID(args.destGUID), 33214, args.spellId, player)
	if player and args.spellId == 62363  and self:GetCIDFromGUID(args.destGUID) == 33214 then
		if not stats[player] then
			stats[player] = {kills = 0, hits = 0, casts = 0, player = player}
		end
		stats[player].hits = stats[player].hits + 1
		if args.overkill then
			stats[player].kills = stats[player].kills + 1
		end
	end
end

local sortedStats = {}
local function sort(v1, v2)
	return v1.kills > v2.kills
end

function mod:PrintStats()
	local i = 0
	for _, v in pairs(stats) do
		sortedStats[#sortedStats + 1] = v
		i = i + 1
		if i >= 3 then
			break
		end
	end
	table.sort(sortedStats, sort)
	for i, v in ipairs(sortedStats) do
		SendChatMessage(("%d. %s: %d kills (accuracy: %.2f%%)"):format(i, v.player, v.kills, math.max(math.min(v.casts / v.hits * 100, 100), 0), "RAID")
	end
	table.wipe(sortedStats)
end]]--


--[[
function mod:CHAT_MSG_RAID_BOSS_EMOTE(emote)
	local target = emote:match(L.Emote)
	if target then
		if target == UnitName("player") then
			pursueSpecWarn:Show()
		end
		pursueTargetWarn:Show(target)
	end
end
--]]




