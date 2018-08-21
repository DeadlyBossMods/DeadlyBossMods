local mod	= DBM:NewMod(2197, "DBM-KulTiras", nil, 1028)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(140252)
--mod:SetEncounterID(1880)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 274896 274891 274895",
	"SPELL_CAST_SUCCESS 274888",
	"SPELL_AURA_APPLIED"
)

--TODO, target scan permafrost spike?
local warnIcerimedFists				= mod:NewSpellAnnounce(274888, 3, nil, "Tank")
local warnPermafrostSpike			= mod:NewSpellAnnounce(274896, 2)

local specWarnGlacialBreath			= mod:NewSpecialWarningDodge(274891, nil, nil, nil, 2, 2)
local specWarnFreezingTempest		= mod:NewSpecialWarningMoveTo(274895, nil, nil, nil, 4, 2)

local timerIcerimedFistsCD			= mod:NewAITimer(16, 274888, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerPermafrostSpikeCD		= mod:NewAITimer(16, 274896, nil, nil, nil, 3)
local timerGlacialBreathCD			= mod:NewAITimer(16, 274891, nil, nil, nil, 3)
local timerFreezingTempestCD		= mod:NewAITimer(16, 274895, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)

--mod:AddRangeFrameOption(5, 194966)
--mod:AddReadyCheckOption(37460, false)
local spikeName = DBM:GetSpellInfo(274896)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerIcerimedFistsCD:Start(1-delay)
		--timerPermafrostSpikeCD:Start(1-delay)
		--timerGlacialBreathCD:Start(1-delay)
		--timerFreezingTempestCD:Start(1-delay)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
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

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 274888 then
		warnIcerimedFists:Show()
		timerIcerimedFistsCD:Start()
	end
end
