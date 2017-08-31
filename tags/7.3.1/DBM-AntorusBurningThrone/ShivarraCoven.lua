local mod	= DBM:NewMod(1986, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 16369 $"):sub(12, -3))
mod:SetCreatureID(122468, 122467, 122469)--122468 Noura, 122467 Asara, 122469 Diima, 125436 Thu'raya (mythic only)
mod:SetEncounterID(2073)
mod:SetZone()
mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
--mod:SetHotfixNoticeRev(16350)
mod.respawnTime = 15

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 245627 245303 252861 253650 250648 250095",
	"SPELL_CAST_SUCCESS 244899 253520 245532 250757 250335 250333 250334 249793 245518 246329",
	"SPELL_AURA_APPLIED 244899 253520 245518 245586 250757 249863",
	"SPELL_AURA_APPLIED_DOSE 244899",
	"SPELL_AURA_REMOVED 253520 245586 249863",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_TARGETABLE_CHANGED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"--4 Coven and 1 torment
)

--TODO, whirling saber target scanning or targetting debuff?
--TODO, review tank swap stuff for flash freeze
--TODO, auto range frame for fury of Golganneth?
--TODO, auto mark adds in each phase?
--TODO, orb of frost was never cast, see if removed?
--[[
(ability.id = 245627 or ability.id = 252861 or ability.id = 253650 or ability.id = 250095 or ability.id = 250648) and type = "begincast"
 or (ability.id = 244899 or ability.id = 245518 or ability.id = 253520 or ability.id = 245532 or ability.id = 250335 or ability.id = 250333 or ability.id = 250334 or ability.id = 249793 or ability.id = 250757 or ability.id = 246329) and type = "cast"
--]]
--Noura, Mother of Flames
local warnFieryStrike					= mod:NewStackAnnounce(244899, 2, nil, "Tank")
local warnWhirlingSaber					= mod:NewSpellAnnounce(245627, 2)
local warnFulminatingPulse				= mod:NewTargetAnnounce(253520, 3)
--Asara, Mother of Night
--Diima, Mother of Gloom
local warnChilledBlood					= mod:NewTargetAnnounce(245586, 2)
--Thu'raya, Mother of the Cosmos (Mythic)
local warnCosmicGlare					= mod:NewTargetAnnounce(250757, 3)
--Torment of the Titans

--General
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Noura, Mother of Flames
local specWarnFieryStrike				= mod:NewSpecialWarningStack(244899, nil, 3, nil, nil, 1, 2)
local specWarnFieryStrikeOther			= mod:NewSpecialWarningTaunt(244899, nil, nil, nil, 1, 2)
local specWarnFulminatingPulse			= mod:NewSpecialWarningMoveAway(253520, nil, nil, nil, 1, 2)
local yellFulminatingPulse				= mod:NewFadesYell(253520)
--Asara, Mother of Night
--local specWarnTouchofDarkness			= mod:NewSpecialWarningInterrupt(245303, "HasInterrupt", nil, nil, 1, 2)
local specWarnShadowBlades				= mod:NewSpecialWarningDodge(246329, nil, nil, nil, 2, 2)
local specWarnStormofDarkness			= mod:NewSpecialWarningCount(252861, nil, nil, nil, 2, 2)
--Diima, Mother of Gloom
local specWarnFlashfreeze				= mod:NewSpecialWarningYou(245518, nil, nil, nil, 1, 2)
local specWarnFlashfreezeOther			= mod:NewSpecialWarningTaunt(245518, nil, nil, nil, 1, 2)
local yellFlashfreeze					= mod:NewYell(245518, nil, false)
local specWarnChilledBlood				= mod:NewSpecialWarningTarget(245586, "Healer", nil, nil, 1, 2)
local specWarnOrbofFrost				= mod:NewSpecialWarningDodge(253650, nil, nil, nil, 1, 2)
--Thu'raya, Mother of the Cosmos (Mythic)
local specWarnTouchoftheCosmos			= mod:NewSpecialWarningInterrupt(250648, "HasInterrupt", nil, nil, 1, 2)
local specWarnCosmicGlare				= mod:NewSpecialWarningMoveAway(250757, nil, nil, nil, 1, 2)
local yellCosmicGlare					= mod:NewYell(250757)
--Torment of the Titans
local specWarnTormentofTitans			= mod:NewSpecialWarningSwitch("ej16138", nil, nil, nil, 1, 2)

--General
local timerBossIncoming					= mod:NewTimer(61, "timerBossIncoming", nil, nil, nil, 1)
--Noura, Mother of Flames
local timerFieryStrikeCD				= mod:NewCDTimer(12.1, 244899, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerWhirlingSaberCD				= mod:NewCDTimer(35.3, 245627, nil, nil, nil, 3)
local timerFulminatingPulseCD			= mod:NewCDTimer(40.5, 253520, nil, nil, nil, 3)
--Asara, Mother of Night
--local timerTouchofDarknessCD			= mod:NewAITimer(61, 245303, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerShadowBladesCD				= mod:NewCDTimer(27.9, 246329, nil, nil, nil, 3)
local timerStormofDarknessCD			= mod:NewCDTimer(51, 252861, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
--Diima, Mother of Gloom
local timerFlashFreezeCD				= mod:NewCDTimer(12.1, 245518, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerChilledBloodCD				= mod:NewCDTimer(25.4, 245586, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON)
local timerOrbofFrostCD					= mod:NewAITimer(61, 253650, nil, nil, nil, 3)
--Thu'raya, Mother of the Cosmos (Mythic)
local timerTouchoftheCosmosCD			= mod:NewAITimer(61, 250648, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerCosmicGlareCD				= mod:NewAITimer(61, 250757, nil, nil, nil, 3)
--Torment of the Titans
----Activations timers
local timerMachinationsofAmanThulCD		= mod:NewCastTimer(80, 250335, nil, nil, nil, 6)
local timerFlamesofKhazgorothCD			= mod:NewCastTimer(80, 250333, nil, nil, nil, 6)
local timerSpectralArmyofNorgannonCD	= mod:NewCastTimer(80, 250334, nil, nil, nil, 6)
local timerFuryofGolgannethCD			= mod:NewCastTimer(80, 249793, nil, nil, nil, 6)
----Actual phase stuff
local timerMachinationsofAman			= mod:NewCastTimer(20, 250095, nil, nil, nil, 5, nil, DBM_CORE_DAMAGE_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--Noura, Mother of Flames
local countdownTitans					= mod:NewCountdown(80, "ej16138")
--Asara, Mother of Night
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
local voiceStormofDarkness				= mod:NewVoice(252861)--aesoon
--Diima, Mother of Gloom
local voiceFlashfreeze					= mod:NewVoice(245518)--tauntboss
local voiceChilledBlood					= mod:NewVoice(245586, "Healer")--healall?
local voicOrbofFrost					= mod:NewVoice(253650)--161411 (run away from ice orb)
--Thu'raya, Mother of the Cosmos (Mythic)
local voiceTouchoftheCosmos				= mod:NewVoice(250648, "HasInterrupt")--kickcast
local voiceCosmicGlare					= mod:NewVoice(250757)--runout
--Torment of the Titans
local voiceTormentofTitans				= mod:NewVoice("ej16138")--killmob

--mod:AddSetIconOption("SetIconOnFocusedDread", 238502, true)
mod:AddInfoFrameOption(245586, true)
--mod:AddRangeFrameOption("5/10")
mod:AddNamePlateOption("NPAuraOnVisageofTitan", 249863)

mod.vb.stormCount = 0
mod.vb.chilledCount = 0
mod.vb.tormentCount = 0
mod.vb.MachinationsLeft = 0
mod.vb.lastTormentCaster = DBM_CORE_UNKNOWN

function mod:OnCombatStart(delay)
	self.vb.stormCount = 0
	self.vb.chilledCount = 0
	self.vb.tormentCount = 0
	self.vb.MachinationsLeft = 0
	self.vb.lastTormentCaster = DBM_CORE_UNKNOWN
	if self:IsMythic() then
		self:SetCreatureID(122468, 122467, 122469, 125436)
	else
		self:SetCreatureID(122468, 122467, 122469)
	end
	--Diima, Mother of Gloom is first one to go inactive
	timerWhirlingSaberCD:Start(8-delay)
	timerFieryStrikeCD:Start(12.3-delay)
--	timerTouchofDarknessCD:Start(1-delay)
	timerShadowBladesCD:Start(12.3-delay)
	if not self:IsEasy() then
		timerFulminatingPulseCD:Start(20.9-delay)
		timerStormofDarknessCD:Start(29.6-delay)
	end
	if self.Options.NPAuraOnVisageofTitan then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
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
		voiceStormofDarkness:Play("aesoon")
		timerStormofDarknessCD:Start()--Add count when not AI timer
	elseif spellId == 253650 then
		specWarnOrbofFrost:Show()
		voicOrbofFrost:Play("161411")
		timerOrbofFrostCD:Start()
	elseif spellId == 250095 and self:AntiSpam(3, 1) then
		timerMachinationsofAman:Start()
	elseif spellId == 250648 then
		timerTouchoftheCosmosCD:Start()
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
	elseif spellId == 245532 and self:AntiSpam(3, 2) then
		timerChilledBloodCD:Start()
		voiceChilledBlood:Play("healall")
	elseif (spellId == 250335 or spellId == 250333 or spellId == 250334 or spellId == 249793) then--Torment selections
		self.vb.lastTormentCaster = args.sourceName
		self.vb.lastTormentCaster = string.split(",", self.vb.lastTormentCaster)--Strip title
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
	elseif spellId == 250757 then
		timerCosmicGlareCD:Start()
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
	elseif spellId == 245518 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			if args:IsPlayer() then--At this point the other tank SHOULD be clear.
				specWarnFlashfreeze:Show()
				voiceFlashfreeze:Play("targetyou")
				yellFlashfreeze:Yell()
			else
				specWarnFlashfreezeOther:Show(args.destName)
				voiceFlashfreeze:Play("tauntboss")
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
	elseif spellId == 250757 then
		warnCosmicGlare:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnCosmicGlare:Show()
			voiceCosmicGlare:Play("runout")
			yellCosmicGlare:Yell()
		end
	elseif spellId == 249863 then
		if self.Options.NPAuraOnVisageofTitan then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
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
	elseif spellId == 245586 then
		self.vb.chilledCount = self.vb.chilledCount - 1
		if self.Options.InfoFrame and self.vb.chilledCount == 0 then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 249863 then--Bonecage Armor
		if self.Options.NPAuraOnVisageofTitan then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
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

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:250095") then--Machinations of Aman'Thul
		self.vb.MachinationsLeft = 4
		specWarnTormentofTitans:Show()
		voiceTormentofTitans:Play("killmob")
		self.vb.tormentCount = self.vb.tormentCount + 1
		if self.vb.tormentCount % 2 == 0 then
			timerBossIncoming:Start(14, self.vb.lastTormentCaster)
		end
	elseif msg:find("spell:245671") then--Flames of Khaz'goroth
		specWarnTormentofTitans:Show()
		voiceTormentofTitans:Play("killmob")
		self.vb.tormentCount = self.vb.tormentCount + 1
		if self.vb.tormentCount % 2 == 0 then
			timerBossIncoming:Start(14, self.vb.lastTormentCaster)
		end
	elseif msg:find("spell:245910") then--Spectral Army of Norgannon
		specWarnTormentofTitans:Show()
		voiceTormentofTitans:Play("killmob")
		self.vb.tormentCount = self.vb.tormentCount + 1
		if self.vb.tormentCount % 2 == 0 then
			timerBossIncoming:Start(14, self.vb.lastTormentCaster)
		end
	elseif msg:find("spell:246763") then--Fury of Golganneth
		specWarnTormentofTitans:Show()
		voiceTormentofTitans:Play("killmob")
		self.vb.tormentCount = self.vb.tormentCount + 1
		if self.vb.tormentCount % 2 == 0 then
			timerBossIncoming:Start(14, self.vb.lastTormentCaster)
		end
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
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Engaging", 2)
			timerWhirlingSaberCD:Start(9)
			timerFieryStrikeCD:Start(12.1)
			if not self:IsEasy() then
				timerFulminatingPulseCD:Start(20.6)
			end
		else
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Leaving", 2)
			timerFieryStrikeCD:Stop()
			timerWhirlingSaberCD:Stop()
			timerFulminatingPulseCD:Stop()
		end
	elseif cid == 122467 then--Asara
		if UnitExists(uId) then
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Engaging", 2)
			--TODO, timers, never saw her leave so never saw her return
		else
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Leaving", 2)
			--timerTouchofDarknessCD:Stop()
			timerShadowBladesCD:Stop()
			timerStormofDarknessCD:Stop()
		end
	elseif cid == 122469 then--Diima
		if UnitExists(uId) then
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Engaging", 2)
			timerChilledBloodCD:Start(6.5)
			timerFlashFreezeCD:Start(12.5)
			timerOrbofFrostCD:Start(2)--AI timer for now
		else
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Leaving", 2)
			timerFlashFreezeCD:Stop()
			timerChilledBloodCD:Stop()
			timerOrbofFrostCD:Stop()
		end
	elseif cid == 125436 then--Thu'raya (mythic only)
		if UnitExists(uId) then
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Engaging", 2)
		else
			DBM:Debug("UNIT_TARGETABLE_CHANGED, Boss Leaving", 2)
			timerTouchoftheCosmosCD:Stop()
			timerCosmicGlareCD:Stop()
		end
	end
end	

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 246329 then--Shadow Blades
		specWarnShadowBlades:Show()
		voiceShadowBlades:Play("watchstep")
		timerShadowBladesCD:Start()
	end
end
--]]
