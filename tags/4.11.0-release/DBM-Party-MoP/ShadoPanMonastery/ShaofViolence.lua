local mod	= DBM:NewMod(685, "DBM-Party-MoP", 3, 312)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7726 $"):sub(12, -3))
mod:SetCreatureID(56719)
mod:SetModelID(43283)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnDisorientingSmash			= mod:NewTargetAnnounce(106872, 2)
local warnShaSpike					= mod:NewSpellAnnounce(106877, 3)--maybe use target scanning?
local warnEnrage					= mod:NewSpellAnnounce(38166, 4)

local timerDisorientingSmashCD		= mod:NewCDTimer(13, 106872)--variables. not confirmed
local timerShaSpikeCD				= mod:NewNextTimer(9, 106877)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(38166) then
		warnEnrage:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(106877) then
		warnShaSpike:Show()
		timerShaSpikeCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(106872) then
		warnDisorientingSmash:Show(args.destName)
		timerDisorientingSmashCD:Start()
	end
end