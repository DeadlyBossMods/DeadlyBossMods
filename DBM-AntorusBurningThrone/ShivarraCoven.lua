local mod	= DBM:NewMod(1986, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(122468, 122467, 122469)--122468 Noura, 122467 Asara, 122469 Diima, 125436 Thu'raya (mythic only)
mod:SetEncounterID(2073)
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(16963)
mod.respawnTime = 25

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 245627 245303 252861 253650 250648 250095",
	"SPELL_CAST_SUCCESS 244899 253520 245532 250335 250333 250334 249793 245518 246329",
	"SPELL_AURA_APPLIED 244899 253520 245518 245586 250757 249863",
	"SPELL_AURA_APPLIED_DOSE 244899 245518",
	"SPELL_AURA_REMOVED 253520 245586 249863 250757",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_TARGETABLE_CHANGED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, auto range frame for fury of Golganneth?
--TODO, verify timerBossIncoming on all difficulties
--TODO, transcribe/video and tweak some timers for activation especially timerStormofDarknessCD which had some timer refreshed debug
--[[
(ability.id = 245627 or ability.id = 252861 or ability.id = 253650 or ability.id = 250095 or ability.id = 250648) and type = "begincast"
 or (ability.id = 244899 or ability.id = 245518 or ability.id = 253520 or ability.id = 245532 or ability.id = 250335 or ability.id = 250333 or ability.id = 250334 or ability.id = 249793 or ability.id = 250757 or ability.id = 246329) and type = "cast"
 or ability.id = 250757 and type = "applydebuff"
--]]
--All
local warnActivated						= mod:NewTargetAnnounce(118212, 3, 78740)
--Noura, Mother of Flames
local warnFieryStrike					= mod:NewStackAnnounce(244899, 2, nil, "Tank")
local warnWhirlingSaber					= mod:NewSpellAnnounce(245627, 2)
local warnFulminatingPulse				= mod:NewTargetAnnounce(253520, 3)
--Asara, Mother of Night
--Diima, Mother of Gloom
local warnChilledBlood					= mod:NewTargetAnnounce(245586, 2)
local warnFlashFreeze					= mod:NewStackAnnounce(245518, 2, nil, "Tank")
--Thu'raya, Mother of the Cosmos (Mythic)
local warnCosmicGlare					= mod:NewTargetAnnounce(250757, 3)
--Torment of the Titans

--General
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Noura, Mother of Flames
local specWarnFieryStrike				= mod:NewSpecialWarningStack(244899, nil, 3, nil, nil, 1, 6)
local specWarnFieryStrikeOther			= mod:NewSpecialWarningTaunt(244899, nil, nil, nil, 1, 2)
local specWarnFulminatingPulse			= mod:NewSpecialWarningMoveAway(253520, nil, nil, nil, 1, 2)
local yellFulminatingPulse				= mod:NewFadesYell(253520)
--Asara, Mother of Night
--local specWarnTouchofDarkness			= mod:NewSpecialWarningInterrupt(245303, "HasInterrupt", nil, nil, 1, 2)
local specWarnShadowBlades				= mod:NewSpecialWarningDodge(246329, nil, nil, nil, 2, 2)
local specWarnStormofDarkness			= mod:NewSpecialWarningCount(252861, nil, nil, nil, 2, 2)
--Diima, Mother of Gloom
local specWarnFlashfreeze				= mod:NewSpecialWarningStack(245518, nil, 3, nil, nil, 1, 6)
local specWarnFlashfreezeOther			= mod:NewSpecialWarningTaunt(245518, nil, nil, nil, 1, 2)
local yellFlashfreeze					= mod:NewYell(245518, nil, false)
local specWarnChilledBlood				= mod:NewSpecialWarningTarget(245586, "Healer", nil, nil, 1, 2)
local specWarnOrbofFrost				= mod:NewSpecialWarningDodge(253650, nil, nil, nil, 1, 2)
--Thu'raya, Mother of the Cosmos (Mythic)
local specWarnTouchoftheCosmos			= mod:NewSpecialWarningInterrupt(250648, "HasInterrupt", nil, nil, 1, 2)
local specWarnCosmicGlare				= mod:NewSpecialWarningMoveAway(250757, nil, nil, nil, 1, 2)
local yellCosmicGlare					= mod:NewYell(250757)
local yellCosmicGlareFades				= mod:NewShortFadesYell(250757)
--Torment of the Titans
local specWarnTormentofTitans			= mod:NewSpecialWarningSpell("ej16138", nil, nil, nil, 1, 7)

--General
local timerBossIncoming					= mod:NewTimer(61, "timerBossIncoming", nil, nil, nil, 1)
--Noura, Mother of Flames
local timerFieryStrikeCD				= mod:NewCDTimer(10.5, 244899, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerWhirlingSaberCD				= mod:NewNextTimer(35.1, 245627, nil, nil, nil, 3)--35-45
local timerFulminatingPulseCD			= mod:NewNextTimer(40.5, 253520, nil, nil, nil, 3)
--Asara, Mother of Night
--local timerTouchofDarknessCD			= mod:NewAITimer(61, 245303, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerShadowBladesCD				= mod:NewCDTimer(27.8, 246329, nil, nil, nil, 3)
local timerStormofDarknessCD			= mod:NewNextCountTimer(56.8, 252861, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)--57+
--Diima, Mother of Gloom
local timerFlashFreezeCD				= mod:NewCDTimer(10.1, 245518, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerChilledBloodCD				= mod:NewNextTimer(25.4, 245586, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON)
local timerOrbofFrostCD					= mod:NewNextTimer(30, 253650, nil, nil, nil, 3)
--Thu'raya, Mother of the Cosmos (Mythic)
--local timerTouchoftheCosmosCD			= mod:NewAITimer(61, 250648, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerCosmicGlareCD				= mod:NewCDTimer(17, 250757, nil, nil, nil, 3)
--Torment of the Titans
----Activations timers
local timerMachinationsofAmanThulCD		= mod:NewCastTimer(85, 250335, nil, nil, nil, 6)
local timerFlamesofKhazgorothCD			= mod:NewCastTimer(85, 250333, nil, nil, nil, 6)
local timerSpectralArmyofNorgannonCD	= mod:NewCastTimer(85, 250334, nil, nil, nil, 6)
local timerFuryofGolgannethCD			= mod:NewCastTimer(85, 249793, nil, nil, nil, 6)
----Actual phase stuff
local timerMachinationsofAman			= mod:NewCastTimer(20, 250095, nil, nil, nil, 5, nil, DBM_CORE_DAMAGE_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--Noura, Mother of Flames
local countdownTitans					= mod:NewCountdown(85, "ej16138")
local countdownFulminatingPulse			= mod:NewCountdown("Alt57", 253520, "Healer")
--Asara, Mother of Night
local countdownStormofDarkness			= mod:NewCountdown("AltTwo57", 252861)
--Diima, Mother of Gloom
--Thu'raya, Mother of the Cosmos (Mythic)
--Torment of the Titans

--General
--local voiceGTFO						= mod:NewVoice(238028, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway
--Noura, Mother of Flames
local voiceFieryStrike					= mod:NewVoice(244899)--tauntboss/stackhigh
local voiceFulminatingPulse				= mod:NewVoice(253520)--runout
--Asara, Mother of Night
--local voiceTouchofDarkness				= mod:NewVoice(245303, "HasInterrupt")--kickcast
local voiceShadowBlades					= mod:NewVoice(246329)--watchstep?
local voiceStormofDarkness				= mod:NewVoice(252861)--findshelter
--Diima, Mother of Gloom
local voiceFlashfreeze					= mod:NewVoice(245518)--tauntboss
local voiceChilledBlood					= mod:NewVoice(245586, "Healer")--healall?
local voicOrbofFrost					= mod:NewVoice(253650)--161411 (run away from ice orb)
--Thu'raya, Mother of the Cosmos (Mythic)
local voiceTouchoftheCosmos				= mod:NewVoice(250648, "HasInterrupt")--kickcast
local voiceCosmicGlare					= mod:NewVoice(250757)--runout
--Torment of the Titans
local voiceTormentofTitans				= mod:NewVoice("ej16138")--killmob/runtoedge/scatter/watchstep

mod:AddSetIconOption("SetIconOnFulminatingPulse2", 253520, false)
mod:AddSetIconOption("SetIconOnChilledBlood2", 245586, false)
mod:AddSetIconOption("SetIconOnCosmicGlare", 250757, false)
mod:AddInfoFrameOption(245586, true)
--mod:AddRangeFrameOption("5/10")
mod:AddNamePlateOption("NPAuraOnVisageofTitan", 249863)

local titanCount = {}
mod.vb.stormCount = 0
mod.vb.chilledCount = 0
mod.vb.MachinationsLeft = 0
mod.vb.fpIcon = 6
mod.vb.chilledIcon = 1
mod.vb.glareIcon = 4

function mod:OnCombatStart(delay)
	self.vb.stormCount = 0
	self.vb.chilledCount = 0
	self.vb.MachinationsLeft = 0
	self.vb.fpIcon = 4
	self.vb.chilledIcon = 1
	self.vb.glareIcon = 4
	if self:IsMythic() then
		self:SetCreatureID(122468, 122467, 122469, 125436)
	else
		self:SetCreatureID(122468, 122467, 122469)
	end
	--Diima, Mother of Gloom is first one to go inactive
	timerWhirlingSaberCD:Start(8-delay)
	timerFieryStrikeCD:Start(11-delay)
--	timerTouchofDarknessCD:Start(1-delay)
	timerShadowBladesCD:Start(11.8-delay)
	if not self:IsEasy() then
		timerFulminatingPulseCD:Start(20.3-delay)
		countdownFulminatingPulse:Start(20.3-delay)
		timerStormofDarknessCD:Start(28.8-delay, 1)
		countdownStormofDarkness:Start(28.8-delay)
	end
	if self.Options.NPAuraOnVisageofTitan then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	table.wipe(titanCount)
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnVisageofTitan then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		self:SetCreatureID(122468, 122467, 122469, 125436)
	else
		self:SetCreatureID(122468, 122467, 122469)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 245627 then
		warnWhirlingSaber:Show()
		timerWhirlingSaberCD:Start()
	elseif spellId == 245303 then
--		timerTouchofDarknessCD:Start()
	elseif spellId == 252861 then
		self.vb.stormCount = self.vb.stormCount + 1
		specWarnStormofDarkness:Show(self.vb.stormCount)
		voiceStormofDarkness:Play("findshelter")
		timerStormofDarknessCD:Start(56.8, self.vb.stormCount+1)
		countdownStormofDarkness:Start(56.8)
	elseif spellId == 253650 then
		specWarnOrbofFrost:Show()
		voicOrbofFrost:Play("161411")
		timerOrbofFrostCD:Start()
	elseif spellId == 250095 and self:AntiSpam(3, 1) then
		timerMachinationsofAman:Start()
	elseif spellId == 250648 then
		--timerTouchoftheCosmosCD:Start()
--		self.vb.pangCount = self.vb.pangCount + 1
--		if self.vb.pangCount == 4 then
--			self.vb.pangCount = 1
--		end
		if self:CheckInterruptFilter(args.sourceGUID) then
--			local kickCount = self.vb.pangCount
			specWarnTouchoftheCosmos:Show(args.sourceName)
			voiceTouchoftheCosmos:Play("kickcast")
--[[		if kickCount == 1 then
				voiceTouchoftheCosmos:Play("kick1r")
			elseif kickCount == 2 then
				voiceTouchoftheCosmos:Play("kick2r")
			elseif kickCount == 3 then
				voiceTouchoftheCosmos:Play("kick3r")
			end--]]
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 244899 then
		timerFieryStrikeCD:Start()
	elseif spellId == 245518 then
		timerFlashFreezeCD:Start()
	elseif spellId == 253520 and self:AntiSpam(3, 3) then
		timerFulminatingPulseCD:Start()
		countdownFulminatingPulse:Start(40.5)
	elseif spellId == 245532 and self:AntiSpam(3, 2) then
		timerChilledBloodCD:Start()
		voiceChilledBlood:Play("healall")
	elseif (spellId == 250335 or spellId == 250333 or spellId == 250334 or spellId == 249793) then--Torment selections
		countdownTitans:Start()
		if spellId == 250335 then--Machinations of Aman'Thul
			timerMachinationsofAmanThulCD:Start()
		elseif spellId == 250333 then--Flames of Khaz'goroth
			timerFlamesofKhazgorothCD:Start()
		elseif spellId == 250334 then--Spectral Army of Norgannon
			timerSpectralArmyofNorgannonCD:Start()
		elseif spellId == 249793 then--Fury of Golganneth
			timerFuryofGolgannethCD:Start()
		end
	elseif spellId == 246329 then--Shadow Blades
		specWarnShadowBlades:Show()
		voiceShadowBlades:Play("watchstep")
		timerShadowBladesCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 244899 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 3 then--Lasts 30 seconds, unknown reapplication rate, fine tune!
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnFieryStrike:Show(amount)
					voiceFieryStrike:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitIsDeadOrGhost("player") and not UnitDebuff("player", args.spellName) then
						specWarnFieryStrikeOther:Show(args.destName)
						voiceFieryStrike:Play("tauntboss")
					else
						warnFieryStrike:Show(args.destName, amount)
					end
				end
			else
				warnFieryStrike:Show(args.destName, amount)
			end
		end
	elseif spellId == 253520 then
		warnFulminatingPulse:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFulminatingPulse:Show()
			voiceFulminatingPulse:Play("runout")
			yellFulminatingPulse:Countdown(10)
		end
		if self.Options.SetIconOnFulminatingPulse2 then
			self:SetIcon(args.destName, self.vb.fpIcon)
		end
		self.vb.fpIcon = self.vb.fpIcon + 1
		if self.vb.fpIcon == 9 then
			self.vb.fpIcon = 6
		end
	elseif spellId == 245518 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 3 then--Lasts 30 seconds, unknown reapplication rate, fine tune!
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnFlashfreeze:Show(amount)
					voiceFlashfreeze:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitIsDeadOrGhost("player") and not UnitDebuff("player", args.spellName) then
						specWarnFlashfreezeOther:Show(args.destName)
						voiceFlashfreeze:Play("tauntboss")
					else
						warnFlashFreeze:Show(args.destName, amount)
					end
				end
			else
				warnFlashFreeze:Show(args.destName, amount)
			end
		end
	elseif spellId == 245586 then
		self.vb.chilledCount = self.vb.chilledCount + 1
		if self.Options.specwarn245586target then
			specWarnChilledBlood:CombinedShow(0.3, args.destName)
		else
			warnChilledBlood:CombinedShow(0.3, args.destName)
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(6, "playerabsorb", args.spellName, select(17, UnitDebuff(args.destName, args.spellName)))
		end
		if self.Options.SetIconOnChilledBlood2 then
			self:SetIcon(args.destName, self.vb.chilledIcon)
		end
		self.vb.chilledIcon = self.vb.chilledIcon + 1
		if self.vb.chilledIcon == 3 then
			self.vb.chilledIcon = 5
		elseif self.vb.chilledIcon == 6 then
			self.vb.chilledIcon = 1
		end
	elseif spellId == 250757 then
		warnCosmicGlare:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnCosmicGlare:Show()
			voiceCosmicGlare:Play("runout")
			yellCosmicGlare:Yell()
			yellCosmicGlareFades:Countdown(4)
		end
		if self.Options.SetIconOnCosmicGlare then
			self:SetIcon(args.destName, self.vb.glareIcon)
		end
		self.vb.glareIcon = self.vb.glareIcon + 1
		if self.vb.glareIcon == 6 then
			self.vb.glareIcon = 4
		end
	elseif spellId == 249863 then
		if self.Options.NPAuraOnVisageofTitan then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 30)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 253520 then
		if args:IsPlayer() then
			yellFulminatingPulse:Cancel()
		end
		if self.Options.SetIconOnFulminatingPulse2 then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 245586 then
		self.vb.chilledCount = self.vb.chilledCount - 1
		if self.Options.InfoFrame and self.vb.chilledCount == 0 then
			DBM.InfoFrame:Hide()
		end
		if self.Options.SetIconOnChilledBlood2 then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 249863 then--Bonecage Armor
		if self.Options.NPAuraOnVisageofTitan then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 250757 then
		if args:IsPlayer() then
			yellCosmicGlareFades:Cancel()
		end
		if self.Options.SetIconOnCosmicGlare then
			self:SetIcon(args.destName, 0)
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
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 125837 then--Torment of Amanthul
		self.vb.MachinationsLeft = self.vb.MachinationsLeft - 1
		if self.vb.MachinationsLeft == 0 then
			timerMachinationsofAman:Stop()
		end
--	elseif cid == 124164 then--Torment of Golganneth
	
--	elseif cid == 124166 then--Torment of Khazgoroth
	
--	elseif cid == 123503 then--Torment of Norgannon

	end
end

--"<94.13 21:56:15> [UNIT_SPELLCAST_SUCCEEDED] Diima, Mother of Gloom(??) [[boss3:Torment of Khaz'goroth::3-3779-1712-25990-259066-00119F734F:259066]]", -- [1126]
--"<94.33 21:56:15> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\Icons\\ABILITY_MONK_BREATHOFFIRE:20|tThe Coven prepares to unleash the  |cFFFF0000|Hspell:245671|h[Flames of Khaz'goroth]|h|r!#Diima, Mother of Gloom###
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 259068 or spellId == 259066 or spellId == 259069 or spellId == 259070 then
		local name = UnitName(uId)
		name = string.split(",", name)--Strip title
		specWarnTormentofTitans:Show()
		if spellId == 259068 then--Torment of Aman'Thul
			self.vb.MachinationsLeft = 4
			voiceTormentofTitans:Play("killmob")
		elseif spellId == 259066 then--Torment of Khaz'goroth
			voiceTormentofTitans:Play("runtoedge")
			voiceTormentofTitans:Schedule(1, "killmob")
		elseif spellId == 259069 then--Torment of Norgannon
			voiceTormentofTitans:Play("watchstep")
		elseif spellId == 259070 then--Torment of Golganneth
			voiceTormentofTitans:Play("scatter")
			voiceTormentofTitans:Schedule(1, "killmob")
		end
		if not titanCount[name] then
			titanCount[name] = 1
		elseif titanCount[name] then
			titanCount[name] = titanCount[name] + 1
		end
		if titanCount[name] == 2 then
			titanCount[name] = 0
			timerBossIncoming:Start(14, name)
		end
		DBM:Debug("UNIT_SPELLCAST_SUCCEEDED fired with: "..name, 2)
	end
end

--"<196.23 00:02:34> [UNIT_TARGETABLE_CHANGED] boss3#true#true#true#Diima, Mother of Gloom#Creature-0-2083-1712-12288-122469-0000111E27#elite#2150947263", -- [1436]
--"<196.23 00:02:34> [UNIT_TARGETABLE_CHANGED] nameplate2#false#false#true#Noura, Mother of Flames#Creature-0-2083-1712-12288-122468-0000111E27#elite#2150947229", -- [1437]
--"<196.23 00:02:34> [UNIT_TARGETABLE_CHANGED] boss2#false#false#true#Noura, Mother of Flames#Creature-0-2083-1712-12288-122468-0000111E27#elite#2150947229", -- [1438]
--"<198.19 00:02:36> [UNIT_SPELLCAST_SUCCEEDED] Noura, Mother of Flames(??) [[boss2:Spectral Army of Norgannon::3-2083-1712-12288-250334-000B1120DC:250334]]", -- [1456]
function mod:UNIT_TARGETABLE_CHANGED(uId)
	local cid = self:GetCIDFromGUID(UnitGUID(uId))
	if cid == 122468 then--Noura
		if UnitExists(uId) then
			warnActivated:Show(UnitName(uId))
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Engaging", 2)
			timerWhirlingSaberCD:Start(9)
			timerFieryStrikeCD:Start(12.1)
			if not self:IsEasy() then
				timerFulminatingPulseCD:Start(20.6)
				countdownFulminatingPulse:Start(20.6)
			end
		else
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Leaving", 2)
			timerFieryStrikeCD:Stop()
			timerWhirlingSaberCD:Stop()
			timerFulminatingPulseCD:Stop()
			countdownFulminatingPulse:Cancel()
		end
	elseif cid == 122467 then--Asara
		if UnitExists(uId) then
			warnActivated:Show(UnitName(uId))
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Engaging", 2)
			--TODO, timers, never saw her leave so never saw her return
		else
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Leaving", 2)
			--timerTouchofDarknessCD:Stop()
			timerShadowBladesCD:Stop()
			timerStormofDarknessCD:Stop()
			countdownStormofDarkness:Cancel()
		end
	elseif cid == 122469 then--Diima
		if UnitExists(uId) then
			warnActivated:Show(UnitName(uId))
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Engaging", 2)
			timerChilledBloodCD:Start(6.5)
			timerFlashFreezeCD:Start(12.5)
			if not self:IsEasy() then
				timerOrbofFrostCD:Start(30)
			end
		else
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Leaving", 2)
			timerFlashFreezeCD:Stop()
			timerChilledBloodCD:Stop()
			timerOrbofFrostCD:Stop()
		end
	elseif cid == 125436 then--Thu'raya (mythic only)
		if UnitExists(uId) then
			warnActivated:Show(UnitName(uId))
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Engaging", 2)
			timerCosmicGlareCD:Start(6)
		else
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Leaving", 2)
			--timerTouchoftheCosmosCD:Stop()
			timerCosmicGlareCD:Stop()
		end
	end
end	
