local mod = DBM:NewMod("Freya", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))

mod:SetZone()

--mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warnSunBeam = mod:NewAnnounce("WarnUnstableSunBeam", 2, 62243)
local specWarnSunBeam = mod:NewSpecialWarning("SpecWarnUnstableSunBeam")
local timerSunBeam = mod:NewTimer(20, "TimerUnstableSunBeam", 62243)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62243 then -- unstable sun beam
		warnSunBeam:Show(args.destName)
		if args.destName == UnitName("player") then
			specWarnSunBeam:Show()
		end
		self:SetIcon(args.destName, 8, 21)
		timerSunBeam:Start(args.destName)
	end
end

