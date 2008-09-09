local mod = DBM:NewMod("Faerlina", "DBM-Naxx", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15953)
mod:SetZone(GetAddOnMetadata("DBM-Naxx", "X-DBM-Mod-LoadZone"))

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warnEmbraceActive		= mod:NewAnnounce("WarningEmbraceActive", 1, 28732)
local warnEmbraceExpire		= mod:NewAnnounce("WarningEmbraceExpire", 2, 28732)
local warnEmbraceExpired	= mod:NewAnnounce("WarningEmbraceExpired", 3, 28732)

local timerEmbrace			= mod:NewTimer(30, "TimerEmbrace", 28732)

local embraceSpam = 0
function mod:SPELL_CAST_SUCCESS(args)
	if (args.spellId == 28732				-- Widow's Embrace (10)
	or args.spellId == 54097)				-- Widow's Embrace (25)
	and (GetTime() - embraceSpam) > 5 then  -- This spell is casted twice in Naxx 25 (bug?)
		embraceSpam = GetTime()
		warnEmbraceExpire:Cancel()
		warnEmbraceExpired:Cancel()
		timerEmbrace:Start()
		warnEmbraceActive:Show()
		warnEmbraceExpire:Schedule(25)
		warnEmbraceExpired:Schedule(30)
	end
end
