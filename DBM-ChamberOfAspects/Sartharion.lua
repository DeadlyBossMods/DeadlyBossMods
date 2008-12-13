local mod = DBM:NewMod("Sartharion", "DBM-ChamberOfAspects")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28860)
mod:SetZone()

mod:RegisterCombat("combat")

mod:SetBossHealthInfo(
	28860, "Sartharion",
	30452, "Tenebron",
	30451, "Shadron",
	30449, "Vesperon"
)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_EMOTE"
)

mod:AddBoolOption("PlaySoundOnFireWall", true, "announce")
mod:AddBoolOption("AnnounceFails", true, "announce")

local timerTenebron	= mod:NewTimer(30, "TimerTenebron")
local timerShadron	= mod:NewTimer(80, "TimerShadron")
local timerVesperon	= mod:NewTimer(120, "TimerVesperon")

local warnTenebron	= mod:NewAnnounce("WarningTenebron", 2, nil, false)
local warnShadron	= mod:NewAnnounce("WarningShadron", 2, nil, false)
local warnVesperon	= mod:NewAnnounce("WarningVesperon", 2, nil, false)

local warnFireWall			= mod:NewSpecialWarning("WarningFireWall")
local warnVesperonPortal	= mod:NewSpecialWarning("WarningVesperonPortal", false)
local warnTenebronPortal	= mod:NewSpecialWarning("WarningTenebronPortal", false)
local warnShadronPortal		= mod:NewSpecialWarning("WarningShadronPortal", false)

local timerWall         = mod:NewTimer(30, "TimerWall", 43113)  

local lastvoids = {}
local lastfire = {}

function mod:OnSync(event)
	if event == "FireWall" then
		timerWall:Start()
		warnFireWall:Show()
		
		if self.Options.PlaySoundOnFireWall then
			PlaySoundFile("Sound\\Spells\\PVPFlagTaken.wav")
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end

	elseif event == "VesperonPortal" then
		warnVesperonPortal:Show()

	elseif event == "TenebronPortal" then
		warnTenebronPortal:Show()

	elseif event == "ShadronPortal" then
		warnShadronPortal:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, mob)
	if not self:IsInCombat() then return end
	if msg == L.Wall then
		self:SendSync("FireWall")
	elseif msg == L.Portal then
		if mob == L.NameVesperon then
			self:SendSync("VesperonPortal")
		elseif mob == L.NameTenebron then
			self:SendSync("TenebronPortal")
		elseif mob == L.NameShadron then
			self:SendSync("ShadronPortal")
		end
	end
end

mod.CHAT_MSG_MONSTER_EMOTE = mod.CHAT_MSG_RAID_BOSS_EMOTE

function mod:OnCombatStart(delay)
	timerTenebron:Start()
	timerShadron:Start()
	timerVesperon:Start()

	warnTenebron:Schedule(25)
	warnShadron:Schedule(70)
	warnVesperon:Schedule(115)

	table.wipe(lastvoids)
	table.wipe(lastfire)
end


local sortedFails = {}
local function sortFails1(e1, e2)
	return (lastvoids[e1] or 0) > (lastvoids[e2] or 0)
end
local function sortFails2(e1, e2)
	return (lastfire[e1] or 0) > (lastfire[e2] or 0)
end

function mod:OnCombatEnd(wipe)	
	if not self.Options.AnnounceFails then return end

	local voids = ""
	for k, v in pairs(lastvoids) do
		table.insert(sortedFails, k)
	end
	table.sort(sortedFails, sortFails1)
	for i, v in ipairs(sortedFails) do
		voids = voids.." "..v.."("..(lastvoids[v] or "")..")"
	end
	SendChatMessage(L.VoidZones:format(voids), "RAID")
	table.wipe(sortedFails)
	
	local fire = ""
	for k, v in pairs(lastfire) do
		table.insert(sortedFails, k)
	end
	table.sort(sortedFails, sortFails2)
	for i, v in ipairs(sortedFails) do
		fire = fire.." "..v.."("..(lastfire[v] or "")..")"
	end
	SendChatMessage(L.FireWalls:format(fire), "RAID")
	table.wipe(sortedFails)
end

function mod:SPELL_AURA_APPLIED(args)
	if not self:IsInCombat() then return end
	if self.Options.AnnounceFails and args.spellId == 57491 and DBM:GetRaidUnitId(args.destName) ~= "none" and args.destName then
		lastfire[args.destName] = (lastfire[args.destName] or 0) + 1
		SendChatMessage(L.FireWallOn:format(args.destName), "RAID")
	end
end

function mod:SPELL_DAMAGE(args)
	if self.Options.AnnounceFails and args.spellId == 59128 and DBM:GetRaidUnitId(args.destName) ~= "none" and args.destName then
		lastvoids[args.destName] = (lastvoids[args.destName] or 0) + 1
		SendChatMessage(L.VoidZoneOn:format(args.destName), "RAID")
	end	
end


