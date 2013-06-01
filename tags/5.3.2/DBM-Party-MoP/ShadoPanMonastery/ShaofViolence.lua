local mod	= DBM:NewMod(685, "DBM-Party-MoP", 3, 312)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56719)
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Kill)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnDisorientingSmash		= mod:NewTargetAnnounce(106872, 2)
local warnShaSpike				= mod:NewTargetAnnounce(106877, 3)
local warnEnrage				= mod:NewSpellAnnounce(38166, 4)

local specWarnShaSpike			= mod:NewSpecialWarningMove(106877)

local timerDisorientingSmashCD	= mod:NewCDTimer(13, 106872)--variables. not confirmed
local timerShaSpikeCD			= mod:NewNextTimer(9, 106877)

function mod:ShaSpikeTarget(targetname)
	if not targetname then return end
	warnShaSpike:Show(targetname)
	if targetname == UnitName("player") then
		specWarnShaSpike:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 38166 then
		warnEnrage:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 106877 then
		self:BossTargetScanner(56719, "ShaSpikeTarget", 0.02, 20)
		timerShaSpikeCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 106872 then
		warnDisorientingSmash:Show(args.destName)
		timerDisorientingSmashCD:Start()
	end
end