local mod	= DBM:NewMod("Emalon", "DBM-PvP", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2524 $"):sub(12, -3))
mod:SetCreatureID(33993)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_HEAL",
	"UNIT_TARGET",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local specWarnNova			= mod:NewSpecialWarning("specWarnNova")
local warnNova				= mod:NewSpellAnnounce(65279, 3)
local warnOverCharge		= mod:NewSpellAnnounce(64218, 2)

local timerNova				= mod:NewCastTimer(65279)
local timerNovaCD			= mod:NewCDTimer(45, 65279)--Varies, 45-60seconds in between nova's
local timerOvercharge		= mod:NewNextTimer(45, 64218)
local timerMobOvercharge	= mod:NewTimer(20, "timerMobOvercharge", 64217)

local timerEmalonEnrage		= mod:NewTimer(360, "EmalonEnrage", 26662)

mod:AddBoolOption("NovaSound")
mod:AddBoolOption("RangeFrame")


local overchargedMob
function mod:OnCombatStart(delay)
	overchargedMob = nil
	timerOvercharge:Start(-delay)
	timerNovaCD:Start(20-delay)
	timerEmalonEnrage:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 64216 or args.spellId == 65279 then
		timerNova:Start()
		timerNovaCD:Start()
		warnNova:Show()
		specWarnNova:Show()
		if self.Options.NovaSound then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end

function mod:UNIT_TARGET()
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

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 64217 then	-- 1 of 10 stacks (+1 each 2 seconds)
		timerMobOvercharge:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 64217 then
		timerMobOvercharge:Stop()
	end
end

