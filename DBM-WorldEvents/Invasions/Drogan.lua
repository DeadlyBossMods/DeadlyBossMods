local mod	= DBM:NewMod("Drogan", "DBM-WorldEvents", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90841)
mod:SetZone(1159, 1331, 1158, 1153, 1152, 1330)--4 of these not needed, but don't know what's what ATM

mod:RegisterCombat("combat")
mod:SetMinCombatTime(15)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 180882",
	"SPELL_AURA_APPLIED 180880"
)

local warnWhirlingAxe			= mod:NewTargetAnnounce(180882, 3)
local warnChainGrasp			= mod:NewTargetAnnounce(180880, 3)

local specWarnWhirlingAxe		= mod:NewSpecialWarningYou(180882)
local yellWhirlingAxe			= mod:NewYell(180882)
local specWarnChainGrasp		= mod:NewSpecialWarningYou(180880)--Persists for 30 seconds or until you get 30 yards from boss, whichever first.

local timerWhirlingAxeCD		= mod:NewCDTimer(25, 180882)

function mod:AxeTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnWhirlingAxe:Show()
		yellWhirlingAxe:Yell()
	else
		warnWhirlingAxe:Show(targetname)
	end
end

function mod:OnCombatStart(delay, summonTriggered)
	if summonTriggered then
		timerWhirlingAxeCD:Start(12.5)--Only one pull, small sample
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 180882 then
		timerWhirlingAxeCD:Start()
		self:BossTargetScanner(90841, "AxeTarget", 0.05, 16)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 180880 then
		if args:IsPlayer() then
			specWarnChainGrasp:Show()
		else
			warnChainGrasp:Show(args.destName)
		end
	end
end
