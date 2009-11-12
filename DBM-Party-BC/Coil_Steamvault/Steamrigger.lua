local mod	= DBM:NewMod("Steamrigger", "DBM-Party-BC", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1 $"):sub(12, -3))
mod:SetCreatureID(17796)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL"
)

local WarnSummon    = mod:NewAnnounce("WarnSummon")
local WarnNe        = mod:NewTargetAnnounce(35107)
local timerNet      = mod:NewTargetTimer(6, 35107)

local enrageTimer	= mod:NewEnrageTimer(300)

function mod:OnCombatStart(delay)
	if mod:IsDifficulty("heroic5") then
        enrageTimer:Start(-delay)
    end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(35107) then
		warningNet:Show(args.destName)
		timerNet:Start(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Mechs then		-- Adds
		WarnSummon:Show()
	end
end