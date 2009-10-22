local mod = DBM:NewMod("DevourerofSouls", "DBM-Party-WotLK", 14)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1728 $"):sub(12, -3))
mod:SetCreatureID(36502)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warnMirroredSoul			= mod:NewTargetAnnounce(69051)
local timerMirroredSoul			= mod:NewTargetTimer(8, 69051)
local warnUnleashedSouls			= mod:NewSpellAnnounce(68939)
local warnWailingSouls			= mod:NewSpellAnnounce(68899)
local warnWellofSouls				= mod:NewSpellAnnounce(68820)
local specwarnMirroredSoul	= mod:NewSpecialWarning("specwarnMirroredSoul")

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68820) then							-- Well of Souls
		warnWellofSouls:Show(args.spellName)
	elseif args:IsSpellID(68939) then							-- Unleashed Souls
		warnUnleashedSouls:Show(args.spellName)
	elseif args:IsSpellID(68899, 70324) then							-- Wailing Souls (possible heroic spellid drycoded from thotbot testrealm database)
		warnWailingSouls:Show(args.spellName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69051) then							-- Mirroed Soul
		if args:IsPlayer() then
			warnMirroredSoul:Show(args.destName)
			timerMirroredSoul:Show(args.destName)
			specwarnMirroredSoul:Show()
		end
	end
end

