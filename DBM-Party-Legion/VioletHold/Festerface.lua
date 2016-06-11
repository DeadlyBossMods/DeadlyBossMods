local mod	= DBM:NewMod(1693, "DBM-Party-Legion", 9, 777)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(101995)
mod:SetEncounterID(1848)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 201598 201729",
	"SPELL_PERIODIC_DAMAGE 202266",
	"SPELL_PERIODIC_MISSED 202266"
)

--TODO, maybe an infoframe for oozes remaining, similar to Iron Reaver in HFC
local specWarnOozes					= mod:NewSpecialWarningSwitch("ej12646", "-Healer", nil, nil, 1, 2)
local specWarnBlackBile				= mod:NewSpecialWarningSwitch("ej12651", nil, nil, nil, 3, 2)
local specWarnOozeGTFO				= mod:NewSpecialWarningMove(202266, nil, nil, nil, 1, 2)

local timerOozesCD					= mod:NewNextTimer(51, 201598, nil, nil, nil, 1)

local countdownOozes				= mod:NewCountdown(51, 201598)

local voiceOozes					= mod:NewVoice("ej12646")--mobsoon
local voiceBlackBile				= mod:NewVoice("ej12651")--mobsoon (maybe use a diff one?)
local voiceOozeGTFO					= mod:NewVoice(202266)--runaway

--mod:AddRangeFrameOption(5, 153396)

function mod:OnCombatStart(delay)
--	timerOozesCD:Start(3.7-delay)--Too variable on pull, 3-6, pretty much right away anyways so no need for timer
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 201598 then
		specWarnOozes:Show()
		voiceOozes:Play("mobsoon")
		timerOozesCD:Start()
		countdownOozes:Start()
	elseif spellId == 201729 then
		specWarnBlackBile:Show()
		voiceBlackBile:Play("mobsoon")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 202266 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnOozeGTFO:Show()
		voiceOozeGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
