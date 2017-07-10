local mod	= DBM:NewMod(1985, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 16369 $"):sub(12, -3))
mod:SetCreatureID(124393)
mod:SetEncounterID(2064)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
--mod:SetHotfixNoticeRev(16350)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 243983 244709 245504 244607 244915 246805",
	"SPELL_CAST_SUCCESS 245050",
	"SPELL_AURA_APPLIED 244016 244383 244613 244949 244849 245050 245118",
	"SPELL_AURA_APPLIED_DOSE 244016",
	"SPELL_AURA_REFRESH 244016",
	"SPELL_AURA_REMOVED 244383 244613 244849 245118",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO: This fight desperately needs warning filters. A preliminary global function exists for setting platform manually via macro, hopefully later an actual GUI/mod
--TODO: Fine tune Reality Tear stack warnings and evaluate if it needs a tank filter. Because it expiring blows up on entire raid, no tank filter currently used
--TODO, find out impact/cast time for collapsing World and add a cast timer
--TODO, maybe hide timers for platforms you aren't on as well, that's a bit uglier than just filtering a warning, besides you may still want to know these timers
--TODO, interrupt rotation helper for Flames of Xoroth?
--TODO, portal spawns, etc
--TODO, Icons for the 3 debuffs you move from one portal to another?
--TODO, voice warnings for portals maybe, have to see fight to see if timing lines up first
--TODO, find a workable cast ID for corrupt and enable interrupt warning
--TODO, timers for all interrupts? for time being, not supported to reduce timer clutter
--TODO, an overview info frame showing the needs of portal worlds (how many shields up, how much fel miasma, how many fires in dark realm if possible)
--Platform: Nexus
local warnRealityTear					= mod:NewStackAnnounce(244016, 2, nil, "Tank")
local warnTransportPortal				= mod:NewSpellAnnounce(244677, 2)
--Platform: Xoroth
local warnAegisofFlames					= mod:NewTargetAnnounce(244383, 3)
local warnAegisofFlamesEnded			= mod:NewEndAnnounce(244383, 1)
local warnEverburningFlames				= mod:NewTargetAnnounce(244613, 2, nil, false)
--Platform: Rancora
local warnCausticSlime					= mod:NewTargetAnnounce(244849, 2, nil, false)
--Platform: Nathreza
local warnHypnotize						= mod:NewTargetAnnounce(245050, 2, nil, "Healer")
local warnCloyingShadows				= mod:NewTargetAnnounce(245118, 2, nil, false)
local warnHungeringGloom				= mod:NewTargetAnnounce(245075, 2, nil, false)

--Platform: Nexus
local specWarnRealityTear				= mod:NewSpecialWarningStack(244016, nil, 4, nil, nil, 1, 2)
local specWarnRealityTearOther			= mod:NewSpecialWarningTaunt(244016, nil, nil, nil, 1, 2)
local specWarnCollapsingWorld			= mod:NewSpecialWarningSpell(243983, nil, nil, nil, 2, 2)
local specWarnFelstormBarrage			= mod:NewSpecialWarningDodge(244000, nil, nil, nil, 2, 2)
local specWarnFieryDetonation			= mod:NewSpecialWarningInterrupt(244709, false)
local specWarnHowlingShadows			= mod:NewSpecialWarningInterrupt(245504, "HasInterrupt")
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Platform: Xoroth
local specWarnFlamesofXoroth			= mod:NewSpecialWarningInterrupt(244607, "HasInterrupt")
local specWarnSupernova					= mod:NewSpecialWarningDodge(244598, nil, nil, nil, 2, 2)
local specWarnEverburningFlames			= mod:NewSpecialWarningMoveTo(244613, nil, nil, nil, 1)--No voice yet
local yellEverburningFlames				= mod:NewFadesYell(244613)
--Platform: Rancora
local specWarnFelSilkWrap				= mod:NewSpecialWarningYou(244949, nil, nil, nil, 1, 2)
local yellFelSilkWrap					= mod:NewYell(244949)
local specWarnFelSilkWrapOther			= mod:NewSpecialWarningSwitchCount(244949, "Dps", DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format(244949), nil, 1, 2)
local specWarnLeechEssence				= mod:NewSpecialWarningSpell(244915, nil, nil, nil, 1, 2)--Don't know what to do for voice yet til strat divised
local specWarnCausticSlime				= mod:NewSpecialWarningMoveTo(244849, nil, nil, nil, 1)--No voice yet
local specWarnCausticSlimeLFR			= mod:NewSpecialWarningMoveAway(244849, nil, nil, nil, 1)--No voice yet
local yellCausticSlime					= mod:NewFadesYell(244849)
--Platform: Nathreza
local specWarnHypnotize					= mod:NewSpecialWarningYou(245050, nil, nil, nil, 1, 2)
--local specWarnCorrupt					= mod:NewSpecialWarningInterrupt(245040, "HasInterrupt")
local specWarnCloyingShadows			= mod:NewSpecialWarningYou(245118, nil, nil, nil, 1)--No voice yet (you warning for now, since it's secondary debuff you move to fel miasma)
local yellCloyingShadows				= mod:NewFadesYell(245118)
local specWarnHungeringGloom			= mod:NewSpecialWarningMoveTo(245075, nil, nil, nil, 1)--No voice yet

--Platform: Nexus
local timerRealityTearCD				= mod:NewAITimer(25, 244016, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerCollapsingWorldCD			= mod:NewAITimer(61, 243983, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerFelstormBarrageCD			= mod:NewAITimer(61, 244000, nil, nil, nil, 3)
local timerTransportPortalCD			= mod:NewAITimer(61, 244677, nil, nil, nil, 1)
--Platform: Xoroth
local timerSupernovaCD					= mod:NewAITimer(61, 244598, nil, nil, nil, 3)
--Platform: Rancora
local timerFelSilkWrapCD				= mod:NewAITimer(61, 244949, nil, nil, nil, 3)
local timerLeechEssenceCD				= mod:NewAITimer(61, 244949, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)--Change to source timer later with support for mythic add
--Platform: Nathreza
local timerHypnotizeCD					= mod:NewAITimer(61, 245050, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON..DBM_CORE_MAGIC_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--Platform: Nexus
--local countdownSingularity			= mod:NewCountdown(50, 235059)
--Platform: Xoroth
--Platform: Rancora

--Platform: Nexus
local voiceRealityTear					= mod:NewVoice(244016)--tauntboss/stackhigh
local voiceCollapsingWorld				= mod:NewVoice(243983)--carefly
local voiceFelstormBarrage				= mod:NewVoice(244000)--farfromline
local voiceFieryDetonation				= mod:NewVoice(244709, false)--kickcast
local voiceHowlingShadows				= mod:NewVoice(245504, "HasInterrupt")--kickcast
--local voiceGTFO						= mod:NewVoice(238028, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway
--Platform: Xoroth
local voiceFlamesofXoroth				= mod:NewVoice(244607, "HasInterrupt")--kickcast
--Platform: Rancora
local voiceFelSilkWrap					= mod:NewVoice(244949)--changetarget/targetyou
--Platform: Nathreza
local voiceHypnotize					= mod:NewVoice(245050)--targetyou (not sure if better option)
--local voiceCorrupt						= mod:NewVoice(245040, "HasInterrupt")--kickcast

--mod:AddSetIconOption("SetIconOnFocusedDread", 238502, true)
--mod:AddInfoFrameOption(239154, true)
mod:AddRangeFrameOption("8/10")

mod.vb.shieldsActive = 0
local playerPlatform = 0
local mindFog, aegisFlames, felMiasma = GetSpellInfo(245099), GetSpellInfo(244383), GetSpellInfo(244826)

--0 Nexus, 1 Xoroth, 2 Rancora, 3 Nathreza
--Global function player can access via macro or 3rd party mod like similar to krosus assist to set player platform
function DBMSetHasabelPlatform(platform)
	if type(platform) == "Number" and platform < 4 then--Don't allow bad input like invalid number or non numbers
		playerPlatform = platform
	end
end

local updateRangeFrame
do
	local everBurningFlames, causticSlime, CloyingShadows, hungeringGloom = GetSpellInfo(244613), GetSpellInfo(244849), GetSpellInfo(245118), GetSpellInfo(245075)
	local UnitDebuff = UnitDebuff
	local function debuffFilter(uId)
		if UnitDebuff(uId, everBurningFlames) or UnitDebuff(uId, hungeringGloom) or UnitDebuff(uId, causticSlime) then
			return true
		end
	end
	updateRangeFrame = function(self)
		if not self.Options.RangeFrame then return end
		if UnitDebuff("player", causticSlime) then
			DBM.RangeCheck:Show(10)
		elseif UnitDebuff("player", everBurningFlames) or UnitDebuff("player", CloyingShadows) or UnitDebuff("player", hungeringGloom) then
			DBM.RangeCheck:Show(8)
		else
			DBM.RangeCheck:Show(10, debuffFilter)
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.shieldsActive = 0
	playerPlatform = 0--Nexus
	timerRealityTearCD:Start(1-delay)
	timerCollapsingWorldCD:Start(1-delay)
	timerFelstormBarrageCD:Start(1-delay)
	timerTransportPortalCD:Start(1-delay)
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
	if spellId == 243983 then
		timerCollapsingWorldCD:Start()
--		if playerPlatform == 0 then--Actually on nexus platform
			specWarnCollapsingWorld:Show()
			voiceCollapsingWorld:Play("carefly")
--		end
	elseif spellId == 244709 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnFieryDetonation:Show(args.sourceName)
		voiceFieryDetonation:Play("kickcast")
	elseif spellId == 245504 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnHowlingShadows:Show(args.sourceName)
		voiceHowlingShadows:Play("kickcast")
	elseif spellId == 244607 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnFlamesofXoroth:Show(args.sourceName)
		voiceFlamesofXoroth:Play("kickcast")
	elseif spellId == 244915 or spellId == 246805 then
		if spellId == 244915 then--Rancora platform
			timerLeechEssenceCD:Start()
--			if playerPlatform == 2 then--Actually on Rancora platform
				specWarnLeechEssence:Show()
--			end
		else--Mythic add on nexus platform
			--timerLeechEssenceCD:Start() enable later with appropriate add filter
--			if playerPlatform == 0 then--Actually on Nexus platform
				specWarnLeechEssence:Show()
--			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 245050 then--Hypnotize
		timerHypnotizeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 244016 then
		local uId = DBM:GetRaidUnitId(args.destName)
--		if self:IsTanking(uId) then
			timerRealityTearCD:Start()--Move this later
			local amount = args.amount or 1
			if amount >= 4 then--Lasts 30 seconds, cast every 5 seconds, swapping will be at 6
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnRealityTear:Show(amount)
					voiceRealityTear:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitIsDeadOrGhost("player") and not UnitDebuff("player", args.spellName) then
						specWarnRealityTearOther:Show(args.destName)
						voiceRealityTear:Play("tauntboss")
					else
						warnRealityTear:Show(args.destName, amount)
					end
				end
			else
				if amount % 2 == 0 then
					warnRealityTear:Show(args.destName, amount)
				end
			end
--		end
	elseif spellId == 244383 then--Aegis of Flames
		self.vb.shieldsActive = self.vb.shieldsActive + 1
		warnAegisofFlames:Show(args.destName)
		if self:GetDestCreatureID() == 124396 then--Baron Vulcanar
			--Timers and things?
		else--Mythic mob
		
		end
	elseif spellId == 244613 then--Everburning Flames
		warnEverburningFlames:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnEverburningFlames:Show(mindFog)
			yellEverburningFlames:Countdown(10)
			updateRangeFrame(self)
		end
	elseif spellId == 244849 then--Caustic Slime
		warnCausticSlime:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			if not self:IsLFR() and self.vb.shieldsActive > 0 then--Show moveto message
				specWarnCausticSlime:Show(aegisFlames)
			else--Show LFR/You message
				specWarnCausticSlimeLFR:Show()
			end
			yellCausticSlime:Countdown(20)
			updateRangeFrame(self)
		end
	elseif spellId == 245118 then--Cloying Shadows
		warnCloyingShadows:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnCloyingShadows:Show()
			yellCloyingShadows:Countdown(30)
			updateRangeFrame(self)
		end
	elseif spellId == 245075 then
		warnHungeringGloom:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnHungeringGloom:Show(felMiasma)
			updateRangeFrame(self)
		end
	elseif spellId == 244949 then--Felsilk Wrap
		timerFelSilkWrapCD:Start()
		if args:IsPlayer() then
			specWarnFelSilkWrap:Show()
			voiceFelSilkWrap:Play("targetyou")
			yellFelSilkWrap:Yell()
		else
--			if playerPlatform == 2 then--Actually on Rancora platform
				specWarnFelSilkWrapOther:Show(">"..args.destName.."<")
				if self.Options.SpecWarn244949switchcount then
					voiceFelSilkWrap:Play("changetarget")
				end
--			end
		end
	elseif spellId == 245050 then--Hypnotize
		warnHypnotize:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnHypnotize:Show()
			voiceHypnotize:Play("targetyou")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 244383 then--Aegis of Flames
		self.vb.shieldsActive = self.vb.shieldsActive - 1
		warnAegisofFlamesEnded:Show()
	elseif spellId == 244613 then--Everburning Flames
		if args:IsPlayer() then
			yellEverburningFlames:Cancel()
			updateRangeFrame(self)
		end
	elseif spellId == 244849 then--Caustic Slime
		if args:IsPlayer() then
			yellCausticSlime:Cancel()
			updateRangeFrame(self)
		end
	elseif spellId == 245118 then--Cloying Shadows
		if args:IsPlayer() then
			yellCloyingShadows:Cancel()
			--updateRangeFrame(self)
		end
	elseif spellId == 245075 then--Hungering Gloom
		if args:IsPlayer() then
			updateRangeFrame(self)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		voiceGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:238502") then

	end
end
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then--Baron Vulcanar (Platform: Xoroth)
		timerSupernovaCD:Stop()
	elseif cid == 124395 then--Lady Dacidion (Platform: Rancora)
		timerFelSilkWrapCD:Stop()
		timerLeechEssenceCD:Stop()--Add appropriate boss filter when mythic add support added
	elseif cid == 124394 then--Lord Eilgar (Platform: Nathreza)
		timerHypnotizeCD:Stop()--Add appropriate boss filter when mythic add support added
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 244000 then--Felstorm Barrage
		timerFelstormBarrageCD:Start()
--		if playerPlatform == 0 then--Actually on nexus platform
			specWarnFelstormBarrage:Show()
			voiceFelstormBarrage:Play("farfromline")
--		end
	elseif spellId == 244677 then--Transport Portal
		timerTransportPortalCD:Start()
--		if playerPlatform == 0 then--Actually on nexus platform
			warnTransportPortal:Show()
--		end
	elseif spellId == 244598 then--Supernova
		timerSupernovaCD:Start()
--		if playerPlatform == 1 then--Actually on Xoroth platform
			specWarnSupernova:Show()
--		end
	end
end
