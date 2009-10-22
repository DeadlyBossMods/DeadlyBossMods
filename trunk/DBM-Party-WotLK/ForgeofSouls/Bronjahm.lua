local mod = DBM:NewMod("Bronjahm", "DBM-Party-WotLK", 14)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1728 $"):sub(12, -3))
mod:SetCreatureID(36497)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local timerNextSoulstorm	= mod:NewNextTimer(30, 68872) --Experimental, Timer may not be right
local warnCorruptSoul			= mod:NewTargetAnnounce(68839)
local specwarnSoulstorm		= mod:NewSpecialWarning("specwarnSoulstorm")
local timerSoulstorm				= mod:NewBuffActiveTimer(12, 68872)

function mod:OnCombatStart(delay)
timerNextSoulstorm:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(68839) then							-- Corrupt Soul
			warnCorruptSoul:Show(args.destName)
	elseif args:IsSpellID(68872) then							-- Soulstorm
			specwarnSoulstorm:Show()
			timerSoulstorm:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(68872) then							-- Soulstorm
		timerNextSoulstorm:Start()
	end
end