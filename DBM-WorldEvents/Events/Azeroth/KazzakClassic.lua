local mod	= DBM:NewMod("KazzakClassic", "DBM-WorldEvents", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(121818)--121818 TW ID, 12397 classic ID
--mod:SetModelID(17887)

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 243712",
	"SPELL_AURA_APPLIED 243713 243723 156598",
	"SPELL_AURA_APPLIED_DOSE 243713"
)

--TODO, maybe add yells for classic version, for timewalking version, it just doens't matter if marks don't run out
local warnVoidBolt				= mod:NewStackAnnounce(243713, 2, nil, "Tank")
local warningFrenzy				= mod:NewSpellAnnounce(156598, 3)
local warningMark				= mod:NewTargetAnnounce(243723, 4)
local warningShadowBoltVolley	= mod:NewSpellAnnounce(243712, 2)

local specWarnMark				= mod:NewSpecialWarningMoveAway(243723, nil, nil, nil, 1, 2)

local timerVoidBoltCD			= mod:NewCDTimer(27.8, 243713, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)--Iffy
local timerMarkCD				= mod:NewCDTimer(13.3, 243723, nil, nil, nil, 3, nil, DBM_CORE_L.MAGIC_ICON)
--local timerShadowBoltVolleyCD	= mod:NewCDTimer(7.6, 243712, nil, nil, nil, 2)

--mod:AddReadyCheckOption(48620, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		timerVoidBoltCD:Start(8.3-delay)
		--timerShadowBoltVolleyCD:Start(11.5-delay)
		timerMarkCD:Start(14.1-delay)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 243712 then
		warningShadowBoltVolley:Show()
		--timerShadowBoltVolleyCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 243713 then
		local amount = args.amount or 1
		warnVoidBolt:Show(args.destName, amount)
		timerVoidBoltCD:Start()
	elseif spellId == 156598 then
		warningFrenzy:Show()
	elseif spellId == 243723 then
		warningMark:CombinedShow(0.5, args.destName)
		timerMarkCD:DelayedStart(0.5)
		if args:IsPlayer() then
			specWarnMark:Show()
			specWarnMark:Play("runout")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
