local mod	= DBM:NewMod(1438, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91331)--Doomfire Spirit (92208), Hellfire Deathcaller (92740), Felborne Overfiend (93615), Dreadstalker (93616), Infernal doombringer (94412)
mod:SetEncounterID(1799)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 183254 189897 183817 183828 185590 184265 183864",
	"SPELL_CAST_SUCCESS 183865 184931 187180",
	"SPELL_AURA_APPLIED 182879 183634 183865 184964 186574 187180 186961 189895 186123 186662 186952",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 186123 185014 187180 186961 186952",
	"CHAT_MSG_MONSTER_YELL",
	"RAID_BOSS_WHISPER",
	"CHAT_MSG_ADDON",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO< figure out rain of chaos (182225). periodic trigger of every 12 seconds. but how to detect? Logs show nothing, maybe have to schedule repeating loop
--Phase 1: The Defiler
local warnDoomfireFixate			= mod:NewTargetAnnounce(182879, 3)
local warnFelBurst					= mod:NewTargetAnnounce(183817, 4)--Target scanning impossible. Cannot pre warn target until knock up
local warnDemonicHavoc				= mod:NewTargetAnnounce(183865, 3)--Mythic
local warnDesecrate					= mod:NewSpellAnnounce(185590, 2)
--Phase 2: Hand of the Legion
local warnShackledTorment			= mod:NewTargetAnnounce(184964, 3)
local warnWroughtChaos				= mod:NewTargetAnnounce(184265, 4)--Combined both targets into one warning under primary spell name
local warnDreadFixate				= mod:NewTargetAnnounce(186574, 2, nil, false)--No idea. 3 second fixate?
--Phase 3: The Twisting Nether
local warnDemonicFeedback			= mod:NewTargetAnnounce(187180, 3)
local warnNetherBanish				= mod:NewTargetAnnounce(186961, 2)
----The Nether
local warnVoidStarFixate			= mod:NewTargetAnnounce(189895, 2)

--Phase 1: The Defiler
local specWarnDoomfire				= mod:NewSpecialWarningSwitch(189897, "Dps")
local specWarnDoomfireFixate		= mod:NewSpecialWarningYou(182879, nil, nil, nil, 4)
local yellDoomfireFixate			= mod:NewYell(182826)--Use short name for yell
local specWarnAllureofFlames		= mod:NewSpecialWarningSpell(183254, nil, nil, nil, 2)
local specWarnDeathCaller			= mod:NewSpecialWarningSwitch("ej11582", "Dps")--Tanks don't need switch, they have death brand special warning 2 seconds earlier
local specWarnFelBurst				= mod:NewSpecialWarningYou(183817)
local yellFelBurst					= mod:NewYell(183817)--Change yell to countdown mayeb when better understood
local specWarnFelBurstNear			= mod:NewSpecialWarningClose(183817)
local specWarnDeathBrand			= mod:NewSpecialWarningSpell(183828, "Tank")
--Phase 2: Hand of the Legion
local specWarnShackledTorment		= mod:NewSpecialWarningYou(184964)
local yellShackledTorment			= mod:NewYell(184964)
local specWarnWroughtChaos			= mod:NewSpecialWarningMoveAway(186123, nil, nil, nil, 3)
local yellWroughtChaos				= mod:NewYell(186123)
local specWarnFocusedChaos			= mod:NewSpecialWarningMoveAway(185014, nil, nil, nil, 3)
local yellFocusedChaos				= mod:NewYell(185014)
local specWarnDreadFixate			= mod:NewSpecialWarningYou(186574, false)--Do you run from a 3 second fixate?
--Phase 3: The Twisting Nether
local specWarnDemonicFeedback		= mod:NewSpecialWarningYou(187180)
local yellDemonicFeedback			= mod:NewYell(187180, nil, false)
local specWarnDemonicFeedbackOther	= mod:NewSpecialWarningTarget(187180, "Healer")
local specWarnNetherBanish			= mod:NewSpecialWarningYou(186961)
local yellNetherBanish				= mod:NewFadesYell(186961)
----The Nether
local specWarnVoidStarFixate		= mod:NewSpecialWarningYou(189895)--Maybe move away? depends how often it changes fixate targets
local yellVoidStarFixate			= mod:NewYell(189895, nil, false)
--Phase 3.5
local specWarnRainofChaos			= mod:NewSpecialWarningSpell(189953, nil, nil, nil, 2)

--Phase 1: The Defiler
local timerDoomfireCD				= mod:NewCDTimer(42.1, 182826)--182826 cast, 182879 fixate. Doomfire only fixates ranged, but ALL dps switch to it.
local timerAllureofFlamesCD			= mod:NewCDTimer(47.5, 183254)
local timerFelBurstCD				= mod:NewCDTimer(47.3, 183817, nil, "Ranged")--Only targets ranged
local timerDeathbrandCD				= mod:NewCDTimer(42.5, 183828)--Everyone, for tanks/healers to know when debuff/big hit, for dps to know add coming
local timerDesecrateCD				= mod:NewCDTimer(27, 185590, nil, "Melee")--Only targets melee
----Hellfire Deathcaller
local timerShadowBlastCD			= mod:NewCDTimer(9.7, 183864, nil, "Tank")
local timerDemonicHavocCD			= mod:NewAITimer(107, 183865)--Mythic, timer unknown, AI timer used until known
--Phase 2: Hand of the Legion
local timerShackledTormentCD		= mod:NewCDTimer(31.5, 184931)
local timerWroughtChaosCD			= mod:NewCDTimer(51.7, 184265)
--Phase 2.5
local timerFelborneOverfiendCD		= mod:NewNextTimer(44.3, "ej11603", nil, nil, nil, 186662)
--Phase 3: The Twisting Nether
local timerDemonicFeedbackCD		= mod:NewCDTimer(16.9, 187180)
local timerNetherBanishCD			= mod:NewCDTimer(61.9, 186961)
----The Nether

--local berserkTimer				= mod:NewBerserkTimer(360)

local countdownWroughtChaos			= mod:NewCountdownFades(5, 184265)

--local voiceInfernoSlice			= mod:NewVoice(155080)

mod:AddRangeFrameOption("8/10")
mod:AddSetIconOption("SetIconOnDemonicFeedback", 187180)
mod:AddHudMapOption("HudMapOnWrought", 184265)--Yellow on caster (wrought chaos), red on target (focused chaos)
mod:AddBoolOption("FilterOtherPhase", true)

--mod.vb.wroughtWarned = 0--Just in case it's spammy and there needs to be some kind of filter
mod.vb.phase = 1
mod.vb.demonicFeedbacks = 0
mod.vb.netherPortals = 0
local playerBanished = false
local AddsSeen = {}
local UnitDebuff = UnitDebuff
local DemonicFeedback = GetSpellInfo(187180)
local NetherBanish = GetSpellInfo(186961)
local demonicFilter, netherFilter
do
	demonicFilter = function(uId)
		if UnitDebuff(uId, DemonicFeedback) then
			return true
		end
	end
	netherFilter = function(uId)
		if UnitDebuff(uId, NetherBanish) then
			return true
		end
	end
end

local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self.vb.netherPortals > 0 then
		--Blue post says 8, but pretty sure it's 10. The visual was bigger than 8
		if UnitDebuff("player", NetherBanish) then
			DBM.RangeCheck:Show(10)
		else
			DBM.RangeCheck:Show(10, netherFilter)
		end
	elseif self.vb.demonicFeedbacks > 0 then
		if UnitDebuff("player", DemonicFeedback) then
			DBM.RangeCheck:Show(8)
		else
			DBM.RangeCheck:Show(8, demonicFilter)
		end
	elseif self.vb.phase < 2 and self:IsRanged() then--Fel burst in phase 1
		DBM.RangeCheck:Show(8)
	else
		DBM.RangeCheck:Hide()
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.demonicFeedbacks = 0
	self.vb.netherPortals = 0
	table.wipe(AddsSeen)
	playerBanished = false
	timerDoomfireCD:Start(6-delay)
	timerDeathbrandCD:Start(18-delay)
	timerAllureofFlamesCD:Start(30-delay)
	timerFelBurstCD:Start(41-delay)
	DBM:AddMsg(DBM_CORE_COMBAT_STARTED_AI_TIMER)--One ai timer remains, for mythic
	updateRangeFrame(self)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnWrought then
		DBMHudMap:Disable()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 183254 then
		if not playerBanished or not self.Options.FilterOtherPhase then
			specWarnAllureofFlames:Show()
		end
		timerAllureofFlamesCD:Start()
	elseif spellId == 189897 then
		specWarnDoomfire:Show()
		timerDoomfireCD:Start()
	elseif spellId == 183817 then
		timerFelBurstCD:Start()
	elseif spellId == 183828 then
		timerDeathbrandCD:Start()
		specWarnDeathBrand:Show()
	elseif spellId == 185590 then
		warnDesecrate:Show()
		timerDesecrateCD:Start()
		if self.vb.phase == 1 then
			self.vb.phase = 1.5--85%
		end
	elseif spellId == 184265 then
--		self.vb.wroughtWarned = 0--Reset Counter
		timerWroughtChaosCD:Start()
		if self.vb.phase < 2 then--1 second slower than yell, without requiring using yell.
			self.vb.phase = 2
			--Cancel stuff only used in phase 1
			timerFelBurstCD:Cancel()
			timerDesecrateCD:Cancel()
			timerDoomfireCD:Cancel()
			timerShackledTormentCD:Start(11.5)
		end
	elseif spellId == 183864 then
		timerShadowBlastCD:Start(args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 183865 then
		timerDemonicHavocCD:Start(nil, args.sourceGUID)
	elseif spellId == 184931 then
		timerShackledTormentCD:Start()
	elseif spellId == 187180 then
		timerDemonicFeedbackCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 182879 then
		warnDoomfireFixate:Show(args.destName)
		if args:IsPlayer() then
			specWarnDoomfireFixate:Show()
			yellDoomfireFixate:Yell()
		end
	elseif spellId == 183634 then
		warnFelBurst:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFelBurst:Show()
			yellFelBurst:Yell()
		end
	elseif spellId == 183865 then
		warnDemonicHavoc:CombinedShow(0.3, args.destName)
	elseif spellId == 184964 then
		if not playerBanished or not self.Options.FilterOtherPhase then
			warnShackledTorment:CombinedShow(0.3, args.destName)
		end
		if args:IsPlayer() then
			specWarnShackledTorment:Show()
			yellShackledTorment:Yell()
		end
	elseif spellId == 186123 then--Wrought Chaos
		--self.vb.wroughtWarned = self.vb.wroughtWarned + 1
		if args:IsPlayer() then
			specWarnWroughtChaos:Show()
			yellWroughtChaos:Yell()
			countdownWroughtChaos:Start()
		end
		if not playerBanished or not self.Options.FilterOtherPhase then
			warnWroughtChaos:CombinedShow(1, args.destName)
			if self.Options.HudMapOnWrought then
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 5, 1, 1, 0, 0.5, nil, true, 2):Pulse(0.5, 0.5)--Yellow
			end
		end
	elseif spellId == 185014 then--Focused Chaos
		print("If you see this message, it means blizzard made Focused Chaos visible in combat log, please report this to @mysticalos on twitter")
		--self.vb.wroughtWarned = self.vb.wroughtWarned + 1
--[[		warnWroughtChaos:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFocusedChaos:Show()
			yellFocusedChaos:Yell()
			countdownWroughtChaos:Start()
		end
		if self.Options.HudMapOnWrought then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 5, 1, 1, 0, 0.5, nil, true, 2):Pulse(0.5, 0.5)--Red
		end--]]
	elseif spellId == 186574 then--Dreadstalker fixate
		warnDreadFixate:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDreadFixate:Show()
		end
	elseif spellId == 187180 then
		self.vb.demonicFeedbacks = self.vb.demonicFeedbacks + 1
		if not playerBanished or not self.Options.FilterOtherPhase then
			if self.Options.SpecWarn187180target then
				specWarnDemonicFeedbackOther:CombinedShow(0.3, args.destName)
			else
				warnDemonicFeedback:CombinedShow(0.3, args.destName)
			end
		end
		if args:IsPlayer() then
			specWarnDemonicFeedback:Show()
			yellDemonicFeedback:Yell()
		end
		if self.Options.SetIconOnDemonicFeedback and not self:IsLFR() then
			self:SetSortedIcon(0.7, args.destName, 1)
		end
		updateRangeFrame(self)
	elseif spellId == 186961 then
		self.vb.netherPortals = self.vb.netherPortals + 1
		timerNetherBanishCD:Start()
		if args:IsPlayer() then
			specWarnNetherBanish:Show()
			yellNetherBanish:Schedule(6, 1)
			yellNetherBanish:Schedule(5, 2)
			yellNetherBanish:Schedule(4, 3)
			yellNetherBanish:Schedule(3, 4)
			yellNetherBanish:Schedule(2, 5)
		else
			warnNetherBanish:Show(args.destName)
		end
		updateRangeFrame(self)
		if self.vb.phase < 3 then--Secondary phase 3 trigger, if yell not localized
			self.vb.phase = 3
			timerAllureofFlamesCD:Cancel()--Done for rest of fight
			timerDeathbrandCD:Cancel()--Done for rest of fight
			timerShackledTormentCD:Cancel()--Resets to 51.4-6 here
			timerDemonicFeedbackCD:Start(11)
			timerShackledTormentCD:Start(45.4)
		end
	elseif spellId == 189895 and (playerBanished or not self.Options.FilterOtherPhase) then
		warnVoidStarFixate:CombinedShow(0.3, args.destName)--More than one?
		if args:IsPlayer() then
			specWarnVoidStarFixate:Show()
			yellVoidStarFixate:Yell()
		end
	elseif spellId == 186662 then--Felborne Overfiend Spawn
		timerFelborneOverfiendCD:Start()
		if self.vb.phase < 2.5 then--First spawn is about 3 seconds after phase 2.5 trigger yell
			self.vb.phase = 2.5
			timerShackledTormentCD:Cancel()--Resets to 40-3 here
			timerShackledTormentCD:Start(37)
		end
	elseif spellId == 186952 and args:IsPlayer() then
		playerBanished = true
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 186123 or spellId == 185014 then--Wrought Chaos/Focused Chaos
		if self.Options.HudMapOnWrought then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	elseif spellId == 187180 then
		self.vb.demonicFeedbacks = self.vb.demonicFeedbacks - 1
		if self.Options.SetIconOnDemonicFeedback and not self:IsLFR() then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 186961 then
		self.vb.netherPortals = self.vb.netherPortals - 1
		updateRangeFrame(self)
	elseif spellId == 186952 and args:IsPlayer() then
		playerBanished = false
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 92740 then--Hellfire Deathcaller
		timerDemonicHavocCD:Cancel(args.destGUID)
		timerShadowBlastCD:Cancel(args.destGUID)
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitGUID = UnitGUID("boss"..i)
		if unitGUID and not AddsSeen[unitGUID] then
			AddsSeen[unitGUID] = true
			local cid = self:GetCIDFromGUID(unitGUID)
			if cid == 92740 then--Hellfire Deathcaller
				specWarnDeathCaller:Show()
				timerShadowBlastCD:Start(4.5, unitGUID)
				if self:IsMythic() then
					timerDemonicHavocCD:Start(1, unitGUID)
				end
			end
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	--"<263.67 18:01:33> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Look upon the endless forces of the Burning Legion and know the folly of your resistance.#Archimonde
	--"<266.42 18:01:36> [CLEU] SPELL_AURA_APPLIED#Creature-0-2012-1448-150-93615-0000566CBD#Felborne Overfiend#Creature-0-2012-1448-150-93615-0000566CBD#Felborne Overfiend#186662#Heart of Argus#BUFF#nil", -- [12225]	
	if msg == L.phase2point5 and self.vb.phase < 2.5 then
		self:SendSync("phase25")
	elseif msg == L.phase3 and self.vb.phase < 3 then
		self:SendSync("phase3")
	elseif msg == L.phase3point5 and self.vb.phase < 3.5 then
		self:SendSync("phase35")
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:185014") then
		specWarnFocusedChaos:Show()
		yellFocusedChaos:Yell()
		countdownWroughtChaos:Start()
	end
end

--per usual, use transcriptor message to get messages from both bigwigs and DBM, all without adding comms to this mod at all
function mod:CHAT_MSG_ADDON(prefix, msg, channel, targetName)
	if prefix ~= "Transcriptor" then return end
	if msg:find("spell:185014") then--
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(3, targetName) then--Antispam sync by target name, since this doesn't use dbms built in onsync handler.
			if not playerBanished or not self.Options.FilterOtherPhase then
				warnWroughtChaos:CombinedShow(1, targetName)
				if self.Options.HudMapOnWrought then
					DBMHudMap:RegisterRangeMarkerOnPartyMember(185014, "highlight", targetName, 5, 5, 1, 0, 0, 0.5, nil, true, 2):Pulse(0.5, 0.5)--Red
				end
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 189953 then--Rain of Chaos (25% version). Phase 3.5
		specWarnRainofChaos:Show()
		if self.vb.phase == 3 then
			self.vb.phase = 3.5
		end
	end
end

function mod:OnSync(msg)
	if msg == "phase25" and self.vb.phase < 2.5 then
		self.vb.phase = 2.5
		timerShackledTormentCD:Cancel()--Resets to 40 here
		timerShackledTormentCD:Start(40)
	elseif msg == "phase3" and self.vb.phase < 3 then
		self.vb.phase = 3
		timerNetherBanishCD:Start(6)
		timerDemonicFeedbackCD:Start(17)
		timerAllureofFlamesCD:Cancel()--Done for rest of fight
		timerDeathbrandCD:Cancel()--Done for rest of fight
		timerShackledTormentCD:Cancel()--Resets to 51.4 here
		timerShackledTormentCD:Start(51.4)
	elseif msg == "phase35" and self.vb.phase < 3.5 then
		self.vb.phase = 3.5
		--This one does NOT alter shackled torment
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
--]]
