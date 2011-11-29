local mod	= DBM:NewMod("Benedictus", "DBM-Party-Cataclysm", 14)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(54938)
mod:SetModelID(38991)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
	"UNIT_HEALTH"
)

local warnRighteousShear		= mod:NewTargetAnnounce(103151, 2)
local warnPurifyingLight		= mod:NewSpellAnnounce(103565, 3)
local warnWaveVirtue			= mod:NewSpellAnnounce(103678, 4, nil, false)	-- blizzard warning
local prewarnPhase2			= mod:NewPrePhaseAnnounce(2, 2)
local warnTwilightShear			= mod:NewTargetAnnounce(103363, 2)
local warnCorruptingTwilight	= mod:NewSpellAnnounce(103767, 3)
local warnWaveTwilight			= mod:NewSpellAnnounce(103780, 4, nil, false)	-- blizzard warning

local specwarnPurified			= mod:NewSpecialWarningMove(103653)
local specwarnWaveVirtue		= mod:NewSpecialWarningSpell(103678, nil, nil, nil, true)
local specwarnTwilight			= mod:NewSpecialWarningMove(103775)
local specwarnWaveTwilight		= mod:NewSpecialWarningSpell(103780, nil, nil, nil, true)

local timerWaveVirtueCD			= mod:NewNextTimer(30, 103678)--Will he do it more then once? if you are terrible and take > 30 sec to push him?
local timerWaveTwilightCD		= mod:NewNextTimer(30, 103780)--^

local warnedP2 = false
local spamDamage = 0	-- used for both Special Warnings

function mod:OnCombatStart(delay)
	warnedP2 = false
	spamDamage = 0
	timerWaveVirtueCD:Start(-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(103151) then
		warnRighteousShear:Show()
	elseif args:IsSpellID(103565) then
		warnPurifyingLight:Show()
	elseif args:IsSpellID(103677, 103680, 103681) then--Spellids are locationsal. So figure out which one is switch could announce wave direction?
		warnWaveVirtue:Show()
		specwarnWaveVirtue:Show()
	elseif args:IsSpellID(103363) then
		warnTwilightShear:Show()
	elseif args:IsSpellID(103767) then
		warnCorruptingTwilight:Show()
	elseif args:IsSpellID(103782, 103783, 103784) then--Same as virtue
		warnWaveTwilight:Show()
		specwarnWaveTwilight:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(103151) then
		warnRighteousShear:Show(args.destName)
	elseif args:IsSpellID(103363) then
		warnTwilightShear:Show(args.destName)
	elseif args:IsSpellID(103754) then--Phase change from holy to shadow.
		timerWaveVirtueCD:Cancel()--Cancel this timer if he was pushed before he got to do it, which is entirely possible.
		timerWaveTwilightCD:Start(35)--Is this cast more then once?
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(103653) and args:IsPlayer() and GetTime() - spamDamage > 5 then
		specwarnPurified:Show()
		spamDamage = GetTime()
	elseif args:IsSpellID(103775) and args:IsPlayer() and GetTime() - spamDamage > 5 then
		specwarnTwilight:Show()
		spamDamage = GetTime()
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 54938 then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 80 and warnedP2 then
			warnedP2 = false
		elseif not warnedP2 and h > 63 and h < 67 then
			warnedP2 = true
			prewarnPhase2:Show()
		end
	end
end

--: 14:05:48.764

-- Timers from 2 logs so they most likely are incorrect :)  (?? = unknown, didnt happen)
-- "Holy" timers: X secs after combat start
	-- 1st Purifying Light after [4 or 5] secs

-- "Shadow" timers:  X secs after SPELL_AURA_APPLIED event for Twilight Epiphany
	-- 1st Twilight Shear after [15 or 12] secs
	-- 1st Corrupting Twilight after [17 or 17] secs
