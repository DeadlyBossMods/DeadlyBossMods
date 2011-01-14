local mod	= DBM:NewMod("Lockmaw", "DBM-Party-Cataclysm", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43614)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS"
)

local warnScentBlood	= mod:NewTargetAnnounce(81690, 3)
local warnPoison	= mod:NewTargetAnnounce(81630, 3)
local warnDustFlail	= mod:NewSpellAnnounce(81642, 3)
local warnEnrage	= mod:NewSpellAnnounce(81706, 4)

local timerScentBlood	= mod:NewTargetTimer(30, 81690)
local timerPoison	= mod:NewTargetTimer(12, 81642)
local timerDustFlail	= mod:NewBuffActiveTimer(5, 81642)

mod:AddBoolOption("RangeFrame")

function mod:OnCombatStart(delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(81690, 89998) then
		warnScentBlood:Show(args.destName)
		timerScentBlood:Start(args.destName)
	elseif args:IsSpellID(81630, 90004) then
		warnPoison:Show(args.destName)
		timerPoison:Start(args.destName)
	elseif args:IsSpellID(81706) then
		warnEnrage:Show()
	end
end

mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(81690, 89998) then
		timerScentBlood:Cancel(args.destName)
	elseif args:IsSpellID(81630, 90004) then
		timerPoison:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(81642) then
		warnDustFlail:Show()
		timerDustFlail:Start()
	end
end