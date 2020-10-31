local mod	= DBM:NewMod("Emeriss", "DBM-WorldEvents", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(121913)--121913 TW ID, 14889 classic ID
--mod:SetModelID(17887)

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 243401",
	"SPELL_CAST_SUCCESS 243399",
	"SPELL_AURA_APPLIED 243401 243451",
	"SPELL_AURA_APPLIED_DOSE 243401"
)

--TODO, maybe taunt special warnings for classic version when it matters more.
local warnNoxiousBreath			= mod:NewStackAnnounce(243401, 2, nil, "Tank")

local specWarnSleepingFog		= mod:NewSpecialWarningDodge(243399, nil, nil, nil, 2, 2)
local specWarnMushroom			= mod:NewSpecialWarningYou(243451, nil, nil, nil, 1, 2)

local timerNoxiousBreathCD		= mod:NewCDTimer(18.3, 243401, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)--Iffy
local timerSleepingFogCD		= mod:NewCDTimer(15.8, 243399, nil, nil, nil, 3)

--mod:AddReadyCheckOption(48620, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		timerNoxiousBreathCD:Start(11.9-delay)--13
		timerSleepingFogCD:Start(18.4-delay)--19.2
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 243401 and self:AntiSpam(3, 1) then
		timerNoxiousBreathCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 243399 then
		specWarnSleepingFog:Show()
		specWarnSleepingFog:Play("watchstep")
		timerSleepingFogCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 243401 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			warnNoxiousBreath:Show(args.destName, amount)
		end
	elseif args.spellId == 243451 then
		--9.7-20 second timer
		if args:IsPlayer() then
			specWarnMushroom:Show()
			specWarnMushroom:Play("targetyou")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
