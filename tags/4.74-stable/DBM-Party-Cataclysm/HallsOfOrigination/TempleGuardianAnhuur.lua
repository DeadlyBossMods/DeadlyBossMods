local mod	= DBM:NewMod("TempleGuardianAnhuur", "DBM-Party-Cataclysm", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39425)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
	"UNIT_HEALTH"
)

local warnShield	= mod:NewSpellAnnounce(74938, 3)
local warnShieldSoon	= mod:NewSoonAnnounce(74938, 2)
local warnReckoning	= mod:NewTargetAnnounce(75592, 4)

local timerReckoning	= mod:NewTargetTimer(8, 75992)

local specWarnLight	= mod:NewSpecialWarningMove(75117)

-- Divine Reckoning .. icon ? .. arrow ?


local prewarnShield = false
local spamLight = 0
function mod:OnCombatStart(delay)
	prewarnShield = false
	spamLight = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(74938) then
		warnShield:Show()
	elseif args:IsSpellID(75592) then
		warnReckoning:Show(args.destName)
		timerReckoning:Start(args.destName)
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(75117, 94951) and GetTime() - spamLight > 5 and args:IsPlayer() then
		specWarnLight:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitName(uId) == L.name then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if not prewarnShield and (h < 75 and h > 70 or h < 41 and h < 36) then
			prewarnShield = true
			warnShieldSoon:Show()
		elseif prewarnShield and (h > 80 or h < 60 and h > 45) then
			prewarnShield = false
		end
	end
end
		