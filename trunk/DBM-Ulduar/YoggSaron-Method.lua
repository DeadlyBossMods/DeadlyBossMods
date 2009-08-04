local mod = DBM:NewMod("YoggSaronMethod", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1177 $"):sub(12, -3))
--mod:SetCreatureID(33288)
mod:SetZone()

--mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"UNIT_TARGET",
	"PLAYER_TARGET_CHANGED"
)

--[[
5/18 21:23:14.578  SPELL_CAST_SUCCESS,0xF15000820801C7D9,"Yogg-Saron",0xa48,0x0000000000000000,nil,0x80000000,64465,"Shadow Beacon",0x20
5/18 21:23:14.604  SPELL_AURA_APPLIED,0xF15000820801C7D9,"Yogg-Saron",0xa48,0xF13000 84C4 01D6F7,"Immortal Guardian",0xa48,64465,"Shadow Beacon",0x20,BUFF
5/18 21:23:14.604  SPELL_AURA_APPLIED,0xF15000820801C7D9,"Yogg-Saron",0xa48,0xF1300084C401D6A4,"Immortal Guardian",0xa48,64465,"Shadow Beacon",0x20,BUFF
5/18 21:23:14.604  SPELL_AURA_APPLIED,0xF15000820801C7D9,"Yogg-Saron",0xa48,0xF1300084C401D63F,"Immortal Guardian",0xa48,64465,"Shadow Beacon",0x20,BUFF
Mob ID:  33988
--]]

local mobtable = {}
local buffid = 8

local spellname = GetSpellInfo(64465)

function mod:OnCombatStart()
	table.wipe(mobtable)
	buffid = 8
end

do
	local function resetme()
		table.wipe(mobtable)
		while buffid <= 8 do
			SetRaidTarget("player", buffid)
			buffid = buffid + 1
		end
		buffid = 8
		DBM:Schedule(0.5, function() SetRaidTarget("player", 0); end)
	end
	function mod:SPELL_CAST_SUCCESS(args)
		if args.spellId == 64465 then
			self:Schedule(20, resetme)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 64465 then	-- initialcheck if someone allready has that target
		self:CheckAndSetIcon()
	end
end

function mod:CheckAndSetIcon()
	for i = 1, GetNumRaidMembers() do
		if self:GetUnitCreatureId("raid"..i.."target") == 33988 then
			self:CheckTarget("raid"..i.."target")
		end
		-- not else, because we allways want to check pets
		if self:GetUnitCreatureId("raidpet"..i.."target") == 33988 then
			self:CheckTarget("raidpet"..i.."target")
		end
	end
	if self:GetUnitCreatureId("playertarget") == 33988 then
		self:CheckTarget("playertarget")
	end
end
mod.PLAYER_TARGET_CHANGED = mod.CheckAndSetIcon
mod.UNIT_TARGET = mod.CheckAndSetIcon

function mod:CheckTarget(raidtarget)
	local uID = UnitGUID(raidtarget)
	if not uID then return end	-- uhm, whats that?

	if not mobtable[uID] and self:IsBuffed(raidtarget) then
		mobtable[uID] = true
		SetRaidTarget(raidtarget, buffid)
		buffid = buffid - 1
		if buffid < 1 then
			buffid = 8
		end
	end
end

function mod:IsBuffed(raidtarget)
	local i = 1
	local buffs, i = { }, 1
	local buff = UnitBuff(raidtarget, i)
	while buff do
		if spellname == buff then
			buffs[#buffs + 1] = buff
		end
		i = i + 1
		buff = UnitBuff(raidtarget, i)
	end
	
	if #buffs < 1 then 	return false
	else 			return true
	end	
end




