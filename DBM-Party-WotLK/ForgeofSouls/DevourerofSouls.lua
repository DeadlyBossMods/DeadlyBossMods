local mod	= DBM:NewMod("DevourerofSouls", "DBM-Party-WotLK", 14)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36502)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warnPhantomBlast			= mod:NewSpellAnnounce(68982)
local warnUnleashedSouls		= mod:NewSpellAnnounce(68939)
local warnWailingSouls			= mod:NewSpellAnnounce(68899)
local warnWellofSouls			= mod:NewSpellAnnounce(68820)
local warnMirroredSoul			= mod:NewTargetAnnounce(69051)
local timerMirroredSoul			= mod:NewTargetTimer(8, 69051)
local timerUnleashedSouls		= mod:NewBuffActiveTimer(5, 68939)
local specwarnMirroredSoul		= mod:NewSpecialWarning("specwarnMirroredSoul")
local specwarnPhantomBlast		= mod:NewSpecialWarning("specwarnPhantomBlast", false)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68982, 70322) then						-- Phantom Blast
		warnPhantomBlast:Show()
		specwarnPhantomBlast:Show()
	elseif args:IsSpellID(68820) then							-- Well of Souls
		warnWellofSouls:Show()
	elseif args:IsSpellID(68939) then							-- Unleashed Souls
		warnUnleashedSouls:Show()
	elseif args:IsSpellID(68899, 70324) then					-- Wailing Souls
		warnWailingSouls:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69051) and args:IsDestTypePlayer() then	-- Mirrored Soul
		warnMirroredSoul:Show(args.destName)
		timerMirroredSoul:Show(args.destName)
		specwarnMirroredSoul:Show()
	elseif args:IsSpellID(68939) then							-- Unleashed Souls
		timerUnleashedSouls:Start()
	end
end