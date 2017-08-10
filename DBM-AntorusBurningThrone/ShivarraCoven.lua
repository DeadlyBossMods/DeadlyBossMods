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
	"SPELL_CAST_START 245627 245303 252861 253650 250648 250095 250335",
	"SPELL_CAST_SUCCESS 244899 253520 245586 250757",
	"SPELL_AURA_APPLIED 244899 253520 245518 245586 250757 249863",
	"SPELL_AURA_APPLIED_DOSE 244899",
	"SPELL_AURA_REMOVED 253520 245586 249863",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"--4 Coven and 1 torment
)

--TODO, whirling saber target scanning or targetting debuff?
--TODO, review tank swap stuff.
--TODO, activation and deactivation of sisters for correct timer start/stop. It's likely the one casting torture that's inactive
--TODO, auto range frame for fury of Golganneth
--TODO, figure out more about incoming adds abilities to get all warnings gooder!
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
local specWarnFieryStrike				= mod:NewSpecialWarningStack(244899, nil, 2, nil, nil, 1, 2)
local specWarnFieryStrikeOther			= mod:NewSpecialWarningTaunt(244899, nil, nil, nil, 1, 2)
local specWarnFulminatingPulse			= mod:NewSpecialWarningMoveAway(253520, nil, nil, nil, 1, 2)
local yellFulminatingPulse				= mod:NewFadesYell(253520)
--Asara, Mother of Night
local specWarnTouchofDarkness			= mod:NewSpecialWarningInterrupt(245303, "HasInterrupt", nil, nil, 1, 2)
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
local specWarnTormentofTitans			= mod:NewSpecialWarningSwitch("ej16138", "-Healer", nil, nil, 1, 2)

--Noura, Mother of Flames
local timerFieryStrikeCD				= mod:NewAITimer(25, 244899, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerWhirlingSaberCD				= mod:NewAITimer(61, 245627, nil, nil, nil, 3)
local timerFulminatingPulseCD			= mod:NewAITimer(61, 253520, nil, nil, nil, 3)
--Asara, Mother of Night
local timerTouchofDarknessCD			= mod:NewAITimer(61, 245303, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerShadowBladesCD				= mod:NewAITimer(61, 246329, nil, nil, nil, 3)
local timerStormofDarknessCD			= mod:NewAITimer(61, 252861, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
--Diima, Mother of Gloom
local timerChilledBloodCD				= mod:NewAITimer(61, 245586, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON)
local timerOrbofFrostCD					= mod:NewAITimer(61, 253650, nil, nil, nil, 3)
--Thu'raya, Mother of the Cosmos (Mythic)
local timerTouchoftheCosmosCD			= mod:NewAITimer(61, 250648, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerCosmicGlareCD				= mod:NewAITimer(61, 250757, nil, nil, nil, 3)
--Torment of the Titans
local timerTormentofTitansCD			= mod:NewAITimer(61, "ej16138", nil, nil, nil, 6)
local timerMachinationsofAman			= mod:NewCastTimer(20, 250095, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(600)

--Noura, Mother of Flames
--local countdownSingularity			= mod:NewCountdown(50, 235059)
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
local voiceTouchofDarkness				= mod:NewVoice(245303, "HasInterrupt")--kickcast
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


--mod:AddSetIconOption("SetIconOnFocusedDread", 238502, true)
mod:AddInfoFrameOption(245586, true)
--mod:AddRangeFrameOption("5/10")
mod:AddNamePlateOption("NPAuraOnVisageofTitan", 249863)

mod.vb.stormCount = 0
mod.vb.chilledCount = 0
mod.vb.tormentCount = 0

--[[
local debuffFilter
local UnitDebuff = UnitDebuff
local playerDebuff = nil
do
	local spellName = GetSpellInfo(231311)
	debuffFilter = function(uId)
		if not playerDebuff then return true end
		if not select(11, UnitDebuff(uId, spellName)) == playerDebuff then
			return true
		end
	end
end

local expelLight, stormOfJustice = GetSpellInfo(228028), GetSpellInfo(227807)
local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self.vb.brandActive then
		DBM.RangeCheck:Show(15, debuffFilter)--There are no 15 yard items that are actually 15 yard, this will round to 18 :\
	elseif UnitDebuff("player", expelLight) or UnitDebuff("player", stormOfJustice) then
		DBM.RangeCheck:Show(8)
	elseif self.vb.hornCasting then--Spread for Horn of Valor
		DBM.RangeCheck:Show(5)
	else
		DBM.RangeCheck:Hide()
	end
end
--]]

function mod:OnCombatStart(delay)
	self.vb.stormCount = 0
	self.vb.chilledCount = 0
	self.vb.tormentCount = 0
	if self:IsMythic() then
		self:SetCreatureID(122468, 122467, 122469, 125436)
	else
		self:SetCreatureID(122468, 122467, 122469)
	end
	--Diima, Mother of Gloom is first one to go inactive
	timerTormentofTitansCD:Start(1-delay)
	timerFieryStrikeCD:Start(1-delay)
	timerWhirlingSaberCD:Start(1-delay)
	timerTouchofDarknessCD:Start(1-delay)
	timerShadowBladesCD:Start(1-delay)
	if not self:IsEasy() then
		timerFulminatingPulseCD:Start(1-delay)
		timerStormofDarknessCD:Start(1-delay)
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
		timerTouchofDarknessCD:Start()
--		self.vb.pangCount = self.vb.pangCount + 1
--		if self.vb.pangCount == 4 then
--			self.vb.pangCount = 1
--		end
		if self:CheckInterruptFilter(args.sourceGUID) then
--			local kickCount = self.vb.pangCount
			specWarnTouchofDarkness:Show(args.sourceName)
			voiceTouchofDarkness:Play("kickcast")
--[[		if kickCount == 1 then
				voiceTouchofDarkness:Play("kick1r")
			elseif kickCount == 2 then
				voiceTouchofDarkness:Play("kick2r")
			elseif kickCount == 3 then
				voiceTouchofDarkness:Play("kick3r")
			end--]]
		end
	elseif spellId == 252861 then
		self.vb.stormCount = self.vb.stormCount + 1
		specWarnStormofDarkness:Show(self.vb.stormCount)
		voiceStormofDarkness:Play("aesoon")
		timerStormofDarknessCD:Start()--Add count when not AI timer
	elseif spellId == 253650 then
		specWarnOrbofFrost:Show()
		voicOrbofFrost:Play("161411")
		timerOrbofFrostCD:Start()
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
	elseif spellId == 250095 or spellId == 250335 then--Assumed move if have to use applied or channeling unit event
		if spellId == 250335 then
			timerMachinationsofAman:Start(90)--LFR?
		else
			timerMachinationsofAman:Start()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 244899 then
		timerFieryStrikeCD:Start()
	elseif spellId == 253520 then
		timerFulminatingPulseCD:Start()
	elseif spellId == 245586 then
		timerChilledBloodCD:Start()
		voiceChilledBlood:Play("healall")
	elseif (spellId == 252479 or spellId == 244756 or spellId == 244733 or spellId == 244740) and self:AntiSpam(5, spellId) then
		self.vb.tormentCount = self.vb.tormentCount + 1
		specWarnTormentofTitans:Show()
		timerTormentofTitansCD:Start()
		if self.vb.tormentCount % 2 == 0 then--Should be a sister rotation
			--Do shit
		end
		if spellId == 252479 then--Torment of Aman'Thul
	
		elseif spellId == 244756 then--Torment of Golganneth
		
		elseif spellId == 244733 then--Torment of Khaz'goroth
		
		elseif spellId == 244740 then--Torment of Norgannon
		
		end
	elseif spellId == 250757 then
		timerCosmicGlareCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 244899 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then--Lasts 30 seconds, unknown reapplication rate, fine tune!
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

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:238502") then

	end
end
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 125837 then--Torment of Amanthul
		timerMachinationsofAman:Stop()
	elseif cid == 124164 then--Torment of Golganneth
	
	elseif cid == 124166 then--Torment of Khazgoroth
	
	elseif cid == 123503 then--Torment of Norgannon

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 246329 then--Shadow Blades
		specWarnShadowBlades:Show()
		voiceShadowBlades:Play("watchstep")
		timerShadowBladesCD:Start()
	elseif (spellId == 252479 or spellId == 244756 or spellId == 244733 or spellId == 244740) and self:AntiSpam(5, spellId) then
		self.vb.tormentCount = self.vb.tormentCount + 1
		specWarnTormentofTitans:Show()
		timerTormentofTitansCD:Start()
		if self.vb.tormentCount % 2 == 0 then--Should be a sister rotation
			--Do shit
		end
		if spellId == 252479 then--Torment of Aman'Thul
	
		elseif spellId == 244756 then--Torment of Golganneth
		
		elseif spellId == 244733 then--Torment of Khaz'goroth
		
		elseif spellId == 244740 then--Torment of Norgannon
		
		end
	end
end
