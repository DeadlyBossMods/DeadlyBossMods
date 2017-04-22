local mod	= DBM:NewMod(1763, "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(108678)
mod:SetEncounterID(1888)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 216044",
	"SPELL_CAST_SUCCESS 215821",
	"SPELL_PERIODIC_DAMAGE 215876",
	"SPELL_PERIODIC_MISSED 215876"
)

local specWarnBreath			= mod:NewSpecialWarningSpell(215821, "Tank", nil, nil, 1, 2)
local specWarnBurningEarth		= mod:NewSpecialWarningMove(215876, nil, nil, nil, 1, 2)
local specWarnFear				= mod:NewSpecialWarningSpell(216044, nil, nil, nil, 2, 2)

local timerBreathCD				= mod:NewCDTimer(18.4, 215821, nil, "Tank", 2, 5, nil, DBM_CORE_TANK_ICON)--18.4-23
local timerFearCD				= mod:NewCDTimer(63, 216044, nil, nil, nil, 1)--63-65

local voiceBreath				= mod:NewVoice(215821, "Tank")--breathsoon
local voiceBurningEarth			= mod:NewVoice(215876)--runaway
local voiceFear					= mod:NewVoice(216044)

--mod:AddReadyCheckOption(37460, false)
mod:AddRangeFrameOption(5, 216043)--Range unknown, journal nor spell tooltip say.

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		timerBreathCD:Start(16-delay)
		timerFearCD:Start(60-delay)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 215821 then
		specWarnBreath:Show()
		voiceBreath:Play("breathsoon")
		timerBreathCD:Start()
	elseif spellId == 216044 then
		specWarnFear:Show()
		voiceFear:Play("fearsoon")
		timerFearCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 215821 then
		specWarnBreath:Show()
		voiceBreath:Play("breathsoon")
		timerBreathCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 215876 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnBurningEarth:Show()
		voiceBurningEarth:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
