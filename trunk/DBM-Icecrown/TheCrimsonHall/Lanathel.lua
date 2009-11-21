local mod	= DBM:NewMod("Lanathel", "DBM-Icecrown", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
mod:SetCreatureID(37955)
--mod:SetUsedIcons(3, 4, 5, 6, 7, 8)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warnPactDarkfallen	= mod:NewTargetAnnounce(71340, 3)

local timerPactDarkfallen	= mod:NewNextTimer(30, 71340)

local specWarnPactDarkfallen	= mod:NewSpecialWarning("SpecWarnPactDarkfallen")

local pactTargets = {}

function mod:warnPactTargets()
	warnPactDarkfallen:Show(table.concat(pactTargets, "<, >"))
	table.wipe(pactTargets)
	timerPactDarkfallen:Start(30)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(71340) then
		self:UnscheduleMethod("warnPactTargets")
		pactTargets[#pactTargets + 1] = args.destName
		self:ScheduleMethod(0.3, "warnPactTargets")
		if args:IsPlayer() then
			specWarnPactDarkfallen:Show()
		end
	end
end