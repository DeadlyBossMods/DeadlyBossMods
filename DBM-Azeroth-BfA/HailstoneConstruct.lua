local mod	= DBM:NewMod(2197, "DBM-Azeroth-BfA", 1, 1028)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(140252)
--mod:SetEncounterID(1880)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 274896 274891 274895"
)

local warnPermafrostSpike			= mod:NewSpellAnnounce(274896, 2)

local specWarnGlacialBreath			= mod:NewSpecialWarningDodge(274891, nil, nil, nil, 2, 2)
local specWarnFreezingTempest		= mod:NewSpecialWarningMoveTo(274895, nil, nil, 2, 3, 2)

local timerPermafrostSpikeCD		= mod:NewCDTimer(10.2, 274896, nil, nil, nil, 3)
local timerGlacialBreathCD			= mod:NewCDTimer(43.2, 274891, nil, nil, nil, 3)
local timerFreezingTempestCD		= mod:NewCDTimer(65.5, 274895, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)

--mod:AddReadyCheckOption(37460, false)
local spikeName = DBM:GetSpellInfo(274896)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerPermafrostSpikeCD:Start(1-delay)
		--timerGlacialBreathCD:Start(1-delay)
		--timerFreezingTempestCD:Start(1-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 274896 then
		warnPermafrostSpike:Show()
		timerPermafrostSpikeCD:Start()
	elseif spellId == 274891 then
		specWarnGlacialBreath:Show()
		specWarnGlacialBreath:Play("breathsoon")
		timerGlacialBreathCD:Start()
	elseif spellId == 274895 then
		specWarnFreezingTempest:Show(spikeName)
		specWarnFreezingTempest:Play("findshelter")
		timerFreezingTempestCD:Start()
	end
end
