local mod	= DBM:NewMod("Springvale", "DBM-Party-Cataclysm", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(4278)
mod:SetModelID(37287)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"CHAT_MSG_MONSTER_YELL"
)

local warnDesecration		= mod:NewSpellAnnounce(93687, 3)
local warnMaleficStrike		= mod:NewSpellAnnounce(93685, 2, nil, false)
local warnShield			= mod:NewSpellAnnounce(93736, 4)
local warnWordShame			= mod:NewTargetAnnounce(93852, 3)
local warnEmpowerment		= mod:NewCastAnnounce(93844, 4)

local specWarnDesecration	= mod:NewSpecialWarningMove(94370)
local specWarnEmpowerment	= mod:NewSpecialWarningInterrupt(93844, false)

local timerAdds				= mod:NewTimer(40, "TimerAdds", 48000)
local timerMaleficStrike	= mod:NewNextTimer(6, 93685, nil, false)

function mod:OnCombatStart(delay)
	timerAdds:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(93736) then
		warnShield:Show()
	elseif args:IsSpellID(93852) then
		warnWordShame:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93844) then
		warnEmpowerment:Show()
		specWarnEmpowerment:Show(args.sourceName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(93685) then
		warnMaleficStrike:Show()
		timerMaleficStrike:Start()
	elseif args:IsSpellID(93687) then
		warnDesecration:Show()
	end
end

function mod:SPELL_DAMAGE(sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId)
	if spellId == 94370 and destGUID == UnitGUID("player") and self:AntiSpam(4) then
		specWarnDesecration:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellAdds or msg:find(L.YellAdds) then
		timerAdds:Start()--unknown time for 2nd+ set, pugs don't take this long anymore. Assumed the same but don't know for sure.
	end
end