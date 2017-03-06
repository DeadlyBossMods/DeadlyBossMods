local mod	= DBM:NewMod(1861, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(115767)--116328 Vellius, 115795 Abyss Stalker, 116329/116843 Sarukel
mod:SetEncounterID(2037)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4)
--mod:SetHotfixNoticeRev(15581)
mod.respawnTime = 40

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 230273 232722 230384 232746 232757 232756 230358",
	"SPELL_CAST_SUCCESS 230201",
	"SPELL_AURA_APPLIED 239375 239362 230139 230201 230362 232916 230384",
	"SPELL_AURA_REMOVED 239375 239362 230139",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO: Do more with who has Buffer fish?
--TODO, automate Hydra Shot and assigning of soakers?
--TODO, target scan dark depths?
--TODO, New voice movetojelly (move to jellyfish).
--TOOD, New voice inktoshark (bring ink to shark)
--[[
(ability.id = 230273 or ability.id = 232722 or ability.id = 230384 or ability.id = 232746 or ability.id = 232757 or ability.id = 232827 or ability.id = 232756 or ability.id = 230358) and type = "begincast" or
(ability.id = 230201 or ability.id = 232745) and type = "cast" or
(target.id = 116329 or target.id = 116843 or target.id = 116328) and type = "death" or
(ability.id = 239375 or ability.id = 239362 or ability.id = 230139) and type = "applydebuff"
--]]
--NOTE: 3 stage fight but all stage 3 stuff is from stage 1 and 2 (combined) so there are no new abilities to list for stage 3 HERE
--General Stuff
local warnHydraShot					= mod:NewTargetAnnounce(230139, 4)
local warnDarkDepths				= mod:NewSpellAnnounce(230273, 2)
local warnDreadSharkSpawn			= mod:NewSpellAnnounce(239436, 2)
--Stage One: Ten Thousand Fangs
local warnThunderingShock			= mod:NewTargetAnnounce(230362, 2, nil, false)
local warnConsumingHunger			= mod:NewTargetAnnounce(230384, 2)
--Stage Two: Terrors of the Deep
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnSummonOssunet				= mod:NewSpellAnnounce(232756, 2)
local warnBefoulingInk				= mod:NewTargetAnnounce(232916, 2, nil, false)--Optional warning if you want to know who's carrying ink
--Stage three
local warnPhase3					= mod:NewPhaseAnnounce(3, 2)

--General Stuff
local specWarnHydraShot				= mod:NewSpecialWarningYou(230139, nil, nil, nil, 1, 2)
local yellHydraShot					= mod:NewPosYell(230139)
local specWarnBurdenofPain			= mod:NewSpecialWarningYou(230201, nil, nil, nil, 1, 2)
local specWarnBurdenofPainTaunt		= mod:NewSpecialWarningTaunt(230201, nil, nil, nil, 1, 2)
local specWarnFromtheAbyss			= mod:NewSpecialWarningSwitch(230227, "-Healer", nil, nil, 1, 2)
--Stage One: Ten Thousand Fangs
local specWarnSlicingTornado		= mod:NewSpecialWarningDodge(232722, nil, nil, nil, 2, 2)
local specWarnThunderingShock		= mod:NewSpecialWarningDodge(230362, nil, nil, nil, 2, 7)
local specWarnThunderingShockDispel	= mod:NewSpecialWarningDispel(230362, "Healer", nil, nil, 1, 2)
local specWarnConsumingHunger		= mod:NewSpecialWarningMoveTo(230384, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(230920), nil, 1, 7)
--Stage Two: Terrors of the Deep
local specWarnDevouringMaw			= mod:NewSpecialWarningSpell(232745, nil, nil, nil, 2, 7)
local specWarnCrashingWave			= mod:NewSpecialWarningDodge(232827, nil, nil, nil, 3, 2)
--Mythic
local specWarnDeliciousBufferfish	= mod:NewSpecialWarningYou(239375, nil, nil, nil, 1, 2)

--General Stuff
local timerHydraShotCD				= mod:NewCDTimer(40, 230139, nil, nil, nil, 3)
local timerBurdenofPainCD			= mod:NewCDTimer(28, 230201, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--28-32
local timerFromtheAbyssCD			= mod:NewCDTimer(27, 230227, nil, nil, nil, 1)--27-31
--Stage One: Ten Thousand Fangs
local timerSlicingTornadoCD			= mod:NewCDTimer(45, 232722, nil, nil, nil, 3)--45-54
local timerConsumingHungerCD		= mod:NewCDTimer(32, 230920, nil, nil, nil, 1)
local timerThunderingShockCD		= mod:NewCDTimer(32.2, 230358, nil, nil, nil, 3)
--Stage Two: Terrors of the Deep
local timerDevouringMawCD			= mod:NewCDTimer(42, 232745, nil, nil, nil, 3)
local timerCrashingWaveCD			= mod:NewCDCountTimer(42, 232827, nil, nil, nil, 3)
local timerInkCD					= mod:NewCDTimer(41, 232913, nil, nil, nil, 3)
--Stage 3 just stage 2 shit combined

--local berserkTimer				= mod:NewBerserkTimer(300)

--General Stuff
--local countdownDrawPower			= mod:NewCountdown(33, 227629)
--Stage One: Ten Thousand Fangs

--General Stuff
local voiceHydraShot				= mod:NewVoice(230139)--targetyou
local voiceBurdenofPain				= mod:NewVoice(230201)--defensive/tauntboss
local voiceFromtheAbyss				= mod:NewVoice(230227, "-Healer")--killmob
--Stage One: Ten Thousand Fangs
local voiceSlicingTornado			= mod:NewVoice(232722)--watchwave?
local voiceThunderingShock			= mod:NewVoice(230362, "Healer")--helpdispel 
local voiceConsumingHunger			= mod:NewVoice(230384)--movetojelly (move to jellyfish)
--Stage Two: Terrors of the Deep
local voiceDevouringMaw				= mod:NewVoice(232745)-- inktoshark (bring ink to shark) too long?
local voiceCrashingWave				= mod:NewVoice(232827)--chargemove

mod:AddSetIconOption("SetIconOnHydraShot", 230139, true)
--mod:AddInfoFrameOption(227503, true)
--mod:AddRangeFrameOption("5/8/15")

mod.vb.phase = 1
mod.vb.crashingWaveCount = 0
mod.vb.hydraShotCount = 0
local thunderingShock = GetSpellInfo(230358)
local consumingHunger = GetSpellInfo(230384)
local hydraIcons = {}

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.crashingWaveCount = 0
	self.vb.hydraShotCount = 0
	table.wipe(hydraIcons)
	timerThunderingShockCD:Start(10-delay)
	timerBurdenofPainCD:Start(18-delay)
	timerFromtheAbyssCD:Start(18-delay)
	timerConsumingHungerCD:Start(20-delay)--20-23
	timerSlicingTornadoCD:Start(30-delay)
	if not self:IsLFR() then
		timerHydraShotCD:Start(25.4-delay, 1)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 230273 then
		warnDarkDepths:Show()
	elseif spellId == 232722 then
		specWarnSlicingTornado:Show()
		voiceSlicingTornado:Play("watchwave")
		if self:IsMythic() then
			timerSlicingTornadoCD:Start(34)
		else
			timerSlicingTornadoCD:Start()
		end
	elseif spellId == 230384 then
		timerConsumingHungerCD:Start()
	elseif spellId == 232746 then
		specWarnDevouringMaw:Show()
		voiceDevouringMaw:Play("inktoshark")
		timerDevouringMawCD:Start()
	elseif spellId == 232757 then
		self.vb.crashingWaveCount = self.vb.crashingWaveCount + 1
		specWarnCrashingWave:Show()
		voiceCrashingWave:Play("chargemove")
		timerCrashingWaveCD:Start(nil, self.vb.crashingWaveCount+1)
	elseif spellId == 232756 then
		warnSummonOssunet:Show()
		if self.vb.phase < 3 then
			timerInkCD:Start(42)
		else
			timerInkCD:Start(31)--Variable, not sequence though cause differs pull to pull. just standard variable CD
		end
	elseif spellId == 230358 then
		specWarnThunderingShock:Show()
		if UnitDebuff("player", consumingHunger) then
			voiceThunderingShock:Play("movetojelly")
		else
			voiceThunderingShock:Play("watchstep")
		end
		timerThunderingShockCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 230201 then
		timerBurdenofPainCD:Start()
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
			voiceHydraShot:Play("targetyou")
			yellHydraShot:Yell(count, count, count)
		end
		if self.Options.SetIconOnHydraShot then
			self:SetIcon(name, count)
		end
	elseif spellId == 230201 then
		if args:IsPlayer() then
			specWarnBurdenofPain:Show()
			voiceBurdenofPain:Play("defensive")
		else
			specWarnBurdenofPainTaunt:Show(args.destName)
			voiceBurdenofPain:Play("tauntboss")
		end
	elseif spellId == 230362 then
		if self.Options.SpecWarn230362dispel then
			specWarnThunderingShock:CombinedShow(0.3, args.destName)
			if self:AntiSpam(3, 2) then
				voiceThunderingShock:Play("helpdispel")
			end
		else
			warnThunderingShock:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 230384 then--230384
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
		timerHydraShotCD:Start(nil, self.vb.hydraShotCount+1)
	elseif spellId == 239423 then--Dread Shark
		if self:IsMythic() then
			--Every two sharks apparently
			--although need more data to confirm, only saw up to 2 sharks in logs and first one didn't phase change 2nd did
			warnDreadSharkSpawn:Show()
			self.vb.phase = self.vb.phase + 0.5
		else
			--Non mythic seems to use this for phase change even though there are no dread sharks
			self.vb.phase = self.vb.phase + 1
		end
		if self.vb.phase == 2 then
			self.vb.crashingWaveCount = 0
			self.vb.hydraShotCount = 0
			warnPhase2:Show()
			timerThunderingShockCD:Stop()
			timerSlicingTornadoCD:Stop()
			timerConsumingHungerCD:Stop()
			timerHydraShotCD:Stop()
			timerBurdenofPainCD:Stop()
			timerFromtheAbyssCD:Stop()
			
			timerInkCD:Start(10.8)
			timerBurdenofPainCD:Start(26)
			timerFromtheAbyssCD:Start(29)
			timerCrashingWaveCD:Start(30, 1)
			timerDevouringMawCD:Start(40)
			if not self:IsLFR() then
				timerHydraShotCD:Start(25.5, 1)
			end
		elseif self.vb.phase == 3 then
			self.vb.crashingWaveCount = 0
			self.vb.hydraShotCount = 0
			warnPhase3:Show()
			timerCrashingWaveCD:Stop()
			timerInkCD:Stop()
			timerHydraShotCD:Stop()
			timerBurdenofPainCD:Stop()
			timerDevouringMawCD:Stop()
			timerFromtheAbyssCD:Stop()
			
			timerInkCD:Start(10.8)
			timerBurdenofPainCD:Start(26)
			timerFromtheAbyssCD:Start(29)
			timerCrashingWaveCD:Start(30, 1)
			timerConsumingHungerCD:Start(39)--SUCCESS
			timerSlicingTornadoCD:Start(52.2)
			if not self:IsLFR() then
				timerHydraShotCD:Start(25.5, 1)
			end
		end
	end
end

