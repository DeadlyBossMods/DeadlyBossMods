local mod	= DBM:NewMod("Ashbury", "DBM-Party-Cataclysm", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(46962)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnPain				= mod:NewTargetAnnounce(93712, 3)
local warnWracking			= mod:NewSpellAnnounce(93720, 2)
local warnArchangel			= mod:NewSpellAnnounce(93757, 4)


local timerAsphyxiate		= mod:NewCDTimer(45, 93710)

function mod:OnCombatStart(delay)
	timerAsphyxiate:Start(18-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(93712) then
		warnPain:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93757) then
		warnArchangel:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(93710) then
		timerAsphyxiate:Start()
	elseif args:IsSpellID(93720) then
		warnWracking:Show()
	end
end