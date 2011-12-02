local mod	= DBM:NewMod("Perotharn", "DBM-Party-Cataclysm", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(55085)
mod:SetModelID(39182)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnFelFlames			= mod:NewTargetAnnounce(108141, 3)
local warnDecay				= mod:NewTargetAnnounce(105544, 3, nil, mod:IsHealer())
local warnFelQuickening		= mod:NewTargetAnnounce(104905, 3, nil, mod:IsHealer() or mod:IsTank())

local specWarnFelFlames		= mod:NewSpecialWarningMove(108141)

local timerFelFlamesCD		= mod:NewNextTimer(8.4, 108141)
local timerDecay			= mod:NewTargetTimer(10, 105544, nil, mod:IsHealer())
local timerDecayCD			= mod:NewNextTimer(17, 105544, nil, mod:IsHealer())
local timerFelQuickening	= mod:NewBuffActiveTimer(15, 104905, nil, mod:IsHealer() or mod:IsTank())

local function showFelFlamesWarning()
	local targetname = self:GetBossTarget(55085)
	if not targetname then return end
	warnFelFlames:Show(targetname)
	if targetname == UnitName("player") then
		specWarnFelFlames:Show()
	end
end

function mod:OnCombatStart(delay)
	timerFelFlamesCD:Start(5-delay)
	timerDecayCD:Start(8-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(108141) then
		timerFelFlamesCD:Start()
		self:Schedule(0.2, showFelFlamesWarning)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(104905) then
		self:SetWipeTime(30)--You leave combat briefly during this transition, we don't want the mod ending prematurely.
		timerFelFlamesCD:Start(39.5)
		timerDecayCD:Start(44)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(105544) then
		warnDecay:Show(args.destName)
		timerDecay:Start(args.destName)
		timerDecayCD:Start()
	elseif args:IsSpellID(105526) then
		warnFelQuickening:Show()
		timerFelQuickening:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(105544) then
		timerDecay:Cancel(args.destName)
	end
end