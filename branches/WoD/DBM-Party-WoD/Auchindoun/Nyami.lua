local mod	= DBM:NewMod(1186, "DBM-Party-WoD", 1, 547)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76177)
mod:SetEncounterID(1685)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 154477",
	"SPELL_CAST_START 155327 153994"
)


local warnSWP					= mod:NewTargetAnnounce(154477, 2, nil, mod:IsHealer())
local warnSoulVessel			= mod:NewSpellAnnounce(155327, 4)
local warnTornSpirits			= mod:NewSpellAnnounce(153991, 3)

local specWarnSWP				= mod:NewSpecialWarningDispel(154477, mod:IsHealer())
local specWarnSoulVessel		= mod:NewSpecialWarningSpell(155327, nil, nil, nil, 2)
local specWarnSoulVesselEnd		= mod:NewSpecialWarningEnd(155327)
local specWarnTornSpirits		= mod:NewSpecialWarningSwitch(153991, not mod:IsHealer())

local timerSoulVessel			= mod:NewBuffActiveTimer(11.5, 155327)
local timerSoulVesselCD			= mod:NewNextTimer(27, 155327)
local timerTornSpiritsCD		= mod:NewNextTimer(22.5, 153991)

function mod:OnCombatStart(delay)
	timerSoulVesselCD:Start(6-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 154477 then
		warnSWP:Show(args.destName)
		specWarnSWP:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 155327 then
		warnSoulVessel:Show()
		specWarnSoulVessel:Show()
		specWarnSoulVesselEnd:Schedule(11.5)
		timerSoulVessel:Start()
		timerTornSpiritsCD:Start()
		timerSoulVesselCD:Start()
	elseif spellId == 153994 then
		warnTornSpirits:Show()
		specWarnTornSpirits:Show()
	end
end
