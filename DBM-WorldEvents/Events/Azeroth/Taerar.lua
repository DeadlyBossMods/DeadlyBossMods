local mod	= DBM:NewMod("Taerar", "DBM-WorldEvents", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(121911)--121911 TW ID, 14890 classic ID
--mod:SetModelID(17887)

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 243661 243401",
	"SPELL_CAST_SUCCESS 243399",
	"SPELL_AURA_APPLIED 243401",
	"SPELL_AURA_APPLIED_DOSE 243401"
)

--TODO, maybe taunt special warnings for classic version when it matters more.
local warnNoxiousBreath			= mod:NewStackAnnounce(243401, 2, nil, "Tank")
local warningBellowingRoar		= mod:NewSpellAnnounce(243661, 3)

local specWarnSleepingFog		= mod:NewSpecialWarningDodge(243399, nil, nil, nil, 2, 2)

local timerNoxiousBreathCD		= mod:NewCDTimer(19.4, 243401, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Iffy
local timerSleepingFogCD		= mod:NewCDTimer(17, 243399, nil, nil, nil, 3)
local timerBellowingRoarCD		= mod:NewCDTimer(4.8, 243661, nil, nil, nil, 2)

--mod:AddReadyCheckOption(48620, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		timerBellowingRoarCD:Start(10.5-delay)
		timerNoxiousBreathCD:Start(14.3-delay)
		timerSleepingFogCD:Start(21.5-delay)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 243661 and self:AntiSpam(3, 1) then
		warningBellowingRoar:Show()
		timerBellowingRoarCD:Start()
	elseif args.spellId == 243401 and self:AntiSpam(3, 2) then
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
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
