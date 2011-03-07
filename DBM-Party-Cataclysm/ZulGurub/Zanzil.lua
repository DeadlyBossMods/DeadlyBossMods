local mod	= DBM:NewMod("Zanzil", "DBM-Party-Cataclysm", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52053)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnCauldronRed		= mod:NewSpellAnnounce(96486, 3)
local warnCauldronGreen		= mod:NewSpellAnnounce(96487, 3)
local warnCauldronBlue		= mod:NewSpellAnnounce(96488, 3)
local warnZanzilFire		= mod:NewSpellAnnounce(96914, 3)
local warnZanzilGas		= mod:NewSpellAnnounce(96388, 3)
local warnZanzilElixir		= mod:NewSpellAnnounce(96316, 4)

local timerZanzilGas		= mod:NewBuffActiveTimer(7, 96388)
local timerZanzilElixir		= mod:NewCDTimer(30, 96316)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(96388) then
		timerZanzilGas:Start()
	elseif args:IsSpellID(96316) then
		warnZanzilElixir:Show()
		timerZanzilElixir:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(96914) then
		warnZanzilFire:Show()
		-- add target scanning ??
	elseif args:IsSpellID(96338) then
		warnZanzilGas:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(96486) then
		warnCauldronRed:Show()
	elseif args:IsSpellID(96487) then
		warnCauldronGreen:Show()
	elseif args:IsSpellID(96488) then
		warnCauldronBlue:Show()
	end
end