local mod	= DBM:NewMod("LadyFleshsear", "DBM-GarrisonInvasions")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91012)
mod:SetZone()

mod:RegisterCombat("combat")
mod:SetMinCombatTime(15)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 180779",
	"SPELL_CAST_SUCCESS 180774",
	"SPELL_AURA_APPLIED 180776",
	"SPELL_PERIODIC_DAMAGE 180775"
)

local warnRainofFire			= mod:NewSpellAnnounce(180774, 3)
local warnOverwhelmingFlames	= mod:NewTargetAnnounce(180776, 4)

local specWarnOverwhelmingFlames= mod:NewSpecialWarningMoveAway(180776, nil, nil, nil, 1, 2)
local yellOverwhelmingFlames	= mod:NewYell(180776)
local specWarnRainofFireGTFO	= mod:NewSpecialWarningMove(180775, nil, nil, nil, 1, 2)
local specWarnCallofFlame		= mod:NewSpecialWarningSpell(180779, nil, nil, nil, 2)--Don't really remember what this does to voice it right now

local voiceOverwhelmingFlames	= mod:NewVoice(180776)--runout
local voiceRainofFireGTFO		= mod:NewVoice(180775)--runaway

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 180779 then
		specWarnCallofFlame:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 180774 then
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
			voiceOverwhelmingFlames:Play("runout")
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 180775 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 1) then
		specWarnRainofFireGTFO:Show()
		voiceRainofFireGTFO:Play("runaway")
	end
end
