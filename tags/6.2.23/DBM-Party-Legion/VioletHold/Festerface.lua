local mod	= DBM:NewMod(1693, "DBM-Party-Legion", 9, 777)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(101995)
mod:SetEncounterID(1848)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 201598 201729"
)

--TODO, maybe an infoframe for oozes remaining, similar to Iron Reaver in HFC
local specWarnOozes					= mod:NewSpecialWarningSwitch("ej12646", "-Healer", nil, nil, 1, 2)
local specWarnBlackBile				= mod:NewSpecialWarningSwitch("ej12651", nil, nil, nil, 3, 2)

local timerOozesCD					= mod:NewNextTimer(51, 201598, nil, nil, nil, 1)

local countdownOozes				= mod:NewCountdown(51, 201598)

local voiceOozes					= mod:NewVoice("ej12646")--mobsoon
local voiceBlackBile				= mod:NewVoice("ej12651")--mobsoon (maybe use a diff one?)

--mod:AddRangeFrameOption(5, 153396)

function mod:OnCombatStart(delay)
	timerOozesCD:Start(3.7-delay)--Countdown not started here on purpose
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
