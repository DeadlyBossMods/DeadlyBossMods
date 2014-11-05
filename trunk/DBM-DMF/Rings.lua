local mod	= DBM:NewMod("Rings", "DBM-DMF")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 170820 170823",
	"SPELL_AURA_APPLIED_DOSE 170823",
	"SPELL_AURA_REMOVED 170820"
)
mod.noStatistics = true

local warnRings		= mod:NewCountAnnounce(170823, 1, nil, false)--Spammy, so off by default, but requested because blizz bug, ring does not always make sound when passing through so this alert can serve as confirmation sound

local timerGame		= mod:NewBuffActiveTimer(10, 170820)

local countdownGame	= mod:NewCountdownFades(10, 170820)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local wingsName = GetSpellInfo(170820)
local UnitBuff = UnitBuff

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 170823 and args:IsPlayer() then
		warnRings:Show(args.amount or 1)
		countdownGame:Cancel()
		local _, _, _, _, _, duration, expires = UnitBuff("player", wingsName)
		--Maybe use expires instead?
		timerGame:Start(duration-1)
		countdownGame:Start(duration-1)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--"<111.5 20:41:44> [CLEU] SPELL_AURA_REMOVED#false#Player-55-07DC716F#Judgementál#1304#0#Player-55-07DC716F#Judgementál#1304#0#170820#Wings of Flame#1#BUFF", -- [150]
--"<111.5 20:41:44> [CLEU] SPELL_AURA_APPLIED#false#Player-55-07DC716F#Judgementál#1304#0#Player-55-07DC716F#Judgementál#1304#0#170838#Slow Fall#64#BUFF", -- [151]
function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 170820 and args:IsPlayer() then
		timerGame:Cancel()
		countdownGame:Cancel()
	end
end
