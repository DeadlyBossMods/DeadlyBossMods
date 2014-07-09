local mod	= DBM:NewMod(888, "DBM-Party-WoD", 2, 385)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(74787)
mod:SetEncounterID(1653)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 150751",
	"SPELL_CAST_START 150759 150801 153679 150753"
)

local warnFerociousYell			= mod:NewCastAnnounce(150759, 2)
local warnRaiseMiners			= mod:NewSpellAnnounce(150801, 2, nil, mod:IsTank())
local warnCrushingLeap			= mod:NewTargetAnnounce(150751, 3)
local warnEarthCrush			= mod:NewTargetAnnounce(153679, 3)--target scanning assumed, TODO: Verify it!
local warnWildSlam				= mod:NewTargetAnnounce(150753, 3, nil, mod:IsMelee())

local specWarnFerociousYell		= mod:NewSpecialWarningInterrupt(150759, not mod:IsHealer())
local specWarnRaiseMiners		= mod:NewSpecialWarningSwitch(150801, mod:IsTank())
local specWarnCrushingLeap		= mod:NewSpecialWarningTarget(150751, false)
local specWarnEarthCrush		= mod:NewSpecialWarningYou(153679)
local yellEarthCrush			= mod:NewYell(153679)
local specWarnWildSlam			= mod:NewSpecialWarningRun(150753, mod:IsMelee())

--In logs he didn't have any consistent timings, they were all wildly variable, no useful timers

function mod:EarthCrushTarget(targetname, uId)
	if not targetname then return end
	warnEarthCrush:Show(targetname)
	if targetname == UnitName("player") then
		specWarnEarthCrush:Show()
		yellEarthCrush:Yell()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 150751 then
		warnCrushingLeap:Show(args.destName)
		specWarnCrushingLeap:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 150759 then
		warnFerociousYell:Show()
		specWarnFerociousYell:Show(args.sourceName)
	elseif spellId == 150801 then
		warnRaiseMiners:Show()
		specWarnRaiseMiners:Show()
	elseif spellId == 153679 then
		self:BossTargetScanner(74787, "EarthCrushTarget", 0.1, 12)--Adjust timing if not reliable
	elseif spellId == 150753 then
		warnWildSlam:Show()
		specWarnWildSlam:Show()
	end
end
