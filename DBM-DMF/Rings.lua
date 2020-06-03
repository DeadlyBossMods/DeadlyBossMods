local mod	= DBM:NewMod("Rings", "DBM-DMF")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 170820 170823",
	"SPELL_AURA_APPLIED_DOSE 170823",
	"SPELL_AURA_REMOVED 170820"
)
mod.noStatistics = true

local warnRings		= mod:NewCountAnnounce(170823, 1, nil, false)--Spammy, so off by default, but requested because blizz bug, ring does not always make sound when passing through so this alert can serve as confirmation sound

local timerGame		= mod:NewBuffActiveTimer(10, 170820, nil, nil, nil, 5, nil, nil, nil, 1, 5)

local function checkBuff()
	local name, _, _, _, _, expires, _, _, _, spellId = DBM:UnitBuff("player", 170820)
	if name and spellId == 170820 then
		local time = expires-GetTime()
		timerGame:Stop()
		timerGame:Start(time)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 170823 and args:IsPlayer() then
		warnRings:Show(args.amount or 1)
		self:Unschedule(checkBuff)
		self:Schedule(0.2, checkBuff)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--"<111.5 20:41:44> [CLEU] SPELL_AURA_REMOVED#false#Player-55-07DC716F#Judgementál#1304#0#Player-55-07DC716F#Judgementál#1304#0#170820#Wings of Flame#1#BUFF", -- [150]
--"<111.5 20:41:44> [CLEU] SPELL_AURA_APPLIED#false#Player-55-07DC716F#Judgementál#1304#0#Player-55-07DC716F#Judgementál#1304#0#170838#Slow Fall#64#BUFF", -- [151]
function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 170820 and args:IsPlayer() then
		self:Unschedule(checkBuff)
		timerGame:Cancel()
	end
end
