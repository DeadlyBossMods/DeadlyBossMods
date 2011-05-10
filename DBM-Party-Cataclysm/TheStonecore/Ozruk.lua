local mod	= DBM:NewMod("Ozruk", "DBM-Party-Cataclysm", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(42188)
mod:SetModelID(36475)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_HEALTH"
)

local warnShatterSoon		= mod:NewSoonAnnounce(92662, 3)
local warnShatter			= mod:NewSpellAnnounce(92662, 4)
local warnBulwark			= mod:NewSpellAnnounce(92659, 3)
local warnGroundSlam		= mod:NewCastAnnounce(92410, 4)
local warnEnrage			= mod:NewSpellAnnounce(80467, 3)
local warnEnrageSoon		= mod:NewSoonAnnounce(80467, 2)
local warnGroundSlam		= mod:NewCastAnnounce(92410, 4)

local specWarnGroundSlam	= mod:NewSpecialWarningMove(92410, mod:IsTank())
local specWarnShatter		= mod:NewSpecialWarningRun(92662, mod:IsMelee())

--local timerShatterCD		= mod:NewCDTimer(19, 92662)
local timerBulwark			= mod:NewBuffActiveTimer(10, 92659)
local timerBulwarkCD		= mod:NewCDTimer(20, 92659)
local timerGroundSlam		= mod:NewCastTimer(3, 92410)
local timerShatter			= mod:NewCastTimer(3, 92662)

local soundShatter			= mod:NewSound(92662, nil, mod:IsMelee())

local prewarnEnrage = false

function mod:OnCombatStart(delay)
	prewarnEnrage = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(80467) then
		warnEnrage:Show()
	elseif args:IsSpellID(78939, 92659) then
		warnBulwark:Show()
		timerBulwark:Start()
		timerBulwarkCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(78939, 92659) then--This can be dispelled.
		timerBulwark:Cancel()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(78807, 92662) then
		warnShatter:Show()
		timerShatter:Start()
--		timerShatterCD:Start()
		specWarnShatter:Show()
		soundShatter:Play()
	elseif args:IsSpellID(92426) then
		warnShatterSoon:Show()
	elseif args:IsSpellID(78903, 92410) then
		warnGroundSlam:Show()
		specWarnGroundSlam:Show()
		timerGroundSlam:Start()
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