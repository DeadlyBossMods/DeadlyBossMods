local mod	= DBM:NewMod("Ozruk", "DBM-Party-Cataclysm", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(42188)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"UNIT_HEALTH"
)

local warnSpikeBarrage		= mod:NewSoonAnnounce(78807, 2)
local warnBulwark		= mod:NewSpellAnnounce(78939, 3)
local warnGroundSlam		= mod:NewCastAnnounce(78903, 4)
local warnEnrage		= mod:NewSpellAnnounce(80467, 3)
local warnEnrageSoon		= mod:NewSoonAnnounce(80467, 2)

local timerSpikeBarrage		= mod:NewCDTimer(19, 78807)
local timerBulwark		= mod:NewBuffActiveTimer(10, 78939)
local timerBulwarkCD		= mod:NewCDTimer(22, 78939)
local timerGroundSlam		= mod:NewCastTimer(3, 78903)
local timerGroundSlamCD		= mod:NewCDTimer(12, 78903)

local specWarnGroundSlam	= mod:NewSpecialWarningCast(78903, nil) --mod:IsMelee())

local prewarnEnrage

-- Spike Barrage CD shortened when enraged ??

function mod:OnCombatStart(delay)
	prewarnEnrage = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(80467) then
		warnEnrage:Show()
	elseif args:IsSpellID(78939) then
		warnBulwark:Show()
		timerBulwark:Start()
		timerBulwarkCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(78807) then
		warnSpikeBarrage:Schedule(15)
		timerSpikeBarrage:Start()
	elseif args:IsSpellID(78903) then
		warnGroundSlam:Show()
		specWarnGroundSlam:Show()
		timerGroundSlam:Start()
		timerGroundSlamCD:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitName(uId) == L.name then
		local h = UnitHealth(uId) / UnitHealthMax(uId)
		if h > 75 and prewarnEnrage then
			prewarnEnrage = false
		elseif h > 33 and h < 37 and not prewarnEnrage then
			warnEnrageSoon:Show()
			prewarnEnrage = true
		end
	end
end