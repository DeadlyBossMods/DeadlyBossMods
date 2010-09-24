local mod	= DBM:NewMod("Asaad", "DBM-Party-Cataclysm", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision:$"):sub(12, -3))
mod:SetCreatureID(45878)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warnStaticCling	= mod:NewSpellAnnounce(87618, 3)

local timerStaticCling	= mod:NewBuffActiveTimer(19, 87618)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(87618) then
		warnStaticCling:Show()
		timerStaticCling:Start()	-- 1sec cast + 18sec duration
	end
end

-- Supremacy of the Storm ,, iirc this is cast AFTER the Grounding Field is created (86930)
