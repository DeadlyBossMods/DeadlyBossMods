local mod	= DBM:NewMod("HighProphetBarim", "DBM-Party-Cataclysm", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43612)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"UNIT_DIED"
)

local warnPlagueAges		= mod:NewTargetAnnounce(82622, 3)
local warnLashings		= mod:NewTargetAnnounce(82506, 3)
local warnRepentance		= mod:NewSpellAnnounce(82320, 2)	-- kind of add phase
local warnSoulSever		= mod:NewTargetAnnounce(82255, 3)

local timerPlagueAges		= mod:NewTargetTimer(9, 82622)
local timerLashings		= mod:NewTargetTimer(20, 82506)
local timerSoulSever		= mod:NewTargetTimer(4, 82255)
local timerSoulSeverCD		= mod:NewCDTimer(11, 82255)

local specWarnHeavenFury	= mod:NewSpecialWarningMove(81942)

mod:AddBoolOption("BossHealthAdds")

local spamHeavenFury = 0
function mod:OnCombatStart(delay)
	spamHeavenFury = 0
	if mod.Options.BossHealthAdds then
		DBM.BossHealth:AddBoss(48906, L.BlazeHeavens)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(82622, 89997) then
		warnPlagueAges:Show(args.destName)
		timerPlagueAges:Start(args.destName)
	elseif args:IsSpellID(82506) then
		warnLashings:Show(args.destName)
		timerLashings:Start(args.destName)
	elseif args:IsSpellID(82320) and args.destName == L.name then
		warnRepentance:Show()
		if mod.Options.BossHealthAdds then
			DBM.BossHealth:AddBoss(43927, L.HarbringerDarkness)
			DBM.BossHealth:AddBoss(48906)
		end
	elseif args:IsSpellID(82255) then
		warnSoulSever:Show(args.destName)
		timerSoulSever:Start(args.destName)
		timerSoulSeverCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(82622, 89997) then
		timerPlagueAges:Cancel(args.destName)
	elseif args:IsSpellID(82506) then
		timerLashings:Cancel(args.destName)
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(81942, 90040) and args:IsPlayer() and GetTime() - spamHeavenFury > 5 then
		spamHeavenFury = GetTime()
		specWarnHeavenFury:Show()
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 43612 and mod.Options.BossHealthAdds then
		DBM.BossHealth:RemoveBoss(43927)
		DBM.BossHealth:AddBoss(48906, L.BlazeHeavens)
	end
end
		