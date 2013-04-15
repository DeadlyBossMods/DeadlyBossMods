local mod	= DBM:NewMod(831, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(69473)
mod:SetModelID(47739) -- most likely a placeholder :)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START"
)

-- NO WARNINGS, THIS IS ONLY SPELL INFORMATION
-- To complete this mod, combatlog required..
--[[
Adding like this bad idea, now these will option default to ON for all warnings when they do get added and we won't be able to reset the crap defaults for people who zoned into ToT at least once with this version of mod
local warnAnima					= mod:NewSpellAnnounce(138331)
local warnMurderousStrike		= mod:NewSpellAnnounce(138333)--Tank Spells?
local warnUnstableAnima			= mod:NewSpellAnnounce(138295)--May range frame needed
local warnSanguineHorror		= mod:NewSpellAnnounce(138338)--Adds?
local warnVita					= mod:NewSpellAnnounce(138332)
local warnFatalStrike			= mod:NewSpellAnnounce(138334)--Tank Spells?
local warnUnstableVita			= mod:NewSpellAnnounce(138308)
local warnCracklingStalker		= mod:NewSpellAnnounce(138339)--Adds?
local warnCreation				= mod:NewSpellAnnounce(138321)
local warnRuinBolt				= mod:NewSpellAnnounce(139087)
--]]