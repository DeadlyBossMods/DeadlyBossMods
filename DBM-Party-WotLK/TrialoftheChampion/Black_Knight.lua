local mod = DBM:NewMod("BlackKnight", "DBM-Party-WotLK", 13)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 559 $"):sub(12, -3))
mod:SetCreatureID(35451)
--mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE"
)

local warnExplode	= mod:NewAnnounce("warnExplode")
local warnGhoulExplode	= mod:NewTargetAnnounce(67751)
local warnMarked	= mod:NewTargetAnnounce(67823)
local timerMarked			= mod:NewTargetTimer(10, 67823)
local specWarnDesecration		= mod:NewSpecialWarning("specWarnDesecration")

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(67729, 67886) then							-- Explode (elite explodes self, not BK. Phase 2)
		warnExplode:Show(args.spellName)
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(67781, 67876) and args:IsPlayer() then							-- Desecration, MOVE!
		specWarnDesecration:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(67823, 67882) then							-- Marked For Death
		warnMarked:Show(args.destName)
		timerMarked:Show(args.destName)
	elseif args:IsSpellID(67751) then							-- Ghoul Explode (BK exlodes Army of the dead. Phase 3)
		warnGhoulExplode:Show(args.destName)
	end
end