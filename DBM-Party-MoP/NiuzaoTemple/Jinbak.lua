local mod	= DBM:NewMod(693, "DBM-Party-MoP", 6, 324)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7464 $"):sub(12, -3))
mod:SetCreatureID(61567)
mod:SetModelID(43197)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_SUCCESS"
)


local warnDetonate			= mod:NewSpellAnnounce(120001, 3)

local specWarnSapResidue	= mod:NewSpecialWarningStack(119941, true, 8)
local specWarnDetonate		= mod:NewSpecialWarningSpell(120001, mod:IsHealer(), nil, nil, true)
local specWarnGlob			= mod:NewSpecialWarningSwitch("ej6494", not mod:IsHealer())

local timerDetonateCD		= mod:NewNextTimer(45.5, 120001)
local timerDetonate			= mod:NewCastTimer(5, 120001)
local timerSapResidue		= mod:NewBuffFadesTimer(10, 119941)

function mod:OnCombatStart(delay)
	timerDetonateCD:Start(30-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(119941) and args:IsPlayer() then
		timerSapResidue:Start()
		if (args.amount or 1) >= 8 and self:AntiSpam() then
			specWarnSapResidue:Show(args.amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(120001) then
		warnDetonate:Show()
		specWarnDetonate:Show()
		specWarnGlob:Show()
		timerDetonate:Start()
		timerDetonateCD:Start()
	end
end
