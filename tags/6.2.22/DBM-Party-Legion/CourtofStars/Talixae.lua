local mod	= DBM:NewMod(1719, "DBM-Party-Legion", 7, 800)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(104217)
mod:SetEncounterID(1869)
mod:SetZone()

mod:RegisterCombat("combat")

--Out of combat register, to support the secondary bosses off to sides
mod:RegisterEvents(
	"SPELL_CAST_START 208165 207881 207980 209378"
)

--local specWarnWitheringSoul		= mod:NewSpecialWarningInterrupt(208165, "HasInterrupt")
local specWarnInfernalEruption		= mod:NewSpecialWarningDodge(207881, nil, nil, nil, 2, 2)
local specWarnDisintegrationBeam	= mod:NewSpecialWarningInterrupt(207980, "HasInterrupt", nil, nil, 1, 2)
local specWarnWhirlingBlades		= mod:NewSpecialWarningRun(209378, "Melee", nil, nil, 4, 2)

local timerWitheringSoulCD			= mod:NewCDTimer(14.5, 208165, nil, nil, nil, 3)
local timerInfernalEruptionCD		= mod:NewCDTimer(32, 207881, nil, nil, nil, 2)

local voiceInfernalEruption			= mod:NewVoice(207881)--watchstep
local voiceDisintegrationBeam		= mod:NewVoice(207980, "HasInterrupt")--kickcast
local voiceWhirlingBlades			= mod:NewVoice(209378, "Melee")--runout

function mod:OnCombatStart(delay)
	timerWitheringSoulCD:Start(12-delay)
	timerInfernalEruptionCD:Start(19.5-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 208165 then
		--if self:CheckInterruptFilter(args.sourceGUID) then
			--specWarnWitheringSoul:Show(args.sourceName)
		--end
		timerWitheringSoulCD:Start()
	elseif spellId == 207881 then
		specWarnInfernalEruption:Show()
		voiceInfernalEruption:Play("watchstep")
		timerInfernalEruptionCD:Start()
	elseif spellId == 207980 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnDisintegrationBeam:Show(args.sourceName)
		voiceDisintegrationBeam:Play("kickcast")
	elseif spellId == 209378 then
		specWarnWhirlingBlades:Show()
		voiceWhirlingBlades:Play("runout")
	end
end
