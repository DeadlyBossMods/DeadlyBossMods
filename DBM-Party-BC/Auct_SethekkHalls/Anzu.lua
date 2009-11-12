local mod = DBM:NewMod("Anzu", "DBM-Party-BC", 9)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 9 $"):sub(12, -3))

mod:SetCreatureID(23035, 23132)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnScreech           = mod:NewSpellAnnounce(40184)
local warnCyclone           = mod:NewTargetAnnounce(40321)
local warnSpellBomb         = mod:NewTargetAnnounce(40303)
local timerScreech          = mod:NewCastTimer(5, 40184)
local timerScreechDebuff    = mod:NewBuffActiveTimer(6, 40184)
local timerCyclone          = mod:NewTargetTimer(6, 40321)
local timerSpellBomb        = mod:NewTargetTimer(8, 40303)
local timerScreechCD		= mod:NewCDTimer(30, 40184)--Best guess on screech CD. Might need tweaking.

function mod:OnCombatStart(delay)
	timerScreechCD:Start()
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 40184 then
		warnScreech:Show()
		timerScreech:Start()
		timerScreechCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 40321 then
		warnCyclone:Show(args.destName)
		timerCyclone:Start(args.destName)
	elseif args.spellId == 40184 then
		timerScreechDebuff:Show()
	elseif args.spellId == 40303 then
		warnSpellBomb:Show(args.destName)
		timerSpellBomb:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 40303 then
		timerSpellBomb:Cancel(args.destName)
	end
end