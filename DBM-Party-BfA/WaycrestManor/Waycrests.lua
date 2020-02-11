local mod	= DBM:NewMod(2128, "DBM-Party-BfA", 10, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(131527, 131545)
mod:SetMainBossID(131545)
mod:SetEncounterID(2116)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 261440",
	"SPELL_CAST_START 268306 261440",
	"SPELL_CAST_SUCCESS 261438",
	"UNIT_DIED"
)

--TODO, more/better timer data, because Lady Waycrest will interrupt Cadenza casts to cast vitaly transfer, so on normal mode her health drops too fast for meaningful Cd data
--TODO, Contanous Remnants doesn't seem to have a valid debuff spellID that has a duration in tooltip data, so figure out what to use for it on heroic
local warnVirulentPathogen			= mod:NewTargetAnnounce(261440, 2)

local specWarnDiscordantCadenza		= mod:NewSpecialWarningDodge(268306, nil, nil, nil, 2, 2)
local specWarnVirulentPathogen		= mod:NewSpecialWarningMoveAway(261440, nil, nil, nil, 1, 2)
local yellVirulentPathogen			= mod:NewShortYell(261440)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

local timerWastingStrikeCD			= mod:NewCDTimer(16.5, 261438, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 3)--16.5-17.1
local timerVirulentPathogenCD		= mod:NewCDTimer(15.4, 261440, nil, nil, nil, 3, nil, DBM_CORE_DISEASE_ICON, nil, 1, 3)--15.4-17
local timerDiscordantCadenzaCD		= mod:NewCDTimer(22.6, 268306, nil, nil, nil, 3)--pull:16.1, 3.6, 19.4, 17.0

mod:AddRangeFrameOption(6, 261440)

function mod:OnCombatStart(delay)
	timerWastingStrikeCD:Start(6-delay)
	timerVirulentPathogenCD:Start(10.5-delay)
	timerDiscordantCadenzaCD:Start(15.5-delay)
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
	if spellId == 261440 then
		warnVirulentPathogen:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnVirulentPathogen:Show()
			specWarnVirulentPathogen:Play("scatter")
			yellVirulentPathogen:Yell()
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 268306 and self:AntiSpam(6, 1) then--Antispam in case she interrupts cast to cast transfer, then casts it a second time
		specWarnDiscordantCadenza:Show()
		specWarnDiscordantCadenza:Play("watchstep")
		timerDiscordantCadenzaCD:Start()
	elseif spellId == 261440 then
		timerVirulentPathogenCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 261438 then
		timerWastingStrikeCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 131527 then--Lord Waycrest
		timerWastingStrikeCD:Stop()
		timerVirulentPathogenCD:Stop()
	end
end
