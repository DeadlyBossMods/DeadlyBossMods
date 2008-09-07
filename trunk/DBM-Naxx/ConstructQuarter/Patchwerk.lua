local mod = DBM:NewMod("Patchwerk", "DBM-Naxx", 2)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(16028)
mod:SetZone(GetAddOnMetadata("DBM-Naxx", "X-DBM-Mod-LoadZone"))

mod:RegisterCombat("yell", L.yell1, L.yell2)

mod:RegisterEvents(
	"SPELL_DAMAGE",
	"SPELL_MISSED"
)

mod:AddBoolOption("WarningHateful", false, "announce")
local enrageTimer = mod:NewEnrageTimer(420)

local function announceStrike(target, damage)
	SendChatMessage(L.HatefulStrike:format(target, damage), "RAID")
end

function mod:OnCombatStart(delay)
	enrageTimer:Start()
end

function mod:SPELL_DAMAGE(args)
	if args.spellId == 28308 and self.Options.WarningHateful and DBM:GetRaidRank() >= 1 then
		announceStrike(args.destName, args.amount or 0)
	end
end

function mod:SPELL_MISSED(args)
	if args.spellId == 28308 and self.Options.WarningHateful and DBM:GetRaidRank() >= 1 then
		announceStrike(args.destName, getglobal("ACTION_SPELL_MISSED_"..(args.missType)) or "")
	end	
end

