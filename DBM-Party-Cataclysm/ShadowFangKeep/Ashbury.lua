local mod	= DBM:NewMod(96, "DBM-Party-Cataclysm", 6, 64)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(46962)
mod:SetModelID(34610)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnPain				= mod:NewTargetAnnounce(93581, 3)
local warnWracking			= mod:NewSpellAnnounce(93720, 2)
local warnArchangel			= mod:NewSpellAnnounce(93757, 4)


local timerAsphyxiate		= mod:NewCDTimer(45, 93423)

function mod:OnCombatStart(delay)
	timerAsphyxiate:Start(18-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(93581, 93712) then -- unconfirmed in mop
		warnPain:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93757) then
		warnArchangel:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(93423, 93710) then -- unconfirmed in mop
		timerAsphyxiate:Start()
	elseif args:IsSpellID(93720) then
		warnWracking:Show()
	end
end