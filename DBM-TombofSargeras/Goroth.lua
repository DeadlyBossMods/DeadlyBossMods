local mod	= DBM:NewMod(1862, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(115844)
mod:SetEncounterID(2032)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(15581)
mod.respawnTime = 14

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 233062",
	"SPELL_CAST_SUCCES 232249 231363 238587",
	"SPELL_AURA_APPLIED 233272 232249 231363",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 233272 232249 231363",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_AURA_UNFILTERED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO: Possibly SPELL_SUMMON event for 233266 in case you screw up brimstone to deal with adds
--TODO, better option defaults, especially brimstone
--TODO, NP Auras for comments or stars?
--TODO, generic Inferal Spike warnings/timers?
--TODO, Fel Eruption stuff (GTFO? etc?)
local warnShatteringStar				= mod:NewTargetAnnounce(233272, 3)
local warnCrashingComet					= mod:NewTargetAnnounce(232249, 4)

local specWarnInfernalBurning			= mod:NewSpecialWarningMoveTo(233062, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge:format(233062), nil, 3, 2)
local specWarnShatteringStar			= mod:NewSpecialWarningMoveAway(233272, nil, nil, nil, 3, 2)
local yellShatteringStar				= mod:NewFadesYell(233272)
local specWarnCrashingComet				= mod:NewSpecialWarningMoveAway(232249, nil, nil, nil, 3, 2)
local yellCrashingComet					= mod:NewFadesYell(232249)
local specWarnBurningArmor				= mod:NewSpecialWarningMoveAway(231363, nil, nil, nil, 1, 2)
local specWarnBurningArmorTaunt			= mod:NewSpecialWarningTaunt(231363, nil, nil, nil, 1, 2)
local specWarnRainofBrimstone			= mod:NewSpecialWarningMoveTo(238587, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(238587), nil, 1, 6)

local timerInfernalBurningCD			= mod:NewAITimer(31, 233062, nil, nil, nil, 2)
local timerShatteringStarCD				= mod:NewAITimer(31, 233272, nil, nil, nil, 3)
local timerShatteringStar				= mod:NewBuffFadesTimer(6, 233272, nil, nil, nil, 5)
local timerCrashingCometCD				= mod:NewAITimer(31, 232249, nil, nil, nil, 3)
local timerCrashingComet				= mod:NewBuffFadesTimer(5, 232249, nil, nil, nil, 5)
local timerBurningArmorCD				= mod:NewAITimer(31, 231363, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerBurningArmor					= mod:NewBuffFadesTimer(3, 231363, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON)
local timerRainofBrimstoneCD			= mod:NewAITimer(31, 238587, nil, nil, nil, 1)

--local berserkTimer					= mod:NewBerserkTimer(300)

local countdownInfernalBurning			= mod:NewCountdown(30, 233062)
local countdownShatteringStar			= mod:NewCountdownFades("AltTwo6", 233272)
local countdownCrashingComet			= mod:NewCountdownFades("Alt5", 232249)--Assume for now tank will never get comets and dps will never get burning armor
local countdownBurningArmor				= mod:NewCountdownFades("Alt6", 231363)--^^

local voiceInfernalBurning				= mod:NewVoice(233062)--findshelter
local voiceShatteringStar				= mod:NewVoice(233272)--runout (maybe custom voice that says "kite through spikes"?)
local voiceCrashingComet				= mod:NewVoice(232249)--runout
local voiceBurningArmor					= mod:NewVoice(231363)--runout/tauntboss
local voiceRainofBrimstone				= mod:NewVoice(238587)--helpsoak

--mod:AddSetIconOption("SetIconOnShield", 228270, true)
--mod:AddInfoFrameOption(227503, true)
mod:AddRangeFrameOption("10/25")

local infernalSpike = GetSpellInfo(233021)
local crashingComet = GetSpellInfo(232249)
local cometTable = {}

function mod:OnCombatStart(delay)
	table.wipe(cometTable)
	timerInfernalBurningCD:Start(1-delay)
	timerShatteringStarCD:Start(1-delay)
	timerCrashingCometCD:Start(1-delay)
	timerBurningArmorCD:Start(1-delay)
	timerRainofBrimstoneCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 233062 then
		specWarnInfernalBurning:Show(infernalSpike)
		voiceInfernalBurning:Play("findshelter")
		--voiceShockwave:Schedule(3.5, "safenow")
		timerInfernalBurningCD:Start()
		--countdownInfernalBurning:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 232249 then
		--timerCrashingCometCD:Start()
	elseif spellId == 231363 then
		timerBurningArmorCD:Start()
	elseif spellId == 238587 and self:AntiSpam(5, 1) then
		specWarnRainofBrimstone:Show(args.spellName)
		voiceRainofBrimstone:Play("helpsoak")
		timerRainofBrimstoneCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 233272 then
		timerShatteringStarCD:Start()
		if args:IsPlayer() then--Still do yell and range frame here, in case DK
			specWarnShatteringStar:Show()
			voiceShatteringStar:Play("runout")
			yellShatteringStar:Yell(6)
			yellShatteringStar:Schedule(5, 1)
			yellShatteringStar:Schedule(4, 2)
			yellShatteringStar:Schedule(3, 3)
			countdownShatteringStar:Start()
			timerShatteringStar:Start()
		else
			warnShatteringStar:Show(args.destName)
		end
	elseif spellId == 232249 then
		--warnCrashingComet:CombinedShow(0.3, args.destName)
		--[[if args:IsPlayer() then--Still do yell and range frame here, in case DK
			specWarnCrashingComet:Show()
			voiceCrashingComet:Play("runout")
			yellCrashingComet:Yell(5)
			yellCrashingComet:Schedule(4, 1)
			yellCrashingComet:Schedule(3, 2)
			yellCrashingComet:Schedule(2, 3)
			timerCrashingComet:Start()
			countdownCrashingComet:Start()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end--]]
	elseif spellId == 231363 then
		if args:IsPlayer() then
			specWarnBurningArmor:Show()
			voiceBurningArmor:Play("runout")
			countdownBurningArmor:Start()
			timerBurningArmor:Start()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(25)--Will round up to 28
			end
		else
			specWarnBurningArmorTaunt:Show(args.destName)
			voiceBurningArmor:Play("tauntboss")
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 233272 then
		if args:IsPlayer() then
			yellShatteringStar:Cancel()
			countdownShatteringStar:Cancel()
			timerShatteringStar:Stop()
		end
	elseif spellId == 232249 then
		--[[if args:IsPlayer() then
			yellCrashingComet:Cancel()
			timerCrashingComet:Stop()
			countdownCrashingComet:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end--]]
	elseif spellId == 231363 then
		if args:IsPlayer() then
			countdownBurningArmor:Cancel()
			timerBurningArmor:Stop()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnDancingBlade:Show()
--		voiceDancingBlade:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:228162") then

	end
end
--]]

function mod:UNIT_AURA_UNFILTERED(uId)
	local hasDebuff = UnitDebuff(uId, crashingComet)
	local name = DBM:GetUnitFullName(uId)
	if not hasDebuff and cometTable[name] then
		cometTable[name] = nil
		if UnitIsUnit(uId, "player") then
			yellCrashingComet:Cancel()
			timerCrashingComet:Stop()
			countdownCrashingComet:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif hasDebuff and not cometTable[name] then
		cometTable[name] = true
		if UnitIsUnit(uId, "player") then
			specWarnCrashingComet:Show()
			voiceCrashingComet:Play("runout")
			yellCrashingComet:Yell(5)
			yellCrashingComet:Schedule(4, 1)
			yellCrashingComet:Schedule(3, 2)
			yellCrashingComet:Schedule(2, 3)
			timerCrashingComet:Start()
			countdownCrashingComet:Start()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		else
			warnCrashingComet:Show(name)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 232249 then--Crashing Comet
		timerCrashingCometCD:Start()
	end
end

