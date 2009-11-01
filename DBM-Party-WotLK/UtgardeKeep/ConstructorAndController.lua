local mod = DBM:NewMod("ConstructorAndController", "DBM-Party-WotLK", 10)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(24201)
mod:SetZone()

mod:RegisterCombat("combat", 24000, 24201)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_SUMMON"
)

local warningEnfeeble	= mod:NewTargetAnnounce(43650, 2)
local warningSummon		= mod:NewSpellAnnounce(52611, 3)
local timerEnfeeble		= mod:NewTargetTimer(6, 43650)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(43650) then
		warningEnfeeble:Show(args.destName)
		timerEnfeeble:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(43650) then
		timerEnfeeble:Cancel(args.destName)
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(52611) and (args.GUID == 24201 or args.GUID == 24000) then
		warningSummon:Show()
	end
end