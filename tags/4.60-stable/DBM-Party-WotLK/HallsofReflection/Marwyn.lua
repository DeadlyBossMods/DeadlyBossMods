local mod = DBM:NewMod("Marwyn", "DBM-Party-WotLK", 16)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2153 $"):sub(12, -3))
mod:SetCreatureID(38113)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnWellCorruption		= mod:NewSpellAnnounce(72362, 3)
local warnCorruptedFlesh		= mod:NewSpellAnnounce(72436, 3)

local timerWellCorruptionCD		= mod:NewCDTimer(13, 72362)
local timerCorruptedFlesh		= mod:NewBuffActiveTimer(8, 72436)
local timerCorruptedFleshCD		= mod:NewCDTimer(20, 72436)

local specWarnWellCorruption	= mod:NewSpecialWarningMove(72362)

local spam = 0

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(72362) and args:IsPlayer() then
		specWarnWellCorruption:Show()
	elseif args:IsSpellID(72436, 72363) then
		if GetTime() - spam > 5 then
			warnCorruptedFlesh:Show()
			timerCorruptedFlesh:Start()
			timerCorruptedFleshCD:Start()
			spam = GetTime()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(72362) then
		warnWellCorruption:Show()
		timerWellCorruptionCD:Start()
	end
end