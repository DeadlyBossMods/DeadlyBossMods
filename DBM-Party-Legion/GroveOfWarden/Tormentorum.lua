local mod	= DBM:NewMod(1695, "DBM-Party-Legion", 10, 707)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(96015)
mod:SetEncounterID(1850)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 201488 200898",
	"SPELL_CAST_SUCCESS 200905",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnTeleport				= mod:NewSpellAnnounce(200898, 2)

local specWarnSapSoul			= mod:NewSpecialWarningInterrupt(200905, nil, nil, nil, 1, 2)
local specWarnFear				= mod:NewSpecialWarningSpell(201488, nil, nil, nil, 2)

local timerSapSoulCD			= mod:NewNextTimer(21.5, 200905, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)

local voiceSapSoul				= mod:NewVoice(200905)--Kickcast

function mod:OnCombatStart(delay)
	timerSapSoulCD:Start(10-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 201488 then
		specWarnFear:Show()
	elseif spellId == 200898 then
		warnTeleport:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 200905 then
		specWarnSapSoul:Show(args.sourceName)
		voiceSapSoul:Play("kickcast")
		timerSapSoulCD:Start()
	end
end
