local mod	= DBM:NewMod("Cannon", "DBM-DMF")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS 102120",
	"UNIT_AURA player"
)
mod.noStatistics = true

local timerMagicWings				= mod:NewBuffFadesTimer(8, 102116, nil, nil, nil, 5)

local markWings = false

local function wingsRemoved()
	markWings = false
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 102120 and args:IsPlayer() then
		timerMagicWings:Cancel()
	end
end

function mod:UNIT_AURA()
	if DBM:UnitBuff("player", DBM:GetSpellInfo(102116)) and not markWings then
		timerMagicWings:Start()
		markWings = true
		self:Schedule(8.5, wingsRemoved)
	end
end
