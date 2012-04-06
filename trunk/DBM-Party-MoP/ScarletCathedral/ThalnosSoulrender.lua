local mod	= DBM:NewMod("ThalnosSoulrender", "DBM-Party-MoP", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(59789)
--mod:SetModelID(27705)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS"
)


local warnEvictSoul				= mod:NewTargetAnnounce(115297, 3)
local warnRaiseCrusade			= mod:NewSpellAnnounce(115139, 3)
local warnSummonSpirits			= mod:NewSpellAnnounce(115147, 4)
local warnEmpowerZombie			= mod:NewSpellAnnounce(115239, 4, 115250)

local specWarnFallenCrusader	= mod:NewSpecialWarningSwitch("ej5863", not mod:IsHealer())--Need more data, nots sure if they are meaningful enough to kill or ignore.
local specWarnEmpoweredZombie	= mod:NewSpecialWarningSwitch("ej5870", not mod:IsHealer())--These zombies hurt, they need to die asap.

local timerEvictSoul			= mod:NewTargetTimer(6, 116648)
local timerEvictSoulCD			= mod:NewCDTimer(40, 116648)
local timerRaiseCrusadeCD		= mod:NewNextTimer(60, 115139)
local timerSummonSpiritsCD		= mod:NewNextTimer(60, 115147)

function mod:OnCombatStart(delay)
	timerRaiseCrusadeCD:Start(6-delay)
	timerBreathCD:Start(25.5-delay)--Consistent?
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(115297, 116648) then
		warnEvictSoul:Show(args.destName)
		timerEvictSoul:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(115297, 116648) then
		timerEvictSoul:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(115297, 116648) then--Trigger CD off success, since we can resist it. do NOT add ID 115548, it's a similcast to 115297
		timerEvictSoulCD:Start()
	elseif args:IsSpellID(115147, 116653) then--Summon Empowering Spirits
		warnSummonSpirits:Show()
		timerRaiseCrusadeCD:Start(20)--Because they are both 60 second near precise timers, we alternate the timers to reduce needing to have both up at once.
	elseif args:IsSpellID(115139) then--Raise Fallen Crusade
		warnRaiseCrusade:Show()
		specWarnFallenCrusader:Show()
		timerSummonSpiritsCD:Start(40)
	elseif args:IsSpellID(115239) then--Empower Zombie (used by empowering Spirits on fallen Crusaders to make them hulking hard hitting zombies)
		warnEmpowerZombie:Show()
		specWarnEmpoweredZombie:Schedule(2)--schedule a delay since it's not targetable for about 2 seconds
	end
end