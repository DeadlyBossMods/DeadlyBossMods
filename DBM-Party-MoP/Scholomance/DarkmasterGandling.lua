local mod	= DBM:NewMod("DarkmasterGandling", "DBM-Party-MoP", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(59080)
--mod:SetModelID(38931)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

--His encounter doesn't seem implimented yet, he currently has no EJ entry and he doesn't do anything really, just stands there spamming a fireball til he dies.
--4/3 16:26:36.671  Darkmaster Gandling yells: AGGRO [PH]
--4/3 16:27:06.988  Darkmaster Gandling yells: DEATH [PH]
--[[
local warnBlast			= mod:NewSpellAnnounce(102381, 3)
local warnBreath		= mod:NewSpellAnnounce(102569, 4)
local warnRewind		= mod:NewSpellAnnounce(101591, 3)

local timerBlastCD		= mod:NewNextTimer(12, 102381)
local timerBreathCD		= mod:NewNextTimer(22, 102569)

function mod:OnCombatStart(delay)
	timerBlastCD:Start(-delay)
	timerBreathCD:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(101591) and self:AntiSpam() then
		warnRewind:Show()
		timerBlastCD:Cancel()
		timerBreathCD:Cancel()
		timerBlastCD:Start()
		timerBreathCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(102381) then
		warnBlast:Show()
		timerBlastCD:Start()
	elseif args:IsSpellID(102569) then
		warnBreath:Show()
		timerBreathCD:Start()
	end
end--]]