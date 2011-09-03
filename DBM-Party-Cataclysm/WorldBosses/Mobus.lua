local mod	= DBM:NewMod("Mobus", "DBM-Party-Cataclysm", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(50009)
mod:SetModelID(37338)
--mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warnRam				= mod:NewCastAnnounce(93492, 3)
local warnWake				= mod:NewCastAnnounce(93494, 2)

local specWarnRam			= mod:NewSpecialWarningMove(93492, mod:IsTank())
local specWarnWake			= mod:NewSpecialWarningMove(93494, mod:IsMelee() and not mod:IsTank())
local specWarnAlgae			= mod:NewSpecialWarningMove(93490)

--local timerRamCD			= mod:NewNextTimer(28.5, 93492)
--local timerWakeCD			= mod:NewNextTimer(28.5, 93494)

function mod:OnCombatStart(delay)
	--timerRamCD:Start(-delay)
	--timerWakeCD:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93492) then
		warnRam:Show()
		specWarnRam:Show()
--		timerRamCD:Start()
	elseif args:IsSpellID(93494) then
		warnWake:Show()
		specWarnWake:Show()
--		timerRamCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)--Assumed spell event, might need to use spell damage, or spell periodic damage instead.
	if args:IsSpellID(93490) and args:IsPlayer() then
		specWarnAlgae:Show()
	end
end
