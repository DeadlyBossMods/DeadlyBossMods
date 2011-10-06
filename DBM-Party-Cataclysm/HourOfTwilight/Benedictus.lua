local mod	= DBM:NewMod("Benedictus", "DBM-Party-Cataclysm", 14)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(54938)
mod:SetModelID(38991)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"UNIT_HEALTH"
)

local warnRighteousShear	= mod:NewSpellAnnounce(103151, 2)
local warnPurifyingLight	= mod:NewSpellAnnounce(103565, 3)
local warnWaveVirtue		= mod:NewSpellAnnounce(103681, 4, nil, false)	-- blizzard warning
local prewarnP2			= mod:NewPrePhaseAnnounce(2, 2)
local warnTwilightShear		= mod:NewSpellAnnounce(103363, 2)
local warnCorruptingTwilight	= mod:NewSpellAnnounce(103767, 3)
local warnWaveTwilight		= mod:NewSpellAnnounce(103784, 4, nil, false)	-- blizzard warning
-- warn actual 'phase' change?  (Twilight Epiphany (ID = 103754))


local specwarnPurified	= mod:NewSpecialWarningMove(103653)
local specwarnTwilight	= mod:NewSpecialWarningMove(103775)

local warnedP2 = false
local spamDamage = 0	-- used for both Special Warnings

function mod:OnCombatStart(delay)
	warnedP2 = false
	spamDamage = 0
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(103151) then
		warnRighteousShear:Show()
	elseif args:IsSpellID(103565) then
		warnPurifyingLight:Show()
	elseif args:IsSpellID(103681) then
		warnWaveVirtue:Show()
	elseif args:IsSpellID(103363) then
		warnTwilightShear:Show()
	elseif args:IsSpellID(103767) then
		warnCorruptingTwilight:Show()
	elseif args:IsSpellID(103784) then
		warnWaveTwilight:Show()
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
	-- 1st Wave Of Virtue after [?? or 24] secs 

-- "Shadow" timers:  X secs after SPELL_AURA_APPLIED event for Twilight Epiphany
	-- 1st Twilight Shear after [15 or 12] secs
	-- 1st Corrupting Twilight after [17 or 17] secs
	-- 1st Wave of Twilight after [37 or 36] secs
