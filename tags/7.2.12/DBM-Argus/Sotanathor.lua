local mod	= DBM:NewMod(2014, "DBM-Argus", nil, 959)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(109331)
--mod:SetEncounterID(1952)--Does not have one
--mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

--[[
mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--local warnAncientRageFire		= mod:NewSpellAnnounce(217563, 2)

--local specBurningBomb			= mod:NewSpecialWarningYou(217877, nil, nil, nil, 1, 2)
--local yellBurningBomb			= mod:NewFadesYell(217877)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

--local timerBurningBombCD		= mod:NewAITimer(13.4, 217877, nil, nil, nil, 3)

--local voiceBurningBomb			= mod:NewVoice(217877)--targetyou
--local voiceGTFO						= mod:NewVoice(238028, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway

--mod:AddReadyCheckOption(43193, false)
--mod:AddRangeFrameOption(10, 217877)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 217966 then

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 217877 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 217877 then

	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 217877 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 217907 and destGUID == UnitGUID("player") and self:AntiSpam(2, 5) then
		specWarnGTFO:Show()
		voiceGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 217563 and self:AntiSpam(4, 1) then

	end
end
--]]
