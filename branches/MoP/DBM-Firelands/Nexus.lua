local mod	= DBM:NewMod("NexusLegendary", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision:$"):sub(12, -3))
mod:SetCreatureID(53472)
mod:SetModelID(32230)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnBreath				= mod:NewSpellAnnounce(99502, 4)
local specwarnBreath			= mod:NewSpecialWarningCast(99502)
local timerBreath				= mod:NewBuffActiveTimer(14, 99502)

local warnHeal					= mod:NewSpellAnnounce(99392, 3)
local specwarnHealInterrupt		= mod:NewSpecialWarningInterrupt(99392, false)	-- ppl have to manually turn it on if they can interrupt
local specwarnHealDispel		= mod:NewSpecialWarningDispel(99392, false)	-- ppl have to manually turn it on if they can dispel
local timerHeal					= mod:NewBuffActiveTimer(16, 99392)

function mod:OnCombatStart(delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(99502) then
		warnBreath:Show()
		specwarnBreath:Show()
		timerBreath:Start()
	elseif args:IsSpellID(99392) then
		warnHeal:Show()
		specwarnHealInterrupt:Show(args.sourceName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(99392) and not args:IsPlayer() then
		specwarnHealDispel:Show()
		timerHeal:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(99392) then
		timerHeal:Cancel()
	end
end