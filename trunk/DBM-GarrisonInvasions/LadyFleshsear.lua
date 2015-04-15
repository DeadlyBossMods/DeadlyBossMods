local mod	= DBM:NewMod("LadyFleshsear", "DBM-GarrisonInvasions")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91012)
mod:SetZone()

mod:RegisterCombat("combat")
mod:SetMinCombatTime(15)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 180779",
	"SPELL_CAST_SUCCESS 180776 180774",
	"SPELL_AURA_APPLIED 180776",
	"SPELL_PERIODIC_DAMAGE 180775"
)

local warnRainofFire			= mod:NewSpellAnnounce(180774, 3)
local warnOverwhelmingFlames	= mod:NewTargetAnnounce(180776, 4)

local specWarnOverwhelmingFlames= mod:NewSpecialWarningMoveAway(180776)
local yellOverwhelmingFlames	= mod:NewYell(180776)
local specWarnRainofFireGTFO	= mod:NewSpecialWarningMove(180775)
local specWarnCallofFlame		= mod:NewSpecialWarningSpell(180779, nil, nil, nil, 2)

local timerOverwhelmingFlamesCD	= mod:NewCDTimer(21, 180776)--21-32 Delays caused by Call of Flame/Rain of Fire
local timerRainofFireCD			= mod:NewCDTimer(23, 180774)--23-29 Delays caused by Call of Flame/Overwhelming Flames
local timerCallofFlameCD		= mod:NewCDTimer(37, 180774)--37-38 Priority spell

function mod:OnCombatStart(delay, summonTriggered)
	if summonTriggered then
		timerRainofFireCD:Start(11.5)
		timerOverwhelmingFlamesCD:Start(18)
		timerCallofFlameCD:Start(27)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 180779 then
		specWarnCallofFlame:Show()
		timerCallofFlameCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 180776 then
		timerOverwhelmingFlamesCD:Start()
	elseif spellId == 180774 then
		warnRainofFire:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 180776 then
		warnOverwhelmingFlames:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnOverwhelmingFlames:Show()
			yellOverwhelmingFlames:Yell()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 180775 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 1) then
		specWarnRainofFireGTFO:Show()
	end
end
