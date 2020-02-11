local mod	= DBM:NewMod(2129, "DBM-Party-BfA", 10, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(131864)
mod:SetEncounterID(2117)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 268202",
	"SPELL_CAST_START 266225 266266 266181",
	"SPELL_CAST_SUCCESS 266266"
)

--TODO, re-transcribe fight to see what UNIT events exist so maybe yell isn't needed
--TODO, verify iffy timers from such a short short pull
--TODO, heroic stuff (grim portal, dread lense). Too many spellIds to just guess/drycode
local warnDeathlens					= mod:NewTargetNoFilterAnnounce(268202, 4)

local specWarnSummonSlaver			= mod:NewSpecialWarningSwitch(266266, "-Healer", nil, nil, 1, 2)
local specWarnDreadEssence			= mod:NewSpecialWarningSpell(266181, nil, nil, nil, 2, 2)
local specWarnDarkenedLightning		= mod:NewSpecialWarningInterrupt(266225, "HasInterrupt", nil, nil, 1, 2)

local timerDarkenedLightningCD		= mod:NewCDTimer(15.7, 266225, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)--Has interrupt spell icon but it's not actually interruptable
local timerSummonSlaverCD			= mod:NewCDTimer(17, 266266, nil, nil, nil, 1)--17-22
local timerDreadEssenceCD			= mod:NewCDTimer(27.9, 266181, nil, nil, nil, 2)

mod:AddRangeFrameOption(6, 266225)--Range guessed, can't find spell data for it

function mod:OnCombatStart(delay)
	timerDarkenedLightningCD:Start(8-delay)
	timerSummonSlaverCD:Start(13-delay)
	timerDreadEssenceCD:Start(25-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 268202 then
		warnDeathlens:CombinedShow(0.3, args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 266225 then
		timerDarkenedLightningCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnDarkenedLightning:Show(args.sourceName)
			specWarnDarkenedLightning:Play("kickcast")
		end
	elseif spellId == 266266 then
		timerSummonSlaverCD:Start()
	elseif spellId == 266181 then
		specWarnDreadEssence:Show()
		specWarnDreadEssence:Play("aesoon")
		--timerDreadEssenceCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 266266 then
		specWarnSummonSlaver:Show()
		specWarnSummonSlaver:Play("killmob")
	end
end
