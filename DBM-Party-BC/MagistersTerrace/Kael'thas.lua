local mod	= DBM:NewMod("Kael", "DBM-Party-BC", 16)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))
mod:SetCreatureID(24664)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnPhase2        = mod:NewPhaseAnnounce(2)
local WarnPhoenix       = mod:NewSpellAnnounce(44194)
local WarnShockBarrior  = mod:NewSpellAnnounce(46165)
local warnPyroblast		= mod:NewCastAnnounce(36819)
local timerPyroblast	= mod:NewCastTimer(4, 36819)
local timerShockBarrior = mod:NewNextTimer(60, 46165)--Best guess based on limited CL data
local timerPhoenix      = mod:NewNextTimer(45, 44194)--Best guess based on limited CL data
local specwarnPyroblast = mod:NewSpecialWarning("specwarnPyroblast")

function mod:OnCombatStart(delay)
	if mod:IsDifficulty("heroic5") then
        timerShockBarrior:Start(-delay)
        timerPhoenix:Start(10-delay)
    end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(36819) then
		warnPyroblast:Show()
        timerPyroblast:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(44194) then
		WarnPhoenix:Show()
		timerPhoenix:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(44165) then
		WarnShockBarrior:Show(args.destName)
        timerShockBarrior:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(44165) then
        specwarnPyroblast:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.KaelP2 then
		warnPhase2:Show()
		timerShockBarrior:Cancel()
	end
end