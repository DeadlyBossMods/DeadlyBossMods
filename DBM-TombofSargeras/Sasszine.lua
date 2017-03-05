local mod	= DBM:NewMod(1861, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(115767)--116328 Vellius, 115795 Abyss Stalker, 116329/116843 Sarukel
mod:SetEncounterID(2037)
mod:SetZone()
mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(15581)
mod.respawnTime = 40

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 230273 232722 230384 232746 232757 232756 230358",
	"SPELL_CAST_SUCCESS 230201 232745",
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
--TODO, Give thundering shock a voice
--TODO, New voice movetojelly (move to jellyfish).
--TODO, Beckon Sarukel is dodge warning for now, but change if it actually needs tanking in between devours
--TODO, voice warning when figure out how to handle Beckon Sarukel WHEN THEY SPAWN
--TOOD, New voice inktosarukel (bring ink to sarukel)
--TODO, timer for Devouring Maw, and other first casts when adds spawn.
--TODO, call Vellius priority? kill target? avoid target?
--TODO, phase detections
--TODO, Summon Ossunet timers (actually all add timers) will need a lot of work once the phasing is figured out. Ossunet timers extra needed because they seem sequenced (and all over the place)
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
--Stage One: Ten Thousand Fangs
local warnSlicingTornado			= mod:NewSpellAnnounce(232722, 2)
local warnThunderingShock			= mod:NewTargetAnnounce(230362, 2, nil, false)
local warnConsumingHunger			= mod:NewTargetAnnounce(230920, 2)
--Stage Two: Terrors of the Deep
local warnSummonOssunet				= mod:NewSpellAnnounce(232756, 2)
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
local specWarnCrashingWave			= mod:NewSpecialWarningDodge(232827, nil, nil, nil, 3, 2)
--Mythic
local specWarnDeliciousBufferfish	= mod:NewSpecialWarningYou(239375, nil, nil, nil, 1, 2)
local specWarnDreadShark			= mod:NewSpecialWarningSpell(239436, nil, nil, nil, 1, 2)

--General Stuff
local timerHydraShotCD				= mod:NewCDTimer(40, 230139, nil, nil, nil, 3)
local timerBurdenofPainCD			= mod:NewCDTimer(28, 230201, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--28-32
local timerFromtheAbyssCD			= mod:NewCDTimer(27, 230227, nil, nil, nil, 1)--27-31
--Stage One: Ten Thousand Fangs
local timerSlicingTornadoCD			= mod:NewCDTimer(45, 232722, nil, nil, nil, 3)--45-54 (needs correcting)
local timerConsumingHungerCD		= mod:NewCDTimer(32, 230920, nil, nil, nil, 1)
local timerThunderingShockCD		= mod:NewCDTimer(32.2, 230358, nil, nil, nil, 1)
--Stage Two: Terrors of the Deep
local timerBeckonSarukelCD			= mod:NewCDTimer(42, 232746, nil, nil, nil, 1)
local timerCallVelliusCD			= mod:NewCDTimer(42, 232757, nil, nil, nil, 1)

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
local voiceCrashingWave				= mod:NewVoice(232827)--chargemove or watchwave

mod:AddSetIconOption("SetIconOnHydraShot", 230139, true)
--mod:AddInfoFrameOption(227503, true)
--mod:AddRangeFrameOption("5/8/15")

local thunderingShock = GetSpellInfo(230358)
mod.vb.phase = 1
mod.vb.tempIgnore = false

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.tempIgnore = false
	timerThunderingShockCD:Start(10-delay)
	timerBurdenofPainCD:Start(18-delay)
	timerFromtheAbyssCD:Start(18-delay)
	timerConsumingHungerCD:Start(20-delay)--20-23
	timerHydraShotCD:Start(25.4-delay)
	timerSlicingTornadoCD:Start(30-delay)
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
		if self:IsMythic() then
			timerSlicingTornadoCD:Start(34)
		else
			timerSlicingTornadoCD:Start()
		end
	elseif spellId == 230384 then--Consuming Hunter Cast?
		timerConsumingHungerCD:Start()
	elseif spellId == 232746 then
		specWarnBeckonSarukel:Show()
		--timerBeckonSarukelCD:Start()
	elseif spellId == 232757 then
		specWarnCrashingWave:Show()
		voiceCrashingWave:Play("chargemove")
	elseif spellId == 232756 then
		warnSummonOssunet:Show()
		--Temp, move this shit to real phase trigger later
		timerThunderingShockCD:Stop()
		timerSlicingTornadoCD:Stop()
		timerConsumingHungerCD:Stop()
		--TODO, this makes sense except for one pull, which hopefully was a fluke?
		--https://www.warcraftlogs.com/reports/W7kpN3DaLAgjXPK4#fight=28&view=events&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20230273%20or%20ability.id%20%3D%20232722%20or%20ability.id%20%3D%20230384%20or%20ability.id%20%3D%20232746%20or%20ability.id%20%3D%20232757%20or%20ability.id%20%3D%20232827%20or%20ability.id%20%3D%20232756%20or%20ability.id%20%3D%20230358)%20and%20type%20%3D%20%22begincast%22%20or%0A(ability.id%20%3D%20230201%20or%20ability.id%20%3D%20232745)%20and%20type%20%3D%20%22cast%22%20or%0A(target.id%20%3D%20116329%20or%20target.id%20%3D%20116843%20or%20target.id%20%3D%20116328)%20and%20type%20%3D%20%22death%22%20or%0A(ability.id%20%3D%20239375%20or%20ability.id%20%3D%20239362%20or%20ability.id%20%3D%20230139)%20and%20type%20%3D%20%22applydebuff%22
		if not self.vb.tempIgnore then--For time being, don't start these timers if boss summons two Ossunets before Vellius
			timerCallVelliusCD:Start(19.4)
			timerBeckonSarukelCD:Start(29.1)
		end
		self.vb.tempIgnore = true
	elseif spellId == 230358 then
		timerThunderingShockCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 230201 then
		timerBurdenofPainCD:Start()
	elseif spellId == 232745 then
		specWarnDevouringMaw:Show()
		voiceDevouringMaw:Play("inktosarukel")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 239375 or spellId == 239362 then--Carring Bufferfish (239375 confirmed on mythic)
		if args:IsPlayer() then
			specWarnDeliciousBufferfish:Show()
		end
	elseif spellId == 230139 then
		timerHydraShotCD:Start()
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
	elseif spellId == 239423 then--Dread Shark
		specWarnDreadShark:Show()
	end
end

