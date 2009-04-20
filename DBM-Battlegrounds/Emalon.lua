local mod = DBM:NewMod("Emalon", "DBM-Battlegrounds")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 155 $"):sub(12, -3))
mod:SetCreatureID(33993)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_HEAL",
	"RAID_TARGET_UPDATE"
)

mod:AddBoolOption("NovaSound")

local timerNova			= mod:NewCastTimer(64216)
local timerOvercharge	= mod:NewNextTimer(45, 64218)

local specWarnNova		= mod:NewSpecialWarning("specWarnNova")
local warnNova			= mod:NewAnnounce("warnNova", 3)
local warnOverCharge	= mod:NewAnnounce("warnOverCharge", 2)

local overchargedMob
function mod:OnCombatStart(delay)
	overchargedMob = nil
	timerOvercharge:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 64216 or args.spellId == 65279 then
		timerNova:Start()
		warnNova:Show()
		specWarnNova:Show()
		if self.Options.NovaSound then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end

function mod:RAID_TARGET_UPDATE(args)
	if overchargedMob then
		self:TrySetTarget(overchargedMob)
	end
end

function mod:TrySetTarget(target, icon)
	icon = icon or 8
	if DBM:GetRaidRank() >= 1 then
		local found = false
		for i = 1, GetNumRaidMembers() do
			if UnitGUID("raid"..i.."target") == target then
				found = true
				SetRaidTarget("raid"..i.."target", icon)
				break
			end
		end
		if found then
			overchargedMob = nil
		else
			overchargedMob = target
		end
	end
end

function mod:SPELL_HEAL(args)
	if args.spellId == 64218 then
		warnOverCharge:Show()
		timerOvercharge:Start()
		self:TrySetTarget(args.destGUID)
	end
end

