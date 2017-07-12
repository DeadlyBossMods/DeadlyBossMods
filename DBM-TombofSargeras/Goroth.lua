local mod	= DBM:NewMod(1862, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(115844)
mod:SetEncounterID(2032)
mod:SetZone()
--mod:SetUsedIcons(1)
mod:SetHotfixNoticeRev(16280)
mod.respawnTime = 14

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 233062",
	"SPELL_CAST_SUCCESS 231363 233272",
	"SPELL_AURA_APPLIED 233272 231363",
	"SPELL_AURA_REMOVED 233272 231363",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_AURA_UNFILTERED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO: Possibly warnings if mess up soaking brimstone?
--TODO, Fel Eruption stuff (GTFO? etc?)
--[[
(ability.id = 233062) and type = "begincast"
 or (ability.id = 232249 or ability.id = 231363 or ability.id = 233272) and type = "cast"
 or ability.name = "Rain of Brimstone"
--]]
local warnInfernalSpike					= mod:NewSpellAnnounce(233055, 1)
local warnShatteringStar				= mod:NewTargetAnnounce(233272, 3)
local warnCrashingComet					= mod:NewTargetAnnounce(232249, 4)

local specWarnInfernalBurning			= mod:NewSpecialWarningMoveTo(233062, nil, nil, nil, 3, 2)
local specWarnShatteringStar			= mod:NewSpecialWarningMoveTo(233272, nil, nil, nil, 3, 2)
local yellShatteringStar				= mod:NewFadesYell(233272)
local specWarnCrashingComet				= mod:NewSpecialWarningMoveAway(232249, nil, nil, nil, 3, 2)
local yellCrashingComet					= mod:NewFadesYell(232249)
local specWarnBurningArmor				= mod:NewSpecialWarningMoveAway(231363, nil, nil, nil, 3, 2)
local specWarnBurningArmorTaunt			= mod:NewSpecialWarningTaunt(231363, nil, nil, nil, 1, 2)
local specWarnRainofBrimstone			= mod:NewSpecialWarningMoveTo(238587, "-Tank", nil, 2, 1, 6)

local timerInfernalBurningCD			= mod:NewNextTimer(59.9, 233062, nil, nil, nil, 2)
local timerShatteringStarCD				= mod:NewNextCountTimer(31, 233272, nil, nil, nil, 3)
local timerShatteringStar				= mod:NewBuffFadesTimer(6, 233272, nil, nil, nil, 5)
local timerCrashingComet				= mod:NewBuffFadesTimer(5, 232249, nil, nil, nil, 5)
local timerCrashingCometCD				= mod:NewCDTimer(18.2, 232249, nil, nil, nil, 3)--18.2-24.7
local timerInfernalSpikeCD				= mod:NewCDTimer(16.2, 233055, nil, nil, nil, 3)--16.2-20.7
local timerBurningArmorCD				= mod:NewCDTimer(24.3, 231363, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerBurningArmor					= mod:NewBuffFadesTimer(6, 231363, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON)
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerRainofBrimstoneCD			= mod:NewCDCountTimer(31, 238587, nil, nil, nil, 5, nil, DBM_CORE_HEROIC_ICON)
local timerRainofBrimstone				= mod:NewCastTimer(8, 238587, 87701, nil, nil, 5, nil, DBM_CORE_HEROIC_ICON)

--local berserkTimer					= mod:NewBerserkTimer(300)

local countdownInfernalBurning			= mod:NewCountdown(60, 233062)
local countdownShatteringStar			= mod:NewCountdown("AltTwo6", 233272)
local countdownShatteringStarFades		= mod:NewCountdownFades("AltTwo6", 233272)
local countdownCrashingComet			= mod:NewCountdownFades("Alt5", 232249)--Assume for now tank will never get comets and dps will never get burning armor
local countdownBurningArmor				= mod:NewCountdownFades("Alt6", 231363)--^^

local voiceInfernalBurning				= mod:NewVoice(233062)--findshelter
local voiceShatteringStar				= mod:NewVoice(233272)--runout (maybe custom voice that says "kite through spikes"?)
local voiceCrashingComet				= mod:NewVoice(232249)--runout
local voiceBurningArmor					= mod:NewVoice(231363)--runout/tauntboss
local voiceRainofBrimstone				= mod:NewVoice(238587, "-Tank", nil, 2)--helpsoak

--mod:AddSetIconOption("SetIconOnShield", 228270, true)
--mod:AddInfoFrameOption(227503, true)
mod:AddRangeFrameOption("10/25")

local infernalSpike = GetSpellInfo(233021)
local crashingComet = GetSpellInfo(232249)
local tankDebuff = GetSpellInfo(234264)
local cometTable = {}
local shatteringStarTimers = {24, 60, 60, 50}--24, 60, 60, 50, 20, 40, 20, 40, 20, 40
--["232249-Crashing Comet"] = "pull:8.5, 18.3, 18.3, 18.1, 18.5, 18.3, 22.0, 18.3, 18.2, 25.6, 18.3", --Heroic
--["233050-Infernal Spike"] = "pull:4.1, 16.7, 17.1, 23.2, 17.1, 17.1, 17.1, 16.3, 16.7, 17.0, 20.7, 17.0", --Infernal Spike
mod.vb.shatteringStarCount = 0
mod.vb.brimstoneCount = 0

function mod:OnCombatStart(delay)
	table.wipe(cometTable)
	self.vb.shatteringStarCount = 0
	timerInfernalSpikeCD:Start(4-delay)
	timerCrashingCometCD:Start(8.5-delay)
	timerBurningArmorCD:Start(10.5-delay)
	timerInfernalBurningCD:Start(54-delay)
	if self:IsMythic() then
		self.vb.brimstoneCount = 0
		timerRainofBrimstoneCD:Start(12.1-delay, 1)--12.1-14
		timerShatteringStarCD:Start(34-delay, 1)
		countdownShatteringStar:Start(34-delay)
	else
		timerShatteringStarCD:Start(24-delay, 1)
		countdownShatteringStar:Start(24-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 233062 then
		specWarnInfernalBurning:Show(infernalSpike)
		voiceInfernalBurning:Play("findshelter")
		--voiceInfernalBurning:Schedule(3.5, "safenow")
		timerInfernalBurningCD:Start()
		countdownInfernalBurning:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 231363 then
		timerBurningArmorCD:Start()
	elseif spellId == 233272 then
		self.vb.shatteringStarCount = self.vb.shatteringStarCount + 1
		local nextCount = self.vb.shatteringStarCount+1
		if self:IsMythic() then
			--["233272-Shattering Star"] = "pull:34.8, 61.2, 60.4, 60.8, 32.9, 30.5, 29.6, 30.4",
			if nextCount > 4 then
				timerShatteringStarCD:Start(29.2, nextCount)
				countdownShatteringStar:Start(29.2)
			else
				timerShatteringStarCD:Start(60, nextCount)
				countdownShatteringStar:Start(60)
			end
		else
			local timer = shatteringStarTimers[nextCount]
			if timer then
				timerShatteringStarCD:Start(timer, nextCount)
				countdownShatteringStar:Start(timer)
			else
				if self.vb.shatteringStarCount % 2 == 0 then
					timerShatteringStarCD:Start(20, nextCount)
					countdownShatteringStar:Start(20)
				else
					timerShatteringStarCD:Start(40, nextCount)
					countdownShatteringStar:Start(40)
				end
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 233272 then
		if args:IsPlayer() then--Still do yell and range frame here, in case DK
			specWarnShatteringStar:Show(infernalSpike)
			voiceShatteringStar:Play("runout")
			yellShatteringStar:Yell(6)
			yellShatteringStar:Schedule(5, 1)
			yellShatteringStar:Schedule(4, 2)
			yellShatteringStar:Schedule(3, 3)
			countdownShatteringStarFades:Start()
			timerShatteringStar:Start()
		else
			warnShatteringStar:Show(args.destName)
		end
	elseif spellId == 231363 then
		if args:IsPlayer() then
			specWarnBurningArmor:Show()
			voiceBurningArmor:Play("runout")
			if self:IsTank() then
				countdownBurningArmor:Start()
			end
			timerBurningArmor:Start()
			if self.Options.RangeFrame then
				if self:IsEasy() then
					DBM.RangeCheck:Show(10)
				elseif self:IsHeroic() then
					DBM.RangeCheck:Show(25)--Will round up to 30
				else
					DBM.RangeCheck:Show(40)
				end
			end
		else
			local _, _, _, _, _, _, expires = UnitDebuff("player", tankDebuff)
			if expires then
				local remaining = expires-GetTime()
				specWarnBurningArmorTaunt:Schedule(remaining, args.destName)
				voiceBurningArmor:Schedule(remaining, "tauntboss")
			else
				specWarnBurningArmorTaunt:Show(args.destName)
				voiceBurningArmor:Play("tauntboss")
			end
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 233272 then
		if args:IsPlayer() then
			yellShatteringStar:Cancel()
			countdownShatteringStarFades:Cancel()
			timerShatteringStar:Stop()
		end
	elseif spellId == 231363 then
		if args:IsPlayer() then
			countdownBurningArmor:Cancel()
			timerBurningArmor:Stop()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 230345 and args:IsPlayer() then
		yellCrashingComet:Cancel()
		timerCrashingComet:Stop()
		countdownCrashingComet:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
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
	local hasDebuff, _, _, _, _, _, _, _, _, _, spellId = UnitDebuff(uId, crashingComet)
	local name = DBM:GetUnitFullName(uId)
	if hasDebuff and not cometTable[name] and spellId == 232249 then
		cometTable[name] = true
		warnCrashingComet:CombinedShow(0.5, name)--Multiple targets in heroic/mythic
		if UnitIsUnit(uId, "player") then
			specWarnCrashingComet:Show()
			voiceCrashingComet:Play("runout")
			yellCrashingComet:Yell(5)
			yellCrashingComet:Countdown(5)
			timerCrashingComet:Start()
			countdownCrashingComet:Start()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10, nil, nil, nil, nil, 5)
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 233050 then--Infernal Spike
		warnInfernalSpike:Show()
		timerInfernalSpikeCD:Start()
	elseif spellId == 233285 then--Rain of Brimston
		self.vb.brimstoneCount = self.vb.brimstoneCount + 1
		local nextCount = self.vb.brimstoneCount+1
		specWarnRainofBrimstone:Show(spellName)
		voiceRainofBrimstone:Play("helpsoak")
		--["233285-Rain of Brimstone"] = "pull:12.1, 60.4, 60.8, 60.8, 68.2, 60.0",
		--["233285-Rain of Brimstone"] = "pull:12.2, 60.8, 60.8, 60.5, 68.5",
		--["233285-Rain of Brimstone"] = "pull:12.5, 60.8, 60.8, 60.8, 67.2",
		if nextCount == 5 then
			timerRainofBrimstoneCD:Start(67.2, nextCount)
			timerRainofBrimstone:Start(67.2)
		else
			timerRainofBrimstoneCD:Start(60, nextCount)
			timerRainofBrimstone:Start()
		end
	elseif spellId == 232249 then
		table.wipe(cometTable)
		timerCrashingCometCD:Start()
	end
end

