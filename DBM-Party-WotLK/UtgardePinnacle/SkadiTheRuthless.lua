local mod	= DBM:NewMod("SkadiTheRuthless", "DBM-Party-WotLK", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26693)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warningPoison		= mod:NewTargetAnnounce(59331, 2)
local warningWhirlwind	= mod:NewSpellAnnounce(59322, 3)
local timerPoison		= mod:NewTargetTimer(12, 59331)
local timerWhirlwindCD	= mod:NewCDTimer(30, 59322)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(59331, 50255) then
		warningPoison:Show(args.destName)
		timerPoison:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(59331, 50255) then
		timerPoison:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(59322, 50228) then
		warningWhirlwind:Show()
		timerWhirlwindCD:Start()
	end
end