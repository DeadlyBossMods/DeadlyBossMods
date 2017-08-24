local mod	= DBM:NewMod(1861, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(115767)--116328 Vellius, 115795 Abyss Stalker, 116329/116843 Sarukel
mod:SetEncounterID(2037)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4)
mod:SetHotfixNoticeRev(16600)
mod.respawnTime = 40

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 230273 232722 230384 234661 232746 232757 230358 230201",
	"SPELL_CAST_SUCCESS 230201 232757 232756",
	"SPELL_AURA_APPLIED 239375 239362 230139 230201 230362 232916 230384 234661",
	"SPELL_AURA_REMOVED 239375 239362 230139 230201",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO: Do more with who has Buffer fish?
--TODO, automate Hydra Shot and assigning of soakers?
--TODO, target scan dark depths?
--TODO, hydra shot lowered to 30 on mythic, see if still 40 in other modes
--[[
(ability.id = 230273 or ability.id = 232722 or ability.id = 230384 or ability.id = 232746 or ability.id = 232757 or ability.id = 232827 or ability.id = 232756 or ability.id = 230358) and type = "begincast" or
(ability.id = 230201 or ability.id = 232745) and type = "cast" or
(target.id = 116329 or target.id = 116843 or target.id = 116328) and type = "death" or
(ability.id = 239375 or ability.id = 239362 or ability.id = 230139) and type = "applydebuff"
--]]
--NOTE: 3 stage fight but all stage 3 stuff is from stage 1 and 2 (combined) so there are no new abilities to list for stage 3 HERE
--General Stuff
local warnHydraShot					= mod:NewTargetCountAnnounce(230139, 4)
local warnDarkDepths				= mod:NewSpellAnnounce(230273, 2, nil, false, 2)
local warnDreadSharkSpawn			= mod:NewSpellAnnounce(239436, 2)
local warnBurdenAll					= mod:NewTargetAnnounce(230214, 2)
--Stage One: Ten Thousand Fangs
local warnThunderingShock			= mod:NewTargetAnnounce(230362, 2, nil, false)
local warnConsumingHunger			= mod:NewTargetAnnounce(230384, 2)
--Stage Two: Terrors of the Deep
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnSummonOssunet				= mod:NewSpellAnnounce(232913, 2)
local warnBefoulingInk				= mod:NewTargetAnnounce(232916, 2, nil, false)--Optional warning if you want to know who's carrying ink
--Stage three
local warnPhase3					= mod:NewPhaseAnnounce(3, 2)

--General Stuff
local specWarnHydraShot				= mod:NewSpecialWarningYou(230139, nil, nil, nil, 1, 2)
local yellHydraShot					= mod:NewPosYell(230139, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
local yellHydraShotFades			= mod:NewIconFadesYell(230139)
local specWarnBurdenofPain			= mod:NewSpecialWarningYou(230201, nil, nil, nil, 1, 2)
local specWarnBurdenofPainTaunt		= mod:NewSpecialWarningTaunt(230201, nil, nil, nil, 1, 2)
local specWarnFromtheAbyss			= mod:NewSpecialWarningSwitch(230227, "-Healer", nil, nil, 1, 2)
--Stage One: Ten Thousand Fangs
local specWarnSlicingTornado		= mod:NewSpecialWarningDodge(232722, nil, nil, nil, 2, 2)
local specWarnThunderingShock		= mod:NewSpecialWarningDodge(230362, nil, nil, nil, 2, 7)
local specWarnThunderingShockDispel	= mod:NewSpecialWarningDispel(230362, "Healer", nil, nil, 1, 2)
local specWarnConsumingHunger		= mod:NewSpecialWarningMoveTo(230384, nil, nil, nil, 1, 7)
--Stage Two: Terrors of the Deep
local specWarnDevouringMaw			= mod:NewSpecialWarningSpell(234621, nil, nil, nil, 2, 7)
local specWarnCrashingWave			= mod:NewSpecialWarningDodge(232827, nil, nil, nil, 3, 2)
--Mythic
local specWarnDeliciousBufferfish	= mod:NewSpecialWarningYou(239375, nil, nil, nil, 1, 2)

--General Stuff
mod:AddTimerLine(GENERAL)
local timerHydraShotCD				= mod:NewCDCountTimer(40, 230139, nil, nil, nil, 3)
local timerBurdenofPainCD			= mod:NewCDCountTimer(27.6, 230201, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--28-32
local timerFromtheAbyssCD			= mod:NewCDTimer(27, 230227, nil, nil, nil, 1)--27-31
--Stage One: Ten Thousand Fangs
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerSlicingTornadoCD			= mod:NewCDCountTimer(43.2, 232722, nil, nil, nil, 3)--43.2-54
local timerConsumingHungerCD		= mod:NewCDTimer(31.6, 230920, nil, nil, nil, 1)
local timerThunderingShockCD		= mod:NewCDTimer(32.2, 230358, nil, nil, nil, 3)
--Stage Two: Terrors of the Deep
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerDevouringMawCD			= mod:NewCDTimer(42, 232745, nil, nil, nil, 3)
local timerCrashingWaveCD			= mod:NewCDCountTimer(40, 232827, nil, nil, nil, 3)
local timerInkCD					= mod:NewCDTimer(41, 232913, nil, nil, nil, 3)
--Stage 3 just stage 2 shit combined
local timerBufferSpawn				= mod:NewNextTimer(20, 239362, nil, nil, nil, 5)

local berserkTimer					= mod:NewBerserkTimer(480)

--General Stuff
local countdownHydraShot			= mod:NewCountdown(40, 230139)
local countdownBurdenofPain			= mod:NewCountdown("Alt28", 230201, "Tank")
--Stage One: Ten Thousand Fangs
local countdownSlicingTorando		= mod:NewCountdown("AltTwo43", 232722)

--General Stuff
local voicePhaseChange				= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceHydraShot				= mod:NewVoice(230139)--targetyou/mm
local voiceBurdenofPain				= mod:NewVoice(230201)--defensive/tauntboss
local voiceFromtheAbyss				= mod:NewVoice(230227, "-Healer")--killmob
--Stage One: Ten Thousand Fangs
local voiceSlicingTornado			= mod:NewVoice(232722)--watchwave?
local voiceThunderingShock			= mod:NewVoice(230362, nil, nil, 2)--helpdispel/movetojelly/watchstep
local voiceConsumingHunger			= mod:NewVoice(230384)--movetojelly (move to jellyfish)
--Stage Two: Terrors of the Deep
local voiceDevouringMaw				= mod:NewVoice(232745)-- inktoshark (bring ink to shark) too long?
local voiceCrashingWave				= mod:NewVoice(232827)--chargemove

mod:AddSetIconOption("SetIconOnHydraShot", 230139, true)
mod:AddBoolOption("TauntOnPainSuccess", false)
--mod:AddInfoFrameOption(227503, true)
--mod:AddRangeFrameOption("5/8/15")

mod.vb.phase = 1
mod.vb.crashingWaveCount = 0
mod.vb.hydraShotCount = 0
mod.vb.burdenCount = 0
mod.vb.tornadoCount = 0
local thunderingShock = GetSpellInfo(230358)
local consumingHunger = GetSpellInfo(230384)
local hydraIcons = {}
local eventsRegistered = false

--/run DBM:GetModByName("1861"):TestHydraShot(1)
function mod:TestHydraShot(icon)
	yellHydraShot:Yell(icon, "Hydra Shot", icon)
	yellHydraShotFades:Countdown(5, nil, icon)
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.crashingWaveCount = 0
	self.vb.hydraShotCount = 0
	self.vb.burdenCount = 0
	self.vb.tornadoCount = 0
	table.wipe(hydraIcons)
	timerThunderingShockCD:Start(10-delay)--10-11
	if not self.Options.TauntOnPainSuccess then
		timerBurdenofPainCD:Start(15.4-delay, 1)
		countdownBurdenofPain:Start(15.4-delay)
	else
		timerBurdenofPainCD:Start(17.9-delay, 1)
		countdownBurdenofPain:Start(17.9-delay)
	end
	timerFromtheAbyssCD:Start(18-delay)
	timerConsumingHungerCD:Start(20-delay)--20-23
	if self:IsEasy() then
		timerSlicingTornadoCD:Start(36-delay, 1)--36
		countdownSlicingTorando:Start(36-delay)
	else
		timerSlicingTornadoCD:Start(30-delay, 1)
		countdownSlicingTorando:Start(30-delay)
		if self:IsMythic() then
			timerBufferSpawn:Start(12.5)
		end
	end
	if not self:IsLFR() then
		timerHydraShotCD:Start(25.4-delay, 1)
		countdownHydraShot:Start(25.4-delay)
		berserkTimer:Start(480)
	end
end

function mod:OnCombatEnd()
	eventsRegistered = false
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 230273 then
		warnDarkDepths:Show()
	elseif spellId == 232722 then
		self.vb.tornadoCount = self.vb.tornadoCount + 1
		specWarnSlicingTornado:Show()
		voiceSlicingTornado:Play("watchwave")
		if self:IsMythic() then
			timerSlicingTornadoCD:Start(34, self.vb.tornadoCount+1)
			countdownSlicingTorando:Start(34)
		else
			timerSlicingTornadoCD:Start(nil, self.vb.tornadoCount+1)
			countdownSlicingTorando:Start()
		end
	elseif spellId == 230384 or spellId == 234661 then
		timerConsumingHungerCD:Start()
	elseif spellId == 232746 then
		specWarnDevouringMaw:Show()
		voiceDevouringMaw:Play("inktoshark")
		timerDevouringMawCD:Start()
	elseif spellId == 232757 then
		specWarnCrashingWave:Show()
		voiceCrashingWave:Play("chargemove")
	elseif spellId == 230358 then
		specWarnThunderingShock:Show()
		if UnitDebuff("player", consumingHunger) then
			voiceThunderingShock:Play("movetojelly")
		else
			voiceThunderingShock:Play("watchstep")
		end
		timerThunderingShockCD:Start()
	elseif spellId == 230201 then
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		if tanking or (status == 3) then
			specWarnBurdenofPain:Show()
			voiceBurdenofPain:Play("defensive")
		else
			if not self.Options.TauntOnPainSuccess then
				local targetName = UnitName("boss1target") or DBM_CORE_UNKNOWN
				if self:AntiSpam(5, targetName) then
					specWarnBurdenofPainTaunt:Show(targetName)
					voiceBurdenofPain:Play("tauntboss")
				end
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 230201 then
		self.vb.burdenCount = self.vb.burdenCount + 1
		if not self.Options.TauntOnPainSuccess then
			timerBurdenofPainCD:Start(25.1, self.vb.burdenCount+1)
			countdownBurdenofPain:Start(25.1)
		else
			timerBurdenofPainCD:Start(27.6, self.vb.burdenCount+1)
			countdownBurdenofPain:Start(27.6)
		end
		if self:IsMythic() and not eventsRegistered then
			eventsRegistered = true
			self:RegisterShortTermEvents(
				"SPELL_DAMAGE 230214"
			)
		end
	elseif spellId == 232757 then
		self.vb.crashingWaveCount = self.vb.crashingWaveCount + 1
		timerCrashingWaveCD:Start(nil, self.vb.crashingWaveCount+1)
	elseif spellId == 232756 then
		warnSummonOssunet:Show()
		if self.vb.phase < 3 then
			timerInkCD:Start(41.8)
		else
			timerInkCD:Start(31)--Variable, not sequence though cause differs pull to pull. just standard variable CD
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 239375 or spellId == 239362 then--Carring Bufferfish (239375 confirmed on mythic)
		if args:IsPlayer() then
			specWarnDeliciousBufferfish:Show()
		end
	elseif spellId == 230139 then
		local isPlayer = args:IsPlayer()
		local name = args.destName
		if not tContains(hydraIcons, name) then
			hydraIcons[#hydraIcons+1] = name
		end
		local count = #hydraIcons
		warnHydraShot:CombinedShow(0.3, self.vb.hydraShotCount, args.destName)
		if args:IsPlayer() then
			specWarnHydraShot:Show()
			if self:IsHard() then
				voiceHydraShot:Play("mm"..count)
			else
				voiceHydraShot:Play("targetyou")
			end
			yellHydraShot:Yell(count, args.spellName, count)
			yellHydraShotFades:Countdown(6, nil, count)
		end
		if self.Options.SetIconOnHydraShot then
			self:SetIcon(name, count)
		end
	elseif spellId == 230201 then
		if not args:IsPlayer() and self:AntiSpam(5, args.destName) then
			specWarnBurdenofPainTaunt:Show(args.destName)
			voiceBurdenofPain:Play("tauntboss")
		end
	elseif spellId == 230362 then
		if self.Options.SpecWarn230362dispel then
			specWarnThunderingShock:CombinedShow(0.3, args.destName)
			if self:AntiSpam(3, 2) and self:IsHealer() then
				voiceThunderingShock:Play("helpdispel")
			end
		else
			warnThunderingShock:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 230384 or spellId == 234661 then--230384
		warnConsumingHunger:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnConsumingHunger:Show(thunderingShock)
			voiceConsumingHunger:Play("movetojelly")
		end
	elseif spellId == 232916 then--Person is carrying ink
		warnBefoulingInk:CombinedShow(1, args.destName)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 239375 or spellId == 239362 then--Carring Bufferfish

	elseif spellId == 230139 then
		if self.Options.SetIconOnHydraShot then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellHydraShotFades:Cancel()
		end
	elseif spellId == 230201 then
		eventsRegistered = false
		self:UnregisterShortTermEvents()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 230214 then
		eventsRegistered = false
		self:UnregisterShortTermEvents()
		warnBurdenAll:Show(ALL)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 230227 and self:AntiSpam(3, 3) then
		specWarnFromtheAbyss:Show()
		voiceFromtheAbyss:Play("killmob")
		timerFromtheAbyssCD:Start()
	elseif spellId == 232753 and not self:IsLFR() then--Hydra Shot
		--event still fires in LFR even though mechanic doesn't exist there, so LFR must be filtered for timer
		table.wipe(hydraIcons)
		self.vb.hydraShotCount = self.vb.hydraShotCount + 1
		if self:IsMythic() or self.vb.phase == 2 then
			timerHydraShotCD:Start(30, self.vb.hydraShotCount+1)
			countdownHydraShot:Start(30)
		else
			timerHydraShotCD:Start(40, self.vb.hydraShotCount+1)
			countdownHydraShot:Start(40)
		end
	elseif spellId == 239423 then--Dread Shark
		if self:IsMythic() then
			--Every two sharks apparently
			--although need more data to confirm, only saw up to 2 sharks in logs and first one didn't phase change 2nd did
			warnDreadSharkSpawn:Show()
			self.vb.phase = self.vb.phase + 0.5
			timerBufferSpawn:Start(21)
		else
			--Non mythic seems to use this for phase change even though there are no dread sharks
			self.vb.phase = self.vb.phase + 1
		end
		if self.vb.phase == 2 then
			self.vb.crashingWaveCount = 0
			self.vb.hydraShotCount = 0
			warnPhase2:Show()
			voicePhaseChange:Play("ptwo")
			timerThunderingShockCD:Stop()
			timerSlicingTornadoCD:Stop()
			countdownSlicingTorando:Cancel()
			timerConsumingHungerCD:Stop()
			timerHydraShotCD:Stop()
			countdownHydraShot:Cancel()
			timerBurdenofPainCD:Stop()
			countdownBurdenofPain:Cancel()
			timerFromtheAbyssCD:Stop()
			
			timerInkCD:Start(11.6)
			if self.Options.TauntOnPainSuccess then
				timerBurdenofPainCD:Start(26, self.vb.burdenCount+1)
				countdownBurdenofPain:Start(26)
			else
				timerBurdenofPainCD:Start(23.5, self.vb.burdenCount+1)
				countdownBurdenofPain:Start(23.5)
			end
			timerFromtheAbyssCD:Start(28)
			timerCrashingWaveCD:Start(30, 1)
			timerDevouringMawCD:Start(40)
			if not self:IsLFR() then
				timerHydraShotCD:Start(15.8, 1)
				countdownHydraShot:Start(15.8)
			end
		elseif self.vb.phase == 3 then
			self.vb.crashingWaveCount = 0
			self.vb.hydraShotCount = 0
			warnPhase3:Show()
			voicePhaseChange:Play("pthree")
			timerCrashingWaveCD:Stop()
			timerInkCD:Stop()
			timerHydraShotCD:Stop()
			countdownHydraShot:Cancel()
			timerBurdenofPainCD:Stop()
			countdownBurdenofPain:Cancel()
			timerDevouringMawCD:Stop()
			timerFromtheAbyssCD:Stop()
			
			timerInkCD:Start(11.6)
			if self.Options.TauntOnPainSuccess then
				timerBurdenofPainCD:Start(26, self.vb.burdenCount+1)
				countdownBurdenofPain:Start(26)
			else
				timerBurdenofPainCD:Start(23.5, self.vb.burdenCount+1)
				countdownBurdenofPain:Start(23.5)
			end
			timerFromtheAbyssCD:Start(28)
			timerCrashingWaveCD:Start(30, 1)
			timerConsumingHungerCD:Start(39)--SUCCESS
			timerSlicingTornadoCD:Start(51, self.vb.tornadoCount+1)
			countdownSlicingTorando:Start(51)
			if not self:IsLFR() then
				timerHydraShotCD:Start(15.8, 1)
				countdownHydraShot:Start(15.8)
			end
		end
	end
end

