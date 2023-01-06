local mod	= DBM:NewMod(2517, "DBM-DragonIsles", nil, 1205)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(193532)
mod:SetEncounterID(2653)
mod:SetReCombatTime(20)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")
--mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 389431 389725 389514 391247",
	"SPELL_CAST_SUCCESS 390635"
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
)

--TODO, magma eruption targets? could not find a debuff ID, it might use emote/whisper
--TODO, does he return to P1 after a while of infusion?
--TODO, likely fix rain event
--Phase One
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25874))
local warnMagmaEruption					= mod:NewSpellAnnounce(389725, 2)
--local warnDarkDeterrence				= mod:NewStackAnnounce(361390, 2, nil, "Tank|Healer")

local specWarnDeterringFlame			= mod:NewSpecialWarningSpell(389431, nil, nil, nil, 2, 2)
local specWarnLavaBreath				= mod:NewSpecialWarningDodge(389514, nil, nil, nil, 2, 2)

local timerDeterringFlameCD				= mod:NewAITimer(74.7, 389431, nil, nil, nil, 2)
local timerMagmaEruptionCD				= mod:NewAITimer(53.4, 389725, nil, nil, nil, 3)
local timerLavaBreathCD					= mod:NewAITimer(43.1, 389514, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
--local timerDeterrentStrikeCD			= mod:NewAITimer(9.7, 361387, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Phase Two
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25878))
local warnFlameInfusion					= mod:NewCastAnnounce(391247, 2)

local specWarnRainofDestruction			= mod:NewSpecialWarningSpell(390635, nil, nil, nil, 2, 2)

local timerRainofDestructionCD			= mod:NewAITimer(74.7, 390635, nil, nil, nil, 2)

--mod:AddRangeFrameOption(5, 361632)

function mod:OnCombatStart(delay, yellTriggered)
	self:SetStage(1)
--	if yellTriggered then
		--timerDeterringFlameCD:Start(1)
		--timerMagmaEruptionCD:Start(1)
		--timerLavaBreathCD:Start(1)
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

--function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--end


function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 389431 then
		specWarnDeterringFlame:Show()
		specWarnDeterringFlame:Play("carefly")
		timerDeterringFlameCD:Start()
	elseif spellId == 389725 then
		warnMagmaEruption:Show()
		timerMagmaEruptionCD:Start()
	elseif spellId == 389514 then
		specWarnLavaBreath:Show()
		specWarnLavaBreath:Play("breathsoon")
		timerLavaBreathCD:Start()
	elseif spellId == 391247 then
		self:SetStage(2)
		warnFlameInfusion:Show()
		timerDeterringFlameCD:Stop()
		timerMagmaEruptionCD:Stop()
		timerLavaBreathCD:Stop()
		--P2 timer start
		timerMagmaEruptionCD:Start(2)
		timerLavaBreathCD:Start(2)
		timerRainofDestructionCD:Start(2)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 390635 then
		specWarnRainofDestruction:Show()
		specWarnRainofDestruction:Play("specialsoon")
		timerRainofDestructionCD:Start()
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 361632 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 361632 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 361335 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]
