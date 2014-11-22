local mod	= DBM:NewMod(1208, "DBM-Party-WoD", 5, 556)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(82682)
mod:SetEncounterID(1751)--TODO: Verify, Label was "Boss 3"

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 168885",
	"SPELL_AURA_APPLIED 166492 166726"
)

--Again, too lazy to work on CD timers, someone else can do it. raid mods are putting too much strain on me to give 5 man mods as much attention
--Probalby should also add a close warning for Frozen Rain
local warnParasiticGrowth		= mod:NewSpellAnnounce(168885, 3, nil, mod:IsTank())--This is tanks job, it's no one elses business to interrupt this before tank is ready to push next phase. Careless interruptions can cause a wipe to arcane phase because fire/ice were too short.
local warnFireBloom				= mod:NewSpellAnnounce(113764, 4)--Shitty way of detecting, cast is hidden, only way to "detect" it is if someone is standing in it.
local warnFrozenRain			= mod:NewTargetAnnounce(166726, 3)--Shitty way of detecting, cast is hidden, only way to "detect" it is if someone is standing in it.

local specWarnParasiticGrowth	= mod:NewSpecialWarningSpell(168885, mod:IsTank())
local specWarnFireBloom			= mod:NewSpecialWarningSpell(166492, nil, nil, nil, 2)
local specWarnFrozenRain		= mod:NewSpecialWarningMove(166726)

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 168885 then
		warnParasiticGrowth:Show()
		specWarnParasiticGrowth:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 166492 and self:AntiSpam(12) then--Because the dumb spell has no cast Id, we can only warn when someone gets hit by one of rings.
		warnFireBloom:Show()
		specWarnFireBloom:Show()
	elseif spellId == 166726 and self:AntiSpam(10, args.destName) then--Because dumb spell has no cast Id, we can only warn when people get debuff from standing in it.
		warnFrozenRain:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnFrozenRain:Show()
		end
	end
end
