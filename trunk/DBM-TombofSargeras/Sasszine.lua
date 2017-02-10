local mod	= DBM:NewMod(1861, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(115767)--116328 Vellius, 115795 Abyss Stalker, 116329/116843 Sarukel
mod:SetEncounterID(2037)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(15581)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 230273 232722 230384 232746 232757 232827",
	"SPELL_CAST_SUCCES 230139 230227",
	"SPELL_AURA_APPLIED 239375 239362 230139 230201 230362 234459 230920 234621 232916",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 239375 239362 230139",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO: Do more with who has Buffer fish?
--TODO, Dread Sharks (239436, npc=119792) on mythic
--TODO, automate Hydra Shot and assigning of soakers?
--TODO, target scan dark depths?
--TODO, spec warn slicing tornado, maybe with moveto warning for Consealing Murk?
--TODO, figure out all right spellIds for Thundering Shock for timers/etc. give it voice once known
--TODO, where are nampelate auras most useful so they are just right and not under/over done
--TODO, New voice movetojelly (move to jellyfish).
--TODO, Beckon Sarukel is dodge warning for now, but change if it actually needs tanking in between devours
--TODO, voice warning when figure out how to handle Beckon Sarukel WHEN THEY SPAWN
--TOOD, New voice inktosarukel (bring ink to sarukel)
--TODO, timer for Devouring Maw, and other first casts when adds spawn.
--TODO, call Vellius priority? kill target? avoid target?
--TODO, phase detections
--NOTE: 3 stage fight but all stage 3 stuff is from stage 1 and 2 (combined) so there are no new abilities to list for stage 3 HERE
--General Stuff
local warnHydraShot					= mod:NewTargetAnnounce(230139, 4)
local warnDarkDepths				= mod:NewSpellAnnounce(230273, 2)
--Stage One: Ten Thousand Fangs
local warnSlicingTornado			= mod:NewSpellAnnounce(232722, 2)
local warnThunderingShock			= mod:NewTargetAnnounce(230362, 2, nil, false)
local warnConsumingHunger			= mod:NewTargetAnnounce(230920, 2)
--Stage Two: Terrors of the Deep
local warnBefoulingInk				= mod:NewTargetAnnounce(232916, 2, nil, false)--Optional warning if you want to know who's carrying ink

--General Stuff
local specWarnHydraShot				= mod:NewSpecialWarningYou(230139, nil, nil, nil, 1, 2)
local yellHydraShot					= mod:NewYell(230139)
local specWarnBurdenofPain			= mod:NewSpecialWarningYou(230201, nil, nil, nil, 1, 2)
local specWarnBurdenofPainTaunt		= mod:NewSpecialWarningTaunt(230201, nil, nil, nil, 1, 2)
local specWarnFromtheAbyss			= mod:NewSpecialWarningSwitch(230227, "-Healer", nil, nil, 1, 2)
--Stage One: Ten Thousand Fangs
local specWarnThunderingShock		= mod:NewSpecialWarningDispel(230362, "Healer", nil, nil, 1, 2)
local specWarnConsumingHunger		= mod:NewSpecialWarningMoveTo(230920, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(230920), nil, 1, 7)
--Stage Two: Terrors of the Deep
local specWarnBeckonSarukel			= mod:NewSpecialWarningDodge(232746, nil, nil, nil, 1)
local specWarnDevouringMaw			= mod:NewSpecialWarningSpell(234621, nil, nil, nil, 2, 7)
local specWarnCallVellius			= mod:NewSpecialWarningSpell(232757, "-Healer", nil, nil, 1, 2)--Change to switch if appropriate
local specWarnCrashingWave			= mod:NewSpecialWarningDodge(232827, nil, nil, nil, 3, 2)

--General Stuff
local timerHydraShotCD				= mod:NewAITimer(31, 230139, nil, nil, nil, 3)
local timerBurdenofPainCD			= mod:NewAITimer(31, 230201, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerFromtheAbyssCD			= mod:NewAITimer(31, 230227, nil, nil, nil, 1)
--Stage One: Ten Thousand Fangs
local timerSlicngTornadoCD			= mod:NewAITimer(31, 232722, nil, nil, nil, 3)
local timerConsumingHungerCD		= mod:NewAITimer(31, 230920, nil, nil, nil, 1)
--Stage Two: Terrors of the Deep
local timerBeckonSarukelCD			= mod:NewAITimer(31, 232746, nil, nil, nil, 1)
local timerCallVelliusCD			= mod:NewAITimer(31, 232757, nil, nil, nil, 1)
local timerCrashingWaveCD			= mod:NewAITimer(31, 232827, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)

--local berserkTimer				= mod:NewBerserkTimer(300)

--General Stuff
--local countdownDrawPower			= mod:NewCountdown(33, 227629)
--Stage One: Ten Thousand Fangs

--General Stuff
local voiceHydraShot				= mod:NewVoice(230139)--targetyou
local voiceBurdenofPain				= mod:NewVoice(230201)--defensive/tauntboss
local voiceFromtheAbyss				= mod:NewVoice(230227, "-Healer")--killmob
--Stage One: Ten Thousand Fangs
local voiceThunderingShock			= mod:NewVoice(230362, "Healer")--helpdispel 
local voiceConsumingHunger			= mod:NewVoice(230920)--movetojelly (move to jellyfish)
--Stage Two: Terrors of the Deep
local voiceDevouringMaw				= mod:NewVoice(234621)-- inktosarukel (bring ink to Sarukel) too long?
local voiceCallVellius				= mod:NewVoice(232757, "-Healer")--bigmob
local voiceCrashingWave				= mod:NewVoice(232827)--chargemove or watchwave

mod:AddSetIconOption("SetIconOnHydraShot", 230139, true)
--mod:AddInfoFrameOption(227503, true)
--mod:AddRangeFrameOption("5/8/15")

local thunderingShock = GetSpellInfo(230358)
mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	timerHydraShotCD:Start(1-delay)
	timerBurdenofPainCD:Start(1-delay)
	timerFromtheAbyssCD:Start(1-delay)
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
		warnSlicingTornado:Show()
		timerSlicngTornadoCD:Start()
	elseif spellId == 230384 then--Consuming Hunter Cast?
		timerConsumingHungerCD:Start()
	elseif spellId == 232746 then
		specWarnBeckonSarukel:Show()
		timerBeckonSarukelCD:Start()
	elseif spellId == 232757 then
		specWarnCallVellius:Show()
		voiceCallVellius:Play("bigmob")
		timerCallVelliusCD:Start()
	elseif spellId == 232827 then
		specWarnCrashingWave:Show()
		voiceCrashingWave:Play("chargemove")
		timerCrashingWaveCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 230139 then
		timerHydraShotCD:Start()
	elseif spellId == 230201 then
		timerBurdenofPainCD:Start()
	elseif spellId == 230227 and self:AntiSpam(3, 1) then--Or SPELL_SUMMON
		specWarnFromtheAbyss:Show()
		voiceFromtheAbyss:Play("killmob")
		timerFromtheAbyssCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 239375 or spellId == 239362 then--Carring Bufferfish

	elseif spellId == 230139 then
		if args:IsPlayer() then
			specWarnHydraShot:Show()
			voiceHydraShot:Play("targetyou")
			yellHydraShot:Yell()
		else
			warnHydraShot:Show(args.destName)
		end
		if self.Options.SetIconOnHydraShot then
			self:SetIcon(args.destName, 1)
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
	elseif spellId == 234459 or spellId == 230920 then
		warnConsumingHunger:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnConsumingHunger:Show(thunderingShock)
			voiceConsumingHunger:Play("movetojelly")
		end
	elseif spellId == 234621 then
		specWarnDevouringMaw:Show()
		voiceDevouringMaw:Play("inktosarukel")
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 115795 then--Abyss Stalker

	elseif cid == 116329 or cid == 116843 then--Sarukel (probably 2 Ids for phase 2 and phase 3 versions?)

	elseif cid == 116328 then--Vellius
		timerCrashingWaveCD:Stop(args.destGUID)
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 227503 then

	end
end
--]]
