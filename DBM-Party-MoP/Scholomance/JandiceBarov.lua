local mod	= DBM:NewMod(663, "DBM-Party-MoP", 7, 246)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(59184)--59220 seem to be her mirror images
mod:SetEncounterID(1427)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnWondrousRapidity		= mod:NewSpellAnnounce(114062, 3)
local warnGravityFlux			= mod:NewTargetAnnounce(114059, 2)
local warnWhirlofIllusion		= mod:NewSpellAnnounce(113808, 4)

local specWarnWondrousRapdity	= mod:NewSpecialWarningMove(114062, mod:IsTank())--Frontal cone fixate attack, easily dodged (in fact if you don't, i imagine it'll wreck you on heroic)

local timerWondrousRapidity		= mod:NewBuffFadesTimer(7.5, 114062)
local timerWondrousRapidityCD	= mod:NewNextTimer(14, 114062)
local timerGravityFlux			= mod:NewCDTimer(12, 114059) -- needs more review.

function mod:GravityFluxTarget()
	local targetname = self:GetBossTarget(59184)
	if not targetname then return end
	warnGravityFlux:Show(targetname)
end

function mod:OnCombatStart(delay)
	timerWondrousRapidityCD:Start(6-delay)
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 114062 then
		timerWondrousRapidityCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 114062 then
		warnWondrousRapidity:Show()
		specWarnWondrousRapdity:Show()
		timerWondrousRapidity:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if (spellId == 114059 or spellId == 114047) and self:AntiSpam(2, 1) then -- found 2 spellids on first cast, 4 spellids total (114035, 114038, 114047, 114059). needs more logs to confirm whether spellid is correct.
		self:ScheduleMethod(0.1, "GravityFluxTarget")
		timerGravityFlux:Start()
	elseif spellId == 113808 and self:AntiSpam(2, 2) then
		warnWhirlofIllusion:Show()
		timerGravityFlux:Cancel()
	end
end
