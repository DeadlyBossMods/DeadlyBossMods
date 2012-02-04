local mod	= DBM:NewMod("HighProphetBarim", "DBM-Party-Cataclysm", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43612)
mod:SetModelID(34744)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
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
local specWarnHallowedGround = mod:NewSpecialWarningMove(88814)

mod:AddBoolOption("BossHealthAdds")

local spamSIS = 0

function mod:OnCombatStart(delay)
	spamSIS = 0
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
		spamSIS = GetTime()
		if self.Options.BossHealthAdds then
			DBM.BossHealth:AddBoss(43927, L.HarbringerDarkness)
			DBM.BossHealth:RemoveBoss(48906)
		end
	elseif args:IsSpellID(82255) then
		warnSoulSever:Show(args.destName)
		timerSoulSever:Start(args.destName)
		timerSoulSeverCD:Start()
	elseif args:IsSpellID(88814, 90010) and args:IsPlayer() and GetTime() - spamSIS > 5.5 then
		spamSIS = GetTime()
		specWarnHallowedGround:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(82622, 89997) then
		timerPlagueAges:Cancel(args.destName)
	elseif args:IsSpellID(82506) then
		timerLashings:Cancel(args.destName)
	end
end

function mod:SPELL_DAMAGE(sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlag, spellId)
	if (spellId == 81942 or spellId == 90040) and destName == UnitName("player") and GetTime() - spamSIS > 3 then
		spamSIS = GetTime()
		specWarnHeavenFury:Show()
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 43927 and mod.Options.BossHealthAdds then
		DBM.BossHealth:RemoveBoss(43927)
		DBM.BossHealth:AddBoss(48906, L.BlazeHeavens)
	end
end
		