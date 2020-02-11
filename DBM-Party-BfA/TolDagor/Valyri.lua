local mod	= DBM:NewMod(2099, "DBM-Party-BfA", 9, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(127490)
mod:SetEncounterID(2103)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 257028",
	"SPELL_CAST_START 256955 256970",
	"SPELL_CAST_SUCCESS 257028"
)

--local warnSwirlingScythe			= mod:NewTargetAnnounce(195254, 2)

local specWarnCinderflame			= mod:NewSpecialWarningDodge(256955, nil, nil, nil, 2, 2)
local specWarnFuselighter			= mod:NewSpecialWarningYou(257028, nil, nil, nil, 1, 2)
local yellFuselighter				= mod:NewYell(257028, nil, false)
local specWarnFuselighterOther		= mod:NewSpecialWarningDispel(257028, "Healer", nil, nil, 1, 2)
local specWarnIgnition				= mod:NewSpecialWarningSpell(256970, nil, nil, nil, 1, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

local timerCinderflameCD			= mod:NewCDTimer(20.5, 256955, nil, nil, nil, 3)
local timerFuselighterCD			= mod:NewCDTimer(14.7, 257028, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)--14.7-23, health based?
local timerIgnitionCD				= mod:NewCDTimer(32.7, 256970, nil, nil, nil, 5)--Health based?

function mod:OnCombatStart(delay)
	timerIgnitionCD:Start(6.1-delay)
	timerFuselighterCD:Start(14.2-delay)--SUCCESS
	timerCinderflameCD:Start(18.2-delay)--START
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 257028 then
		if args:IsPlayer() then
			specWarnFuselighter:Show()
			specWarnFuselighter:Play("targetyou")
			yellFuselighter:Yell()
		elseif self:CheckDispelFilter() then
			specWarnFuselighterOther:Show(args.destName)
			specWarnFuselighterOther:Play("helpdispel")
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 256955 then
		specWarnCinderflame:Show()
		specWarnCinderflame:Play("shockwave")
		timerCinderflameCD:Start()
	elseif spellId == 256970 then
		specWarnIgnition:Show()
		specWarnIgnition:Play("firecircle")--Doesn't really say what to do, but at leat accurate description!
		timerIgnitionCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 257028 then
		timerFuselighterCD:Start()
	end
end
