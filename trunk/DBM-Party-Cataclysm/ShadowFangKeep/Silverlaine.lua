local mod	= DBM:NewMod("Silverlaine", "DBM-Party-Cataclysm", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(3887)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warnVeilShadow	= mod:NewTargetAnnounce(23224, 3)
local warnWorgenSpirit	= mod:NewSpellAnnounce(93857, 3)

local timerVeilShadow	= mod:NewTargetTimer(8, 23224)
local timerWorgenSpirit	= mod:NewCastTimer(2, 93857)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(23224) then
		warnVeilShadow:Show(args.destName)
		timerVeilShadow:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(23224) then
		timerVeilShadow:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93857) then
		warnWorgenSpirit:Show()
		timerWorgenSpirit:Start()
	end
end