local mod	= DBM:NewMod("Rabbit", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(58336)
mod:SetModelID(328)
mod:SetZone()

mod:RegisterCombat("combat")
mod:SetWipeTime(180)--Not sure how to really handle the coprse cannoning this boss is. You pretty much die and run back repeatedly. Perhaps set this to infinite and end combat on zone change or death? or unit health reset on rabbit?

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warnTeeth				= mod:NewTargetAnnounce(114078, 4)

local yellTeeth				= mod:NewYell(114078)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 114078 then
		warnTeeth:Show(args.destName)
		if args:IsPlayer() then
			yellTeeth:Yell()
		end
	end
end
