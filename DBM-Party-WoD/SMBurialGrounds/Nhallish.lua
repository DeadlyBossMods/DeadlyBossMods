local mod	= DBM:NewMod(1168, "DBM-Party-WoD", 6, 537)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(75829)
mod:SetEncounterID(1688)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 152801",
	"SPELL_AURA_APPLIED 152979 153067",
	"SPELL_AURA_REMOVED 152979"
)

local warnVoidVortex			= mod:NewSpellAnnounce(152801, 3)
local warnSoulShred				= mod:NewSpellAnnounce(152979, 3)
local warnVoidDevastation		= mod:NewSpellAnnounce(153067, 4)

local specWarnSoulShred			= mod:NewSpecialWarningSpell(152979)
local specWarnVoidDevastation	= mod:NewSpecialWarningSpell(153067, nil, nil, nil, 2)

local timerVoidVortexCD			= mod:NewNextTimer(72, 152801)
local timerSoulShredCD			= mod:NewNextTimer(71, 152979)
local timerSoulShred			= mod:NewBuffFadesTimer(20, 152979)
local timerVoidDevastationCD	= mod:NewNextTimer(71, 153067)

function mod:OnCombatStart(delay)
	timerVoidVortexCD:Start(23-delay)
	timerSoulShredCD:Start(35-delay)
	timerVoidDevastationCD:Start(65.5-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 152801 then
		warnVoidVortex:Show()
		timerVoidVortexCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 152979 and self:AntiSpam() then--SPELL_CAST_SUCCESS is usually missing so have to scan for debuffs
		warnSoulShred:Show()
		specWarnSoulShred:Show()
		timerSoulShredCD:Start()
		timerSoulShred:Start()
	elseif spellId == 153067 then--SPELL_CAST_SUCCESS is usually missing so have to scan for debuffs
		warnVoidDevastation:Show()
		specWarnVoidDevastation:Show()
		timerVoidDevastationCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if spellId == 152979 and args:IsPlayer() then
		timerSoulShred:Cancel()
	end
end